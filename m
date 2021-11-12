Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5780644E35D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhKLIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhKLIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:41:38 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A2C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 00:38:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n8so7877931plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 00:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THvKTAD+2ygLpLxemj7xlxNSJCoUu3plQl2okiS9kUM=;
        b=UYpKXRbBtLQVwoz2vZk9P8VPvOrO0CzaHClnda2haPmLFzUkDB6JiDoybpH4f45rpD
         Ufu5ILp5NBbwh2w7QFw/LQyKp1INvEHjsBJjvydRGkhqYB/PKWogyLOwQdecN/adyI6z
         HFeE+dGFphy2S4HpVFHsw2byfarevPvQxfzuW9N2hl5gjdMBc4Wk2CthOm7iIEtolIrU
         ydrgmPMijAa+k9ze1NhVTD/7rYx8vOH0GZk2s0VzXiymE9MUSuuGZ54N/MNo2F94+DyH
         ju5D5G4sz7aeQsbE6z7EmoOM4GfBBsfM1Mc/UAnJiwRKdbIZV5ZzzkWS8qAm5XhVYuVJ
         R9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THvKTAD+2ygLpLxemj7xlxNSJCoUu3plQl2okiS9kUM=;
        b=frDAQKW0CrZtQ7BxnMv8gR2jiYKr6sEsIn65MOu3pjooIYIPGK4DxVv65NNTgRvx3A
         OkThuIpXSKCNNYc2g8pPEiGw2DkOf6I6iBGQamfGWj4Ouvi2vnTZqmUBsAmTpxuXBVcB
         2W1gxMyOGXOBvV7N//cSkBNG80Jey/5TVZqG/hXM6D/pu2Dfus6eScIaBjmH648/bSgi
         Fbtd9J9oqQT+J4sBTDWjUkv/iY8TxbQreyeuD9SULejHlRWakgPVGEYlua64NjyNuuFs
         3r25CisC3tXoM7EmzIV8x90I4vVxOQZqV1i2eAL16VEuiIUXQO/QC23VZlxTwBIKzsiB
         W+Tg==
X-Gm-Message-State: AOAM530vtkGtC68S4TCu7XzkWfPdOt3NGoi6+n2QWpyP4kaHbQIALigb
        nNYpIQaT6PWHrTeHE8GjDyQ=
X-Google-Smtp-Source: ABdhPJwttMqMHe+SwBdmxvgraPSXuel1XIyVnfgtklPzvhkNkV/yNDejxFOr3K05M3OJd2ld+VLb4g==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr34145817pjb.142.1636706327619;
        Fri, 12 Nov 2021 00:38:47 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f5sm4425010pju.15.2021.11.12.00.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 00:38:47 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] delayacct: Support swapin delay accounting for swapping without blkio
Date:   Fri, 12 Nov 2021 08:38:14 +0000
Message-Id: <20211112083813.8559-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Currently delayacct accounts swapin delay only for swapping that cause
blkio. If we use zram for swapping, tools/accounting/getdelays can't
get any SWAP delay.

It's useful to get zram swapin delay information, for example to adjust
compress algorithm or /proc/sys/vm/swappiness.

Reference to PSI, it accounts any kind of swapping by doing it's work
in swap_readpage(), no matter whether swapping cause blkio. Let
delayacct do the similar work.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/delayacct.h | 44 +++++++++++++++++++--------------------
 kernel/delayacct.c        | 34 +++++++++++++++++-------------
 mm/memory.c               |  4 ----
 mm/page_io.c              |  3 +++
 4 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index af7e6eb50283..b96d68f310a2 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -9,14 +9,6 @@
 
 #include <uapi/linux/taskstats.h>
 
-/*
- * Per-task flags relevant to delay accounting
- * maintained privately to avoid exhausting similar flags in sched.h:PF_*
- * Used to set current->delays->flags
- */
-#define DELAYACCT_PF_SWAPIN	0x00000001	/* I am doing a swapin */
-#define DELAYACCT_PF_BLKIO	0x00000002	/* I am waiting on IO */
-
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
 	raw_spinlock_t	lock;
