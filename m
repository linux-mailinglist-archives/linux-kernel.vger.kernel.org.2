Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F03D71C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhG0JOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:14:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50991 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbhG0JON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627377254; x=1658913254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pmL2u0pxNrKXvS4hIf8AmQFxND+OwrHLSSu25nKLwqg=;
  b=OONNfSjLJrDdQRE1Y5EBWvqoX9RD58YHBsd5QsMq1B8wLDqOFe1FoeSo
   IHeMnYjpVceVNc/kjVUO3y6zw3d6F4kM4M1WqJoc4UPiyXnmq6IpjVXWj
   l9BVUFgs8QAQruR2seu2ohxu54aBqfjsw6YKknR2iToesaIDCCSBBH+ub
   VGEDX2wkVBmdmPXL646iWWvlVoSR2PG2+UpMVhnJ2xflqormOsDAoAlVE
   FTC6BBkRRd119q4dJEhJGoSkTTCKT1DhIe4y19jAeEdSATwD0D5D5Rsl6
   RyXkO7KlHI+87Vb8ZT6+Jb/4EKVnIeBBLvC5PnqCu282YJvl6ZJ/vpGZ8
   g==;
IronPort-SDR: PVaNFV0JX0JMoala1VarmJMZl3qTf6twL1DRW++N41Qy7zyJU0Cal6plT/L1srcNvr3uAXzJGf
 ff/DFjyKg+gzfhyc39PXELDwJGxcCKgiXIck0J3tg6HUzY6MieBWD6etdBw7VNVNGd5uVzy6A1
 bu8iMkCqc/doWcau9kKAvEnAUBKjyMSSDumf90JmXHPsO3c2dbZ7uqxvN056cDr++/kBzJPici
 37F73iOGK2FKYR3+FmeB6Np/OUm3ga8K5YAtotjwyLCGtyBLbev0It0FhDuV0C8TSKmKx65wjM
 Hk4d8r0gjpayaPV5jA7t+HVP
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="63715936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 02:14:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 02:14:12 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 27 Jul 2021 02:14:11 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d4_xplained: change the key code of the gpio key
Date:   Tue, 27 Jul 2021 11:13:51 +0200
Message-ID: <20210727091351.44475-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

Having a button code and not a key code causes issues with libinput.
udev won't set ID_INPUT_KEY. If it is forced, then it causes a bug
within libinput.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 541779af049f..d241c24f0d83 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 #include "sama5d4.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Atmel SAMA5D4 Xplained";
@@ -250,7 +251,7 @@ gpio_keys {
 		pb_user1 {
 			label = "pb_user1";
 			gpios = <&pioE 8 GPIO_ACTIVE_HIGH>;
-			linux,code = <0x100>;
+			linux,code = <KEY_PROG1>;
 			wakeup-source;
 		};
 	};
-- 
2.32.0

