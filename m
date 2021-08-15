Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1D3EC87A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhHOKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhHOKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:05:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED1C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 03:04:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629021880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9PH4/zEr9TGbK+cWctgapywqq9nnEd49Xf6VL9LNXaU=;
        b=uLzVonQzQhUXIo2npaPI2r+U8zSgk7KtDQL00udJqhLUlkS4ZXpSbFssScCqNHGQNk+bVC
        SqtsCABZ6AXgqgRWu1s3vOvQDFdXZPTbZZyYpFrbkeFWpBYX2aoHmrtmrnNqN2GRsdODq9
        hBE4Bz1BrNcFEKtj8jNhi7YaXgM4wcv1ZowcVYBVl7LSi14s9pJJ6xCwWtocsJ7J0O2QOb
        kGo1XM+gQF/4PAg4QehxvYSibAFHxIZn7VUkGzb79XVjVDc13UFMZo1jaI8mw6cm28wGMC
        zjd053HyFC4CpkG5TDngTpS32ZXfZUck9W1vbkAG9hY236w2FJ/un3/LlP+wOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629021880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9PH4/zEr9TGbK+cWctgapywqq9nnEd49Xf6VL9LNXaU=;
        b=9sJag45JcmHrtk9Fza6gUijIxND37QSBN1Hy2buyKYWVT9gJK+KF3WuGognX2zR/6ylaXU
        /O7tEjbwhQuqizBg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.14-rc6
Message-ID: <162902176346.639059.11984349744252166553.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Date:   Sun, 15 Aug 2021 12:04:40 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-08-15

up to:  7a3dc4f35bf8: driver core: Add missing kernel doc for device::msi_lock


A set of fixes for PCI/MSI and x86 interrupt startup:

 - Mask all MSI-X entries when enabling MSI-X otherwise stale unmasked
   entries stay around e.g. when a crashkernel is booted.

 - Enforce masking of a MSI-X table entry when updating it, which mandatory
   according to speification

 - Ensure that writes to MSI[-X} tables are flushed.

 - Prevent invalid bits being set in the MSI mask register

 - Properly serialize modifications to the mask cache and the mask register
   for multi-MSI.

 - Cure the violation of the affinity setting rules on X86 during interrupt
   startup which can cause lost and stale interrupts. Move the initial
   affinity setting ahead of actualy enabling the interrupt.

 - Ensure that MSI interrupts are completely torn down before freeing them
   in the error handling case.

 - Prevent an array out of bounds access in the irq timings code.

Thanks,

	tglx

------------------>
Ben Dai (1):
      genirq/timings: Prevent potential array overflow in __irq_timings_store()

Bixuan Cui (1):
      genirq/msi: Ensure deactivation on teardown

