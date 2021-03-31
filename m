Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC6C34FEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhCaLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:00:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57797 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhCaK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188396; x=1648724396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxCT6tDlt+U3ggKv1NPVzCYZ9HIlt2jE8A4pFsshM/Y=;
  b=ecxRzpG83jstQ/GAfb1LuUUfMjn/h1W2FvQL4/C17YJ6qEYfbQIl19k1
   F/+JPnzvHvE3vHk+bUy6DKcc0R3AV66Pl5gJR4BNKNfM3VA/GiNB+JwjS
   HwMYzXkpSCAJSNRS0ZZWuwnPZbrdfydVviewiL6Rd4Q0CHuKrCL70pf8X
   va7RO4CW7GeNQSOb8Y5a0DKJ9tpYp2DbKCH/+3dy3e5UzW9ykIekR9nI0
   dDyPAw+Wm1CIAujyJCVswCmmL68HJL6Gly+Z8NL4rgZ31h6YeXOkNy9Ee
   UgjY9/M8kg1+hzB5SK+hJK1bgZwUaRkzPhRjP3ZyuceLAekW/bHhBeDLn
   g==;
IronPort-SDR: u12DYrvfYN6OhiPWjlbi4wysTcVCAd3/BQ+aFCzQ/JAybVx7hbne78/3wvDaFat0hc0a4Z4719
 uMSEU0EhUP2dkSbYdGySha2/LviiKMYuPjxAj+ZPhpVnp101+4c9aBxH2wFZHxpbky7ysRha7o
 zoeOj47F1tiZ182NMSpnnQBuPLfEUsFpC0+TUVhykj+j7kT0vjsrZ6cQ8Tx+YXgSIKbaxPAN7g
 s9IHp4vWYIkezzPg3b6EaD5yZVYxbDo4Nv0YvOI4nJJ7RR8JjwGui81FDY7jsT501Ru9dMcnF2
 JMw=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="114825679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:53 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 16/24] dt-bindings: atmel-sysreg: add bindings for sama7g5
Date:   Wed, 31 Mar 2021 13:59:00 +0300
Message-ID: <20210331105908.23027-17-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210331105908.23027-1-claudiu.beznea@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
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

