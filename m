Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A031FCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBSQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:11:41 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:37764 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhBSQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3N5FmuI7Akza+jdh6VfOjQ9znwDFUbT6JCb1EWUpxCw=; b=jtCYK7hhbaLJSWsHjHzeqes+rh
        hxTWwHbTYWST/girWycLvWDvL4QEiPJu4qp9hlBzmyrJjz2J+r9XC+Qzws9fQNWc+gvMrgYZT6grj
        SlLwZ2APePyyn3uqv/1dBPxFb+00fLONpGTkbC5IjwR+2Y6Ygh9xCw7TAMJi0n3d846k=;
Received: from [10.69.141.136]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <nfraser@codeweavers.com>)
        id 1lD8Ml-0003Ld-0i; Fri, 19 Feb 2021 10:10:51 -0600
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Cc:     Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
From:   Nicholas Fraser <nfraser@codeweavers.com>
Subject: [PATCH 2/2] perf buildid-cache: Add test for PE executable
Message-ID: <295f5380-93a1-78fa-884b-afd4319b96d7@codeweavers.com>
Date:   Fri, 19 Feb 2021 11:10:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This builds on the previous changes to tests/shell/buildid.sh, adding
tests for a PE file. It adds it to the build-id cache manually and, if
Wine is available, runs it under "perf record" and verifies that it was
added automatically.

If wine is not installed, only warnings are printed; the test can still
exit 0.

(I welcome ways to make the GUID parsing less awful. checkpatch.pl is
complaining about the line length of the sed command. The re-arranging
could be done via e.g. id=${id:6:2}{id:4:2}... since this style is
already used in the script but that turns out to be longer than the sed
command and anyway it's bash-specific. This uses a hardcoded .exe so we
could also just hardcode its GUID but I'd worry about making the tests
too inflexible.)

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
---
 tools/perf/tests/shell/buildid.sh | 43 +++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
index 416af614bbe0..55e2168ef26f 100755
--- a/tools/perf/tests/shell/buildid.sh
+++ b/tools/perf/tests/shell/buildid.sh
@@ -14,18 +14,41 @@ if ! [ -x "$(command -v cc)" ]; then
 	exit 2
 fi
 
+# check what we need to test windows binaries
+add_pe=1
+run_pe=1
+if ! perf version --build-options | grep -q 'libbfd: .* on '; then
+    echo "WARNING: perf not built with libbfd. PE binaries will not be tested."
+    add_pe=0
+    run_pe=0
+fi
+if ! which wine > /dev/null; then
+    echo "WARNING: wine not found. PE binaries will not be run."
+    run_pe=0
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
+		# the build id must be rearranged into a GUID
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
@@ -50,7 +73,7 @@ check()
 		exit 1
 	fi
 
-	${perf} buildid-cache -l | grep $id
+	${perf} buildid-cache -l | grep ${id}
 	if [ $? -ne 0 ]; then
 		echo "failed: ${id} is not reported by \"perf buildid-cache -l\""
 		exit 1
@@ -81,7 +104,7 @@ test_record()
 	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
 	perf="perf --buildid-dir ${build_id_dir}"
 
-	${perf} record --buildid-all -o ${data} ${1}
+	${perf} record --buildid-all -o ${data} ${2} ${1}
 	if [ $? -ne 0 ]; then
 		echo "failed: record ${1}"
 		exit 1
@@ -96,12 +119,22 @@ test_record()
 # add binaries manual via perf buildid-cache -a
 test_add ${ex_sha1}
 test_add ${ex_md5}
+if [ $add_pe -eq 1 ]; then
+    test_add ${ex_pe}
+fi
 
 # add binaries via perf record post processing
 test_record ${ex_sha1}
 test_record ${ex_md5}
+if [ $run_pe -eq 1 ]; then
+    test_record ${ex_pe} wine
+fi
 
 # cleanup
 rm ${ex_sha1} ${ex_md5}
 
+if [ $add_pe -eq 0 ] || [ $run_pe -eq 0 ]; then
+    echo "WARNING: some PE tests were skipped. See previous warnings."
+fi
+
 exit ${err}
-- 
2.30.1

