Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46C0406FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhIJQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:40:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29242 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhIJQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631291944; x=1662827944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbQHrCnbrHZDMHkoDO6acIBG7KqyxGyyCwJQT7ukBw8=;
  b=nTJdUOVN7US5FZeRGKSTYlQSt4Zangqy3NMfZ8hYcdcetKn2J8KCLnMx
   7Kw8vLO9YkNgepoQAXvXAsDJTX2vK32/bsK0F9ONcQFPsOEqZbfr1kLOh
   DbfEBScZnPecoMCEt3gBLE8gfjDaILKG+fejhu/mgfbxlhcZAa72N8JPQ
   GjDcY1lSwxPZt0SWqDJ8GCfquHXnWU1BsJK7DOVVaZoVl03C4xIScFP88
   0PaF+poo3BGyTw+OUj6J1NXieTTf/4Y+wpVkjJjOWRhsL/0ln/jWG+I+Z
   gYIXFJpL+mztoekBUCk1utTKzfXuUTd8EUWTVVAfCRHvIJiGNhrUMzcje
   g==;
IronPort-SDR: KOOWm0v9t6LlQZWvkOeXO59HhJQ8h5wfsDpkATe8v30OJsq4WWq1yGXA0XFX3G3lPAqTfZ1ydV
 ro8mLli7e4sW4zjbVD8M3Ejg4C6I0UG+F9tMExjCDAyi5xq4FAh4Mvv5sVZpuyVJFzeV1xU/5u
 Ho2QJT8Z1IDd6ximzOaLkAc3ZgIxe2HM9dOIosSENePbsaERUcts9U4omTBvEdh25dmsWQrCgE
 ZtGiqE23epp5+y0Bgw4s+smDbbbgsfub+pG+Dhla1Kax1Bwflo7Y1Rv8DZ64vmlkeKClJIFizn
 9E3r1Y0GmffSnRPo9E54DC7f
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="128921683"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2021 09:39:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Sep 2021 09:39:03 -0700
Received: from plexus-g.actel.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:39:00 -0700
From:   <cristian.birsan@microchip.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <ada@thorsis.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 1/2] dt-bindings: usb: atmel: add USB PHY type property
Date:   Fri, 10 Sep 2021 19:38:41 +0300
Message-ID: <20210910163842.1596407-2-cristian.birsan@microchip.com>
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

Add USB PHY type property for controllers with HSIC support.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index a4002624ba14..f512f0290728 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -39,6 +39,10 @@ Required properties:
 		"ehci_clk" for the peripheral clock
 		"usb_clk" for the UTMI clock
 
+Optional properties:
+ - phy_type : For multi port host USB controllers, should be one of
+   "utmi", or "hsic".
+
 usb1: ehci@800000 {
 	compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 	reg = <0x00800000 0x100000>;
-- 
2.25.1

