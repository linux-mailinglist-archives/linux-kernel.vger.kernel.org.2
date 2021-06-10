Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6853A24FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJHG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:06:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:04:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so472703pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=68pDiFNuiNAnDxPi9NXUEirmvtndBB2jkdTjxfCQjTc=;
        b=i7jGSxz1sRZzashx/SP0GekR6y/YLAECGqykgI0XppaKEkw/RYDfUhd6O91ZqQDhK1
         NjTseqHM/M7+ETYyiM0kVAxmbVVT1PJkLUzS82LkW0136G0965IQnHvdupRjPmpCpzmR
         Oj5Na6WB7wzlRkKbKiqgm+1xB2q31I+UOw3pjZLhvASU8y0NZP+qjSZvRutT975JMb/D
         vaV/Ra/lUUo7ymH0OZOfGU16ezNUpEY6QjRWFgL1o073mKK9EjKZuTmKMwCrlqLHyil2
         i/xl8hVbv30nJk/SNN5qKHB136T3TjnkVNEKp+D9wXGlJZ0M9LtBMKaN5IAvgYdkAtGy
         V/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68pDiFNuiNAnDxPi9NXUEirmvtndBB2jkdTjxfCQjTc=;
        b=EjbSMBh3dqav/0lAdtNTNhpgg8cXAtQ0tZvP5PiktQL78VGnLTsl2IVhAh9EaaF9f3
         3AsP01XiXPKY6/k9lah60oGvvqH18UJ30HCUB2C+TJpn1YhFm4/rpLVqAJ8p4LKt756D
         LG8W4fAVsJwkQnJwGXGjaxmqeziO0jDzv7nLj5r2NSIq5pH5fkBd0CVKhxIicbSQLTij
         xDQ1WEBY5olVAKGKkqOt+AepQy0HBJt4B7fVt0MVDrXOjg0To71xnZsKYYwfCQv3QQ3u
         mpfBcDlVO6HZdoxt0CQeQTcGAn27BqZI5nrL6eewb1iFiay5pKR0WSnzESdQn4XNu/f8
         8x3A==
X-Gm-Message-State: AOAM53259P00iLwl1H2EpPKyLuK/8W52IPvuTcp5suqei7jn54FTaMl7
        J4xL04dzmUQU5pXhKoDP0KI=
X-Google-Smtp-Source: ABdhPJzVYB/RWkK1efdTgrucTwD2phPUqqKAQ4n9bXgog8f4i2CBXOWIv0Q/Bu64sdmSsY/g49aerQ==
X-Received: by 2002:a17:90b:ecd:: with SMTP id gz13mr1852143pjb.107.1623308666977;
        Thu, 10 Jun 2021 00:04:26 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id k7sm6864170pjj.46.2021.06.10.00.04.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:04:26 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     bsingharora@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] delayacct: refactor the code to simplify the implementation
Date:   Thu, 10 Jun 2021 15:04:24 +0800
Message-Id: <1623308664-17589-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The existing data structure is not very convenient for
expansion, and part of the code can be saved. Here, try
to optimize, which can make the code more concise and
easy to expand.

V3: Nothing change, just port to lastest branch.
v2: Fix some errors prompted by the kernel test robot.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/delayacct.h | 123 +++++++++++++++++++---------------------------
 kernel/delayacct.c        |  88 +++++++--------------------------
 2 files changed, 68 insertions(+), 143 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 21651f9..b81a2ed 100644
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
@@ -15,71 +18,39 @@
  * Used to set current->delays->flags
  */
 #define DELAYACCT_PF_SWAPIN	0x00000001	/* I am doing a swapin */
-#define DELAYACCT_PF_BLKIO	0x00000002	/* I am waiting on IO */
 
 #ifdef CONFIG_TASK_DELAY_ACCT
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
+	struct delayacct_count items[DELAYACCT_NR_ITEMS];
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
+static inline void __delayacct_start(struct task_delay_info *delays, int item)
 {
-	if (p->delays)
-		return (p->delays->flags & DELAYACCT_PF_BLKIO);
-	else
-		return 0;
+	delays->items[item].start = ktime_get_ns();
 }
 
 static inline void delayacct_set_flag(struct task_struct *p, int flag)
@@ -112,20 +83,6 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
 	tsk->delays = NULL;
 }
 
