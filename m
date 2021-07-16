Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C93CBA17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhGPPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:50:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:11484 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbhGPPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626450465; x=1657986465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/vZlSOVpdEvhJO6FbDpdJpsOuoJTaVkINSibSKKzyIc=;
  b=PXqvS+xZG/f8DJRIHAYNbNu1b/InKrjz24XcVjbehIQN2XHFe+78sqtb
   NlJLmH+uL3W6Sqm1rRqxX6GJ2EfrNH5cuKPEtKP+4LhFz0/Crb1IgKHrI
   XCmQO0WJYhRd7zGRzsMdaPi1MV8Vu9igIvN93GBHa2geEJJliIalBvzJ4
   tFp6qdfoi3SpI+6V7sUR61O/2JzT78+3kBKmwilziojjL5wFLnSioEyly
   vI8gSIplI3FtMTcZSoeIZ+6o3Jpq3sOmxDICtJNKbBoY/fnBJVXAeHtRS
   p4dxfWUeBwxAWolt++TujwzmxuSKFmXjPHeUPg5LIhoDErMICv/8ssmQY
   g==;
IronPort-SDR: wJorc8U5lOuW1uXp9EBbTlht1FjNrcuBSessMlFUYRTkpyTk6xK7uowROWxLIWn2ohtlGGqBCF
 XATA7wmVfp2mdcBfWE+HS/kCVjhZPnsdkaOjn5zLVDOw/lP2wrZePOL3rTglb7s5tQu8JceJk8
 vDY7z29DSjWU5owP4ghhrXwV92NewblfJj/wTmuPL3eokTH8Rw82q49r4BnsaeUjyj++Xk/LaU
 67AhudmOVAeK3HDhb21DCV2t0PXtrdT97PIZBmt3f1Nz38fG+W3Wq4Z63qKW2c2Bnv9Lxk2TN3
 EV26KTgji2Dmo/58DfGJeKst
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="136196386"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 08:47:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 08:47:43 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 16 Jul 2021 08:47:40 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <emil.velikov@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2] ARM: dts: at91: sama5d4_xplained: Remove spi0 node
Date:   Fri, 16 Jul 2021 18:47:39 +0300
Message-ID: <20210716154739.835738-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama5d4_xplained has an optional on-board serial DataFlash (AT25DF321A),
which does not come populated on board by default. Since the spi0 node
does not have any child populated by default, thus no user on
sama5d4_xplained, remove it. This avoids the following error in SPI NOR,
which reads the values of the pulled downed lines, unrecognizing the flash:

spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 0b3ad1b580b8..046796c5b9b0 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -38,16 +38,6 @@ uart0: serial@f8004000 {
 				status = "okay";
 			};
 
-			spi0: spi@f8010000 {
-				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
-				status = "okay";
-				m25p80@0 {
-					compatible = "atmel,at25df321a";
-					spi-max-frequency = <50000000>;
-					reg = <0>;
-				};
-			};
-
 			i2c0: i2c@f8014000 {
 				i2c-digital-filter;
 				status = "okay";
-- 
2.25.1

