Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9110831B89D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBOMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBOMAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:00:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA5C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:00:02 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b145so4056287pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOvGp4jRtuE/eXG6IgZ4EP0jLdXWxQUjS4sUW+QkBBM=;
        b=F4KvXi3+He5a8coOdqSmllhCZOaPW/U1BaxMUxTRcmezcqyya++OD2qwzAObaqiU/h
         aK9K/ZwP0wowVLEtk5oNMwbIEEdy8zOGZaTJJeMLOQRjTxsga5woJdRMXVUqOIEdtaUN
         Y21Ggk3tcE1AI1xVDH9wis7qKhDp2/KCzu31s0ChbnoeoHgk1iG25gH0Q5FQn2Lk+via
         +WRScQkFoM+okaf1smo5StTNJcghPoQhfa43oMRb/evkFeJ+QQt/cfvuC2SUwfOneyyP
         JzhEteQKHtSUzXH8H5baPboFlSQ8kDe08yQn7rixzvl85bWZ5aB9I0cgfmbx5iHi/v2g
         w4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOvGp4jRtuE/eXG6IgZ4EP0jLdXWxQUjS4sUW+QkBBM=;
        b=qUQAJ5snhof2e4PJ8T4ib8Wt1S04Pj5LOt3Fg50wgOORTsafaVXojFBELELgx9yP12
         8mBYzqnNGpiIuIgbdFCoCjmQwc/GfZgAhvw1T2hH+fCWA2tSIGbmaKY6U5XGotc/DGpt
         5X7YXbJsQ0hjFocvaXH2SFnwU4honKActyqXiTIZwHbXnxpTnFvUJK4LSY4j2KRfdO+d
         KYV51It5OdOTTZ5VM/2pMzW3/hCx3W4aT+k5enHHlI4FhvXSc8h3w4tkZAuH0X80GavK
         ZTcHTPdpKUZ+jpnlqgPmaH6PXpm6bR/V4flji4FHe+Wb7rA0XKxuAHzqfkOhDtHOgd6a
         5Aqw==
X-Gm-Message-State: AOAM531PFjooR8zuua0rtCpW0PkeY1kQ4aB5+Smwd1bBEl+vKdrhcaPP
        8haEQ4UIB9YcC+Oc12HyCOjgnQ==
X-Google-Smtp-Source: ABdhPJyVsMEMR4n/+MRt01CrbfJko8ELNQB4gcY9rj0K9ocPd3i/ZSynQaCajUbypN6HF1x1g092hw==
X-Received: by 2002:a63:f709:: with SMTP id x9mr6287184pgh.287.1613390402055;
        Mon, 15 Feb 2021 04:00:02 -0800 (PST)
Received: from localhost ([45.137.216.90])
        by smtp.gmail.com with ESMTPSA id k12sm19141933pfh.123.2021.02.15.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:00:01 -0800 (PST)
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
Subject: [PATCH v1 2/2] perf test: Output the sub testing result in cs-etm
Date:   Mon, 15 Feb 2021 19:59:44 +0800
Message-Id: <20210215115944.535986-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215115944.535986-1-leo.yan@linaro.org>
References: <20210215115944.535986-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoreSight testing contains sub cases, e.g. every CPU iterates the
possible conntected sinks and tests the paths between the associated ETM
with the found sink.  Besides the per-thread testing, it also contains
system wide testing and snapshot testing.

To easier observe results for the sub cases, this patch introduces a new
function arm_cs_report(), it outputs the result as "PASS" or "FAIL" for
every sub case; and it records the error in the variable "glb_err" which
is used as the final return value when exits the testing.

Before:

  # perf test 73 -v
  73: Check Arm CoreSight trace data recording and synthesized samples:
  --- start ---
  test child forked, pid 17423
  Recording trace (only user mode) with path: CPU0 => tmc_etf0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  Recording trace (only user mode) with path: CPU0 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:

  [...]

After:

  # perf test 73 -v
  73: Check Arm CoreSight trace data recording and synthesized samples:
  --- start ---
  test child forked, pid 17423
  Recording trace (only user mode) with path: CPU0 => tmc_etf0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU0 -> tmc_etf0): PASS
  Recording trace (only user mode) with path: CPU0 => tmc_etr0
  Looking at perf.data file for dumping branch samples:
  Looking at perf.data file for reporting branch samples:
  Looking at perf.data file for instruction samples:
  CoreSight path testing (CPU0 -> tmc_etr0): PASS
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 24 ++++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 59b647455ec6..c9eef0bba6f1 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -11,6 +11,7 @@
 
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 file=$(mktemp /tmp/temporary_file.XXXXX)
+glb_err=0
 
 skip_if_no_cs_etm_event() {
 	perf list | grep -q 'cs_etm//' && return 0
@@ -69,6 +70,15 @@ perf_report_instruction_samples() {
 		egrep " +[0-9]+\.[0-9]+% +$1" > /dev/null 2>&1
 }
 
+arm_cs_report() {
+	if [ $2 != 0 ]; then
+		echo "$1: FAIL"
+		glb_err=$2
+	else
+		echo "$1: PASS"
+	fi
+}
+
 is_device_sink() {
 	# If the node of "enable_sink" is existed under the device path, this
 	# means the device is a sink device.  Need to exclude 'tpiu' since it
@@ -113,9 +123,7 @@ arm_cs_iterate_devices() {
 			perf_report_instruction_samples touch
 
 			err=$?
-
-			# Exit when find failure
-			[ $err != 0 ] && exit $err
+			arm_cs_report "CoreSight path testing (CPU$2 -> $device_name)" $err
 		fi
 
 		arm_cs_iterate_devices $dev $2
@@ -143,9 +151,7 @@ arm_cs_etm_system_wide_test() {
 	perf_report_instruction_samples perf
 
 	err=$?
-
-	# Exit when find failure
-	[ $err != 0 ] && exit $err
+	arm_cs_report "CoreSight system wide testing" $err
 }
 
 arm_cs_etm_snapshot_test() {
@@ -169,12 +175,10 @@ arm_cs_etm_snapshot_test() {
 	perf_report_instruction_samples dd
 
 	err=$?
-
-	# Exit when find failure
-	[ $err != 0 ] && exit $err
+	arm_cs_report "CoreSight snapshot testing" $err
 }
 
 arm_cs_etm_traverse_path_test
 arm_cs_etm_system_wide_test
 arm_cs_etm_snapshot_test
-exit 0
+exit $glb_err
-- 
2.25.1

