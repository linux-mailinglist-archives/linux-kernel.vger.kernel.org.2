Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295993D76FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhG0Nmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:42:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12838 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhG0Nmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627393355; x=1658929355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cCss9beJLyEtVeQKdKDLue42w59nZdJ3lRfZf8HdINI=;
  b=hqHkKjP64c3BSuvHDsAc9gOOroeGFToD02EdE5dd3voNVJ7U7ebLyq1P
   0AjsyxT5/c1j7+h79TMvBHlU2H4i2Fsmwhswr5+/BejPTfT+Gr8KDFMou
   2G/UvRGWH5ne6xAekVN7q7mj/elfXEYBP9HKYVFd7+SBxQACrmR458JSN
   O4nRIeNTaznfrgUxC3dM/g5bNK/VSdmwsTb8H2q3D2kgIxrA+KRyPOtOe
   ITMUHJghqeSX65xGEF0ttjMoIBaYZJshfimqnNwTCDlkuFu1wMC06gybS
   cgmgsiH88S1epr+YqUatBdKg3n6wRH20J4CvRFSj/2RSJlXhKcSbaWgsv
   A==;
IronPort-SDR: pf7le8cEtxSJRm95epm1GUFFAcZ5INH/UVHm+xAeXarcsYJqlT4IYoYNZZ/PC4qkJc+AkG1wbq
 gcT2gK1+WDCOeMdHYgYIc/a0lA45Oto8RWnBLjd1lgWpaTDJMIJUEmQRr9QhowQKUQikbwAJyI
 YCCBNhxVWKjDdJe8g6145ZR7QnbRZdhV7z2/eX+FfpF79m3buvcCSTpFmFbtf1lvpOQ2dwJEed
 P0HmKAkz+K9jsl03PtIYg2ASv6W1jHCUSDWSgbYYpEjfqkXbd+nEYQ7pNoZdvrH1dEC52rRXYH
 MgGooFn6LYg6ywm2XvUE6lUm
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="63745506"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 06:41:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 06:41:25 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Jul 2021 06:41:22 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2] ARM: dts: at91: sama5d2_icp: enable digital filter for I2C nodes
Date:   Tue, 27 Jul 2021 16:41:15 +0300
Message-ID: <20210727134115.1353494-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA5D2's I2C controller supports digital filter, so let's enable it.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - removed Acked-by tag

 arch/arm/boot/dts/at91-sama5d2_icp.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index bd64721fa23c..1c235fc5f788 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -184,6 +184,8 @@ i2c6: i2c@600 {
 		dmas = <0>, <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_flx4_default>;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
 		status = "okay";
 
 		mcp16502@5b {
@@ -307,6 +309,8 @@ regulator-state-mem {
 &i2c0 { /* mikrobus i2c */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_mikrobus_i2c>;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
 	status = "okay";
 };
 
@@ -314,6 +318,8 @@ &i2c1 {
 	dmas = <0>, <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
 	status = "okay";
 
 	eeprom@50 {
-- 
2.30.2

