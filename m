Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965EE38B4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhETRBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239664AbhETQ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421736139A;
        Thu, 20 May 2021 16:58:06 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgu-002d7b-QD; Thu, 20 May 2021 17:38:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 31/39] mfd: Bulk conversion to generic_handle_domain_irq()
Date:   Thu, 20 May 2021 17:37:43 +0100
Message-Id: <20210520163751.27325-32-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/mfd/db8500-prcmu.c    |  2 +-
 drivers/mfd/fsl-imx25-tsadc.c |  4 ++--
 drivers/mfd/ioc3.c            | 10 +++-------
 drivers/mfd/qcom-pm8xxx.c     | 10 ++++------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 167faac9b75b..3ca7d0bfe2f7 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2364,7 +2364,7 @@ static bool read_mailbox_0(void)
 
 		for (n = 0; n < NUM_PRCMU_WAKEUPS; n++) {
 			if (ev & prcmu_irq_bit[n])
-				generic_handle_irq(irq_find_mapping(db8500_irq_domain, n));
+				generic_handle_domain_irq(db8500_irq_domain, n);
 		}
 		r = true;
 		break;
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 5f6f0a83e1c5..37e5e02a1d05 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -35,10 +35,10 @@ static void mx25_tsadc_irq_handler(struct irq_desc *desc)
 	regmap_read(tsadc->regs, MX25_TSC_TGSR, &status);
 
 	if (status & MX25_TGSR_GCQ_INT)
-		generic_handle_irq(irq_find_mapping(tsadc->domain, 1));
+		generic_handle_domain_irq(tsadc->domain, 1);
 
 	if (status & MX25_TGSR_TCQ_INT)
-		generic_handle_irq(irq_find_mapping(tsadc->domain, 0));
+		generic_handle_domain_irq(tsadc->domain, 0);
 
 	chained_irq_exit(chip, desc);
 }
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 99b9c113f964..58656837b7c6 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -105,19 +105,15 @@ static void ioc3_irq_handler(struct irq_desc *desc)
 	struct ioc3_priv_data *ipd = domain->host_data;
 	struct ioc3 __iomem *regs = ipd->regs;
 	u32 pending, mask;
-	unsigned int irq;
 
 	pending = readl(&regs->sio_ir);
 	mask = readl(&regs->sio_ies);
 	pending &= mask; /* Mask off not enabled interrupts */
 
-	if (pending) {
-		irq = irq_find_mapping(domain, __ffs(pending));
-		if (irq)
-			generic_handle_irq(irq);
-	} else  {
+	if (pending)
+		generic_handle_domain_irq(domain, __ffs(pending));
+	else
 		spurious_interrupt();
-	}
 }
 
 /*
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index acd172ddcbd6..ec18a04de355 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -122,7 +122,7 @@ pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
 
 static int pm8xxx_irq_block_handler(struct pm_irq_chip *chip, int block)
 {
-	int pmirq, irq, i, ret = 0;
+	int pmirq, i, ret = 0;
 	unsigned int bits;
 
 	ret = pm8xxx_read_block_irq(chip, block, &bits);
@@ -139,8 +139,7 @@ static int pm8xxx_irq_block_handler(struct pm_irq_chip *chip, int block)
 	for (i = 0; i < 8; i++) {
 		if (bits & (1 << i)) {
 			pmirq = block * 8 + i;
-			irq = irq_find_mapping(chip->irqdomain, pmirq);
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
 
 	ret = regmap_read(chip->regmap,
@@ -216,8 +215,7 @@ static void pm8821_irq_block_handler(struct pm_irq_chip *chip,
 	for (i = 0; i < 8; i++) {
 		if (bits & BIT(i)) {
 			pmirq = block * 8 + i;
-			irq = irq_find_mapping(chip->irqdomain, pmirq);
-			generic_handle_irq(irq);
+			generic_handle_domain_irq(chip->irqdomain, pmirq);
 		}
 	}
 }
-- 
2.30.2

