Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2A3ECB25
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhHOV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:29:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhHOV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:25 -0400
Message-ID: <20210815211302.610830960@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e1natWO/LXHPRnM5qXZ/LReMzOYIhDCno0JUDxBnFkU=;
        b=PLKAHXvJj5SoKYONW+cZojaX9x2Dgs9BY+xJrbPMc+upafgsiKr7EqmYYGMg2azOsZ7K3u
        bnd1sSaI6dY5DSxUi/+OJjvtYdYeh9iRvH2StSav5Z48cu6jG9Z1WhF2MDUDA/4HeeVx+9
        SLOr2zb9/1z5TYwUoD653sb81ctCehIiVE69Rrtv0unmJ2HaNIy6+Hpon7PFZTA9d/ym8j
        UeRIU68kEAQM3Otc/vzjJyQph9fyqJxLdNWui3MuvhFyqAVP03CTmb5Uzy9LZgCWt/f7Nw
        zyPws/kl2fQkI1qn7NRFO7yw8G4Ec7r51nERdttGy/vSjSrYjl3K52+qs7iCrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e1natWO/LXHPRnM5qXZ/LReMzOYIhDCno0JUDxBnFkU=;
        b=iKy8mDv0iLuGQ0ZHcHVA2ocuo8uC078VFtBY4Z29gn9QTDdjTk9HR8rMNXu8BDE6hY0ZyU
        H7uABcr5MhN4czDQ==
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
Subject: [patch V5 12/72] rtmutex: Convert macros to inlines
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:54 +0200 (CEST)
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

