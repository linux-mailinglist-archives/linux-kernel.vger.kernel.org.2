Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372EA33216C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhCII6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCII5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:57:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A8CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:57:43 -0800 (PST)
Message-Id: <20210309085727.153926793@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615280262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ei+LHhf+MGw/l3MD6uQTxIWOC8U0z4z/OUf5lB4CD/Q=;
        b=N155eboODdBbEcn/Q5zSi8Mgpr3N4dQ4HDQo3/Zry+IS3HdsefZQj+3+0nm5lzFP44F2fg
        BKfUs7ZuI0BbwgNELXwVfUS7rQOCftw0gId3xmXlWuRk7MU+XfMNPHqqn+mMvZnh8Fsy9R
        qptU04o2H7F8MJ3bGnxioKjhiU/aRMNiw9q6XhprzMw8JEn8XCLnhXiJKuIBnTNGBXFYZ9
        Odr7rEfI18A8QA1g7dxzcaUvvzkZc93FXMuQ6Kr7ZVER0KPORL/9wWzVh8ETq3C6JvpQ4V
        qpRjXAQuz8M3Of8H4MVm8R7s/fwUOBlG5ThCGyp4o85yUNpMipeqVwN1HemU6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615280262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Ei+LHhf+MGw/l3MD6uQTxIWOC8U0z4z/OUf5lB4CD/Q=;
        b=cLR+S19wfwQdc0LYjzib0ivPKy38/XK2WNgr2eR0t9irAIvM3iKMV/oJpdgmVlNtm7tyvm
        5sxzJQdoX/tz1ABQ==
Date:   Tue, 09 Mar 2021 09:55:54 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V3 2/6] irqtime: Make accounting correct on RT
References: <20210309085552.815026890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vtime_account_irq and irqtime_account_irq() base checks on preempt_count()
which fails on RT because preempt_count() does not contain the softirq
accounting which is seperate on RT.

These checks do not need the full preempt count as they only operate on the
hard and softirq sections.

Use irq_count() instead which provides the correct value on both RT and non
RT kernels. The compiler is clever enough to fold the masking for !RT:

       99b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax
 -     9a2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
 +     9a2:	25 00 ff ff 00       	and    $0xffff00,%eax

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/cputime.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -60,7 +60,7 @@ void irqtime_account_irq(struct task_str
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
-	pc = preempt_count() - offset;
+	pc = irq_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -421,7 +421,7 @@ void vtime_task_switch(struct task_struc
 
 void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	unsigned int pc = preempt_count() - offset;
+	unsigned int pc = irq_count() - offset;
 
 	if (pc & HARDIRQ_OFFSET) {
 		vtime_account_hardirq(tsk);

