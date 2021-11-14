Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1544F81A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhKNNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:33:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B786C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:30:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636896657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NiTeAIA9HvHx/HRhdN7bQi8D6l/lf+oECb1/RxVWpfA=;
        b=W0hFtwYqFd2dqfKFwyP6jnXF0a7lQpMx7GC3OxI/FZ7mCXDGH8CvikcwSF1IE7Lw4+0iMT
        hJLO5yV/YtY+KFXQpfHBlqM1t5+b1VzXYJfAz0njAJWbdmnU8dq2jNW38sap2JUwrlELoX
        aBn2lGjhzf5Ldh1T3dgIGO/y6zzKEp5r7NWt7PYL/tgvkKjDDSbwWzswTyDPNpfjoVq10y
        jjEvn3qj4tsxExKvc2KHNBzO30dFMmsnPG5wd7UNXywuFPnR6Nx+aawLEuqL3T9LFj3x3q
        At9uf9hJhlv8Cq2iQTTJvnT1TtKb+sGdwc3jyDdPdc/1CLYvG0y502lcU647fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636896657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NiTeAIA9HvHx/HRhdN7bQi8D6l/lf+oECb1/RxVWpfA=;
        b=1/UuNNbNYZQ/3VqDsM5GiCqg2PeY+Vk4OEEkP6+emflwwX18rTOmIMafT5mqpW9d1KB2wG
        RjTlzUU9sszgQbBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.16-rc1
Message-ID: <163689642456.3249160.13397023971040961440.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 14 Nov 2021 14:30:56 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-=
11-14

up to:  979292af5b51: Merge tag 'irqchip-fixes-5.16-1' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A set of fixes for the interrupt subsystem:

  - Core code:

    A regression fix for the Open Firmware interrupt mapping code where a
    interrupt controller property in a node caused a map property in the
    same node to be ignored.

  - Interrupt chip drivers:

    - Workaround a limitation in SiFive PLIC interrupt chip which silently
      ignores an EOI when the interrupt line is masked.

    - Provide the missing mask/unmask implementation for the CSKY MP
      interrupt controller.

  - PCI/MSI:

    - Prevent a use after free when PCI/MSI interrupts are released by
      destroying the sysfs entries before freeing the memory which is
      accessed in the sysfs show() function.

    - Implement a mask quirk for the Nvidia ION AHCI chip which does not
      advertise masking capability despite implementing it. Even worse the
      chip comes out of reset with all MSI entries masked, which due to the
      missing masking capability never get unmasked.

    - Move the check which prevents accessing the MSI[X] masking for XEN
      back into the low level accessors. The recent consolidation missed
      that these accessors can be invoked from places which do not have
      that check which broke XEN. Move them back to he original place
      instead of sprinkling tons of these checks all over the code.

  =20
Thanks,

	tglx

------------------>
Guo Ren (2):
      irqchip/csky-mpintc: Fixup mask/unmask implementation
      irqchip/sifive-plic: Fixup EOI failed when masked

Marc Zyngier (3):
      PCI/MSI: Deal with devices lying about their MSI mask capability
      PCI: Add MSI masking quirk for Nvidia ION AHCI
      of/irq: Don't ignore interrupt-controller when interrupt-map failed

Thomas Gleixner (2):
      PCI/MSI: Move non-mask check back into low level accessors
      PCI/MSI: Destroy sysfs before freeing entries


 drivers/irqchip/irq-csky-mpintc.c |  8 ++++----
 drivers/irqchip/irq-sifive-plic.c |  8 +++++++-
 drivers/of/irq.c                  | 19 ++++++++++++++++---
 drivers/pci/msi.c                 | 39 ++++++++++++++++++++++---------------=
--
 drivers/pci/quirks.c              |  6 ++++++
 include/linux/msi.h               |  2 +-
 include/linux/pci.h               |  2 ++
 kernel/irq/msi.c                  |  4 ++--
 8 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpi=
ntc.c
index cb403c960ac0..4aebd67d4f8f 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -78,7 +78,7 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 		readl_relaxed(reg_base + INTCL_RDYIR));
 }
