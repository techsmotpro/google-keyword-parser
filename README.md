# Vercel Deployment Guide

## ✅ Prerequisites

1. **Vercel Account**: Sign up for a free account at [vercel.com](https://vercel.com)
2. **Vercel CLI**: Install the Vercel CLI globally:
   ```bash
   npm install -g vercel
   ```
3. **SERPAPI Key**: You'll need a SERPAPI key (you can get one from [serpapi.com](https://serpapi.com/))

## 🚀 Deployment Steps

### 1. Login to Vercel
```bash
vercel login
```

### 2. Deploy the Application

#### Production Deployment
```bash
vercel --prod
```

#### Development Deployment (Preview)
```bash
vercel
```

### 3. Configure Environment Variables

During deployment, you'll be prompted to add environment variables. Add:

```
SERPAPI_KEY=your_serpapi_key_here
FLASK_ENV=production
```

You can also add them later in the Vercel Dashboard:
1. Go to your project in Vercel
2. Click "Settings"
3. Click "Environment Variables"
4. Add the variables

## 📁 Project Structure

```
scrapper/
├── app.py                # Main Flask application
├── requirements.txt      # Python dependencies
├── vercel.json           # Vercel configuration
├── .vercelignore         # Files to ignore during deployment
├── templates/
│   └── index.html        # Frontend template
└── README.md             # Project documentation
```

## 🎯 Key Changes Made for Vercel

1. **Environment Variables**: API key is now read from `SERPAPI_KEY` environment variable
2. **File Handling**: Excel generation uses `/tmp` directory (Vercel's writable filesystem)
3. **Direct Download**: Excel files are returned directly from the `/export-excel` endpoint
4. **Vercel Configuration**: Added `vercel.json` with Python build settings

## 📝 API Endpoints

- `GET /`: Homepage with search interface
- `POST /check-ranking`: Checks keyword rankings
- `POST /export-excel`: Exports results to Excel

## 🔧 Local Development

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
.\venv\Scripts\activate   # Windows

# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py

# Access at http://localhost:8080
```

## ⚠️ Vercel Limitations

1. **File System**: Only `/tmp` directory is writable (we've handled this)
2. **Function Duration**: Free plan has a 60-second execution limit (we've set to 300 sec in config)
3. **API Limits**: SERPAPI has rate limits - consider caching for heavy usage

## 🐛 Troubleshooting

### Common Issues

1. **API Key Errors**: Check if `SERPAPI_KEY` is correctly set in Vercel
2. **File Download Issues**: Verify the `/export-excel` endpoint returns Excel files directly
3. **Execution Timeouts**: Try reducing the number of keywords or pages searched
4. **Dependencies**: Make sure all requirements are listed in `requirements.txt`

### Checking Logs

1. Go to your Vercel project dashboard
2. Click "Deployments"
3. Select your deployment
4. Click "Logs" to see error messages

## 📈 Performance Optimizations

1. **Caching**: Implement caching for frequently searched keywords
2. **Batch Processing**: Process keywords in batches to avoid timeouts
3. **Error Handling**: Add more robust error handling for API failures
4. **CDN**: Vercel automatically caches static assets

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally
5. Deploy to Vercel preview
6. Create a pull request

## 📄 License

MIT License - feel free to use and modify this project.

## 📞 Support

For issues or questions:
1. Check the Vercel documentation: [vercel.com/docs](https://vercel.com/docs)
2. Open an issue on GitHub
3. Contact SERPAPI support for API-related questions# google-keyword-parser
