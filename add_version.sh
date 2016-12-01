#!/bin/bash

echo "Which version would you like to add?"
read version_variable

if [ `git branch --list ${version_variable}` ]
	then
	echo "Branch named $version_variable already exists"
	exit 0

else
	echo "Branch named $version_variable does not exist"

	git fetch origin &&	git checkout -b migrate

	wget -O PrestaShop.zip https://download.prestashop.com/download/old/prestashop_$version_variable.zip && echo "Downloading files..." || echo "This version of PrestaShop ($version_variable) is not valid".

	if [ ! -f PrestaShop.zip ]
		then
		echo "File not found!"
		exit 1
	else
		echo "Creation of branch $version_variable"
		git checkout -b $version_variable

		echo "Decompression of PrestaShop.zip"
		unzip PrestaShop.zip -d PrestaShop && rm PrestaShop.zip
		unzip PrestaShop/prestashop.zip -d PrestaShopContent && rm -Rf PrestaShop

		echo "Moving Classic Theme"
		mv PrestaShopContent/themes/classic classic && rm -Rf PrestaShopContent

		echo "Adding files to git & push"
		git add classic/ && git commit -m "Add classic theme $version_variable" && git push origin $version_variable && git checkout dev

		echo "Classic Theme for $version_variable added!"
	fi

fi

exit 0
