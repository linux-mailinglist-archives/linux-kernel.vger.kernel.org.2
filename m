Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75C43CE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbhJ0QMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242940AbhJ0QM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2707610C7;
        Wed, 27 Oct 2021 16:10:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV3-000xot-05;
        Wed, 27 Oct 2021 12:10:01 -0400
Message-ID: <20211027161000.836664471@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/15] selftests/ftrace: Stop tracing while reading the trace file by
 default
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Stop tracing while reading the trace file by default, to prevent
the test results while checking it and to avoid taking a long time
to check the result.
If there is any testcase which wants to test the tracing while reading
the trace file, please override this setting inside the test case.

This also recovers the pause-on-trace when clean it up.

Link: https://lkml.kernel.org/r/163529053143.690749.15365238954175942026.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/ftracetest       |  2 +-
 tools/testing/selftests/ftrace/test.d/functions | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 8ec1922e974e..c3311c8c4089 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -428,7 +428,7 @@ for t in $TEST_CASES; do
     exit 1
   fi
 done
-(cd $TRACING_DIR; initialize_ftrace) # for cleanup
+(cd $TRACING_DIR; finish_ftrace) # for cleanup
 
 prlog ""
 prlog "# of passed: " `echo $PASSED_CASES | wc -w`
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..5f6cbec847fc 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -124,10 +124,22 @@ initialize_ftrace() { # Reset ftrace to initial-state
     [ -f uprobe_events ] && echo > uprobe_events
     [ -f synthetic_events ] && echo > synthetic_events
     [ -f snapshot ] && echo 0 > snapshot
+
+# Stop tracing while reading the trace file by default, to prevent
+# the test results while checking it and to avoid taking a long time
+# to check the result.
+    [ -f options/pause-on-trace ] && echo 1 > options/pause-on-trace
+
     clear_trace
     enable_tracing
 }
 
+finish_ftrace() {
+    initialize_ftrace
+# And recover it to default.
+    [ -f options/pause-on-trace ] && echo 0 > options/pause-on-trace
+}
+
 check_requires() { # Check required files and tracers
     for i in "$@" ; do
         r=${i%:README}
-- 
2.33.0
