Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F58437F97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhJVUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234425AbhJVUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48FE613A7;
        Fri, 22 Oct 2021 20:48:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T1-000QSR-Sa;
        Fri, 22 Oct 2021 16:48:43 -0400
Message-ID: <20211022204843.717752020@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [for-next][PATCH 30/40] ftrace/direct: Do not disable when switching direct callers
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently to switch a set of "multi" direct trampolines from one
trampoline to another, a full shutdown of the current set needs to be
done, followed by an update to what trampoline the direct callers would
call, and then re-enabling the callers. This leaves a time when the
functions will not be calling anything, and events may be missed.

Instead, use a trick to allow all the functions with direct trampolines
attached will always call either the new or old trampoline while the
switch is happening. To do this, first attach a "dummy" callback via
ftrace to all the functions that the current direct trampoline is attached
to. This will cause the functions to call the "list func" instead of the
direct trampoline. The list function will call the direct trampoline
"helper" that will set the function it should call as it returns back to
the ftrace trampoline.

At this moment, the direct caller descriptor can safely update the direct
call trampoline. The list function will pick either the new or old
function (depending on the memory coherency model of the architecture).

Now removing the dummy function from each of the locations of the direct
trampoline caller, will put back the direct call, but now to the new
trampoline.

A better visual is:

[ Changing direct call from my_direct_1 to my_direct_2 ]

  <traced_func>:
     call my_direct_1

 ||||||||||||||||||||
 vvvvvvvvvvvvvvvvvvvv

  <traced_func>:
     call ftrace_caller

  <ftrace_caller>:
    [..]
    call ftrace_ops_list_func

	ftrace_ops_list_func()
	{
		ops->func() -> direct_helper -> set rax to my_direct_1 or my_direct_2
	}

   call rax (to either my_direct_1 or my_direct_2

 ||||||||||||||||||||
 vvvvvvvvvvvvvvvvvvvv

  <traced_func>:
     call my_direct_2

Link: https://lore.kernel.org/all/20211014162819.5c85618b@gandalf.local.home/

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30120342176e..f90ed00a6d5b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5561,8 +5561,12 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
  */
 int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_hash *hash;
 	struct ftrace_func_entry *entry, *iter;
+	static struct ftrace_ops tmp_ops = {
+		.func		= ftrace_stub,
+		.flags		= FTRACE_OPS_FL_STUB,
+	};
 	int i, size;
 	int err;
 
@@ -5572,21 +5576,22 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
-	mutex_lock(&ftrace_lock);
+
+	/* Enable the tmp_ops to have the same functions as the direct ops */
+	ftrace_ops_init(&tmp_ops);
+	tmp_ops.func_hash = ops->func_hash;
+
+	err = register_ftrace_function(&tmp_ops);
+	if (err)
+		goto out_direct;
 
 	/*
-	 * Shutdown the ops, change 'direct' pointer for each
-	 * ops entry in direct_functions hash and startup the
-	 * ops back again.
-	 *
-	 * Note there is no callback called for @ops object after
-	 * this ftrace_shutdown call until ftrace_startup is called
-	 * later on.
+	 * Now the ftrace_ops_list_func() is called to do the direct callers.
+	 * We can safely change the direct functions attached to each entry.
 	 */
-	err = ftrace_shutdown(ops, 0);
-	if (err)
-		goto out_unlock;
+	mutex_lock(&ftrace_lock);
 
+	hash = ops->func_hash->filter_hash;
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
@@ -5597,10 +5602,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
-	err = ftrace_startup(ops, 0);
+	/* Removing the tmp_ops will add the updated direct callers to the functions */
+	unregister_ftrace_function(&tmp_ops);
 
- out_unlock:
 	mutex_unlock(&ftrace_lock);
+ out_direct:
 	mutex_unlock(&direct_mutex);
 	return err;
 }
-- 
2.33.0
