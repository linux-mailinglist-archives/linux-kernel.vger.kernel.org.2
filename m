Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7D44E90E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhKLOkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232157AbhKLOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:40:05 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8165560D43;
        Fri, 12 Nov 2021 14:37:14 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mlXg0-0052T9-8y; Fri, 12 Nov 2021 14:37:12 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] of/irq: Don't ignore interrupt-controller when interrupt-map failed
Date:   Fri, 12 Nov 2021 14:36:44 +0000
Message-Id: <20211112143644.434995-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, chzigotzky@xenosoft.de, robh@kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
to an interrupt controller"), the irq code favors using an interrupt-map
over a interrupt-controller property if both are available, while the
earlier behaviour was to ignore the interrupt-map altogether.

However, we now end-up with the opposite behaviour, which is to
ignore the interrupt-controller property even if the interrupt-map
fails to match its input. This new behaviour breaks the AmigaOne
X1000 machine, which ships with an extremely "creative" (read:
broken) device tree.

Fix this by allowing the interrupt-controller property to be selected
when interrupt-map fails to match anything.

Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/of/irq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 32be5a03951f..508fb1717de3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -161,9 +161,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		 * if it is then we are done, unless there is an
 		 * interrupt-map which takes precedence.
 		 */
+		bool intc = of_property_read_bool(ipar, "interrupt-controller");
+
 		imap = of_get_property(ipar, "interrupt-map", &imaplen);
-		if (imap == NULL &&
-		    of_property_read_bool(ipar, "interrupt-controller")) {
+		if (imap == NULL && intc) {
 			pr_debug(" -> got it !\n");
 			return 0;
 		}
@@ -244,8 +245,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 			pr_debug(" -> imaplen=%d\n", imaplen);
 		}
-		if (!match)
+		if (!match) {
+			if (intc) {
+				pr_debug("%pOF interrupt-map failed, using interrupt-controller\n", ipar);
+				return 0;
+			}
+
 			goto fail;
+		}
 
 		/*
 		 * Successfully parsed an interrrupt-map translation; copy new
-- 
2.30.2

