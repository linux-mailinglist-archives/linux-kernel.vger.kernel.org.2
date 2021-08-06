Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09B3E2C16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhHFOHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 10:07:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50722 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhHFOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 10:07:36 -0400
Date:   Fri, 6 Aug 2021 16:07:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628258839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c5GroXma6kd3BTP+QwuDw/OXDe2Krk30mSb6hYmZBsk=;
        b=Gui2SflCW5ESDdu86T6wg6Kwsapc/SPnCjmeo7RfRWG09shQ2K7Qh9us3ZhQazutbxjmAL
        0MaEM8/RW+uVbiETGGd5Egyh3tbHlV1kqIiQxCc5tmV8IOiV/AN6hj8Z/Vf9uX+oDbsdFX
        x2nmzEVoxl0+lZC80QCVLomjpBSpTzu/jsRz4cV5C1Ejaee2h1X1VHLhEphV1CVZe4h2Vt
        4BirkoeCnNIIwmCQb6z5BWQtQQHrWm0XHM4DlRBg0I2LmIM5YbgCck06afswSopLeJ+FCx
        BFaYl91Potj5/gsul1XwIRRCFIsHcv8y0ec+gJ9giGU4os8YSsmCGbcMAx0REQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628258839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c5GroXma6kd3BTP+QwuDw/OXDe2Krk30mSb6hYmZBsk=;
        b=cJX9KzWCokoUPpfOSPu311AQULU35wA+vVTSaycVIIHQY1fUcBkrWpXdnxUWgcSwJ3DfqV
        oW/+G/Q2E/MzJ1Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
Message-ID: <20210806140718.mxss3cbqijfebdo5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom: Valentin Schneider <valentin.schneider@arm.com>
Date: Sun, 22 Nov 2020 20:19:04 +0000

Booting a recent PREEMPT_RT kernel (v5.10-rc3-rt7-rebase) on my arm64 Juno
leads to the idle task blocking on an RT sleeping spinlock down some
notifier path:

|  BUG: scheduling while atomic: swapper/5/0/0x00000002
=E2=80=A6
|  atomic_notifier_call_chain_robust (kernel/notifier.c:71 kernel/notifier.=
c:118 kernel/notifier.c:186)
|  cpu_pm_enter (kernel/cpu_pm.c:39 kernel/cpu_pm.c:93)
|  psci_enter_idle_state (drivers/cpuidle/cpuidle-psci.c:52 drivers/cpuidle=
/cpuidle-psci.c:129)
|  cpuidle_enter_state (drivers/cpuidle/cpuidle.c:238)
|  cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
|  do_idle (kernel/sched/idle.c:132 kernel/sched/idle.c:213 kernel/sched/id=
le.c:273)
|  cpu_startup_entry (kernel/sched/idle.c:368 (discriminator 1))
|  secondary_start_kernel (arch/arm64/kernel/smp.c:273)

Two points worth noting:

1) That this is conceptually the same issue as pointed out in:
   313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
2) Only the _robust() variant of atomic_notifier callchains suffer from
   this

AFAICT only the cpu_pm_notifier_chain really needs to be changed, but
singling it out would mean introducing a new (truly) non-blocking API. At
the same time, callers that are fine with any blocking within the call
chain should use blocking notifiers, so patching up all atomic_notifier's
doesn't seem *too* crazy to me.

Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201122201904.30940-1-valentin.schneider@a=
rm.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

What do we do with this?
Do we merge this as-is, add another "robust atomic notifier" using only
raw_spinlock_t for registration and notification (for only
cpu_pm_notifier_chain) instead of switching to raw_spinlock_t for all
atomic notifier in -tree?=20

 include/linux/notifier.h |  6 +++---
 kernel/notifier.c        | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 2fb373a5c1ede..723bc2df63882 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -58,7 +58,7 @@ struct notifier_block {
 };
=20
 struct atomic_notifier_head {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct notifier_block __rcu *head;
 };
=20
@@ -78,7 +78,7 @@ struct srcu_notifier_head {
 };
=20
 #define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
-		spin_lock_init(&(name)->lock);	\
+		raw_spin_lock_init(&(name)->lock);	\
 		(name)->head =3D NULL;		\
 	} while (0)
 #define BLOCKING_INIT_NOTIFIER_HEAD(name) do {	\
@@ -95,7 +95,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_=
head *nh);
 		cleanup_srcu_struct(&(name)->srcu);
=20
 #define ATOMIC_NOTIFIER_INIT(name) {				\
-		.lock =3D __SPIN_LOCK_UNLOCKED(name.lock),	\
+		.lock =3D __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
 		.head =3D NULL }
 #define BLOCKING_NOTIFIER_INIT(name) {				\
 		.rwsem =3D __RWSEM_INITIALIZER((name).rwsem),	\
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1b019cbca594a..c20782f076432 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -142,9 +142,9 @@ int atomic_notifier_chain_register(struct atomic_notifi=
er_head *nh,
 	unsigned long flags;
 	int ret;
=20
-	spin_lock_irqsave(&nh->lock, flags);
+	raw_spin_lock_irqsave(&nh->lock, flags);
 	ret =3D notifier_chain_register(&nh->head, n);
-	spin_unlock_irqrestore(&nh->lock, flags);
+	raw_spin_unlock_irqrestore(&nh->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_register);
@@ -164,9 +164,9 @@ int atomic_notifier_chain_unregister(struct atomic_noti=
fier_head *nh,
 	unsigned long flags;
 	int ret;
=20
-	spin_lock_irqsave(&nh->lock, flags);
+	raw_spin_lock_irqsave(&nh->lock, flags);
 	ret =3D notifier_chain_unregister(&nh->head, n);
-	spin_unlock_irqrestore(&nh->lock, flags);
+	raw_spin_unlock_irqrestore(&nh->lock, flags);
 	synchronize_rcu();
 	return ret;
 }
@@ -182,9 +182,9 @@ int atomic_notifier_call_chain_robust(struct atomic_not=
ifier_head *nh,
 	 * Musn't use RCU; because then the notifier list can
 	 * change between the up and down traversal.
 	 */
-	spin_lock_irqsave(&nh->lock, flags);
+	raw_spin_lock_irqsave(&nh->lock, flags);
 	ret =3D notifier_call_chain_robust(&nh->head, val_up, val_down, v);
-	spin_unlock_irqrestore(&nh->lock, flags);
+	raw_spin_unlock_irqrestore(&nh->lock, flags);
=20
 	return ret;
 }
--=20
2.32.0

