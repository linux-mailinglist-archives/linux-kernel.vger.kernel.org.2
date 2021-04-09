Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4E359D09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhDILRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:17:47 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31422 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhDILRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617967043; x=1649503043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxCT6tDlt+U3ggKv1NPVzCYZ9HIlt2jE8A4pFsshM/Y=;
  b=Dtv9dvFLFQwH+BWVL4p6nND7tIRfSCQ6VqFCPiG5kv7dE7PM2N7q4rQA
   +t2E4p8QDVs3q4no5eJ2IayhYZrL9t4kwvmxWdjT9z+11JsPw0YHRNm+B
   erMQ8bga+RSq83q1y5O++Clq6GplufLCBITw4k07KvZ4VjjO31tnKeTzC
   jOwER3HOb/OGP2gRGj/Iy0+9lrdexysmCWQxPaAfxLHmFHhIjqnBNTZVs
   3HPnFHMmkV+GDZVmVr+Si1O5dGVzd9sNMQ3DBd6nzKXVQskTkYWvPFzzq
   u44ozO/9t9Qr7zlqH+zntZ/Cavs6kcNBnXe5eYatrvN+ZluV9PVUCN0fZ
   w==;
IronPort-SDR: zPk01M+Fsqw2PFLdJ0Xu9jPi5oTd8xSlT3bBiVyKt9kSLIO3A0wi+UehPCMWNP3djFNHMPA8/M
 0vbxiZUAvfdg0s4l4Zf05V9iR3uSD97U4WxzL+oAqX6hQmy/9pNZqMlVwKEvYuL7MQhLCYjP6k
 YbGECDEDXN8LQ0c1sspLwZLtr/oysw8bV0R9RrNnuFVecz+z5tntYy+4SSansODZG2V/d/dzZ5
 xsHV7KvhBppKuFHxckqn3Ote78az/vW1cP4QWNdBmC9Acy8ZLiOTDV9GmEuvmKT+rqBpDW6tdg
 wyA=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="116427753"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:17:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:17:22 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:17:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 16/24] dt-bindings: atmel-sysreg: add bindings for sama7g5
Date:   Fri, 9 Apr 2021 14:13:37 +0300
Message-ID: <20210409111345.294472-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409111345.294472-1-claudiu.beznea@microchip.com>
References: <20210409111345.294472-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RAM controller and RAM PHY controller DT bindings.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/arm/atmel-sysregs.txt     | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 807264a78edc..7cd55a760d41 100644
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
@@ -55,6 +56,18 @@ Examples:
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
+		status = "okay";
+};
+
 SHDWC Shutdown Controller
 
 required properties:
-- 
2.25.1

