Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9423E90B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhHKMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbhHKMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C6C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:22:44 -0700 (PDT)
Message-ID: <20210811121414.669453962@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qoh8d3hfSvvuGtm/7GyzaEgA5QXxkK7VldYhzUcnH+E=;
        b=itkwgHPgwLNfpB1TrHX+7DYoe+tTH4J9G6m4EOSTAgfViZe0p3FyDFJ1e48yDZSTcuDbQB
        5YR8s1k4Xs6Pov9B5L2tcnH9uncD5qCD7EVS4tGrS1nX8DYhIieHIPvlmOHw+xaMSSiSrz
        3uckE/tVvHVMMH41/XET4/xQDEimKbMJcWk0C0ThosU8u8chLV1LOOze8je+NQnAj7Pv8c
        BnPwadG3j6vWYiXzrYO+cDUsJ07eBRZKTOtK8AyKauKvCpGrtl9FAn8NvM3RRuCHwKmie3
        xVINC6BPuzvhkaufQ1mxAB948cpIMNURioAlCwm9upI7Xt6xtSKuFkTJIvJNRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qoh8d3hfSvvuGtm/7GyzaEgA5QXxkK7VldYhzUcnH+E=;
        b=NmTs9cf5jNwWbUytaYMsW/wbNeFblDRgPCQ8etUy+6y1x/VgLb2Cbdb3hGAUJOSKyRq6W9
        qKDoc5ZB6XYMQjBg==
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
Subject: [patch V4 09/68] rtmutex: Remove rt_mutex_is_locked()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:41 +0200 (CEST)
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
@@ -67,17 +67,6 @@ do { \
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

