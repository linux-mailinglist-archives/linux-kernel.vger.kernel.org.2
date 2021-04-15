Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03993607B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhDOKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:52:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1120 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhDOKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483919; x=1650019919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9yfjvXmswemLhVtI+btx9+2waMn+EiVZ85j75+8VHwc=;
  b=FQxDwI2Znue9gC6987tRt2GHkZlp78p/QUoYsUQew1TLnG/MulAgTXR5
   U97qvDrOQd7nLYrM3cJWo/aN/9Y4XXpa7uW8peDf4gUBFY0U1DWnYNN+S
   X0JBIa/SMBpEKkmA1roRQS2JS4icU1tRkgfXcbaMpOp1erEjUCDET3P+T
   +VhxtpMyAy+d6+tD6uBunOyxoJtBKbTA1yB3lWR+g55HHGkO/r+p8NNGt
   ZWKgfOay+4g1fHkM48yfBrfg8GgoCaWFuH2CSt7LSjzThSbijaYo7LhTT
   CYhDBQKP64GyaRKwCYwFodqShjMsDGNaG9LHWK19+crqNA/Sfxk1fo8wH
   Q==;
IronPort-SDR: mWe3A+yE9yo1tW1VtVPgmOHyGHFqrQxNEgH88q8O/TajuRBITz0C11rk6oYHxM6d5D3waoDXUE
 1BhkaKerHoOiQpUCUTFdbsWuAnU4M/NPks9YhXsHVLW5xAcehRD+fpKWg9x0KyW02FUy8+2DMj
 eZx2my8QeMITLFyy7Yc+61pFViE3ZwcK9UDqr995qrE8KhlRJ2hu0G4Me3xU+q/J4vzE3f+375
 r30NmNeqi4hAgrgmZOlZuS15MuCBE2/UP1qG3qy4pXCX2DCVG14nZnUhLJwxuSxVpg/o+8venc
 G64=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="117122152"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:51:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:51:59 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:51:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 16/24] dt-bindings: atmel-sysreg: add bindings for sama7g5
Date:   Thu, 15 Apr 2021 13:50:02 +0300
Message-ID: <20210415105010.569620-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RAM controller and RAM PHY controller DT bindings.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt      | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 807264a78edc..16eef600d599 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -45,7 +45,8 @@ RAMC SDRAM/DDR Controller required properties:
 			"atmel,at91sam9260-sdramc",
 			"atmel,at91sam9g45-ddramc",
 			"atmel,sama5d3-ddramc",
-			"microchip,sam9x60-ddramc"
+			"microchip,sam9x60-ddramc",
+			"microchip,sama7g5-uddrc"
 - reg: Should contain registers location and length
 
 Examples:
@@ -55,6 +56,17 @@ Examples:
 		reg = <0xffffe800 0x200>;
 	};
 
+RAMC PHY Controller required properties:
+- compatible: Should be "microchip,sama7g5-ddr3phy", "syscon"
+- reg: Should contain registers location and length
+
+Example:
+
+	ddr3phy: ddr3phy@e3804000 {
+		compatible = "microchip,sama7g5-ddr3phy", "syscon";
+		reg = <0xe3804000 0x1000>;
+};
+
 SHDWC Shutdown Controller
 
 required properties:
-- 
2.25.1

