Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FEF3FB406
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhH3Kp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbhH3Kpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33581C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:44:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=w8S0X0CIKCMrt5SR8yGEfDexLTVxKceQ6Z+5rweuKAg=;
        b=CPu0C4BThOgR69Naieru6C/OrEblsUu/6kexPGsf/NVTU6ILyOkuiozH2TvXC+zl87OHRD
        NgocyAExGxsDKzK1ibCxUIYpXfjnyQyml/v+FU2O/LXv0JLkvcFDEKbzB4aH0SwcmfAd73
        C7xdinQYW/xQGQifrF/i+peyfw4Tkn4DnHgUN/P1dqU33hO4xyEmZix5Ux6v79y8lWIoeb
        rJxN9HVoLs4P2Hz0EyaFeGyxP/3GRrgKYmyUk1i8SsqEqw1nks9BHMQp2aSEXTCtJF+cfD
        D3PjgqtLf9bdGEPjm3LPeff+zw8nNuz1RZnGqJtjykzAufN8SQRrWqoM0fqbsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=w8S0X0CIKCMrt5SR8yGEfDexLTVxKceQ6Z+5rweuKAg=;
        b=yGX9IUjBROv271CACm+6PpyoblJ81xy7HccJG29KMOrWMVAvMp9rZ1YhoetEmCDZC1RhP/
        gCGN8hDQEmR6J/Dg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:43 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2021-08=
-30

up to:  47fb0cfdb7a7: Merge tag 'irqchip-5.15' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/maz/arm-platforms into irq/core


Updates to the interrupt core and driver subsystems:

Core changes:

   - The usual set of small fixes and improvements all over the place, but no=
thing
     outstanding

MSI changes:

   - Further consolidation of the PCI/MSI interrupt chip code

   - Make MSI sysfs code independent of PCI/MSI and expose the MSI interrupts
     of platform devices in the same way as PCI exposes them.

Driver changes:

   - Support for ARM GICv3 EPPI partitions

   - Treewide conversion to generic_handle_domain_irq() for all chained
     interrupt controllers

   - Conversion to bitmap_zalloc() throughout the irq chip drivers

   - The usual set of small fixes and improvements


Thanks,

	tglx

------------------>
Andy Shevchenko (7):
      irqchip/partitions: Switch to bitmap_zalloc()
      irqchip/alpine-msi: Switch to bitmap_zalloc()
      irqchip/gic-v2m: Switch to bitmap_zalloc()
      irqchip/gic-v3: Switch to bitmap_zalloc()
      irqchip/ls-scfg-msi: Switch to devm_bitmap_zalloc()
      irqchip/mvebu-gicp: Switch to devm_bitmap_zalloc()
      irqchip/mvebu-odmi: Switch to bitmap_zalloc()

Baokun Li (1):
      genirq/matrix: Fix kernel doc warnings for irq_matrix_alloc_managed()

Barry Song (2):
      genirq/msi: Move MSI sysfs handling from PCI to MSI core
      platform-msi: Add ABI to show msi_irqs of platform devices

Chen-Yu Tsai (1):
      irqchip/gic-v3: Fix priority comparison when non-secure priorities are =
used

Cedric Le Goater (1):
      genirq: Improve "hwirq" output in /proc and /sys/

Gustavo A. R. Silva (1):
      genirq/generic_chip: Use struct_size() in kzalloc()

Huacai Chen (1):
      irqchip/loongson-pch-pic: Improve edge triggered interrupt support

James Morse (2):
      irqchip/gic-v3: Add __gic_get_ppi_index() to find the PPI number from h=
wirq
      irqchip/gic-v3: Fix selection of partition domain for EPPIs

Jianqun Xu (9):
      pinctrl/rockchip: always enable clock for gpio controller
      pinctrl/rockchip: separate struct rockchip_pin_bank to a head file
      pinctrl/rockchip: add pinctrl device to gpio bank struct
      dt-bindings: gpio: change items restriction of clock for rockchip,gpio-=
bank
      gpio/rockchip: add driver for rockchip gpio
      gpio/rockchip: use struct rockchip_gpio_regs for gpio controller
      gpio/rockchip: support next version gpio controller
      gpio/rockchip: drop irq_gc_lock/irq_gc_unlock for irq set type
      pinctrl/rockchip: drop the gpio related codes

Joel Savitz (1):
      genirq: Clarify documentation for request_threaded_irq()

Lee Jones (1):
      genirq/cpuhotplug: Demote debug printk to KERN_DEBUG

Marc Zyngier (14):
      Documentation: Update irq_domain.rst with new lookup APIs
      gpio: Bulk conversion to generic_handle_domain_irq()
      pinctrl: Bulk conversion to generic_handle_domain_irq()
      mfd: Bulk conversion to generic_handle_domain_irq()
      ARM: Bulk conversion to generic_handle_domain_irq()
      arc: Bulk conversion to generic_handle_domain_irq()
      mips: Bulk conversion to generic_handle_domain_irq()
      gpu: Bulk conversion to generic_handle_domain_irq()
      SH: Bulk conversion to generic_handle_domain_irq()
      xtensa: Bulk conversion to generic_handle_domain_irq()
      nios2: Bulk conversion to generic_handle_domain_irq()
      powerpc: Bulk conversion to generic_handle_domain_irq()
      EDAC/altera: Convert to generic_handle_domain_irq()
      irqchip/qcom-pdc: Trim unused levels of the interrupt hierarchy

Markus Schneider-Pargmann (1):
      irqchip/mtk-sysirq: Skip setting irq-wake

Maulik Shah (1):
      irqdomain: Export irq_domain_disconnect_hierarchy()

Randy Dunlap (1):
      genirq: Fix kernel-doc warnings in pm.c, msi.c and ipi.c

Sebastian Andrzej Siewior (1):
      genirq/affinity: Replace deprecated CPU-hotplug functions.

Sven Peter (1):
      irqchip/apple-aic: Fix irq_disable from within irq handlers

Tanner Love (1):
      genirq: Change force_irqthreads to a static key

Thomas Gleixner (9):
      s390/pci: Do not mask MSI[-X] entries on teardown
      PCI/MSI: Simplify msi_verify_entries()
      PCI/MSI: Rename msi_desc::masked
      PCI/MSI: Consolidate error handling in msi_capability_init()
      PCI/MSI: Deobfuscate virtual MSI-X
      PCI/MSI: Cleanup msi_mask()
      PCI/MSI: Provide a new set of mask and unmask functions
      PCI/MSI: Use new mask/unmask functions
      genirq: Fix kernel doc indentation

Zhen Lei (1):
      genirq/timings: Fix error return code in irq_timings_test_irqs()


 Documentation/ABI/testing/sysfs-bus-platform       |  14 +
 Documentation/core-api/irq/irq-domain.rst          |  28 +-
 .../bindings/gpio/rockchip,gpio-bank.yaml          |   5 +-
 arch/arc/kernel/mcip.c                             |   2 +-
 arch/arm/common/sa1111.c                           |  12 +-
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 |   6 +-
 arch/arm/mach-s3c/irq-s3c24xx.c                    |   5 +-
 arch/mips/ath25/ar2315.c                           |  14 +-
 arch/mips/ath25/ar5312.c                           |  13 +-
 arch/mips/lantiq/irq.c                             |   2 +-
 arch/mips/pci/pci-ar2315.c                         |   8 +-
 arch/mips/pci/pci-rt3883.c                         |   5 +-
 arch/mips/ralink/irq.c                             |   2 +-
 arch/mips/sgi-ip27/ip27-irq.c                      |  16 +-
 arch/mips/sgi-ip30/ip30-irq.c                      |   8 +-
 arch/nios2/kernel/irq.c                            |   4 +-
 arch/powerpc/platforms/4xx/uic.c                   |   4 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c     |  23 +-
 arch/powerpc/platforms/52xx/media5200.c            |   9 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |   7 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |   6 +-
 arch/powerpc/platforms/cell/interrupt.c            |   8 +-
 arch/powerpc/platforms/cell/spider-pic.c           |  11 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |  15 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c      |  11 +-
 arch/powerpc/sysdev/fsl_mpic_err.c                 |  11 +-
 arch/powerpc/sysdev/fsl_msi.c                      |  12 +-
 arch/s390/pci/pci_irq.c                            |   4 -
 arch/sh/boards/mach-se/7343/irq.c                  |   2 +-
 arch/sh/boards/mach-se/7722/irq.c                  |   2 +-
 arch/sh/boards/mach-x3proto/gpio.c                 |   2 +-
 arch/xtensa/kernel/irq.c                           |   4 +-
 block/blk-mq.c                                     |   2 +-
 drivers/base/platform-msi.c                        |  20 +-
 drivers/edac/altera_edac.c                         |   7 +-
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-104-dio-48e.c                    |   4 +-
 drivers/gpio/gpio-104-idi-48.c                     |   4 +-
 drivers/gpio/gpio-104-idio-16.c                    |   2 +-
 drivers/gpio/gpio-altera.c                         |  11 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   |   9 +-
 drivers/gpio/gpio-aspeed.c                         |   9 +-
 drivers/gpio/gpio-ath79.c                          |   7 +-
 drivers/gpio/gpio-bcm-kona.c                       |   6 +-
 drivers/gpio/gpio-brcmstb.c                        |   5 +-
 drivers/gpio/gpio-cadence.c                        |   2 +-
 drivers/gpio/gpio-davinci.c                        |   3 +-
 drivers/gpio/gpio-dln2.c                           |  22 +-
 drivers/gpio/gpio-em.c                             |   2 +-
 drivers/gpio/gpio-ep93xx.c                         |   8 +-
 drivers/gpio/gpio-ftgpio010.c                      |   3 +-
 drivers/gpio/gpio-hisi.c                           |   4 +-
 drivers/gpio/gpio-hlwd.c                           |   7 +-
 drivers/gpio/gpio-merrifield.c                     |   8 +-
 drivers/gpio/gpio-mpc8xxx.c                        |   2 +-
 drivers/gpio/gpio-mt7621.c                         |   4 +-
 drivers/gpio/gpio-mxc.c                            |   2 +-
 drivers/gpio/gpio-mxs.c                            |   2 +-
 drivers/gpio/gpio-omap.c                           |   3 +-
 drivers/gpio/gpio-pci-idio-16.c                    |   2 +-
 drivers/gpio/gpio-pcie-idio-24.c                   |   3 +-
 drivers/gpio/gpio-pl061.c                          |   4 +-
 drivers/gpio/gpio-pxa.c                            |   9 +-
 drivers/gpio/gpio-rcar.c                           |   4 +-
 drivers/gpio/gpio-rda.c                            |   8 +-
 drivers/gpio/gpio-realtek-otto.c                   |   7 +-
 drivers/gpio/gpio-rockchip.c                       | 771 +++++++++++++++++
 drivers/gpio/gpio-sch.c                            |   2 +-
 drivers/gpio/gpio-sodaville.c                      |   2 +-
 drivers/gpio/gpio-sprd.c                           |  12 +-
 drivers/gpio/gpio-tb10x.c                          |   2 +-
 drivers/gpio/gpio-tegra.c                          |   9 +-
 drivers/gpio/gpio-tegra186.c                       |   9 +-
 drivers/gpio/gpio-tqmx86.c                         |  10 +-
 drivers/gpio/gpio-vf610.c                          |   2 +-
 drivers/gpio/gpio-ws16c48.c                        |   4 +-
 drivers/gpio/gpio-xgs-iproc.c                      |   2 +-
 drivers/gpio/gpio-xilinx.c                         |   2 +-
 drivers/gpio/gpio-xlp.c                            |   3 +-
 drivers/gpio/gpio-zynq.c                           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |  15 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c          |   3 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |  11 +-
 drivers/irqchip/irq-alpine-msi.c                   |   6 +-
 drivers/irqchip/irq-apple-aic.c                    |   2 +-
 drivers/irqchip/irq-gic-v2m.c                      |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   6 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |   5 +-
 drivers/irqchip/irq-gic-v3.c                       |  84 +-
 drivers/irqchip/irq-loongson-pch-pic.c             |  19 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   5 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |   1 +
 drivers/irqchip/irq-mvebu-gicp.c                   |   4 +-
 drivers/irqchip/irq-mvebu-odmi.c                   |   5 +-
 drivers/irqchip/irq-partition-percpu.c             |   3 +-
 drivers/irqchip/qcom-pdc.c                         |  68 +-
 drivers/mfd/db8500-prcmu.c                         |   2 +-
 drivers/mfd/fsl-imx25-tsadc.c                      |   4 +-
 drivers/mfd/ioc3.c                                 |  10 +-
 drivers/mfd/qcom-pm8xxx.c                          |  10 +-
 drivers/pci/msi.c                                  | 304 +++----
 drivers/pinctrl/actions/pinctrl-owl.c              |   5 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   4 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c           |   3 +-
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c             |   3 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   7 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |   8 +-
 drivers/pinctrl/mediatek/mtk-eint.c                |   5 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |   2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   2 +-
 drivers/pinctrl/pinctrl-amd.c                      |   6 +-
 drivers/pinctrl/pinctrl-at91.c                     |   6 +-
 drivers/pinctrl/pinctrl-equilibrium.c              |   2 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   2 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   2 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |   3 +-
 drivers/pinctrl/pinctrl-oxnas.c                    |   2 +-
 drivers/pinctrl/pinctrl-pic32.c                    |   2 +-
 drivers/pinctrl/pinctrl-pistachio.c                |   2 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 909 +------------------=
--
 drivers/pinctrl/pinctrl-rockchip.h                 | 287 +++++++
 drivers/pinctrl/pinctrl-single.c                   |   4 +-
 drivers/pinctrl/pinctrl-st.c                       |   2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   4 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  15 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |  25 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  17 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             |   3 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   8 +-
 include/linux/interrupt.h                          |   8 +-
 include/linux/msi.h                                |  14 +-
 kernel/irq/affinity.c                              |   8 +-
 kernel/irq/cpuhotplug.c                            |   2 +-
 kernel/irq/generic-chip.c                          |  17 +-
 kernel/irq/ipi.c                                   |  32 +-
 kernel/irq/irqdesc.c                               |   2 +-
 kernel/irq/irqdomain.c                             |   1 +
 kernel/irq/manage.c                                |  19 +-
 kernel/irq/matrix.c                                |   3 +-
 kernel/irq/msi.c                                   | 153 +++-
 kernel/irq/pm.c                                    |   2 +-
 kernel/irq/proc.c                                  |   2 +-
 kernel/irq/timings.c                               |   2 +
 kernel/softirq.c                                   |   2 +-
 147 files changed, 1826 insertions(+), 1677 deletions(-)
 create mode 100644 drivers/gpio/gpio-rockchip.c
 create mode 100644 drivers/pinctrl/pinctrl-rockchip.h

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI=
/testing/sysfs-bus-platform
index 194ca700e962..ff30728595ef 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -28,3 +28,17 @@ Description:
 		value comes from an ACPI _PXM method or a similar firmware
 		source. Initial users for this file would be devices like
 		arm smmu which are populated by arm64 acpi_iort.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		The /sys/devices/.../msi_irqs directory contains a variable set
+		of files, with each file being named after a corresponding msi
+		irq vector allocated to that device.
+
+What:		/sys/bus/platform/devices/.../msi_irqs/<N>
+Date:		August 2021
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		This attribute will show "msi" if <N> is a valid msi irq
diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-a=
pi/irq/irq-domain.rst
index 53283b3729a1..6979b4af2c1f 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -55,8 +55,24 @@ exist then it will allocate a new Linux irq_desc, associat=
e it with
 the hwirq, and call the .map() callback so the driver can perform any
 required hardware setup.
=20
-When an interrupt is received, irq_find_mapping() function should
-be used to find the Linux IRQ number from the hwirq number.
+Once a mapping has been established, it can be retrieved or used via a
+variety of methods:
+
+- irq_resolve_mapping() returns a pointer to the irq_desc structure
+  for a given domain and hwirq number, and NULL if there was no
+  mapping.
+- irq_find_mapping() returns a Linux IRQ number for a given domain and
+  hwirq number, and 0 if there was no mapping
+- irq_linear_revmap() is now identical to irq_find_mapping(), and is
+  deprecated
+- generic_handle_domain_irq() handles an interrupt described by a
+  domain and a hwirq number
+- handle_domain_irq() does the same thing for root interrupt
+  controllers and deals with the set_irq_reg()/irq_enter() sequences
+  that most architecture requires
+
+Note that irq domain lookups must happen in contexts that are
+compatible with a RCU read-side critical section.
=20
 The irq_create_mapping() function must be called *atleast once*
 before any call to irq_find_mapping(), lest the descriptor will not
@@ -137,7 +153,9 @@ required.  Calling irq_create_direct_mapping() will alloc=
ate a Linux
 IRQ number and call the .map() callback so that driver can program the
 Linux IRQ number into the hardware.
=20
-Most drivers cannot use this mapping.
+Most drivers cannot use this mapping, and it is now gated on the
+CONFIG_IRQ_DOMAIN_NOMAP option. Please refrain from introducing new
+users of this API.
=20
 Legacy
 ------
@@ -157,6 +175,10 @@ for IRQ numbers that are passed to struct device registr=
ations.  In that
 case the Linux IRQ numbers cannot be dynamically assigned and the legacy
 mapping should be used.
=20
+As the name implies, the *_legacy() functions are deprecated and only
+exist to ease the support of ancient platforms. No new users should be
+added.
+
 The legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be
 calculated by adding a fixed offset to the hwirq number, and
diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b=
/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index d993e002cebe..0d62c28fb58d 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -22,7 +22,10 @@ properties:
     maxItems: 1
=20
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: APB interface clock source
+      - description: GPIO debounce reference clock source
=20
   gpio-controller: true
=20
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index abf9398cc333..f9fdb557c263 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -352,7 +352,7 @@ static void idu_cascade_isr(struct irq_desc *desc)
 	irq_hw_number_t idu_hwirq =3D core_hwirq - FIRST_EXT_IRQ;
=20
 	chained_irq_enter(core_chip, desc);
-	generic_handle_irq(irq_find_mapping(idu_domain, idu_hwirq));
+	generic_handle_domain_irq(idu_domain, idu_hwirq);
 	chained_irq_exit(core_chip, desc);
 }
=20
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index ff5e0d04cb89..d17083c3fe2d 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -196,14 +196,6 @@ static int sa1111_map_irq(struct sa1111 *sachip, irq_hw_=
number_t hwirq)
 	return irq_create_mapping(sachip->irqdomain, hwirq);
 }
=20
-static void sa1111_handle_irqdomain(struct irq_domain *irqdomain, int irq)
-{
-	struct irq_desc *d =3D irq_to_desc(irq_linear_revmap(irqdomain, irq));
-
-	if (d)
-		generic_handle_irq_desc(d);
-}
-
 /*
  * SA1111 interrupt support.  Since clearing an IRQ while there are
  * active IRQs causes the interrupt output to pulse, the upper levels
@@ -234,11 +226,11 @@ static void sa1111_irq_handler(struct irq_desc *desc)
=20
 	for (i =3D 0; stat0; i++, stat0 >>=3D 1)
 		if (stat0 & 1)
-			sa1111_handle_irqdomain(irqdomain, i);
+			generic_handle_domain_irq(irqdomain, i);
=20
 	for (i =3D 32; stat1; i++, stat1 >>=3D 1)
 		if (stat1 & 1)
-			sa1111_handle_irqdomain(irqdomain, i);
+			generic_handle_domain_irq(irqdomain, i);
=20
 	/* For level-based interrupts */
 	desc->irq_data.chip->irq_unmask(&desc->irq_data);
diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds=
_irqs.c
index bddfc7cd5d40..eda5a47d7fbb 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -39,10 +39,8 @@ static irqreturn_t cplds_irq_handler(int in_irq, void *d)
=20
 	do {
 		pending =3D readl(fpga->base + FPGA_IRQ_SET_CLR) & fpga->irq_mask;
-		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ) {
-			generic_handle_irq(irq_find_mapping(fpga->irqdomain,
-							    bit));
-		}
+		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ)
+			generic_handle_domain_irq(fpga->irqdomain, bit);
 	} while (pending);
=20
 	return IRQ_HANDLED;
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 0c631c14a817..3edc5f614eef 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -298,7 +298,7 @@ static void s3c_irq_demux(struct irq_desc *desc)
 	struct s3c_irq_data *irq_data =3D irq_desc_get_chip_data(desc);
 	struct s3c_irq_intc *intc =3D irq_data->intc;
 	struct s3c_irq_intc *sub_intc =3D irq_data->sub_intc;
-	unsigned int n, offset, irq;
+	unsigned int n, offset;
 	unsigned long src, msk;
=20
 	/* we're using individual domains for the non-dt case
@@ -318,8 +318,7 @@ static void s3c_irq_demux(struct irq_desc *desc)
 	while (src) {
 		n =3D __ffs(src);
 		src &=3D ~(1 << n);
-		irq =3D irq_find_mapping(sub_intc->domain, offset + n);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(sub_intc->domain, offset + n);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 9dbed7b5ea76..76e43a73ba1b 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -69,24 +69,24 @@ static void ar2315_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending =3D ar2315_rst_reg_read(AR2315_ISR) &
 		      ar2315_rst_reg_read(AR2315_IMR);
-	unsigned nr, misc_irq =3D 0;
+	unsigned nr;
+	int ret =3D 0;
=20
 	if (pending) {
 		struct irq_domain *domain =3D irq_desc_get_handler_data(desc);
=20
 		nr =3D __ffs(pending);
-		misc_irq =3D irq_find_mapping(domain, nr);
-	}
=20
-	if (misc_irq) {
 		if (nr =3D=3D AR2315_MISC_IRQ_GPIO)
 			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_GPIO);
 		else if (nr =3D=3D AR2315_MISC_IRQ_WATCHDOG)
 			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_WD);
-		generic_handle_irq(misc_irq);
-	} else {
-		spurious_interrupt();
+
+		ret =3D generic_handle_domain_irq(domain, nr);
 	}
+
+	if (!pending || ret)
+		spurious_interrupt();
 }
=20
 static void ar2315_misc_irq_unmask(struct irq_data *d)
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 23c879f4b734..822b639dbd1e 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -73,22 +73,21 @@ static void ar5312_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending =3D ar5312_rst_reg_read(AR5312_ISR) &
 		      ar5312_rst_reg_read(AR5312_IMR);
-	unsigned nr, misc_irq =3D 0;
+	unsigned nr;
+	int ret =3D 0;
=20
 	if (pending) {
 		struct irq_domain *domain =3D irq_desc_get_handler_data(desc);
=20
 		nr =3D __ffs(pending);
-		misc_irq =3D irq_find_mapping(domain, nr);
-	}
=20
-	if (misc_irq) {
-		generic_handle_irq(misc_irq);
+		ret =3D generic_handle_domain_irq(domain, nr);
 		if (nr =3D=3D AR5312_MISC_IRQ_TIMER)
 			ar5312_rst_reg_read(AR5312_TIMER);
-	} else {
-		spurious_interrupt();
 	}
+
+	if (!pending || ret)
+		spurious_interrupt();
 }
=20
 /* Enable the specified AR5312_MISC_IRQ interrupt */
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index acfbdc01b0ac..b732495f138a 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -300,7 +300,7 @@ static void ltq_hw_irq_handler(struct irq_desc *desc)
 	 */
 	irq =3D __fls(irq);
 	hwirq =3D irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module);
-	generic_handle_irq(irq_linear_revmap(ltq_domain, hwirq));
+	generic_handle_domain_irq(ltq_domain, hwirq);
=20
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
 	if (irq =3D=3D LTQ_ICU_EBU_IRQ && !module && LTQ_EBU_PCC_ISTAT !=3D 0)
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index c1a655aee599..9a4bfb4e63e3 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -337,14 +337,12 @@ static void ar2315_pci_irq_handler(struct irq_desc *des=
c)
 	struct ar2315_pci_ctrl *apc =3D irq_desc_get_handler_data(desc);
 	u32 pending =3D ar2315_pci_reg_read(apc, AR2315_PCI_ISR) &
 		      ar2315_pci_reg_read(apc, AR2315_PCI_IMR);
-	unsigned pci_irq =3D 0;
+	int ret =3D 0;
=20
 	if (pending)
-		pci_irq =3D irq_find_mapping(apc->domain, __ffs(pending));
+		ret =3D generic_handle_domain_irq(apc->domain, __ffs(pending));
=20
-	if (pci_irq)
-		generic_handle_irq(pci_irq);
-	else
+	if (!pending || ret)
 		spurious_interrupt();
 }
=20
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index c48e23cf5b5e..d3c947fa2969 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -140,10 +140,9 @@ static void rt3883_pci_irq_handler(struct irq_desc *desc)
 	}
=20
 	while (pending) {
-		unsigned irq, bit =3D __ffs(pending);
+		unsigned bit =3D __ffs(pending);
=20
-		irq =3D irq_find_mapping(rpc->irq_domain, bit);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(rpc->irq_domain, bit);
=20
 		pending &=3D ~BIT(bit);
 	}
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 220ca0cd7945..fa353bc13947 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -100,7 +100,7 @@ static void ralink_intc_irq_handler(struct irq_desc *desc)
=20
 	if (pending) {
 		struct irq_domain *domain =3D irq_desc_get_handler_data(desc);
-		generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+		generic_handle_domain_irq(domain, __ffs(pending));
 	} else {
 		spurious_interrupt();
 	}
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 95c1bff1ab9f..a0dd3bd2b81b 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -190,7 +190,7 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 	unsigned long *mask =3D per_cpu(irq_enable_mask, cpu);
 	struct irq_domain *domain;
 	u64 pend0;
-	int irq;
+	int ret;
=20
 	/* copied from Irix intpend0() */
 	pend0 =3D LOCAL_HUB_L(PI_INT_PEND0);
@@ -216,10 +216,8 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 #endif
 	{
 		domain =3D irq_desc_get_handler_data(desc);
-		irq =3D irq_linear_revmap(domain, __ffs(pend0));
-		if (irq)
-			generic_handle_irq(irq);
-		else
+		ret =3D generic_handle_domain_irq(domain, __ffs(pend0));
+		if (ret)
 			spurious_interrupt();
 	}
=20
@@ -232,7 +230,7 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 	unsigned long *mask =3D per_cpu(irq_enable_mask, cpu);
 	struct irq_domain *domain;
 	u64 pend1;
-	int irq;
+	int ret;
=20
 	/* copied from Irix intpend0() */
 	pend1 =3D LOCAL_HUB_L(PI_INT_PEND1);
@@ -242,10 +240,8 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 		return;
=20
 	domain =3D irq_desc_get_handler_data(desc);
-	irq =3D irq_linear_revmap(domain, __ffs(pend1) + 64);
-	if (irq)
-		generic_handle_irq(irq);
-	else
+	ret =3D generic_handle_domain_irq(domain, __ffs(pend1) + 64);
+	if (ret)
 		spurious_interrupt();
=20
 	LOCAL_HUB_L(PI_INT_PEND1);
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index ba87704073c8..423c32cb66ed 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -99,7 +99,7 @@ static void ip30_normal_irq(struct irq_desc *desc)
 	int cpu =3D smp_processor_id();
 	struct irq_domain *domain;
 	u64 pend, mask;
-	int irq;
+	int ret;
=20
 	pend =3D heart_read(&heart_regs->isr);
 	mask =3D (heart_read(&heart_regs->imr[cpu]) &
@@ -130,10 +130,8 @@ static void ip30_normal_irq(struct irq_desc *desc)
 #endif
 	{
 		domain =3D irq_desc_get_handler_data(desc);
-		irq =3D irq_linear_revmap(domain, __ffs(pend));
-		if (irq)
-			generic_handle_irq(irq);
-		else
+		ret =3D generic_handle_domain_irq(domain, __ffs(pend));
+		if (ret)
 			spurious_interrupt();
 	}
 }
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index c6a1a9f6ac42..6b7890e5f7af 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -19,11 +19,9 @@ static u32 ienable;
 asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *oldregs =3D set_irq_regs(regs);
-	int irq;
=20
 	irq_enter();
-	irq =3D irq_find_mapping(NULL, hwirq);
-	generic_handle_irq(irq);
+	generic_handle_domain_irq(NULL, hwirq);
 	irq_exit();
=20
 	set_irq_regs(oldregs);
diff --git a/arch/powerpc/platforms/4xx/uic.c b/arch/powerpc/platforms/4xx/ui=
c.c
index 36fb66ce54cf..89e2587b1a59 100644
--- a/arch/powerpc/platforms/4xx/uic.c
+++ b/arch/powerpc/platforms/4xx/uic.c
@@ -198,7 +198,6 @@ static void uic_irq_cascade(struct irq_desc *desc)
 	struct uic *uic =3D irq_desc_get_handler_data(desc);
 	u32 msr;
 	int src;
-	int subvirq;
=20
 	raw_spin_lock(&desc->lock);
 	if (irqd_is_level_type(idata))
@@ -213,8 +212,7 @@ static void uic_irq_cascade(struct irq_desc *desc)
=20
 	src =3D 32 - ffs(msr);
=20
-	subvirq =3D irq_linear_revmap(uic->irqhost, src);
-	generic_handle_irq(subvirq);
+	generic_handle_domain_irq(uic->irqhost, src);
=20
 uic_irq_ret:
 	raw_spin_lock(&desc->lock);
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/pl=
atforms/512x/mpc5121_ads_cpld.c
index b2981634f1f8..ea46870e5d6e 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -81,11 +81,10 @@ static struct irq_chip cpld_pic =3D {
 	.irq_unmask =3D cpld_unmask_irq,
 };
=20
-static int
+static unsigned int
 cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
 			    u8 __iomem *maskp)
 {
-	int cpld_irq;
 	u8 status =3D in_8(statusp);
 	u8 mask =3D in_8(maskp);
=20
@@ -93,28 +92,26 @@ cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statu=
sp,
 	status |=3D (ignore | mask);
=20
 	if (status =3D=3D 0xff)
-		return 0;
-
-	cpld_irq =3D ffz(status) + offset;
+		return ~0;
=20
-	return irq_linear_revmap(cpld_pic_host, cpld_irq);
+	return ffz(status) + offset;
 }
=20
 static void cpld_pic_cascade(struct irq_desc *desc)
 {
-	unsigned int irq;
+	unsigned int hwirq;
=20
-	irq =3D cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
+	hwirq =3D cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
-	if (irq) {
-		generic_handle_irq(irq);
+	if (hwirq !=3D ~0) {
+		generic_handle_domain_irq(cpld_pic_host, hwirq);
 		return;
 	}
=20
-	irq =3D cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
+	hwirq =3D cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
 		&cpld_regs->misc_mask);
-	if (irq) {
-		generic_handle_irq(irq);
+	if (hwirq !=3D ~0) {
+		generic_handle_domain_irq(cpld_pic_host, hwirq);
 		return;
 	}
 }
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms=
/52xx/media5200.c
index efb8bdecbcc7..110c444f4bc7 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -78,7 +78,7 @@ static struct irq_chip media5200_irq_chip =3D {
 static void media5200_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	int sub_virq, val;
+	int val;
 	u32 status, enable;
=20
 	/* Mask off the cascaded IRQ */
@@ -92,11 +92,10 @@ static void media5200_irq_cascade(struct irq_desc *desc)
 	enable =3D in_be32(media5200_irq.regs + MEDIA5200_IRQ_STATUS);
 	val =3D ffs((status & enable) >> MEDIA5200_IRQ_SHIFT);
 	if (val) {
-		sub_virq =3D irq_linear_revmap(media5200_irq.irqhost, val - 1);
-		/* pr_debug("%s: virq=3D%i s=3D%.8x e=3D%.8x hwirq=3D%i subvirq=3D%i\n",
-		 *          __func__, virq, status, enable, val - 1, sub_virq);
+		generic_handle_domain_irq(media5200_irq.irqhost, val - 1);
+		/* pr_debug("%s: virq=3D%i s=3D%.8x e=3D%.8x hwirq=3D%i\n",
+		 *          __func__, virq, status, enable, val - 1);
 		 */
-		generic_handle_irq(sub_virq);
 	}
=20
 	/* Processing done; can reenable the cascade now */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platfor=
ms/52xx/mpc52xx_gpt.c
index 3823df235f25..f862b48b4824 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -190,14 +190,11 @@ static struct irq_chip mpc52xx_gpt_irq_chip =3D {
 static void mpc52xx_gpt_irq_cascade(struct irq_desc *desc)
 {
 	struct mpc52xx_gpt_priv *gpt =3D irq_desc_get_handler_data(desc);
-	int sub_virq;
 	u32 status;
=20
 	status =3D in_be32(&gpt->regs->status) & MPC52xx_GPT_STATUS_IRQMASK;
-	if (status) {
-		sub_virq =3D irq_linear_revmap(gpt->irqhost, 0);
-		generic_handle_irq(sub_virq);
-	}
+	if (status)
+		generic_handle_domain_irq(gpt->irqhost, 0);
 }
=20
 static int mpc52xx_gpt_irq_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/plat=
forms/82xx/pq2ads-pci-pic.c
index f82f75a6085c..285bfe19b798 100644
--- a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -91,10 +91,8 @@ static void pq2ads_pci_irq_demux(struct irq_desc *desc)
 			break;
=20
 		for (bit =3D 0; pend !=3D 0; ++bit, pend <<=3D 1) {
-			if (pend & 0x80000000) {
-				int virq =3D irq_linear_revmap(priv->host, bit);
-				generic_handle_irq(virq);
-			}
+			if (pend & 0x80000000)
+				generic_handle_domain_irq(priv->host, bit);
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms=
/cell/interrupt.c
index c0ab62ba6f16..0873a7a20271 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -106,13 +106,9 @@ static void iic_ioexc_cascade(struct irq_desc *desc)
 			out_be64(&node_iic->iic_is, ack);
 		/* handle them */
 		for (cascade =3D 63; cascade >=3D 0; cascade--)
-			if (bits & (0x8000000000000000UL >> cascade)) {
-				unsigned int cirq =3D
-					irq_linear_revmap(iic_host,
+			if (bits & (0x8000000000000000UL >> cascade))
+				generic_handle_domain_irq(iic_host,
 							  base | cascade);
-				if (cirq)
-					generic_handle_irq(cirq);
-			}
 		/* post-ack level interrupts */
 		ack =3D bits & ~IIC_ISR_EDGE_MASK;
 		if (ack)
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platform=
s/cell/spider-pic.c
index 210785f59271..8af75867cb42 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -190,16 +190,11 @@ static void spider_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct spider_pic *pic =3D irq_desc_get_handler_data(desc);
-	unsigned int cs, virq;
+	unsigned int cs;
=20
 	cs =3D in_be32(pic->regs + TIR_CS) >> 24;
-	if (cs =3D=3D SPIDER_IRQ_INVALID)
-		virq =3D 0;
-	else
-		virq =3D irq_linear_revmap(pic->host, cs);
-
-	if (virq)
-		generic_handle_irq(virq);
+	if (cs !=3D SPIDER_IRQ_INVALID)
+		generic_handle_domain_irq(pic->host, cs);
=20
 	chip->irq_eoi(&desc->irq_data);
 }
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/pla=
tforms/embedded6xx/hlwd-pic.c
index a1b7f79a8a15..15396333a90b 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -108,7 +108,6 @@ static const struct irq_domain_ops hlwd_irq_domain_ops =
=3D {
 static unsigned int __hlwd_pic_get_irq(struct irq_domain *h)
 {
 	void __iomem *io_base =3D h->host_data;
-	int irq;
 	u32 irq_status;
=20
 	irq_status =3D in_be32(io_base + HW_BROADWAY_ICR) &
@@ -116,23 +115,22 @@ static unsigned int __hlwd_pic_get_irq(struct irq_domai=
n *h)
 	if (irq_status =3D=3D 0)
 		return 0;	/* no more IRQs pending */
=20
-	irq =3D __ffs(irq_status);
-	return irq_linear_revmap(h, irq);
+	return __ffs(irq_status);
 }
=20
 static void hlwd_pic_irq_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct irq_domain *irq_domain =3D irq_desc_get_handler_data(desc);
-	unsigned int virq;
+	unsigned int hwirq;
=20
 	raw_spin_lock(&desc->lock);
 	chip->irq_mask(&desc->irq_data); /* IRQ_LEVEL */
 	raw_spin_unlock(&desc->lock);
=20
-	virq =3D __hlwd_pic_get_irq(irq_domain);
-	if (virq)
-		generic_handle_irq(virq);
+	hwirq =3D __hlwd_pic_get_irq(irq_domain);
+	if (hwirq)
+		generic_handle_domain_irq(irq_domain, hwirq);
 	else
 		pr_err("spurious interrupt!\n");
=20
@@ -190,7 +188,8 @@ static struct irq_domain *hlwd_pic_init(struct device_nod=
e *np)
=20
 unsigned int hlwd_pic_get_irq(void)
 {
-	return __hlwd_pic_get_irq(hlwd_irq_host);
+	unsigned int hwirq =3D __hlwd_pic_get_irq(hlwd_irq_host);
+	return hwirq ? irq_linear_revmap(hlwd_irq_host, hwirq) : 0;
 }
=20
 /*
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/pla=
tforms/powernv/opal-irqchip.c
index c164419e254d..d55652b5f6fa 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -46,18 +46,15 @@ void opal_handle_events(void)
 	e =3D READ_ONCE(last_outstanding_events) & opal_event_irqchip.mask;
 again:
 	while (e) {
-		int virq, hwirq;
+		int hwirq;
=20
 		hwirq =3D fls64(e) - 1;
 		e &=3D ~BIT_ULL(hwirq);
=20
 		local_irq_disable();
-		virq =3D irq_find_mapping(opal_event_irqchip.domain, hwirq);
-		if (virq) {
-			irq_enter();
-			generic_handle_irq(virq);
-			irq_exit();
-		}
+		irq_enter();
+		generic_handle_domain_irq(opal_event_irqchip.domain, hwirq);
+		irq_exit();
 		local_irq_enable();
=20
 		cond_resched();
diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpi=
c_err.c
index 5fa5fa215541..9a98bb212922 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -99,7 +99,6 @@ static irqreturn_t fsl_error_int_handler(int irq, void *dat=
a)
 	struct mpic *mpic =3D (struct mpic *) data;
 	u32 eisr, eimr;
 	int errint;
-	unsigned int cascade_irq;
=20
 	eisr =3D mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EISR);
 	eimr =3D mpic_fsl_err_read(mpic->err_regs, MPIC_ERR_INT_EIMR);
@@ -108,13 +107,11 @@ static irqreturn_t fsl_error_int_handler(int irq, void =
*data)
 		return IRQ_NONE;
=20
 	while (eisr) {
+		int ret;
 		errint =3D __builtin_clz(eisr);
-		cascade_irq =3D irq_linear_revmap(mpic->irqhost,
-				 mpic->err_int_vecs[errint]);
-		WARN_ON(!cascade_irq);
-		if (cascade_irq) {
-			generic_handle_irq(cascade_irq);
-		} else {
+		ret =3D generic_handle_domain_irq(mpic->irqhost,
+						mpic->err_int_vecs[errint]);
+		if (WARN_ON(ret)) {
 			eimr |=3D  1 << (31 - errint);
 			mpic_fsl_err_write(mpic->err_regs, eimr);
 		}
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 808e7118abfc..e6b06c3f8197 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -266,7 +266,6 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int n=
vec, int type)
=20
 static irqreturn_t fsl_msi_cascade(int irq, void *data)
 {
-	unsigned int cascade_irq;
 	struct fsl_msi *msi_data;
 	int msir_index =3D -1;
 	u32 msir_value =3D 0;
@@ -279,9 +278,6 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
=20
 	msir_index =3D cascade_data->index;
=20
-	if (msir_index >=3D NR_MSI_REG_MAX)
-		cascade_irq =3D 0;
-
 	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
 		msir_value =3D fsl_msi_read(msi_data->msi_regs,
@@ -305,15 +301,15 @@ static irqreturn_t fsl_msi_cascade(int irq, void *data)
 	}
=20
 	while (msir_value) {
+		int err;
 		intr_index =3D ffs(msir_value) - 1;
=20
-		cascade_irq =3D irq_linear_revmap(msi_data->irqhost,
+		err =3D generic_handle_domain_irq(msi_data->irqhost,
 				msi_hwirq(msi_data, msir_index,
 					  intr_index + have_shift));
-		if (cascade_irq) {
-			generic_handle_irq(cascade_irq);
+		if (!err)
 			ret =3D IRQ_HANDLED;
-		}
+
 		have_shift +=3D intr_index + 1;
 		msir_value =3D msir_value >> (intr_index + 1);
 	}
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 9c7de9089939..3823e159bf74 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -365,10 +365,6 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	for_each_pci_msi_entry(msi, pdev) {
 		if (!msi->irq)
 			continue;
-		if (msi->msi_attrib.is_msix)
-			__pci_msix_desc_mask_irq(msi, 1);
-		else
-			__pci_msi_desc_mask_irq(msi, 1, 1);
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo =3D 0;
diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/=
irq.c
index 1aedbfe32654..f9f3b14f70d5 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -38,7 +38,7 @@ static void se7343_irq_demux(struct irq_desc *desc)
 	mask =3D ioread16(se7343_irq_regs + PA_CPLD_ST_REG);
=20
 	for_each_set_bit(bit, &mask, SE7343_FPGA_IRQ_NR)
-		generic_handle_irq(irq_linear_revmap(se7343_irq_domain, bit));
+		generic_handle_domain_irq(se7343_irq_domain, bit);
=20
 	chip->irq_unmask(data);
 }
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/=
irq.c
index 6d34592767f8..efa96edd47dc 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -37,7 +37,7 @@ static void se7722_irq_demux(struct irq_desc *desc)
 	mask =3D ioread16(se7722_irq_regs + IRQ01_STS_REG);
=20
 	for_each_set_bit(bit, &mask, SE7722_FPGA_IRQ_NR)
-		generic_handle_irq(irq_linear_revmap(se7722_irq_domain, bit));
+		generic_handle_domain_irq(se7722_irq_domain, bit);
=20
 	chip->irq_unmask(data);
 }
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto=
/gpio.c
index efc992f641a6..f82d3a6a844a 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -68,7 +68,7 @@ static void x3proto_gpio_irq_handler(struct irq_desc *desc)
=20
 	mask =3D __raw_readw(KEYDETR);
 	for_each_set_bit(pin, &mask, NR_BASEBOARD_GPIOS)
-		generic_handle_irq(irq_linear_revmap(x3proto_irq_domain, pin));
+		generic_handle_domain_irq(x3proto_irq_domain, pin);
=20
 	chip->irq_unmask(data);
 }
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index a48bf2d10ac2..764b54bef701 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -33,8 +33,6 @@ DECLARE_PER_CPU(unsigned long, nmi_count);
=20
 asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 {
-	int irq =3D irq_find_mapping(NULL, hwirq);
-
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
@@ -48,7 +46,7 @@ asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 			       sp - sizeof(struct thread_info));
 	}
 #endif
-	generic_handle_irq(irq);
+	generic_handle_domain_irq(NULL, hwirq);
 }
=20
 int arch_show_interrupts(struct seq_file *p, int prec)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..572d8ab34014 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -606,7 +606,7 @@ static inline bool blk_mq_complete_need_ipi(struct reques=
t *rq)
 	 * This is probably worse than completing the request on a different
 	 * cache domain.
 	 */
-	if (force_irqthreads)
+	if (force_irqthreads())
 		return false;
=20
 	/* same CPU or cache domain?  Complete locally */
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0b72b134a304..3d6c8f9caf43 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -21,11 +21,12 @@
  * and the callback to write the MSI message.
  */
 struct platform_msi_priv_data {
-	struct device		*dev;
-	void 			*host_data;
-	msi_alloc_info_t	arg;
-	irq_write_msi_msg_t	write_msg;
-	int			devid;
+	struct device			*dev;
+	void				*host_data;
+	const struct attribute_group    **msi_irq_groups;
+	msi_alloc_info_t		arg;
+	irq_write_msi_msg_t		write_msg;
+	int				devid;
 };
=20
 /* The devid allocator */
@@ -272,8 +273,16 @@ int platform_msi_domain_alloc_irqs(struct device *dev, u=
nsigned int nvec,
 	if (err)
 		goto out_free_desc;
=20
+	priv_data->msi_irq_groups =3D msi_populate_sysfs(dev);
+	if (IS_ERR(priv_data->msi_irq_groups)) {
+		err =3D PTR_ERR(priv_data->msi_irq_groups);
+		goto out_free_irqs;
+	}
+
 	return 0;
=20
+out_free_irqs:
+	msi_domain_free_irqs(dev->msi_domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -293,6 +302,7 @@ void platform_msi_domain_free_irqs(struct device *dev)
 		struct msi_desc *desc;
=20
 		desc =3D first_msi_entry(dev);
+		msi_destroy_sysfs(dev, desc->platform.msi_priv_data->msi_irq_groups);
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
=20
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 61c21bd880a4..2eb1d855c288 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1804,11 +1804,8 @@ static void altr_edac_a10_irq_handler(struct irq_desc =
*desc)
 	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
=20
 	bits =3D irq_status;
-	for_each_set_bit(bit, &bits, 32) {
-		irq =3D irq_linear_revmap(edac->domain, dberr * 32 + bit);
-		if (irq)
-			generic_handle_irq(irq);
-	}
+	for_each_set_bit(bit, &bits, 32)
+		generic_handle_domain_irq(edac->domain, dberr * 32 + bit);
=20
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fab571016adf..81abd890b364 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -520,6 +520,14 @@ config GPIO_REG
 	  A 32-bit single register GPIO fixed in/out implementation.  This
 	  can be used to represent any register as a set of GPIO signals.
=20
+config GPIO_ROCKCHIP
+	tristate "Rockchip GPIO support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	default ARCH_ROCKCHIP
+	help
+	  Say yes here to support GPIO on Rockchip SoCs.
+
 config GPIO_SAMA5D2_PIOBU
 	tristate "SAMA5D2 PIOBU GPIO support"
 	depends on MFD_SYSCON
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 32a32659866a..5243e2d1c207 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_GPIO_RDA)			+=3D gpio-rda.o
 obj-$(CONFIG_GPIO_RDC321X)		+=3D gpio-rdc321x.o
 obj-$(CONFIG_GPIO_REALTEK_OTTO)		+=3D gpio-realtek-otto.o
 obj-$(CONFIG_GPIO_REG)			+=3D gpio-reg.o
+obj-$(CONFIG_GPIO_ROCKCHIP)	+=3D gpio-rockchip.o
 obj-$(CONFIG_ARCH_SA1100)		+=3D gpio-sa1100.o
 obj-$(CONFIG_GPIO_SAMA5D2_PIOBU)	+=3D gpio-sama5d2-piobu.o
 obj-$(CONFIG_GPIO_SCH311X)		+=3D gpio-sch311x.o
diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 71c0bea34d7b..6bf41040c41f 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -336,8 +336,8 @@ static irqreturn_t dio48e_irq_handler(int irq, void *dev_=
id)
 	unsigned long gpio;
=20
 	for_each_set_bit(gpio, &irq_mask, 2)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain,
-			19 + gpio*24));
+		generic_handle_domain_irq(chip->irq.domain,
+					  19 + gpio*24);
=20
 	raw_spin_lock(&dio48egpio->lock);
=20
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index b132afaf7d99..34be7dd9f5b9 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -223,8 +223,8 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_=
id)
 		for_each_set_bit(bit_num, &irq_mask, 8) {
 			gpio =3D bit_num + boundary * 8;
=20
-			generic_handle_irq(irq_find_mapping(chip->irq.domain,
-				gpio));
+			generic_handle_domain_irq(chip->irq.domain,
+						  gpio);
 		}
 	}
=20
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 55b40299ebfa..c68ed1a135fa 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -208,7 +208,7 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev=
_id)
 	int gpio;
=20
 	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, gpio));
+		generic_handle_domain_irq(chip->irq.domain, gpio);
=20
 	raw_spin_lock(&idio16gpio->lock);
=20
diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index b7932ecc3b61..b59fae993626 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -201,9 +201,8 @@ static void altera_gpio_irq_edge_handler(struct irq_desc =
*desc)
 	      (readl(mm_gc->regs + ALTERA_GPIO_EDGE_CAP) &
 	      readl(mm_gc->regs + ALTERA_GPIO_IRQ_MASK)))) {
 		writel(status, mm_gc->regs + ALTERA_GPIO_EDGE_CAP);
-		for_each_set_bit(i, &status, mm_gc->gc.ngpio) {
-			generic_handle_irq(irq_find_mapping(irqdomain, i));
-		}
+		for_each_set_bit(i, &status, mm_gc->gc.ngpio)
+			generic_handle_domain_irq(irqdomain, i);
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -228,9 +227,9 @@ static void altera_gpio_irq_leveL_high_handler(struct irq=
_desc *desc)
 	status =3D readl(mm_gc->regs + ALTERA_GPIO_DATA);
 	status &=3D readl(mm_gc->regs + ALTERA_GPIO_IRQ_MASK);
=20
-	for_each_set_bit(i, &status, mm_gc->gc.ngpio) {
-		generic_handle_irq(irq_find_mapping(irqdomain, i));
-	}
+	for_each_set_bit(i, &status, mm_gc->gc.ngpio)
+		generic_handle_domain_irq(irqdomain, i);
+
 	chained_irq_exit(chip, desc);
 }
=20
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpi=
o.c
index 64e54f8c30d2..a99ece15db95 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -392,7 +392,7 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *des=
c)
 	struct gpio_chip *gc =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *ic =3D irq_desc_get_chip(desc);
 	struct aspeed_sgpio *data =3D gpiochip_get_data(gc);
-	unsigned int i, p, girq;
+	unsigned int i, p;
 	unsigned long reg;
=20
 	chained_irq_enter(ic, desc);
@@ -402,11 +402,8 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *de=
sc)
=20
 		reg =3D ioread32(bank_reg(data, bank, reg_irq_status));
=20
-		for_each_set_bit(p, &reg, 32) {
-			girq =3D irq_find_mapping(gc->irq.domain, i * 32 + p);
-			generic_handle_irq(girq);
-		}
-
+		for_each_set_bit(p, &reg, 32)
+			generic_handle_domain_irq(gc->irq.domain, i * 32 + p);
 	}
=20
 	chained_irq_exit(ic, desc);
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index b966f5e28ebf..3c8f20c57695 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -661,7 +661,7 @@ static void aspeed_gpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *ic =3D irq_desc_get_chip(desc);
 	struct aspeed_gpio *data =3D gpiochip_get_data(gc);
-	unsigned int i, p, girq, banks;
+	unsigned int i, p, banks;
 	unsigned long reg;
 	struct aspeed_gpio *gpio =3D gpiochip_get_data(gc);
=20
@@ -673,11 +673,8 @@ static void aspeed_gpio_irq_handler(struct irq_desc *des=
c)
=20
 		reg =3D ioread32(bank_reg(data, bank, reg_irq_status));
=20
-		for_each_set_bit(p, &reg, 32) {
-			girq =3D irq_find_mapping(gc->irq.domain, i * 32 + p);
-			generic_handle_irq(girq);
-		}
-
+		for_each_set_bit(p, &reg, 32)
+			generic_handle_domain_irq(gc->irq.domain, i * 32 + p);
 	}
=20
 	chained_irq_exit(ic, desc);
diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 9b780dc5d390..3958c6d97639 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -204,11 +204,8 @@ static void ath79_gpio_irq_handler(struct irq_desc *desc)
=20
 	raw_spin_unlock_irqrestore(&ctrl->lock, flags);
=20
-	if (pending) {
-		for_each_set_bit(irq, &pending, gc->ngpio)
-			generic_handle_irq(
-				irq_linear_revmap(gc->irq.domain, irq));
-	}
+	for_each_set_bit(irq, &pending, gc->ngpio)
+		generic_handle_domain_irq(gc->irq.domain, irq);
=20
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 1e6b427f2c4a..d329a143f5ec 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -466,9 +466,6 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *de=
sc)
 		    (~(readl(reg_base + GPIO_INT_MASK(bank_id)))))) {
 		for_each_set_bit(bit, &sta, 32) {
 			int hwirq =3D GPIO_PER_BANK * bank_id + bit;
-			int child_irq =3D
-				irq_find_mapping(bank->kona_gpio->irq_domain,
-						 hwirq);
 			/*
 			 * Clear interrupt before handler is called so we don't
 			 * miss any interrupt occurred during executing them.
@@ -476,7 +473,8 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *de=
sc)
 			writel(readl(reg_base + GPIO_INT_STATUS(bank_id)) |
 			       BIT(bit), reg_base + GPIO_INT_STATUS(bank_id));
 			/* Invoke interrupt handler */
-			generic_handle_irq(child_irq);
+			generic_handle_domain_irq(bank->kona_gpio->irq_domain,
+						  hwirq);
 		}
 	}
=20
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index fcfc1a1f1a5c..74b7c91c3d1a 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -277,15 +277,14 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmst=
b_gpio_bank *bank)
 	unsigned long status;
=20
 	while ((status =3D brcmstb_gpio_get_active_irqs(bank))) {
-		unsigned int irq, offset;
+		unsigned int offset;
=20
 		for_each_set_bit(offset, &status, 32) {
 			if (offset >=3D bank->width)
 				dev_warn(&priv->pdev->dev,
 					 "IRQ for invalid GPIO (bank=3D%d, offset=3D%d)\n",
 					 bank->id, offset);
-			irq =3D irq_linear_revmap(domain, hwbase + offset);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(domain, hwbase + offset);
 		}
 	}
 }
diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index 4ab3fcd9b9ba..562f8f7e7d1f 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -133,7 +133,7 @@ static void cdns_gpio_irq_handler(struct irq_desc *desc)
 		~ioread32(cgpio->regs + CDNS_GPIO_IRQ_MASK);
=20
 	for_each_set_bit(hwirq, &status, chip->ngpio)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, hwirq));
+		generic_handle_domain_irq(chip->irq.domain, hwirq);
=20
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 6f2138503726..cb5afaa7ed48 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -369,8 +369,7 @@ static void gpio_irq_handler(struct irq_desc *desc)
 			 */
 			hw_irq =3D (bank_num / 2) * 32 + bit;
=20
-			generic_handle_irq(
-				irq_find_mapping(d->irq_domain, hw_irq));
+			generic_handle_domain_irq(d->irq_domain, hw_irq);
 		}
 	}
 	chained_irq_exit(irq_desc_get_chip(desc), desc);
diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index 4c5f6d0c8d74..026903e3ef54 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -395,7 +395,7 @@ static struct irq_chip dln2_gpio_irqchip =3D {
 static void dln2_gpio_event(struct platform_device *pdev, u16 echo,
 			    const void *data, int len)
 {
-	int pin, irq;
+	int pin, ret;
=20
 	const struct {
 		__le16 count;
@@ -416,24 +416,20 @@ static void dln2_gpio_event(struct platform_device *pde=
v, u16 echo,
 		return;
 	}
=20
-	irq =3D irq_find_mapping(dln2->gpio.irq.domain, pin);
-	if (!irq) {
-		dev_err(dln2->gpio.parent, "pin %d not mapped to IRQ\n", pin);
-		return;
-	}
-
 	switch (dln2->irq_type[pin]) {
 	case DLN2_GPIO_EVENT_CHANGE_RISING:
-		if (event->value)
-			generic_handle_irq(irq);
+		if (!event->value)
+			return;
 		break;
 	case DLN2_GPIO_EVENT_CHANGE_FALLING:
-		if (!event->value)
-			generic_handle_irq(irq);
+		if (event->value)
+			return;
 		break;
-	default:
-		generic_handle_irq(irq);
 	}
+
+	ret =3D generic_handle_domain_irq(dln2->gpio.irq.domain, pin);
+	if (unlikely(ret))
+		dev_err(dln2->gpio.parent, "pin %d not mapped to IRQ\n", pin);
 }
=20
 static int dln2_gpio_probe(struct platform_device *pdev)
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 17a243c528ad..90b336e6ee27 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -173,7 +173,7 @@ static irqreturn_t em_gio_irq_handler(int irq, void *dev_=
id)
 	while ((pending =3D em_gio_read(p, GIO_MST))) {
 		offset =3D __ffs(pending);
 		em_gio_write(p, GIO_IIR, BIT(offset));
-		generic_handle_irq(irq_find_mapping(p->irq_domain, offset));
+		generic_handle_domain_irq(p->irq_domain, offset);
 		irqs_handled++;
 	}
=20
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index ef148b26b587..2e1779709113 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -128,13 +128,13 @@ static void ep93xx_gpio_ab_irq_handler(struct irq_desc =
*desc)
 	 */
 	stat =3D readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
 	for_each_set_bit(offset, &stat, 8)
-		generic_handle_irq(irq_find_mapping(epg->gc[0].gc.irq.domain,
-						    offset));
+		generic_handle_domain_irq(epg->gc[0].gc.irq.domain,
+					  offset);
=20
 	stat =3D readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
 	for_each_set_bit(offset, &stat, 8)
-		generic_handle_irq(irq_find_mapping(epg->gc[1].gc.irq.domain,
-						    offset));
+		generic_handle_domain_irq(epg->gc[1].gc.irq.domain,
+					  offset);
=20
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 4031164780f7..b90a45c939a4 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -149,8 +149,7 @@ static void ftgpio_gpio_irq_handler(struct irq_desc *desc)
 	stat =3D readl(g->base + GPIO_INT_STAT_RAW);
 	if (stat)
 		for_each_set_bit(offset, &stat, gc->ngpio)
-			generic_handle_irq(irq_find_mapping(gc->irq.domain,
-							    offset));
+			generic_handle_domain_irq(gc->irq.domain, offset);
=20
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index ad3d4da25160..3caabef5c7a2 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -186,8 +186,8 @@ static void hisi_gpio_irq_handler(struct irq_desc *desc)
=20
 	chained_irq_enter(irq_c, desc);
 	for_each_set_bit(hwirq, &irq_msk, HISI_GPIO_LINE_NUM_MAX)
-		generic_handle_irq(irq_find_mapping(hisi_gpio->chip.irq.domain,
-						    hwirq));
+		generic_handle_domain_irq(hisi_gpio->chip.irq.domain,
+					  hwirq);
 	chained_irq_exit(irq_c, desc);
 }
=20
diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 4a17599f6d44..641719a96a1a 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -97,11 +97,8 @@ static void hlwd_gpio_irqhandler(struct irq_desc *desc)
=20
 	chained_irq_enter(chip, desc);
=20
-	for_each_set_bit(hwirq, &pending, 32) {
-		int irq =3D irq_find_mapping(hlwd->gpioc.irq.domain, hwirq);
-
-		generic_handle_irq(irq);
-	}
+	for_each_set_bit(hwirq, &pending, 32)
+		generic_handle_domain_irq(hlwd->gpioc.irq.domain, hwirq);
=20
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 22f3ce218f5d..42c4d9d0cd50 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -359,12 +359,8 @@ static void mrfld_irq_handler(struct irq_desc *desc)
 		/* Only interrupts that are enabled */
 		pending &=3D enabled;
=20
-		for_each_set_bit(gpio, &pending, 32) {
-			unsigned int irq;
-
-			irq =3D irq_find_mapping(gc->irq.domain, base + gpio);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(gpio, &pending, 32)
+			generic_handle_domain_irq(gc->irq.domain, base + gpio);
 	}
=20
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 50b321a1ab1b..67dc38976ab6 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -120,7 +120,7 @@ static irqreturn_t mpc8xxx_gpio_irq_cascade(int irq, void=
 *data)
 	mask =3D gc->read_reg(mpc8xxx_gc->regs + GPIO_IER)
 		& gc->read_reg(mpc8xxx_gc->regs + GPIO_IMR);
 	for_each_set_bit(i, &mask, 32)
-		generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq, 31 - i));
+		generic_handle_domain_irq(mpc8xxx_gc->irq, 31 - i);
=20
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 82fb20dca53a..10c0a9bc5ea1 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -95,9 +95,7 @@ mediatek_gpio_irq_handler(int irq, void *data)
 	pending =3D mtk_gpio_r32(rg, GPIO_REG_STAT);
=20
 	for_each_set_bit(bit, &pending, MTK_BANK_WIDTH) {
-		u32 map =3D irq_find_mapping(gc->irq.domain, bit);
-
-		generic_handle_irq(map);
+		generic_handle_domain_irq(gc->irq.domain, bit);
 		mtk_gpio_w32(rg, GPIO_REG_STAT, BIT(bit));
 		ret |=3D IRQ_HANDLED;
 	}
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index b9fdf05d7669..c871602fc5ba 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -241,7 +241,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *po=
rt, u32 irq_stat)
 		if (port->both_edges & (1 << irqoffset))
 			mxc_flip_edge(port, irqoffset);
=20
-		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
+		generic_handle_domain_irq(port->domain, irqoffset);
=20
 		irq_stat &=3D ~(1 << irqoffset);
 	}
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 31a336b86ff2..c5166cd47c9c 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -157,7 +157,7 @@ static void mxs_gpio_irq_handler(struct irq_desc *desc)
 		if (port->both_edges & (1 << irqoffset))
 			mxs_flip_edge(port, irqoffset);
=20
-		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
+		generic_handle_domain_irq(port->domain, irqoffset);
 		irq_stat &=3D ~(1 << irqoffset);
 	}
 }
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ca23f72165ca..415e8df89d6f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -611,8 +611,7 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *g=
piobank)
=20
 			raw_spin_lock_irqsave(&bank->wa_lock, wa_lock_flags);
=20
-			generic_handle_irq(irq_find_mapping(bank->chip.irq.domain,
-							    bit));
+			generic_handle_domain_irq(bank->chip.irq.domain, bit);
=20
 			raw_spin_unlock_irqrestore(&bank->wa_lock,
 						   wa_lock_flags);
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 9acec76e0b51..71a13a394050 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -260,7 +260,7 @@ static irqreturn_t idio_16_irq_handler(int irq, void *dev=
_id)
 		return IRQ_NONE;
=20
 	for_each_set_bit(gpio, &idio16gpio->irq_mask, chip->ngpio)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, gpio));
+		generic_handle_domain_irq(chip->irq.domain, gpio);
=20
 	raw_spin_lock(&idio16gpio->lock);
=20
diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-2=
4.c
index 2a07fd96707e..8a9b98fa418f 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -468,8 +468,7 @@ static irqreturn_t idio_24_irq_handler(int irq, void *dev=
_id)
 	irq_mask =3D idio24gpio->irq_mask & irq_status;
=20
 	for_each_set_bit(gpio, &irq_mask, chip->ngpio - 24)
-		generic_handle_irq(irq_find_mapping(chip->irq.domain,
-			gpio + 24));
+		generic_handle_domain_irq(chip->irq.domain, gpio + 24);
=20
 	raw_spin_lock(&idio24gpio->lock);
=20
diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index f1b53dd1df1a..4ecab700f23f 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -223,8 +223,8 @@ static void pl061_irq_handler(struct irq_desc *desc)
 	pending =3D readb(pl061->base + GPIOMIS);
 	if (pending) {
 		for_each_set_bit(offset, &pending, PL061_GPIO_NR)
-			generic_handle_irq(irq_find_mapping(gc->irq.domain,
-							    offset));
+			generic_handle_domain_irq(gc->irq.domain,
+						  offset);
 	}
=20
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 0cb6600b8eee..382468e294e1 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -455,9 +455,8 @@ static irqreturn_t pxa_gpio_demux_handler(int in_irq, voi=
d *d)
 			for_each_set_bit(n, &gedr, BITS_PER_LONG) {
 				loop =3D 1;
=20
-				generic_handle_irq(
-					irq_find_mapping(pchip->irqdomain,
-							 gpio + n));
+				generic_handle_domain_irq(pchip->irqdomain,
+							  gpio + n);
 			}
 		}
 		handled +=3D loop;
@@ -471,9 +470,9 @@ static irqreturn_t pxa_gpio_direct_handler(int in_irq, vo=
id *d)
 	struct pxa_gpio_chip *pchip =3D d;
=20
 	if (in_irq =3D=3D pchip->irq0) {
-		generic_handle_irq(irq_find_mapping(pchip->irqdomain, 0));
+		generic_handle_domain_irq(pchip->irqdomain, 0);
 	} else if (in_irq =3D=3D pchip->irq1) {
-		generic_handle_irq(irq_find_mapping(pchip->irqdomain, 1));
+		generic_handle_domain_irq(pchip->irqdomain, 1);
 	} else {
 		pr_err("%s() unknown irq %d\n", __func__, in_irq);
 		return IRQ_NONE;
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index e7092d5fe700..b378aba32602 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -213,8 +213,8 @@ static irqreturn_t gpio_rcar_irq_handler(int irq, void *d=
ev_id)
 			  gpio_rcar_read(p, INTMSK))) {
 		offset =3D __ffs(pending);
 		gpio_rcar_write(p, INTCLR, BIT(offset));
-		generic_handle_irq(irq_find_mapping(p->gpio_chip.irq.domain,
-						    offset));
+		generic_handle_domain_irq(p->gpio_chip.irq.domain,
+					  offset);
 		irqs_handled++;
 	}
=20
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 28dcbb58b76b..463846431183 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -181,7 +181,7 @@ static void rda_gpio_irq_handler(struct irq_desc *desc)
 	struct irq_chip *ic =3D irq_desc_get_chip(desc);
 	struct rda_gpio *rda_gpio =3D gpiochip_get_data(chip);
 	unsigned long status;
-	u32 n, girq;
+	u32 n;
=20
 	chained_irq_enter(ic, desc);
=20
@@ -189,10 +189,8 @@ static void rda_gpio_irq_handler(struct irq_desc *desc)
 	/* Only lower 8 bits are capable of generating interrupts */
 	status &=3D RDA_GPIO_IRQ_MASK;
=20
-	for_each_set_bit(n, &status, RDA_GPIO_BANK_NR) {
-		girq =3D irq_find_mapping(chip->irq.domain, n);
-		generic_handle_irq(girq);
-	}
+	for_each_set_bit(n, &status, RDA_GPIO_BANK_NR)
+		generic_handle_domain_irq(chip->irq.domain, n);
=20
 	chained_irq_exit(ic, desc);
 }
diff --git a/drivers/gpio/gpio-realtek-otto.c b/drivers/gpio/gpio-realtek-ott=
o.c
index cb64fb5a51aa..eeeb39bc171d 100644
--- a/drivers/gpio/gpio-realtek-otto.c
+++ b/drivers/gpio/gpio-realtek-otto.c
@@ -196,7 +196,6 @@ static void realtek_gpio_irq_handler(struct irq_desc *des=
c)
 	struct irq_chip *irq_chip =3D irq_desc_get_chip(desc);
 	unsigned int lines_done;
 	unsigned int port_pin_count;
-	unsigned int irq;
 	unsigned long status;
 	int offset;
=20
@@ -205,10 +204,8 @@ static void realtek_gpio_irq_handler(struct irq_desc *de=
sc)
 	for (lines_done =3D 0; lines_done < gc->ngpio; lines_done +=3D 8) {
 		status =3D realtek_gpio_read_isr(ctrl, lines_done / 8);
 		port_pin_count =3D min(gc->ngpio - lines_done, 8U);
-		for_each_set_bit(offset, &status, port_pin_count) {
-			irq =3D irq_find_mapping(gc->irq.domain, offset);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(offset, &status, port_pin_count)
+			generic_handle_domain_irq(gc->irq.domain, offset);
 	}
=20
 	chained_irq_exit(irq_chip, desc);
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
new file mode 100644
index 000000000000..036b2d959503
--- /dev/null
+++ b/drivers/gpio/gpio-rockchip.c
@@ -0,0 +1,771 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * Copyright (c) 2021 Rockchip Electronics Co. Ltd.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+
+#include "../pinctrl/core.h"
+#include "../pinctrl/pinctrl-rockchip.h"
+
+#define GPIO_TYPE_V1		(0)           /* GPIO Version ID reserved */
+#define GPIO_TYPE_V2		(0x01000C2B)  /* GPIO Version ID 0x01000C2B */
+
+static const struct rockchip_gpio_regs gpio_regs_v1 =3D {
+	.port_dr =3D 0x00,
+	.port_ddr =3D 0x04,
+	.int_en =3D 0x30,
+	.int_mask =3D 0x34,
+	.int_type =3D 0x38,
+	.int_polarity =3D 0x3c,
+	.int_status =3D 0x40,
+	.int_rawstatus =3D 0x44,
+	.debounce =3D 0x48,
+	.port_eoi =3D 0x4c,
+	.ext_port =3D 0x50,
+};
+
+static const struct rockchip_gpio_regs gpio_regs_v2 =3D {
+	.port_dr =3D 0x00,
+	.port_ddr =3D 0x08,
+	.int_en =3D 0x10,
+	.int_mask =3D 0x18,
+	.int_type =3D 0x20,
+	.int_polarity =3D 0x28,
+	.int_bothedge =3D 0x30,
+	.int_status =3D 0x50,
+	.int_rawstatus =3D 0x58,
+	.debounce =3D 0x38,
+	.dbclk_div_en =3D 0x40,
+	.dbclk_div_con =3D 0x48,
+	.port_eoi =3D 0x60,
+	.ext_port =3D 0x70,
+	.version_id =3D 0x78,
+};
+
+static inline void gpio_writel_v2(u32 val, void __iomem *reg)
+{
+	writel((val & 0xffff) | 0xffff0000, reg);
+	writel((val >> 16) | 0xffff0000, reg + 0x4);
+}
+
+static inline u32 gpio_readl_v2(void __iomem *reg)
+{
+	return readl(reg + 0x4) << 16 | readl(reg);
+}
+
+static inline void rockchip_gpio_writel(struct rockchip_pin_bank *bank,
+					u32 value, unsigned int offset)
+{
+	void __iomem *reg =3D bank->reg_base + offset;
+
+	if (bank->gpio_type =3D=3D GPIO_TYPE_V2)
+		gpio_writel_v2(value, reg);
+	else
+		writel(value, reg);
+}
+
+static inline u32 rockchip_gpio_readl(struct rockchip_pin_bank *bank,
+				      unsigned int offset)
+{
+	void __iomem *reg =3D bank->reg_base + offset;
+	u32 value;
+
+	if (bank->gpio_type =3D=3D GPIO_TYPE_V2)
+		value =3D gpio_readl_v2(reg);
+	else
+		value =3D readl(reg);
+
+	return value;
+}
+
+static inline void rockchip_gpio_writel_bit(struct rockchip_pin_bank *bank,
+					    u32 bit, u32 value,
+					    unsigned int offset)
+{
+	void __iomem *reg =3D bank->reg_base + offset;
+	u32 data;
+
+	if (bank->gpio_type =3D=3D GPIO_TYPE_V2) {
+		if (value)
+			data =3D BIT(bit % 16) | BIT(bit % 16 + 16);
+		else
+			data =3D BIT(bit % 16 + 16);
+		writel(data, bit >=3D 16 ? reg + 0x4 : reg);
+	} else {
+		data =3D readl(reg);
+		data &=3D ~BIT(bit);
+		if (value)
+			data |=3D BIT(bit);
+		writel(data, reg);
+	}
+}
+
+static inline u32 rockchip_gpio_readl_bit(struct rockchip_pin_bank *bank,
+					  u32 bit, unsigned int offset)
+{
+	void __iomem *reg =3D bank->reg_base + offset;
+	u32 data;
+
+	if (bank->gpio_type =3D=3D GPIO_TYPE_V2) {
+		data =3D readl(bit >=3D 16 ? reg + 0x4 : reg);
+		data >>=3D bit % 16;
+	} else {
+		data =3D readl(reg);
+		data >>=3D bit;
+	}
+
+	return data & (0x1);
+}
+
+static int rockchip_gpio_get_direction(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct rockchip_pin_bank *bank =3D gpiochip_get_data(chip);
+	u32 data;
+
+	data =3D rockchip_gpio_readl_bit(bank, offset, bank->gpio_regs->port_ddr);
+	if (data & BIT(offset))
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static int rockchip_gpio_set_direction(struct gpio_chip *chip,
+				       unsigned int offset, bool input)
+{
+	struct rockchip_pin_bank *bank =3D gpiochip_get_data(chip);
+	unsigned long flags;
+	u32 data =3D input ? 0 : 1;
+
+	raw_spin_lock_irqsave(&bank->slock, flags);
+	rockchip_gpio_writel_bit(bank, offset, data, bank->gpio_regs->port_ddr);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	return 0;
+}
+
+static void rockchip_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			      int value)
+{
+	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&bank->slock, flags);
+	rockchip_gpio_writel_bit(bank, offset, value, bank->gpio_regs->port_dr);
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
+}
+
+static int rockchip_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
+	u32 data;
+
+	data =3D readl(bank->reg_base + bank->gpio_regs->ext_port);
+	data >>=3D offset;
+	data &=3D 1;
+
+	return data;
+}
+
+static int rockchip_gpio_set_debounce(struct gpio_chip *gc,
+				      unsigned int offset,
+				      unsigned int debounce)
+{
+	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
+	const struct rockchip_gpio_regs	*reg =3D bank->gpio_regs;
+	unsigned long flags, div_reg, freq, max_debounce;
+	bool div_debounce_support;
+	unsigned int cur_div_reg;
+	u64 div;
+
+	if (!IS_ERR(bank->db_clk)) {
+		div_debounce_support =3D true;
+		freq =3D clk_get_rate(bank->db_clk);
+		max_debounce =3D (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
+		if (debounce > max_debounce)
+			return -EINVAL;
+
+		div =3D debounce * freq;
+		div_reg =3D DIV_ROUND_CLOSEST_ULL(div, 2 * USEC_PER_SEC) - 1;
+	} else {
+		div_debounce_support =3D false;
+	}
+
+	raw_spin_lock_irqsave(&bank->slock, flags);
+
+	/* Only the v1 needs to configure div_en and div_con for dbclk */
+	if (debounce) {
+		if (div_debounce_support) {
+			/* Configure the max debounce from consumers */
+			cur_div_reg =3D readl(bank->reg_base +
+					    reg->dbclk_div_con);
+			if (cur_div_reg < div_reg)
+				writel(div_reg, bank->reg_base +
+				       reg->dbclk_div_con);
+			rockchip_gpio_writel_bit(bank, offset, 1,
+						 reg->dbclk_div_en);
+		}
+
+		rockchip_gpio_writel_bit(bank, offset, 1, reg->debounce);
+	} else {
+		if (div_debounce_support)
+			rockchip_gpio_writel_bit(bank, offset, 0,
+						 reg->dbclk_div_en);
+
+		rockchip_gpio_writel_bit(bank, offset, 0, reg->debounce);
+	}
+
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	/* Enable or disable dbclk at last */
+	if (div_debounce_support) {
+		if (debounce)
+			clk_prepare_enable(bank->db_clk);
+		else
+			clk_disable_unprepare(bank->db_clk);
+	}
+
+	return 0;
+}
+
+static int rockchip_gpio_direction_input(struct gpio_chip *gc,
+					 unsigned int offset)
+{
+	return rockchip_gpio_set_direction(gc, offset, true);
+}
+
+static int rockchip_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned int offset, int value)
+{
+	rockchip_gpio_set(gc, offset, value);
+
+	return rockchip_gpio_set_direction(gc, offset, false);
+}
+
+/*
+ * gpiolib set_config callback function. The setting of the pin
+ * mux function as 'gpio output' will be handled by the pinctrl subsystem
+ * interface.
+ */
+static int rockchip_gpio_set_config(struct gpio_chip *gc, unsigned int offse=
t,
+				  unsigned long config)
+{
+	enum pin_config_param param =3D pinconf_to_config_param(config);
+
+	switch (param) {
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		rockchip_gpio_set_debounce(gc, offset, true);
+		/*
+		 * Rockchip's gpio could only support up to one period
+		 * of the debounce clock(pclk), which is far away from
+		 * satisftying the requirement, as pclk is usually near
+		 * 100MHz shared by all peripherals. So the fact is it
+		 * has crippled debounce capability could only be useful
+		 * to prevent any spurious glitches from waking up the system
+		 * if the gpio is conguired as wakeup interrupt source. Let's
+		 * still return -ENOTSUPP as before, to make sure the caller
+		 * of gpiod_set_debounce won't change its behaviour.
+		 */
+		return -ENOTSUPP;
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+/*
+ * gpiolib gpio_to_irq callback function. Creates a mapping between a GPIO p=
in
+ * and a virtual IRQ, if not already present.
+ */
+static int rockchip_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
+	unsigned int virq;
+
+	if (!bank->domain)
+		return -ENXIO;
+
+	virq =3D irq_create_mapping(bank->domain, offset);
+
+	return (virq) ? : -ENXIO;
+}
+
+static const struct gpio_chip rockchip_gpiolib_chip =3D {
+	.request =3D gpiochip_generic_request,
+	.free =3D gpiochip_generic_free,
+	.set =3D rockchip_gpio_set,
+	.get =3D rockchip_gpio_get,
+	.get_direction	=3D rockchip_gpio_get_direction,
+	.direction_input =3D rockchip_gpio_direction_input,
+	.direction_output =3D rockchip_gpio_direction_output,
+	.set_config =3D rockchip_gpio_set_config,
+	.to_irq =3D rockchip_gpio_to_irq,
+	.owner =3D THIS_MODULE,
+};
+
+static void rockchip_irq_demux(struct irq_desc *desc)
+{
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	struct rockchip_pin_bank *bank =3D irq_desc_get_handler_data(desc);
+	u32 pend;
+
+	dev_dbg(bank->dev, "got irq for bank %s\n", bank->name);
+
+	chained_irq_enter(chip, desc);
+
+	pend =3D readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
+
+	while (pend) {
+		unsigned int irq, virq;
+
+		irq =3D __ffs(pend);
+		pend &=3D ~BIT(irq);
+		virq =3D irq_find_mapping(bank->domain, irq);
+
+		if (!virq) {
+			dev_err(bank->dev, "unmapped irq %d\n", irq);
+			continue;
+		}
+
+		dev_dbg(bank->dev, "handling irq %d\n", irq);
+
+		/*
+		 * Triggering IRQ on both rising and falling edge
+		 * needs manual intervention.
+		 */
+		if (bank->toggle_edge_mode & BIT(irq)) {
+			u32 data, data_old, polarity;
+			unsigned long flags;
+
+			data =3D readl_relaxed(bank->reg_base +
+					     bank->gpio_regs->ext_port);
+			do {
+				raw_spin_lock_irqsave(&bank->slock, flags);
+
+				polarity =3D readl_relaxed(bank->reg_base +
+							 bank->gpio_regs->int_polarity);
+				if (data & BIT(irq))
+					polarity &=3D ~BIT(irq);
+				else
+					polarity |=3D BIT(irq);
+				writel(polarity,
+				       bank->reg_base +
+				       bank->gpio_regs->int_polarity);
+
+				raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+				data_old =3D data;
+				data =3D readl_relaxed(bank->reg_base +
+						     bank->gpio_regs->ext_port);
+			} while ((data & BIT(irq)) !=3D (data_old & BIT(irq)));
+		}
+
+		generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank =3D gc->private;
+	u32 mask =3D BIT(d->hwirq);
+	u32 polarity;
+	u32 level;
+	u32 data;
+	unsigned long flags;
+	int ret =3D 0;
+
+	raw_spin_lock_irqsave(&bank->slock, flags);
+
+	rockchip_gpio_writel_bit(bank, d->hwirq, 0,
+				 bank->gpio_regs->port_ddr);
+
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	raw_spin_lock_irqsave(&bank->slock, flags);
+
+	level =3D rockchip_gpio_readl(bank, bank->gpio_regs->int_type);
+	polarity =3D rockchip_gpio_readl(bank, bank->gpio_regs->int_polarity);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+		if (bank->gpio_type =3D=3D GPIO_TYPE_V2) {
+			bank->toggle_edge_mode &=3D ~mask;
+			rockchip_gpio_writel_bit(bank, d->hwirq, 1,
+						 bank->gpio_regs->int_bothedge);
+			goto out;
+		} else {
+			bank->toggle_edge_mode |=3D mask;
+			level |=3D mask;
+
+			/*
+			 * Determine gpio state. If 1 next interrupt should be
+			 * falling otherwise rising.
+			 */
+			data =3D readl(bank->reg_base + bank->gpio_regs->ext_port);
+			if (data & mask)
+				polarity &=3D ~mask;
+			else
+				polarity |=3D mask;
+		}
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		bank->toggle_edge_mode &=3D ~mask;
+		level |=3D mask;
+		polarity |=3D mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		bank->toggle_edge_mode &=3D ~mask;
+		level |=3D mask;
+		polarity &=3D ~mask;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		bank->toggle_edge_mode &=3D ~mask;
+		level &=3D ~mask;
+		polarity |=3D mask;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		bank->toggle_edge_mode &=3D ~mask;
+		level &=3D ~mask;
+		polarity &=3D ~mask;
+		break;
+	default:
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	rockchip_gpio_writel(bank, level, bank->gpio_regs->int_type);
+	rockchip_gpio_writel(bank, polarity, bank->gpio_regs->int_polarity);
+out:
+	raw_spin_unlock_irqrestore(&bank->slock, flags);
+
+	return ret;
+}
+
+static void rockchip_irq_suspend(struct irq_data *d)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank =3D gc->private;
+
+	bank->saved_masks =3D irq_reg_readl(gc, bank->gpio_regs->int_mask);
+	irq_reg_writel(gc, ~gc->wake_active, bank->gpio_regs->int_mask);
+}
+
+static void rockchip_irq_resume(struct irq_data *d)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
+	struct rockchip_pin_bank *bank =3D gc->private;
+
+	irq_reg_writel(gc, bank->saved_masks, bank->gpio_regs->int_mask);
+}
+
+static void rockchip_irq_enable(struct irq_data *d)
+{
+	irq_gc_mask_clr_bit(d);
+}
+
+static void rockchip_irq_disable(struct irq_data *d)
+{
+	irq_gc_mask_set_bit(d);
+}
+
+static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
+{
+	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct irq_chip_generic *gc;
+	int ret;
+
+	bank->domain =3D irq_domain_add_linear(bank->of_node, 32,
+					&irq_generic_chip_ops, NULL);
+	if (!bank->domain) {
+		dev_warn(bank->dev, "could not init irq domain for bank %s\n",
+			 bank->name);
+		return -EINVAL;
+	}
+
+	ret =3D irq_alloc_domain_generic_chips(bank->domain, 32, 1,
+					     "rockchip_gpio_irq",
+					     handle_level_irq,
+					     clr, 0, 0);
+	if (ret) {
+		dev_err(bank->dev, "could not alloc generic chips for bank %s\n",
+			bank->name);
+		irq_domain_remove(bank->domain);
+		return -EINVAL;
+	}
+
+	gc =3D irq_get_domain_generic_chip(bank->domain, 0);
+	if (bank->gpio_type =3D=3D GPIO_TYPE_V2) {
+		gc->reg_writel =3D gpio_writel_v2;
+		gc->reg_readl =3D gpio_readl_v2;
+	}
+
+	gc->reg_base =3D bank->reg_base;
+	gc->private =3D bank;
+	gc->chip_types[0].regs.mask =3D bank->gpio_regs->int_mask;
+	gc->chip_types[0].regs.ack =3D bank->gpio_regs->port_eoi;
+	gc->chip_types[0].chip.irq_ack =3D irq_gc_ack_set_bit;
+	gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_set_bit;
+	gc->chip_types[0].chip.irq_unmask =3D irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_enable =3D rockchip_irq_enable;
+	gc->chip_types[0].chip.irq_disable =3D rockchip_irq_disable;
+	gc->chip_types[0].chip.irq_set_wake =3D irq_gc_set_wake;
+	gc->chip_types[0].chip.irq_suspend =3D rockchip_irq_suspend;
+	gc->chip_types[0].chip.irq_resume =3D rockchip_irq_resume;
+	gc->chip_types[0].chip.irq_set_type =3D rockchip_irq_set_type;
+	gc->wake_enabled =3D IRQ_MSK(bank->nr_pins);
+
+	/*
+	 * Linux assumes that all interrupts start out disabled/masked.
+	 * Our driver only uses the concept of masked and always keeps
+	 * things enabled, so for us that's all masked and all enabled.
+	 */
+	rockchip_gpio_writel(bank, 0xffffffff, bank->gpio_regs->int_mask);
+	rockchip_gpio_writel(bank, 0xffffffff, bank->gpio_regs->port_eoi);
+	rockchip_gpio_writel(bank, 0xffffffff, bank->gpio_regs->int_en);
+	gc->mask_cache =3D 0xffffffff;
+
+	irq_set_chained_handler_and_data(bank->irq,
+					 rockchip_irq_demux, bank);
+
+	return 0;
+}
+
+static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
+{
+	struct gpio_chip *gc;
+	int ret;
+
+	bank->gpio_chip =3D rockchip_gpiolib_chip;
+
+	gc =3D &bank->gpio_chip;
+	gc->base =3D bank->pin_base;
+	gc->ngpio =3D bank->nr_pins;
+	gc->label =3D bank->name;
+	gc->parent =3D bank->dev;
+#ifdef CONFIG_OF_GPIO
+	gc->of_node =3D of_node_get(bank->of_node);
+#endif
+
+	ret =3D gpiochip_add_data(gc, bank);
+	if (ret) {
+		dev_err(bank->dev, "failed to add gpiochip %s, %d\n",
+			gc->label, ret);
+		return ret;
+	}
+
+	/*
+	 * For DeviceTree-supported systems, the gpio core checks the
+	 * pinctrl's device node for the "gpio-ranges" property.
+	 * If it is present, it takes care of adding the pin ranges
+	 * for the driver. In this case the driver can skip ahead.
+	 *
+	 * In order to remain compatible with older, existing DeviceTree
+	 * files which don't set the "gpio-ranges" property or systems that
+	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
+	 */
+	if (!of_property_read_bool(bank->of_node, "gpio-ranges")) {
+		struct device_node *pctlnp =3D of_get_parent(bank->of_node);
+		struct pinctrl_dev *pctldev =3D NULL;
+
+		if (!pctlnp)
+			return -ENODATA;
+
+		pctldev =3D of_pinctrl_get(pctlnp);
+		if (!pctldev)
+			return -ENODEV;
+
+		ret =3D gpiochip_add_pin_range(gc, dev_name(pctldev->dev), 0,
+					     gc->base, gc->ngpio);
+		if (ret) {
+			dev_err(bank->dev, "Failed to add pin range\n");
+			goto fail;
+		}
+	}
+
+	ret =3D rockchip_interrupts_register(bank);
+	if (ret) {
+		dev_err(bank->dev, "failed to register interrupt, %d\n", ret);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	gpiochip_remove(&bank->gpio_chip);
+
+	return ret;
+}
+
+static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
+{
+	struct resource res;
+	int id =3D 0;
+
+	if (of_address_to_resource(bank->of_node, 0, &res)) {
+		dev_err(bank->dev, "cannot find IO resource for bank\n");
+		return -ENOENT;
+	}
+
+	bank->reg_base =3D devm_ioremap_resource(bank->dev, &res);
+	if (IS_ERR(bank->reg_base))
+		return PTR_ERR(bank->reg_base);
+
+	bank->irq =3D irq_of_parse_and_map(bank->of_node, 0);
+	if (!bank->irq)
+		return -EINVAL;
+
+	bank->clk =3D of_clk_get(bank->of_node, 0);
+	if (IS_ERR(bank->clk))
+		return PTR_ERR(bank->clk);
+
+	clk_prepare_enable(bank->clk);
+	id =3D readl(bank->reg_base + gpio_regs_v2.version_id);
+
+	/* If not gpio v2, that is default to v1. */
+	if (id =3D=3D GPIO_TYPE_V2) {
+		bank->gpio_regs =3D &gpio_regs_v2;
+		bank->gpio_type =3D GPIO_TYPE_V2;
+		bank->db_clk =3D of_clk_get(bank->of_node, 1);
+		if (IS_ERR(bank->db_clk)) {
+			dev_err(bank->dev, "cannot find debounce clk\n");
+			clk_disable_unprepare(bank->clk);
+			return -EINVAL;
+		}
+	} else {
+		bank->gpio_regs =3D &gpio_regs_v1;
+		bank->gpio_type =3D GPIO_TYPE_V1;
+	}
+
+	return 0;
+}
+
+static struct rockchip_pin_bank *
+rockchip_gpio_find_bank(struct pinctrl_dev *pctldev, int id)
+{
+	struct rockchip_pinctrl *info;
+	struct rockchip_pin_bank *bank;
+	int i, found =3D 0;
+
+	info =3D pinctrl_dev_get_drvdata(pctldev);
+	bank =3D info->ctrl->pin_banks;
+	for (i =3D 0; i < info->ctrl->nr_banks; i++, bank++) {
+		if (bank->bank_num =3D=3D id) {
+			found =3D 1;
+			break;
+		}
+	}
+
+	return found ? bank : NULL;
+}
+
+static int rockchip_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	struct device_node *pctlnp =3D of_get_parent(np);
+	struct pinctrl_dev *pctldev =3D NULL;
+	struct rockchip_pin_bank *bank =3D NULL;
+	static int gpio;
+	int id, ret;
+
+	if (!np || !pctlnp)
+		return -ENODEV;
+
+	pctldev =3D of_pinctrl_get(pctlnp);
+	if (!pctldev)
+		return -EPROBE_DEFER;
+
+	id =3D of_alias_get_id(np, "gpio");
+	if (id < 0)
+		id =3D gpio++;
+
+	bank =3D rockchip_gpio_find_bank(pctldev, id);
+	if (!bank)
+		return -EINVAL;
+
+	bank->dev =3D dev;
+	bank->of_node =3D np;
+
+	raw_spin_lock_init(&bank->slock);
+
+	ret =3D rockchip_get_bank_data(bank);
+	if (ret)
+		return ret;
+
+	ret =3D rockchip_gpiolib_register(bank);
+	if (ret) {
+		clk_disable_unprepare(bank->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, bank);
+	dev_info(dev, "probed %pOF\n", np);
+
+	return 0;
+}
+
+static int rockchip_gpio_remove(struct platform_device *pdev)
+{
+	struct rockchip_pin_bank *bank =3D platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(bank->clk);
+	gpiochip_remove(&bank->gpio_chip);
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_gpio_match[] =3D {
+	{ .compatible =3D "rockchip,gpio-bank", },
+	{ .compatible =3D "rockchip,rk3188-gpio-bank0" },
+	{ },
+};
+
+static struct platform_driver rockchip_gpio_driver =3D {
+	.probe		=3D rockchip_gpio_probe,
+	.remove		=3D rockchip_gpio_remove,
+	.driver		=3D {
+		.name	=3D "rockchip-gpio",
+		.of_match_table =3D rockchip_gpio_match,
+	},
+};
+
+static int __init rockchip_gpio_init(void)
+{
+	return platform_driver_register(&rockchip_gpio_driver);
+}
+postcore_initcall(rockchip_gpio_init);
+
+static void __exit rockchip_gpio_exit(void)
+{
+	platform_driver_unregister(&rockchip_gpio_driver);
+}
+module_exit(rockchip_gpio_exit);
+
+MODULE_DESCRIPTION("Rockchip gpio driver");
+MODULE_ALIAS("platform:rockchip-gpio");
+MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, rockchip_gpio_match);
diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index a6f0421d6e50..0600f71462b5 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -259,7 +259,7 @@ static u32 sch_gpio_gpe_handler(acpi_handle gpe_device, u=
32 gpe, void *context)
=20
 	pending =3D (resume_status << sch->resume_base) | core_status;
 	for_each_set_bit(offset, &pending, sch->chip.ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, offset));
+		generic_handle_domain_irq(gc->irq.domain, offset);
=20
 	/* Set returning value depending on whether we handled an interrupt */
 	ret =3D pending ? ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index aed988e78251..c2a2c76c1652 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -84,7 +84,7 @@ static irqreturn_t sdv_gpio_pub_irq_handler(int irq, void *=
data)
 		return IRQ_NONE;
=20
 	for_each_set_bit(irq_bit, &irq_stat, 32)
-		generic_handle_irq(irq_find_mapping(sd->id, irq_bit));
+		generic_handle_domain_irq(sd->id, irq_bit);
=20
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 25c37edcbc6c..9dd9dabb579e 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -189,7 +189,7 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *chip =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *ic =3D irq_desc_get_chip(desc);
 	struct sprd_gpio *sprd_gpio =3D gpiochip_get_data(chip);
-	u32 bank, n, girq;
+	u32 bank, n;
=20
 	chained_irq_enter(ic, desc);
=20
@@ -198,13 +198,9 @@ static void sprd_gpio_irq_handler(struct irq_desc *desc)
 		unsigned long reg =3D readl_relaxed(base + SPRD_GPIO_MIS) &
 			SPRD_GPIO_BANK_MASK;
=20
-		for_each_set_bit(n, &reg, SPRD_GPIO_BANK_NR) {
-			girq =3D irq_find_mapping(chip->irq.domain,
-						bank * SPRD_GPIO_BANK_NR + n);
-
-			generic_handle_irq(girq);
-		}
-
+		for_each_set_bit(n, &reg, SPRD_GPIO_BANK_NR)
+			generic_handle_domain_irq(chip->irq.domain,
+						  bank * SPRD_GPIO_BANK_NR + n);
 	}
 	chained_irq_exit(ic, desc);
 }
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 866201cf5f65..718a508d3b2f 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -100,7 +100,7 @@ static irqreturn_t tb10x_gpio_irq_cascade(int irq, void *=
data)
 	int i;
=20
 	for_each_set_bit(i, &bits, 32)
-		generic_handle_irq(irq_find_mapping(tb10x_gpio->domain, i));
+		generic_handle_domain_irq(tb10x_gpio->domain, i);
=20
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 0025f613d9b3..7f5bc10a6479 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -408,6 +408,8 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
 		lvl =3D tegra_gpio_readl(tgi, GPIO_INT_LVL(tgi, gpio));
=20
 		for_each_set_bit(pin, &sta, 8) {
+			int ret;
+
 			tegra_gpio_writel(tgi, 1 << pin,
 					  GPIO_INT_CLR(tgi, gpio));
=20
@@ -420,11 +422,8 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
 				chained_irq_exit(chip, desc);
 			}
=20
-			irq =3D irq_find_mapping(domain, gpio + pin);
-			if (WARN_ON(irq =3D=3D 0))
-				continue;
-
-			generic_handle_irq(irq);
+			ret =3D generic_handle_domain_irq(domain, gpio + pin);
+			WARN_RATELIMIT(ret, "hwirq =3D %d", gpio + pin);
 		}
 	}
=20
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d38980b9923a..05c90d76cb22 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -456,7 +456,7 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
=20
 	for (i =3D 0; i < gpio->soc->num_ports; i++) {
 		const struct tegra_gpio_port *port =3D &gpio->soc->ports[i];
-		unsigned int pin, irq;
+		unsigned int pin;
 		unsigned long value;
 		void __iomem *base;
=20
@@ -469,11 +469,8 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 		value =3D readl(base + TEGRA186_GPIO_INTERRUPT_STATUS(1));
=20
 		for_each_set_bit(pin, &value, port->pins) {
-			irq =3D irq_find_mapping(domain, offset + pin);
-			if (WARN_ON(irq =3D=3D 0))
-				continue;
-
-			generic_handle_irq(irq);
+			int ret =3D generic_handle_domain_irq(domain, offset + pin);
+			WARN_RATELIMIT(ret, "hwirq =3D %d", offset + pin);
 		}
=20
 skip:
diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 0f5d17f343f1..5b103221b58d 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -183,7 +183,7 @@ static void tqmx86_gpio_irq_handler(struct irq_desc *desc)
 	struct tqmx86_gpio_data *gpio =3D gpiochip_get_data(chip);
 	struct irq_chip *irq_chip =3D irq_desc_get_chip(desc);
 	unsigned long irq_bits;
-	int i =3D 0, child_irq;
+	int i =3D 0;
 	u8 irq_status;
=20
 	chained_irq_enter(irq_chip, desc);
@@ -192,11 +192,9 @@ static void tqmx86_gpio_irq_handler(struct irq_desc *des=
c)
 	tqmx86_gpio_write(gpio, irq_status, TQMX86_GPIIS);
=20
 	irq_bits =3D irq_status;
-	for_each_set_bit(i, &irq_bits, TQMX86_NGPI) {
-		child_irq =3D irq_find_mapping(gpio->chip.irq.domain,
-					     i + TQMX86_NGPO);
-		generic_handle_irq(child_irq);
-	}
+	for_each_set_bit(i, &irq_bits, TQMX86_NGPI)
+		generic_handle_domain_irq(gpio->chip.irq.domain,
+					  i + TQMX86_NGPO);
=20
 	chained_irq_exit(irq_chip, desc);
 }
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 58776f2d69ff..e0f2b67558e7 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -149,7 +149,7 @@ static void vf610_gpio_irq_handler(struct irq_desc *desc)
 	for_each_set_bit(pin, &irq_isfr, VF610_GPIO_PER_PORT) {
 		vf610_gpio_writel(BIT(pin), port->base + PORT_ISFR);
=20
-		generic_handle_irq(irq_find_mapping(port->gc.irq.domain, pin));
+		generic_handle_domain_irq(port->gc.irq.domain, pin);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index 2d89d0529135..bb02a82e22f4 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -339,8 +339,8 @@ static irqreturn_t ws16c48_irq_handler(int irq, void *dev=
_id)
 		for_each_set_bit(port, &int_pending, 3) {
 			int_id =3D inb(ws16c48gpio->base + 8 + port);
 			for_each_set_bit(gpio, &int_id, 8)
-				generic_handle_irq(irq_find_mapping(
-					chip->irq.domain, gpio + 8*port));
+				generic_handle_domain_irq(chip->irq.domain,
+							  gpio + 8*port);
 		}
=20
 		int_pending =3D inb(ws16c48gpio->base + 6) & 0x7;
diff --git a/drivers/gpio/gpio-xgs-iproc.c b/drivers/gpio/gpio-xgs-iproc.c
index ad5489a65d54..fa9b4d8c3ff5 100644
--- a/drivers/gpio/gpio-xgs-iproc.c
+++ b/drivers/gpio/gpio-xgs-iproc.c
@@ -185,7 +185,7 @@ static irqreturn_t iproc_gpio_irq_handler(int irq, void *=
data)
 		int_bits =3D level | event;
=20
 		for_each_set_bit(bit, &int_bits, gc->ngpio)
-			generic_handle_irq(irq_linear_revmap(gc->irq.domain, bit));
+			generic_handle_domain_irq(gc->irq.domain, bit);
 	}
=20
 	return int_bits ? IRQ_HANDLED : IRQ_NONE;
diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index c329c3a606e8..a1b66338d077 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -538,7 +538,7 @@ static void xgpio_irqhandler(struct irq_desc *desc)
=20
 	for_each_set_bit(bit, all, 64) {
 		irq_offset =3D xgpio_from_bit(chip, bit);
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, irq_offset));
+		generic_handle_domain_irq(gc->irq.domain, irq_offset);
 	}
=20
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index d7b16bb9e4e4..0d94d3aef752 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -216,8 +216,7 @@ static void xlp_gpio_generic_handler(struct irq_desc *des=
c)
 		}
=20
 		if (gpio_stat & BIT(gpio % XLP_GPIO_REGSZ))
-			generic_handle_irq(irq_find_mapping(
-						priv->chip.irq.domain, gpio));
+			generic_handle_domain_irq(priv->chip.irq.domain, gpio);
 	}
 	chained_irq_exit(irqchip, desc);
 }
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index f0cb8ccd03ed..06c6401f02b8 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -628,12 +628,8 @@ static void zynq_gpio_handle_bank_irq(struct zynq_gpio *=
gpio,
 	if (!pending)
 		return;
=20
-	for_each_set_bit(offset, &pending, 32) {
-		unsigned int gpio_irq;
-
-		gpio_irq =3D irq_find_mapping(irqdomain, offset + bank_offset);
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(offset, &pending, 32)
+		generic_handle_domain_irq(irqdomain, offset + bank_offset);
 }
=20
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/am=
dgpu/amdgpu_irq.c
index 83af307e97cd..cd2e18f072fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -502,7 +502,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
=20
 	} else if ((client_id =3D=3D AMDGPU_IRQ_CLIENTID_LEGACY) &&
 		   adev->irq.virq[src_id]) {
-		generic_handle_irq(irq_find_mapping(adev->irq.domain, src_id));
+		generic_handle_domain_irq(adev->irq.domain, src_id);
=20
 	} else if (!adev->irq.client[client_id].sources) {
 		DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %d\n",
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/d=
isp/dpu1/dpu_mdss.c
index 6b0a7bc87eb7..b466784d9822 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -45,20 +45,13 @@ static void dpu_mdss_irq(struct irq_desc *desc)
=20
 	while (interrupts) {
 		irq_hw_number_t hwirq =3D fls(interrupts) - 1;
-		unsigned int mapping;
 		int rc;
=20
-		mapping =3D irq_find_mapping(dpu_mdss->irq_controller.domain,
-					   hwirq);
-		if (mapping =3D=3D 0) {
-			DRM_ERROR("couldn't find irq mapping for %lu\n", hwirq);
-			break;
-		}
-
-		rc =3D generic_handle_irq(mapping);
+		rc =3D generic_handle_domain_irq(dpu_mdss->irq_controller.domain,
+					       hwirq);
 		if (rc < 0) {
-			DRM_ERROR("handle irq fail: irq=3D%lu mapping=3D%u rc=3D%d\n",
-				  hwirq, mapping, rc);
+			DRM_ERROR("handle irq fail: irq=3D%lu rc=3D%d\n",
+				  hwirq, rc);
 			break;
 		}
=20
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c b/drivers/gpu/drm/msm/=
disp/mdp5/mdp5_mdss.c
index 09bd46ad820b..2f4895bcb0b0 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mdss.c
@@ -50,8 +50,7 @@ static irqreturn_t mdss_irq(int irq, void *arg)
 	while (intr) {
 		irq_hw_number_t hwirq =3D fls(intr) - 1;
=20
-		generic_handle_irq(irq_find_mapping(
-				mdp5_mdss->irqcontroller.domain, hwirq));
+		generic_handle_domain_irq(mdp5_mdss->irqcontroller.domain, hwirq);
 		intr &=3D ~(1 << hwirq);
 	}
=20
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index d166ee262ce4..118318513e2d 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1003,19 +1003,16 @@ static int ipu_submodules_init(struct ipu_soc *ipu,
 static void ipu_irq_handle(struct ipu_soc *ipu, const int *regs, int num_reg=
s)
 {
 	unsigned long status;
-	int i, bit, irq;
+	int i, bit;
=20
 	for (i =3D 0; i < num_regs; i++) {
=20
 		status =3D ipu_cm_read(ipu, IPU_INT_STAT(regs[i]));
 		status &=3D ipu_cm_read(ipu, IPU_INT_CTRL(regs[i]));
=20
-		for_each_set_bit(bit, &status, 32) {
-			irq =3D irq_linear_revmap(ipu->domain,
-						regs[i] * 32 + bit);
-			if (irq)
-				generic_handle_irq(irq);
-		}
+		for_each_set_bit(bit, &status, 32)
+			generic_handle_domain_irq(ipu->domain,
+						  regs[i] * 32 + bit);
 	}
 }
=20
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-ms=
i.c
index ede02dc2bcd0..5ddb8e578ac6 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -267,9 +267,7 @@ static int alpine_msix_init(struct device_node *node,
 		goto err_priv;
 	}
=20
-	priv->msi_map =3D kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
+	priv->msi_map =3D bitmap_zalloc(priv->num_spis, GFP_KERNEL);
 	if (!priv->msi_map) {
 		ret =3D -ENOMEM;
 		goto err_priv;
@@ -285,7 +283,7 @@ static int alpine_msix_init(struct device_node *node,
 	return 0;
=20
 err_map:
-	kfree(priv->msi_map);
+	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
 	return ret;
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index b8c06bd8659e..6fc145aacaf0 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -226,7 +226,7 @@ static void aic_irq_eoi(struct irq_data *d)
 	 * Reading the interrupt reason automatically acknowledges and masks
 	 * the IRQ, so we just unmask it here if needed.
 	 */
-	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
+	if (!irqd_irq_masked(d))
 		aic_irq_unmask(d);
 }
=20
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be9ea6fd6f8b..9349fc68b81a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -269,7 +269,7 @@ static void gicv2m_teardown(void)
=20
 	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
 		list_del(&v2m->entry);
-		kfree(v2m->bm);
+		bitmap_free(v2m->bm);
 		iounmap(v2m->base);
 		of_node_put(to_of_node(v2m->fwnode));
 		if (is_fwnode_irqchip(v2m->fwnode))
@@ -386,8 +386,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *f=
wnode,
 			break;
 		}
 	}
-	v2m->bm =3D kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
-			  GFP_KERNEL);
+	v2m->bm =3D bitmap_zalloc(v2m->nr_spis, GFP_KERNEL);
 	if (!v2m->bm) {
 		ret =3D -ENOMEM;
 		goto err_iounmap;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index ba39668c3e08..7f40dca8cda5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2140,7 +2140,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *b=
ase, int *nr_ids)
 	if (err)
 		goto out;
=20
-	bitmap =3D kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
+	bitmap =3D bitmap_zalloc(nr_irqs, GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
=20
@@ -2156,7 +2156,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *b=
ase, int *nr_ids)
 static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
 	WARN_ON(free_lpi_range(base, nr_ids));
-	kfree(bitmap);
+	bitmap_free(bitmap);
 }
=20
 static void gic_reset_prop_table(void *va)
@@ -3387,7 +3387,7 @@ static struct its_device *its_create_device(struct its_=
node *its, u32 dev_id,
 	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
 		kfree(dev);
 		kfree(itt);
-		kfree(lpi_map);
+		bitmap_free(lpi_map);
 		kfree(col_map);
 		return NULL;
 	}
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index e81e89a81cb5..b84c9c2eccdc 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -290,8 +290,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct =
irq_domain *parent)
 		if (ret)
 			goto err_free_mbi;
=20
-		mbi_ranges[n].bm =3D kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
-					   sizeof(long), GFP_KERNEL);
+		mbi_ranges[n].bm =3D bitmap_zalloc(mbi_ranges[n].nr_spis, GFP_KERNEL);
 		if (!mbi_ranges[n].bm) {
 			ret =3D -ENOMEM;
 			goto err_free_mbi;
@@ -329,7 +328,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct =
irq_domain *parent)
 err_free_mbi:
 	if (mbi_ranges) {
 		for (n =3D 0; n < mbi_range_nr; n++)
-			kfree(mbi_ranges[n].bm);
+			bitmap_free(mbi_ranges[n].bm);
 		kfree(mbi_ranges);
 	}
=20
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..fd4e9a37fea6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -100,6 +100,27 @@ EXPORT_SYMBOL(gic_pmr_sync);
 DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
 EXPORT_SYMBOL(gic_nonsecure_priorities);
=20
+/*
+ * When the Non-secure world has access to group 0 interrupts (as a
+ * consequence of SCR_EL3.FIQ =3D=3D 0), reading the ICC_RPR_EL1 register wi=
ll
+ * return the Distributor's view of the interrupt priority.
+ *
+ * When GIC security is enabled (GICD_CTLR.DS =3D=3D 0), the interrupt prior=
ity
+ * written by software is moved to the Non-secure range by the Distributor.
+ *
+ * If both are true (which is when gic_nonsecure_priorities gets enabled),
+ * we need to shift down the priority programmed by software to match it
+ * against the value returned by ICC_RPR_EL1.
+ */
+#define GICD_INT_RPR_PRI(priority)					\
+	({								\
+		u32 __priority =3D (priority);				\
+		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
+			__priority =3D 0x80 | (__priority >> 1);		\
+									\
+		__priority;						\
+	})
+
 /* ppi_nmi_refs[n] =3D=3D number of cpus having ppi[n + 16] set as NMI */
 static refcount_t *ppi_nmi_refs;
=20
@@ -446,18 +467,23 @@ static void gic_irq_set_prio(struct irq_data *d, u8 pri=
o)
 	writeb_relaxed(prio, base + offset + index);
 }
=20
-static u32 gic_get_ppi_index(struct irq_data *d)
+static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 {
-	switch (get_intid_range(d)) {
+	switch (__get_intid_range(hwirq)) {
 	case PPI_RANGE:
-		return d->hwirq - 16;
+		return hwirq - 16;
 	case EPPI_RANGE:
-		return d->hwirq - EPPI_BASE_INTID + 16;
+		return hwirq - EPPI_BASE_INTID + 16;
 	default:
 		unreachable();
 	}
 }
=20
+static u32 gic_get_ppi_index(struct irq_data *d)
+{
+	return __gic_get_ppi_index(d->hwirq);
+}
+
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc =3D irq_to_desc(d->irq);
@@ -687,7 +713,7 @@ static asmlinkage void __exception_irq_entry gic_handle_i=
rq(struct pt_regs *regs
 		return;
=20
 	if (gic_supports_nmi() &&
-	    unlikely(gic_read_rpr() =3D=3D GICD_INT_NMI_PRI)) {
+	    unlikely(gic_read_rpr() =3D=3D GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
 		gic_handle_nmi(irqnr, regs);
 		return;
 	}
@@ -1467,10 +1493,34 @@ static void gic_irq_domain_free(struct irq_domain *do=
main, unsigned int virq,
 	}
 }
=20
+static bool fwspec_is_partitioned_ppi(struct irq_fwspec *fwspec,
+				      irq_hw_number_t hwirq)
+{
+	enum gic_intid_range range;
+
+	if (!gic_data.ppi_descs)
+		return false;
+
+	if (!is_of_node(fwspec->fwnode))
+		return false;
+
+	if (fwspec->param_count < 4 || !fwspec->param[3])
+		return false;
+
+	range =3D __get_intid_range(hwirq);
+	if (range !=3D PPI_RANGE && range !=3D EPPI_RANGE)
+		return false;
+
+	return true;
+}
+
 static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
+	unsigned int type, ret, ppi_idx;
+	irq_hw_number_t hwirq;
+
 	/* Not for us */
         if (fwspec->fwnode !=3D d->fwnode)
 		return 0;
@@ -1479,16 +1529,19 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	if (!is_of_node(fwspec->fwnode))
 		return 1;
=20
+	ret =3D gic_irq_domain_translate(d, fwspec, &hwirq, &type);
+	if (WARN_ON_ONCE(ret))
+		return 0;
+
+	if (!fwspec_is_partitioned_ppi(fwspec, hwirq))
+		return d =3D=3D gic_data.domain;
+
 	/*
 	 * If this is a PPI and we have a 4th (non-null) parameter,
 	 * then we need to match the partition domain.
 	 */
-	if (fwspec->param_count >=3D 4 &&
-	    fwspec->param[0] =3D=3D 1 && fwspec->param[3] !=3D 0 &&
-	    gic_data.ppi_descs)
-		return d =3D=3D partition_get_domain(gic_data.ppi_descs[fwspec->param[1]]);
-
-	return d =3D=3D gic_data.domain;
+	ppi_idx =3D __gic_get_ppi_index(hwirq);
+	return d =3D=3D partition_get_domain(gic_data.ppi_descs[ppi_idx]);
 }
=20
 static const struct irq_domain_ops gic_irq_domain_ops =3D {
@@ -1503,7 +1556,9 @@ static int partition_domain_translate(struct irq_domain=
 *d,
 				      unsigned long *hwirq,
 				      unsigned int *type)
 {
+	unsigned long ppi_intid;
 	struct device_node *np;
+	unsigned int ppi_idx;
 	int ret;
=20
 	if (!gic_data.ppi_descs)
@@ -1513,7 +1568,12 @@ static int partition_domain_translate(struct irq_domai=
n *d,
 	if (WARN_ON(!np))
 		return -EINVAL;
=20
-	ret =3D partition_translate_id(gic_data.ppi_descs[fwspec->param[1]],
+	ret =3D gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
+	if (WARN_ON_ONCE(ret))
+		return 0;
+
+	ppi_idx =3D __gic_get_ppi_index(ppi_intid);
+	ret =3D partition_translate_id(gic_data.ppi_descs[ppi_idx],
 				     of_node_to_fwnode(np));
 	if (ret < 0)
 		return ret;
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index f790ca6d78aa..a4eb8a2181c7 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -92,18 +92,22 @@ static int pch_pic_set_type(struct irq_data *d, unsigned =
int type)
 	case IRQ_TYPE_EDGE_RISING:
 		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	default:
 		ret =3D -EINVAL;
@@ -113,11 +117,24 @@ static int pch_pic_set_type(struct irq_data *d, unsigne=
d int type)
 	return ret;
 }
=20
+static void pch_pic_ack_irq(struct irq_data *d)
+{
+	unsigned int reg;
+	struct pch_pic *priv =3D irq_data_get_irq_chip_data(d);
+
+	reg =3D readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) * 4);
+	if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
+		writel(BIT(PIC_REG_BIT(d->hwirq)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	}
+	irq_chip_ack_parent(d);
+}
+
 static struct irq_chip pch_pic_irq_chip =3D {
 	.name			=3D "PCH PIC",
 	.irq_mask		=3D pch_pic_mask_irq,
 	.irq_unmask		=3D pch_pic_unmask_irq,
-	.irq_ack		=3D irq_chip_ack_parent,
+	.irq_ack		=3D pch_pic_ack_irq,
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 	.irq_set_type		=3D pch_pic_set_type,
 };
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index 55322da51c56..b4927e425f7b 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -362,10 +362,7 @@ static int ls_scfg_msi_probe(struct platform_device *pde=
v)
=20
 	msi_data->irqs_num =3D MSI_IRQS_PER_MSIR *
 			     (1 << msi_data->cfg->ibs_shift);
-	msi_data->used =3D devm_kcalloc(&pdev->dev,
-				    BITS_TO_LONGS(msi_data->irqs_num),
-				    sizeof(*msi_data->used),
-				    GFP_KERNEL);
+	msi_data->used =3D devm_bitmap_zalloc(&pdev->dev, msi_data->irqs_num, GFP_K=
ERNEL);
 	if (!msi_data->used)
 		return -ENOMEM;
 	/*
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysir=
q.c
index 6ff98b87e5c0..586e52d5442b 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -65,6 +65,7 @@ static struct irq_chip mtk_sysirq_chip =3D {
 	.irq_set_type		=3D mtk_sysirq_set_type,
 	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_SKIP_SET_WAKE,
 };
=20
 static int mtk_sysirq_domain_translate(struct irq_domain *d,
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index 3be5c5dba1da..fe88a782173d 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -210,9 +210,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		gicp->spi_cnt +=3D gicp->spi_ranges[i].count;
 	}
=20
-	gicp->spi_bitmap =3D devm_kcalloc(&pdev->dev,
-				BITS_TO_LONGS(gicp->spi_cnt), sizeof(long),
-				GFP_KERNEL);
+	gicp->spi_bitmap =3D devm_bitmap_zalloc(&pdev->dev, gicp->spi_cnt, GFP_KERN=
EL);
 	if (!gicp->spi_bitmap)
 		return -ENOMEM;
=20
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odm=
i.c
index b4d367868dbb..dc4145abdd6f 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -171,8 +171,7 @@ static int __init mvebu_odmi_init(struct device_node *nod=
e,
 	if (!odmis)
 		return -ENOMEM;
=20
-	odmis_bm =3D kcalloc(BITS_TO_LONGS(odmis_count * NODMIS_PER_FRAME),
-			   sizeof(long), GFP_KERNEL);
+	odmis_bm =3D bitmap_zalloc(odmis_count * NODMIS_PER_FRAME, GFP_KERNEL);
 	if (!odmis_bm) {
 		ret =3D -ENOMEM;
 		goto err_alloc;
@@ -227,7 +226,7 @@ static int __init mvebu_odmi_init(struct device_node *nod=
e,
 		if (odmi->base && !IS_ERR(odmi->base))
 			iounmap(odmis[i].base);
 	}
-	kfree(odmis_bm);
+	bitmap_free(odmis_bm);
 err_alloc:
 	kfree(odmis);
 	return ret;
diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-par=
tition-percpu.c
index 89c23a1566dc..8e76d2913e6b 100644
--- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -215,8 +215,7 @@ struct partition_desc *partition_create_desc(struct fwnod=
e_handle *fwnode,
 		goto out;
 	desc->domain =3D d;
=20
-	desc->bitmap =3D kcalloc(BITS_TO_LONGS(nr_parts), sizeof(long),
-			       GFP_KERNEL);
+	desc->bitmap =3D bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
 		goto out;
=20
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 32d59202d408..173e6520e06e 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -53,26 +53,6 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
=20
-static int qcom_pdc_gic_get_irqchip_state(struct irq_data *d,
-					  enum irqchip_irq_state which,
-					  bool *state)
-{
-	if (d->hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return 0;
-
-	return irq_chip_get_parent_state(d, which, state);
-}
-
-static int qcom_pdc_gic_set_irqchip_state(struct irq_data *d,
-					  enum irqchip_irq_state which,
-					  bool value)
-{
-	if (d->hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return 0;
-
-	return irq_chip_set_parent_state(d, which, value);
-}
-
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out =3D d->hwirq;
@@ -91,38 +71,16 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
=20
 static void qcom_pdc_gic_disable(struct irq_data *d)
 {
-	if (d->hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return;
-
 	pdc_enable_intr(d, false);
 	irq_chip_disable_parent(d);
 }
=20
 static void qcom_pdc_gic_enable(struct irq_data *d)
 {
-	if (d->hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return;
-
 	pdc_enable_intr(d, true);
 	irq_chip_enable_parent(d);
 }
=20
-static void qcom_pdc_gic_mask(struct irq_data *d)
-{
-	if (d->hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return;
-
-	irq_chip_mask_parent(d);
-}
-
-static void qcom_pdc_gic_unmask(struct irq_data *d)
-{
-	if (d->hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return;
-
-	irq_chip_unmask_parent(d);
-}
-
 /*
  * GIC does not handle falling edge or active low. To allow falling edge and
  * active low interrupts to be handled at GIC, PDC has an inverter that inve=
rts
@@ -159,14 +117,10 @@ enum pdc_irq_config_bits {
  */
 static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 {
-	int pin_out =3D d->hwirq;
 	enum pdc_irq_config_bits pdc_type;
 	enum pdc_irq_config_bits old_pdc_type;
 	int ret;
=20
-	if (pin_out =3D=3D GPIO_NO_WAKE_IRQ)
-		return 0;
-
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		pdc_type =3D PDC_EDGE_RISING;
@@ -191,8 +145,8 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsi=
gned int type)
 		return -EINVAL;
 	}
=20
-	old_pdc_type =3D pdc_reg_read(IRQ_i_CFG, pin_out);
-	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
+	old_pdc_type =3D pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
=20
 	ret =3D irq_chip_set_type_parent(d, type);
 	if (ret)
@@ -216,12 +170,12 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, un=
signed int type)
 static struct irq_chip qcom_pdc_gic_chip =3D {
 	.name			=3D "PDC",
 	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_mask		=3D qcom_pdc_gic_mask,
-	.irq_unmask		=3D qcom_pdc_gic_unmask,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
 	.irq_disable		=3D qcom_pdc_gic_disable,
 	.irq_enable		=3D qcom_pdc_gic_enable,
-	.irq_get_irqchip_state	=3D qcom_pdc_gic_get_irqchip_state,
-	.irq_set_irqchip_state	=3D qcom_pdc_gic_set_irqchip_state,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
 	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
 	.irq_set_type		=3D qcom_pdc_gic_set_type,
 	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
@@ -282,7 +236,7 @@ static int qcom_pdc_alloc(struct irq_domain *domain, unsi=
gned int virq,
=20
 	parent_hwirq =3D get_parent_hwirq(hwirq);
 	if (parent_hwirq =3D=3D PDC_NO_PARENT_IRQ)
-		return 0;
+		return irq_domain_disconnect_hierarchy(domain->parent, virq);
=20
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		type =3D IRQ_TYPE_EDGE_RISING;
@@ -319,17 +273,17 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domai=
n, unsigned int virq,
 	if (ret)
 		return ret;
=20
+	if (hwirq =3D=3D GPIO_NO_WAKE_IRQ)
+		return irq_domain_disconnect_hierarchy(domain, virq);
+
 	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 					    &qcom_pdc_gic_chip, NULL);
 	if (ret)
 		return ret;
=20
-	if (hwirq =3D=3D GPIO_NO_WAKE_IRQ)
-		return 0;
-
 	parent_hwirq =3D get_parent_hwirq(hwirq);
 	if (parent_hwirq =3D=3D PDC_NO_PARENT_IRQ)
-		return 0;
+		return irq_domain_disconnect_hierarchy(domain->parent, virq);
=20
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		type =3D IRQ_TYPE_EDGE_RISING;
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3bde7fda755f..287da20f1231 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2364,7 +2364,7 @@ static bool read_mailbox_0(void)
=20
 		for (n =3D 0; n < NUM_PRCMU_WAKEUPS; n++) {
 			if (ev & prcmu_irq_bit[n])
-				generic_handle_irq(irq_find_mapping(db8500_irq_domain, n));
+				generic_handle_domain_irq(db8500_irq_domain, n);
 		}
 		r =3D true;
 		break;
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 5f6f0a83e1c5..37e5e02a1d05 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -35,10 +35,10 @@ static void mx25_tsadc_irq_handler(struct irq_desc *desc)
 	regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
=20
 	if (status & MX25_TGSR_GCQ_INT)
-		generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
+		generic_handle_domain_irq(tsadc->domain, 1);
=20
 	if (status & MX25_TGSR_TCQ_INT)
-		generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
+		generic_handle_domain_irq(tsadc->domain, 0);
=20
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 99b9c113f964..58656837b7c6 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -105,19 +105,15 @@ static void ioc3_irq_handler(struct irq_desc *desc)
 	struct ioc3_priv_data *ipd =3D domain->host_data;
 	struct ioc3 __iomem *regs =3D ipd->regs;
 	u32 pending, mask;
-	unsigned int irq;
=20
 	pending =3D readl(&regs->sio_ir);
 	mask =3D readl(&regs->sio_ies);
 	pending &=3D mask; /* Mask off not enabled interrupts */
=20
-	if (pending) {
-		irq =3D irq_find_mapping(domain, __ffs(pending));
-		if (irq)
-			generic_handle_irq(irq);
-	} else  {
+	if (pending)
+		generic_handle_domain_irq(domain, __ffs(pending));
+	else
 		spurious_interrupt();
-	}
 }
=20
 /*
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index acd172ddcbd6..ec18a04de355 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -122,7 +122,7 @@ pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int =
bp, unsigned int cp)
=20
 static int pm8xxx_irq_block_handler(struct pm_irq_chip *chip, int block)
 {
-	int pmirq, irq, i, ret =3D 0;
+	int pmirq, i, ret =3D 0;
 	unsigned int bits;
=20
 	ret =3D pm8xxx_read_block_irq(chip, block, &bits);
@@ -139,8 +139,7 @@ static int pm8xxx_irq_block_handler(struct pm_irq_chip *c=
hip, int block)
 	for (i =3D 0; i < 8; i++) {
 		if (bits & (1 << i)) {
 			pmirq =3D block * 8 + i;
-			irq =3D irq_find_mapping(chip->irqdomain, pmirq);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(chip->irqdomain, pmirq);
 		}
 	}
 	return 0;
@@ -199,7 +198,7 @@ static void pm8xxx_irq_handler(struct irq_desc *desc)
 static void pm8821_irq_block_handler(struct pm_irq_chip *chip,
 				     int master, int block)
 {
-	int pmirq, irq, i, ret;
+	int pmirq, i, ret;
 	unsigned int bits;
=20
 	ret =3D regmap_read(chip->regmap,
@@ -216,8 +215,7 @@ static void pm8821_irq_block_handler(struct pm_irq_chip *=
chip,
 	for (i =3D 0; i < 8; i++) {
 		if (bits & BIT(i)) {
 			pmirq =3D block * 8 + i;
-			irq =3D irq_find_mapping(chip->irqdomain, pmirq);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(chip->irqdomain, pmirq);
 		}
 	}
 }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index e5e75331b415..6eb0ae39deae 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -129,94 +129,95 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return default_restore_msi_irqs(dev);
 }
=20
-static inline __attribute_const__ u32 msi_mask(unsigned x)
-{
-	/* Don't shift by >=3D width of type */
-	if (x >=3D 5)
-		return 0xffffffff;
-	return (1 << (1 << x)) - 1;
-}
-
 /*
  * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
  * mask all MSI interrupts by clearing the MSI enable bit does not work
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
+{
+	/* Don't shift by >=3D width of type */
+	if (desc->msi_attrib.multi_cap >=3D 5)
+		return 0xffffffff;
+	return (1 << (1 << desc->msi_attrib.multi_cap)) - 1;
+}
+
+static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u=
32 set)
 {
 	raw_spinlock_t *lock =3D &desc->dev->msi_lock;
 	unsigned long flags;
=20
-	if (pci_msi_ignore_mask || !desc->msi_attrib.maskbit)
-		return;
-
 	raw_spin_lock_irqsave(lock, flags);
-	desc->masked &=3D ~mask;
-	desc->masked |=3D flag;
+	desc->msi_mask &=3D ~clear;
+	desc->msi_mask |=3D set;
 	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       desc->masked);
+			       desc->msi_mask);
 	raw_spin_unlock_irqrestore(lock, flags);
 }
=20
-static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
 {
-	__pci_msi_desc_mask_irq(desc, mask, flag);
+	pci_msi_update_mask(desc, 0, mask);
 }
=20
-static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
 {
-	if (desc->msi_attrib.is_virtual)
-		return NULL;
+	pci_msi_update_mask(desc, mask, 0);
+}
=20
-	return desc->mask_base +
-		desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
+{
+	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
 }
=20
 /*
- * This internal function does not flush PCI writes to the device.
- * All users must ensure that they read from the device before either
- * assuming that the device state is up to date, or returning out of this
- * file.  This saves a few milliseconds when initialising devices with lots
- * of MSI-X interrupts.
+ * This internal function does not flush PCI writes to the device.  All
+ * users must ensure that they read from the device before either assuming
+ * that the device state is up to date, or returning out of this file.
+ * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
  */
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
+static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
-	u32 mask_bits =3D desc->masked;
-	void __iomem *desc_addr;
-
-	if (pci_msi_ignore_mask)
-		return 0;
-
-	desc_addr =3D pci_msix_desc_addr(desc);
-	if (!desc_addr)
-		return 0;
+	void __iomem *desc_addr =3D pci_msix_desc_addr(desc);
=20
-	mask_bits &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	if (flag & PCI_MSIX_ENTRY_CTRL_MASKBIT)
-		mask_bits |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+}
=20
-	writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	desc->msix_ctrl |=3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
+	/* Flush write to device */
+	readl(desc->mask_base);
+}
=20
-	return mask_bits;
+static inline void pci_msix_unmask(struct msi_desc *desc)
+{
+	desc->msix_ctrl &=3D ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	pci_msix_write_vector_ctrl(desc, desc->msix_ctrl);
 }
=20
-static void msix_mask_irq(struct msi_desc *desc, u32 flag)
+static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	desc->masked =3D __pci_msix_desc_mask_irq(desc, flag);
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
+
+	if (desc->msi_attrib.is_msix)
+		pci_msix_mask(desc);
+	else if (desc->msi_attrib.maskbit)
+		pci_msi_mask(desc, mask);
 }
=20
-static void msi_set_mask_bit(struct irq_data *data, u32 flag)
+static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+		return;
=20
-	if (desc->msi_attrib.is_msix) {
-		msix_mask_irq(desc, flag);
-		readl(desc->mask_base);		/* Flush write to device */
-	} else {
-		unsigned offset =3D data->irq - desc->irq;
-		msi_mask_irq(desc, 1 << offset, flag << offset);
-	}
+	if (desc->msi_attrib.is_msix)
+		pci_msix_unmask(desc);
+	else if (desc->msi_attrib.maskbit)
+		pci_msi_unmask(desc, mask);
 }
=20
 /**
@@ -225,7 +226,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 f=
lag)
  */
 void pci_msi_mask_irq(struct irq_data *data)
 {
-	msi_set_mask_bit(data, 1);
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+
+	__pci_msi_mask_desc(desc, BIT(data->irq - desc->irq));
 }
 EXPORT_SYMBOL_GPL(pci_msi_mask_irq);
=20
@@ -235,7 +238,9 @@ EXPORT_SYMBOL_GPL(pci_msi_mask_irq);
  */
 void pci_msi_unmask_irq(struct irq_data *data)
 {
-	msi_set_mask_bit(data, 0);
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+
+	__pci_msi_unmask_desc(desc, BIT(data->irq - desc->irq));
 }
 EXPORT_SYMBOL_GPL(pci_msi_unmask_irq);
=20
@@ -256,10 +261,8 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct m=
si_msg *msg)
 	if (entry->msi_attrib.is_msix) {
 		void __iomem *base =3D pci_msix_desc_addr(entry);
=20
-		if (!base) {
-			WARN_ON(1);
+		if (WARN_ON_ONCE(entry->msi_attrib.is_virtual))
 			return;
-		}
=20
 		msg->address_lo =3D readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		msg->address_hi =3D readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
@@ -290,9 +293,10 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct =
msi_msg *msg)
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base =3D pci_msix_desc_addr(entry);
-		bool unmasked =3D !(entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT);
+		u32 ctrl =3D entry->msix_ctrl;
+		bool unmasked =3D !(ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
=20
-		if (!base)
+		if (entry->msi_attrib.is_virtual)
 			goto skip;
=20
 		/*
@@ -304,14 +308,14 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct=
 msi_msg *msg)
 		 * undefined."
 		 */
 		if (unmasked)
-			__pci_msix_desc_mask_irq(entry, PCI_MSIX_ENTRY_CTRL_MASKBIT);
+			pci_msix_write_vector_ctrl(entry, ctrl | PCI_MSIX_ENTRY_CTRL_MASKBIT);
=20
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
=20
 		if (unmasked)
-			__pci_msix_desc_mask_irq(entry, 0);
+			pci_msix_write_vector_ctrl(entry, ctrl);
=20
 		/* Ensure that the writes are visible in the device */
 		readl(base + PCI_MSIX_ENTRY_DATA);
@@ -359,9 +363,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 {
 	struct list_head *msi_list =3D dev_to_msi_list(&dev->dev);
 	struct msi_desc *entry, *tmp;
-	struct attribute **msi_attrs;
-	struct device_attribute *dev_attr;
-	int i, count =3D 0;
+	int i;
=20
 	for_each_pci_msi_entry(entry, dev)
 		if (entry->irq)
@@ -381,18 +383,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 	}
=20
 	if (dev->msi_irq_groups) {
-		sysfs_remove_groups(&dev->dev.kobj, dev->msi_irq_groups);
-		msi_attrs =3D dev->msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr =3D container_of(msi_attrs[count],
-						struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(dev->msi_irq_groups[0]);
-		kfree(dev->msi_irq_groups);
+		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
 		dev->msi_irq_groups =3D NULL;
 	}
 }
@@ -429,8 +420,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	arch_restore_msi_irqs(dev);
=20
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
-		     entry->masked);
+	pci_msi_update_mask(entry, 0, 0);
 	control &=3D ~PCI_MSI_FLAGS_QSIZE;
 	control |=3D (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
@@ -461,7 +451,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
=20
 	arch_restore_msi_irqs(dev);
 	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->masked);
+		pci_msix_write_vector_ctrl(entry, entry->msix_ctrl);
=20
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -473,102 +463,6 @@ void pci_restore_msi_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_restore_msi_state);
=20
-static ssize_t msi_mode_show(struct device *dev, struct device_attribute *at=
tr,
-			     char *buf)
-{
-	struct msi_desc *entry;
-	unsigned long irq;
-	int retval;
-
-	retval =3D kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry =3D irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%s\n",
-			  entry->msi_attrib.is_msix ? "msix" : "msi");
-}
-
-static int populate_msi_sysfs(struct pci_dev *pdev)
-{
-	struct attribute **msi_attrs;
-	struct attribute *msi_attr;
-	struct device_attribute *msi_dev_attr;
-	struct attribute_group *msi_irq_group;
-	const struct attribute_group **msi_irq_groups;
-	struct msi_desc *entry;
-	int ret =3D -ENOMEM;
-	int num_msi =3D 0;
-	int count =3D 0;
-	int i;
-
-	/* Determine how many msi entries we have */
-	for_each_pci_msi_entry(entry, pdev)
-		num_msi +=3D entry->nvec_used;
-	if (!num_msi)
-		return 0;
-
-	/* Dynamically create the MSI attributes for the PCI device */
-	msi_attrs =3D kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
-	if (!msi_attrs)
-		return -ENOMEM;
-	for_each_pci_msi_entry(entry, pdev) {
-		for (i =3D 0; i < entry->nvec_used; i++) {
-			msi_dev_attr =3D kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-			if (!msi_dev_attr)
-				goto error_attrs;
-			msi_attrs[count] =3D &msi_dev_attr->attr;
-
-			sysfs_attr_init(&msi_dev_attr->attr);
-			msi_dev_attr->attr.name =3D kasprintf(GFP_KERNEL, "%d",
-							    entry->irq + i);
-			if (!msi_dev_attr->attr.name)
-				goto error_attrs;
-			msi_dev_attr->attr.mode =3D S_IRUGO;
-			msi_dev_attr->show =3D msi_mode_show;
-			++count;
-		}
-	}
-
-	msi_irq_group =3D kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-	if (!msi_irq_group)
-		goto error_attrs;
-	msi_irq_group->name =3D "msi_irqs";
-	msi_irq_group->attrs =3D msi_attrs;
-
-	msi_irq_groups =3D kcalloc(2, sizeof(void *), GFP_KERNEL);
-	if (!msi_irq_groups)
-		goto error_irq_group;
-	msi_irq_groups[0] =3D msi_irq_group;
-
-	ret =3D sysfs_create_groups(&pdev->dev.kobj, msi_irq_groups);
-	if (ret)
-		goto error_irq_groups;
-	pdev->msi_irq_groups =3D msi_irq_groups;
-
-	return 0;
-
-error_irq_groups:
-	kfree(msi_irq_groups);
-error_irq_group:
-	kfree(msi_irq_group);
-error_attrs:
-	count =3D 0;
-	msi_attr =3D msi_attrs[count];
-	while (msi_attr) {
-		msi_dev_attr =3D container_of(msi_attr, struct device_attribute, attr);
-		kfree(msi_attr->name);
-		kfree(msi_dev_attr);
-		++count;
-		msi_attr =3D msi_attrs[count];
-	}
-	kfree(msi_attrs);
-	return ret;
-}
-
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -602,7 +496,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq=
_affinity *affd)
=20
 	/* Save the initial mask status */
 	if (entry->msi_attrib.maskbit)
-		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
+		pci_read_config_dword(dev, entry->mask_pos, &entry->msi_mask);
=20
 out:
 	kfree(masks);
@@ -613,8 +507,11 @@ static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
=20
+	if (!dev->no_64bit_msi)
+		return 0;
+
 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->msg.address_hi && dev->no_64bit_msi) {
+		if (entry->msg.address_hi) {
 			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only su=
pports 32 bits\n",
 				entry->msg.address_hi, entry->msg.address_lo);
 			return -EIO;
@@ -640,7 +537,6 @@ static int msi_capability_init(struct pci_dev *dev, int n=
vec,
 {
 	struct msi_desc *entry;
 	int ret;
-	unsigned mask;
=20
 	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
=20
@@ -649,31 +545,23 @@ static int msi_capability_init(struct pci_dev *dev, int=
 nvec,
 		return -ENOMEM;
=20
 	/* All MSIs are unmasked by default; mask them all */
-	mask =3D msi_mask(entry->msi_attrib.multi_cap);
-	msi_mask_irq(entry, mask, mask);
+	pci_msi_mask(entry, msi_multi_mask(entry));
=20
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
=20
 	/* Configure MSI capability structure */
 	ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
=20
 	ret =3D msi_verify_entries(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
=20
-	ret =3D populate_msi_sysfs(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
+	dev->msi_irq_groups =3D msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(dev->msi_irq_groups)) {
+		ret =3D PTR_ERR(dev->msi_irq_groups);
+		goto err;
 	}
=20
 	/* Set MSI enabled bits	*/
@@ -684,6 +572,11 @@ static int msi_capability_init(struct pci_dev *dev, int =
nvec,
 	pcibios_free_irq(dev);
 	dev->irq =3D entry->irq;
 	return 0;
+
+err:
+	pci_msi_unmask(entry, msi_multi_mask(entry));
+	free_msi_irqs(dev);
+	return ret;
 }
=20
 static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entrie=
s)
@@ -745,9 +638,10 @@ static int msix_setup_entries(struct pci_dev *dev, void =
__iomem *base,
 		entry->msi_attrib.default_irq	=3D dev->irq;
 		entry->mask_base		=3D base;
=20
-		addr =3D pci_msix_desc_addr(entry);
-		if (addr)
-			entry->masked =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+		if (!entry->msi_attrib.is_virtual) {
+			addr =3D pci_msix_desc_addr(entry);
+			entry->msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+		}
=20
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)
@@ -833,9 +727,11 @@ static int msix_capability_init(struct pci_dev *dev, str=
uct msix_entry *entries,
=20
 	msix_update_entries(dev, entries);
=20
-	ret =3D populate_msi_sysfs(dev);
-	if (ret)
+	dev->msi_irq_groups =3D msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(dev->msi_irq_groups)) {
+		ret =3D PTR_ERR(dev->msi_irq_groups);
 		goto out_free;
+	}
=20
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
@@ -948,7 +844,6 @@ EXPORT_SYMBOL(pci_msi_vec_count);
 static void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
-	u32 mask;
=20
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
@@ -961,8 +856,7 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	dev->msi_enabled =3D 0;
=20
 	/* Return the device with MSI unmasked as initial states */
-	mask =3D msi_mask(desc->msi_attrib.multi_cap);
-	msi_mask_irq(desc, mask, 0);
+	pci_msi_unmask(desc, msi_multi_mask(desc));
=20
 	/* Restore dev->irq to its default pin-assertion IRQ */
 	dev->irq =3D desc->msi_attrib.default_irq;
@@ -1048,7 +942,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
=20
 	/* Return the device with MSI-X masked as initial states */
 	for_each_pci_msi_entry(entry, dev)
-		__pci_msix_desc_mask_irq(entry, 1);
+		pci_msix_mask(entry);
=20
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/=
pinctrl-owl.c
index c8b3e396ea27..781f2200ed58 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -833,7 +833,7 @@ static void owl_gpio_irq_handler(struct irq_desc *desc)
 	unsigned int parent =3D irq_desc_get_irq(desc);
 	const struct owl_gpio_port *port;
 	void __iomem *base;
-	unsigned int pin, irq, offset =3D 0, i;
+	unsigned int pin, offset =3D 0, i;
 	unsigned long pending_irq;
=20
 	chained_irq_enter(chip, desc);
@@ -849,8 +849,7 @@ static void owl_gpio_irq_handler(struct irq_desc *desc)
 		pending_irq =3D readl_relaxed(base + port->intc_pd);
=20
 		for_each_set_bit(pin, &pending_irq, port->pins) {
-			irq =3D irq_find_mapping(domain, offset + pin);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(domain, offset + pin);
=20
 			/* clear pending interrupt */
 			owl_gpio_update_reg(base + port->intc_pd, pin, true);
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinc=
trl-bcm2835.c
index 2c87af1180c4..8b34d2c308c7 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -395,8 +395,8 @@ static void bcm2835_gpio_irq_handle_bank(struct bcm2835_p=
inctrl *pc,
 	events &=3D pc->enabled_irq_map[bank];
 	for_each_set_bit(offset, &events, 32) {
 		gpio =3D (32 * bank) + offset;
-		generic_handle_irq(irq_linear_revmap(pc->gpio_chip.irq.domain,
-						     gpio));
+		generic_handle_domain_irq(pc->gpio_chip.irq.domain,
+					  gpio);
 	}
 }
=20
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/p=
inctrl-iproc-gpio.c
index dc511b9a6b43..a7a0dd638a26 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -176,7 +176,6 @@ static void iproc_gpio_irq_handler(struct irq_desc *desc)
=20
 		for_each_set_bit(bit, &val, NGPIOS_PER_BANK) {
 			unsigned pin =3D NGPIOS_PER_BANK * i + bit;
-			int child_irq =3D irq_find_mapping(gc->irq.domain, pin);
=20
 			/*
 			 * Clear the interrupt before invoking the
@@ -185,7 +184,7 @@ static void iproc_gpio_irq_handler(struct irq_desc *desc)
 			writel(BIT(bit), chip->base + (i * GPIO_BANK_SIZE) +
 			       IPROC_GPIO_INT_CLR_OFFSET);
=20
-			generic_handle_irq(child_irq);
+			generic_handle_domain_irq(gc->irq.domain, pin);
 		}
 	}
=20
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pin=
ctrl-nsp-gpio.c
index a00a42a61a90..e03142895f61 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -155,8 +155,7 @@ static irqreturn_t nsp_gpio_irq_handler(int irq, void *da=
ta)
 		int_bits =3D level | event;
=20
 		for_each_set_bit(bit, &int_bits, gc->ngpio)
-			generic_handle_irq(
-				irq_linear_revmap(gc->irq.domain, bit));
+			generic_handle_domain_irq(gc->irq.domain, bit);
 	}
=20
 	return  int_bits ? IRQ_HANDLED : IRQ_NONE;
diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel=
/pinctrl-baytrail.c
index 394a421a19d5..8f23d126c6a7 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1444,7 +1444,6 @@ static void byt_gpio_irq_handler(struct irq_desc *desc)
 	u32 base, pin;
 	void __iomem *reg;
 	unsigned long pending;
-	unsigned int virq;
=20
 	/* check from GPIO controller which pin triggered the interrupt */
 	for (base =3D 0; base < vg->chip.ngpio; base +=3D 32) {
@@ -1460,10 +1459,8 @@ static void byt_gpio_irq_handler(struct irq_desc *desc)
 		raw_spin_lock(&byt_lock);
 		pending =3D readl(reg);
 		raw_spin_unlock(&byt_lock);
-		for_each_set_bit(pin, &pending, 32) {
-			virq =3D irq_find_mapping(vg->chip.irq.domain, base + pin);
-			generic_handle_irq(virq);
-		}
+		for_each_set_bit(pin, &pending, 32)
+			generic_handle_domain_irq(vg->chip.irq.domain, base + pin);
 	}
 	chip->irq_eoi(data);
 }
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/int=
el/pinctrl-cherryview.c
index 2ed17cdf946d..980099028cf8 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1409,11 +1409,10 @@ static void chv_gpio_irq_handler(struct irq_desc *des=
c)
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
=20
 	for_each_set_bit(intr_line, &pending, community->nirqs) {
-		unsigned int irq, offset;
+		unsigned int offset;
=20
 		offset =3D cctx->intr_lines[intr_line];
-		irq =3D irq_find_mapping(gc->irq.domain, offset);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(gc->irq.domain, offset);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/inte=
l/pinctrl-lynxpoint.c
index 0a48ca46ab59..561fa322b0b4 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -653,12 +653,8 @@ static void lp_gpio_irq_handler(struct irq_desc *desc)
 		/* Only interrupts that are enabled */
 		pending =3D ioread32(reg) & ioread32(ena);
=20
-		for_each_set_bit(pin, &pending, 32) {
-			unsigned int irq;
-
-			irq =3D irq_find_mapping(lg->chip.irq.domain, base + pin);
-			generic_handle_irq(irq);
-		}
+		for_each_set_bit(pin, &pending, 32)
+			generic_handle_domain_irq(lg->chip.irq.domain, base + pin);
 	}
 	chip->irq_eoi(data);
 }
diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/m=
tk-eint.c
index 3b9b5dbd7968..f7b54a551764 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -319,7 +319,7 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct mtk_eint *eint =3D irq_desc_get_handler_data(desc);
 	unsigned int status, eint_num;
-	int offset, mask_offset, index, virq;
+	int offset, mask_offset, index;
 	void __iomem *reg =3D  mtk_eint_get_offset(eint, 0, eint->regs->stat);
 	int dual_edge, start_level, curr_level;
=20
@@ -331,7 +331,6 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 			offset =3D __ffs(status);
 			mask_offset =3D eint_num >> 5;
 			index =3D eint_num + offset;
-			virq =3D irq_find_mapping(eint->domain, index);
 			status &=3D ~BIT(offset);
=20
 			/*
@@ -361,7 +360,7 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 								 index);
 			}
=20
-			generic_handle_irq(virq);
+			generic_handle_domain_irq(eint->domain, index);
=20
 			if (dual_edge) {
 				curr_level =3D mtk_eint_flip_edge(eint, index);
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/noma=
dik/pinctrl-nomadik.c
index abfe11c7b49f..39828e9c3120 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -815,7 +815,7 @@ static void nmk_gpio_irq_handler(struct irq_desc *desc)
 	while (status) {
 		int bit =3D __ffs(status);
=20
-		generic_handle_irq(irq_find_mapping(chip->irq.domain, bit));
+		generic_handle_domain_irq(chip->irq.domain, bit);
 		status &=3D ~BIT(bit);
 	}
=20
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvo=
ton/pinctrl-npcm7xx.c
index bb1ea47ec4c6..4d81908d6725 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -231,7 +231,7 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
=20
 	sts &=3D en;
 	for_each_set_bit(bit, (const void *)&sts, NPCM7XX_GPIO_PER_BANK)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, bit));
+		generic_handle_domain_irq(gc->irq.domain, bit);
 	chained_irq_exit(chip, desc);
 }
=20
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a76be6cc26ee..11625ed1c6c5 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -621,14 +621,12 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *=
dev_id)
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
-			irq =3D irq_find_mapping(gc->irq.domain, irqnr + i);
-			if (irq !=3D 0)
-				generic_handle_irq(irq);
+			generic_handle_domain_irq(gc->irq.domain, irqnr + i);
=20
 			/* Clear interrupt.
 			 * We must read the pin register again, in case the
 			 * value was changed while executing
-			 * generic_handle_irq() above.
+			 * generic_handle_domain_irq() above.
 			 * If we didn't find a mapping for the interrupt,
 			 * disable it in order to avoid a system hang caused
 			 * by an interrupt storm.
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 72e6df7abe8c..6022496bb6a9 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1712,10 +1712,8 @@ static void gpio_irq_handler(struct irq_desc *desc)
 			continue;
 		}
=20
-		for_each_set_bit(n, &isr, BITS_PER_LONG) {
-			generic_handle_irq(irq_find_mapping(
-					   gpio_chip->irq.domain, n));
-		}
+		for_each_set_bit(n, &isr, BITS_PER_LONG)
+			generic_handle_domain_irq(gpio_chip->irq.domain, n);
 	}
 	chained_irq_exit(chip, desc);
 	/* now it may re-trigger */
diff --git a/drivers/pinctrl/pinctrl-equilibrium.c b/drivers/pinctrl/pinctrl-=
equilibrium.c
index 38cc20fa9d5a..fb713f9c53d0 100644
--- a/drivers/pinctrl/pinctrl-equilibrium.c
+++ b/drivers/pinctrl/pinctrl-equilibrium.c
@@ -155,7 +155,7 @@ static void eqbr_irq_handler(struct irq_desc *desc)
 	pins =3D readl(gctrl->membase + GPIO_IRNCR);
=20
 	for_each_set_bit(offset, &pins, gc->ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, offset));
+		generic_handle_domain_irq(gc->irq.domain, offset);
=20
 	chained_irq_exit(ic, desc);
 }
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-inge=
nic.c
index 983ba9865f77..ce9cc719c395 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -3080,7 +3080,7 @@ static void ingenic_gpio_irq_handler(struct irq_desc *d=
esc)
 		flag =3D ingenic_gpio_read_reg(jzgc, JZ4730_GPIO_GPFR);
=20
 	for_each_set_bit(i, &flag, 32)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, i));
+		generic_handle_domain_irq(gc->irq.domain, i);
 	chained_irq_exit(irq_chip, desc);
 }
=20
diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinc=
trl-microchip-sgpio.c
index 165cb7a59715..072bccdea2a5 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -673,7 +673,7 @@ static void sgpio_irq_handler(struct irq_desc *desc)
=20
 		for_each_set_bit(port, &val, SGPIO_BITS_PER_WORD) {
 			gpio =3D sgpio_addr_to_pin(priv, port, bit);
-			generic_handle_irq(irq_linear_revmap(chip->irq.domain, gpio));
+			generic_handle_domain_irq(chip->irq.domain, gpio);
 		}
=20
 		chained_irq_exit(parent_chip, desc);
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelo=
t.c
index e470c16718de..0a36ec8775a3 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1290,8 +1290,7 @@ static void ocelot_irq_handler(struct irq_desc *desc)
=20
 		for_each_set_bit(irq, &irqs,
 				 min(32U, info->desc->npins - 32 * i))
-			generic_handle_irq(irq_linear_revmap(chip->irq.domain,
-							     irq + 32 * i));
+			generic_handle_domain_irq(chip->irq.domain, irq + 32 * i);
=20
 		chained_irq_exit(parent_chip, desc);
 	}
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index 5a312279b3c7..cebd810bd6d1 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -1055,7 +1055,7 @@ static void oxnas_gpio_irq_handler(struct irq_desc *des=
c)
 	stat =3D readl(bank->reg_base + IRQ_PENDING);
=20
 	for_each_set_bit(pin, &stat, BITS_PER_LONG)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, pin));
+		generic_handle_domain_irq(gc->irq.domain, pin);
=20
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index a6e2a4a4ca95..748dabd8db6e 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -2101,7 +2101,7 @@ static void pic32_gpio_irq_handler(struct irq_desc *des=
c)
 	pending =3D pic32_gpio_get_pending(gc, stat);
=20
 	for_each_set_bit(pin, &pending, BITS_PER_LONG)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, pin));
+		generic_handle_domain_irq(gc->irq.domain, pin);
=20
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pi=
stachio.c
index ec761ba2a2da..8d271c6b0ca4 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -1306,7 +1306,7 @@ static void pistachio_gpio_irq_handler(struct irq_desc =
*desc)
 	pending =3D gpio_readl(bank, GPIO_INTERRUPT_STATUS) &
 		gpio_readl(bank, GPIO_INTERRUPT_EN);
 	for_each_set_bit(pin, &pending, 16)
-		generic_handle_irq(irq_linear_revmap(gc->irq.domain, pin));
+		generic_handle_domain_irq(gc->irq.domain, pin);
 	chained_irq_exit(chip, desc);
 }
=20
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-roc=
kchip.c
index 067fc4208de4..ae33e376695f 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -21,8 +21,8 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
-#include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
@@ -37,35 +37,7 @@
=20
 #include "core.h"
 #include "pinconf.h"
-
-/* GPIO control registers */
-#define GPIO_SWPORT_DR		0x00
-#define GPIO_SWPORT_DDR		0x04
-#define GPIO_INTEN		0x30
-#define GPIO_INTMASK		0x34
-#define GPIO_INTTYPE_LEVEL	0x38
-#define GPIO_INT_POLARITY	0x3c
-#define GPIO_INT_STATUS		0x40
-#define GPIO_INT_RAWSTATUS	0x44
-#define GPIO_DEBOUNCE		0x48
-#define GPIO_PORTS_EOI		0x4c
-#define GPIO_EXT_PORT		0x50
-#define GPIO_LS_SYNC		0x60
-
-enum rockchip_pinctrl_type {
-	PX30,
-	RV1108,
-	RK2928,
-	RK3066B,
-	RK3128,
-	RK3188,
-	RK3288,
-	RK3308,
-	RK3368,
-	RK3399,
-	RK3568,
-};
-
+#include "pinctrl-rockchip.h"
=20
 /**
  * Generate a bitmask for setting a value (v) with a write mask bit in hiword
@@ -84,103 +56,6 @@ enum rockchip_pinctrl_type {
 #define IOMUX_WIDTH_3BIT	BIT(4)
 #define IOMUX_WIDTH_2BIT	BIT(5)
=20
-/**
- * struct rockchip_iomux
- * @type: iomux variant using IOMUX_* constants
- * @offset: if initialized to -1 it will be autocalculated, by specifying
- *	    an initial offset value the relevant source offset can be reset
- *	    to a new value for autocalculating the following iomux registers.
- */
-struct rockchip_iomux {
-	int				type;
-	int				offset;
-};
-
-/*
- * enum type index corresponding to rockchip_perpin_drv_list arrays index.
- */
-enum rockchip_pin_drv_type {
-	DRV_TYPE_IO_DEFAULT =3D 0,
-	DRV_TYPE_IO_1V8_OR_3V0,
-	DRV_TYPE_IO_1V8_ONLY,
-	DRV_TYPE_IO_1V8_3V0_AUTO,
-	DRV_TYPE_IO_3V3_ONLY,
-	DRV_TYPE_MAX
-};
-
-/*
- * enum type index corresponding to rockchip_pull_list arrays index.
- */
-enum rockchip_pin_pull_type {
-	PULL_TYPE_IO_DEFAULT =3D 0,
-	PULL_TYPE_IO_1V8_ONLY,
-	PULL_TYPE_MAX
-};
-
-/**
- * struct rockchip_drv
- * @drv_type: drive strength variant using rockchip_perpin_drv_type
- * @offset: if initialized to -1 it will be autocalculated, by specifying
- *	    an initial offset value the relevant source offset can be reset
- *	    to a new value for autocalculating the following drive strength
- *	    registers. if used chips own cal_drv func instead to calculate
- *	    registers offset, the variant could be ignored.
- */
-struct rockchip_drv {
-	enum rockchip_pin_drv_type	drv_type;
-	int				offset;
-};
-
-/**
- * struct rockchip_pin_bank
- * @reg_base: register base of the gpio bank
- * @regmap_pull: optional separate register for additional pull settings
- * @clk: clock of the gpio bank
- * @irq: interrupt of the gpio bank
- * @saved_masks: Saved content of GPIO_INTEN at suspend time.
- * @pin_base: first pin number
- * @nr_pins: number of pins in this bank
- * @name: name of the bank
- * @bank_num: number of the bank, to account for holes
- * @iomux: array describing the 4 iomux sources of the bank
- * @drv: array describing the 4 drive strength sources of the bank
- * @pull_type: array describing the 4 pull type sources of the bank
- * @valid: is all necessary information present
- * @of_node: dt node of this bank
- * @drvdata: common pinctrl basedata
- * @domain: irqdomain of the gpio bank
- * @gpio_chip: gpiolib chip
- * @grange: gpio range
- * @slock: spinlock for the gpio bank
- * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
- * @recalced_mask: bit mask to indicate a need to recalulate the mask
- * @route_mask: bits describing the routing pins of per bank
- */
-struct rockchip_pin_bank {
-	void __iomem			*reg_base;
-	struct regmap			*regmap_pull;
-	struct clk			*clk;
-	int				irq;
-	u32				saved_masks;
-	u32				pin_base;
-	u8				nr_pins;
-	char				*name;
-	u8				bank_num;
-	struct rockchip_iomux		iomux[4];
-	struct rockchip_drv		drv[4];
-	enum rockchip_pin_pull_type	pull_type[4];
-	bool				valid;
-	struct device_node		*of_node;
-	struct rockchip_pinctrl		*drvdata;
-	struct irq_domain		*domain;
-	struct gpio_chip		gpio_chip;
-	struct pinctrl_gpio_range	grange;
-	raw_spinlock_t			slock;
-	u32				toggle_edge_mode;
-	u32				recalced_mask;
-	u32				route_mask;
-};
-
 #define PIN_BANK(id, pins, label)			\
 	{						\
 		.bank_num	=3D id,			\
@@ -320,119 +195,6 @@ struct rockchip_pin_bank {
 #define RK_MUXROUTE_PMU(ID, PIN, FUNC, REG, VAL)	\
 	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROCKCHIP_ROUTE_PMU)
=20
-/**
- * struct rockchip_mux_recalced_data: represent a pin iomux data.
- * @num: bank number.
- * @pin: pin number.
- * @bit: index at register.
- * @reg: register offset.
- * @mask: mask bit
- */
-struct rockchip_mux_recalced_data {
-	u8 num;
-	u8 pin;
-	u32 reg;
-	u8 bit;
-	u8 mask;
-};
-
-enum rockchip_mux_route_location {
-	ROCKCHIP_ROUTE_SAME =3D 0,
-	ROCKCHIP_ROUTE_PMU,
-	ROCKCHIP_ROUTE_GRF,
-};
-
-/**
- * struct rockchip_mux_recalced_data: represent a pin iomux data.
- * @bank_num: bank number.
- * @pin: index at register or used to calc index.
- * @func: the min pin.
- * @route_location: the mux route location (same, pmu, grf).
- * @route_offset: the max pin.
- * @route_val: the register offset.
- */
-struct rockchip_mux_route_data {
-	u8 bank_num;
-	u8 pin;
-	u8 func;
-	enum rockchip_mux_route_location route_location;
-	u32 route_offset;
-	u32 route_val;
-};
-
-struct rockchip_pin_ctrl {
-	struct rockchip_pin_bank	*pin_banks;
-	u32				nr_banks;
-	u32				nr_pins;
-	char				*label;
-	enum rockchip_pinctrl_type	type;
-	int				grf_mux_offset;
-	int				pmu_mux_offset;
-	int				grf_drv_offset;
-	int				pmu_drv_offset;
-	struct rockchip_mux_recalced_data *iomux_recalced;
-	u32				niomux_recalced;
-	struct rockchip_mux_route_data *iomux_routes;
-	u32				niomux_routes;
-
-	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
-				    int pin_num, struct regmap **regmap,
-				    int *reg, u8 *bit);
-};
-
-struct rockchip_pin_config {
-	unsigned int		func;
-	unsigned long		*configs;
-	unsigned int		nconfigs;
-};
-
-/**
- * struct rockchip_pin_group: represent group of pins of a pinmux function.
- * @name: name of the pin group, used to lookup the group.
- * @pins: the pins included in this group.
- * @npins: number of pins included in this group.
- * @data: local pin configuration
- */
-struct rockchip_pin_group {
-	const char			*name;
-	unsigned int			npins;
-	unsigned int			*pins;
-	struct rockchip_pin_config	*data;
-};
-
-/**
- * struct rockchip_pmx_func: represent a pin function.
- * @name: name of the pin function, used to lookup the function.
- * @groups: one or more names of pin groups that provide this function.
- * @ngroups: number of groups included in @groups.
- */
-struct rockchip_pmx_func {
-	const char		*name;
-	const char		**groups;
-	u8			ngroups;
-};
-
-struct rockchip_pinctrl {
-	struct regmap			*regmap_base;
-	int				reg_size;
-	struct regmap			*regmap_pull;
-	struct regmap			*regmap_pmu;
-	struct device			*dev;
-	struct rockchip_pin_ctrl	*ctrl;
-	struct pinctrl_desc		pctl;
-	struct pinctrl_dev		*pctl_dev;
-	struct rockchip_pin_group	*groups;
-	unsigned int			ngroups;
-	struct rockchip_pmx_func	*functions;
-	unsigned int			nfunctions;
-};
-
 static struct regmap_config rockchip_regmap_config =3D {
 	.reg_bits =3D 32,
 	.val_bits =3D 32,
@@ -2295,86 +2057,11 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctld=
ev, unsigned selector,
 	return 0;
 }
=20
-static int rockchip_gpio_get_direction(struct gpio_chip *chip, unsigned offs=
et)
-{
-	struct rockchip_pin_bank *bank =3D gpiochip_get_data(chip);
-	u32 data;
-	int ret;
-
-	ret =3D clk_enable(bank->clk);
-	if (ret < 0) {
-		dev_err(bank->drvdata->dev,
-			"failed to enable clock for bank %s\n", bank->name);
-		return ret;
-	}
-	data =3D readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
-	clk_disable(bank->clk);
-
-	if (data & BIT(offset))
-		return GPIO_LINE_DIRECTION_OUT;
-
-	return GPIO_LINE_DIRECTION_IN;
-}
-
-/*
- * The calls to gpio_direction_output() and gpio_direction_input()
- * leads to this function call (via the pinctrl_gpio_direction_{input|output=
}()
- * function called from the gpiolib interface).
- */
-static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
-					    int pin, bool input)
-{
-	struct rockchip_pin_bank *bank;
-	int ret;
-	unsigned long flags;
-	u32 data;
-
-	bank =3D gpiochip_get_data(chip);
-
-	ret =3D rockchip_set_mux(bank, pin, RK_FUNC_GPIO);
-	if (ret < 0)
-		return ret;
-
-	clk_enable(bank->clk);
-	raw_spin_lock_irqsave(&bank->slock, flags);
-
-	data =3D readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
-	/* set bit to 1 for output, 0 for input */
-	if (!input)
-		data |=3D BIT(pin);
-	else
-		data &=3D ~BIT(pin);
-	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
-
-	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
-
-	return 0;
-}
-
-static int rockchip_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
-					      struct pinctrl_gpio_range *range,
-					      unsigned offset, bool input)
-{
-	struct rockchip_pinctrl *info =3D pinctrl_dev_get_drvdata(pctldev);
-	struct gpio_chip *chip;
-	int pin;
-
-	chip =3D range->gc;
-	pin =3D offset - chip->base;
-	dev_dbg(info->dev, "gpio_direction for pin %u as %s-%d to %s\n",
-		 offset, range->name, pin, input ? "input" : "output");
-
-	return _rockchip_pmx_gpio_set_direction(chip, offset - chip->base,
-						input);
-}
-
 static const struct pinmux_ops rockchip_pmx_ops =3D {
 	.get_functions_count	=3D rockchip_pmx_get_funcs_count,
 	.get_function_name	=3D rockchip_pmx_get_func_name,
 	.get_function_groups	=3D rockchip_pmx_get_groups,
 	.set_mux		=3D rockchip_pmx_set,
-	.gpio_set_direction	=3D rockchip_pmx_gpio_set_direction,
 };
=20
 /*
@@ -2405,15 +2092,13 @@ static bool rockchip_pinconf_pull_valid(struct rockch=
ip_pin_ctrl *ctrl,
 	return false;
 }
=20
-static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int val=
ue);
-static int rockchip_gpio_get(struct gpio_chip *gc, unsigned offset);
-
 /* set the pin config settings for a specified pin */
 static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pi=
n,
 				unsigned long *configs, unsigned num_configs)
 {
 	struct rockchip_pinctrl *info =3D pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank =3D pin_to_bank(info, pin);
+	struct gpio_chip *gpio =3D &bank->gpio_chip;
 	enum pin_config_param param;
 	u32 arg;
 	int i;
@@ -2446,10 +2131,13 @@ static int rockchip_pinconf_set(struct pinctrl_dev *p=
ctldev, unsigned int pin,
 				return rc;
 			break;
 		case PIN_CONFIG_OUTPUT:
-			rockchip_gpio_set(&bank->gpio_chip,
-					  pin - bank->pin_base, arg);
-			rc =3D _rockchip_pmx_gpio_set_direction(&bank->gpio_chip,
-					  pin - bank->pin_base, false);
+			rc =3D rockchip_set_mux(bank, pin - bank->pin_base,
+					      RK_FUNC_GPIO);
+			if (rc !=3D RK_FUNC_GPIO)
+				return -EINVAL;
+
+			rc =3D gpio->direction_output(gpio, pin - bank->pin_base,
+						    arg);
 			if (rc)
 				return rc;
 			break;
@@ -2487,6 +2175,7 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pct=
ldev, unsigned int pin,
 {
 	struct rockchip_pinctrl *info =3D pinctrl_dev_get_drvdata(pctldev);
 	struct rockchip_pin_bank *bank =3D pin_to_bank(info, pin);
+	struct gpio_chip *gpio =3D &bank->gpio_chip;
 	enum pin_config_param param =3D pinconf_to_config_param(*config);
 	u16 arg;
 	int rc;
@@ -2515,7 +2204,7 @@ static int rockchip_pinconf_get(struct pinctrl_dev *pct=
ldev, unsigned int pin,
 		if (rc !=3D RK_FUNC_GPIO)
 			return -EINVAL;
=20
-		rc =3D rockchip_gpio_get(&bank->gpio_chip, pin - bank->pin_base);
+		rc =3D gpio->get(gpio, pin - bank->pin_base);
 		if (rc < 0)
 			return rc;
=20
@@ -2753,7 +2442,7 @@ static int rockchip_pinctrl_register(struct platform_de=
vice *pdev,
 	ctrldesc->npins =3D info->ctrl->nr_pins;
=20
 	pdesc =3D pindesc;
-	for (bank =3D 0 , k =3D 0; bank < info->ctrl->nr_banks; bank++) {
+	for (bank =3D 0, k =3D 0; bank < info->ctrl->nr_banks; bank++) {
 		pin_bank =3D &info->ctrl->pin_banks[bank];
 		for (pin =3D 0; pin < pin_bank->nr_pins; pin++, k++) {
 			pdesc->number =3D k;
@@ -2773,553 +2462,9 @@ static int rockchip_pinctrl_register(struct platform_=
device *pdev,
 		return PTR_ERR(info->pctl_dev);
 	}
=20
-	for (bank =3D 0; bank < info->ctrl->nr_banks; ++bank) {
-		pin_bank =3D &info->ctrl->pin_banks[bank];
-		pin_bank->grange.name =3D pin_bank->name;
-		pin_bank->grange.id =3D bank;
-		pin_bank->grange.pin_base =3D pin_bank->pin_base;
-		pin_bank->grange.base =3D pin_bank->gpio_chip.base;
-		pin_bank->grange.npins =3D pin_bank->gpio_chip.ngpio;
-		pin_bank->grange.gc =3D &pin_bank->gpio_chip;
-		pinctrl_add_gpio_range(info->pctl_dev, &pin_bank->grange);
-	}
-
 	return 0;
 }
=20
-/*
- * GPIO handling
- */
-
-static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int val=
ue)
-{
-	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
-	void __iomem *reg =3D bank->reg_base + GPIO_SWPORT_DR;
-	unsigned long flags;
-	u32 data;
-
-	clk_enable(bank->clk);
-	raw_spin_lock_irqsave(&bank->slock, flags);
-
-	data =3D readl(reg);
-	data &=3D ~BIT(offset);
-	if (value)
-		data |=3D BIT(offset);
-	writel(data, reg);
-
-	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
-}
-
-/*
- * Returns the level of the pin for input direction and setting of the DR
- * register for output gpios.
- */
-static int rockchip_gpio_get(struct gpio_chip *gc, unsigned offset)
-{
-	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
-	u32 data;
-
-	clk_enable(bank->clk);
-	data =3D readl(bank->reg_base + GPIO_EXT_PORT);
-	clk_disable(bank->clk);
-	data >>=3D offset;
-	data &=3D 1;
-	return data;
-}
-
-/*
- * gpiolib gpio_direction_input callback function. The setting of the pin
- * mux function as 'gpio input' will be handled by the pinctrl subsystem
- * interface.
- */
-static int rockchip_gpio_direction_input(struct gpio_chip *gc, unsigned offs=
et)
-{
-	return pinctrl_gpio_direction_input(gc->base + offset);
-}
-
-/*
- * gpiolib gpio_direction_output callback function. The setting of the pin
- * mux function as 'gpio output' will be handled by the pinctrl subsystem
- * interface.
- */
-static int rockchip_gpio_direction_output(struct gpio_chip *gc,
-					  unsigned offset, int value)
-{
-	rockchip_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output(gc->base + offset);
-}
-
-static void rockchip_gpio_set_debounce(struct gpio_chip *gc,
-				       unsigned int offset, bool enable)
-{
-	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
-	void __iomem *reg =3D bank->reg_base + GPIO_DEBOUNCE;
-	unsigned long flags;
-	u32 data;
-
-	clk_enable(bank->clk);
-	raw_spin_lock_irqsave(&bank->slock, flags);
-
-	data =3D readl(reg);
-	if (enable)
-		data |=3D BIT(offset);
-	else
-		data &=3D ~BIT(offset);
-	writel(data, reg);
-
-	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
-}
-
-/*
- * gpiolib set_config callback function. The setting of the pin
- * mux function as 'gpio output' will be handled by the pinctrl subsystem
- * interface.
- */
-static int rockchip_gpio_set_config(struct gpio_chip *gc, unsigned int offse=
t,
-				  unsigned long config)
-{
-	enum pin_config_param param =3D pinconf_to_config_param(config);
-
-	switch (param) {
-	case PIN_CONFIG_INPUT_DEBOUNCE:
-		rockchip_gpio_set_debounce(gc, offset, true);
-		/*
-		 * Rockchip's gpio could only support up to one period
-		 * of the debounce clock(pclk), which is far away from
-		 * satisftying the requirement, as pclk is usually near
-		 * 100MHz shared by all peripherals. So the fact is it
-		 * has crippled debounce capability could only be useful
-		 * to prevent any spurious glitches from waking up the system
-		 * if the gpio is conguired as wakeup interrupt source. Let's
-		 * still return -ENOTSUPP as before, to make sure the caller
-		 * of gpiod_set_debounce won't change its behaviour.
-		 */
-		return -ENOTSUPP;
-	default:
-		return -ENOTSUPP;
-	}
-}
-
-/*
- * gpiolib gpio_to_irq callback function. Creates a mapping between a GPIO p=
in
- * and a virtual IRQ, if not already present.
- */
-static int rockchip_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
-{
-	struct rockchip_pin_bank *bank =3D gpiochip_get_data(gc);
-	unsigned int virq;
-
-	if (!bank->domain)
-		return -ENXIO;
-
-	clk_enable(bank->clk);
-	virq =3D irq_create_mapping(bank->domain, offset);
-	clk_disable(bank->clk);
-
-	return (virq) ? : -ENXIO;
-}
-
-static const struct gpio_chip rockchip_gpiolib_chip =3D {
-	.request =3D gpiochip_generic_request,
-	.free =3D gpiochip_generic_free,
-	.set =3D rockchip_gpio_set,
-	.get =3D rockchip_gpio_get,
-	.get_direction	=3D rockchip_gpio_get_direction,
-	.direction_input =3D rockchip_gpio_direction_input,
-	.direction_output =3D rockchip_gpio_direction_output,
-	.set_config =3D rockchip_gpio_set_config,
-	.to_irq =3D rockchip_gpio_to_irq,
-	.owner =3D THIS_MODULE,
-};
-
-/*
- * Interrupt handling
- */
-
-static void rockchip_irq_demux(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	struct rockchip_pin_bank *bank =3D irq_desc_get_handler_data(desc);
-	u32 pend;
-
-	dev_dbg(bank->drvdata->dev, "got irq for bank %s\n", bank->name);
-
-	chained_irq_enter(chip, desc);
-
-	pend =3D readl_relaxed(bank->reg_base + GPIO_INT_STATUS);
-
-	while (pend) {
-		unsigned int irq, virq;
-
-		irq =3D __ffs(pend);
-		pend &=3D ~BIT(irq);
-		virq =3D irq_find_mapping(bank->domain, irq);
-
-		if (!virq) {
-			dev_err(bank->drvdata->dev, "unmapped irq %d\n", irq);
-			continue;
-		}
-
-		dev_dbg(bank->drvdata->dev, "handling irq %d\n", irq);
-
-		/*
-		 * Triggering IRQ on both rising and falling edge
-		 * needs manual intervention.
-		 */
-		if (bank->toggle_edge_mode & BIT(irq)) {
-			u32 data, data_old, polarity;
-			unsigned long flags;
-
-			data =3D readl_relaxed(bank->reg_base + GPIO_EXT_PORT);
-			do {
-				raw_spin_lock_irqsave(&bank->slock, flags);
-
-				polarity =3D readl_relaxed(bank->reg_base +
-							 GPIO_INT_POLARITY);
-				if (data & BIT(irq))
-					polarity &=3D ~BIT(irq);
-				else
-					polarity |=3D BIT(irq);
-				writel(polarity,
-				       bank->reg_base + GPIO_INT_POLARITY);
-
-				raw_spin_unlock_irqrestore(&bank->slock, flags);
-
-				data_old =3D data;
-				data =3D readl_relaxed(bank->reg_base +
-						     GPIO_EXT_PORT);
-			} while ((data & BIT(irq)) !=3D (data_old & BIT(irq)));
-		}
-
-		generic_handle_irq(virq);
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
-{
-	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank =3D gc->private;
-	u32 mask =3D BIT(d->hwirq);
-	u32 polarity;
-	u32 level;
-	u32 data;
-	unsigned long flags;
-	int ret;
-
-	/* make sure the pin is configured as gpio input */
-	ret =3D rockchip_set_mux(bank, d->hwirq, RK_FUNC_GPIO);
-	if (ret < 0)
-		return ret;
-
-	clk_enable(bank->clk);
-	raw_spin_lock_irqsave(&bank->slock, flags);
-
-	data =3D readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
-	data &=3D ~mask;
-	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
-
-	raw_spin_unlock_irqrestore(&bank->slock, flags);
-
-	if (type & IRQ_TYPE_EDGE_BOTH)
-		irq_set_handler_locked(d, handle_edge_irq);
-	else
-		irq_set_handler_locked(d, handle_level_irq);
-
-	raw_spin_lock_irqsave(&bank->slock, flags);
-	irq_gc_lock(gc);
-
-	level =3D readl_relaxed(gc->reg_base + GPIO_INTTYPE_LEVEL);
-	polarity =3D readl_relaxed(gc->reg_base + GPIO_INT_POLARITY);
-
-	switch (type) {
-	case IRQ_TYPE_EDGE_BOTH:
-		bank->toggle_edge_mode |=3D mask;
-		level |=3D mask;
-
-		/*
-		 * Determine gpio state. If 1 next interrupt should be falling
-		 * otherwise rising.
-		 */
-		data =3D readl(bank->reg_base + GPIO_EXT_PORT);
-		if (data & mask)
-			polarity &=3D ~mask;
-		else
-			polarity |=3D mask;
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		bank->toggle_edge_mode &=3D ~mask;
-		level |=3D mask;
-		polarity |=3D mask;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		bank->toggle_edge_mode &=3D ~mask;
-		level |=3D mask;
-		polarity &=3D ~mask;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		bank->toggle_edge_mode &=3D ~mask;
-		level &=3D ~mask;
-		polarity |=3D mask;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		bank->toggle_edge_mode &=3D ~mask;
-		level &=3D ~mask;
-		polarity &=3D ~mask;
-		break;
-	default:
-		irq_gc_unlock(gc);
-		raw_spin_unlock_irqrestore(&bank->slock, flags);
-		clk_disable(bank->clk);
-		return -EINVAL;
-	}
-
-	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
-	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
-
-	irq_gc_unlock(gc);
-	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
-
-	return 0;
-}
-
-static void rockchip_irq_suspend(struct irq_data *d)
-{
-	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank =3D gc->private;
-
-	clk_enable(bank->clk);
-	bank->saved_masks =3D irq_reg_readl(gc, GPIO_INTMASK);
-	irq_reg_writel(gc, ~gc->wake_active, GPIO_INTMASK);
-	clk_disable(bank->clk);
-}
-
-static void rockchip_irq_resume(struct irq_data *d)
-{
-	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank =3D gc->private;
-
-	clk_enable(bank->clk);
-	irq_reg_writel(gc, bank->saved_masks, GPIO_INTMASK);
-	clk_disable(bank->clk);
-}
-
-static void rockchip_irq_enable(struct irq_data *d)
-{
-	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank =3D gc->private;
-
-	clk_enable(bank->clk);
-	irq_gc_mask_clr_bit(d);
-}
-
-static void rockchip_irq_disable(struct irq_data *d)
-{
-	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(d);
-	struct rockchip_pin_bank *bank =3D gc->private;
-
-	irq_gc_mask_set_bit(d);
-	clk_disable(bank->clk);
-}
-
-static int rockchip_interrupts_register(struct platform_device *pdev,
-						struct rockchip_pinctrl *info)
-{
-	struct rockchip_pin_ctrl *ctrl =3D info->ctrl;
-	struct rockchip_pin_bank *bank =3D ctrl->pin_banks;
-	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	struct irq_chip_generic *gc;
-	int ret;
-	int i;
-
-	for (i =3D 0; i < ctrl->nr_banks; ++i, ++bank) {
-		if (!bank->valid) {
-			dev_warn(&pdev->dev, "bank %s is not valid\n",
-				 bank->name);
-			continue;
-		}
-
-		ret =3D clk_enable(bank->clk);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to enable clock for bank %s\n",
-				bank->name);
-			continue;
-		}
-
-		bank->domain =3D irq_domain_add_linear(bank->of_node, 32,
-						&irq_generic_chip_ops, NULL);
-		if (!bank->domain) {
-			dev_warn(&pdev->dev, "could not initialize irq domain for bank %s\n",
-				 bank->name);
-			clk_disable(bank->clk);
-			continue;
-		}
-
-		ret =3D irq_alloc_domain_generic_chips(bank->domain, 32, 1,
-					 "rockchip_gpio_irq", handle_level_irq,
-					 clr, 0, 0);
-		if (ret) {
-			dev_err(&pdev->dev, "could not alloc generic chips for bank %s\n",
-				bank->name);
-			irq_domain_remove(bank->domain);
-			clk_disable(bank->clk);
-			continue;
-		}
-
-		gc =3D irq_get_domain_generic_chip(bank->domain, 0);
-		gc->reg_base =3D bank->reg_base;
-		gc->private =3D bank;
-		gc->chip_types[0].regs.mask =3D GPIO_INTMASK;
-		gc->chip_types[0].regs.ack =3D GPIO_PORTS_EOI;
-		gc->chip_types[0].chip.irq_ack =3D irq_gc_ack_set_bit;
-		gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_set_bit;
-		gc->chip_types[0].chip.irq_unmask =3D irq_gc_mask_clr_bit;
-		gc->chip_types[0].chip.irq_enable =3D rockchip_irq_enable;
-		gc->chip_types[0].chip.irq_disable =3D rockchip_irq_disable;
-		gc->chip_types[0].chip.irq_set_wake =3D irq_gc_set_wake;
-		gc->chip_types[0].chip.irq_suspend =3D rockchip_irq_suspend;
-		gc->chip_types[0].chip.irq_resume =3D rockchip_irq_resume;
-		gc->chip_types[0].chip.irq_set_type =3D rockchip_irq_set_type;
-		gc->wake_enabled =3D IRQ_MSK(bank->nr_pins);
-
-		/*
-		 * Linux assumes that all interrupts start out disabled/masked.
-		 * Our driver only uses the concept of masked and always keeps
-		 * things enabled, so for us that's all masked and all enabled.
-		 */
-		writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTMASK);
-		writel_relaxed(0xffffffff, bank->reg_base + GPIO_PORTS_EOI);
-		writel_relaxed(0xffffffff, bank->reg_base + GPIO_INTEN);
-		gc->mask_cache =3D 0xffffffff;
-
-		irq_set_chained_handler_and_data(bank->irq,
-						 rockchip_irq_demux, bank);
-		clk_disable(bank->clk);
-	}
-
-	return 0;
-}
-
-static int rockchip_gpiolib_register(struct platform_device *pdev,
-						struct rockchip_pinctrl *info)
-{
-	struct rockchip_pin_ctrl *ctrl =3D info->ctrl;
-	struct rockchip_pin_bank *bank =3D ctrl->pin_banks;
-	struct gpio_chip *gc;
-	int ret;
-	int i;
-
-	for (i =3D 0; i < ctrl->nr_banks; ++i, ++bank) {
-		if (!bank->valid) {
-			dev_warn(&pdev->dev, "bank %s is not valid\n",
-				 bank->name);
-			continue;
-		}
-
-		bank->gpio_chip =3D rockchip_gpiolib_chip;
-
-		gc =3D &bank->gpio_chip;
-		gc->base =3D bank->pin_base;
-		gc->ngpio =3D bank->nr_pins;
-		gc->parent =3D &pdev->dev;
-		gc->of_node =3D bank->of_node;
-		gc->label =3D bank->name;
-
-		ret =3D gpiochip_add_data(gc, bank);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register gpio_chip %s, error code: %d\n",
-							gc->label, ret);
-			goto fail;
-		}
-	}
-
-	rockchip_interrupts_register(pdev, info);
-
-	return 0;
-
-fail:
-	for (--i, --bank; i >=3D 0; --i, --bank) {
-		if (!bank->valid)
-			continue;
-		gpiochip_remove(&bank->gpio_chip);
-	}
-	return ret;
-}
-
-static int rockchip_gpiolib_unregister(struct platform_device *pdev,
-						struct rockchip_pinctrl *info)
-{
-	struct rockchip_pin_ctrl *ctrl =3D info->ctrl;
-	struct rockchip_pin_bank *bank =3D ctrl->pin_banks;
-	int i;
-
-	for (i =3D 0; i < ctrl->nr_banks; ++i, ++bank) {
-		if (!bank->valid)
-			continue;
-		gpiochip_remove(&bank->gpio_chip);
-	}
-
-	return 0;
-}
-
-static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
-				  struct rockchip_pinctrl *info)
-{
-	struct resource res;
-	void __iomem *base;
-
-	if (of_address_to_resource(bank->of_node, 0, &res)) {
-		dev_err(info->dev, "cannot find IO resource for bank\n");
-		return -ENOENT;
-	}
-
-	bank->reg_base =3D devm_ioremap_resource(info->dev, &res);
-	if (IS_ERR(bank->reg_base))
-		return PTR_ERR(bank->reg_base);
-
-	/*
-	 * special case, where parts of the pull setting-registers are
-	 * part of the PMU register space
-	 */
-	if (of_device_is_compatible(bank->of_node,
-				    "rockchip,rk3188-gpio-bank0")) {
-		struct device_node *node;
-
-		node =3D of_parse_phandle(bank->of_node->parent,
-					"rockchip,pmu", 0);
-		if (!node) {
-			if (of_address_to_resource(bank->of_node, 1, &res)) {
-				dev_err(info->dev, "cannot find IO resource for bank\n");
-				return -ENOENT;
-			}
-
-			base =3D devm_ioremap_resource(info->dev, &res);
-			if (IS_ERR(base))
-				return PTR_ERR(base);
-			rockchip_regmap_config.max_register =3D
-						    resource_size(&res) - 4;
-			rockchip_regmap_config.name =3D
-					    "rockchip,rk3188-gpio-bank0-pull";
-			bank->regmap_pull =3D devm_regmap_init_mmio(info->dev,
-						    base,
-						    &rockchip_regmap_config);
-		}
-		of_node_put(node);
-	}
-
-	bank->irq =3D irq_of_parse_and_map(bank->of_node, 0);
-
-	bank->clk =3D of_clk_get(bank->of_node, 0);
-	if (IS_ERR(bank->clk))
-		return PTR_ERR(bank->clk);
-
-	return clk_prepare(bank->clk);
-}
-
 static const struct of_device_id rockchip_pinctrl_dt_match[];
=20
 /* retrieve the soc specific data */
@@ -3329,7 +2474,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_s=
oc_data(
 {
 	const struct of_device_id *match;
 	struct device_node *node =3D pdev->dev.of_node;
-	struct device_node *np;
 	struct rockchip_pin_ctrl *ctrl;
 	struct rockchip_pin_bank *bank;
 	int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, i, j;
@@ -3337,23 +2481,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_=
soc_data(
 	match =3D of_match_node(rockchip_pinctrl_dt_match, node);
 	ctrl =3D (struct rockchip_pin_ctrl *)match->data;
=20
-	for_each_child_of_node(node, np) {
-		if (!of_find_property(np, "gpio-controller", NULL))
-			continue;
-
-		bank =3D ctrl->pin_banks;
-		for (i =3D 0; i < ctrl->nr_banks; ++i, ++bank) {
-			if (!strcmp(bank->name, np->name)) {
-				bank->of_node =3D np;
-
-				if (!rockchip_get_bank_data(bank, d))
-					bank->valid =3D true;
-
-				break;
-			}
-		}
-	}
-
 	grf_offs =3D ctrl->grf_mux_offset;
 	pmu_offs =3D ctrl->pmu_mux_offset;
 	drv_pmu_offs =3D ctrl->pmu_drv_offset;
@@ -3574,18 +2701,18 @@ static int rockchip_pinctrl_probe(struct platform_dev=
ice *pdev)
 			return PTR_ERR(info->regmap_pmu);
 	}
=20
-	ret =3D rockchip_gpiolib_register(pdev, info);
+	ret =3D rockchip_pinctrl_register(pdev, info);
 	if (ret)
 		return ret;
=20
-	ret =3D rockchip_pinctrl_register(pdev, info);
+	platform_set_drvdata(pdev, info);
+
+	ret =3D of_platform_populate(np, rockchip_bank_match, NULL, NULL);
 	if (ret) {
-		rockchip_gpiolib_unregister(pdev, info);
+		dev_err(&pdev->dev, "failed to register gpio device\n");
 		return ret;
 	}
=20
-	platform_set_drvdata(pdev, info);
-
 	return 0;
 }
=20
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-roc=
kchip.h
new file mode 100644
index 000000000000..589d4d2a98c9
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021 Rockchip Electronics Co. Ltd.
+ *
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * With some ideas taken from pinctrl-samsung:
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2012 Linaro Ltd
+ *		https://www.linaro.org
+ *
+ * and pinctrl-at91:
+ * Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcroso=
ft.com>
+ */
+
+#ifndef _PINCTRL_ROCKCHIP_H
+#define _PINCTRL_ROCKCHIP_H
+
+enum rockchip_pinctrl_type {
+	PX30,
+	RV1108,
+	RK2928,
+	RK3066B,
+	RK3128,
+	RK3188,
+	RK3288,
+	RK3308,
+	RK3368,
+	RK3399,
+	RK3568,
+};
+
+/**
+ * struct rockchip_gpio_regs
+ * @port_dr: data register
+ * @port_ddr: data direction register
+ * @int_en: interrupt enable
+ * @int_mask: interrupt mask
+ * @int_type: interrupt trigger type, such as high, low, edge trriger type.
+ * @int_polarity: interrupt polarity enable register
+ * @int_bothedge: interrupt bothedge enable register
+ * @int_status: interrupt status register
+ * @int_rawstatus: int_status =3D int_rawstatus & int_mask
+ * @debounce: enable debounce for interrupt signal
+ * @dbclk_div_en: enable divider for debounce clock
+ * @dbclk_div_con: setting for divider of debounce clock
+ * @port_eoi: end of interrupt of the port
+ * @ext_port: port data from external
+ * @version_id: controller version register
+ */
+struct rockchip_gpio_regs {
+	u32 port_dr;
+	u32 port_ddr;
+	u32 int_en;
+	u32 int_mask;
+	u32 int_type;
+	u32 int_polarity;
+	u32 int_bothedge;
+	u32 int_status;
+	u32 int_rawstatus;
+	u32 debounce;
+	u32 dbclk_div_en;
+	u32 dbclk_div_con;
+	u32 port_eoi;
+	u32 ext_port;
+	u32 version_id;
+};
+
+/**
+ * struct rockchip_iomux
+ * @type: iomux variant using IOMUX_* constants
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following iomux registers.
+ */
+struct rockchip_iomux {
+	int type;
+	int offset;
+};
+
+/*
+ * enum type index corresponding to rockchip_perpin_drv_list arrays index.
+ */
+enum rockchip_pin_drv_type {
+	DRV_TYPE_IO_DEFAULT =3D 0,
+	DRV_TYPE_IO_1V8_OR_3V0,
+	DRV_TYPE_IO_1V8_ONLY,
+	DRV_TYPE_IO_1V8_3V0_AUTO,
+	DRV_TYPE_IO_3V3_ONLY,
+	DRV_TYPE_MAX
+};
+
+/*
+ * enum type index corresponding to rockchip_pull_list arrays index.
+ */
+enum rockchip_pin_pull_type {
+	PULL_TYPE_IO_DEFAULT =3D 0,
+	PULL_TYPE_IO_1V8_ONLY,
+	PULL_TYPE_MAX
+};
+
+/**
+ * struct rockchip_drv
+ * @drv_type: drive strength variant using rockchip_perpin_drv_type
+ * @offset: if initialized to -1 it will be autocalculated, by specifying
+ *	    an initial offset value the relevant source offset can be reset
+ *	    to a new value for autocalculating the following drive strength
+ *	    registers. if used chips own cal_drv func instead to calculate
+ *	    registers offset, the variant could be ignored.
+ */
+struct rockchip_drv {
+	enum rockchip_pin_drv_type	drv_type;
+	int				offset;
+};
+
+/**
+ * struct rockchip_pin_bank
+ * @dev: the pinctrl device bind to the bank
+ * @reg_base: register base of the gpio bank
+ * @regmap_pull: optional separate register for additional pull settings
+ * @clk: clock of the gpio bank
+ * @db_clk: clock of the gpio debounce
+ * @irq: interrupt of the gpio bank
+ * @saved_masks: Saved content of GPIO_INTEN at suspend time.
+ * @pin_base: first pin number
+ * @nr_pins: number of pins in this bank
+ * @name: name of the bank
+ * @bank_num: number of the bank, to account for holes
+ * @iomux: array describing the 4 iomux sources of the bank
+ * @drv: array describing the 4 drive strength sources of the bank
+ * @pull_type: array describing the 4 pull type sources of the bank
+ * @valid: is all necessary information present
+ * @of_node: dt node of this bank
+ * @drvdata: common pinctrl basedata
+ * @domain: irqdomain of the gpio bank
+ * @gpio_chip: gpiolib chip
+ * @grange: gpio range
+ * @slock: spinlock for the gpio bank
+ * @toggle_edge_mode: bit mask to toggle (falling/rising) edge mode
+ * @recalced_mask: bit mask to indicate a need to recalulate the mask
+ * @route_mask: bits describing the routing pins of per bank
+ */
+struct rockchip_pin_bank {
+	struct device			*dev;
+	void __iomem			*reg_base;
+	struct regmap			*regmap_pull;
+	struct clk			*clk;
+	struct clk			*db_clk;
+	int				irq;
+	u32				saved_masks;
+	u32				pin_base;
+	u8				nr_pins;
+	char				*name;
+	u8				bank_num;
+	struct rockchip_iomux		iomux[4];
+	struct rockchip_drv		drv[4];
+	enum rockchip_pin_pull_type	pull_type[4];
+	bool				valid;
+	struct device_node		*of_node;
+	struct rockchip_pinctrl		*drvdata;
+	struct irq_domain		*domain;
+	struct gpio_chip		gpio_chip;
+	struct pinctrl_gpio_range	grange;
+	raw_spinlock_t			slock;
+	const struct rockchip_gpio_regs	*gpio_regs;
+	u32				gpio_type;
+	u32				toggle_edge_mode;
+	u32				recalced_mask;
+	u32				route_mask;
+};
+
+/**
+ * struct rockchip_mux_recalced_data: represent a pin iomux data.
+ * @num: bank number.
+ * @pin: pin number.
+ * @bit: index at register.
+ * @reg: register offset.
+ * @mask: mask bit
+ */
+struct rockchip_mux_recalced_data {
+	u8 num;
+	u8 pin;
+	u32 reg;
+	u8 bit;
+	u8 mask;
+};
+
+enum rockchip_mux_route_location {
+	ROCKCHIP_ROUTE_SAME =3D 0,
+	ROCKCHIP_ROUTE_PMU,
+	ROCKCHIP_ROUTE_GRF,
+};
+
+/**
+ * struct rockchip_mux_recalced_data: represent a pin iomux data.
+ * @bank_num: bank number.
+ * @pin: index at register or used to calc index.
+ * @func: the min pin.
+ * @route_location: the mux route location (same, pmu, grf).
+ * @route_offset: the max pin.
+ * @route_val: the register offset.
+ */
+struct rockchip_mux_route_data {
+	u8 bank_num;
+	u8 pin;
+	u8 func;
+	enum rockchip_mux_route_location route_location;
+	u32 route_offset;
+	u32 route_val;
+};
+
+struct rockchip_pin_ctrl {
+	struct rockchip_pin_bank	*pin_banks;
+	u32				nr_banks;
+	u32				nr_pins;
+	char				*label;
+	enum rockchip_pinctrl_type	type;
+	int				grf_mux_offset;
+	int				pmu_mux_offset;
+	int				grf_drv_offset;
+	int				pmu_drv_offset;
+	struct rockchip_mux_recalced_data *iomux_recalced;
+	u32				niomux_recalced;
+	struct rockchip_mux_route_data *iomux_routes;
+	u32				niomux_routes;
+
+	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+	void	(*drv_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+	int	(*schmitt_calc_reg)(struct rockchip_pin_bank *bank,
+				    int pin_num, struct regmap **regmap,
+				    int *reg, u8 *bit);
+};
+
+struct rockchip_pin_config {
+	unsigned int		func;
+	unsigned long		*configs;
+	unsigned int		nconfigs;
+};
+
+/**
+ * struct rockchip_pin_group: represent group of pins of a pinmux function.
+ * @name: name of the pin group, used to lookup the group.
+ * @pins: the pins included in this group.
+ * @npins: number of pins included in this group.
+ * @data: local pin configuration
+ */
+struct rockchip_pin_group {
+	const char			*name;
+	unsigned int			npins;
+	unsigned int			*pins;
+	struct rockchip_pin_config	*data;
+};
+
+/**
+ * struct rockchip_pmx_func: represent a pin function.
+ * @name: name of the pin function, used to lookup the function.
+ * @groups: one or more names of pin groups that provide this function.
+ * @ngroups: number of groups included in @groups.
+ */
+struct rockchip_pmx_func {
+	const char		*name;
+	const char		**groups;
+	u8			ngroups;
+};
+
+struct rockchip_pinctrl {
+	struct regmap			*regmap_base;
+	int				reg_size;
+	struct regmap			*regmap_pull;
+	struct regmap			*regmap_pmu;
+	struct device			*dev;
+	struct rockchip_pin_ctrl	*ctrl;
+	struct pinctrl_desc		pctl;
+	struct pinctrl_dev		*pctl_dev;
+	struct rockchip_pin_group	*groups;
+	unsigned int			ngroups;
+	struct rockchip_pmx_func	*functions;
+	unsigned int			nfunctions;
+};
+
+#endif
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-singl=
e.c
index e3aa64798f7d..aa6e72214609 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1491,8 +1491,8 @@ static int pcs_irq_handle(struct pcs_soc_data *pcs_soc)
 		mask =3D pcs->read(pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 		if (mask & pcs_soc->irq_status_mask) {
-			generic_handle_irq(irq_find_mapping(pcs->domain,
-							    pcswi->hwirq));
+			generic_handle_domain_irq(pcs->domain,
+						  pcswi->hwirq);
 			count++;
 		}
 	}
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 43d9e6c7fd81..fa3edb4b898a 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1420,7 +1420,7 @@ static void __gpio_irq_handler(struct st_gpio_bank *ban=
k)
 					continue;
 			}
=20
-			generic_handle_irq(irq_find_mapping(bank->gpio_chip.irq.domain, n));
+			generic_handle_domain_irq(bank->gpio_chip.irq.domain, n);
 		}
 	}
 }
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctr=
l-msm.c
index d70caecd21d2..8476a8ac4451 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1177,7 +1177,6 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	const struct msm_pingroup *g;
 	struct msm_pinctrl *pctrl =3D gpiochip_get_data(gc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	int irq_pin;
 	int handled =3D 0;
 	u32 val;
 	int i;
@@ -1192,8 +1191,7 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 		g =3D &pctrl->soc->groups[i];
 		val =3D msm_readl_intr_status(pctrl, g);
 		if (val & BIT(g->intr_status_bit)) {
-			irq_pin =3D irq_find_mapping(gc->irq.domain, i);
-			generic_handle_irq(irq_pin);
+			generic_handle_domain_irq(gc->irq.domain, i);
 			handled++;
 		}
 	}
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsu=
ng/pinctrl-exynos.c
index 2b99f4130e1e..0489c899b401 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -246,7 +246,8 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *da=
ta)
 {
 	struct samsung_pinctrl_drv_data *d =3D data;
 	struct samsung_pin_bank *bank =3D d->pin_banks;
-	unsigned int svc, group, pin, virq;
+	unsigned int svc, group, pin;
+	int ret;
=20
 	svc =3D readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group =3D EXYNOS_SVC_GROUP(svc);
@@ -256,10 +257,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *=
data)
 		return IRQ_HANDLED;
 	bank +=3D (group - 1);
=20
-	virq =3D irq_linear_revmap(bank->irq_domain, pin);
-	if (!virq)
+	ret =3D generic_handle_domain_irq(bank->irq_domain, pin);
+	if (ret)
 		return IRQ_NONE;
-	generic_handle_irq(virq);
+
 	return IRQ_HANDLED;
 }
=20
@@ -473,12 +474,10 @@ static void exynos_irq_eint0_15(struct irq_desc *desc)
 	struct exynos_weint_data *eintd =3D irq_desc_get_handler_data(desc);
 	struct samsung_pin_bank *bank =3D eintd->bank;
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	int eint_irq;
=20
 	chained_irq_enter(chip, desc);
=20
-	eint_irq =3D irq_linear_revmap(bank->irq_domain, eintd->irq);
-	generic_handle_irq(eint_irq);
+	generic_handle_domain_irq(bank->irq_domain, eintd->irq);
=20
 	chained_irq_exit(chip, desc);
 }
@@ -490,7 +489,7 @@ static inline void exynos_irq_demux_eint(unsigned int pen=
d,
=20
 	while (pend) {
 		irq =3D fls(pend) - 1;
-		generic_handle_irq(irq_find_mapping(domain, irq));
+		generic_handle_domain_irq(domain, irq);
 		pend &=3D ~(1 << irq);
 	}
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/sams=
ung/pinctrl-s3c24xx.c
index 00d77d6946b5..ac1eba30cf40 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -234,14 +234,12 @@ static void s3c2410_demux_eint0_3(struct irq_desc *desc)
 {
 	struct irq_data *data =3D irq_desc_get_irq_data(desc);
 	struct s3c24xx_eint_data *eint_data =3D irq_desc_get_handler_data(desc);
-	unsigned int virq;
+	int ret;
=20
 	/* the first 4 eints have a simple 1 to 1 mapping */
-	virq =3D irq_linear_revmap(eint_data->domains[data->hwirq], data->hwirq);
+	ret =3D generic_handle_domain_irq(eint_data->domains[data->hwirq], data->hw=
irq);
 	/* Something must be really wrong if an unmapped EINT is unmasked */
-	BUG_ON(!virq);
-
-	generic_handle_irq(virq);
+	BUG_ON(ret);
 }
=20
 /* Handling of EINTs 0-3 on S3C2412 and S3C2413 */
@@ -290,16 +288,14 @@ static void s3c2412_demux_eint0_3(struct irq_desc *desc)
 	struct s3c24xx_eint_data *eint_data =3D irq_desc_get_handler_data(desc);
 	struct irq_data *data =3D irq_desc_get_irq_data(desc);
 	struct irq_chip *chip =3D irq_data_get_irq_chip(data);
-	unsigned int virq;
+	int ret;
=20
 	chained_irq_enter(chip, desc);
=20
 	/* the first 4 eints have a simple 1 to 1 mapping */
-	virq =3D irq_linear_revmap(eint_data->domains[data->hwirq], data->hwirq);
+	ret =3D generic_handle_domain_irq(eint_data->domains[data->hwirq], data->hw=
irq);
 	/* Something must be really wrong if an unmapped EINT is unmasked */
-	BUG_ON(!virq);
-
-	generic_handle_irq(virq);
+	BUG_ON(ret);
=20
 	chained_irq_exit(chip, desc);
 }
@@ -364,15 +360,14 @@ static inline void s3c24xx_demux_eint(struct irq_desc *=
desc,
 	pend &=3D range;
=20
 	while (pend) {
-		unsigned int virq, irq;
+		unsigned int irq;
+		int ret;
=20
 		irq =3D __ffs(pend);
 		pend &=3D ~(1 << irq);
-		virq =3D irq_linear_revmap(data->domains[irq], irq - offset);
+		ret =3D generic_handle_domain_irq(data->domains[irq], irq - offset);
 		/* Something is really wrong if an unmapped EINT is unmasked */
-		BUG_ON(!virq);
-
-		generic_handle_irq(virq);
+		BUG_ON(ret);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/sams=
ung/pinctrl-s3c64xx.c
index 53e2a6412add..c5f95a1071ae 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -414,7 +414,7 @@ static void s3c64xx_eint_gpio_irq(struct irq_desc *desc)
 		unsigned int svc;
 		unsigned int group;
 		unsigned int pin;
-		unsigned int virq;
+		int ret;
=20
 		svc =3D readl(drvdata->virt_base + SERVICE_REG);
 		group =3D SVC_GROUP(svc);
@@ -431,14 +431,12 @@ static void s3c64xx_eint_gpio_irq(struct irq_desc *desc)
 				pin -=3D 8;
 		}
=20
-		virq =3D irq_linear_revmap(data->domains[group], pin);
+		ret =3D generic_handle_domain_irq(data->domains[group], pin);
 		/*
 		 * Something must be really wrong if an unmapped EINT
 		 * was unmasked...
 		 */
-		BUG_ON(!virq);
-
-		generic_handle_irq(virq);
+		BUG_ON(ret);
 	} while (1);
=20
 	chained_irq_exit(chip, desc);
@@ -607,18 +605,17 @@ static inline void s3c64xx_irq_demux_eint(struct irq_de=
sc *desc, u32 range)
 	pend &=3D range;
=20
 	while (pend) {
-		unsigned int virq, irq;
+		unsigned int irq;
+		int ret;
=20
 		irq =3D fls(pend) - 1;
 		pend &=3D ~(1 << irq);
-		virq =3D irq_linear_revmap(data->domains[irq], data->pins[irq]);
+		ret =3D generic_handle_domain_irq(data->domains[irq], data->pins[irq]);
 		/*
 		 * Something must be really wrong if an unmapped EINT
 		 * was unmasked...
 		 */
-		BUG_ON(!virq);
-
-		generic_handle_irq(virq);
+		BUG_ON(ret);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/drivers/pinctrl/spear/pinctrl-plgpio.c b/drivers/pinctrl/spear/p=
inctrl-plgpio.c
index 1ebbc49b16f1..43bb334af1e1 100644
--- a/drivers/pinctrl/spear/pinctrl-plgpio.c
+++ b/drivers/pinctrl/spear/pinctrl-plgpio.c
@@ -400,8 +400,7 @@ static void plgpio_irq_handler(struct irq_desc *desc)
=20
 			/* get correct irq line number */
 			pin =3D i * MAX_GPIO_PER_REG + pin;
-			generic_handle_irq(
-				irq_find_mapping(gc->irq.domain, pin));
+			generic_handle_domain_irq(gc->irq.domain, pin);
 		}
 	}
 	chained_irq_exit(irqchip, desc);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pi=
nctrl-sunxi.c
index dc8d39ae045b..baa4058e024e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1149,11 +1149,9 @@ static void sunxi_pinctrl_irq_handler(struct irq_desc =
*desc)
 	if (val) {
 		int irqoffset;
=20
-		for_each_set_bit(irqoffset, &val, IRQ_PER_BANK) {
-			int pin_irq =3D irq_find_mapping(pctl->domain,
-						       bank * IRQ_PER_BANK + irqoffset);
-			generic_handle_irq(pin_irq);
-		}
+		for_each_set_bit(irqoffset, &val, IRQ_PER_BANK)
+			generic_handle_domain_irq(pctl->domain,
+						  bank * IRQ_PER_BANK + irqoffset);
 	}
=20
 	chained_irq_exit(chip, desc);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2ed65b01c961..1f22a30c0963 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -13,6 +13,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
+#include <linux/jump_label.h>
=20
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -474,12 +475,13 @@ extern int irq_set_irqchip_state(unsigned int irq, enum=
 irqchip_irq_state which,
=20
 #ifdef CONFIG_IRQ_FORCED_THREADING
 # ifdef CONFIG_PREEMPT_RT
-#  define force_irqthreads	(true)
+#  define force_irqthreads()	(true)
 # else
-extern bool force_irqthreads;
+DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
+#  define force_irqthreads()	(static_branch_unlikely(&force_irqthreads_key))
 # endif
 #else
-#define force_irqthreads	(0)
+#define force_irqthreads()	(false)
 #endif
=20
 #ifndef local_softirq_pending
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e8bdcb83172b..49cf6eb222e7 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -107,7 +107,8 @@ struct ti_sci_inta_msi_desc {
  *			address or data changes
  * @write_msi_msg_data:	Data parameter for the callback.
  *
- * @masked:	[PCI MSI/X] Mask bits
+ * @msi_mask:	[PCI MSI]   MSI cached mask bits
+ * @msix_ctrl:	[PCI MSI-X] MSI-X cached per vector control bits
  * @is_msix:	[PCI MSI/X] True if MSI-X
  * @multiple:	[PCI MSI/X] log2 num of messages allocated
  * @multi_cap:	[PCI MSI/X] log2 num of messages supported
@@ -139,7 +140,10 @@ struct msi_desc {
 	union {
 		/* PCI MSI/X specific data */
 		struct {
-			u32 masked;
+			union {
+				u32 msi_mask;
+				u32 msix_ctrl;
+			};
 			struct {
 				u8	is_msix		: 1;
 				u8	multiple	: 3;
@@ -232,11 +236,13 @@ void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
=20
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
-void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
=20
+const struct attribute_group **msi_populate_sysfs(struct device *dev);
+void msi_destroy_sysfs(struct device *dev,
+		       const struct attribute_group **msi_irq_groups);
+
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3b..f7ff8919dc9b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -355,7 +355,7 @@ static int irq_build_affinity_masks(unsigned int startvec=
, unsigned int numvecs,
 		goto fail_npresmsk;
=20
 	/* Stabilize the cpumasks */
-	get_online_cpus();
+	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
=20
 	/* Spread on present CPUs starting from affd->pre_vectors */
@@ -384,7 +384,7 @@ static int irq_build_affinity_masks(unsigned int startvec=
, unsigned int numvecs,
 		nr_others =3D ret;
=20
  fail_build_affinity:
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	if (ret >=3D 0)
 		WARN_ON(nr_present + nr_others < numvecs);
@@ -505,9 +505,9 @@ unsigned int irq_calc_affinity_vectors(unsigned int minve=
c, unsigned int maxvec,
 	if (affd->calc_sets) {
 		set_vecs =3D maxvec - resv;
 	} else {
-		get_online_cpus();
+		cpus_read_lock();
 		set_vecs =3D cpumask_weight(cpu_possible_mask);
-		put_online_cpus();
+		cpus_read_unlock();
 	}
=20
 	return resv + min(set_vecs, maxvec - resv);
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b13b359..39a41c56ad4f 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
 		raw_spin_unlock(&desc->lock);
=20
 		if (affinity_broken) {
-			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
+			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
 		}
 	}
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f8f23af6ab0d..cc7cdd26e23e 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -240,9 +240,8 @@ irq_alloc_generic_chip(const char *name, int num_ct, unsi=
gned int irq_base,
 		       void __iomem *reg_base, irq_flow_handler_t handler)
 {
 	struct irq_chip_generic *gc;
-	unsigned long sz =3D sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
=20
-	gc =3D kzalloc(sz, GFP_KERNEL);
+	gc =3D kzalloc(struct_size(gc, chip_types, num_ct), GFP_KERNEL);
 	if (gc) {
 		irq_init_generic_chip(gc, name, num_ct, irq_base, reg_base,
 				      handler);
@@ -288,8 +287,11 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *=
d, int irqs_per_chip,
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
-	int numchips, sz, i;
 	unsigned long flags;
+	int numchips, i;
+	size_t dgc_sz;
+	size_t gc_sz;
+	size_t sz;
 	void *tmp;
=20
 	if (d->gc)
@@ -300,8 +302,9 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d=
, int irqs_per_chip,
 		return -EINVAL;
=20
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	sz =3D sizeof(*dgc) + numchips * sizeof(gc);
-	sz +=3D numchips * (sizeof(*gc) + num_ct * sizeof(struct irq_chip_type));
+	gc_sz =3D struct_size(gc, chip_types, num_ct);
+	dgc_sz =3D struct_size(dgc, gc, numchips);
+	sz =3D dgc_sz + numchips * gc_sz;
=20
 	tmp =3D dgc =3D kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
@@ -314,7 +317,7 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d=
, int irqs_per_chip,
 	d->gc =3D dgc;
=20
 	/* Calc pointer to the first generic chip */
-	tmp +=3D sizeof(*dgc) + numchips * sizeof(gc);
+	tmp +=3D dgc_sz;
 	for (i =3D 0; i < numchips; i++) {
 		/* Store the pointer to the generic chip */
 		dgc->gc[i] =3D gc =3D tmp;
@@ -331,7 +334,7 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d=
, int irqs_per_chip,
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
 		/* Calc pointer to the next generic chip */
-		tmp +=3D sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
+		tmp +=3D gc_sz;
 	}
 	return 0;
 }
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 52f11c791bf8..08ce7da3b57c 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -14,11 +14,11 @@
 /**
  * irq_reserve_ipi() - Setup an IPI to destination cpumask
  * @domain:	IPI domain
- * @dest:	cpumask of cpus which can receive the IPI
+ * @dest:	cpumask of CPUs which can receive the IPI
  *
  * Allocate a virq that can be used to send IPI to any CPU in dest mask.
  *
- * On success it'll return linux irq number and error code on failure
+ * Return: Linux IRQ number on success or error code on failure
  */
 int irq_reserve_ipi(struct irq_domain *domain,
 			     const struct cpumask *dest)
@@ -104,13 +104,13 @@ int irq_reserve_ipi(struct irq_domain *domain,
=20
 /**
  * irq_destroy_ipi() - unreserve an IPI that was previously allocated
- * @irq:	linux irq number to be destroyed
- * @dest:	cpumask of cpus which should have the IPI removed
+ * @irq:	Linux IRQ number to be destroyed
+ * @dest:	cpumask of CPUs which should have the IPI removed
  *
  * The IPIs allocated with irq_reserve_ipi() are returned to the system
  * destroying all virqs associated with them.
  *
- * Return 0 on success or error code on failure.
+ * Return: %0 on success or error code on failure.
  */
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 {
@@ -150,14 +150,14 @@ int irq_destroy_ipi(unsigned int irq, const struct cpum=
ask *dest)
 }
=20
 /**
- * ipi_get_hwirq - Get the hwirq associated with an IPI to a cpu
- * @irq:	linux irq number
- * @cpu:	the target cpu
+ * ipi_get_hwirq - Get the hwirq associated with an IPI to a CPU
+ * @irq:	Linux IRQ number
+ * @cpu:	the target CPU
  *
  * When dealing with coprocessors IPI, we need to inform the coprocessor of
  * the hwirq it needs to use to receive and send IPIs.
  *
- * Returns hwirq value on success and INVALID_HWIRQ on failure.
+ * Return: hwirq value on success or INVALID_HWIRQ on failure.
  */
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 {
@@ -216,7 +216,7 @@ static int ipi_send_verify(struct irq_chip *chip, struct =
irq_data *data,
  * This function is for architecture or core code to speed up IPI sending. N=
ot
  * usable from driver code.
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int __ipi_send_single(struct irq_desc *desc, unsigned int cpu)
 {
@@ -250,7 +250,7 @@ int __ipi_send_single(struct irq_desc *desc, unsigned int=
 cpu)
 }
=20
 /**
- * ipi_send_mask - send an IPI to target Linux SMP CPU(s)
+ * __ipi_send_mask - send an IPI to target Linux SMP CPU(s)
  * @desc:	pointer to irq_desc of the IRQ
  * @dest:	dest CPU(s), must be a subset of the mask passed to
  *		irq_reserve_ipi()
@@ -258,7 +258,7 @@ int __ipi_send_single(struct irq_desc *desc, unsigned int=
 cpu)
  * This function is for architecture or core code to speed up IPI sending. N=
ot
  * usable from driver code.
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest)
 {
@@ -298,11 +298,11 @@ int __ipi_send_mask(struct irq_desc *desc, const struct=
 cpumask *dest)
=20
 /**
  * ipi_send_single - Send an IPI to a single CPU
- * @virq:	linux irq number from irq_reserve_ipi()
+ * @virq:	Linux IRQ number from irq_reserve_ipi()
  * @cpu:	destination CPU, must in the destination mask passed to
  *		irq_reserve_ipi()
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int ipi_send_single(unsigned int virq, unsigned int cpu)
 {
@@ -319,11 +319,11 @@ EXPORT_SYMBOL_GPL(ipi_send_single);
=20
 /**
  * ipi_send_mask - Send an IPI to target CPU(s)
- * @virq:	linux irq number from irq_reserve_ipi()
+ * @virq:	Linux IRQ number from irq_reserve_ipi()
  * @dest:	dest CPU(s), must be a subset of the mask passed to
  *		irq_reserve_ipi()
  *
- * Returns zero on success and negative error number on failure.
+ * Return: %0 on success or negative error number on failure.
  */
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index fadb93766020..4e3c29bb603c 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -188,7 +188,7 @@ static ssize_t hwirq_show(struct kobject *kobj,
=20
 	raw_spin_lock_irq(&desc->lock);
 	if (desc->irq_data.domain)
-		ret =3D sprintf(buf, "%d\n", (int)desc->irq_data.hwirq);
+		ret =3D sprintf(buf, "%lu\n", desc->irq_data.hwirq);
 	raw_spin_unlock_irq(&desc->lock);
=20
 	return ret;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 51c483ce2447..62be16135e7c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1215,6 +1215,7 @@ int irq_domain_disconnect_hierarchy(struct irq_domain *=
domain,
 	irqd->chip =3D ERR_PTR(-ENOTCONN);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_domain_disconnect_hierarchy);
=20
 static int irq_domain_trim_hierarchy(unsigned int virq)
 {
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ef30b4762947..27667e82ecc9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -25,12 +25,11 @@
 #include "internals.h"
=20
 #if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
-__read_mostly bool force_irqthreads;
-EXPORT_SYMBOL_GPL(force_irqthreads);
+DEFINE_STATIC_KEY_FALSE(force_irqthreads_key);
=20
 static int __init setup_forced_irqthreads(char *arg)
 {
-	force_irqthreads =3D true;
+	static_branch_enable(&force_irqthreads_key);
 	return 0;
 }
 early_param("threadirqs", setup_forced_irqthreads);
@@ -1260,8 +1259,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
=20
-	if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
-					&action->thread_flags))
+	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
+					   &action->thread_flags))
 		handler_fn =3D irq_forced_thread_fn;
 	else
 		handler_fn =3D irq_thread_fn;
@@ -1322,7 +1321,7 @@ EXPORT_SYMBOL_GPL(irq_wake_thread);
=20
 static int irq_setup_forced_threading(struct irqaction *new)
 {
-	if (!force_irqthreads)
+	if (!force_irqthreads())
 		return 0;
 	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
 		return 0;
@@ -2072,9 +2071,9 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *	request_threaded_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs.
- *		  Primary handler for threaded interrupts
- *		  If NULL and thread_fn !=3D NULL the default
- *		  primary handler is installed
+ *		  Primary handler for threaded interrupts.
+ *		  If handler is NULL and thread_fn !=3D NULL
+ *		  the default primary handler is installed.
  *	@thread_fn: Function called from the irq handler thread
  *		    If NULL, no irq thread is created
  *	@irqflags: Interrupt type flags
@@ -2108,7 +2107,7 @@ const void *free_nmi(unsigned int irq, void *dev_id)
  *
  *	IRQF_SHARED		Interrupt is shared
  *	IRQF_TRIGGER_*		Specify active edge(s) or level
- *
+ *	IRQF_ONESHOT		Run thread_fn with interrupt line masked
  */
 int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 			 irq_handler_t thread_fn, unsigned long irqflags,
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 578596e41cb6..bbfb26489aa1 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -280,7 +280,8 @@ void irq_matrix_remove_managed(struct irq_matrix *m, cons=
t struct cpumask *msk)
 /**
  * irq_matrix_alloc_managed - Allocate a managed interrupt in a CPU map
  * @m:		Matrix pointer
- * @cpu:	On which CPU the interrupt should be allocated
+ * @msk:	Which CPUs to search in
+ * @mapped_cpu:	Pointer to store the CPU for which the irq was allocated
  */
 int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
 			     unsigned int *mapped_cpu)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e348b5..48ef144649e3 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,17 +14,20 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
=20
 #include "internals.h"
=20
 /**
- * alloc_msi_entry - Allocate an initialize msi_entry
+ * alloc_msi_entry - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
  *
- * If @affinity is not NULL then an affinity array[@nvec] is allocated
+ * If @affinity is not %NULL then an affinity array[@nvec] is allocated
  * and the affinity masks and flags from @affinity are copied.
+ *
+ * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 				 const struct irq_affinity_desc *affinity)
@@ -69,6 +72,139 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg =
*msg)
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
=20
+static ssize_t msi_mode_show(struct device *dev, struct device_attribute *at=
tr,
+			     char *buf)
+{
+	struct msi_desc *entry;
+	bool is_msix =3D false;
+	unsigned long irq;
+	int retval;
+
+	retval =3D kstrtoul(attr->attr.name, 10, &irq);
+	if (retval)
+		return retval;
+
+	entry =3D irq_get_msi_desc(irq);
+	if (!entry)
+		return -ENODEV;
+
+	if (dev_is_pci(dev))
+		is_msix =3D entry->msi_attrib.is_msix;
+
+	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
+}
+
+/**
+ * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
+ * @dev:	The device(PCI, platform etc) who will get sysfs entries
+ *
+ * Return attribute_group ** so that specific bus MSI can save it to
+ * somewhere during initilizing msi irqs. If devices has no MSI irq,
+ * return NULL; if it fails to populate sysfs, return ERR_PTR
+ */
+const struct attribute_group **msi_populate_sysfs(struct device *dev)
+{
+	const struct attribute_group **msi_irq_groups;
+	struct attribute **msi_attrs, *msi_attr;
+	struct device_attribute *msi_dev_attr;
+	struct attribute_group *msi_irq_group;
+	struct msi_desc *entry;
+	int ret =3D -ENOMEM;
+	int num_msi =3D 0;
+	int count =3D 0;
+	int i;
+
+	/* Determine how many msi entries we have */
+	for_each_msi_entry(entry, dev)
+		num_msi +=3D entry->nvec_used;
+	if (!num_msi)
+		return NULL;
+
+	/* Dynamically create the MSI attributes for the device */
+	msi_attrs =3D kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
+	if (!msi_attrs)
+		return ERR_PTR(-ENOMEM);
+
+	for_each_msi_entry(entry, dev) {
+		for (i =3D 0; i < entry->nvec_used; i++) {
+			msi_dev_attr =3D kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
+			if (!msi_dev_attr)
+				goto error_attrs;
+			msi_attrs[count] =3D &msi_dev_attr->attr;
+
+			sysfs_attr_init(&msi_dev_attr->attr);
+			msi_dev_attr->attr.name =3D kasprintf(GFP_KERNEL, "%d",
+							    entry->irq + i);
+			if (!msi_dev_attr->attr.name)
+				goto error_attrs;
+			msi_dev_attr->attr.mode =3D 0444;
+			msi_dev_attr->show =3D msi_mode_show;
+			++count;
+		}
+	}
+
+	msi_irq_group =3D kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
+	if (!msi_irq_group)
+		goto error_attrs;
+	msi_irq_group->name =3D "msi_irqs";
+	msi_irq_group->attrs =3D msi_attrs;
+
+	msi_irq_groups =3D kcalloc(2, sizeof(void *), GFP_KERNEL);
+	if (!msi_irq_groups)
+		goto error_irq_group;
+	msi_irq_groups[0] =3D msi_irq_group;
+
+	ret =3D sysfs_create_groups(&dev->kobj, msi_irq_groups);
+	if (ret)
+		goto error_irq_groups;
+
+	return msi_irq_groups;
+
+error_irq_groups:
+	kfree(msi_irq_groups);
+error_irq_group:
+	kfree(msi_irq_group);
+error_attrs:
+	count =3D 0;
+	msi_attr =3D msi_attrs[count];
+	while (msi_attr) {
+		msi_dev_attr =3D container_of(msi_attr, struct device_attribute, attr);
+		kfree(msi_attr->name);
+		kfree(msi_dev_attr);
+		++count;
+		msi_attr =3D msi_attrs[count];
+	}
+	kfree(msi_attrs);
+	return ERR_PTR(ret);
+}
+
+/**
+ * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
+ * @dev:		The device(PCI, platform etc) who will remove sysfs entries
+ * @msi_irq_groups:	attribute_group for device msi_irqs entries
+ */
+void msi_destroy_sysfs(struct device *dev, const struct attribute_group **ms=
i_irq_groups)
+{
+	struct device_attribute *dev_attr;
+	struct attribute **msi_attrs;
+	int count =3D 0;
+
+	if (msi_irq_groups) {
+		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
+		msi_attrs =3D msi_irq_groups[0]->attrs;
+		while (msi_attrs[count]) {
+			dev_attr =3D container_of(msi_attrs[count],
+					struct device_attribute, attr);
+			kfree(dev_attr->attr.name);
+			kfree(dev_attr);
+			++count;
+		}
+		kfree(msi_attrs);
+		kfree(msi_irq_groups[0]);
+		kfree(msi_irq_groups);
+	}
+}
+
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
@@ -97,6 +233,8 @@ static void msi_check_level(struct irq_domain *domain, str=
uct msi_msg *msg)
  *
  * Intended to be used by MSI interrupt controllers which are
  * implemented with hierarchical domains.
+ *
+ * Return: IRQ_SET_MASK_* result code
  */
 int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
@@ -277,10 +415,12 @@ static void msi_domain_update_chip_ops(struct msi_domai=
n_info *info)
 }
=20
 /**
- * msi_create_irq_domain - Create a MSI interrupt domain
+ * msi_create_irq_domain - Create an MSI interrupt domain
  * @fwnode:	Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
+ *
+ * Return: pointer to the created &struct irq_domain or %NULL on failure
  */
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
@@ -492,7 +632,7 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, st=
ruct device *dev,
  *		are allocated
  * @nvec:	The number of interrupts to allocate
  *
- * Returns 0 on success or an error code.
+ * Return: %0 on success or an error code.
  */
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec)
@@ -521,7 +661,7 @@ void __msi_domain_free_irqs(struct irq_domain *domain, st=
ruct device *dev)
 }
=20
 /**
- * __msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain ass=
ociated tp @dev
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain assoc=
iated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
@@ -538,8 +678,7 @@ void msi_domain_free_irqs(struct irq_domain *domain, stru=
ct device *dev)
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *
- * Returns the pointer to the msi_domain_info stored in
- * @domain->host_data.
+ * Return: the pointer to the msi_domain_info stored in @domain->host_data.
  */
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
 {
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ce0adb22ee96..ca71123a6130 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -227,7 +227,7 @@ void rearm_wake_irq(unsigned int irq)
 }
=20
 /**
- * irq_pm_syscore_ops - enable interrupt lines early
+ * irq_pm_syscore_resume - enable interrupt lines early
  *
  * Enable all interrupt lines with %IRQF_EARLY_RESUME set.
  */
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 7c5cd42df3b9..ee595ec09778 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -513,7 +513,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_printf(p, " %8s", "None");
 	}
 	if (desc->irq_data.domain)
-		seq_printf(p, " %*d", prec, (int) desc->irq_data.hwirq);
+		seq_printf(p, " %*lu", prec, desc->irq_data.hwirq);
 	else
 		seq_printf(p, " %*s", prec, "");
 #ifdef CONFIG_GENERIC_IRQ_SHOW_LEVEL
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index d309d6fbf5bd..59affb3bfdfa 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -794,12 +794,14 @@ static int __init irq_timings_test_irqs(struct timings_=
intervals *ti)
=20
 		__irq_timings_store(irq, irqs, ti->intervals[i]);
 		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] !=3D index) {
+			ret =3D -EBADSLT;
 			pr_err("Failed to store in the circular buffer\n");
 			goto out;
 		}
 	}
=20
 	if (irqs->count !=3D ti->count) {
+		ret =3D -ERANGE;
 		pr_err("Count differs\n");
 		goto out;
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index f3a012179f47..322b65d45676 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -422,7 +422,7 @@ static inline void invoke_softirq(void)
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
=20
-	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
+	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if

