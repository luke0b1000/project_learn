# Install python3-pip // lynx [terminal browser]
sudo apt-get install -y python3-pip lynx
# Install aws cli [https://docs.aws.amazon.com/cli/latest/userguide/installing.html] // nodeenv [https://github.com/ekalinin/nodeenv]
pip3 install awscli nodeenv
# [https://docs.aws.amazon.com/cli/latest/reference/configure/index.html]
aws configure

# Create a node virtual environment named - vnode1
~/.local/bin/nodeenv vnode1
# Activate the environment
source vnode1/bin/activate
# Confirm node and npm versions
node -v ; npm -v

# Install Express Generator[https://expressjs.com/en/starter/generator.html]
npm install express-generator  -g

express --view=nunjucks myexpressapp && cd myexpressapp
# Install [https://mozilla.github.io/nunjucks/] // [https://github.com/awslabs/aws-serverless-express] and put into package.json
npm install nunjucks aws-serverless-express --save

# Add to app.js nunjucks configuration [https://mozilla.github.io/nunjucks/getting-started.html]
# var nunjucks = require('nunjucks');
# nunjucks.configure('views', { autoescape: true,express: app });
vi app.js

# Add to index.html - create the template
# <!doctype html>
# <html>
# <head><title>{{title}}</title></head>
# <body>Welcome to {{title}} WORLD!!!</body>
# </html>
vi views/index.html

# Modify index.js to point to template
# from index to index.html
vi routes/index.js

# Install the packages in packages.json [https://docs.npmjs.com/cli/install]
npm install
# Start the package [https://docs.npmjs.com/cli/start]
npm start

lynx http://localhost:3000

# Install Serverless Frameworks [https://serverless.com/]
npm install serverless -g

# Create your lambda template with name myserverlessapp [https://serverless.com/framework/docs/providers/aws/cli-reference/create/]
sls create --template aws-nodejs --name myserverlessapp
# Rename handler.js to lambda.js
mv handler.js lambda.js

# Add to lambda.js
'use strict'
const awsServerlessExpress = require('aws-serverless-express')
const app = require('./app')
const server = awsServerlessExpress.createServer(app)
exports.myhelloworld = (event, context) => awsServerlessExpress.proxy(server, event, context)
vi lambda.js

# Add to serverless.yml
handler: lambda.myhelloworld
events:
  - http: ANY {proxy+}
  - http: ANY /
vi serverless.yml
    
# Create your AWS infrastructure
sls deploy

lynx http://lambda url
# Tear down your AWS infrastructure
sls remove
