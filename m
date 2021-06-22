Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6653B0129
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFVKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:20:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15265 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFVKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624357082; x=1655893082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HDo7+dEIV2AQMejAUxlNUXe4B9kHDn8VG83f//59U2o=;
  b=K0nHKMI2pNm8Hf9Te+5MXk216PCZ36o/5cZgCFdgrCrU/Zz8ta0Wsy4j
   xkcShQ3LlAepNQiECi6+hTaIo22T4MU0Z7NU5Uv+Sfl6eo01/e3NbwFKz
   wCmsQ5G5MYMbMM1xkHgZ2lUkA6M8xeRiBIxAXzbg7h9P757L7UPHVksVj
   Mob0L/4uw/Esl/DQBy0nuM0mErffIDC1j+ie2cPip1PVytujwaUIZFQ24
   XHRNkR2ZSBgP6k1FO/E65hUFD7YDwLrdam/t3fl0M7nD2WD9L6jI231i6
   zj3awh73PxQYApznGAznzrEiKp47cPqJ2JwSVw5zCF3Q90QCAmRbN0y7A
   A==;
IronPort-SDR: j2YIpKSr/HFUTI9ZJMmIer6BbL2zKdDGrigwUQPipr1vv6hEOYlLcvLZpYHTpki5Wv68AAwv8X
 zD8VasrBfCFIG7EYgu8sGLiag0eUUKFzA8CQjF5psHjed/TXpUMQilWktw1qPy1uGvyn9JxrNW
 e5Ze7szutWBVSDy5F6ezQ4c1T6S8xt7wx7PgtpJ7hJTY2JCxbBXJ8Ps+HprZqRC1JCs62fAr6L
 sH1+QZdd6m2MZ8vZoDz6DqcCj7pVnfQbkbeP9RiijymaghY7nUbxCmcvaRfGUqaMN1k2lWLZSC
 2Q4=
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="125617644"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2021 03:17:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 03:17:58 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 22 Jun 2021 03:17:52 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d27_som1_ek: enable ADC node
Date:   Tue, 22 Jun 2021 13:17:42 +0300
Message-ID: <20210622101742.14535-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the ADC for AN pins on Mikrobus1 and Mikrobus2 on the board.
These correspond to channels AD6 and AD7 in the controller.

 # cat /sys/bus/iio/devices/iio\:device0/in_voltage6_raw
 240
 # cat /sys/bus/iio/devices/iio\:device0/in_voltage7_raw
 16380

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index a9e6fee55a2a..261a7dbcfdee 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -224,8 +224,10 @@ i2c1: i2c@fc028000 {
 			adc: adc@fc030000 {
 				vddana-supply = <&vddana>;
 				vref-supply = <&advref>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mikrobus1_an &pinctrl_mikrobus2_an>;
 
-				status = "disabled";
+				status = "okay";
 			};
 
 			pinctrl@fc038000 {
-- 
2.25.1

