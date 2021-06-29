Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2089B3B747B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhF2OlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:41:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbhF2OlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:41:14 -0400
Date:   Tue, 29 Jun 2021 14:35:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624977526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c1TN6OGZF8IMjaH1l/nKgqqjkOly1YbUY9y0rBZDrGM=;
        b=GX7dxbZYPXS3ReHxM4pAkdE7L5Hhp825Zf6shdDlTRR8yPUaOWkYcj1rkEqIxt0CaQmDCl
        U6EzlafY9Ka2bATh/bY/AURaoYI2pPVUt++UVJYLam0aJENTgbI+x4W/BAA84deVHTpVF9
        pzGVdBOwr7dC8R17GB3LmXt77bc6wnUPjWAWhjbv9TtAHTBLFRFRkI8RWxZ6+aOtptGwRl
        C1tFEdGfYF8uMri1B7wcWm35v6FHpu5gm8tn6aAPzFx2Tq07B2/Lj47LXff1Ut8kN3SYpj
        vdgWbed7JjN/stk3AW24aGPYZjjGdpxosO/V6tvYneVBPx+N5eFuhW8/M2dPnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624977526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c1TN6OGZF8IMjaH1l/nKgqqjkOly1YbUY9y0rBZDrGM=;
        b=cllBChlmL8loBexqW5ojWgTrFN3LDlBigYywTtOR2FP3qvVcRUV+R7OC9qZ2RZK5ugw0wl
        qZzXojCwE9SsPuAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v5.14-rc1
References: <162497731214.6531.6083197571290189651.tglx@nanos>
Message-ID: <162497731335.6531.6983356866447421688.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2021-06-29

up to:  130708331bc6: cpu/hotplug: Simplify access to percpu cpuhp_state

A simple cleanup for the CPU hotplug code to avoid per_cpu_ptr()
reevaluation.

Thanks,

	tglx

------------------>
Yuan ZhaoXiong (1):
      cpu/hotplug: Simplify access to percpu cpuhp_state


 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518556f4..2942cb4644c5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -961,7 +961,7 @@ static int takedown_cpu(unsigned int cpu)
 	int err;
 
 	/* Park the smpboot threads */
-	kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+	kthread_park(st->thread);
 
 	/*
 	 * Prevent irq alloc/free while the dying cpu reorganizes the
@@ -977,7 +977,7 @@ static int takedown_cpu(unsigned int cpu)
 		/* CPU refused to die */
 		irq_unlock_sparse();
 		/* Unpark the hotplug thread so we can rollback there */
-		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+		kthread_unpark(st->thread);
 		return err;
 	}
 	BUG_ON(cpu_online(cpu));

