Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0015846079F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358467AbhK1Qkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:40:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358555AbhK1Qih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:38:37 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638117320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=z7wTEtL+RDUa4U6Pu6A85/a4Fm+7nB36JHXG+Z9mBhQ=;
        b=jaLEqpx/P8+ttb8Pk1VXfnI/rlCwQxhthUeiCcioPqw12h9ttaRCCfWM7i0ul51zyoHrJI
        Fx2MFz50wLk7tXS/pZjBrjQBDpOcIVKzGFjT5qe3AM4veSV8ISRVi8QjO0I5KibzaQXyQL
        Grc4+6941jPhZQWDSpO0dwUNXVxj033AToxMqGdgQWDc1fr9/fhlm73/G8J+EI6tKn+L9h
        3zsHeflxoLOhHnBnRvvirx9tkZ1Se6bctd1EVgSvo+rfPUeRAQq9fly+SV/5SftExvneIv
        YlKVYSudXrtoizUO0I5x8v3iCz6TbfXylal3GLfYysYk3QH/lJOa6lXZ023ICA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638117320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=z7wTEtL+RDUa4U6Pu6A85/a4Fm+7nB36JHXG+Z9mBhQ=;
        b=/dDwB/73uSOqJ1PMUZ4a4xVtT0n9bkzehYcjjdHSt/g8HG+EAIfVqlS9E0cdwpnz3V+vwE
        /2zpl62uDgQZWPAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.16-rc3
References: <163811728418.767205.14544746031342483043.tglx@xen13>
Message-ID: <163811728714.767205.7609265541729493515.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 Nov 2021 17:35:19 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
1-11-28

up to:  dce1ca0525bf: sched/scs: Reset task stack state in bringup_cpu()


A single scheduler fix to ensure that there is no stale KASAN shadow state
left on the idle task's stack when a CPU is brought up after it was brought
down before.

Thanks,

	tglx

------------------>
Mark Rutland (1):
      sched/scs: Reset task stack state in bringup_cpu()


 kernel/cpu.c        | 7 +++++++
 kernel/sched/core.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 192e43a87407..407a2568f35e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,6 +31,7 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
+#include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
=20
@@ -587,6 +588,12 @@ static int bringup_cpu(unsigned int cpu)
 	struct task_struct *idle =3D idle_thread_get(cpu);
 	int ret;
=20
+	/*
+	 * Reset stale stack state from the last time this CPU was online.
+	 */
+	scs_task_reset(idle);
+	kasan_unpoison_task_stack(idle);
+
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fda64ac..76f9deeaa942 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8619,9 +8619,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->flags |=3D PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
=20
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
 #ifdef CONFIG_SMP
 	/*
 	 * It's possible that init_idle() gets called multiple times on a task,
@@ -8777,7 +8774,6 @@ void idle_task_exit(void)
 		finish_arch_post_lock_switch();
 	}
=20
-	scs_task_reset(current);
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
=20

