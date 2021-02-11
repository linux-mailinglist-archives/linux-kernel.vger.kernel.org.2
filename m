Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9860F318380
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBKCNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhBKCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B02A64ECE;
        Thu, 11 Feb 2021 02:09:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QU-00BAYb-6x; Wed, 10 Feb 2021 21:09:50 -0500
Message-ID: <20210211020950.102294806@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 11/12] selftests/ftrace: Update synthetic event syntax errors
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Some of the synthetic event errors and positions have changed in the
code - update those and add several more tests.

Also add a runtime check to ensure that the kernel supports dynamic
strings in synthetic events, which these tests require.

Fixes: 81ff92a93d95 (selftests/ftrace: Add test case for synthetic
event syntax errors)

Link: https://lkml.kernel.org/r/51402656433455baead34f068c6e9466b64df9c0.1612208610.git.zanussi@kernel.org

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.29.2


