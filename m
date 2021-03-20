Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED1342DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCTPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:35:00 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:64103 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCTPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:34:50 -0400
Date:   Sat, 20 Mar 2021 15:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
        s=protonmail3; t=1616254486;
        bh=JTyt7legjbFhec6GFumJoMePKi1InCF9VN17NylsqRE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Nb8kmdt4B3a51am5iZsJpAi7WUIS++kbEc3Orbn+Moy2/MVoFvBQs0QlSzJtNV/+t
         l1br16fPNrPDXQfIicmG5rjfeVPVxJSIwmj1xLwP56PEmfb/0xeJlrrbNIb2EYeV0w
         YLfJuziguX5bA1WE4EnOHthTE5Vc5Udx9aVsdGCLQftHjivuryzwgRxxjxJliDIyv2
         D/GVvFswygnOKcgx1HhJ4uLxMp5mr/+yH7W6dAT405Eo2qdHzLda2n9mGqYW9ACirX
         jRaqMxCQmpRxA5oDDUWNuxaL9z8cg2N6GKC3H4yiBCR0FcNofYMRByUPhxI84hqTbm
         K9/zpawux33ow==
To:     iommu@lists.linux-foundation.org
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>
Reply-To: Sven Peter <sven@svenpeter.dev>
Subject: [PATCH 3/3] iommu: dart: Add DART iommu driver
Message-ID: <20210320153419.61311-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple's new SoCs use iommus for almost all peripherals. These Device
Address Resolution Tables must be setup before these peripherals can
act as DMA masters.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                      |   1 +
 drivers/iommu/Kconfig            |  13 +
 drivers/iommu/Makefile           |   1 +
 drivers/iommu/apple-dart-iommu.c | 653 +++++++++++++++++++++++++++++++
 4 files changed, 668 insertions(+)
 create mode 100644 drivers/iommu/apple-dart-iommu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f9a4f2de88b..7dcfce53dd04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1241,6 +1241,7 @@ M:=09Sven Peter <sven@svenpeter.dev>
 L:=09iommu@lists.linux-foundation.org
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
+F:=09drivers/iommu/apple-dart-iommu.c

 APPLE SMC DRIVER
 M:=09Henrik Rydberg <rydberg@bitmath.org>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3c95c8524abe..810bcb3ed414 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -262,6 +262,19 @@ config SPAPR_TCE_IOMMU
 =09  Enables bits of IOMMU API required by VFIO. The iommu_ops
 =09  is not implemented as it is not necessary for VFIO.

+config IOMMU_APPLE_DART
+=09tristate "Apple DART IOMMU Support"
+=09depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+=09select IOMMU_API
+=09select IOMMU_IO_PGTABLE_APPLE_DART
+=09help
+=09  Support for Apple DART (Device Address Resolution Table) IOMMUs
+=09  found in Apple ARM SoCs like the M1.
+=09  This IOMMU is required for most peripherals using DMA to access
+=09  the main memory.
+
+=09  Say Y here if you are using an Apple SoC with a DART IOMMU.
+
 # ARM IOMMU support
 config ARM_SMMU
 =09tristate "ARM Ltd. System MMU (SMMU) Support"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 61bd30cd8369..5f21f0dfec6a 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA_LIB) +=3D iommu-sva-lib.o
