Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB9403730
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351423AbhIHJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:44:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9696 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351405AbhIHJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631094219; x=1662630219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ewAUrQJURfYDPGd+sHCrQMi5PMP+lIP4vadIYJIr6lE=;
  b=0xxV13BBbw8KRL6MpiGVaoynEjNMkFiztmdzVWRhBR+Uqf6nNR0bZJUw
   he6cUfNDe0wWL32U54144DZIzkZiXi+QEWLgehKHTQDPmTTCqMXA7E4H3
   SPb/xgGhAM9u+0cvhOfQQ0gmSuw+EybG2pwi/bTsZ7C/+eJBOM14/w0ou
   ahsJc04V/EyQ9k13c9Sangx3xPk7yy2u5AbZ0F3WLTxlq2cqYI8l06nMV
   q3Vt85QIxX+y2MbDZOQaJKUsfp7tl2+FVM5Ph2940sA4lOHeHOBEs6WVc
   +R2FlhOAGvUB6eke4cgUS201rYOpkZapHzsR64xwpsHIut39Is+cfdqYN
   Q==;
IronPort-SDR: 9pFAfS5XV+02xqzW5OodiOjHBUPh+cr+qejp7LxX+Jb9RMQVIE78yKNFKGhX8mhdJlJQRHCQyQ
 3j+mxqzeAR1es8a3QRiqGCF5tl1rQY+tTyVsUIJe2bNWIMo8MxGOSuI7YEOjBtalBjLkOTUKkl
 wR68peioXHBQjV/AThJ8wGLolaC/YTIOv9YSnL5EKJvS92gdvA2hETWDmBCo3PXTJQZ9KSpVy/
 qCPtY9v22z64uNJodl+NeAWj11hdfWSDd00vmZxr7Z29w6Kp0yuQdqammYuv/2R3o+hLyFrtTc
 zZL2X4uBck5lAmDQhei+D0QK
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="128601268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2021 02:43:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 02:43:38 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 02:43:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: add chipid
Date:   Wed, 8 Sep 2021 12:43:29 +0300
Message-ID: <20210908094329.182477-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add chipid node for sama7g5.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Nicolas,

This applies clean on top of series with title "ARM: at91: add new nodes
to DT and fix for PM".

 arch/arm/boot/dts/sama7g5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index e50806cf7660..6c58c151c6d9 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -159,6 +159,11 @@ ps_wdt: watchdog@e001d180 {
 			clocks = <&clk32k 0>;
 		};
 
+		chipid@e0020000 {
+			compatible = "microchip,sama7g5-chipid";
+			reg = <0xe0020000 0x8>;
+		};
+
 		sdmmc0: mmc@e1204000 {
 			compatible = "microchip,sama7g5-sdhci", "microchip,sam9x60-sdhci";
 			reg = <0xe1204000 0x4000>;
-- 
2.25.1

