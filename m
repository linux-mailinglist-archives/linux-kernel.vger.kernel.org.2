Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2B3682FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhDVPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:08:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbhDVPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:13 -0400
Date:   Thu, 22 Apr 2021 15:07:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619104057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj9SiqGxo7pcu6J8MczC8BVjLr4uvKFTb4z+SmDzI7s=;
        b=i5+xBP/Wo58VXO9i+1AIhcpVyE8T95v2sFMIgqdVmvLyMInV1vluax18cKnL3fgEKLEyJS
        6ZlxOSDMgxw/UkX0SuFQ6yZ8HckzNrcfe94kQOmT7bISPkRiyA//uR3UECcjLFNU3XLFRP
        vc8T8WmKRA7lUeOWt1nSqEcXCClcNbov31agQKJkZtNo0zQUiZ8duMh9xRCN2hZNi7qgPG
        jEgK7BKCcYaUkHTWpWnyTuPbYNJJVCxqtKOxXeS4/bXDuKqhuN17ko1RvSfFNXlBAYVKoi
        U0VI0vOAq4G8Jgyr/o8+6yEOCtQSUzmpM/nljbUVUmXvC3aT547gl9uwthe+LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619104057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yj9SiqGxo7pcu6J8MczC8BVjLr4uvKFTb4z+SmDzI7s=;
        b=v8sFkaLDo34hdjQCcyLA+Os/UqNx17JUN5nDq/dmVF3QPU9795W/qD0gLFtian7aYo75kF
        a5xH7AFixRwNaIDg==
From:   "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v4.1: Disable vSGI upon (GIC
 CPUIF < v4.1) detection
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210317100719.3331-2-lorenzo.pieralisi@arm.com>
References: <20210317100719.3331-2-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Message-ID: <161910405703.29796.18333969731246871273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     46135d6f878ab00261d4a2082d620bfb41019aab
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/46135d6f878ab00261d4a2082d620bfb41019aab
Author:        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
AuthorDate:    Wed, 17 Mar 2021 10:07:19 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 15:55:21 +01:00

irqchip/gic-v4.1: Disable vSGI upon (GIC CPUIF < v4.1) detection

GIC CPU interfaces versions predating GIC v4.1 were not built to
accommodate vINTID within the vSGI range; as reported in the GIC
specifications (8.2 "Changes to the CPU interface"), it is
CONSTRAINED UNPREDICTABLE to deliver a vSGI to a PE with
ID_AA64PFR0_EL1.GIC < b0011.

Check the GIC CPUIF version by reading the SYS_ID_AA64_PFR0_EL1.

Disable vSGIs if a CPUIF version < 4.1 is detected to prevent using
vSGIs on systems where they may misbehave.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210317100719.3331-2-lorenzo.pieralisi@arm.com
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |  4 ++--
 drivers/irqchip/irq-gic-v4.c       | 27 +++++++++++++++++++++++++--
 include/linux/irqchip/arm-gic-v4.h |  2 ++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 15a6c98..2f1b156 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -86,7 +86,7 @@ static unsigned long vgic_mmio_read_v3_misc(struct kvm_vcpu *vcpu,
 		}
 		break;
 	case GICD_TYPER2:
-		if (kvm_vgic_global_state.has_gicv4_1)
+		if (kvm_vgic_global_state.has_gicv4_1 && gic_cpuif_has_vsgi())
 			value = GICD_TYPER2_nASSGIcap;
 		break;
 	case GICD_IIDR:
@@ -119,7 +119,7 @@ static void vgic_mmio_write_v3_misc(struct kvm_vcpu *vcpu,
 		dist->enabled = val & GICD_CTLR_ENABLE_SS_G1;
 
 		/* Not a GICv4.1? No HW SGIs */
-		if (!kvm_vgic_global_state.has_gicv4_1)
+		if (!kvm_vgic_global_state.has_gicv4_1 || !gic_cpuif_has_vsgi())
 			val &= ~GICD_CTLR_nASSGIreq;
 
 		/* Dist stays enabled? nASSGIreq is RO */
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 5d1dc99..4ea71b2 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -87,17 +87,40 @@ static struct irq_domain *gic_domain;
 static const struct irq_domain_ops *vpe_domain_ops;
 static const struct irq_domain_ops *sgi_domain_ops;
 
+#ifdef CONFIG_ARM64
+#include <asm/cpufeature.h>
+
+bool gic_cpuif_has_vsgi(void)
+{
+	unsigned long fld, reg = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_GIC_SHIFT);
+
+	return fld >= 0x3;
+}
+#else
+bool gic_cpuif_has_vsgi(void)
+{
+	return false;
+}
+#endif
+
 static bool has_v4_1(void)
 {
 	return !!sgi_domain_ops;
 }
 
+static bool has_v4_1_sgi(void)
+{
+	return has_v4_1() && gic_cpuif_has_vsgi();
+}
+
 static int its_alloc_vcpu_sgis(struct its_vpe *vpe, int idx)
 {
 	char *name;
 	int sgi_base;
 
-	if (!has_v4_1())
+	if (!has_v4_1_sgi())
 		return 0;
 
 	name = kasprintf(GFP_KERNEL, "GICv4-sgi-%d", task_pid_nr(current));
@@ -182,7 +205,7 @@ static void its_free_sgi_irqs(struct its_vm *vm)
 {
 	int i;
 
-	if (!has_v4_1())
+	if (!has_v4_1_sgi())
 		return;
 
 	for (i = 0; i < vm->nr_vpes; i++) {
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 943c341..2c63375 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -145,4 +145,6 @@ int its_init_v4(struct irq_domain *domain,
 		const struct irq_domain_ops *vpe_ops,
 		const struct irq_domain_ops *sgi_ops);
 
+bool gic_cpuif_has_vsgi(void);
+
 #endif
