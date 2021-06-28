Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA693B5F69
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhF1Nw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhF1Nwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:52:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5284D61C7E;
        Mon, 28 Jun 2021 13:50:17 +0000 (UTC)
Date:   Mon, 28 Jun 2021 09:50:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: selftest/ftrace: Add test results to "-h" help text to ftracetest
Message-ID: <20210628095015.4b8b1cb9@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra recently had to debug jump labels that were failing in
the ftracetest script. He became frustrated as there was no easily
available documentation on what the meanings of UNSUPPORTED and
UNRESOLVED were. The only place they are documented is in the code.

At the very least, add the results to the help text, as I find that I
also sometimes need to figure out what those terms mean.

Now "./ftracetest -h" produces:

Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]
 Options:
		-h|--help  Show help message
		-k|--keep  Keep passed test logs
		-v|--verbose Increase verbosity of test messages
		-vv        Alias of -v -v (Show all results in stdout)
		-vvv       Alias of -v -v -v (Show all commands immediately)
		--fail-unsupported Treat UNSUPPORTED as a failure
		--fail-unresolved Treat UNRESOLVED as a failure
		-d|--debug Debug mode (trace all shell commands)
		-l|--logdir <dir> Save logs on the <dir>
		            If <dir> is -, all logs output in console only

 Test results:
	PASS		The test succeeded
	FAIL		The test failed, but was expected to succeed.
	UNRESOLVED	The test produced indeterminate results. (e.g. interrupted)
	UNTESTED	The test was not run, currently just a placeholder.
	UNSUPPORTED	The test failed because of lack of feature.
	XFAIL		The test failed, and was expected to fail.

Link: https://lore.kernel.org/lkml/YNmflj%2FWpFG5Ivmb@hirez.programming.kicks-ass.net/

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 8ec1922e974e..f34580c70650 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -21,6 +21,14 @@ echo "		--fail-unresolved Treat UNRESOLVED as a failure"
 echo "		-d|--debug Debug mode (trace all shell commands)"
 echo "		-l|--logdir <dir> Save logs on the <dir>"
 echo "		            If <dir> is -, all logs output in console only"
+echo ""
+echo " Test results:"
+echo "	PASS		The test succeeded"
+echo "	FAIL		The test failed, but was expected to succeed."
+echo "	UNRESOLVED	The test produced indeterminate results. (e.g. interrupted)"
+echo "	UNTESTED	The test was not run, currently just a placeholder."
+echo "	UNSUPPORTED	The test failed because of lack of feature."
+echo "	XFAIL		The test failed, and was expected to fail."
 exit $1
 }
 
