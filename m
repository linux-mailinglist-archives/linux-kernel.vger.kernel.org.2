Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA343B31A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhJZNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:23:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2950 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhJZNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635254466; x=1666790466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+B0okMOOzcOhjz3TGoccFG745L17Bg3X75cyIf9gkXQ=;
  b=Qi+9efMswg6fNdbY9YNtM2qgO9SKUItJKN7+PZ3dDGqUxRIfxH8H75wH
   BZ+NEowylByKz4qMEORZLJwKn8iAASF+7yGJ0i0Ut3zcKowe7xUgAT311
   mLcxcIl/ESMB7m2jM7ZuyMmPRXvdedAgCJm6aRIebHjZAiiQWBr+b8uR/
   MLdwrFdrM7fXRdsUZGDG+CfdGougqqKxkPX+xPHOh7wafa7GSkb4CdVDz
   yqNq9Y9wrSgg2NMIpDHqkCZPSraZkneDL62exVoB2G6kPGfEHLgdFRrxd
   IEI3yYgDWimg7vm9QnbHgUUG19QC43z51JdIad9WgUZr4cIRJPZfWiJ2k
   A==;
IronPort-SDR: zSe+/AVIdjSh8dFU380kdj9tlrs3EYo/2LL4xdSTNv9V5eMtGjPaLqcEUwgHgfrXRMBDJZza1y
 UKFfVDoCpP/uOc1fOFhRZCaDSwzNw/jOxYO/WIS8H33ZefAhKZnNmxmGDGWsy/ErnxXcFSwxHX
 YsM/+A41i4rc0SURq3Ska7OaNBHLa4m2Hq2n37p9GlTmwUxspg+cmFD7v2Sc+NAGpb8cYnQgWe
 Vi0P6YBL2iHP92/dVkrQUB+c+qVVjzw55ZUxCxd/4uN7CGKcjdBZ3MtntQ5cJYuhGixh3mIE7Y
 uSmFtWuH5d7IrHgCiuIpg4vf
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="134392532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2021 06:21:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 26 Oct 2021 06:21:05 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 26 Oct 2021 06:21:00 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <nicolas.ferre@microchip.com>, <devicetree@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: remove PA11__SDMMC0_VDDSEL from pinctrl
Date:   Tue, 26 Oct 2021 16:20:34 +0300
Message-ID: <20211026132034.678655-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihai Sain <mihai.sain@microchip.com>

I/O voltage for eMMC is always 3.3V because PA11__SDMMC0_VDDSEL is
tied with 10K resistor to GND. U13 switch S1 is always selected as
voltage rail of 3.3V for VCCQ power pin from MPU controller and eMMC flash.
Removing PA11 from pinctrl because it remains unused.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index b1e854f658de..9bf2ec0ba3e2 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -66,7 +66,7 @@ sdmmc0: sdio-host@a0000000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sdmmc0_default>;
 			non-removable;
-			mmc-ddr-1_8v;
+			mmc-ddr-3_3v;
 			status = "okay";
 		};
 
@@ -619,10 +619,9 @@ cmd_data {
 						bias-disable;
 					};
 
-					ck_cd_rstn_vddsel {
+					ck_cd_rstn {
 						pinmux = <PIN_PA0__SDMMC0_CK>,
 							 <PIN_PA10__SDMMC0_RSTN>,
-							 <PIN_PA11__SDMMC0_VDDSEL>,
 							 <PIN_PA13__SDMMC0_CD>;
 						bias-disable;
 					};
-- 
2.25.1

