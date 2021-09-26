Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE041881B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 12:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhIZKbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 06:31:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhIZKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:31:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632652206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N39VOfAksS8dpNmtvtpZ+/pIG6vp2RKmiWfbvcGjUHM=;
        b=Ht8LOFu2NGafIYqFG7XpZ7tjMQqcrnoVS9SJxS5l6uDnYG/sIgRX1LW4mh+NpaKJ7p3OZ6
        t4lnTIYVeDKvnq5ykoTppCdy1O5C0TTPyTZsU03sACgsh0uUUH+VbeBR6ADEcNdXt8ZT1L
        +OvDSaMyliNScN/KeLfE3RQPhIVgck6RcanPDlnMBzGlW1ultVR0p/MuDpJXIhWjtuZzKR
        xxKzzAwqIdpOrL2EMK4qpwsWoG7ndVeCMtcD1DihLFHH2JygnTWOT0TLlhMcNhZ9hhfcZm
        xqsP2mUuCqU/qxv6WCM+vRRstcrr/lxSU82CMhbSxLt4iCj+ukZty0EYtqsH8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632652206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N39VOfAksS8dpNmtvtpZ+/pIG6vp2RKmiWfbvcGjUHM=;
        b=CLsTyYdFAOpQnnT3bGKd5TQoub6NZkTd/sLV5YNsiWnFFPnCpoTD2dOA8GHrRM6QlM7TKm
        YdRJHrsegOtkKAAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.15-rc3
Message-ID: <163265189226.178609.9712455554034472888.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 26 Sep 2021 12:30:06 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-=
09-26

up to:  f9bfed3ad5b1: Merge tag 'irqchip-fixes-5.15-1' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of fixes for interrupt chip drivers:

 - Work around a bad GIC integration on a Renesas platform which can't
   handle byte-sized MMIO access

 - Plug a potential memory leak in the GICv4 driver

 - Fix a regression in the Armada 370-XP IPI code which was caused by
   issuing EOI instack of ACK.

 - A couple of small fixes here and there

Thanks,

	tglx

------------------>
Bixuan Cui (1):
      irqdomain: Change the type of 'size' in __irq_domain_add() to be consis=
tent

Geert Uytterhoeven (1):
      irqchip/renesas-rza1: Use semicolons instead of commas

Kaige Fu (1):
      irqchip/gic-v3-its: Fix potential VPE leak on error

Marc Zyngier (3):
      Documentation: Fix irq-domain.rst build warning
      irqchip/armada-370-xp: Fix ack/eoi breakage
      irqchip/gic: Work around broken Renesas integration

Randy Dunlap (2):
      irqchip/mbigen: Repair non-kernel-doc notation
      irqchip/goldfish-pic: Select GENERIC_IRQ_CHIP to fix build


 Documentation/core-api/irq/irq-domain.rst |  5 +--
 drivers/irqchip/Kconfig                   |  1 +
 drivers/irqchip/irq-armada-370-xp.c       |  4 +--
 drivers/irqchip/irq-gic-v3-its.c          |  2 +-
 drivers/irqchip/irq-gic.c                 | 52 +++++++++++++++++++++++++++++=
+-
 drivers/irqchip/irq-mbigen.c              |  6 ++--
 drivers/irqchip/irq-renesas-rza1.c        | 12 +++----
 include/linux/irqdomain.h                 |  2 +-
 kernel/irq/irqdomain.c                    |  2 +-
 9 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-a=
pi/irq/irq-domain.rst
index 6979b4af2c1f..9c0e8758037a 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -175,9 +175,10 @@ for IRQ numbers that are passed to struct device registr=
ations.  In that
 case the Linux IRQ numbers cannot be dynamically assigned and the legacy
 mapping should be used.
=20
-As the name implies, the *_legacy() functions are deprecated and only
+As the name implies, the \*_legacy() functions are deprecated and only
 exist to ease the support of ancient platforms. No new users should be
-added.
+added. Same goes for the \*_simple() functions when their use results
+in the legacy behaviour.
=20
 The legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d5924e9f766..aca7b595c4c7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -409,6 +409,7 @@ config MESON_IRQ_GPIO
 config GOLDFISH_PIC
        bool "Goldfish programmable interrupt controller"
        depends on MIPS && (GOLDFISH || COMPILE_TEST)
+       select GENERIC_IRQ_CHIP
        select IRQ_DOMAIN
        help
          Say yes here to enable Goldfish interrupt controller driver used
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 7557ab551295..53e0fb0562c1 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -359,16 +359,16 @@ static void armada_370_xp_ipi_send_mask(struct irq_data=
 *d,
 		ARMADA_370_XP_SW_TRIG_INT_OFFS);
 }
=20
-static void armada_370_xp_ipi_eoi(struct irq_data *d)
+static void armada_370_xp_ipi_ack(struct irq_data *d)
 {
 	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS=
);
 }
=20
 static struct irq_chip ipi_irqchip =3D {
 	.name		=3D "IPI",
+	.irq_ack	=3D armada_370_xp_ipi_ack,
 	.irq_mask	=3D armada_370_xp_ipi_mask,
 	.irq_unmask	=3D armada_370_xp_ipi_unmask,
-	.irq_eoi	=3D armada_370_xp_ipi_eoi,
 	.ipi_send_mask	=3D armada_370_xp_ipi_send_mask,
 };
=20
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 7f40dca8cda5..eb0882d15366 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4501,7 +4501,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
=20
 	if (err) {
 		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i - 1);
