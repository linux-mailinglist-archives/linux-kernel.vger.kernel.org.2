Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597C13ECEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhHPGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43264 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhHPGq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096388; x=1660632388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7ddTF2RdMj7+wLTZPUG9yvpW6hfBDmQ4fUfE2MtAEg=;
  b=VSRY8tyeGY7oPTawnkM2LsfNv2+WFYKE+jwz/uj4cIRTiOaX9t+6N1kz
   VMjPnlRjUjD2gjT5UGPg44Uq9aUv/fy6+rjP/Acx6n3cuLYhDeKPJZsDU
   HJAPizT7UuHVUdL2Cc7lShdIBt02ubjQJNmzxOmnZ/g4XCY1LxkQDdH/3
   oc8deUjhkWvKAFsT8BrDFYnNU7rZQrioy5FjwBRvDSOsyI77XE3ys0eHD
   P7ME//eQJwwMeUotjMpHu+TavIlzEbYLBt82GnSNKaC6n1LkmzFVexXcF
   /q1X4d9N0ZFaPUsE8b3idrPGdUGlIroOyXXSUQxB3RLRHgPE5m8Q7OuLS
   w==;
IronPort-SDR: mCB471Qx/s7ExUNpJx2m1aQOMgeEoPmEEO0bfDzjbkC/nENIrU4djEEBjdmK2KWSX0V2MkiEVF
 emA7fQXf82aVXOIxqqHnmdNsNdn1PEJeR/mLbShRSbLfj7vehqj1LPfxMc50PvDmyvL31N9orW
 tyukO8weYwkStynrik8pX81XqIf+bhkUs0T/4HVNyR5zV1pzla1+tjgKL0ZYoh805hMdlDuRWk
 t8lqKDytG/X97/pFMVkuH6+uezUMz7VyPBIk+hVuWZG5thUcQhvQhIkf0CMm7/Iq4ytp5NpAH2
 x4POjgCnrxIOV7sRX0SskqOS
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="132362605"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/7] ARM: dts: at91: at91sam9260: add pinctrl label
Date:   Mon, 16 Aug 2021 09:44:10 +0300
Message-ID: <20210816064416.1630674-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add label for pinctrl node.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 019f1c3d4d30..7368347c9357 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -166,7 +166,7 @@ tcb1: timer@fffdc000 {
 				clock-names = "t0_clk", "t1_clk", "t2_clk", "slow_clk";
 			};
 
-			pinctrl@fffff400 {
+			pinctrl: pinctrl@fffff400 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
-- 
2.25.1

