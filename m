Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD1364642
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhDSOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbhDSOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:37:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC360C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:37:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j7so14967479pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=4LvAqjSakFrOOgfKv6+tGiUniPm2wmziQuekX7JD+j4=;
        b=j4CphkVNqxDIqR6t+Rul0x9nKokLhNOHjxyCymWTwtonu33mevn8VTtNydfIN5ObYy
         MCj0nap3q8/BJp9P6lcz+5Vd3hLgjg0zz+P2aoe57MO9XUwPLNpTsIN9mkPEU8z5uRBk
         5Smil0nzf03WN59GkOZznxvDsjQ5WkLSqP+4WinbnwprBVqQ2qKmiJUICW9CiJJvsiYM
         cs1LZp+M1m6vxyY65B3yh9aig6houkb8qt8WCUh2zzyTATXHrAMlCzrxHbL68LxPU3q3
         qTk1bEyYKDgbLcO4nrYYEfblymssV2NGG680Eo7RRsnWnszZRMbBMcGPFZXyHgaaczOv
         wVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=4LvAqjSakFrOOgfKv6+tGiUniPm2wmziQuekX7JD+j4=;
        b=ehfFRJfOzr9vn6HOpCNddE8quhcp4yq8vkFwvUMaTD70AUwO1A08ZAh48DO0wLfVNC
         HCZmico23Hj/HhadxdNouogpVwRqMaktAE/nwJhEdrByXWBvdbWPen0kEhIOfuv7AVjc
         tDmPbNaiGCwmi2jvXXH8HiGnoSlt1Q6yQHpvZ4BM0zx5CVvmZvCmo6axrHrVZdqeaciT
         8lyGT5XNbgD2TVl5nNpU25wxCE6Mi2TPuIH/wD73gsGxpD98GLMR5EOvHE0fCjht0fh7
         kU08yc9viajNlJJGyoP4+L9/ex17GCjpIVrSn+nEF7fOGGFsmB2nJK/HGLn2yl6xPWVC
         TbGA==
X-Gm-Message-State: AOAM532MY01gU7GzP9guU0vVdBWfvClDJJy/yN3luFQVmd7Cp/gy0oZS
        0vvubRCJRhJA0FbfjohOZxyveT9ec4Zsfw==
X-Google-Smtp-Source: ABdhPJziFY/kZShZxkgtCKcvR47d47JgWhc4/41Kl73cUeKaQDkYihP6LCPZN74zAJ3/U1KZHX6NAw==
X-Received: by 2002:a63:dc49:: with SMTP id f9mr12029986pgj.361.1618843031299;
        Mon, 19 Apr 2021 07:37:11 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id k21sm9403134pff.214.2021.04.19.07.37.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Apr 2021 07:37:10 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     adobriyan@gmail.com, bsingharora@gmail.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] delayacct: refactor the code to simplify the implementation
Date:   Mon, 19 Apr 2021 22:37:06 +0800
Message-Id: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The existing data structure is not very convenient for expansion,
and part of the code can be saved. Here, try to optimize, which
can make the code more concise and easy to expand.

delayacct_is_task_waiting_on_io() is currently only referenced by
cgroup v1, but I have submitted another patch to take out this
reference and it has been accepted. But I am not very sure when
it will merge into the main line. In order to avoid compilation
errors, here I temporarily keep delayacct_is_task_waiting_on_io(),
and I will consider deleting it according to the situation in the
future.

v2: Fix some errors prompted by the kernel test robot.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/delayacct.h | 142 ++++++++++++++++++++--------------------------
 kernel/delayacct.c        |  93 +++++++-----------------------
 2 files changed, 85 insertions(+), 150 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 2d3bdcc..c3142d9 100644
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
@@ -15,71 +18,49 @@
  * Used to set current->delays->flags
  */
 #define DELAYACCT_PF_SWAPIN	0x00000001	/* I am doing a swapin */
-#define DELAYACCT_PF_BLKIO	0x00000002	/* I am waiting on IO */
+
+static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
+{
+	return p->in_iowait;
+}
 
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
+extern int  __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk);
+extern u64  __delayacct_blkio_ticks(struct task_struct *tsk);
+extern void __delayacct_end(struct task_delay_info *delays, int item);
 
-static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
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
@@ -112,22 +93,7 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
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
@@ -141,31 +107,52 @@ static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
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
@@ -176,17 +163,14 @@ static inline void delayacct_tsk_init(struct task_struct *tsk)
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

