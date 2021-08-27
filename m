Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56D13F990D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbhH0MdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 08:33:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58492 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhH0MdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:33:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F36261FF08;
        Fri, 27 Aug 2021 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630067532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Vd+tUs6wTAUAyjisZYaUQyAL8A4GNv6GpVWaw3KUUZ8=;
        b=kdBQWhOQveSfOrwlCVe1caRuUSXuJPygt/VCXx4IEvgeUU7gulPPZmbCqWGhdjtkBjVgwY
        qFmpg7yPbh/aMrFrNoWp1Jj8YCOeaaZRbYBKXH41/GCb0JwIZP/2JvwPpa6rL2RrqwoK1I
        wABRKwy2wUjD4aCruD5xzGVTjOLWyjI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B4F0413890;
        Fri, 27 Aug 2021 12:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 0awpKkvbKGE1VAAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 27 Aug 2021 12:32:11 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] xen/balloon: use a kernel thread instead a workqueue
Date:   Fri, 27 Aug 2021 14:32:06 +0200
Message-Id: <20210827123206.15429-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today the Xen ballooning is done via delayed work in a workqueue. This
might result in workqueue hangups being reported in case of large
amounts of memory are being ballooned in one go (here 16GB):

BUG: workqueue lockup - pool cpus=6 node=0 flags=0x0 nice=0 stuck for 64s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=2/256 refcnt=3
    in-flight: 229:balloon_process
    pending: cache_reap
workqueue events_freezable_power_: flags=0x84
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: disk_events_workfn
workqueue mm_percpu_wq: flags=0x8
  pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_update
pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=64s workers=3 idle: 2222 43

This can easily be avoided by using a dedicated kernel thread for doing
the ballooning work.

Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/balloon.c | 62 +++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 671c71245a7b..2d2803883306 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -43,6 +43,8 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/errno.h>
+#include <linux/freezer.h>
+#include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
 #include <linux/pagemap.h>
@@ -115,7 +117,7 @@ static struct ctl_table xen_root[] = {
 #define EXTENT_ORDER (fls(XEN_PFN_PER_PAGE) - 1)
 
 /*
- * balloon_process() state:
+ * balloon_thread() state:
  *
  * BP_DONE: done or nothing to do,
  * BP_WAIT: wait to be rescheduled,
@@ -130,6 +132,8 @@ enum bp_state {
 	BP_ECANCELED
 };
 
+/* Main waiting point for xen-balloon thread. */
+static DECLARE_WAIT_QUEUE_HEAD(balloon_thread_wq);
 
 static DEFINE_MUTEX(balloon_mutex);
 
@@ -144,10 +148,6 @@ static xen_pfn_t frame_list[PAGE_SIZE / sizeof(xen_pfn_t)];
 static LIST_HEAD(ballooned_pages);
 static DECLARE_WAIT_QUEUE_HEAD(balloon_wq);
 
-/* Main work function, always executed in process context. */
-static void balloon_process(struct work_struct *work);
-static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
-
 /* When ballooning out (allocating memory to return to Xen) we don't really
    want the kernel to try too hard since that can trigger the oom killer. */
 #define GFP_BALLOON \
@@ -366,7 +366,7 @@ static void xen_online_page(struct page *page, unsigned int order)
 static int xen_memory_notifier(struct notifier_block *nb, unsigned long val, void *v)
 {
 	if (val == MEM_ONLINE)
-		schedule_delayed_work(&balloon_worker, 0);
+		wake_up(&balloon_thread_wq);
 
 	return NOTIFY_OK;
 }
@@ -491,18 +491,43 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
 }
 
 /*
- * As this is a work item it is guaranteed to run as a single instance only.
+ * Stop waiting if either state is not BP_EAGAIN and ballooning action is
+ * needed, or if the credit has changed while state is BP_EAGAIN.
+ */
+static bool balloon_thread_cond(enum bp_state state, long credit)
+{
+	if (state != BP_EAGAIN)
+		credit = 0;
+
+	return current_credit() != credit || kthread_should_stop();
+}
+
+/*
+ * As this is a kthread it is guaranteed to run as a single instance only.
  * We may of course race updates of the target counts (which are protected
  * by the balloon lock), or with changes to the Xen hard limit, but we will
  * recover from these in time.
  */
-static void balloon_process(struct work_struct *work)
+static int balloon_thread(void *unused)
 {
 	enum bp_state state = BP_DONE;
 	long credit;
+	unsigned long timeout;
+
+	set_freezable();
+	for (;;) {
+		if (state == BP_EAGAIN)
+			timeout = balloon_stats.schedule_delay * HZ;
+		else
+			timeout = 3600 * HZ;
+		credit = current_credit();
 
+		wait_event_interruptible_timeout(balloon_thread_wq,
+				 balloon_thread_cond(state, credit), timeout);
+
+		if (kthread_should_stop())
+			return 0;
 
-	do {
 		mutex_lock(&balloon_mutex);
 
 		credit = current_credit();
@@ -529,12 +554,7 @@ static void balloon_process(struct work_struct *work)
 		mutex_unlock(&balloon_mutex);
 
 		cond_resched();
-
-	} while (credit && state == BP_DONE);
-
-	/* Schedule more work if there is some still to be done. */
-	if (state == BP_EAGAIN)
-		schedule_delayed_work(&balloon_worker, balloon_stats.schedule_delay * HZ);
+	}
 }
 
 /* Resets the Xen limit, sets new target, and kicks off processing. */
@@ -542,7 +562,7 @@ void balloon_set_new_target(unsigned long target)
 {
 	/* No need for lock. Not read-modify-write updates. */
 	balloon_stats.target_pages = target;
-	schedule_delayed_work(&balloon_worker, 0);
+	wake_up(&balloon_thread_wq);
 }
 EXPORT_SYMBOL_GPL(balloon_set_new_target);
 
@@ -647,7 +667,7 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 
 	/* The balloon may be too large now. Shrink it if needed. */
 	if (current_credit())
-		schedule_delayed_work(&balloon_worker, 0);
+		wake_up(&balloon_thread_wq);
 
 	mutex_unlock(&balloon_mutex);
 }
@@ -679,6 +699,8 @@ static void __init balloon_add_region(unsigned long start_pfn,
 
 static int __init balloon_init(void)
 {
+	struct task_struct *task;
+
 	if (!xen_domain())
 		return -ENODEV;
 
@@ -722,6 +744,12 @@ static int __init balloon_init(void)
 	}
 #endif
 
+	task = kthread_run(balloon_thread, NULL, "xen-balloon");
+	if (IS_ERR(task)) {
+		pr_err("xen-balloon thread could not be started, ballooning will not work!\n");
+		return PTR_ERR(task);
+	}
+
 	/* Init the xen-balloon driver. */
 	xen_balloon_init();
 
-- 
2.26.2

