Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC03A2D18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFJNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:33:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55208 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFJNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:33:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 578671FD47;
        Thu, 10 Jun 2021 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623331866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGKyYQMrbAeahE3xhD9fI3AH7oTEeG1ybITAWUSu00U=;
        b=KlDFzc8qD5bNU3U//9KTxSniwH7y6WvcXUUQr7/S2TapRpo4putFwtesWGLgasZOnWEk5W
        fbcY0BdkxKDVgfT5FiUwSqUlr9iER53FLlaeEQen/2x30TpbTC/otyxY6/qlxCXQQxxQiv
        bVjLEvK+bU59Xbsx68gi9aU+CciyjKs=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 1C3F1A3B92;
        Thu, 10 Jun 2021 13:31:06 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Martin Liu <liumartin@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tejun Heo <tj@kernel.org>, minchan@google.com,
        davidchao@google.com, jenhaochen@google.com,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] kthread_worker: Fix return value when kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()
Date:   Thu, 10 Jun 2021 15:30:51 +0200
Message-Id: <20210610133051.15337-4-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210610133051.15337-1-pmladek@suse.com>
References: <20210610133051.15337-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kthread_mod_delayed_work() might race with
kthread_cancel_delayed_work_sync() or another kthread_mod_delayed_work()
call. The function lets the other operation win when it sees
work->canceling counter set. And it returns @false.

But it should return @true as it is done by the related workqueue API,
see mod_delayed_work_on().

The reason is that the return value might be used for reference counting.
It has to distinguish the case when the number of queued works has changed
or stayed the same.

The change is safe. kthread_mod_delayed_work() return value is not checked
anywhere at the moment.

Link: https://lore.kernel.org/r/20210521163526.GA17916@redhat.com
Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kthread.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 0fccf7d0c6a1..86ae5f2e6db8 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1156,14 +1156,14 @@ static bool __kthread_cancel_work(struct kthread_work *work)
  * modify @dwork's timer so that it expires after @delay. If @delay is zero,
  * @work is guaranteed to be queued immediately.
  *
- * Return: %true if @dwork was pending and its timer was modified,
- * %false otherwise.
+ * Return: %false if @dwork was idle and queued, %true otherwise.
  *
  * A special case is when the work is being canceled in parallel.
  * It might be caused either by the real kthread_cancel_delayed_work_sync()
  * or yet another kthread_mod_delayed_work() call. We let the other command
- * win and return %false here. The caller is supposed to synchronize these
- * operations a reasonable way.
+ * win and return %true here. The return value can be used for reference
+ * counting and the number of queued works stays the same. Anyway, the caller
+ * is supposed to synchronize these operations a reasonable way.
  *
  * This function is safe to call from any context including IRQ handler.
  * See __kthread_cancel_work() and kthread_delayed_work_timer_fn()
@@ -1175,13 +1175,15 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 {
 	struct kthread_work *work = &dwork->work;
 	unsigned long flags;
-	int ret = false;
+	int ret;
 
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
-	if (!work->worker)
+	if (!work->worker) {
+		ret = false;
 		goto fast_queue;
+	}
 
 	/* Work must not be used with >1 worker, see kthread_queue_work() */
 	WARN_ON_ONCE(work->worker != worker);
@@ -1199,8 +1201,11 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	 * be used for reference counting.
 	 */
 	kthread_cancel_delayed_work_timer(work, &flags);
-	if (work->canceling)
+	if (work->canceling) {
+		/* The number of works in the queue does not change. */
+		ret = true;
 		goto out;
+	}
 	ret = __kthread_cancel_work(work);
 
 fast_queue:
-- 
2.26.2