Thomas Gleixner (12):
      PCI/MSI: Enable and mask MSI-X early
      PCI/MSI: Mask all unused MSI-X entries
      PCI/MSI: Enforce that MSI-X table entry is masked for update
      PCI/MSI: Enforce MSI[X] entry updates to be visible
      PCI/MSI: Do not set invalid bits in MSI mask
      PCI/MSI: Correct misleading comments
      PCI/MSI: Use msi_mask_irq() in pci_msi_shutdown()
      PCI/MSI: Protect msi_desc::masked for multi-MSI
      genirq: Provide IRQCHIP_AFFINITY_PRE_STARTUP
      x86/ioapic: Force affinity setup before startup
      x86/msi: Force affinity setup before startup
      driver core: Add missing kernel doc for device::msi_lock


 arch/x86/kernel/apic/io_apic.c |   6 +-
 arch/x86/kernel/apic/msi.c     |  11 +++-
 arch/x86/kernel/hpet.c         |   2 +-
 drivers/base/core.c            |   1 +
 drivers/pci/msi.c              | 125 +++++++++++++++++++++++++----------------
 include/linux/device.h         |   2 +
 include/linux/irq.h            |   2 +
 include/linux/msi.h            |   2 +-
 kernel/irq/chip.c              |   5 +-
 kernel/irq/msi.c               |  13 +++--
 kernel/irq/timings.c           |   5 ++
 11 files changed, 113 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d5c691a3208b..39224e035e47 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1986,7 +1986,8 @@ static struct irq_chip ioapic_chip __read_mostly = {
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct irq_chip ioapic_ir_chip __read_mostly = {
@@ -1999,7 +2000,8 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static inline void init_IO_APIC_traps(void)
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 44ebe25e7703..dbacb9ec8843 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -58,11 +58,13 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 *   The quirk bit is not set in this case.
 	 * - The new vector is the same as the old vector
 	 * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
+	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
 	if (!irqd_msi_nomask_quirk(irqd) ||
 	    cfg->vector == old_cfg.vector ||
 	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
+	    !irqd_is_started(irqd) ||
 	    cfg->dest_apicid == old_cfg.dest_apicid) {
 		irq_msi_update_msg(irqd, cfg);
 		return ret;
@@ -150,7 +152,8 @@ static struct irq_chip pci_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	= msi_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
@@ -219,7 +222,8 @@ static struct irq_chip pci_msi_ir_controller = {
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct msi_domain_info pci_msi_ir_domain_info = {
@@ -273,7 +277,8 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int dmar_msi_init(struct irq_domain *domain,
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 08651a4e6aa0..42fc41dd0e1f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -508,7 +508,7 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 	.irq_set_affinity = msi_domain_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
 	.irq_write_msi_msg = hpet_msi_write_msg,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int hpet_msi_init(struct irq_domain *domain,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6360490a4a3..6c0ef9d55a34 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2837,6 +2837,7 @@ void device_initialize(struct device *dev)
 	device_pm_init(dev);
 	set_dev_node(dev, -1);
 #ifdef CONFIG_GENERIC_MSI_IRQ
+	raw_spin_lock_init(&dev->msi_lock);
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255c8515..e5e75331b415 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -143,24 +143,25 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
-	u32 mask_bits = desc->masked;
+	raw_spinlock_t *lock = &desc->dev->msi_lock;
+	unsigned long flags;
 
 	if (pci_msi_ignore_mask || !desc->msi_attrib.maskbit)
-		return 0;
+		return;
 
-	mask_bits &= ~mask;
-	mask_bits |= flag;
+	raw_spin_lock_irqsave(lock, flags);
+	desc->masked &= ~mask;
+	desc->masked |= flag;
 	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       mask_bits);
-
-	return mask_bits;
+			       desc->masked);
+	raw_spin_unlock_irqrestore(lock, flags);
 }
 
 static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 {
-	desc->masked = __pci_msi_desc_mask_irq(desc, mask, flag);
+	__pci_msi_desc_mask_irq(desc, mask, flag);
 }
 
 static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
@@ -289,13 +290,31 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
+		bool unmasked = !(entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
 		if (!base)
 			goto skip;
 
+		/*
+		 * The specification mandates that the entry is masked
+		 * when the message is modified:
+		 *
+		 * "If software changes the Address or Data value of an
+		 * entry while the entry is unmasked, the result is
+		 * undefined."
+		 */
+		if (unmasked)
+			__pci_msix_desc_mask_irq(entry, PCI_MSIX_ENTRY_CTRL_MASKBIT);
+
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+
+		if (unmasked)
+			__pci_msix_desc_mask_irq(entry, 0);
+
+		/* Ensure that the writes are visible in the device */
+		readl(base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		int pos = dev->msi_cap;
 		u16 msgctl;
@@ -316,6 +335,8 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 			pci_write_config_word(dev, pos + PCI_MSI_DATA_32,
 					      msg->data);
 		}
+		/* Ensure that the writes are visible in the device */
+		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 	}
 
 skip:
@@ -636,21 +657,21 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(entry, mask, 0);
 		free_msi_irqs(dev);
 		return ret;
 	}
 
 	ret = msi_verify_entries(dev);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(entry, mask, 0);
 		free_msi_irqs(dev);
 		return ret;
 	}
 
 	ret = populate_msi_sysfs(dev);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(entry, mask, 0);
 		free_msi_irqs(dev);
 		return ret;
 	}
@@ -691,6 +712,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 {
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
+	void __iomem *addr;
 	int ret, i;
 	int vec_count = pci_msix_vec_count(dev);
 
@@ -711,6 +733,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 
 		entry->msi_attrib.is_msix	= 1;
 		entry->msi_attrib.is_64		= 1;
+
 		if (entries)
 			entry->msi_attrib.entry_nr = entries[i].entry;
 		else
@@ -722,6 +745,10 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
+		addr = pci_msix_desc_addr(entry);
+		if (addr)
+			entry->masked = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)
 			curmsk++;
@@ -732,26 +759,25 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 	return ret;
 }
 
-static void msix_program_entries(struct pci_dev *dev,
-				 struct msix_entry *entries)
+static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
 {
 	struct msi_desc *entry;
-	int i = 0;
-	void __iomem *desc_addr;
 
 	for_each_pci_msi_entry(entry, dev) {
-		if (entries)
-			entries[i++].vector = entry->irq;
+		if (entries) {
+			entries->vector = entry->irq;
+			entries++;
+		}
+	}
+}
 
