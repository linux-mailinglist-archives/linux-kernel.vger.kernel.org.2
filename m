Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01718458C42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhKVKdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236184AbhKVKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:33:53 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C186660F6B;
        Mon, 22 Nov 2021 10:30:40 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mp6as-0071pT-Gp; Mon, 22 Nov 2021 10:30:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kernel-team@android.com, Rob Herring <robh@kernel.org>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of/irq: Add a quirk for controllers with their own definition of interrupt-map
Date:   Mon, 22 Nov 2021 10:30:32 +0000
Message-Id: <20211122103032.517923-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel-team@android.com, robh@kernel.org, john@phrozen.org, biwen.li@nxp.com, chris.brandt@renesas.com, geert+renesas@glider.be
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
to an interrupt controller"), a handful of interrupt controllers have
stopped working correctly. This is due to the DT exposing a non-sensical
interrupt-map property, and their drivers relying on the kernel ignoring
this property.

Since we cannot realistically fix this terrible behaviour, add a quirk
for the limited set of devices that have implemented this monster,
and document that this is a pretty bad practice.

Cc: Rob Herring <robh@kernel.org>
Cc: John Crispin <john@phrozen.org>
Cc: Biwen Li <biwen.li@nxp.com>
Cc: Chris Brandt <chris.brandt@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index b10f015b2e37..27a5173c813c 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -76,6 +76,36 @@ struct device_node *of_irq_find_parent(struct device_node *child)
 }
 EXPORT_SYMBOL_GPL(of_irq_find_parent);
 
+/*
+ * These interrupt controllers abuse interrupt-map for unspeakable
+ * reasons and rely on the core code to *ignore* it (the drivers do
+ * their own parsing of the property).
+ *
+ * If you think of adding to the list for something *new*, think
+ * again. There is a high chance that you will be sent back to the
+ * drawing board.
+ */
+static const char * const of_irq_imap_abusers[] = {
+	"CBEA,platform-spider-pic",
+	"sti,platform-spider-pic",
+	"realtek,rtl-intc",
+	"fsl,ls1021a-extirq",
+	"fsl,ls1043a-extirq",
+	"fsl,ls1088a-extirq",
+	"renesas,rza1-irqc",
+};
+
+static bool of_irq_abuses_interrupt_map(struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(of_irq_imap_abusers); i++)
+		if (of_device_is_compatible(np, of_irq_imap_abusers[i]))
+			return true;
+
+	return false;
+}
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
@@ -159,12 +189,15 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		/*
 		 * Now check if cursor is an interrupt-controller and
 		 * if it is then we are done, unless there is an
-		 * interrupt-map which takes precedence.
+		 * interrupt-map which takes precedence if we're not
+		 * in presence of once of these broken platform that
+		 * want to parse interrupt-map themselves for $reason.
 		 */
 		bool intc = of_property_read_bool(ipar, "interrupt-controller");
 
 		imap = of_get_property(ipar, "interrupt-map", &imaplen);
-		if (imap == NULL && intc) {
+		if (intc && (imap == NULL ||
+			     (imap && of_irq_abuses_interrupt_map(ipar)))) {
 			pr_debug(" -> got it !\n");
 			return 0;
 		}
-- 
2.30.2

