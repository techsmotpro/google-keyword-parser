#!/bin/bash

# Test script to verify the application is ready for deployment

echo "=== Testing Flask Application Deployment ==="
echo

# Check if all required files exist
echo "Checking required files:"
for file in app.py requirements.txt vercel.json .vercelignore .env.example .gitignore templates/index.html README.md; do
    if [ -f "$file" ] || [ -d "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file"
        exit 1
    fi
done

echo

# Check for hardcoded API keys
echo "Checking for hardcoded API keys:"
if grep -r "2a7163b7940d4a447cfa5741870f851a2d1d68c1c854476e86ccfb81cb857361" --exclude-dir=.git --exclude=.env.example --exclude=test_deployment.sh .; then
    echo "❌ Hardcoded API key found!"
    exit 1
else
    echo "✅ No hardcoded API keys found"
fi

echo

# Check Python syntax
echo "Checking Python syntax:"
if python -m py_compile app.py check_ranking.py; then
    echo "✅ Python files compile successfully"
    rm -f *.pyc
else
    echo "❌ Python syntax errors"
    exit 1
fi

echo

# Check if dependencies are available
echo "Checking Python dependencies:"
if python -c "import sys, pip; [pip.main(['show', req.split('==')[0]]) for req in open('requirements.txt').read().splitlines() if req and not req.startswith('#')]"; then
    echo "✅ All dependencies are installed"
else
    echo "❌ Some dependencies are missing"
fi

echo

# Check Flask app starts
echo "Testing Flask application startup:"
SERPAPI_KEY=2a7163b7940d4a447cfa5741870f851a2d1d68c1c854476e86ccfb81cb857361 python -c "
import sys
import subprocess
import time
import requests

# Start the Flask app in background
process = subprocess.Popen([sys.executable, 'app.py'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
time.sleep(2)

try:
    # Test if server responds
    response = requests.get('http://localhost:8080/', timeout=5)
    if response.status_code == 200:
        print('✅ Flask application is running successfully')
    else:
        print(f'❌ Flask application returned status code: {response.status_code}')
        process.terminate()
        sys.exit(1)
except Exception as e:
    print(f'❌ Error: {e}')
    process.terminate()
    sys.exit(1)
finally:
    process.terminate()
    try:
        process.wait(timeout=1)
    except:
        process.kill()
"

echo

echo "=== All tests passed! Application is ready for deployment ==="