+			its_vpe_irq_domain_free(domain, virq, i);
=20
 		its_lpi_free(bitmap, base, nr_ids);
 		its_free_prop_table(vprop_page);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d329ec3d64d8..5f22c9d65e57 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -107,6 +107,8 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
=20
 #endif
=20
+static DEFINE_STATIC_KEY_FALSE(needs_rmw_access);
+
 /*
  * The GIC mapping of CPU interfaces does not necessarily match
  * the logical CPU numbering.  Let's use a mapping as returned
@@ -774,6 +776,25 @@ static int gic_pm_init(struct gic_chip_data *gic)
 #endif
=20
 #ifdef CONFIG_SMP
+static void rmw_writeb(u8 bval, void __iomem *addr)
+{
+	static DEFINE_RAW_SPINLOCK(rmw_lock);
+	unsigned long offset =3D (unsigned long)addr & 3UL;
+	unsigned long shift =3D offset * 8;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&rmw_lock, flags);
+
+	addr -=3D offset;
+	val =3D readl_relaxed(addr);
+	val &=3D ~GENMASK(shift + 7, shift);
+	val |=3D bval << shift;
+	writel_relaxed(val, addr);
+
+	raw_spin_unlock_irqrestore(&rmw_lock, flags);
+}
+
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_v=
al,
 			    bool force)
 {
@@ -788,7 +809,10 @@ static int gic_set_affinity(struct irq_data *d, const st=
ruct cpumask *mask_val,
 	if (cpu >=3D NR_GIC_CPU_IF || cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
-	writeb_relaxed(gic_cpu_map[cpu], reg);
+	if (static_branch_unlikely(&needs_rmw_access))
+		rmw_writeb(gic_cpu_map[cpu], reg);
+	else
+		writeb_relaxed(gic_cpu_map[cpu], reg);
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
 	return IRQ_SET_MASK_OK_DONE;
@@ -1375,6 +1399,30 @@ static bool gic_check_eoimode(struct device_node *node=
, void __iomem **base)
 	return true;
 }
=20
+static bool gic_enable_rmw_access(void *data)
+{
+	/*
+	 * The EMEV2 class of machines has a broken interconnect, and
+	 * locks up on accesses that are less than 32bit. So far, only
+	 * the affinity setting requires it.
+	 */
+	if (of_machine_is_compatible("renesas,emev2")) {
+		static_branch_enable(&needs_rmw_access);
+		return true;
+	}
+
+	return false;
+}
+
+static const struct gic_quirk gic_quirks[] =3D {
+	{
+		.desc		=3D "broken byte access",
+		.compatible	=3D "arm,pl390",
+		.init		=3D gic_enable_rmw_access,
+	},
+	{ },
+};
+
 static int gic_of_setup(struct gic_chip_data *gic, struct device_node *node)
 {
 	if (!gic || !node)
@@ -1391,6 +1439,8 @@ static int gic_of_setup(struct gic_chip_data *gic, stru=
ct device_node *node)
 	if (of_property_read_u32(node, "cpu-offset", &gic->percpu_offset))
 		gic->percpu_offset =3D 0;
=20
+	gic_enable_of_quirks(node, gic_quirks, gic);
+
 	return 0;
=20
 error:
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f565317a3da3..12df2162108e 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -25,7 +25,7 @@
 /* The maximum IRQ pin number of mbigen chip(start from 0) */
 #define MAXIMUM_IRQ_PIN_NUM		1407
=20
-/**
+/*
  * In mbigen vector register
  * bit[21:12]:	event id value
  * bit[11:0]:	device id
@@ -39,14 +39,14 @@
 /* offset of vector register in mbigen node */
 #define REG_MBIGEN_VEC_OFFSET		0x200
=20
-/**
+/*
  * offset of clear register in mbigen node
  * This register is used to clear the status
  * of interrupt
  */
 #define REG_MBIGEN_CLEAR_OFFSET		0xa000
=20
-/**
+/*
  * offset of interrupt type register
  * This register is used to configure interrupt
  * trigger type
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index b0d46ac42b89..72c06e883d1c 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -223,12 +223,12 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 		goto out_put_node;
 	}
=20
-	priv->chip.name =3D "rza1-irqc",
-	priv->chip.irq_mask =3D irq_chip_mask_parent,
-	priv->chip.irq_unmask =3D irq_chip_unmask_parent,
-	priv->chip.irq_eoi =3D rza1_irqc_eoi,
-	priv->chip.irq_retrigger =3D irq_chip_retrigger_hierarchy,
-	priv->chip.irq_set_type =3D rza1_irqc_set_type,
+	priv->chip.name =3D "rza1-irqc";
+	priv->chip.irq_mask =3D irq_chip_mask_parent;
+	priv->chip.irq_unmask =3D irq_chip_unmask_parent;
+	priv->chip.irq_eoi =3D rza1_irqc_eoi;
+	priv->chip.irq_retrigger =3D irq_chip_retrigger_hierarchy;
+	priv->chip.irq_set_type =3D rza1_irqc_set_type;
 	priv->chip.flags =3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
=20
 	priv->irq_domain =3D irq_domain_add_hierarchy(parent, 0, IRQC_NUM_IRQ,
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 23e4ee523576..9ee238ad29ce 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -251,7 +251,7 @@ static inline struct fwnode_handle *irq_domain_alloc_fwno=
de(phys_addr_t *pa)
 }
=20
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned i=
nt size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 19e83e9b723c..4d8fc65cf38f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
  * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
+struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned i=
nt size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data)

