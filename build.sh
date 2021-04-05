#!/bin/bash
cd `dirname $0`

npm install
npx npm-check-updates -u

npx cwebp -r

for js in `find public/assets/js/ -name *.js | grep -v min.`;do
	npx uglifyjs --compress --mangle -- ${js} >| ${js%%.js}.min.js
done

for css in `find public/assets/css/ -name *.css | grep -v min.`;do
	npx cleancss ${css} >| ${css%%.css}.min.css
done

# npx html-minifier public/test.html -o public/index.html

npx cld upload_dir -f tknr.com public/assets
npx cld upload_dir -f tknr.com public/images

