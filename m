Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B043DBA51
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbhG3OVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:21:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbhG3ORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:36 -0400
Message-ID: <20210730135206.528228725@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x1jMXexlEPdAz0CqHsNuS5nqhi24x/wRfKCrdA19NWE=;
        b=jJKQCWCiEqgfZbyf6LnqPV9ETXJMf8Pal4TUAHvnr1rIcRgJBAcXPxJ0xF/Oek4va2s8AU
        BvwUNkJopJAvUAesBnsywmGVAJ4oag3BhnO9NQ14WjLwpif2NK7fRm5OTwLxdhgImx/I9A
        AavmdqH7t6a/O3wJLIZDFcfrcu3Ia9lw7+Mon5A5QHdU3cW8+3e3HxmUakx7HoRgqfvc9B
        Px30HLosRTh8vf897Z+5L1pQWoBYInT5t8WGKegf2fXZLaLhzagXkuJ2HCsEa9htjge55L
        nBZUKY43DVmRBuBo88++Otuuy0c+/37nSM0sB1kg+tfCHWRm9oFDjwkOgGlHyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x1jMXexlEPdAz0CqHsNuS5nqhi24x/wRfKCrdA19NWE=;
        b=QceNbxLtXXAgxFbWM8AIhvU7AMChELEv9oh7q4A3FjKlgAuHZeNpq4Oh8EkPvHEAkPVciW
        ZotRBjmKVEYPUMDA==
Date:   Fri, 30 Jul 2021 15:50:31 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 24/63] locking/lockdep: Reduce includes in debug_locks.h
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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
 

