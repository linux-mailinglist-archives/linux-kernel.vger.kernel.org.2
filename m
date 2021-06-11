Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB43A4389
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhFKN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhFKN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:42 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fanpwl3YAdJNXikQhsqNlIjF0sjON0JNyroUeZhgHS4=;
        b=jUse8loclVYdO6rFVT/1ogCYvgQj7szhfqN7NMAuEu4vDUWG4n9wg4AbKeqnIIF0nH5oKZ
        zWx2Sxg39DUQ5FK7ND6s1ulK8nMCnidRynyDw/lw7+cv3YuLy9ItfQ2M2zXkVrDv1MWwdP
        TJdoHDYIqqZB5WTo64SEZ8J8gcTsyebg4DtH5ECWi/3nVRqleBBzm8Q+hR+ZV/d6As3ueX
        WQ9Mt2vrX+o3CKSTwKqp5wTAmrlc3dPvxHL6PWY1T3j9fcIqq/FiRLXtM3cI+dOcZBDSm7
        mWNngdYl7TBzWICkVT7pPWNiCcH3l81Ya+IofEpk8XGaPAtp0XMddLREoVlvow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fanpwl3YAdJNXikQhsqNlIjF0sjON0JNyroUeZhgHS4=;
        b=ZohG7rIjhkbH4ifr/wv3xW2xcdC5r0Y9Cr7ml4yIOvLfufWpkntRDLchEBFdIBDlfW//41
        4GLBXeax7e9M4JAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] powerpc: Convert
 irq_domain_add_legacy_isa use to irq_domain_add_legacy
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968086.19906.14976410092936613343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     7c576f4d3ce43fa0fc1ac258dc4768d0f3b3b992
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7c576f4d3ce43fa0fc1ac258dc4768d0f3b3b992
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 10:42:25 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:16 +01:00

powerpc: Convert irq_domain_add_legacy_isa use to irq_domain_add_legacy

irq_domain_add_legacy_isa is a pain. It only exists for the benefit of
two PPC-specific drivers, and creates an ugly dependency between asm/irq.h
and linux/irqdomain.h

Instead, let's convert these two drivers to irq_domain_add_legacy(),
stop using NUM_ISA_INTERRUPTS by directly setting NR_IRQS_LEGACY.

The dependency cannot be broken yet as there is a lot of PPC-related
code that depends on it, but that's the first step towards it.

A followup patch will remove irq_domain_add_legacy_isa.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/powerpc/include/asm/irq.h         | 4 ++--
 arch/powerpc/platforms/ps3/interrupt.c | 4 ++--
 arch/powerpc/sysdev/i8259.c            | 3 ++-
 arch/powerpc/sysdev/mpic.c             | 2 +-
 arch/powerpc/sysdev/tsi108_pci.c       | 3 ++-
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index b2bd588..c1eda91 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -23,8 +23,8 @@ extern atomic_t ppc_n_lost_interrupts;
 /* Total number of virq in the platform */
 #define NR_IRQS		CONFIG_NR_IRQS
 
-/* Same thing, used by the generic IRQ code */
-#define NR_IRQS_LEGACY		NUM_ISA_INTERRUPTS
+/* Number of irqs reserved for a legacy isa controller */
+#define NR_IRQS_LEGACY		16
 
 extern irq_hw_number_t virq_to_hw(unsigned int virq);
 
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index e68f4fb..4987142 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -46,7 +46,7 @@
  * implementation equates HV plug value to Linux virq value, constrains each
  * interrupt to have a system wide unique plug number, and limits the range
  * of the plug values to map into the first dword of the bitmaps.  This
- * gives a usable range of plug values of  {NUM_ISA_INTERRUPTS..63}.  Note
+ * gives a usable range of plug values of  {NR_IRQS_LEGACY..63}.  Note
  * that there is no constraint on how many in this set an individual thread
  * can acquire.
  *
@@ -722,7 +722,7 @@ static unsigned int ps3_get_irq(void)
 	}
 
 #if defined(DEBUG)
-	if (unlikely(plug < NUM_ISA_INTERRUPTS || plug > PS3_PLUG_MAX)) {
+	if (unlikely(plug < NR_IRQS_LEGACY || plug > PS3_PLUG_MAX)) {
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
 		BUG();
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index c1d76c3..dc1a151 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -260,7 +260,8 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
-	i8259_host = irq_domain_add_legacy_isa(node, &i8259_host_ops, NULL);
+	i8259_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
+					   &i8259_host_ops, NULL);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b0426f2..995fb2a 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -602,7 +602,7 @@ static void __init mpic_scan_ht_pics(struct mpic *mpic)
 /* Find an mpic associated with a given linux interrupt */
 static struct mpic *mpic_find(unsigned int irq)
 {
-	if (irq < NUM_ISA_INTERRUPTS)
+	if (irq < NR_IRQS_LEGACY)
 		return NULL;
 
 	return irq_get_chip_data(irq);
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 49f9541..042bb38 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -404,7 +404,8 @@ void __init tsi108_pci_int_init(struct device_node *node)
 {
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
-	pci_irq_host = irq_domain_add_legacy_isa(node, &pci_irq_domain_ops, NULL);
+	pci_irq_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
+					     &pci_irq_domain_ops, NULL);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq domain!\n");
 		return;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 7e4305c..fdf8db4 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -201,7 +201,7 @@ void xics_migrate_irqs_away(void)
 		struct ics *ics;
 
 		/* We can't set affinity on ISA interrupts */
-		if (virq < NUM_ISA_INTERRUPTS)
+		if (virq < NR_IRQS_LEGACY)
 			continue;
 		/* We only need to migrate enabled IRQS */
 		if (!desc->action)
