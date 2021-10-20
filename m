Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5B434835
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhJTJt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:49:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7307 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJTJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634723231; x=1666259231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZVVPO+VvFAE0LSAnkbPvz2beVEoKWYg4xDLbbKFbzo=;
  b=xLaJygQf8IF7RGuTn43M2bomSTfOp1nlpdK4sS0zz2EnjHy/lM3q9cNW
   nmHFVa4S3A3V5gRvMUfjHxg/1wnBZYvCtd5Jfs+8XiuCiK1W5q/VYCARz
   wvtpn2vacShzMacEPo+7HN1GL5KX676HXd2UQN5gVCrMIDSMfOWFZGums
   waUV0nNwtLE1ir/74UXbXqM8UwLJtQ3p0is0Px9dO23jo0xm9F0bHrzVW
   9So9iF9JarDm+GgTj1pUvbFE6YoYKtWWwTGGIr8pJUAeQACe4DN0IpvSD
   dk51Ik9GoRWYaL7zeqbvvvDUTlogHK3bIAyL+d58t/4YgQ75H+MZ5Rd2L
   w==;
IronPort-SDR: RMI9zGS5Fh+JwiX2pKzf4xuzlWlpHObznckSv71ZONHEZ21bm4wtJWy/zxpgKMqSODovxSUbjv
 n+4YxBKaeqFq0d9eqc2gaxOoaJtXbOpU0MDKVtRwUyhzvwBTDADFAoxI8bSuyfzHFIV8/XI7kd
 fQcND8WTi71jIk9R/wFbh0x3pYIfiKvuz91tMUQK4lRPZXYgksufs9VIU475yX9noN+LhnWF4i
 OC9yvRtcUz3mPOD24RvCUq/gBMWD05DtfL0T3MRRLjSPCd0h09JtIxnJ1eXMYvGmETJ5hg57yz
 ktJKIvwLTWKrRitLnOVfdxzi
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="140422127"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2021 02:47:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Oct 2021 02:47:10 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Oct 2021 02:47:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: sama7g5: add rtc node
Date:   Wed, 20 Oct 2021 12:46:54 +0300
Message-ID: <20211020094656.3343242-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
References: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add RTC node.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea: add sama7g5 compatible as the IP has 2 extra registers
 compared with sam9x60]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 6a9d74a9e1ac..e16a337fd100 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -152,6 +152,13 @@ gpbr: gpbr@e001d060 {
 			reg = <0xe001d060 0x48>;
 		};
 
+		rtc: rtc@e001d0a8 {
+			compatible = "microchip,sama7g5-rtc", "microchip,sam9x60-rtc";
+			reg = <0xe001d0a8 0x30>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk32k 1>;
+		};
+
 		ps_wdt: watchdog@e001d180 {
 			compatible = "microchip,sama7g5-wdt";
 			reg = <0xe001d180 0x24>;
-- 
2.25.1