@@ -37,13 +29,13 @@ struct task_delay_info {
 	 * associated with the operation is added to XXX_delay.
 	 * XXX_delay contains the accumulated delay time in nanoseconds.
 	 */
-	u64 blkio_start;	/* Shared by blkio, swapin */
+	u64 blkio_start;
 	u64 blkio_delay;	/* wait for sync block io completion */
-	u64 swapin_delay;	/* wait for swapin block io completion */
+	u64 swapin_start;
+	u64 swapin_delay;	/* wait for swapin */
 	u32 blkio_count;	/* total count of the number of sync block */
 				/* io operations performed */
-	u32 swapin_count;	/* total count of the number of swapin block */
-				/* io operations performed */
+	u32 swapin_count;	/* total count of swapin */
 
 	u64 freepages_start;
 	u64 freepages_delay;	/* wait for memory reclaim */
@@ -79,14 +71,8 @@ extern void __delayacct_freepages_start(void);
 extern void __delayacct_freepages_end(void);
 extern void __delayacct_thrashing_start(void);
 extern void __delayacct_thrashing_end(void);
-
-static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
-{
-	if (p->delays)
-		return (p->delays->flags & DELAYACCT_PF_BLKIO);
-	else
-		return 0;
-}
+extern void __delayacct_swapin_start(void);
+extern void __delayacct_swapin_end(void);
 
 static inline void delayacct_set_flag(struct task_struct *p, int flag)
 {
@@ -123,7 +109,6 @@ static inline void delayacct_blkio_start(void)
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
-	delayacct_set_flag(current, DELAYACCT_PF_BLKIO);
 	if (current->delays)
 		__delayacct_blkio_start();
 }
@@ -135,7 +120,6 @@ static inline void delayacct_blkio_end(struct task_struct *p)
 
 	if (p->delays)
 		__delayacct_blkio_end(p);
-	delayacct_clear_flag(p, DELAYACCT_PF_BLKIO);
 }
 
 static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
@@ -169,6 +153,18 @@ static inline void delayacct_thrashing_end(void)
 		__delayacct_thrashing_end();
 }
 
+static inline void delayacct_swapin_start(void)
+{
+	if (current->delays)
+		__delayacct_swapin_start();
+}
+
+static inline void delayacct_swapin_end(void)
+{
+	if (current->delays)
+		__delayacct_swapin_end();
+}
+
 #else
 static inline void delayacct_set_flag(struct task_struct *p, int flag)
 {}
@@ -199,6 +195,10 @@ static inline void delayacct_thrashing_start(void)
 {}
 static inline void delayacct_thrashing_end(void)
 {}
+static inline void delayacct_swapin_start(void)
+{}
+static inline void delayacct_swapin_end(void)
+{}
 
 #endif /* CONFIG_TASK_DELAY_ACCT */
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 51530d5b15a8..11f3cd82d7e4 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -100,19 +100,10 @@ void __delayacct_blkio_start(void)
  */
 void __delayacct_blkio_end(struct task_struct *p)
 {
-	struct task_delay_info *delays = p->delays;
-	u64 *total;
-	u32 *count;
-
-	if (p->delays->flags & DELAYACCT_PF_SWAPIN) {
-		total = &delays->swapin_delay;
-		count = &delays->swapin_count;
-	} else {
-		total = &delays->blkio_delay;
-		count = &delays->blkio_count;
-	}
-
-	delayacct_end(&delays->lock, &delays->blkio_start, total, count);
+	delayacct_end(&p->delays->lock,
+		      &p->delays->blkio_start,
+		      &p->delays->blkio_delay,
+		      &p->delays->blkio_count);
 }
 
 int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
@@ -179,8 +170,7 @@ __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
-				tsk->delays->swapin_delay);
+	ret = nsec_to_clock_t(tsk->delays->blkio_delay);
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
@@ -210,3 +200,17 @@ void __delayacct_thrashing_end(void)
 		      &current->delays->thrashing_delay,
 		      &current->delays->thrashing_count);
 }
+
+void __delayacct_swapin_start(void)
+{
+	current->delays->swapin_start = local_clock();
+}
+
+void __delayacct_swapin_end(void)
+{
+	delayacct_end(&current->delays->lock,
+		      &current->delays->swapin_start,
+		      &current->delays->swapin_delay,
+		      &current->delays->swapin_count);
+}
+
diff --git a/mm/memory.c b/mm/memory.c
index 39e7a1495c3c..8379fcda2b9f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3515,7 +3515,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(!si))
 		goto out;
 
-	delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
 	page = lookup_swap_cache(entry, vma, vmf->address);
 	swapcache = page;
 
@@ -3563,7 +3562,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					vmf->address, &vmf->ptl);
 			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
-			delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 			goto unlock;
 		}
 
@@ -3577,13 +3575,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * owner processes (which may be unknown at hwpoison time)
 		 */
 		ret = VM_FAULT_HWPOISON;
-		delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 		goto out_release;
 	}
 
 	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
 
-	delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
 	if (!locked) {
 		ret |= VM_FAULT_RETRY;
 		goto out_release;
diff --git a/mm/page_io.c b/mm/page_io.c
index d597bc6e6e45..cf8549433afd 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -25,6 +25,7 @@
 #include <linux/psi.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
+#include <linux/delayacct.h>
 
 void end_swap_bio_write(struct bio *bio)
 {
@@ -372,6 +373,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * significant part of overall IO time.
 	 */
 	psi_memstall_enter(&pflags);
+	delayacct_swapin_start();
 
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
@@ -436,6 +438,7 @@ int swap_readpage(struct page *page, bool synchronous)
 
 out:
 	psi_memstall_leave(&pflags);
+	delayacct_swapin_end();
 	return ret;
 }
 
-- 
2.25.1

