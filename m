Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6559F3E90B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbhHKMYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:24:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhHKMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:08 -0400
Message-ID: <20210811121414.795305075@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=AMlDfW2ngHfdY6IWCeOmQZAXmI04Ba26obUjR4G9/alSedajoxUIeF7mYZa5PZG3m9xN3B
        9Be2SPfEvMbOdvr2cJ2LHTzuqk7LRAXqhsblagNu2ZZdsD4qsSPvO6LAq15enmX2uxx4Af
        J1K/uHI3q3jTwf1Ivdh21SV5u+f54MvdCpxM+Vw38WYELs0Zg89qOt5ZcoQjTRBWK9Ldyv
        strztJ2sXnjW4JVaLUUxOVrI4of0l2rRurINpWzwaVMyNAoQeDWPwW1STtWQiVmhoKdj/T
        6GqbqtQhwdIeSwD5xr5Zvq4KdOuRMMSaHRsY6thLGZMCtG3srJJ23keQahtq4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=eUDu0nLG36KMlxSLMzLhRDK/3B0vz/bm0XSTu/JX9No70vou1FS60uNiU29bMnyMPIA0Ui
        MaOfII0d2BrNzpDg==
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
Subject: [patch V4 11/68] rtmutex: Switch to try_cmpxchg()
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:22:44 +0200 (CEST)
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

