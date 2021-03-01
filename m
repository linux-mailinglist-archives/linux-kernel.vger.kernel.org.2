Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E8327E3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhCAM0S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Mar 2021 07:26:18 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:49247 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232916AbhCAM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:26:14 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385--EyhXwv5MAS-t8o7KyKhCw-1; Mon, 01 Mar 2021 07:25:18 -0500
X-MC-Unique: -EyhXwv5MAS-t8o7KyKhCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F0221020C20;
        Mon,  1 Mar 2021 12:25:16 +0000 (UTC)
Received: from krava.cust.in.nbox.cz (unknown [10.40.192.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21B905C1C4;
        Mon,  1 Mar 2021 12:25:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf daemon: Allow test for non root user
Date:   Mon,  1 Mar 2021 13:25:10 +0100
Message-Id: <20210301122510.64402-2-jolsa@kernel.org>
In-Reply-To: <20210301122510.64402-1-jolsa@kernel.org>
References: <20210301122510.64402-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John reported that the daemon test is not working for
non root user. Changing the tests configurations so
it's allowed to run under normal user.

Fixes: 2291bb915b55 ("perf tests: Add daemon 'list' command test")
Reported-by: John Garry <john.garry@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index e5b824dd08d9..5ad3ca8d681b 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -140,10 +140,10 @@ test_list()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -159,14 +159,14 @@ EOF
 	# check 1st session
 	# pid:size:-e cpu-clock:base/size:base/size/output:base/size/control:base/size/ack:0
 	local line=`perf daemon --config ${config} -x: | head -2 | tail -1`
-	check_line_other "${line}" size "-e cpu-clock" ${base}/session-size \
+	check_line_other "${line}" size "-e cpu-clock -m 1 sleep 10" ${base}/session-size \
 			 ${base}/session-size/output ${base}/session-size/control \
 			 ${base}/session-size/ack "0"
 
 	# check 2nd session
 	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
 	local line=`perf daemon --config ${config} -x: | head -3 | tail -1`
-	check_line_other "${line}" time "-e task-clock" ${base}/session-time \
+	check_line_other "${line}" time "-e task-clock -m 1 sleep 10" ${base}/session-time \
 			 ${base}/session-time/output ${base}/session-time/control \
 			 ${base}/session-time/ack "0"
 
@@ -190,10 +190,10 @@ test_reconfig()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -204,7 +204,7 @@ EOF
 	# check 2nd session
 	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
 	local line=`perf daemon --config ${config} -x: | head -3 | tail -1`
-	check_line_other "${line}" time "-e task-clock" ${base}/session-time \
+	check_line_other "${line}" time "-e task-clock -m 1 sleep 10" ${base}/session-time \
 			 ${base}/session-time/output ${base}/session-time/control ${base}/session-time/ack "0"
 	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
 
@@ -215,10 +215,10 @@ EOF
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 EOF
 
 	# TEST 1 - change config
@@ -238,7 +238,7 @@ EOF
 	# check reconfigured 2nd session
 	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
 	local line=`perf daemon --config ${config} -x: | head -3 | tail -1`
-	check_line_other "${line}" time "-e cpu-clock" ${base}/session-time \
+	check_line_other "${line}" time "-e cpu-clock -m 1 sleep 10" ${base}/session-time \
 			 ${base}/session-time/output ${base}/session-time/control ${base}/session-time/ack "0"
 
 	# TEST 2 - empty config
@@ -309,10 +309,10 @@ test_stop()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -361,7 +361,7 @@ test_signal()
 base=BASE
 
 [session-test]
-run = -e cpu-clock --switch-output
+run = -e cpu-clock --switch-output -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -400,10 +400,10 @@ test_ping()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 
 [session-time]
-run = -e task-clock
+run = -e task-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
@@ -439,7 +439,7 @@ test_lock()
 base=BASE
 
 [session-size]
-run = -e cpu-clock
+run = -e cpu-clock -m 1 sleep 10
 EOF
 
 	sed -i -e "s|BASE|${base}|" ${config}
-- 
2.29.2