-		desc_addr = pci_msix_desc_addr(entry);
-		if (desc_addr)
-			entry->masked = readl(desc_addr +
-					      PCI_MSIX_ENTRY_VECTOR_CTRL);
-		else
-			entry->masked = 0;
+static void msix_mask_all(void __iomem *base, int tsize)
+{
+	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	int i;
 
-		msix_mask_irq(entry, 1);
-	}
+	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
+		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
 /**
@@ -768,22 +794,33 @@ static void msix_program_entries(struct pci_dev *dev,
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	int ret;
-	u16 control;
 	void __iomem *base;
+	int ret, tsize;
+	u16 control;
 
-	/* Ensure MSI-X is disabled while it is set up */
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	/*
+	 * Some devices require MSI-X to be enabled before the MSI-X
+	 * registers can be accessed.  Mask all the vectors to prevent
+	 * interrupts coming in before they're fully set up.
+	 */
+	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
+				    PCI_MSIX_FLAGS_ENABLE);
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
-	base = msix_map_region(dev, msix_table_size(control));
-	if (!base)
-		return -ENOMEM;
+	tsize = msix_table_size(control);
+	base = msix_map_region(dev, tsize);
+	if (!base) {
+		ret = -ENOMEM;
+		goto out_disable;
+	}
+
+	/* Ensure that all table entries are masked. */
+	msix_mask_all(base, tsize);
 
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
-		return ret;
+		goto out_disable;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
@@ -794,15 +831,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	if (ret)
 		goto out_free;
 
-	/*
-	 * Some devices require MSI-X to be enabled before we can touch the
-	 * MSI-X registers.  We need to mask all the vectors to prevent
-	 * interrupts coming in before they're fully set up.
-	 */
-	pci_msix_clear_and_set_ctrl(dev, 0,
-				PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
-
-	msix_program_entries(dev, entries);
+	msix_update_entries(dev, entries);
 
 	ret = populate_msi_sysfs(dev);
 	if (ret)
@@ -836,6 +865,9 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 out_free:
 	free_msi_irqs(dev);
 
+out_disable:
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+
 	return ret;
 }
 
@@ -930,8 +962,7 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
-	/* Keep cached state to be restored */
-	__pci_msi_desc_mask_irq(desc, mask, ~mask);
+	msi_mask_irq(desc, mask, 0);
 
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -1016,10 +1047,8 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	}
 
 	/* Return the device with MSI-X masked as initial states */
-	for_each_pci_msi_entry(entry, dev) {
-		/* Keep cached states to be restored */
+	for_each_pci_msi_entry(entry, dev)
 		__pci_msix_desc_mask_irq(entry, 1);
-	}
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
diff --git a/include/linux/device.h b/include/linux/device.h
index 59940f1744c1..65d84b67b024 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -407,6 +407,7 @@ struct dev_links_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
+ * @msi_lock:	Lock to protect MSI mask cache and mask register
  * @msi_list:	Hosts MSI descriptors
  * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
@@ -506,6 +507,7 @@ struct device {
 	struct dev_pin_info	*pins;
 #endif
 #ifdef CONFIG_GENERIC_MSI_IRQ
+	raw_spinlock_t		msi_lock;
 	struct list_head	msi_list;
 #endif
 #ifdef CONFIG_DMA_OPS
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8e9a9ae471a6..c8293c817646 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -569,6 +569,7 @@ struct irq_chip {
  * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
  * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
  *                                    in the suspend path if they are in disabled state
+ * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +582,7 @@ enum {
 	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
 	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
+	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
 };
 
 #include <linux/irqdesc.h>
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6aff469e511d..e8bdcb83172b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -233,7 +233,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 
 u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
-u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
+void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7f04c7d8296e..a98bcfc4be7b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -265,8 +265,11 @@ int irq_startup(struct irq_desc *desc, bool resend, bool force)
 	} else {
 		switch (__irq_startup_managed(desc, aff, force)) {
 		case IRQ_STARTUP_NORMAL:
+			if (d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP)
+				irq_setup_affinity(desc);
 			ret = __irq_startup(desc);
-			irq_setup_affinity(desc);
+			if (!(d->chip->flags & IRQCHIP_AFFINITY_PRE_STARTUP))
+				irq_setup_affinity(desc);
 			break;
 		case IRQ_STARTUP_MANAGED:
 			irq_do_set_affinity(d, aff, false);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e348b5..85df3ca03efe 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -476,11 +476,6 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return 0;
 
 cleanup:
-	for_each_msi_vector(desc, i, dev) {
-		irq_data = irq_domain_get_irq_data(domain, i);
-		if (irqd_is_activated(irq_data))
-			irq_domain_deactivate_irq(irq_data);
-	}
 	msi_domain_free_irqs(domain, dev);
 	return ret;
 }
@@ -505,7 +500,15 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
+	struct irq_data *irq_data;
 	struct msi_desc *desc;
+	int i;
+
+	for_each_msi_vector(desc, i, dev) {
+		irq_data = irq_domain_get_irq_data(domain, i);
+		if (irqd_is_activated(irq_data))
+			irq_domain_deactivate_irq(irq_data);
+	}
 
 	for_each_msi_entry(desc, dev) {
 		/*
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index d309d6fbf5bd..4d2a702d7aa9 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -453,6 +453,11 @@ static __always_inline void __irq_timings_store(int irq, struct irqt_stat *irqs,
 	 */
 	index = irq_timings_interval_index(interval);
 
+	if (index > PREDICTION_BUFFER_SIZE - 1) {
+		irqs->count = 0;
+		return;
+	}
+
 	/*
 	 * Store the index as an element of the pattern in another
 	 * circular array.

