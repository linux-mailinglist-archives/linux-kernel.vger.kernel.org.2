Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780131B896
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBOMBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBOMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:00:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D36EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:59:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lw17so2602073pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bn8SOxw8iQ2fUjRNRLgFjtAEW644pGxCEvahPzCBJms=;
        b=Lftvv19j8pnia7+uCBXPpSUmWp4LzrL+N1qC7csGH2rxslTmGA7Dd+eTd1xROFN893
         0tyPTEpERks1lQgV3t/nVFwi0tBwITRCvKmx+4NSyFnNAsK8HQzGkW133KL80jDsRht3
         LbhNGe3OHj/6w8/Xm0USddbTRyQdeO0iOpQlMBjkSsIhCKHtCSNUDj4TO+9cDQNGkjMr
         3xZDQru9sbfcCkNfQtmDfrujC0NLj+orJlnii487PzUA6D0q2Egfoelu6zJCeRTFVlhY
         GjU+Sbs6SRrHHw7ekaxendqEk1zAu4k95BWk95QMHcv43JjHviZ2H+clZosuy9IwUlPZ
         m6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bn8SOxw8iQ2fUjRNRLgFjtAEW644pGxCEvahPzCBJms=;
        b=P6PmFDcDkcmY2BdNbCPNogAvFSkg3h2ybcBxhpZO+f9dvHMD0sxXW1LhqqQjZ98px5
         o/uFuG8CBNDtDWDCt/gjV10udlMJshUBayPT/0xLbH0buaXAf3DjmZOAk//Jcgh6GObq
         NGNGw+pVUwbz0wE06X5e4AHDDZN+iLq7q0GsO/tmSJ/3PonPKTYogvOjZJzcD/wl3lsv
         IKRhrqdBuii2y+mJjaFTaTKJO/ZKrd3WPuZxBMzGMPA652f9zCx14lQaNGqYsmKGX9Ev
         qdsAKVbtUP4AxqvkV+zOeeD+DIwQpNKk7mf3zuc4h1iUTKSVhLHf6OaCmiwcMhyH8xl3
         E57g==
X-Gm-Message-State: AOAM530S5Ly+pst9wre1fwFZD81cKLoF63mYKXcTnKSrBBsfJJUnyfTC
        2W+885A4XQW4vMDU9n8eFvhpLw==
X-Google-Smtp-Source: ABdhPJz12Uvp3hp4uCXgO8/YpXAnFfts/Wo1n1FUqcaeAtzsuHDlWRFHZLLF6XUGoizfsd2HEKK1Gw==
X-Received: by 2002:a17:902:b213:b029:db:3a3e:d8ad with SMTP id t19-20020a170902b213b02900db3a3ed8admr15325267plr.73.1613390398991;
        Mon, 15 Feb 2021 03:59:58 -0800 (PST)
Received: from localhost ([45.137.216.90])
        by smtp.gmail.com with ESMTPSA id q2sm16731765pfu.215.2021.02.15.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 03:59:58 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf test: Suppress logs in cs-etm testing
Date:   Mon, 15 Feb 2021 19:59:43 +0800
Message-Id: <20210215115944.535986-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215115944.535986-1-leo.yan@linaro.org>
References: <20210215115944.535986-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the option '-v' for the verbose logs, "perf test" outputs tons of
logs for the CoreSight case, the logs are mainly introduced by the
decoding.  And it outputs some trivial info from "perf record" command
and there have debugging info for CPU number and device name when
iterates between ETMs and sinks.

For a neat output format, this patch redirects the output logs to
"/dev/null", thus can avoid to flood logs.  And it removes the redundant
log for CPU number and device name, which have already printed out the
relevant info in the function record_touch_file().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 21 +++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 18fde2f179cd..59b647455ec6 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -33,7 +33,7 @@ record_touch_file() {
 	echo "Recording trace (only user mode) with path: CPU$2 => $1"
 	rm -f $file
 	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
-		-- taskset -c $2 touch $file
+		-- taskset -c $2 touch $file > /dev/null 2>&1
 }
 
 perf_script_branch_samples() {
@@ -43,8 +43,8 @@ perf_script_branch_samples() {
 	#   touch  6512          1         branches:u:      ffffb220824c strcmp+0xc (/lib/aarch64-linux-gnu/ld-2.27.so)
 	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
 	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
-	perf script -F,-time -i ${perfdata} | \
-		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +"
+	perf script -F,-time -i ${perfdata} 2>&1 | \
+		egrep " +$1 +[0-9]+ .* +branches:(.*:)? +" > /dev/null 2>&1
 }
 
 perf_report_branch_samples() {
@@ -54,8 +54,8 @@ perf_report_branch_samples() {
 	#   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
 	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
 	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
-	perf report --stdio -i ${perfdata} | \
-		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 "
+	perf report --stdio -i ${perfdata} 2>&1 | \
+		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
 }
 
 perf_report_instruction_samples() {
@@ -65,8 +65,8 @@ perf_report_instruction_samples() {
 	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
 	#    5.80%  touch    libc-2.27.so   [.] getenv
 	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
-	perf report --itrace=i1000i --stdio -i ${perfdata} | \
-		egrep " +[0-9]+\.[0-9]+% +$1"
+	perf report --itrace=i1000i --stdio -i ${perfdata} 2>&1 | \
+		egrep " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1
 }
 
 is_device_sink() {
@@ -129,9 +129,6 @@ arm_cs_etm_traverse_path_test() {
 		# Find the ETM device belonging to which CPU
 		cpu=`cat $dev/cpu`
 
-		echo $dev
-		echo $cpu
-
 		# Use depth-first search (DFS) to iterate outputs
 		arm_cs_iterate_devices $dev $cpu
 	done
@@ -139,7 +136,7 @@ arm_cs_etm_traverse_path_test() {
 
 arm_cs_etm_system_wide_test() {
 	echo "Recording trace with system wide mode"
-	perf record -o ${perfdata} -e cs_etm// -a -- ls
+	perf record -o ${perfdata} -e cs_etm// -a -- ls > /dev/null 2>&1
 
 	perf_script_branch_samples perf &&
 	perf_report_branch_samples perf &&
@@ -154,7 +151,7 @@ arm_cs_etm_system_wide_test() {
 arm_cs_etm_snapshot_test() {
 	echo "Recording trace with snapshot mode"
 	perf record -o ${perfdata} -e cs_etm// -S \
-		-- dd if=/dev/zero of=/dev/null &
+		-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
 	PERFPID=$!
 
 	# Wait for perf program
-- 
2.25.1

