Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2C34AC31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhCZQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhCZQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:01:41 -0700 (PDT)
Message-Id: <20210326153943.955697588@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xy727W+qzv0PBQwS5uaGtfzbwrCrcbzJGhOu6/1Ya6A=;
        b=PshmuIm3iMA3jJgWN5d/ehhTkfEdzeaZ4i/nA7wybqLSSVXu78ya1c8dDLkZcBjl0aVdDx
        s5cjxWnaaglYyqQdkKJEaQrtokoePt8mSFBKZbl2vGc9j1pUH0VuvHaibNEX9O55fhHqKW
        k3zYzuaG3RbU68z33ZCTUBPxC07z04a0pKEM+ZFM7lrpXmL+tJiyTer68E/jgke/+ZWNIK
        SunCpcjIhlt23ZSqA5XeqA/Sw/oVYp2vfzD92iReg9oO+0UtrM9L1V/EL/ocgnxjAN8W8Z
        1+YX1bH+EEvfVBlOO0Ebza9AKLa53F1kLEGzQg3bKT7Cu7X2Q92wmSt0A5KwKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xy727W+qzv0PBQwS5uaGtfzbwrCrcbzJGhOu6/1Ya6A=;
        b=qpLUF16cp8LKzhtaFcJ79LQIDn0kdS1jB7u/Judn0uQkZNg/eeuYNn28nZDRxlg5lOcVQY
        KMo4lS7h+852QeDw==
Date:   Fri, 26 Mar 2021 16:29:38 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 09/15] locking/rtmutex: Decrapify __rt_mutex_init()
References: <20210326152929.709289883@linutronix.de>
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
 kernel/locking/rtmutex.c        |   10 ++++------
 kernel/locking/rtmutex_common.h |    7 +++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

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
 
@@ -1612,7 +1610,7 @@ EXPORT_SYMBOL_GPL(__rt_mutex_init);
 void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
-	__rt_mutex_init(lock, NULL, NULL);
+	__rt_mutex_basic_init(lock);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
 
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -100,6 +100,13 @@ enum rtmutex_chainwalk {
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

