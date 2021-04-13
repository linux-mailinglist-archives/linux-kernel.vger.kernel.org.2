Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC535D4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbhDMBh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243489AbhDMBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:37:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE7C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:37:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso2836939pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=X8en3VOo87dNBMi4FpIPD+GwtbAegDrQPEcD9Xian0Y=;
        b=PzDjWN6dMW9ApAeT5cBfQmOKO00FI2LMXMw5N/mJQLHS5c/bgyZARuNRkdemE+m6KJ
         i5hLXtw6CxwV8xkxuJHp0kTfV2jYijamFN9mtXJPpnTvSEQfpvjUjcNGqQejV15YKRs+
         XW+R+9d7QaQGascVABILd5HofY9Y63f3scmhGtKr8dpws6tbzr7MdmSEOQElQJZCZae4
         FNPXVHLhkJyDlQYdE1FQPiefwWTSoB7Tt6viMc/0Pzql2OQwkR0pJL/PKVVEnzOFWI6j
         FDuURsyKZCT4V4izmx16748Ju7igg+p5aQBvGTMPzeYRftMD9CmRq85MEn/urGdGC3TI
         zLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=X8en3VOo87dNBMi4FpIPD+GwtbAegDrQPEcD9Xian0Y=;
        b=R2TDXwY9MIP91nukRklyzUlSBXJOi7k4xK8/zHeoss5Cgcmf6GasOHOWtx9rmGWA23
         nUKSFtY/K8uiA+ZAv+5sAim1B188k+L/Ak/dzJFCVRyWkfa0ZlMjr8cTDLzKkJzRWSpL
         Yf8HjVaml8pRWY3T8xUuO563DB/ui63DjAVzgf6EIaWr8uk+W991RIomTsQ7xINqus54
         bTi7nzuVWUapYRq59vc4BNuv8uAVVgbst3KTvN8BrjTZ1pEPpuWAlWteykYOFXTtTYvq
         HBjFCniak8WuJ5i6BNPp72Q5/idHfNqaLokMYbvR2AeenItsejbwmqUVvz8mXBlihrlU
         TdRw==
X-Gm-Message-State: AOAM53235ubstsub70PG/+0DYOW9z3Zue+qo1YLydkj69HZFk4Y4sF3O
        zCLOFug52K3vQBCr+1qEVFhtFS/aoiY=
X-Google-Smtp-Source: ABdhPJx4Ku4TZlglOH5XQYTpw6/NM80ekHSXFqva/K5J/Vhr1+jLy/GVs6PBbSwiWwqF5GXJkw3htg==
X-Received: by 2002:a17:902:e851:b029:eb:1fd0:fa8e with SMTP id t17-20020a170902e851b02900eb1fd0fa8emr2880351plg.38.1618277851931;
        Mon, 12 Apr 2021 18:37:31 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id l1sm12593282pgt.29.2021.04.12.18.37.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 18:37:31 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     adobriyan@gmail.com, bsingharora@gmail.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] delayacct: refactor the code to simplify the implementation
Date:   Tue, 13 Apr 2021 09:37:26 +0800
Message-Id: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The existing data structure is not very convenient for
expansion, and part of the code can be saved. Here, try
to optimize, which can make the code more concise and
easy to expand.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/delayacct.h | 139 ++++++++++++++++++++--------------------------
 kernel/delayacct.c        |  93 ++++++++-----------------------
 2 files changed, 81 insertions(+), 151 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 2d3bdcc..33f6c84 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -2,12 +2,15 @@
 /* delayacct.h - per-task delay accounting
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ * Copyright (C) Chunguang Xu, Tencent Corp. 2021
  */
 
 #ifndef _LINUX_DELAYACCT_H
 #define _LINUX_DELAYACCT_H
 
 #include <uapi/linux/taskstats.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
 
 /*
  * Per-task flags relevant to delay accounting
@@ -15,71 +18,44 @@
  * Used to set current->delays->flags
  */
 #define DELAYACCT_PF_SWAPIN	0x00000001	/* I am doing a swapin */
-#define DELAYACCT_PF_BLKIO	0x00000002	/* I am waiting on IO */
 
 #ifdef CONFIG_TASK_DELAY_ACCT
