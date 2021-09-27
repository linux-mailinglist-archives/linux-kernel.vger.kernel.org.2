Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12716419017
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhI0HkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhI0Hjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:39:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46318C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:38:17 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:38:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632728295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4aJWVw/ZVKFOKYDS675KC4EOfP5vGYejiwQFoqnpuk=;
        b=FOKKFNI+NMyhlChLDlhtRV+Cv+ruc5HzuVtTU1FLfIOQRAorvY6Cuf9Ad0In1SbxPcxH55
        6srTkLCqlRz11pYJDnC1ozMglmk7+V1HDNuYtWRDwQfd4CUow+cJpMpNgVBPRWFWSAJram
        s0WaFkzY7hcWkyQShvVjqs/mL3PynVrjt09IRlMZqxH2yqtebXg4pL56MCO83IDqH2CMRR
        0/AN9tjaO8Oxt5c6NgC9mxfj/qHFOdhv7zMo927KV75SFBiP+nLs6ORjDNlopRryhI3L1m
        cRw9e+SPM1a/NRJkXyhNzx+PL4/iGhTWIWa9YSED5/8qDLqMiy+mB5fj7C5fIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632728295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4aJWVw/ZVKFOKYDS675KC4EOfP5vGYejiwQFoqnpuk=;
        b=3GEPPzQPQuc8OO7R7Hh1CxtSuTu4pDCQiYapeq7KQCFUznUMTd3jbcN7bXYI9cVClB89qP
        ofVYGBiRqXWoGiBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] smp: Wake ksoftirqd on PREEMPT_RT instead do_softirq().
Message-ID: <20210927073814.x5h6osr4dgiu44sc@linutronix.de>
References: <20210924094755.2m32pgqwrqw2cg2s@linutronix.de>
 <YU76mB5hzvw3xZRB@infradead.org>
 <87tui7bc5m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87tui7bc5m.ffs@tglx>
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
v1=E2=80=A6v2: Drop an empty line.

 kernel/smp.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
---
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -690,10 +690,20 @@ void flush_smp_call_function_from_idle(v
=20
 	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
 		      smp_processor_id(), CFD_SEQ_IDLE);
+
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
-	if (local_softirq_pending())
-		do_softirq();
+
+	if (local_softirq_pending()) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			do_softirq();
+		} else {
+			struct task_struct *ksoftirqd =3D this_cpu_ksoftirqd();
+
+			if (ksoftirqd && !task_is_running(ksoftirqd))
+				wake_up_process(ksoftirqd);
+		}
+	}
=20
 	local_irq_restore(flags);
 }