-static inline void delayacct_blkio_start(void)
-{
-	delayacct_set_flag(current, DELAYACCT_PF_BLKIO);
-	if (current->delays)
-		__delayacct_blkio_start();
-}
-
-static inline void delayacct_blkio_end(struct task_struct *p)
-{
-	if (p->delays)
-		__delayacct_blkio_end(p);
-	delayacct_clear_flag(p, DELAYACCT_PF_BLKIO);
-}
-
 static inline int delayacct_add_tsk(struct taskstats *d,
 					struct task_struct *tsk)
 {
@@ -141,28 +98,50 @@ static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 	return 0;
 }
 
+static inline void delayacct_blkio_start(void)
+{
+	if (!current->delays)
+		return;
+
+	if (current->delays->flags & DELAYACCT_PF_SWAPIN)
+		__delayacct_start(current->delays, DELAYACCT_SWAPIN);
+	else
+		__delayacct_start(current->delays, DELAYACCT_BLKIO);
+}
+
+static inline void delayacct_blkio_end(struct task_struct *p)
+{
+	if (!p->delays)
+		return;
+
+	if (p->delays->flags & DELAYACCT_PF_SWAPIN)
+		__delayacct_end(p->delays, DELAYACCT_SWAPIN);
+	else
+		__delayacct_end(p->delays, DELAYACCT_BLKIO);
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
@@ -185,8 +164,6 @@ static inline int delayacct_add_tsk(struct taskstats *d,
 { return 0; }
 static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 { return 0; }
-static inline int delayacct_is_task_waiting_on_io(struct task_struct *p)
-{ return 0; }
 static inline void delayacct_freepages_start(void)
 {}
 static inline void delayacct_freepages_end(void)
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 27725754..f44d559 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -2,6 +2,7 @@
 /* delayacct.c - per-task delay accounting
  *
  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
+ * Copyright (C) Chunguang Xu, Tencent Corp. 2021
  */
 
 #include <linux/sched.h>
@@ -42,46 +43,20 @@ void __delayacct_tsk_init(struct task_struct *tsk)
  * Finish delay accounting for a statistic using its timestamps (@start),
  * accumalator (@total) and @count
  */
-static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
-			  u32 *count)
+void __delayacct_end(struct task_delay_info *delays, int item)
 {
-	s64 ns = ktime_get_ns() - *start;
+	struct delayacct_count *delay = &delays->items[item];
+	s64 ns = ktime_get_ns() - delay->start;
 	unsigned long flags;
 
 	if (ns > 0) {
-		raw_spin_lock_irqsave(lock, flags);
-		*total += ns;
-		(*count)++;
-		raw_spin_unlock_irqrestore(lock, flags);
+		raw_spin_lock_irqsave(&delays->lock, flags);
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
 	u64 utime, stime, stimescaled, utimescaled;
@@ -120,18 +95,18 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
 	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
+	tmp = d->blkio_delay_total + tsk->delays->items[DELAYACCT_BLKIO].delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
-	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
+	tmp = d->swapin_delay_total + tsk->delays->items[DELAYACCT_SWAPIN].delay;
 	d->swapin_delay_total = (tmp < d->swapin_delay_total) ? 0 : tmp;
-	tmp = d->freepages_delay_total + tsk->delays->freepages_delay;
+	tmp = d->freepages_delay_total + tsk->delays->items[DELAYACCT_FREEPAGES].delay;
 	d->freepages_delay_total = (tmp < d->freepages_delay_total) ? 0 : tmp;
-	tmp = d->thrashing_delay_total + tsk->delays->thrashing_delay;
+	tmp = d->thrashing_delay_total + tsk->delays->items[DELAYACCT_THRASHING].delay;
 	d->thrashing_delay_total = (tmp < d->thrashing_delay_total) ? 0 : tmp;
-	d->blkio_count += tsk->delays->blkio_count;
-	d->swapin_count += tsk->delays->swapin_count;
-	d->freepages_count += tsk->delays->freepages_count;
-	d->thrashing_count += tsk->delays->thrashing_count;
+	d->blkio_count += tsk->delays->items[DELAYACCT_BLKIO].count;
+	d->swapin_count += tsk->delays->items[DELAYACCT_SWAPIN].count;
+	d->freepages_count += tsk->delays->items[DELAYACCT_FREEPAGES].count;
+	d->thrashing_count += tsk->delays->items[DELAYACCT_THRASHING].count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
@@ -143,35 +118,8 @@ __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
-	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
-				tsk->delays->swapin_delay);
+	ret = nsec_to_clock_t(tsk->delays->items[DELAYACCT_BLKIO].delay +
+			      tsk->delays->items[DELAYACCT_SWAPIN].delay);
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
-
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

