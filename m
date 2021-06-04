Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FFE39B9CC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFDN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:26:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17128 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhFDN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622813085; x=1654349085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UrHKelKyqqHlztFRcAxQQRjdVr20Dnac6fTjGDJIXBE=;
  b=ieRo2K8alyaxbocnhSfSz+TU8BnhQUBK0HyaR/o67UfQaERxYy2K+XsM
   KvY1QKY9zJ8Pz58ZrzYheHtr/l39XSGvyIMSyMMl9oc2IcWEwViLPsXC1
   AIE7rJsgzraOpta5Drj0f9UdZ0U+W+xEGEMK+I4PmeCDxFWwrYlKT1oHB
   kjIbhAzoLAY2tD53PixEORTqViQ4biqvtT4GgggJ6awDnWw0XO1kEWPnY
   cE6qZHUMQEawKSpgvyFprnr+RQl6bBoPbQs2Lt+OLPofTzoPFvRR1w/Ot
   TS/1zV/e7jKoPMDxqwhR2cP41xcf2jLUXrwcePNcVBdwLwxeEgyow9Lfk
   g==;
IronPort-SDR: kmCdPm16MTdtGr+ka3FEVC0yZTQmIVhJi1sulMGAitcHkYm4/7pHdYZ+a8Zn7TEQo8iq0SiSc0
 VtySDQ2qiUKkhQkekEm9efidEpiOC/5AOYQaW4FDYeZmMVLMFWNF8IUepw401GbOUNLzh/EBIq
 xowUgEydJl0nlTYsY4+VBzzI3Yee1zt4tmnyapVYGlw8xI2vRzca0Qrm7FJhwU3Uvn5eDmK9wd
 XmvkxWevu3jtY0lqGxX7kPE6dihS3CvmjAkI4uax+6/FPsTZ/bi1Jp/j1LRjgXB1EVWaM+72ZR
 dT4=
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="57879846"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jun 2021 06:24:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 06:24:43 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 4 Jun 2021 06:24:42 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] dt-bindings: i2c: at91: fix example for scl-gpios
Date:   Fri, 4 Jun 2021 15:24:38 +0200
Message-ID: <20210604132438.18784-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

The SCL gpio pin used by I2C bus for recovery needs to be configured as
open drain, so fix the binding example accordingly.
In relation with fix c5a283802573 ("ARM: dts: at91: Configure I2C SCL
gpio as open drain").

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Fixes: 19e5cef058a0 ("dt-bindings: i2c: at91: document optional bus recovery properties")
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index 96c914e048f5..2015f50aed0f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -73,7 +73,7 @@ i2c0: i2c@f8034600 {
 	pinctrl-0 = <&pinctrl_i2c0>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
 	sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
-	scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	wm8731: wm8731@1a {
 		compatible = "wm8731";
-- 
2.31.1

