Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15D3F4828
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhHWKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:04:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52246 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhHWKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629713045; x=1661249045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o9754bOu5EEwH9LqToOgBeWqVOuHjveY+/qscjKYto8=;
  b=Nhqw217QWSsqT6nr/AGzbW8vSvUGl5xmiAUubHLVDkvtaqw7IDGuvr//
   v2vmY2/OiN8mBes8wC3ndQYCy0P3X3J0pcSYtbCpGoL/VoTmGeMt8gWhs
   V+/G4p6Yq3MPL9LVvzh29n7BxpdD3xNdm56v4B3pQKy8artinE6oNIfMQ
   7hLwwVbFCszCoywN3pOUSLeM195sZWpUqnL0LKI2+grm9NZBavy7uxLGl
   D72JruApICtQocYkYZ5qa1GutEWRBOP66FXNZGQ9yRoqlXdhVgz4nyIfU
   Mhh0QdGal+MFaf3qAB0rydd309QcUUL0Dcz66XSBDjcCUrk/f11fTmPQ4
   w==;
IronPort-SDR: grdg3NIz2Q7+LkCWSTD2ljJluCM71KSPrkMUNLJ55pNJeTpL035SO1MDnAAgRCKYTVTx14nGqJ
 nO+KGccVIc7M/BzBjgetaVN2Io8kF1ObShCxOPBaBoFd+5YLxA5RschzbBfnRv3axO2LZHPdd3
 u02vXLEDbQFTmJszmTwWUO4Fk8KEBy2w5F91zo3oKf+oCXnxFJ/LwtoEeVGWXHi5anF6DBvZ0J
 +7UDpmn3nWuHUbFC+bNVnt80CTyMzxMIoqC0HRya8/T8BlvJVS1BkL2sO+b//XA5wGootLUllc
 Tl4K+7XcCgjEh89ZkydMpDtF
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="66761167"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 03:04:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 03:04:04 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 03:04:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] ARM: dts: at91: add ram bindings
Date:   Mon, 23 Aug 2021 13:03:54 +0300
Message-ID: <20210823100356.22206-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210823100356.22206-1-claudiu.beznea@microchip.com>
References: <20210823100356.22206-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for RAM (controller and PHY). These are necessary
for platform specific power management code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index cc6be6db7b80..ecabab4343b6 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -515,6 +515,18 @@ spi11: spi@400 {
 			};
 		};
 
+		uddrc: uddrc@e3800000 {
+			compatible = "microchip,sama7g5-uddrc";
+			reg = <0xe3800000 0x4000>;
+			status = "okay";
+		};
+
+		ddr3phy: ddr3phy@e3804000 {
+			compatible = "microchip,sama7g5-ddr3phy";
+			reg = <0xe3804000 0x1000>;
+			status = "okay";
+		};
+
 		gic: interrupt-controller@e8c11000 {
 			compatible = "arm,cortex-a7-gic";
 			#interrupt-cells = <3>;
-- 
2.25.1

