Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8643FDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhJ2OFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231680AbhJ2OFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:05:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 962D761184;
        Fri, 29 Oct 2021 14:03:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mgSTX-001App-MC;
        Fri, 29 Oct 2021 10:03:19 -0400
Message-ID: <20211029140319.524840177@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 29 Oct 2021 10:02:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 1/2] ftrace: Fix kernel-doc formatting issues
References: <20211029140208.987338181@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Some functions had kernel-doc that used a comma instead of a hash to
separate the function name from the one line description.

Also, the "ftrace_is_dead()" had an incomplete description.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

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
-- 
2.33.0
