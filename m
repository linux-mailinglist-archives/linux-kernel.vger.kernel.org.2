Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215E53244D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhBXUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:01:27 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:60764 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBXUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dmj7KJqhSto9SQSwzoeqjNm2bSTw7/bJr+8g6smLj3c=; b=L3YsNqvIUEzDpmAd8w1X9nVi+2
        kFhttNkg1O65St22No4gsl/JXXtpdT4F5I1P9Yai1pYjBnC1pufNw+iHIfg7r7Icv4VRhnxd+nTsv
        03ccLUmYKagJUCWwHBFxtksyPyiPPYh5hOsOH1KQdLg2C0/QVyUHiYANwLoTeJlQsEqk=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lF0Jw-0007ef-OM; Wed, 24 Feb 2021 13:59:40 -0600
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Cc:     Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH] perf buildid-cache: Add test for PE executable
Message-ID: <790bfe67-2155-a426-7130-ae7c45cb055b@codeweavers.com>
Date:   Wed, 24 Feb 2021 14:59:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 9fd0b3889f00ad13662879767d833309d8a035b6 Mon Sep 17 00:00:00 2001
From: Nicholas Fraser <nfraser@codeweavers.com>
Date: Thu, 18 Feb 2021 13:24:03 -0500
Subject: [PATCH] perf buildid-cache: Add test for PE executable

This builds on the previous changes to tests/shell/buildid.sh, adding
tests for a PE file. It adds it to the build-id cache manually and, if
Wine is available, runs it under "perf record" and verifies that it was
added automatically.

If wine is not installed, only warnings are printed; the test can still
exit 0.

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/tests/shell/buildid.sh | 65 +++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index 416af614bbe0..f05670d1e39e 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -14,18 +14,56 @@ if ! [ -x "$(command -v cc)" ]; then
 	exit 2
 fi
 
+# check what we need to test windows binaries
+add_pe=1
+run_pe=1
+if ! perf version --build-options | grep -q 'libbfd: .* on '; then
+	echo "WARNING: perf not built with libbfd. PE binaries will not be tested."
+	add_pe=0
+	run_pe=0
+fi
+if ! which wine > /dev/null; then
+	echo "WARNING: wine not found. PE binaries will not be run."
+	run_pe=0
+fi
+
+# set up wine
+if [ ${run_pe} -eq 1 ]; then
+	wineprefix=$(mktemp -d /tmp/perf.wineprefix.XXX)
+	export WINEPREFIX=${wineprefix}
+	# clear display variables to prevent wine from popping up dialogs
+	unset DISPLAY
+	unset WAYLAND_DISPLAY
+fi
+
 ex_md5=$(mktemp /tmp/perf.ex.MD5.XXX)
 ex_sha1=$(mktemp /tmp/perf.ex.SHA1.XXX)
+ex_pe=$(dirname $0)/../pe-file.exe
 
 echo 'int main(void) { return 0; }' | cc -Wl,--build-id=sha1 -o ${ex_sha1} -x c -
 echo 'int main(void) { return 0; }' | cc -Wl,--build-id=md5 -o ${ex_md5} -x c -
 
-echo "test binaries: ${ex_sha1} ${ex_md5}"
+echo "test binaries: ${ex_sha1} ${ex_md5} ${ex_pe}"
 
 check()
 {
-	id=`readelf -n ${1} 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
-
+	case $1 in
+	*.exe)
+		# We don't have a tool that can pull a nicely formatted build-id out of
+		# a PE file, but we can extract the whole section with objcopy and
+		# format it ourselves. The .buildid section is a Debug Directory
+		# containing a CodeView entry:
+		#     https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#debug-directory-image-only
+		#     https://github.com/dotnet/runtime/blob/da94c022576a5c3bbc0e896f006565905eb137f9/docs/design/specs/PE-COFF.md
+		# The build-id starts at byte 33 and must be rearranged into a GUID.
+		id=`objcopy -O binary --only-section=.buildid $1 /dev/stdout | \
+			cut -c 33-48 | hexdump -ve '/1 "%02x"' | \
+			sed 's@^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(.*\)0a$@\4\3\2\1\6\5\8\7\9@'`
+		;;
+	*)
+		id=`readelf -n ${1} 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
+		;;
+	esac
 	echo "build id: ${id}"
 
 	link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
@@ -50,7 +88,7 @@ check()
 		exit 1
 	fi
 
-	${perf} buildid-cache -l | grep $id
+	${perf} buildid-cache -l | grep ${id}
 	if [ $? -ne 0 ]; then
 		echo "failed: ${id} is not reported by \"perf buildid-cache -l\""
 		exit 1
@@ -79,16 +117,20 @@ test_record()
 {
 	data=$(mktemp /tmp/perf.data.XXX)
 	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
+	log=$(mktemp /tmp/perf.log.XXX)
 	perf="perf --buildid-dir ${build_id_dir}"
 
-	${perf} record --buildid-all -o ${data} ${1}
+	echo "running: perf record $@"
+	${perf} record --buildid-all -o ${data} $@ &> ${log}
 	if [ $? -ne 0 ]; then
-		echo "failed: record ${1}"
+		echo "failed: record $@"
+		echo "see log: ${log}"
 		exit 1
 	fi
 
-	check ${1}
+	check ${@: -1}
 
+	rm -f ${log}
 	rm -rf ${build_id_dir}
 	rm -rf ${data}
 }
@@ -96,12 +138,21 @@ test_record()
 # add binaries manual via perf buildid-cache -a
 test_add ${ex_sha1}
 test_add ${ex_md5}
+if [ ${add_pe} -eq 1 ]; then
+	test_add ${ex_pe}
+fi
 
 # add binaries via perf record post processing
 test_record ${ex_sha1}
 test_record ${ex_md5}
+if [ ${run_pe} -eq 1 ]; then
+	test_record wine ${ex_pe}
+fi
 
 # cleanup
 rm ${ex_sha1} ${ex_md5}
+if [ ${run_pe} -eq 1 ]; then
+	rm -r ${wineprefix}
+fi
 
 exit ${err}
-- 
2.30.1


