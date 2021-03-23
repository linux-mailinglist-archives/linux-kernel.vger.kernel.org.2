Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54778346B48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhCWVlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhCWVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D258C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:39:52 -0700 (PDT)
Message-Id: <20210323213708.400351704@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6rZKFRfc2POSEtJ6HeNKCxqt6gk5ai8upmYP90iivys=;
        b=MmRXFJwvZlX9JFd0IKuqdsgvGr5S+0z784zbzslL9eEXEUZDXFY3jpE8JfukTbwDyo9vlO
        V20E/OD+WcLT3PWm6Az3CFmlEp5s0vT6DjupaX1H9mg/LXWlPRF/QpggRpoT6QVe8ZjAQx
        sOA6Ex2AeaRmRzFtI5uuOrg+VfsFpZnkRANJKORyFohee4hQGdoQgU42927ZT0p7Qwnc6V
        YTiQdpNu4YnmWFEsKdTkT4jzMPgnm3J+DoRUbK8DFqHuy96xhM6biiBJOc9kMG8BrjFYQm
        HAzHgxPmJM8zHL5L0zyEOThLV6y+PLSxHFqfT8gaRaOocOreprCxT7pjYG86Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6rZKFRfc2POSEtJ6HeNKCxqt6gk5ai8upmYP90iivys=;
        b=Ioc5Qlj+kdtYUvC/baftLkxubb7mRGwlw8osF+uEdxKPYDPHLShyOBZlE8enUzlCUrL02M
        5MKjFm9YFKU7aPDw==
Date:   Tue, 23 Mar 2021 22:30:28 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 09/14] locking/rtmutex: Decrapify __rt_mutex_init()
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional debug handling is just another layer of obfuscation. Split
the function so rt_mutex_init_proxy_locked() can invoke the inner init and
__rt_mutex_init() gets the full treatment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c        |   11 ++++-------
 kernel/locking/rtmutex_common.h |    7 +++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1586,12 +1586,10 @@ void __sched rt_mutex_futex_unlock(struc
 void __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
 {
-	lock->owner = NULL;
-	raw_spin_lock_init(&lock->wait_lock);
-	lock->waiters = RB_ROOT_CACHED;
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
 
-	if (name && key)
-		debug_rt_mutex_init(lock, name, key);
+	__rt_mutex_basic_init(lock);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -1612,8 +1610,7 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
-	__rt_mutex_init(lock, NULL, NULL);
-	debug_rt_mutex_proxy_lock(lock, proxy_owner);
+	__rt_mutex_basic_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -88,6 +88,13 @@ enum rtmutex_chainwalk {
 	RT_MUTEX_FULL_CHAINWALK,
 };
 
+static inline void __rt_mutex_basic_init(struct rt_mutex *lock)
+{
+	lock->owner = NULL;
+	raw_spin_lock_init(&lock->wait_lock);
+	lock->waiters = RB_ROOT_CACHED;
+}
+
 /*
  * PI-futex support (proxy locking functions, etc.):
  */

