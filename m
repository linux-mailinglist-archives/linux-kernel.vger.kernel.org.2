Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9E3D73F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhG0LCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:02:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:45934 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbhG0LCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627383737; x=1658919737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y8+DswQOgqJ+Z109s5uZ3P5QjJf+XnVxLaqAzGjFO8A=;
  b=RYq9ut6Y71X7h2+AIJfQaiePeW+eEgdQFILQ7/u7RL/ojS7wJ4ypSay/
   j4ketqxuJnPq8xmnX2wsvSe8wMgDpa3WOtVOIU06RBhW4mz854Zm5SFwO
   4WxpeSPKM+h1SwNqsHixQfNhSUnvMmBZUbPHntQMISfZMUSxlsYFhgXHs
   W8cvlHT2LEYy6xoNvrzo9dAdcxZcBYktHVLO5fygN6dzowEslOculf9kn
   IendabCTbuOVO7tH+x5Z3itiayH2sADN+ekvILUPOmtmDmvBXB8iqrHbM
   RkbzOv67kawDpPsRtQkjagHZn0ukE3cDtSHNWiXAHqbHWphha68q4X6LQ
   w==;
IronPort-SDR: TKnfswii3JJzbTcQowpZ3Bac84fFpMTjol9FvslS1IjTvjUAsSyJhPz6DaH68FRoWBfChsT3ju
 e00vr2/9xK2FKd8FIYdN5/GFxR00tPpnIeM0MHAR9tcWvAJLL2b9oNpSHtwqROLdKELvm1hpwg
 vFKvmnsAljJDwWyiRRxL6KQ44986W32HIUEq4kTt9P7QyVc6pLPyVPgyJLlPOkajOY10nFIGv4
 XQ3K9bZ6dyUxV8ip3OkHLTrjl6oh/o/9UFsrR8Y+K4kEp/Ugi+0iS/fc+8Tu9IczME+girhoFj
 GWy98HT/mIiF2zIJoeCTnlO4
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="123596040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 04:02:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 04:02:17 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Jul 2021 04:02:13 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2_icp: enable digital filter for I2C nodes
Date:   Tue, 27 Jul 2021 14:02:06 +0300
Message-ID: <20210727110206.1336773-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAMA5D2's I2C controller supports digital filter, so let's enable it.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
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

