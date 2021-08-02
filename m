Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B63DDDA1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhHBQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232834AbhHBQ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:27:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710446112D;
        Mon,  2 Aug 2021 16:26:53 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mAamB-002WEi-SB; Mon, 02 Aug 2021 17:26:51 +0100
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
Subject: [PATCH v2 07/14] ARM: Bulk conversion to generic_handle_domain_irq()
Date:   Mon,  2 Aug 2021 17:26:23 +0100
Message-Id: <20210802162630.2219813-8-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210802162630.2219813-1-maz@kernel.org>
References: <20210802162630.2219813-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/common/sa1111.c           | 12 ++----------
 arch/arm/mach-pxa/pxa_cplds_irqs.c |  6 ++----
 arch/arm/mach-s3c/irq-s3c24xx.c    |  5 ++---
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index ff5e0d04cb89..d17083c3fe2d 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -196,14 +196,6 @@ static int sa1111_map_irq(struct sa1111 *sachip, irq_hw_number_t hwirq)
 	return irq_create_mapping(sachip->irqdomain, hwirq);
 }
 
-static void sa1111_handle_irqdomain(struct irq_domain *irqdomain, int irq)
-{
-	struct irq_desc *d = irq_to_desc(irq_linear_revmap(irqdomain, irq));
-
-	if (d)
-		generic_handle_irq_desc(d);
-}
-
 /*
  * SA1111 interrupt support.  Since clearing an IRQ while there are
  * active IRQs causes the interrupt output to pulse, the upper levels
@@ -234,11 +226,11 @@ static void sa1111_irq_handler(struct irq_desc *desc)
 
 	for (i = 0; stat0; i++, stat0 >>= 1)
 		if (stat0 & 1)
-			sa1111_handle_irqdomain(irqdomain, i);
+			generic_handle_domain_irq(irqdomain, i);
 
 	for (i = 32; stat1; i++, stat1 >>= 1)
 		if (stat1 & 1)
-			sa1111_handle_irqdomain(irqdomain, i);
+			generic_handle_domain_irq(irqdomain, i);
 
 	/* For level-based interrupts */
 	desc->irq_data.chip->irq_unmask(&desc->irq_data);
diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index bddfc7cd5d40..eda5a47d7fbb 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -39,10 +39,8 @@ static irqreturn_t cplds_irq_handler(int in_irq, void *d)
 
 	do {
 		pending = readl(fpga->base + FPGA_IRQ_SET_CLR) & fpga->irq_mask;
-		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ) {
-			generic_handle_irq(irq_find_mapping(fpga->irqdomain,
-							    bit));
-		}
+		for_each_set_bit(bit, &pending, CPLDS_NB_IRQ)
+			generic_handle_domain_irq(fpga->irqdomain, bit);
 	} while (pending);
 
 	return IRQ_HANDLED;
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 0c631c14a817..3edc5f614eef 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -298,7 +298,7 @@ static void s3c_irq_demux(struct irq_desc *desc)
 	struct s3c_irq_data *irq_data = irq_desc_get_chip_data(desc);
 	struct s3c_irq_intc *intc = irq_data->intc;
 	struct s3c_irq_intc *sub_intc = irq_data->sub_intc;
-	unsigned int n, offset, irq;
+	unsigned int n, offset;
 	unsigned long src, msk;
 
 	/* we're using individual domains for the non-dt case
@@ -318,8 +318,7 @@ static void s3c_irq_demux(struct irq_desc *desc)
 	while (src) {
 		n = __ffs(src);
 		src &= ~(1 << n);
-		irq = irq_find_mapping(sub_intc->domain, offset + n);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(sub_intc->domain, offset + n);
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.30.2

