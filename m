Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF313E90B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhHKMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhHKMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:07 -0400
Message-ID: <20210811121414.732694767@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e1natWO/LXHPRnM5qXZ/LReMzOYIhDCno0JUDxBnFkU=;
        b=BPeipWXVLysJJHJtES3Z83TSpg3gT5D+NtAvw6vKu3yX1fo2rZf488wduwM0/uUrfHg5US
        YsUvYK1dwOnfOcVWYxqMzwcDV514K6vaSTi/TjF0vop6XuSlGh+1JbdxgXq6IGv3wt+tCo
        QyklIHN8AAF1B0dsftxMf3O5SC4mUhOQIoZ9ea1dphkM3ddAMkVWtN1li89epjQHXEM+6D
        LwfO/5ecwrjafpL2lEIOHoOEyr1PpZFDnG/Rb+VjgttNOmcopDrsIEpsBtVjr4Ah9ZS6rp
        mv+UTKWX49gWyJtGJpskdNjoJBQ1UInqafd2FkwZKHYTYDgqUdscBVzbtzBVIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e1natWO/LXHPRnM5qXZ/LReMzOYIhDCno0JUDxBnFkU=;
        b=LkG1bgZ1vkSx14VAjpv8cv5PyI93HUHvr0+zpbnQMMgrtWb7btMxcWI2Ew5qzMfIqBSNgy
        JONp1SOsFFBsRjAQ==
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
Subject: [patch V4 10/68] rtmutex: Convert macros to inlines
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:42 +0200 (CEST)
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