+
+enum delayacct_item {
+	DELAYACCT_BLKIO,     /* block IO latency */
+	DELAYACCT_SWAPIN,    /* swapin IO latency*/
+	DELAYACCT_THRASHING, /* pagecache thrashing IO latency*/
+	DELAYACCT_FREEPAGES, /* memory reclaim latency*/
+	DELAYACCT_NR_ITEMS
+};
+
+struct delayacct_count {
+	u64 start;  /* start timestamp of XXX operation */
+	u32 count;  /* incremented on every XXX operation */
+	u64 delay;  /* accumulated delay time in nanoseconds */
+	u64 max;    /* maximum latency of XXX operation */
+};
+
 struct task_delay_info {
 	raw_spinlock_t	lock;
 	unsigned int	flags;	/* Private per-task flags */
-
-	/* For each stat XXX, add following, aligned appropriately
-	 *
-	 * struct timespec XXX_start, XXX_end;
-	 * u64 XXX_delay;
-	 * u32 XXX_count;
-	 *
-	 * Atomicity of updates to XXX_delay, XXX_count protected by
-	 * single lock above (split into XXX_lock if contention is an issue).
-	 */
-
-	/*
-	 * XXX_count is incremented on every XXX operation, the delay
-	 * associated with the operation is added to XXX_delay.
-	 * XXX_delay contains the accumulated delay time in nanoseconds.
-	 */
-	u64 blkio_start;	/* Shared by blkio, swapin */
-	u64 blkio_delay;	/* wait for sync block io completion */
-	u64 swapin_delay;	/* wait for swapin block io completion */
-	u32 blkio_count;	/* total count of the number of sync block */
-				/* io operations performed */
-	u32 swapin_count;	/* total count of the number of swapin block */
-				/* io operations performed */
-
-	u64 freepages_start;
-	u64 freepages_delay;	/* wait for memory reclaim */
-
-	u64 thrashing_start;
-	u64 thrashing_delay;	/* wait for thrashing page */
-
-	u32 freepages_count;	/* total count of memory reclaim */
-	u32 thrashing_count;	/* total count of thrash waits */
+	struct delayacct_count delays[DELAYACCT_NR_ITEMS];
 };
-#endif
-
-#include <linux/sched.h>
-#include <linux/slab.h>
 
-#ifdef CONFIG_TASK_DELAY_ACCT
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
-extern void __delayacct_tsk_exit(struct task_struct *);
-extern void __delayacct_blkio_start(void);
-extern void __delayacct_blkio_end(struct task_struct *);
-extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
-extern __u64 __delayacct_blkio_ticks(struct task_struct *);
-extern void __delayacct_freepages_start(void);
-extern void __delayacct_freepages_end(void);
-extern void __delayacct_thrashing_start(void);
-extern void __delayacct_thrashing_end(void);
-
-static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
+extern int  __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk);
+extern u64  __delayacct_blkio_ticks(struct task_struct *tsk);
+extern void __delayacct_end(struct task_delay_info *delays, int item);
+
+extern int  proc_delayacct_show(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task);
+
+static inline void __delayacct_start(struct task_delay_info *delays, int item)
 {
-	if (p->delays)
-		return (p->delays->flags & DELAYACCT_PF_BLKIO);
-	else
-		return 0;
+	delays->delays[item].start = ktime_get_ns();
 }
 
 static inline void delayacct_set_flag(int flag)
@@ -112,22 +88,7 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
 	tsk->delays = NULL;
 }
 
-static inline void delayacct_blkio_start(void)
-{
-	delayacct_set_flag(DELAYACCT_PF_BLKIO);
-	if (current->delays)
-		__delayacct_blkio_start();
-}
-
-static inline void delayacct_blkio_end(struct task_struct *p)
-{
-	if (p->delays)
-		__delayacct_blkio_end(p);
-	delayacct_clear_flag(DELAYACCT_PF_BLKIO);
-}
-
-static inline int delayacct_add_tsk(struct taskstats *d,
-					struct task_struct *tsk)
+static inline int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 {
 	if (!delayacct_on || !tsk->delays)
 		return 0;
@@ -141,31 +102,52 @@ static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 	return 0;
 }
 
+static inline void delayacct_blkio_start(void)
+{
+	if (current->delays) {
+		if (current->delays->flags & DELAYACCT_PF_SWAPIN)
+			__delayacct_start(current->delays, DELAYACCT_SWAPIN);
+		else
+			__delayacct_start(current->delays, DELAYACCT_BLKIO);
+	}
+}
+
+static inline void delayacct_blkio_end(struct task_struct *p)
+{
+	if (p->delays) {
+		if (p->delays->flags & DELAYACCT_PF_SWAPIN)
+			__delayacct_end(p->delays, DELAYACCT_SWAPIN);
+		else
+			__delayacct_end(p->delays, DELAYACCT_BLKIO);
+	}
+}
+
 static inline void delayacct_freepages_start(void)
 {
 	if (current->delays)
-		__delayacct_freepages_start();
+		__delayacct_start(current->delays, DELAYACCT_FREEPAGES);
 }
 
 static inline void delayacct_freepages_end(void)
 {
 	if (current->delays)
-		__delayacct_freepages_end();
+		__delayacct_end(current->delays, DELAYACCT_FREEPAGES);
 }
 
 static inline void delayacct_thrashing_start(void)
 {
 	if (current->delays)
-		__delayacct_thrashing_start();
+		__delayacct_start(current->delays, DELAYACCT_THRASHING);
 }
 
 static inline void delayacct_thrashing_end(void)
 {
 	if (current->delays)
-		__delayacct_thrashing_end();
+		__delayacct_end(current->delays, DELAYACCT_THRASHING);
 }
 
 #else
+
 static inline void delayacct_set_flag(int flag)
 {}
 static inline void delayacct_clear_flag(int flag)
