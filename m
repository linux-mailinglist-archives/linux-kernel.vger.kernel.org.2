Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C6E30B0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhBATwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232739AbhBATu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:50:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949A764EC7;
        Mon,  1 Feb 2021 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612208908;
        bh=xgOBus5e/9Dm2CNFG/dmYKTPsdUbEBzhnA2rRSLxD64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=in3jzHme5Xk+Z3zZ3bKuEjxsea5X2aof5gl/3y8xCbGcMBZbevQuuEFk9hhMR2y76
         qioYcGR0lv727zfB9BW084RL261+Vl5SAaejZhXOZIfdN/wQ3MEElg5G2jaMWbZsXT
         KCXov0/fUdMdcjVZiQUQphUZAbfLf+60MtziP/WcRmQq9fEK96FHZtD/DaNE35gNFh
         va+KJWvbHTA9Z+v9SUrYY426Kbo+0+GJOyj4VeYLjAK5so2dOZnCC3bSU11BE/AtZq
         Uq2/JYMCDXE7cNU9CCk0vEKtf4JsI323hM7XOSKkG7pOW7Z7b07k4J5wAsRTSYwJh5
         s4SEKLkCrp0mA==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/6] selftests/ftrace: Update synthetic event syntax errors
Date:   Mon,  1 Feb 2021 13:48:15 -0600
Message-Id: <51402656433455baead34f068c6e9466b64df9c0.1612208610.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the synthetic event errors and positions have changed in the
code - update those and add several more tests.

Also add a runtime check to ensure that the kernel supports dynamic
strings in synthetic events, which these tests require.

Fixes: 81ff92a93d95 (selftests/ftrace: Add test case for synthetic
event syntax errors)

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger-synthetic_event_syntax_errors.tc  | 35 ++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
index ada594fe16cb..955e3ceea44b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
@@ -1,19 +1,38 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic_events syntax parser errors
-# requires: synthetic_events error_log
+# requires: synthetic_events error_log "char name[]' >> synthetic_events":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'
 }
 
+check_dyn_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'synthetic_events' "$1" 'dynamic_events'
+}
+
 check_error 'myevent ^chr arg'			# INVALID_TYPE
-check_error 'myevent ^char str[];; int v'	# INVALID_TYPE
-check_error 'myevent char ^str]; int v'		# INVALID_NAME
-check_error 'myevent char ^str;[]'		# INVALID_NAME
-check_error 'myevent ^char str[; int v'		# INVALID_TYPE
-check_error '^mye;vent char str[]'		# BAD_NAME
-check_error 'myevent char str[]; ^int'		# INVALID_FIELD
-check_error '^myevent'				# INCOMPLETE_CMD
+check_error 'myevent ^unsigned arg'		# INCOMPLETE_TYPE
+
+check_error 'myevent char ^str]; int v'		# BAD_NAME
+check_error '^mye-vent char str[]'		# BAD_NAME
+check_error 'myevent char ^st-r[]'		# BAD_NAME
+
+check_error 'myevent char str;^[]'		# INVALID_FIELD
+check_error 'myevent char str; ^int'		# INVALID_FIELD
+
+check_error 'myevent char ^str[; int v'		# INVALID_ARRAY_SPEC
+check_error 'myevent char ^str[kdjdk]'		# INVALID_ARRAY_SPEC
+check_error 'myevent char ^str[257]'		# INVALID_ARRAY_SPEC
+
+check_error '^mye;vent char str[]'		# INVALID_CMD
+check_error '^myevent ; char str[]'		# INVALID_CMD
+check_error '^myevent; char str[]'		# INVALID_CMD
+check_error '^myevent ;char str[]'		# INVALID_CMD
+check_error '^; char str[]'			# INVALID_CMD
+check_error '^;myevent char str[]'		# INVALID_CMD
+check_error '^myevent'				# INVALID_CMD
+
+check_dyn_error '^s:junk/myevent char str['	# INVALID_DYN_CMD
 
 exit 0
-- 
2.17.1

