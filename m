Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7983531C130
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBOSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:11:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79064C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 10:10:31 -0800 (PST)
Date:   Mon, 15 Feb 2021 19:10:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613412629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4ua0Bk1hXrmKg18t1gjofV0muurRlhSUo2yxIxA8jUQ=;
        b=P3m+luK9bA2zWuto8YO2j+JK5AvW0VCgAklcCYLvITeQ4TBxLPiG/DF7YgCmg7c7aUZbCj
        8v5ArPa1IP1POPaOJ1tBDt3R7P9kziO3Sw09M4fCf6qmTOzoQmP0F9W1nvhr5jA4ZSrh9F
        FZ8QFSWSAOz7LPU2BrHnUWipLWGFPSGuzh7cwRkmMqv1ZE/8rIRz4SmdUmunyt3034V/M6
        BpvznHWjCWr6rjQMcvf0yiY8MFAsrCHbs7tNw0nnj4YEuA4qX3z0ep4RNwi58tmCGh5vtY
        8zV8R6SEdDjzFCnzXXflAM1hngum0uSFm/AbKp3to/kdHsc00qpHhhkGEpzGBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613412629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4ua0Bk1hXrmKg18t1gjofV0muurRlhSUo2yxIxA8jUQ=;
        b=f+hDivHa1JRSEZNK2iQBvVAMW6Lwnvl1ZI2MuYsZV7v01fRF0pPJxJ5Wkh5xTPzoLrc7Q2
        GI5cQ4AiG3Gd6TCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT] smp: Wake ksoftirqd on PREEMPT_RT instead do_softirq().
Message-ID: <20210215181027.mxkzolp3fibfiwvv@linutronix.de>
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
 kernel/smp.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -450,8 +450,18 @@ void flush_smp_call_function_from_idle(v
 
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
+			if (ksoftirqd && ksoftirqd->state != TASK_RUNNING)
+				wake_up_process(ksoftirqd);
+		}
+	}
 
 	local_irq_restore(flags);
 }
