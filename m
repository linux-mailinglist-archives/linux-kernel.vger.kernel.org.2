Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C877406FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhIJQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:40:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29242 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhIJQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631291947; x=1662827947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j3/W4EVBQOz9yH/HC2QsqbHvKVE/H182DHHZWWu1UyY=;
  b=jfzkFq0GNThvjZggI1uphjeOs+v1r7kJU5I8pUR7z2Lu6kYwFd2nW6nd
   8im4xRjocBal/NWgH6J4U6xuH7GNQ9lsMtWB37Q8kcRoeo80b620yNgx8
   TVrhk6YZWL+Swxhd4elEf7sKPnARyp0WAQxZlCuZyyL5i/KXex9ldAY5t
   fe3s+tJPoO8RMHalTY/gYsBUVoP4HhLwYTGrlaqLiuLjMYUrfQKtDlAgl
   G3GShlHDWSd47wkmGB8JUvpUuAPyBOLwk4Xg4NZQCTS3og5z+FvUlMInC
   LHJvwA+rB3Pk9IAP7d6EjnpkahRTTGAaqa4r+XXi8Uw3ELA97Vm/1Tr5t
   A==;
IronPort-SDR: /Z6pG8TEJkhA6tlDKFyAAC8ZuEQdHh4tI8jwvWJiG2D8RLvZn5k6CAmRhQr3TXQnThyePZlAIR
 G3EhUndK5ivhI2UqqbjSkq7HcMFt5Oiy91F8nMHYyN+uglu1W98gMGxVy1fhH+2EyH+aIta8iK
 ATqopXeLcNNquXhcmiHFFE/zamMF7DmYypAHpsV4V36wQ+99/a6fJndH+B/VsyOhv7zAmH7648
 3v5SGkc77lioTj6KBDq3isEJE/N39UDTrxP5EqhOZXqMmzCcpfvhPuzyaSFhGPGD7H7Sk9FA7+
 obwAGh2txsTDsF8caim4IF7/
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="128921696"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2021 09:39:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Sep 2021 09:39:06 -0700
Received: from plexus-g.actel.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:39:04 -0700
From:   <cristian.birsan@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <ada@thorsis.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 2/2] USB: host: ehci-atmel: Add support for HSIC phy
Date:   Fri, 10 Sep 2021 19:38:42 +0300
Message-ID: <20210910163842.1596407-3-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910163842.1596407-1-cristian.birsan@microchip.com>
References: <20210910163842.1596407-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Add support for USB Host High Speed Port HSIC phy.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/host/ehci-atmel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index e893467d659c..05d41fd65f25 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/of.h>
 
 #include "ehci.h"
 
@@ -25,6 +27,9 @@
 
 static const char hcd_name[] = "ehci-atmel";
 
+#define EHCI_INSNREG(index)			((index) * 4 + 0x90)
+#define EHCI_INSNREG08_HSIC_EN			BIT(2)
+
 /* interface and function clocks */
 #define hcd_to_atmel_ehci_priv(h) \
 	((struct atmel_ehci_priv *)hcd_to_ehci(h)->priv)
@@ -154,6 +159,9 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 		goto fail_add_hcd;
 	device_wakeup_enable(hcd->self.controller);
 
+	if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_HSIC)
+		writel(EHCI_INSNREG08_HSIC_EN, hcd->regs + EHCI_INSNREG(8));
+
 	return retval;
 
 fail_add_hcd:
-- 
2.25.1

