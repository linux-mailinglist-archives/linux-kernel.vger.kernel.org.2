Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8A83ECB26
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhHOV3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:29:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhHOV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:24 -0400
Message-ID: <20210815211302.552218335@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZNgeNJUoyTohxPSayLDxma3rY3D4aSWGp/YVkJ6xoCg=;
        b=JpNlSSNklTTn0ZUWdo6V+zb0muaxoVMfEoQRT95BEiJaIh+nnDYS0NOtyn282D2qWUtSo4
        V43dWzyjxpE3l5EIUc0njDjwoOCnqwHCSQYcAcMExIWlj36MYQzlWQO4Rt/Gd6sAhYI/Mp
        UIutt0GpXFOTMGJpNQYWMXeMhNPmOiI5lK1GQQg8Kq5vApeAnMqS6hC1bKdCtjNFi9zp2h
        RyvN1IlGDx1uF5UChtu87h07FOgKrwhUJqEjy9/FJLbexMSdCoQVZlCIAmR/NT1X5A3uje
        xTzca5l68rXYUcqqcZsdbX0z8LotPpAB7U5eP54pEQITwMdSkS9EKppXtr07bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZNgeNJUoyTohxPSayLDxma3rY3D4aSWGp/YVkJ6xoCg=;
        b=xeUvASx5te7aQb3ax46IWW5h44z0IWBKGxXEabQtb0GzaP5uANikyqKe1a8zDgBipEkXB4
        stE+4EA6M07SodBA==
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
Subject: [patch V5 11/72] rtmutex: Remove rt_mutex_is_locked()
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:52 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

No more users.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |   11 -----------
 1 file changed, 11 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -72,17 +72,6 @@ do { \
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
-/**
- * rt_mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-static inline int rt_mutex_is_locked(struct rt_mutex *lock)
-{
-	return lock->owner != NULL;
-}
-
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC

