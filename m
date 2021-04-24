Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBD36A091
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhDXJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhDXJro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:47:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E449161409;
        Sat, 24 Apr 2021 09:47:05 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1laEsR-009DQH-Kc; Sat, 24 Apr 2021 10:47:03 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hao Fang <fanghao11@huawei.com>, He Ying <heying24@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.13
Date:   Sat, 24 Apr 2021 10:46:40 +0100
Message-Id: <20210424094640.1731920-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, arnd@arndb.de, christian.ruppert@abilis.com, erwan.leray@foss.st.com, geert+renesas@glider.be, fanghao11@huawei.com, heying24@huawei.com, jszhang@kernel.org, j.neuschaefer@gmx.net, lorenzo.pieralisi@arm.com, mark-pk.tsai@mediatek.com, mark.rutland@arm.com, rnayak@codeaurora.org, rdunlap@infradead.org, robert.hancock@calian.com, robh@kernel.org, swboyd@chromium.org, tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

This is the set of irqchip/irqdomain updates for 5.13. Only a couple
of new drivers this time around (though see below for the actual
truth), a handful of fixes, and the start of a long overdue cleanup of
the irqdomain library to try and get rid of some of the ancient (and
mostly unused) cruft.

But this PR isn't the full story: we also have support for the Apple
M1 going via the the arm-soc tree, as it made more sense to keep all
the various bits together. There is also the MSI rework to get rid of
the msi_controller abstraction that is going via the PCI tree.

Please pull,

	M.

The following changes since commit 5fbecd2389f48e1415799c63130d0cdce1cf3f60:

  irqchip/ingenic: Add support for the JZ4760 (2021-03-09 08:45:17 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.13

for you to fetch changes up to debf69cfd4c618c7036a13cc4edd1faf87ce7d53:

  irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP (2021-04-24 09:50:03 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.13

New HW support:

- New driver for the Nuvoton WPCM450 interrupt controller
- New driver for the IDT 79rc3243x interrupt controller
- Add support for interrupt trigger configuration to the MStar irqchip
- Add more external interrupt support to the STM32 irqchip
- Add new compatible strings for QCOM SC7280 to the qcom-pdc binding

Fixes and cleanups:

- Drop irq_create_strict_mappings() and irq_create_identity_mapping()
  from the irqdomain API, with cleanups in a couple of drivers
- Fix nested NMI issue with spurious interrupts on GICv3
- Don't allow GICv4.1 vSGIs when the CPU doesn't support them
- Various cleanups and minor fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      irqchip/gic-v3: Fix OF_BAD_ADDR error handling

Erwan Le Ray (1):
      irqchip/stm32: Add usart instances exti direct event support

Hao Fang (1):
      irqchip/hisi: Use the correct HiSilicon copyright

He Ying (1):
      irqchip/gic-v3: Do not enable irqs when handling spurious interrups

Jisheng Zhang (1):
      irqchip/sifive-plic: Mark two global variables __ro_after_init

Jonathan Neuschäfer (2):
      dt-bindings: interrupt-controller: Add nuvoton, wpcm450-aic
      irqchip: Add driver for WPCM450 interrupt controller

Lorenzo Pieralisi (1):
      irqchip/gic-v4.1: Disable vSGI upon (GIC CPUIF < v4.1) detection

Marc Zyngier (8):
      sh: intc: Drop the use of irq_create_identity_mapping()
      irqdomain: Get rid of irq_create_identity_mapping()
      mips: netlogic: Use irq_domain_simple_ops for XLP PIC
      irqchip/wpcm450: Drop COMPILE_TEST
      ARM: PXA: Kill use of irq_create_strict_mappings()
      irqchip/jcore-aic: Kill use of irq_create_strict_mappings()
      irqdomain: Get rid of irq_create_strict_mappings()
      irqdomain: Drop references to recusive irqdomain setup

Mark-PK Tsai (1):
      irqchip/irq-mst: Support polarity configuration

Rajendra Nayak (1):
      dt-bindings: qcom,pdc: Add compatible for sc7280

Randy Dunlap (1):
      irqchip/tb10x: Use 'fallthrough' to eliminate a warning

Robert Hancock (1):
      irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP

Thomas Bogendoerfer (2):
      irqchip: Add support for IDT 79rc3243x interrupt controller
      dt-bindings: interrupt-controller: Add IDT 79RC3243x Interrupt Controller

 .../interrupt-controller/idt,32434-pic.yaml        |  48 ++++++
 .../interrupt-controller/nuvoton,wpcm450-aic.yaml  |  39 +++++
 .../bindings/interrupt-controller/qcom,pdc.txt     |   1 +
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 |  24 ++-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |   4 +-
 arch/mips/netlogic/common/irq.c                    |   6 +-
 drivers/irqchip/Kconfig                            |  18 ++-
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-gic-v3-mbi.c                   |   2 +-
 drivers/irqchip/irq-gic-v3.c                       |   8 +-
 drivers/irqchip/irq-gic-v4.c                       |  27 +++-
 drivers/irqchip/irq-hip04.c                        |   4 +-
 drivers/irqchip/irq-idt3243x.c                     | 124 ++++++++++++++++
 drivers/irqchip/irq-jcore-aic.c                    |   4 +-
 drivers/irqchip/irq-mbigen.c                       |   4 +-
 drivers/irqchip/irq-mst-intc.c                     |  98 ++++++++++++-
 drivers/irqchip/irq-sifive-plic.c                  |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   |   7 +
 drivers/irqchip/irq-tb10x.c                        |   1 +
 drivers/irqchip/irq-wpcm450-aic.c                  | 161 +++++++++++++++++++++
 drivers/sh/intc/core.c                             |  49 +++----
 include/linux/irqchip/arm-gic-v4.h                 |   2 +
 include/linux/irqdomain.h                          |   9 --
 kernel/irq/irqdomain.c                             |  43 +-----
 24 files changed, 570 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/idt,32434-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml
 create mode 100644 drivers/irqchip/irq-idt3243x.c
 create mode 100644 drivers/irqchip/irq-wpcm450-aic.c
