Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BCA43FE45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhJ2OSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhJ2OSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:18:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E4461175;
        Fri, 29 Oct 2021 14:15:52 +0000 (UTC)
Date:   Fri, 29 Oct 2021 10:15:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fixes to comments
Message-ID: <20211029101550.2bde4593@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

Tracing comment fixes:

- Some bots have informed me that some of the ftrace functions kernel-doc
  has formatting issues.

- Also, fix my snake instinct.


Please pull the latest trace-v5.15-rc6-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.15-rc6-3

Tag SHA1: aaf3082d8a5af584655e04b618b39677e57f29b0
Head SHA1: ddcf906fe5ed842034b2d995064c1de1dcc7e812


Steven Rostedt (VMware) (2):
      ftrace: Fix kernel-doc formatting issues
      tracing: Fix misspelling of "missing"

----
 kernel/trace/ftrace.c       | 18 ++++++++++--------
 kernel/trace/trace_eprobe.c |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 635fbdc9d589..feebf57c6458 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2208,7 +2208,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 }
 
 /**
- * ftrace_update_record, set a record that now is tracing or not
+ * ftrace_update_record - set a record that now is tracing or not
  * @rec: the record to update
  * @enable: set to true if the record is tracing, false to force disable
  *
@@ -2221,7 +2221,7 @@ int ftrace_update_record(struct dyn_ftrace *rec, bool enable)
 }
 
 /**
- * ftrace_test_record, check if the record has been enabled or not
+ * ftrace_test_record - check if the record has been enabled or not
  * @rec: the record to test
  * @enable: set to true to check if enabled, false if it is disabled
  *
@@ -2574,7 +2574,7 @@ struct ftrace_rec_iter {
 };
 
 /**
- * ftrace_rec_iter_start, start up iterating over traced functions
+ * ftrace_rec_iter_start - start up iterating over traced functions
  *
  * Returns an iterator handle that is used to iterate over all
  * the records that represent address locations where functions
@@ -2605,7 +2605,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_start(void)
 }
 
 /**
- * ftrace_rec_iter_next, get the next record to process.
+ * ftrace_rec_iter_next - get the next record to process.
  * @iter: The handle to the iterator.
  *
  * Returns the next iterator after the given iterator @iter.
@@ -2630,7 +2630,7 @@ struct ftrace_rec_iter *ftrace_rec_iter_next(struct ftrace_rec_iter *iter)
 }
 
 /**
- * ftrace_rec_iter_record, get the record at the iterator location
+ * ftrace_rec_iter_record - get the record at the iterator location
  * @iter: The current iterator location
  *
  * Returns the record that the current @iter is at.
@@ -2733,7 +2733,7 @@ static int __ftrace_modify_code(void *data)
 }
 
 /**
- * ftrace_run_stop_machine, go back to the stop machine method
+ * ftrace_run_stop_machine - go back to the stop machine method
  * @command: The command to tell ftrace what to do
  *
  * If an arch needs to fall back to the stop machine method, the
@@ -2745,7 +2745,7 @@ void ftrace_run_stop_machine(int command)
 }
 
 /**
- * arch_ftrace_update_code, modify the code to trace or not trace
+ * arch_ftrace_update_code - modify the code to trace or not trace
  * @command: The command that needs to be done
  *
  * Archs can override this function if it does not need to
@@ -7525,7 +7525,9 @@ void ftrace_kill(void)
 }
 
 /**
- * Test if ftrace is dead or not.
+ * ftrace_is_dead - Test if ftrace is dead or not.
+ *
+ * Returns 1 if ftrace is "dead", zero otherwise.
  */
 int ftrace_is_dead(void)
 {
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5c5f208c15d3..928867f527e7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -904,7 +904,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
-		/* This must return -ENOMEM or misssing event, else there is a bug */
+		/* This must return -ENOMEM or missing event, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM && ret != -ENODEV);
 		ep = NULL;
 		goto error;
