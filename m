Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5C3E1854
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbhHEPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbhHEPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF61C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:41:20 -0700 (PDT)
Message-ID: <20210805153953.391807152@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e1natWO/LXHPRnM5qXZ/LReMzOYIhDCno0JUDxBnFkU=;
        b=CJzMhwYFGCsBjvwKuE0EGCB79CeM7F3cmNTG1beo12Kt71DqLSXBq5EN0/fpoE9Gx97S19
        8M+TOY5XZ+9ICv7ia/6wFNd2mVGi4iwO6cWRaCcrfzBqRVzBtOJIL5jB+/WhXauhEtGewN
        oaZCB/O70J5caSEv/rAbRpi4Bx339YGsqeGEl8vc1PMXjuqbIHcjKVvV1Hh1ZceqenJZf0
        nhgwX2Li5wOIdJXdk5cddnuqVl05+qK9YgPT8ITKcXHKvvQbRwHKdDLAbcIz2DyZdPR1Ya
        bxprysR1WdK4X4Xr0HFin5E7lyPeiqSbvBfvHxtLlD9ZIgZTamkhmoSpjVv2gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e1natWO/LXHPRnM5qXZ/LReMzOYIhDCno0JUDxBnFkU=;
        b=Y7zoDmCf6YOKrsXttbUocBUozBr0fzfHGc2vlLX8FWDkno1Zt16iTDhPK0olKasssvSv0Y
        C3N3/rYba19BQFCQ==
Date:   Thu, 05 Aug 2021 17:13:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V3 10/64] rtmutex: Convert macros to inlines
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Inlines are typesafe...

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)
---
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,8 +141,19 @@ static __always_inline void fixup_rt_mut
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return cmpxchg_acquire(&lock->owner, old, new) == old;
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return cmpxchg_release(&lock->owner, old, new) == old;
+}
 
 /*
  * Callers must hold the ->wait_lock -- which is the whole purpose as we force
@@ -201,8 +212,20 @@ static __always_inline bool unlock_rt_mu
 }
 
 #else
-# define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
-# define rt_mutex_cmpxchg_release(l,c,n)	(0)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+}
 
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 {

