Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B325B34BE9E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhC1T6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 15:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhC1T6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 15:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616961513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9OiFa22hFu0KHUxDNLn2lkAkPMr6mIf/ohah5Y7Keys=;
        b=SdjKIFep9PrPEgDYdQPw4d3JmM8Wu6tmCFJehBieOOh4XRr1uhtukjIcZ3IrOqubydddCf
        TiEp8GWfx3MNpMPJNqJI9KtwhgsUbPmwKhwm43ugpiGOm/flvUJQxNdVqXsMQDh9nhqgvr
        TH6MBeYPfg5FmjRcz5KYCV7s4zTY2Sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-xvgQJFrSNz2q-QFXM03VCg-1; Sun, 28 Mar 2021 15:58:31 -0400
X-MC-Unique: xvgQJFrSNz2q-QFXM03VCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DCB87A826;
        Sun, 28 Mar 2021 19:58:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E027B5D9D3;
        Sun, 28 Mar 2021 19:58:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/apic/vector: Move pr_warn() outside of vector_lock
Date:   Sun, 28 Mar 2021 15:58:11 -0400
Message-Id: <20210328195811.32109-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that the following circular locking dependency warning
could happen in some systems:

[  218.097878] ======================================================
[  218.097879] WARNING: possible circular locking dependency detected
[  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
[  218.097881] ------------------------------------------------------
[  218.097882] systemd/1 is trying to acquire lock:
[  218.097883] ffffffff84c27920 (console_owner){-.-.}, at: console_unlock+0x3fb/0x9f0
[  218.097886]
[  218.097887] but task is already holding lock:
[  218.097888] ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
[  218.097891]
[  218.097892] which lock already depends on the new lock.
    :
[  218.097966] other info that might help us debug this:
[  218.097967]
[  218.097967] Chain exists of:
[  218.097968]   console_oc_lock_class --> vector_lock
[  218.097972]
[  218.097973]  Possible unsafe locking scenario:
[  218.097973]
[  218.097974]        CPU0                    CPU1
[  218.097975]        ----                    ----
[  218.097975]   lock(vector_lock);
[  218.097977]                                lock(&irq_desc_lock_class);
[  218.097980]                                lock(vector_lock);
[  218.097981]   lock(console_owner);
[  218.097983]
[  218.097984]  *** DEADLOCK ***

This lockdep warning was causing by printing of the warning message:

[  218.095152] irq 3: Affinity broken due to vector space exhaustion.

It looks that this warning message is relatively more common than
the other warnings in arch/x86/kernel/apic/vector.c. To avoid this
potential deadlock scenario, this patch moves all the pr_warn() calls
in the vector.c file outside of the vector_lock critical sections.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/apic/vector.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c7492252f..948ec592ef61 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -385,7 +385,8 @@ static void x86_vector_deactivate(struct irq_domain *dom, struct irq_data *irqd)
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
 }
 
-static int activate_reserved(struct irq_data *irqd)
+static int activate_reserved(struct irq_data *irqd, unsigned long flags,
+			     bool *unlocked)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	int ret;
@@ -410,6 +411,8 @@ static int activate_reserved(struct irq_data *irqd)
 	 */
 	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
 			    irq_data_get_affinity_mask(irqd))) {
+		raw_spin_unlock_irqrestore(&vector_lock, flags);
+		*unlocked = true;
 		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
 			irqd->irq);
 	}
@@ -446,6 +449,7 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	unsigned long flags;
+	bool unlocked = false;
 	int ret = 0;
 
 	trace_vector_activate(irqd->irq, apicd->is_managed,
@@ -459,8 +463,9 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
 	else if (apicd->is_managed)
 		ret = activate_managed(irqd);
 	else if (apicd->has_reserved)
-		ret = activate_reserved(irqd);
-	raw_spin_unlock_irqrestore(&vector_lock, flags);
+		ret = activate_reserved(irqd, flags, &unlocked);
+	if (!unlocked)
+		raw_spin_unlock_irqrestore(&vector_lock, flags);
 	return ret;
 }
 
@@ -989,6 +994,7 @@ void irq_force_complete_move(struct irq_desc *desc)
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
+	bool warn_move_in_progress = false;
 
 	/*
 	 * The function is called for all descriptors regardless of which
@@ -1064,12 +1070,14 @@ void irq_force_complete_move(struct irq_desc *desc)
 		 * so we have the necessary information when a problem in that
 		 * area arises.
 		 */
-		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
-			irqd->irq, vector);
+		warn_move_in_progress = true;
 	}
 	free_moved_vector(apicd);
 unlock:
 	raw_spin_unlock(&vector_lock);
+	if (warn_move_in_progress)
+		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
+			irqd->irq, vector);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1079,25 +1087,24 @@ void irq_force_complete_move(struct irq_desc *desc)
  */
 int lapic_can_unplug_cpu(void)
 {
-	unsigned int rsvd, avl, tomove, cpu = smp_processor_id();
+	unsigned int rsvd = 0, avl, tomove, cpu = smp_processor_id();
 	int ret = 0;
 
 	raw_spin_lock(&vector_lock);
 	tomove = irq_matrix_allocated(vector_matrix);
 	avl = irq_matrix_available(vector_matrix, true);
+	if (avl < tomove)
+		ret = -ENOSPC;
+	else
+		rsvd = irq_matrix_reserved(vector_matrix);
+	raw_spin_unlock(&vector_lock);
 	if (avl < tomove) {
 		pr_warn("CPU %u has %u vectors, %u available. Cannot disable CPU\n",
 			cpu, tomove, avl);
-		ret = -ENOSPC;
-		goto out;
-	}
-	rsvd = irq_matrix_reserved(vector_matrix);
-	if (avl < rsvd) {
+	} else if (avl < rsvd) {
 		pr_warn("Reserved vectors %u > available %u. IRQ request may fail\n",
 			rsvd, avl);
 	}
-out:
-	raw_spin_unlock(&vector_lock);
 	return ret;
 }
 #endif /* HOTPLUG_CPU */
-- 
2.18.1