=20
-static void csky_mpintc_enable(struct irq_data *d)
+static void csky_mpintc_unmask(struct irq_data *d)
 {
 	void __iomem *reg_base =3D this_cpu_read(intcl_reg);
=20
@@ -87,7 +87,7 @@ static void csky_mpintc_enable(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
 }
=20
-static void csky_mpintc_disable(struct irq_data *d)
+static void csky_mpintc_mask(struct irq_data *d)
 {
 	void __iomem *reg_base =3D this_cpu_read(intcl_reg);
=20
@@ -164,8 +164,8 @@ static int csky_irq_set_affinity(struct irq_data *d,
 static struct irq_chip csky_irq_chip =3D {
 	.name           =3D "C-SKY SMP Intc",
 	.irq_eoi	=3D csky_mpintc_eoi,
-	.irq_enable	=3D csky_mpintc_enable,
-	.irq_disable	=3D csky_mpintc_disable,
+	.irq_unmask	=3D csky_mpintc_unmask,
+	.irq_mask	=3D csky_mpintc_mask,
 	.irq_set_type	=3D csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity =3D csky_irq_set_affinity,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index cf74cfa82045..259065d271ef 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -163,7 +163,13 @@ static void plic_irq_eoi(struct irq_data *d)
 {
 	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
=20
-	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	if (irqd_irq_masked(d)) {
+		plic_irq_unmask(d);
+		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+		plic_irq_mask(d);
+	} else {
+		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+	}
 }
=20
 static struct irq_chip plic_chip =3D {
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 32be5a03951f..b10f015b2e37 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -161,9 +161,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phand=
le_args *out_irq)
 		 * if it is then we are done, unless there is an
 		 * interrupt-map which takes precedence.
 		 */
+		bool intc =3D of_property_read_bool(ipar, "interrupt-controller");
+
 		imap =3D of_get_property(ipar, "interrupt-map", &imaplen);
-		if (imap =3D=3D NULL &&
-		    of_property_read_bool(ipar, "interrupt-controller")) {
+		if (imap =3D=3D NULL && intc) {
 			pr_debug(" -> got it !\n");
 			return 0;
 		}
@@ -244,8 +245,20 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phand=
le_args *out_irq)
=20
 			pr_debug(" -> imaplen=3D%d\n", imaplen);
 		}
-		if (!match)
+		if (!match) {
+			if (intc) {
+				/*
+				 * The PASEMI Nemo is a known offender, so
+				 * let's only warn for anyone else.
+				 */
+				WARN(!IS_ENABLED(CONFIG_PPC_PASEMI),
+				     "%pOF interrupt-map failed, using interrupt-controller\n",
+				     ipar);
+				return 0;
+			}
+
 			goto fail;
+		}
=20
 		/*
 		 * Successfully parsed an interrrupt-map translation; copy new
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 12e296d634eb..48e3f4e47b29 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc =
*desc, u32 clear, u32 s
 	raw_spinlock_t *lock =3D &desc->dev->msi_lock;
 	unsigned long flags;
=20
+	if (!desc->msi_attrib.can_mask)
+		return;
+
 	raw_spin_lock_irqsave(lock, flags);
 	desc->msi_mask &=3D ~clear;
 	desc->msi_mask |=3D set;
@@ -181,7 +184,8 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *d=
esc, u32 ctrl)
 {
 	void __iomem *desc_addr =3D pci_msix_desc_addr(desc);
=20
-	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	if (desc->msi_attrib.can_mask)
+		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
 static inline void pci_msix_mask(struct msi_desc *desc)
@@ -200,23 +204,17 @@ static inline void pci_msix_unmask(struct msi_desc *des=
c)
=20
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return;
-
 	if (desc->msi_attrib.is_msix)
 		pci_msix_mask(desc);
-	else if (desc->msi_attrib.maskbit)
+	else
 		pci_msi_mask(desc, mask);
 }
=20
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
-		return;
-
 	if (desc->msi_attrib.is_msix)
 		pci_msix_unmask(desc);
-	else if (desc->msi_attrib.maskbit)
+	else
 		pci_msi_unmask(desc, mask);
 }
=20
@@ -370,6 +368,11 @@ static void free_msi_irqs(struct pci_dev *dev)
 			for (i =3D 0; i < entry->nvec_used; i++)
 				BUG_ON(irq_has_action(entry->irq + i));
=20
+	if (dev->msi_irq_groups) {
+		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
+		dev->msi_irq_groups =3D NULL;
+	}
+
 	pci_msi_teardown_msi_irqs(dev);
=20
 	list_for_each_entry_safe(entry, tmp, msi_list, list) {
@@ -381,11 +384,6 @@ static void free_msi_irqs(struct pci_dev *dev)
 		list_del(&entry->list);
 		free_msi_entry(entry);
 	}
-
-	if (dev->msi_irq_groups) {
-		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
-		dev->msi_irq_groups =3D NULL;
-	}
 }
=20
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
@@ -479,12 +477,16 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct i=
rq_affinity *affd)
 		goto out;
=20
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	/* Lies, damned lies, and MSIs */
+	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
+		control |=3D PCI_MSI_FLAGS_MASKBIT;
=20
 	entry->msi_attrib.is_msix	=3D 0;
 	entry->msi_attrib.is_64		=3D !!(control & PCI_MSI_FLAGS_64BIT);
 	entry->msi_attrib.is_virtual    =3D 0;
 	entry->msi_attrib.entry_nr	=3D 0;
-	entry->msi_attrib.maskbit	=3D !!(control & PCI_MSI_FLAGS_MASKBIT);
+	entry->msi_attrib.can_mask	=3D !pci_msi_ignore_mask &&
+					  !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	=3D dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	=3D (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	=3D ilog2(__roundup_pow_of_two(nvec));
@@ -495,7 +497,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq=
_affinity *affd)
 		entry->mask_pos =3D dev->msi_cap + PCI_MSI_MASK_32;
=20
 	/* Save the initial mask status */
-	if (entry->msi_attrib.maskbit)
+	if (entry->msi_attrib.can_mask)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
=20
 out:
@@ -639,10 +641,13 @@ static int msix_setup_entries(struct pci_dev *dev, void=
 __iomem *base,
 		entry->msi_attrib.is_virtual =3D
 			entry->msi_attrib.entry_nr >=3D vec_count;
=20
+		entry->msi_attrib.can_mask	=3D !pci_msi_ignore_mask &&
+						  !entry->msi_attrib.is_virtual;
+
 		entry->msi_attrib.default_irq	=3D dev->irq;
 		entry->mask_base		=3D base;
=20
-		if (!entry->msi_attrib.is_virtual) {
+		if (entry->msi_attrib.can_mask) {
 			addr =3D pci_msix_desc_addr(entry);
 			entry->msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index aedb78c86ddc..003950c738d2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5851,3 +5851,9 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
+
+static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
+{
+	pdev->dev_flags |=3D PCI_DEV_FLAGS_HAS_MSI_MASKING;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 49cf6eb222e7..e616f94c7c58 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -148,7 +148,7 @@ struct msi_desc {
 				u8	is_msix		: 1;
 				u8	multiple	: 3;
 				u8	multi_cap	: 3;
-				u8	maskbit		: 1;
+				u8	can_mask	: 1;
 				u8	is_64		: 1;
 				u8	is_virtual	: 1;
 				u16	entry_nr;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c8afbee5da4b..d0dba7fd9848 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -233,6 +233,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET =3D (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING =3D (__force pci_dev_flags_t) (1 << 11),
+	/* Device does honor MSI masking despite saying otherwise */
+	PCI_DEV_FLAGS_HAS_MSI_MASKING =3D (__force pci_dev_flags_t) (1 << 12),
 };
=20
 enum pci_irq_reroute_variant {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6a5ecee6e567..7f350ae59c5f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -529,10 +529,10 @@ static bool msi_check_reservation_mode(struct irq_domai=
n *domain,
=20
 	/*
 	 * Checking the first MSI descriptor is sufficient. MSIX supports
-	 * masking and MSI does so when the maskbit is set.
+	 * masking and MSI does so when the can_mask attribute is set.
 	 */
 	desc =3D first_msi_entry(dev);
-	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
+	return desc->msi_attrib.is_msix || desc->msi_attrib.can_mask;
 }
=20
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,