+obj-$(CONFIG_IOMMU_APPLE_DART) +=3D apple-dart-iommu.o
diff --git a/drivers/iommu/apple-dart-iommu.c b/drivers/iommu/apple-dart-io=
mmu.c
new file mode 100644
index 000000000000..a642dbc22281
--- /dev/null
+++ b/drivers/iommu/apple-dart-iommu.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple DART (Device Address Resolution Table) IOMMU driver
+ *
+ * Based on arm/arm-smmu/arm-ssmu.c and arm/arm-smmu-v3/arm-smmu-v3.c
+ *  Copyright (C) 2013 ARM Limited
+ *  Copyright (C) 2015 ARM Limited
+ *
+ * Copyright (C) 2021 The Asahi Linux Contributors
+ */
+
+#include <linux/dma-iommu.h>
+#include <linux/ratelimit.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/io-pgtable.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define DART_MAX_DEVICES 16
+#define DART_MAX_DOMAINS 16
+#define DART_MAX_TTBR 4
+
+#define DART_DOMAINS_ALL 0xffff
+
+#define DART_CONFIG 0x60
+#define DART_CONFIG_LOCK BIT(15)
+
+#define DART_ERROR 0x40
+#define DART_ERROR_DOMAIN_SHIFT 24
+#define DART_ERROR_DOMAIN_MASK 0xf
+#define DART_ERROR_CODE_MASK 0xffffff
+#define DART_ERROR_FLAG BIT(31)
+#define DART_ERROR_READ_FAULT BIT(4)
+#define DART_ERROR_WRITE_FAULT BIT(3)
+#define DART_ERROR_NO_PTE BIT(2)
+#define DART_ERROR_NO_PMD BIT(1)
+#define DART_ERROR_NO_PGD BIT(0)
+
+#define DART_DOMAIN_SELECT 0x34
+
+#define DART_DOMAIN_COMMAND 0x20
+#define DART_DOMAIN_COMMAND_BUSY BIT(2)
+#define DART_DOMAIN_COMMAND_INVALIDATE BIT(20)
+
+#define DART_DOMAIN_COMMAND_BUSY_TIMEOUT 100
+
+#define DART_DEVICE2DOMAIN_MAP 0x80
+
+#define DART_ERROR_ADDR_HI 0x54
+#define DART_ERROR_ADDR_LO 0x50
+
+#define DART_TCR(domain) (0x100 + 4 * (domain))
+#define DART_TCR_TRANSLATE_ENABLE BIT(7)
+#define DART_TCR_BYPASS_ENABLE BIT(8)
+
+#define DART_TTBR(domain, idx) (0x200 + 16 * (domain) + 4 * (idx))
+#define DART_TTBR_VALID BIT(31)
+#define DART_TTBR_SHIFT 12
+
+struct apple_dart_domain;
+
+struct apple_dart {
+=09struct device *dev;
+=09void __iomem *regs;
+
+=09int irq;
+=09struct clk_bulk_data *clks;
+=09int num_clks;
+
+=09struct iommu_device iommu;
+
+=09struct apple_dart_domain *domains[DART_MAX_DOMAINS];
+
+=09spinlock_t command_lock;
+=09struct mutex domain_mutex;
+};
+
+struct apple_dart_domain {
+=09struct apple_dart *dart;
+
+=09int domain_idx;
+
+=09struct io_pgtable_ops *pgtbl_ops;
+
+=09struct iommu_domain domain;
+};
+
+struct apple_dart_master {
+=09struct apple_dart *dart;
+=09u32 sid;
+};
+
+static struct platform_driver apple_dart_driver;
+static const struct iommu_ops apple_dart_iommu_ops;
+
+static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
+{
+=09return container_of(dom, struct apple_dart_domain, domain);
+}
+
+static void apple_dart_hw_enable_translation(struct apple_dart *dart,
+=09=09=09=09=09     u16 domain)
+{
+=09writel(DART_TCR_TRANSLATE_ENABLE, dart->regs + DART_TCR(domain));
+}
+
+static void apple_dart_hw_disable_translation(struct apple_dart *dart,
+=09=09=09=09=09      u16 domain)
+{
+=09writel(0, dart->regs + DART_TCR(domain));
+}
+
+static void apple_dart_hw_set_pgd(struct apple_dart *dart, u16 domain, u16=
 idx,
+=09=09=09=09  phys_addr_t paddr)
+{
+=09writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
+=09       dart->regs + DART_TTBR(domain, idx));
+}
+
+static void apple_dart_hw_clear_pgd(struct apple_dart *dart, u16 domain,
+=09=09=09=09    u16 idx)
+{
+=09writel(0, dart->regs + DART_TTBR(domain, idx));
+}
+
+static void apple_dart_hw_clear_all_pgds(struct apple_dart *dart, u16 doma=
in)
+{
+=09int i;
+
+=09for (i =3D 0; i < 4; ++i)
+=09=09apple_dart_hw_clear_pgd(dart, domain, i);
+}
+
+static int apple_dart_hw_domain_command(struct apple_dart *dart,
+=09=09=09=09=09u16 domain_bitmap, u32 command)
+{
+=09unsigned long flags;
+=09int ret;
+=09u32 command_reg;
+
+=09spin_lock_irqsave(&dart->command_lock, flags);
+=09writel(domain_bitmap, dart->regs + DART_DOMAIN_SELECT);
+=09writel(command, dart->regs + DART_DOMAIN_COMMAND);
+
+=09ret =3D readl_poll_timeout(dart->regs + DART_DOMAIN_COMMAND, command_re=
g,
+=09=09=09=09 !(command_reg & DART_DOMAIN_COMMAND_BUSY), 1,
+=09=09=09=09 DART_DOMAIN_COMMAND_BUSY_TIMEOUT);
+=09spin_unlock_irqrestore(&dart->command_lock, flags);
+
+=09if (ret) {
+=09=09dev_err(dart->dev,
+=09=09=09"Timeout while waiting for busy flag to be cleared after issuing =
command %08x for domains %x\n",
+=09=09=09command, domain_bitmap);
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+
+static int apple_dart_hw_invalidate_tlb_global(struct apple_dart *dart)
+{
+=09return apple_dart_hw_domain_command(dart, DART_DOMAINS_ALL,
+=09=09=09=09=09    DART_DOMAIN_COMMAND_INVALIDATE);
+}
+
+static int apple_dart_hw_invalidate_tlb_domain(struct apple_dart *dart,
+=09=09=09=09=09       u16 domain)
+{
+=09return apple_dart_hw_domain_command(dart, 1 << domain,
+=09=09=09=09=09    DART_DOMAIN_COMMAND_INVALIDATE);
+}
+
+static void apple_dart_hw_map_device_to_domain(struct apple_dart *dart,
+=09=09=09=09=09       u8 device, u8 domain)
+{
+=09u32 val;
+=09unsigned int reg =3D device / 4;
+=09unsigned int shift =3D 8 * (device % 4);
+=09unsigned int mask =3D 0xff << shift;
+
+=09val =3D readl(dart->regs + DART_DEVICE2DOMAIN_MAP + 4 * reg);
+=09val &=3D ~mask;
+=09val |=3D domain << shift;
+=09writel(val, dart->regs + DART_DEVICE2DOMAIN_MAP + 4 * reg);
+}
+
+static int apple_hw_dart_reset(struct apple_dart *dart)
+{
+=09int domain;
+=09u32 config;
+
+=09config =3D readl(dart->regs + DART_CONFIG);
+=09if (config & DART_CONFIG_LOCK) {
+=09=09dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
+=09=09=09config);
+=09=09return -EINVAL;
+=09}
+
+=09for (domain =3D 0; domain < DART_MAX_DOMAINS; ++domain) {
+=09=09apple_dart_hw_disable_translation(dart, domain);
+=09=09apple_dart_hw_clear_all_pgds(dart, domain);
+=09}
+
+=09/* restore identity device to domain map */
+=09for (domain =3D 0; domain < DART_MAX_DOMAINS; ++domain)
+=09=09apple_dart_hw_map_device_to_domain(dart, domain, domain);
+
+=09return apple_dart_hw_invalidate_tlb_global(dart);
+}
+
+static void apple_dart_tlb_flush_all(void *cookie)
+{
+=09struct apple_dart_domain *domain =3D cookie;
+
+=09apple_dart_hw_invalidate_tlb_domain(domain->dart, domain->domain_idx);
+}
+
+static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
+=09=09=09=09      size_t granule, void *cookie)
+{
+=09struct apple_dart_domain *domain =3D cookie;
+
+=09apple_dart_hw_invalidate_tlb_domain(domain->dart, domain->domain_idx);
+}
+
+static const struct iommu_flush_ops apple_dart_tlb_ops =3D {
+=09.tlb_flush_all =3D apple_dart_tlb_flush_all,
+=09.tlb_flush_walk =3D apple_dart_tlb_flush_walk,
+=09.tlb_add_page =3D NULL,
+};
+
+static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
+{
+=09struct apple_dart_domain *dart_domain;
+
+=09if (type !=3D IOMMU_DOMAIN_DMA && type !=3D IOMMU_DOMAIN_UNMANAGED)
+=09=09return NULL;
+
+=09dart_domain =3D kzalloc(sizeof(*dart_domain), GFP_KERNEL);
+=09if (!dart_domain)
+=09=09return NULL;
+
+=09dart_domain->domain_idx =3D -1;
+=09iommu_get_dma_cookie(&dart_domain->domain);
+
+=09return &dart_domain->domain;
+}
+
+static void apple_dart_domain_free(struct iommu_domain *domain)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct apple_dart *dart =3D dart_domain->dart;
+
+=09if (dart && dart_domain->domain_idx >=3D 0) {
+=09=09mutex_lock(&dart->domain_mutex);
+=09=09apple_dart_hw_clear_all_pgds(dart_domain->dart,
+=09=09=09=09=09     dart_domain->domain_idx);
+=09=09apple_dart_hw_disable_translation(dart_domain->dart,
+=09=09=09=09=09=09  dart_domain->domain_idx);
+
+=09=09apple_dart_hw_invalidate_tlb_domain(dart_domain->dart,
+=09=09=09=09=09=09    dart_domain->domain_idx);
+
+=09=09dart->domains[dart_domain->domain_idx] =3D NULL;
+
+=09=09mutex_unlock(&dart->domain_mutex);
+=09}
+
+=09kfree(dart_domain);
+}
+
+static struct apple_dart *apple_dart_get_by_fwnode(struct fwnode_handle *f=
wnode)
+{
+=09struct device *dev =3D
+=09=09driver_find_device_by_fwnode(&apple_dart_driver.driver, fwnode);
+=09put_device(dev);
+=09return dev ? dev_get_drvdata(dev) : NULL;
+}
+
+static int apple_dart_finalise_domain(struct iommu_domain *domain,
+=09=09=09=09      struct apple_dart_master *cfg)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct apple_dart *dart =3D dart_domain->dart;
+=09struct io_pgtable_cfg pgtbl_cfg;
+=09int i, ret;
+
+=09mutex_lock(&dart->domain_mutex);
+
+=09/* sanity check to ensure this domain isn't already initialized */
+=09if (WARN_ON(dart_domain->domain_idx >=3D 0)) {
+=09=09ret =3D -EINVAL;
+=09=09goto out;
+=09}
+
+=09dart_domain->domain_idx =3D cfg->sid;
+
+=09/* sanity check to ensure this index isn't already in use */
+=09if (WARN_ON(dart->domains[dart_domain->domain_idx] !=3D NULL)) {
+=09=09ret =3D -EINVAL;
+=09=09goto out;
+=09}
+=09dart->domains[dart_domain->domain_idx] =3D dart_domain;
+
+=09pgtbl_cfg =3D (struct io_pgtable_cfg){
+=09=09.pgsize_bitmap =3D SZ_16K,
+=09=09.ias =3D 32,
+=09=09.oas =3D 36,
+=09=09.coherent_walk =3D 1,
+=09=09.tlb =3D &apple_dart_tlb_ops,
+=09=09.iommu_dev =3D dart->dev,
+=09};
+
+=09dart_domain->pgtbl_ops =3D
+=09=09alloc_io_pgtable_ops(ARM_APPLE_DART, &pgtbl_cfg, domain);
+=09if (!dart_domain->pgtbl_ops) {
+=09=09ret =3D -ENOMEM;
+=09=09goto out_domain;
+=09}
+
+=09for (i =3D 0; i < 4; ++i) {
+=09=09apple_dart_hw_set_pgd(dart, dart_domain->domain_idx, i,
+=09=09=09=09      pgtbl_cfg.apple_dart_cfg.pgd[i]);
+=09}
+
+=09apple_dart_hw_enable_translation(dart, dart_domain->domain_idx);
+=09apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+
+=09domain->pgsize_bitmap =3D pgtbl_cfg.pgsize_bitmap;
+=09domain->geometry.aperture_end =3D (1UL << pgtbl_cfg.ias) - 1;
+=09domain->geometry.force_aperture =3D true;
+
+=09ret =3D 0;
+
+out_domain:
+=09if (ret)
+=09=09dart->domains[dart_domain->domain_idx] =3D NULL;
+out:
+=09mutex_unlock(&dart->domain_mutex);
+=09return ret;
+}
+
+static int apple_dart_attach_dev(struct iommu_domain *domain,
+=09=09=09=09 struct device *dev)
+{
+=09int ret;
+=09struct apple_dart_master *cfg =3D dev_iommu_priv_get(dev);
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+
+=09dart_domain->dart =3D cfg->dart;
+
+=09ret =3D apple_dart_finalise_domain(domain, cfg);
+=09if (ret)
+=09=09return ret;
+
+=09return 0;
+}
+
+static struct iommu_device *apple_dart_probe_device(struct device *dev)
+{
+=09struct apple_dart *dart =3D NULL;
+=09struct apple_dart_master *cfg =3D NULL;
+=09struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
+
+=09if (!fwspec || fwspec->ops !=3D &apple_dart_iommu_ops)
+=09=09return ERR_PTR(-ENODEV);
+
+=09dart =3D apple_dart_get_by_fwnode(fwspec->iommu_fwnode);
+=09if (!dart)
+=09=09return ERR_PTR(-ENODEV);
+
+=09cfg =3D kzalloc(offsetof(struct apple_dart_master, sid), GFP_KERNEL);
+=09if (!cfg)
+=09=09return ERR_PTR(-ENOMEM);
+
+=09cfg->dart =3D dart;
+=09cfg->sid =3D fwspec->ids[0];
+=09dev_iommu_priv_set(dev, cfg);
+
+=09device_link_add(dev, dart->dev,
+=09=09=09DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+=09return &dart->iommu;
+}
+
+static void apple_dart_release_device(struct device *dev)
+{
+=09struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
+
+=09if (!fwspec || fwspec->ops !=3D &apple_dart_iommu_ops)
+=09=09return;
+
+=09iommu_fwspec_free(dev);
+}
+
+static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args =
*args)
+{
+=09if (args->args_count !=3D 1) {
+=09=09dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
+=09=09=09args->args_count);
+=09=09return -EINVAL;
+=09}
+
+=09return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
+=09=09=09=09=09   dma_addr_t iova)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct io_pgtable_ops *ops =3D dart_domain->pgtbl_ops;
+
+=09if (!ops)
+=09=09return -ENODEV;
+
+=09return ops->iova_to_phys(ops, iova);
+}
+
+static int apple_dart_map(struct iommu_domain *domain, unsigned long iova,
+=09=09=09  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct io_pgtable_ops *ops =3D dart_domain->pgtbl_ops;
+
+=09if (!ops)
+=09=09return -ENODEV;
+
+=09return ops->map(ops, iova, paddr, size, prot, gfp);
+}
+
+static size_t apple_dart_unmap(struct iommu_domain *domain, unsigned long =
iova,
+=09=09=09       size_t size, struct iommu_iotlb_gather *gather)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct io_pgtable_ops *ops =3D dart_domain->pgtbl_ops;
+
+=09if (!ops)
+=09=09return 0;
+
+=09return ops->unmap(ops, iova, size, gather);
+}
+
+static void apple_dart_iotlb_sync(struct iommu_domain *domain,
+=09=09=09=09  struct iommu_iotlb_gather *gather)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct apple_dart *dart =3D dart_domain->dart;
+
+=09if (!dart)
+=09=09return;
+
+=09apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+}
+
+static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
+=09=09=09=09      unsigned long iova, size_t size)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct apple_dart *dart =3D dart_domain->dart;
+
+=09if (!dart)
+=09=09return;
+
+=09apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+}
+
+static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
+{
+=09struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
+=09struct apple_dart *dart =3D dart_domain->dart;
+
+=09if (!dart)
+=09=09return;
+
+=09apple_dart_hw_invalidate_tlb_domain(dart, dart_domain->domain_idx);
+}
+
+static struct iommu_group *apple_dart_device_group(struct device *dev)
+{
+=09/* once we have PCI support this needs to use pci_device_group conditio=
nally */
+=09return generic_device_group(dev);
+}
+
+static const struct iommu_ops apple_dart_iommu_ops =3D {
+=09.domain_alloc =3D apple_dart_domain_alloc,
+=09.domain_free =3D apple_dart_domain_free,
+=09.attach_dev =3D apple_dart_attach_dev,
+=09.map =3D apple_dart_map,
+=09.unmap =3D apple_dart_unmap,
+=09.flush_iotlb_all =3D apple_dart_flush_iotlb_all,
+=09.iotlb_sync =3D apple_dart_iotlb_sync,
+=09.iotlb_sync_map =3D apple_dart_iotlb_sync_map,
+=09.iova_to_phys =3D apple_dart_iova_to_phys,
+=09.probe_device =3D apple_dart_probe_device,
+=09.release_device =3D apple_dart_release_device,
+=09.device_group =3D apple_dart_device_group,
+=09.of_xlate =3D apple_dart_of_xlate,
+=09.pgsize_bitmap =3D SZ_16K,
+};
+
+static irqreturn_t apple_dart_irq(int irq, void *dev)
+{
+=09static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+=09=09=09=09      DEFAULT_RATELIMIT_BURST);
+=09struct apple_dart *dart =3D dev;
+=09const char *fault_name =3D NULL;
+=09u32 error =3D readl(dart->regs + DART_ERROR);
+=09u32 error_code =3D error & DART_ERROR_CODE_MASK;
+=09u32 addr_hi =3D readl(dart->regs + DART_ERROR_ADDR_HI);
+=09u32 addr_lo =3D readl(dart->regs + DART_ERROR_ADDR_LO);
+=09u8 domain_idx =3D
+=09=09(error >> DART_ERROR_DOMAIN_SHIFT) & DART_ERROR_DOMAIN_MASK;
+
+=09if (!(error & DART_ERROR_FLAG))
+=09=09return IRQ_NONE;
+
+=09if (error_code & DART_ERROR_READ_FAULT)
+=09=09fault_name =3D "READ FAULT";
+=09else if (error_code & DART_ERROR_WRITE_FAULT)
+=09=09fault_name =3D "WRITE FAULT";
+=09else if (error_code & DART_ERROR_NO_PTE)
+=09=09fault_name =3D "NO PTE FOR IOVA";
+=09else if (error_code & DART_ERROR_NO_PMD)
+=09=09fault_name =3D "NO PMD FOR IOVA";
+=09else if (error_code & DART_ERROR_NO_PGD)
+=09=09fault_name =3D "NO PGD FOR IOVA";
+
+=09if (WARN_ON(fault_name =3D=3D NULL))
+=09=09fault_name =3D "unknown";
+
+=09if (__ratelimit(&rs)) {
+=09=09dev_err(dart->dev,
+=09=09=09"Apple DART translation fault: error status %08x [domain:%d code:=
%x (%s)] at address 0x%08x%08x",
+=09=09=09error, domain_idx, error_code, fault_name, addr_hi,
+=09=09=09addr_lo);
+=09}
+
+=09writel(error, dart->regs + DART_ERROR);
+=09return IRQ_HANDLED;
+}
+
+static int apple_dart_probe(struct platform_device *pdev)
+{
+=09int ret;
+=09struct resource *res;
+=09resource_size_t ioaddr;
+=09struct apple_dart *dart;
+=09struct device *dev =3D &pdev->dev;
+
+=09dart =3D devm_kzalloc(dev, sizeof(*dart), GFP_KERNEL);
+=09if (!dart)
+=09=09return -ENOMEM;
+=09dart->dev =3D dev;
+=09spin_lock_init(&dart->command_lock);
+=09mutex_init(&dart->domain_mutex);
+
+=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (resource_size(res) < 0x4000) {
+=09=09dev_err(dev, "MMIO region too small (%pr)\n", res);
+=09=09return -EINVAL;
+=09}
+=09ioaddr =3D res->start;
+=09dart->regs =3D devm_ioremap_resource(dev, res);
+=09if (IS_ERR(dart->regs))
+=09=09return PTR_ERR(dart->regs);
+
+=09ret =3D devm_clk_bulk_get_all(dev, &dart->clks);
+=09if (ret < 0)
+=09=09return ret;
+=09dart->num_clks =3D ret;
+
+=09ret =3D clk_bulk_prepare_enable(dart->num_clks, dart->clks);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D apple_hw_dart_reset(dart);
+=09if (ret)
+=09=09return ret;
+
+=09dart->irq =3D platform_get_irq(pdev, 0);
+=09if (dart->irq < 0)
+=09=09return -ENODEV;
+
+=09ret =3D devm_request_irq(dart->dev, dart->irq, apple_dart_irq,
+=09=09=09       IRQF_SHARED, "apple-dart fault", dart);
+=09if (ret)
+=09=09return ret;
+
+=09platform_set_drvdata(pdev, dart);
+
+=09ret =3D iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s"=
,
+=09=09=09=09     dev_name(&pdev->dev));
+=09if (ret)
+=09=09return ret;
+
+=09iommu_device_set_ops(&dart->iommu, &apple_dart_iommu_ops);
+=09iommu_device_set_fwnode(&dart->iommu, dev->fwnode);
+
+=09ret =3D iommu_device_register(&dart->iommu);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D bus_set_iommu(dev->bus, &apple_dart_iommu_ops);
+=09if (ret)
+=09=09return ret;
+
+=09return 0;
+}
+
+static int apple_dart_remove(struct platform_device *pdev)
+{
+=09struct apple_dart *dart =3D platform_get_drvdata(pdev);
+
+=09iommu_device_unregister(&dart->iommu);
+=09iommu_device_sysfs_remove(&dart->iommu);
+
+=09clk_bulk_disable(dart->num_clks, dart->clks);
+=09clk_bulk_unprepare(dart->num_clks, dart->clks);
+
+=09return 0;
+}
+
+static void apple_dart_shutdown(struct platform_device *pdev)
+{
+=09apple_dart_remove(pdev);
+}
+
+static const struct of_device_id apple_dart_of_match[] =3D {
+=09{ .compatible =3D "apple,t8103-dart", .data =3D NULL },
+=09{},
+};
+MODULE_DEVICE_TABLE(of, apple_dart_of_match);
+
+static struct platform_driver apple_dart_driver =3D {
+=09.driver=09=3D {
+=09=09.name=09=09=09=3D "apple-dart",
+=09=09.of_match_table=09=09=3D apple_dart_of_match,
+=09},
+=09.probe=09=3D apple_dart_probe,
+=09.remove=09=3D apple_dart_remove,
+=09.shutdown =3D apple_dart_shutdown,
+};
+module_platform_driver(apple_dart_driver);
+
+MODULE_DESCRIPTION("IOMMU API for Apple's DART");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_LICENSE("GPL v2");
--
2.25.1