@@ -176,17 +158,14 @@ static inline void delayacct_tsk_init(struct task_struct *tsk)
 {}
 static inline void delayacct_tsk_free(struct task_struct *tsk)
 {}
+static inline int  delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
+{ return 0; }
+static inline u64  delayacct_blkio_ticks(struct task_struct *tsk)
+{ return 0; }
 static inline void delayacct_blkio_start(void)
 {}
 static inline void delayacct_blkio_end(struct task_struct *p)
 {}
-static inline int delayacct_add_tsk(struct taskstats *d,
-					struct task_struct *tsk)
-{ return 0; }
-static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
-{ return 0; }
-static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
-{ return 0; }
 static inline void delayacct_freepages_start(void)
 {}
 static inline void delayacct_freepages_end(void)
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 27725754..ec580cb 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -2,6 +2,7 @@
 /* delayacct.c - per-task delay accounting
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ * Copyright (C) Chunguang Xu, Tencent Corp. 2021
  */
 
 #include <linux/sched.h>
@@ -42,48 +43,24 @@ void __delayacct_tsk_init(struct task_struct *tsk)
  * Finish delay accounting for a statistic using its timestamps (@start),
  * accumalator (@total) and @count
  */
-static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
-			  u32 *count)
+void __delayacct_end(struct task_delay_info *delays, int item)
 {
-	s64 ns = ktime_get_ns() - *start;
+	struct delayacct_count *delay = &delays->delays[item];
+	u64 ns = ktime_get_ns() - delay->start;
 	unsigned long flags;
 
 	if (ns > 0) {
-		raw_spin_lock_irqsave(lock, flags);
-		*total += ns;
-		(*count)++;
-		raw_spin_unlock_irqrestore(lock, flags);
+		raw_spin_lock_irqsave(&delays->lock, flags);
+		delay->max = max(delay->max, ns);
+		delay->delay += ns;
+		delay->count++;
+		raw_spin_unlock_irqrestore(&delays->lock, flags);
 	}
 }
 
-void __delayacct_blkio_start(void)
-{
-	current->delays->blkio_start = ktime_get_ns();
-}
-
-/*
- * We cannot rely on the `current` macro, as we haven't yet switched back to
- * the process being woken.
- */
-void __delayacct_blkio_end(struct task_struct *p)
-{
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
-}
-
 int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 {
+	struct delayacct_count *delays = tsk->delays->delays;
 	u64 utime, stime, stimescaled, utimescaled;
 	unsigned long long t2, t3;
 	unsigned long flags, t1;
@@ -120,58 +97,32 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
 	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
+	tmp = d->blkio_delay_total + delays[DELAYACCT_BLKIO].delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
-	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
+	tmp = d->swapin_delay_total + delays[DELAYACCT_SWAPIN].delay;
 	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
-	tmp = d->freepages_delay_total + tsk->delays->freepages_delay;
+	tmp = d->freepages_delay_total + delays[DELAYACCT_FREEPAGES].delay;
 	d->freepages_delay_total = (tmp < d->freepages_delay_total) ? 0 : tmp;
-	tmp = d->thrashing_delay_total + tsk->delays->thrashing_delay;
+	tmp = d->thrashing_delay_total + delays[DELAYACCT_THRASHING].delay;
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
-	d->blkio_count += tsk->delays->blkio_count;
-	d->swapin_count += tsk->delays->swapin_count;
-	d->freepages_count += tsk->delays->freepages_count;
-	d->thrashing_count += tsk->delays->thrashing_count;
+	d->blkio_count += delays[DELAYACCT_BLKIO].count;
+	d->swapin_count += delays[DELAYACCT_SWAPIN].count;
+	d->freepages_count += delays[DELAYACCT_FREEPAGES].count;
+	d->thrashing_count += delays[DELAYACCT_THRASHING].count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
 }
 
-__u64 __delayacct_blkio_ticks(struct task_struct *tsk)
+u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 {
-	__u64 ret;
+	u64 ret;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
-				tsk->delays->swapin_delay);
+	ret = nsec_to_clock_t(tsk->delays->delays[DELAYACCT_BLKIO].delay +
+			      tsk->delays->delays[DELAYACCT_SWAPIN].delay);
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
 
-void __delayacct_freepages_start(void)
-{
-	current->delays->freepages_start = ktime_get_ns();
-}
-
-void __delayacct_freepages_end(void)
-{
-	delayacct_end(
-		&current->delays->lock,
-		&current->delays->freepages_start,
-		&current->delays->freepages_delay,
-		&current->delays->freepages_count);
-}
-
-void __delayacct_thrashing_start(void)
-{
-	current->delays->thrashing_start = ktime_get_ns();
-}
-
-void __delayacct_thrashing_end(void)
-{
-	delayacct_end(&current->delays->lock,
-		      &current->delays->thrashing_start,
-		      &current->delays->thrashing_delay,
-		      &current->delays->thrashing_count);
-}
-- 
1.8.3.1

