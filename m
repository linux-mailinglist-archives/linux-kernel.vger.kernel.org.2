Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE744370B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhKBUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhKBUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:14:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FBD6112E;
        Tue,  2 Nov 2021 20:11:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mi08V-001jPb-41;
        Tue, 02 Nov 2021 16:11:59 -0400
Message-ID: <20211102201158.956019455@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Nov 2021 16:11:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [for-next][PATCH 13/14] tracing/selftests: Add tests for hist trigger expression parsing
References: <20211102201126.559641540@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

Add tests for the parsing of hist trigger expressions; and to
validate expression evaluation.

Link: https://lkml.kernel.org/r/20211029183339.3216491-5-kaleshsingh@google.com

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger/trigger-hist-expressions.tc       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
new file mode 100644
index 000000000000..05ffba299dbf
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test histogram expression parsing
+# requires: set_event events/sched/sched_process_fork/trigger events/sched/sched_process_fork/hist error_log "<var1>=<field|var_ref|numeric_literal>":README
+
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+test_hist_expr() { # test_name expression expected_val
+    trigger="events/sched/sched_process_fork/trigger"
+
+    reset_trigger_file $trigger
+
+    echo "Test hist trigger expressions - $1"
+
+    echo "hist:keys=common_pid:x=$2" > $trigger
+
+    for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
+
+    actual=`grep -o 'x=[[:digit:]]*' $trigger | awk -F= '{ print $2 }'`
+
+    if [ $actual != $3 ]; then
+        fail "Failed hist trigger expression evaluation: Expression: $2 Expected: $3, Actual: $actual"
+    fi
+
+    reset_trigger_file $trigger
+}
+
+check_error() { # test_name command-with-error-pos-by-^
+    trigger="events/sched/sched_process_fork/trigger"
+
+    echo "Test hist trigger expressions - $1"
+    ftrace_errlog_check 'hist:sched:sched_process_fork' "$2" $trigger
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
+# err pos for "too many subexpressions" is dependent on where
+# the last subexpression was detected. This can vary depending
+# on how the expression tree was generated.
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=32+^10*3/20-4'
+check_error "Too many subexpressions" 'hist:keys=common_pid:x=^1+2+3+4+5'
+
+check_error "Unary minus not supported in subexpression" 'hist:keys=common_pid:x=-(^1)+2'
+
+check_error "Division by zero" 'hist:keys=common_pid:x=3/^0'
+
+exit 0
-- 
2.33.0
