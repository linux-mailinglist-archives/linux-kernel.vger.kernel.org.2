Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3004731B05F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBNMlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 07:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNMlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 07:41:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B3F64DA8;
        Sun, 14 Feb 2021 12:40:32 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lBGhS-00E7PN-5G; Sun, 14 Feb 2021 12:40:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Barry Song <baohua@kernel.org>,
        Bert Vermeulen <bert@biot.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Biwen Li <biwen.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@linux.alibaba.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Vinod Koul <vkoul@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.12
Date:   Sun, 14 Feb 2021 12:40:15 +0000
Message-Id: <20210214124015.3333457-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, arnd@arndb.de, baohua@kernel.org, bert@biot.com, mail@birger-koblitz.de, biwen.li@nxp.com, bjorn.andersson@linaro.org, geert+renesas@glider.be, guoren@linux.alibaba.com, chenhuacai@loongson.cn, john@phrozen.org, lorenzo.pieralisi@arm.com, mans@mansr.com, marc.w.gonzalez@free.fr, mripard@kernel.org, robh@kernel.org, samuel@sholland.org, vkoul@kernel.org, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the bulk of the irqchip updates for 5.12. For once, it is
*very* quiet, and one could almost believe that people have stopped
inventing new interrupt controllers. A quick look at what is brewing
indicates that they are just trying to lure us into a false sense of
security. Oh well.

This time around, we have two new drivers (RTL838x/RTL839x and
sun6i-r), two removed drivers (sirfsoc and tango), a couple of fixes,
and the rest is a mundane mix of Kconconfig and DT binding updates.

Please pull,

	M.

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.12

for you to fetch changes up to a890caeb2ba40ca183969230e204ab144f258357:

  irqchip/imx: IMX_INTMUX should not default to y, unconditionally (2021-02-14 12:01:16 +0000)

----------------------------------------------------------------
irqchip updates for Linux 5.12:

- New driver for the MIPS-based Realtek RTL838x/RTL839x SoC
- Conversion of the sun6i-r support code to a hierarchical setup
- Fix wake-up interrupts for the ls-extirq driver
- Fix MSI allocation for the loongson-pch-msi driver
- Add compatible strings for new Qualcomm SoCs
- Tidy up a few Kconfig entries (IMX, CSKY)
- Spelling phyksiz
- Remove the sirfsoc and tango drivers

----------------------------------------------------------------
Arnd Bergmann (2):
      irqchip: Remove sigma tango driver
      irqchip: Remove sirfsoc driver

Bert Vermeulen (2):
      dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support
      irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller

Biwen Li (1):
      irqchip/ls-extirq: add IRQCHIP_SKIP_SET_WAKE to the irqchip flags

Geert Uytterhoeven (1):
      irqchip/imx: IMX_INTMUX should not default to y, unconditionally

Guo Ren (1):
      irqchip/csky-mpintc: Prevent selection on unsupported platforms

Huacai Chen (1):
      irqchip/loongson-pch-msi: Use bitmap_zalloc() to allocate bitmap

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Fix typos in PMR/RPR SCR_EL3.FIQ handling explanation

Samuel Holland (4):
      dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
      dt-bindings: irq: sun6i-r: Add a compatible for the H3
      irqchip/sun6i-r: Use a stacked irqchip driver
      irqchip/sun6i-r: Add wakeup support

Vinod Koul (2):
      dt-bindings: qcom,pdc: Add compatible for SM8250
      dt-bindings: qcom,pdc: Add compatible for SM8350

 .../allwinner,sun6i-a31-r-intc.yaml                |  67 ++++
 .../allwinner,sun7i-a20-sc-nmi.yaml                |  10 -
 .../bindings/interrupt-controller/qcom,pdc.txt     |   2 +
 .../interrupt-controller/realtek,rtl-intc.yaml     |  57 ++++
 .../interrupt-controller/sigma,smp8642-intc.txt    |  48 ---
 arch/arm/mach-sunxi/Kconfig                        |   2 +
 arch/arm64/Kconfig.platforms                       |   2 +
 drivers/irqchip/Kconfig                            |  10 +-
 drivers/irqchip/Makefile                           |   4 +-
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-loongson-pch-msi.c             |   2 +-
 drivers/irqchip/irq-ls-extirq.c                    |   2 +-
 drivers/irqchip/irq-realtek-rtl.c                  | 180 ++++++++++
 drivers/irqchip/irq-sirfsoc.c                      | 134 --------
 drivers/irqchip/irq-sun6i-r.c                      | 379 +++++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c                    |  26 +-
 drivers/irqchip/irq-tango.c                        | 227 ------------
 17 files changed, 701 insertions(+), 455 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
 create mode 100644 drivers/irqchip/irq-realtek-rtl.c
 delete mode 100644 drivers/irqchip/irq-sirfsoc.c
 create mode 100644 drivers/irqchip/irq-sun6i-r.c
 delete mode 100644 drivers/irqchip/irq-tango.c
