Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759DD3E90BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbhHKMYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbhHKMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F092EC061389
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:02 -0700 (PDT)
Message-ID: <20210811121415.640742863@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x1jMXexlEPdAz0CqHsNuS5nqhi24x/wRfKCrdA19NWE=;
        b=KN9U3+clRB9XQocj0eKHaJWOa7vIuvRgwjRrNsXmb2upX1eQlLF3A5ZMM/xwFXTCxDzTw5
        aD8EdtepEXCkA2d23CbLY0c2L+oOsPbTRiTYyzkosX+fCooS5dRKK6zX1khYA4z0ZDnT7X
        bvyoOp3dXTZF8wcWUJTKTXkBF4Mz4YNsu75kdlwiKOO/5f/ilYZaqx70Q6QPQKnLIvS8eZ
        Re0gSU96XjsQJihVUqijveKqs5bVvpWsNC09pNb1iYBSIxI6yUJSaWEnkuOi4k0YDi0Q1r
        RLJCTXHiMPs8U6dBLAk0eTQgeBsafjbqJhIChr37sYum4hRKBF/WwLXpP2c7oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x1jMXexlEPdAz0CqHsNuS5nqhi24x/wRfKCrdA19NWE=;
        b=JzJzXs7NL9Q4ncaES4FbBKUbKtXDMnNG0vADfB5Z7RrUNiegpp2RuDFa0AyFpTVTxCz3Tp
        PPHAgD6eWJtJEbBw==
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
Subject: [patch V4 25/68] locking/lockdep: Reduce includes in debug_locks.h
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:01 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The inclusion of printk.h leads to a circular dependency if spinlock_t is
based on rtmutexes on RT enabled kernels.

Include only atomic.h (xchg()) and cache.h (__read_mostly) which is all
what debug_locks.h requires.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/debug_locks.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -3,8 +3,7 @@
 #define __LINUX_DEBUG_LOCKING_H
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
-#include <linux/printk.h>
+#include <linux/cache.h>
 
 struct task_struct;
 

