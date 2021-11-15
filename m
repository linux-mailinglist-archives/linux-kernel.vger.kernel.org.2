Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA92451D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbhKPAbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345670AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762CC06BCEC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:21 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z6so15872100pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSU/bxyKp6FyGYKZlQ+qKRvq76tinNQyIE7V87t1vWc=;
        b=RSoOTeOk8+nU/lOvTffH2t/NjrUdgFLCBX9mYPw/F/aURDsLdqmIcD9f6s6eLRTICW
         ByuQFIrRsGR8psdlUEMBmmHdmAYttPL9Xxbatf22MUeWHAQf3yPydB91UTTD/hpaNWyu
         BLZky7bgD7/FbDydPkLXHhV1g/MFduxNELbcz0Cm8sP2QYtYtXHAfsYjys4/3IMqzZv8
         zYDaHMno0dApmDcOzOpTlsunF5Cwx732lgY+WINTciOyfSPGkP+8ktuQX/YnA8a4c9LP
         YH3g9py8JhVTSACPfW4rdi2JcjVEoz0rQfGsiRgGadf17kHpc6VkitcRiB8GH9YXcEu5
         uiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oSU/bxyKp6FyGYKZlQ+qKRvq76tinNQyIE7V87t1vWc=;
        b=tfKu0OlepWJzkbpbUk0zmS+ZyVb1rdFuP/OCDNHZFQErbWu9gS3ky8XbiGrYaMeZLn
         8gmQwJajBOFfsr+nDQIzVQFNXpDGBHVF+X9ecjMneN7j+ZBDd9CQ81dfgz3rhg3qua8F
         y+kJpFC3bSXHlJIds6lSaWULNfWp8rC+EcBAle4BZotKxL3BSUFot2BxpmVq6QXCb+pa
         9/TgGkMCMH7a5Yq39pEakRX6j/HsvVdqB27BE6z0ow2JtxJku5SbfJ7AgTpOLZFDv1ZT
         O5TMsR/CgdESdfW0QCN2uy7V842NsRwekCq6Z62aU2oJDEjGl/C5K8JhHei6vfUmETsy
         eUMw==
X-Gm-Message-State: AOAM531CbtqEFlIj3FiOkMoUtD7a465VAfUt5iw/BkU5Gpqh+a+O8och
        2IEhfgBAnMlXQQni4F6vtHM=
X-Google-Smtp-Source: ABdhPJxCRfxSUmnVJPZw0iLv/IrkJKX4mjo6ceoMEhA8QOI3WkCxC/83gtcbSMLOj8s2icx22mFWfg==
X-Received: by 2002:a63:8143:: with SMTP id t64mr730692pgd.43.1637002760989;
        Mon, 15 Nov 2021 10:59:20 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 7/9] locking/rwlocks: introduce write_lock_nested
Date:   Mon, 15 Nov 2021 10:59:07 -0800
Message-Id: <20211115185909.3949505-8-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for converting bit_spin_lock to rwlock in zsmalloc
so that multiple writers of zspages can run at the same time but
those zspages are supposed to be different zspage instance. Thus,
it's not deadlock. This patch adds write_lock_nested to support
the case for LOCKDEP.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/rwlock.h          |  6 ++++++
 include/linux/rwlock_api_smp.h  |  9 +++++++++
 include/linux/rwlock_rt.h       |  6 ++++++
 include/linux/spinlock_api_up.h |  1 +
 kernel/locking/spinlock.c       |  6 ++++++
 kernel/locking/spinlock_rt.c    | 12 ++++++++++++
 6 files changed, 40 insertions(+)

diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 2c0ad417ce3c..8f416c5e929e 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -55,6 +55,12 @@ do {								\
 #define write_lock(lock)	_raw_write_lock(lock)
 #define read_lock(lock)		_raw_read_lock(lock)
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define write_lock_nested(lock, subclass)	_raw_write_lock_nested(lock, subclass)
+#else
+#define write_lock_nested(lock, subclass)	_raw_write_lock(lock)
+#endif
+
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 
 #define read_lock_irqsave(lock, flags)			\
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index f1db6f17c4fb..f0c535ec4e65 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -17,6 +17,7 @@
 
 void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_write_lock(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)	__acquires(lock);
 void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires(lock);
 void __lockfunc _raw_write_lock_bh(rwlock_t *lock)	__acquires(lock);
 void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires(lock);
@@ -46,6 +47,7 @@ _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 
 #ifdef CONFIG_INLINE_WRITE_LOCK
 #define _raw_write_lock(lock) __raw_write_lock(lock)
+#define _raw_write_lock_nested(lock, subclass) __raw_write_lock_nested(lock, subclass)
 #endif
 
 #ifdef CONFIG_INLINE_READ_LOCK_BH
@@ -209,6 +211,13 @@ static inline void __raw_write_lock(rwlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
+static inline void __raw_write_lock_nested(rwlock_t *lock, int subclass)
+{
+	preempt_disable();
+	rwlock_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
+}
+
 #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline void __raw_write_unlock(rwlock_t *lock)
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 49c1f3842ed5..efd6da62c893 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -28,6 +28,7 @@ extern void rt_read_lock(rwlock_t *rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
 extern void rt_read_unlock(rwlock_t *rwlock);
 extern void rt_write_lock(rwlock_t *rwlock);
+extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
 extern int rt_write_trylock(rwlock_t *rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock);
 
@@ -83,6 +84,11 @@ static __always_inline void write_lock(rwlock_t *rwlock)
 	rt_write_lock(rwlock);
 }
 
+static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
+{
+	rt_write_lock_nested(rwlock, subclass);
+}
+
 static __always_inline void write_lock_bh(rwlock_t *rwlock)
 {
 	local_bh_disable();
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index d0d188861ad6..b8ba00ccccde 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -59,6 +59,7 @@
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_read_lock(lock)			__LOCK(lock)
 #define _raw_write_lock(lock)			__LOCK(lock)
+#define _raw_write_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_spin_lock_bh(lock)			__LOCK_BH(lock)
 #define _raw_read_lock_bh(lock)			__LOCK_BH(lock)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index b562f9289372..996811efa6d6 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -300,6 +300,12 @@ void __lockfunc _raw_write_lock(rwlock_t *lock)
 	__raw_write_lock(lock);
 }
 EXPORT_SYMBOL(_raw_write_lock);
+
+void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)
+{
+	__raw_write_lock_nested(lock, subclass);
+}
+EXPORT_SYMBOL(_raw_write_lock_nested);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_IRQSAVE
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index b2e553f9255b..b82d346f1e00 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -239,6 +239,18 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
+{
+	___might_sleep(__FILE__, __LINE__, 0);
+	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
+	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_write_lock_nested);
+#endif
+
 void __sched rt_read_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-- 
2.34.0.rc1.387.gb447b232ab-goog

