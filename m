Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1003E1864
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbhHEPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:43:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242382AbhHEPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:57 -0400
Message-ID: <20210805153954.276114061@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x1jMXexlEPdAz0CqHsNuS5nqhi24x/wRfKCrdA19NWE=;
        b=Et2KK8RyYV9mR/+Uc42oU4HG+pO7Lk+6zqx8YpAiaRIIrZnSThKgQFHU6XNsoK0Eb5lXS4
        +2czh/giELj71KlErI5NDOK4X7pPChvv+X3sRsM27gYmamjUaEfZLabrJ0EZk+pao9tm6b
        tcD+GWu+vA1VM0SEUoeJ1X3miHRgxD7MLdV3TkNRbi4lJ0Le9//RIBoWNVwBlIrj0YLJoB
        RHY1uCbRmv7agwT8zfBbrNJ8BIT43tvQI0MYFN4Xru5Q4aMnQTIs8JJlnQlrUwZTvr7ZhR
        KGWLzD1spcHyAGrdt5mp0GN2U7hkXty3hJJhoS13W7eGDjpKow6N5MXqx+lxwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=x1jMXexlEPdAz0CqHsNuS5nqhi24x/wRfKCrdA19NWE=;
        b=wjZx47ryforEYskJFD31dDu+LafUUJa8GjbLsxmo5eloQEyPeNuRAPjeA3ZO0gHSTfPYhE
        tVMpPh8Y8A/WVoBg==
Date:   Thu, 05 Aug 2021 17:13:25 +0200
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
Subject: [patch V3 25/64] locking/lockdep: Reduce includes in debug_locks.h
References: <20210805151300.330412127@linutronix.de>
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
 

