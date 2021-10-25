Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEF43A3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhJYUGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbhJYUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:04:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782F2C036D67
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:25:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w8-20020a170902a70800b0013ffaf12fbaso4175666plq.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=0X4ZzEWqQCI4S+9dMmdUBiiRunDNYVnUP5vvvMfRtDs=;
        b=bi59lsDZVQms20hwFrTJJM3A/hTBiNa7tq1pLsKiZNL6niHp8iT9X1jIprUqUp56p4
         kaEdhbjPBAuGwiry1ymNlKFWkZP2Cp9AayRKUjjLVHK8hevBvbkMlMJT/4cEzSnsIIs8
         uPmcHafy1IQXWqKXBrB8w9AZwKdiTrh4Ff0H9vjxkWqAI0qOYF8giDkLgh+s+ZozRO3B
         wyecMadGlWFxZ26lpG2oAhPZPc/ooNC2pOHiaShcSLTCC2g5clVah9MT1LDQ7trjUMrP
         F+I7gI3hUD1FBJIeCpmMiXv5Lq2ON1AkLjfH4qZYlZhmYlbtyBu6ylJkRXCUOs9DAWcO
         NlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=0X4ZzEWqQCI4S+9dMmdUBiiRunDNYVnUP5vvvMfRtDs=;
        b=wqe56Q0UwD/mvnI018fpOkM4bUf/Im5ix2pU/XCnHqiUyf+l0nxuQlnRzg6N4HiXx1
         pcr0qhy4wD5xUrsY3Iw98LIWs8fsZnvdMWGUL5RWmf6uuDUi4FSfsGjOEvYih+C2oqHe
         weEIMeoNSU67+4Yj3km9D1WF2XSHQb0FaXck1r5BqOsjf1OFnNe+iU/h6gIwu29eSr+5
         bf2AtjeIGoe4lLwjA8znYPG7LnBhrOd850d1g+uZFf7AyAqUA4NqgkTY7ZCb/vivsqZV
         qtwKwAT58cHHJunLRGwO+zbX8Z+oJ7cFcNgtLiuKtlRK6lSeif40E9t27QYqRHgSK78D
         limQ==
X-Gm-Message-State: AOAM531Htl6vCaCvr/Vl6M+53R08fItLChMDNAuatT/Fdtc6cJrEoito
        Wq0apoAZIAuXtl9k9Pp4R2PQcQJom5omirEtpA==
X-Google-Smtp-Source: ABdhPJzXXPfI/4dfShXeTCziC9Z90/UVK1Pqw4rSjtJJCZfTyDZT4yuAF4sUhZ1BdorC8BCekgQgTIrfpmbx+Kceog==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a17:90b:3ecc:: with SMTP id
 rm12mr23043839pjb.48.1635189947934; Mon, 25 Oct 2021 12:25:47 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:23:18 -0700
In-Reply-To: <20211025192330.2992076-1-kaleshsingh@google.com>
Message-Id: <20211025192330.2992076-8-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025192330.2992076-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 7/8] tracing/selftests: Add tests for hist trigger
 expression parsing
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for the parsing of hist trigger expressions; and to
validate expression evaluation.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Change-Id: Id3871697eb2d7537c8185494f5c1d347077798bc
---

Changes in v3:
  - Remove .sym-offset error check tests

Changes in v2:
  - Add Namhyung's Reviewed-by
  - Update comment to clarify err_pos in "Too many subexpressions" test


 .../testing/selftests/ftrace/test.d/functions |  4 +-
 .../trigger/trigger-hist-expressions.tc       | 72 +++++++++++++++++++
 2 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..1855a63559ad 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -16,13 +16,13 @@ reset_tracer() { # reset the current tracer
 
 reset_trigger_file() {
     # remove action triggers first
-    grep -H ':on[^:]*(' $@ |
+    grep -H ':on[^:]*(' $@ | tac |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
-    grep -Hv ^# $@ |
+    grep -Hv ^# $@ | tac |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
 	file=`echo $line | cut -f1 -d:`
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
new file mode 100644
index 000000000000..e715641c54d3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test histogram expression parsing
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log
+
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+get_hist_var() { #var_name hist_path
+    hist_output=`grep -m1 "$1: " $2`
+    hitcount=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "hitcount:") print $(i+1)} }'`
+    var_sum=`echo $hist_output | awk '{ for (i=1; i<=NF; ++i) { if ($i ~ "'$1':") print $(i+1)} }'`
+    var_val=$(( var_sum / hitcount ))
+    echo $var_val
+}
+
+test_hist_expr() { # test_name expression expected_val
+    reset_trigger
+
+    echo "Test hist trigger expressions - $1"
+
+    echo "hist:keys=common_pid:x=$2" > events/sched/sched_process_fork/trigger
+    echo 'hist:keys=common_pid:vals=$x' >> events/sched/sched_process_fork/trigger
+    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+
+    actual=`get_hist_var x events/sched/sched_process_fork/hist`
+
+    if [ $actual != $3 ]; then
+        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
+    fi
+
+    reset_trigger
+}
+
+check_error() { # test_name command-with-error-pos-by-^
+    reset_trigger
+
+    echo "Test hist trigger expressions - $1"
+    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" 'events/sched/sched_process_fork/trigger'
+
+    reset_trigger
+}
+
+test_hist_expr "Variable assignment" "123" "123"
+
+test_hist_expr "Subtraction not associative" "16-8-4-2" "2"
+
+test_hist_expr "Division not associative" "64/8/4/2" "1"
+
+test_hist_expr "Same precedence operators (+,-) evaluated left to right" "16-8+4+2" "14"
+
+test_hist_expr "Same precedence operators (*,/) evaluated left to right" "4*3/2*2" "12"
+
+test_hist_expr "Multiplication evaluated before addition/subtraction" "4+3*2-2" "8"
+
+test_hist_expr "Division evaluated before addition/subtraction" "4+6/2-2" "5"
+
+# Division by zero returns -1
+test_hist_expr "Handles division by zero" "3/0" "-1"
+
+# err pos for "too many subexpressions" is dependent on where
+# the last subexpression was detected. This can vary depending
+# on how the expression tree was generated.
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=32+^10*3/20-4'
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=^1+2+3+4+5'
+
+check_error "Unary minus not supported in subexpression" 'hist:keys=common_pid:x=-(^1)+2'
+
+exit 0
-- 
2.33.0.1079.g6e70778dc9-goog

