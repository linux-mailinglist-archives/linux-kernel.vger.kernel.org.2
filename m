Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA63F5857
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhHXGjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:39:19 -0400
Received: from mail.thorsis.com ([92.198.35.195]:38898 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231401AbhHXGjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:39:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 19950ECC;
        Tue, 24 Aug 2021 08:38:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q-l84O7cbou0; Tue, 24 Aug 2021 08:38:27 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 85C50D17; Tue, 24 Aug 2021 08:38:24 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: thorsis.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
Received: from adahl by ada.ifak-system.com with local (Exim 4.92)
        (envelope-from <ada@thorsis.com>)
        id 1mIQ3S-0006PM-Pe; Tue, 24 Aug 2021 08:37:02 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] USB: host: ehci-atmel: Allow enabling HSIC on SAMA5D2
Date:   Tue, 24 Aug 2021 08:37:02 +0200
Message-Id: <20210824063702.24586-1-ada@thorsis.com>
In-Reply-To: <20210823140052.GA120849@rowland.harvard.edu>
References: <20210823140052.GA120849@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other SoC series featuring the 'atmel,at91sam9g45-ehci' USB EHCI
controller, which have embedded USB high-speed transceivers for each
port, the third port on the SAMA5D2 series is HSIC only.  That HSIC
interface is not enabled after a power-on reset, but can be enabled by
setting a flag in a vendor specific EHCI register.

The register offsets added to the new header file were compared with
those for the SAM9G45, SAM9X25, SAMA5D3, SAMA5D4, and SAM9X60 series and
there are no differences in the offsets or contents of those registers.
Which of those additional vendor specific registers are supported,
differs by SoC family.  So while the HSIC enable feature is currently
only present for SAMA5D2, it probably does not hurt to set it on the
other families, hence no additional check for SoC family here.

Tested on a custom board featuring a SAMA5D27C-D5M SiP connected to an
USB3503 hub with an upstream HSIC interface.

Link: https://community.atmel.com/forum/sama5d2-using-hsic-under-linux
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    - for introducing new dt binding, would be nice to convert old one
      first, probably needs split up and multiple iteration review?
    - name of that new dt property?
    - register definitions put to a separate file, like
      'drivers/usb/host/ehci-fsl.h'
    - unsure where exactly in the probe process that register write should
      happen, datasheet gives no hint
    - should suspend/resume be considered?

 drivers/usb/host/ehci-atmel.c | 17 +++++++++++++++++
 drivers/usb/host/ehci-atmel.h | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 drivers/usb/host/ehci-atmel.h

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index e893467d659c..f8d9e686c082 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -20,6 +20,7 @@
 #include <linux/usb/hcd.h>
 
 #include "ehci.h"
+#include "ehci-atmel.h"
 
 #define DRIVER_DESC "EHCI Atmel driver"
 
@@ -85,6 +86,7 @@ static void atmel_stop_ehci(struct platform_device *pdev)
 
 static int ehci_atmel_drv_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct usb_hcd *hcd;
 	const struct hc_driver *driver = &ehci_atmel_hc_driver;
 	struct resource *res;
@@ -149,6 +151,14 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 
 	atmel_start_ehci(pdev);
 
+	if (of_property_read_bool(np, "atmel,enable-hsic")) {
+		u32 tmp;
+
+		tmp = ehci_readl(ehci, hcd->regs + AT91_UHPHS_INSNREG08);
+		tmp |= AT91_UHPHS_HSIC_EN;
+		ehci_writel(ehci, tmp, hcd->regs + AT91_UHPHS_INSNREG08);
+	}
+
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval)
 		goto fail_add_hcd;
@@ -170,10 +180,17 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 static int ehci_atmel_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ehci_hcd *ehci;
+	u32 tmp;
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
+	ehci = hcd_to_ehci(hcd);
+	tmp = ehci_readl(ehci, hcd->regs + AT91_UHPHS_INSNREG08);
+	tmp &= ~AT91_UHPHS_HSIC_EN;
+	ehci_writel(ehci, tmp, hcd->regs + AT91_UHPHS_INSNREG08);
+
 	atmel_stop_ehci(pdev);
 
 	return 0;
diff --git a/drivers/usb/host/ehci-atmel.h b/drivers/usb/host/ehci-atmel.h
new file mode 100644
index 000000000000..4c4998c2a6dd
--- /dev/null
+++ b/drivers/usb/host/ehci-atmel.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Vendor specific definitions for EHCI on Atmel/Microchip SoCs.
+ *
+ * © 2021 Alexander Dahl <ada@thorsis.com>
+ */
+#ifndef EHCI_ATMEL_H
+#define EHCI_ATMEL_H
+
+/* device specific register offsets, taken from SAMA5D2 datasheet */
+
+#define AT91_UHPHS_INSNREG06    0xA8        /* AHB Error Status Register */
+
+#define AT91_UHPHS_INSNREG07    0xAC        /* AHB Master Error Address Register */
+
+#define AT91_UHPHS_INSNREG08    0xB0        /* HSIC Enable/Disable Register */
+#define AT91_UHPHS_HSIC_EN      (1 << 2)    /* HSIC Enable/Disable */
+
+#endif /* ECHI_ATMEL_H */

base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
-- 
2.30.2

