#!/bin/bash

LEGIT=0

while [ $LEGIT -eq 0 ]; do
	export WAT=
	export WATLANG=
	while [ ! \( "${WAT}" = "prog" -o "${WAT}" = "lib" \) ]; do
		echo -n 'make "prog" or "lib"? '
		read WAT
	done
	while [ ! \( "${WATLANG}" = "c" -o "${WATLANG}" = "cxx" \) ]; do
		echo -n 'in "c" or "cxx"? '
		read WATLANG
	done

	echo -n 'TEHCODER? '
	read TEHCODER
	echo -n 'TEHEMAIL? '
	read TEHEMAIL
	echo -n 'TEHPROGNAME? (leave away 'lib' prefix for libs) '
	read TEHPROGNAME
	echo -n 'TEHPROGDESCR? (short!) '
	read TEHPROGDESCR
	echo -n 'TEHCONTACT? (e.g. #sup on irc.fgt.net) '
	read TEHCONTACT

	echo "TEHCODER: '${TEHCODER}'"
	echo "TEHEMAIL: '${TEHEMAIL}'"
	echo "TEHPROGNAME: '${TEHPROGNAME}'"
	echo "TEHPROGDESCR: '${TEHPROGDESCR}'"
	echo "TEHCONTACT: '${TEHCONTACT}'"
	echo -n 'seems legit? y/n'

	read RESP

	if [ "$RESP" = "y" ]; then
		LEGIT=1
	elif [ "$RESP" != "n" ]; then
		echo i take it as a no.
	fi
done

TEHYEAR=$(date +%Y)
TEHDATE=$(date +%Y/%m/%d)

rm -rf dest
cp -a data/${WATLANG}${WAT} dest
find dest -type d -name '*TEHPROGNAME*' | while read LINE; do
	mv -v "${LINE}" "$(echo $LINE | sed "s/TEHPROGNAME/${TEHPROGNAME}/g")"
done
find dest -type f -name '*TEHPROGNAME*' | while read LINE; do
	mv -v "${LINE}" "$(echo $LINE | sed "s/TEHPROGNAME/${TEHPROGNAME}/g")"
done
find dest -type f -exec sed -i "s/TEHCODER/${TEHCODER}/g" {} \;
find dest -type f -exec sed -i "s/TEHEMAIL/${TEHEMAIL}/g" {} \;
find dest -type f -exec sed -i "s/TEHPROGNAME/${TEHPROGNAME}/g" {} \;
find dest -type f -exec sed -i "s/TEHPROGDESCR/${TEHPROGDESCR}/g" {} \;
find dest -type f -exec sed -i "s/TEHCONTACT/${TEHCONTACT}/g" {} \;
find dest -type f -exec sed -i "s/TEHYEAR/${TEHYEAR}/g" {} \;
find dest -type f -exec sed -i "s*TEHDATE*${TEHDATE}*g" {} \;

echo -n "your shit is ready in ./"
if [ $WAT = "lib" ]; then
	mv dest "lib${TEHPROGNAME}"
	echo -n 'lib'
else
	mv dest "${TEHPROGNAME}"
fi
echo "${TEHPROGNAME}"




