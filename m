Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4213DBA81
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhG3OYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbhG3ORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421EEC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:15 -0700 (PDT)
Message-ID: <20210730135205.726084388@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=YBH7oVS/BDdKbjdtXM6T1HaPfbbkpD7NQjA7pZth0eVxZzoaBleXb6jLzbC6jQmd+9DsEG
        DN7+7igOErkT74Ji5TTaPUsHXoGsj0ubVYtgaXoGllek7fpctgwRpgOMujJdzEjAZi8nB8
        IEHqBciFyNJ5GeG8VJyL9SeJoM+KNKegzmlZ5QS6HEdbZ0CdhIWgfv+ZNRAXsOwC1CQpKl
        lPF3zJOiQzDQ/uwjVITw8o4pbDPmSGMFG6o1RQILQUfV9980o/Gzqua02PrMlFs2IsUh8o
        pJWcrxJnc+hdDrQVb8oql3GVT9qDTtXWuVK2+I6MwnpX/P109OYFHPc4tP/IIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=CqvxsBfrTaNj50p9VaVanEbmqE511uUKL/DgnRHd2PWtVRhTgN/TxSftypKUAlkXQsIUlq
        hktp1SiLxPpNH9BA==
Date:   Fri, 30 Jul 2021 15:50:17 +0200
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
Subject: [patch 10/63] rtmutex: Switch to try_cmpxchg()
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allows the compiler to generate better code depending on the architecture.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -145,14 +145,14 @@ static __always_inline bool rt_mutex_cmp
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
-	return cmpxchg_acquire(&lock->owner, old, new) == old;
+	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
-	return cmpxchg_release(&lock->owner, old, new) == old;
+	return try_cmpxchg_release(&lock->owner, &old, new);
 }
 
 /*

