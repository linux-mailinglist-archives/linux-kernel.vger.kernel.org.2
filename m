Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E143D0F93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhGUMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:50:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42792 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhGUMuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626874276; x=1658410276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I7WNKuI7+/pCzxmkLSNPPRi3rAKXl6Cc8hkgas1mvPw=;
  b=vqUkM+KHylyWtfaxGXwuC/eBXD24k3NZzhwHpkoasmXQZFnGogd0kqfX
   I3tafE/KOsm63YttpYIb+YyVy4wL7fkITEdclGD4qcZXVOYvPb+e+6q9v
   xGJWOafRMjmrz5gOu1ENc4OLijx3/yLFltvmV7EOfv74gNmwMuHV9aWH/
   LSZGGFVV0oEb6b4jawyZUGJVMXx03PtebnbKf1a4kc7zc7Kal881wIgiE
   hLB6EblBjGlrdGToIH7zI3GBh5MUwWztRSDYSx0IdMS7ldZxu7Gq2yV9b
   tt5Y7EdMqbpAqVgJie5i5hJsfdHW+aPWyylLb1/S6t6F4lU4ot0WdEUWD
   w==;
IronPort-SDR: TB1f9NIV08DZNaBwaSYx0KT7fE2RjAj4o1xmO1rb/uIqteCgZuXpCb3ciqzIVcFSGpjmcNym7B
 TUjxXRU9v7s5+Do9hjAIWwJ/tUWTF+isqlvkw0bqLNXslQcwrXGvHlAyY/fU03cyMgFm/Qr6/S
 I/kK/oWmzGwHbKikYlhSzHPLP69NZbpfGQJh9JsAi7Y10CuyqyKm9v2CGFRD96XPqBkSstRTva
 mINJqJ1r3t9le8gfd+xXTZIFezdi5aitZZbyQfWPawXSWLv3KNdqRrp5z790I0d+HZBFgSif5N
 LHwMqRsu8gK7vknZNp/RCYO0
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="122877766"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2021 06:31:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 06:31:15 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 21 Jul 2021 06:31:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2] usb: host: ohci-at91: suspend/resume ports after/before OHCI accesses
Date:   Wed, 21 Jul 2021 16:29:05 +0300
Message-ID: <20210721132905.1970713-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5 suspending ports will cut the access to OHCI registers and
any subsequent access to them will lead to CPU being blocked trying to
access that memory. Same thing happens on resume: if OHCI memory is
accessed before resuming ports the CPU will block on that access. The
OCHI memory is accessed on suspend/resume though
ohci_suspend()/ohci_resume().

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- rebase on top of v5.14-rc2
- collected tag

 drivers/usb/host/ohci-at91.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 9bbd7ddd0003..a24aea3d2759 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -611,8 +611,6 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	if (ohci_at91->wakeup)
 		enable_irq_wake(hcd->irq);
 
-	ohci_at91_port_suspend(ohci_at91->sfr_regmap, 1);
-
 	ret = ohci_suspend(hcd, ohci_at91->wakeup);
 	if (ret) {
 		if (ohci_at91->wakeup)
@@ -632,7 +630,10 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
 		msleep(1);
+		ohci_at91_port_suspend(ohci_at91->sfr_regmap, 1);
 		at91_stop_clock(ohci_at91);
+	} else {
+		ohci_at91_port_suspend(ohci_at91->sfr_regmap, 1);
 	}
 
 	return ret;
@@ -644,6 +645,8 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
 
+	ohci_at91_port_suspend(ohci_at91->sfr_regmap, 0);
+
 	if (ohci_at91->wakeup)
 		disable_irq_wake(hcd->irq);
 	else
@@ -651,8 +654,6 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 
 	ohci_resume(hcd, false);
 
-	ohci_at91_port_suspend(ohci_at91->sfr_regmap, 0);
-
 	return 0;
 }
 
-- 
2.25.1

