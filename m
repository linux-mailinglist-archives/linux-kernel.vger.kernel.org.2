Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC53F4B96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhHWNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:20:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3607 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbhHWNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629724772; x=1661260772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJLV5bSkClOuIxOjkK0Fw3trXSDYrOz7YzR6Azlmt6g=;
  b=wMC0VhHuLiWhYZY/QGk+BrTy7uuX4vfnHtpTVgqCHAZ7SR6hmoaEsoTZ
   UkxDFJJZ1oWzEIGEpjX/PVHKqFVd36XLfp4Y1ei1KWwMDKgqdj6OjgODP
   zY1q/+QGrPpL/2z7xXOpL/n06oXNhdPmXIUhTbcbV8XgeWiD96pj+ijr5
   YoQxVymbyPa0Mauiok3evL/ue0EXnVZfh4hMax7LPL8MAaHQFPnaTNf/n
   5zOMiyiIUs4oI0iRafiR6saw7oojTZk4eSv7Kl3imh88063HgkSuNNr+5
   k1qEtYwav8TjnJo0l9i+p2P60pQ8lbOqY1GvdWJrwKQ7LIzcUGYKLizD6
   Q==;
IronPort-SDR: W5EZ3Eea98pdR/oNbb+2viQrwOlxjeCAW4pFD5MbqgT/L1ZOatHpeV71QgYqxeJlUeBlNrICyu
 KB3gB2lJ2sNOKYAwsvsmcaSmajpwEMq1Hew3ku13yp+nwZP4W3p28WfPwPcU+y9IMjrG99S1ID
 gXx8cwZwthhvcZ2DU+/CCaS5JH+6hvJmokbkwXkjBatbbrUiPHOoVzvWYnitboVV1OSCWJQj9R
 pnIk218J2FvG7rhplqx2wYngFRzMGw2fhFBCVQi9Ttnx6iuFrCb37g43/46x4OHrG0bCwjAURY
 YGope9OQ++H16r6tMvNMfnJt
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="126756932"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 06:19:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 06:19:32 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 06:19:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/4] ARM: dts: at91: sama7g5: add securam node
Date:   Mon, 23 Aug 2021 16:19:14 +0300
Message-ID: <20210823131915.23857-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823131915.23857-1-claudiu.beznea@microchip.com>
References: <20210823131915.23857-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add securam node.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index ecabab4343b6..3a4315ac0eb0 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -75,6 +75,17 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		securam: securam@e0000000 {
+			compatible = "microchip,sama7g5-securam", "atmel,sama5d2-securam", "mmio-sram";
+			reg = <0xe0000000 0x4000>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 18>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000000 0x4000>;
+			no-memory-wc;
+			status = "okay";
+		};
+
 		secumod: secumod@e0004000 {
 			compatible = "microchip,sama7g5-secumod", "atmel,sama5d2-secumod", "syscon";
 			reg = <0xe0004000 0x4000>;
-- 
2.25.1

