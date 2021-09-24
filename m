Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7292B416F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbhIXJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:49:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbhIXJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:49:31 -0400
Date:   Fri, 24 Sep 2021 11:47:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632476877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BY5B6uPkTBbe0WA3EzrYgFum7UnHUC+VP7ozRiHl2eU=;
        b=asigcvDQiYNaSJfk2qs90r7AQaCwocjsnmqU/6u6siom3j8t6+nlECGFIbMhbRrql3CL88
        iV8j4Y9KeBrqT2v1RoAgJ56JWz8JEC6pfy1ioT+bm8e2qwF2CGS7kBLDMaQG5FO6kof3c5
        /LOnzkESSpub12sYhXahUfUAJoBAZuAJ4vqlGWss/K8q7mQaTk37mtT7a9YTYNKGnP6qnk
        ZdYad86gUT3do/QeqdLVICiaRnl4ALzmHb0fjFhKAiIlW82TY/Ebg2FT1AS+hMdutVvubE
        DspcrdhdC4nwXvDBbxvSZzuybCccA2IEzYed6FscqUoyH+IjGyF8lxI5VHh8pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632476877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BY5B6uPkTBbe0WA3EzrYgFum7UnHUC+VP7ozRiHl2eU=;
        b=4oUsvfuotIWDL8xIcLpkvOR+6ly/XXKUtbaFRkHl8TgSZ4vNOypmAul2r9SmeWzXB93sQV
        vL22hoVwzz7quRBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] smp: Wake ksoftirqd on PREEMPT_RT instead do_softirq().
Message-ID: <20210924094755.2m32pgqwrqw2cg2s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softirq implementation on PREEMPT_RT does not provide do_softirq().
The other user of do_softirq() is replaced with a local_bh_disable()
+ enable() around the possible raise-softirq invocation. This can not be
done here because migration_cpu_stop() is invoked with disabled
preemption.

Wake the softirq thread on PREEMPT_RT if there are any pending softirqs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
---
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -690,10 +690,21 @@ void flush_smp_call_function_from_idle(v
 
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
+
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
-	if (local_softirq_pending())
-		do_softirq();
+
+	if (local_softirq_pending()) {
+
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			do_softirq();
+		} else {
+			struct task_struct *ksoftirqd = this_cpu_ksoftirqd();
+
+			if (ksoftirqd && !task_is_running(ksoftirqd))
+				wake_up_process(ksoftirqd);
+		}
+	}
 
 	local_irq_restore(flags);
 }
