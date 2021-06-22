Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B63B0606
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhFVNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:44:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:9749 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhFVNom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624369347; x=1655905347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GP082JeyVvXq8STGW5/q34uKMupdVUFzrzpUOT2trvQ=;
  b=IG0N+YL7lDJppLwxraDNBy5VZFRBOKX2jHHvj6jNpPQaKBHNrnGc4KtM
   VZhM/DkAiFnfQXs+IK5ubcQFGX3a0tmtOxFBkBqx3uqneG3LIDSLlUYCM
   j+Bv6uzH9XpebfD/3Dg6Znrcfx/BCWFbDUiDSaitet2G1zw9LRZjTGAaF
   odgvea7U0Ey69aYbxzXxUOVUOcieoyOC9Cf5F7aOHoiUkBrltl2rt5WSO
   +PY5uRjtADKcmJAOxAeV1EvOycQy3zvefLAOSgw5X+67cAhchYVzPLwpO
   EgAoCWxl8KdNBvQF1BYKoj7k2zmoXCotqadZP5EeoSXKkcrfMSDmuBAkt
   w==;
IronPort-SDR: 632sqRxxv25qpLLxIq5urZuNTFvYgNlHT02NNxehoICgDgRO39aotsCLQy8XGOSfqbYj2dve0V
 8X1yBWtKVRNv5nzlczj/PufQTrbxUjreFvrXTzxC3UD55L/7jBlhm/+tgI1BtFENgoWiZz+ty8
 OF6Fs3z3v/iKWJczzhx/Bp57UZrYDvNhonzDcKDkqAN8fBLuBxuJiD5SO1rJwZU1p5nYyqjINH
 zPFSDs5QehD9VFjvblKxmbv+orzZZLcPyxRViTH5v8orUKfYhavjG78Me3K9hfPFtfX0C/MnUH
 HSc=
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="133007379"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2021 06:42:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 06:42:26 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 22 Jun 2021 06:42:24 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d4_xplained: Mark optional AT25DF321A as disabled
Date:   Tue, 22 Jun 2021 16:42:22 +0300
Message-ID: <20210622134222.107806-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama5d4_xplained has an optional on-board serial DataFlash (AT25DF321A),
which does not come populated on board by default. Mark it as disabled
to avoid the following probe error:
spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 0b3ad1b580b8..f397e2a68e5c 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -40,7 +40,7 @@ uart0: serial@f8004000 {
 
 			spi0: spi@f8010000 {
 				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
-				status = "okay";
+				status = "disabled";
 				m25p80@0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
-- 
2.25.1

