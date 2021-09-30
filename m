Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DC41DE30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347353AbhI3P6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbhI3P6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:58:39 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7459C06176C;
        Thu, 30 Sep 2021 08:56:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1561BFBD8;
        Thu, 30 Sep 2021 17:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1633017414; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=IU87R0XSQOesOBA4xIK7GNvQVFsVTZb7Gkj0MIhqEes=;
        b=1Aioh4dTlVijAtyXdQNT6Sr1VrjuoTchdcdV8AUsilm0KCFsGOwVhQb11qNjTnGKprYmes
        74mOqHWN9TvgMcnZ1Dcz133RCXaw5B9Zy1lmrZYyXePOv1lNp3z+dPQN7OOaH8wxwOvhlY
        C5RZHNvpr+yUwUrL/AsLdOnzvdJ42TppXBmQz/UVfXqe65i2VPKnUPkaZdzCWni7v8CMsz
        kITSaLy5E6ZYTNQNyoJfIwm4lLriGWZnea5+XPdkK25/B/gnOyW76iHaUoR541hQtvzymK
        MH9/UCI8FNppMp09qp+xfxazn/XZ7gCraNa6Mxl7Q88L6j6qDekW9XpFcoaaow==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 2/8] arm64: dts: imx8mm-kontron: Make sure SOC and DRAM supply voltages are correct
Date:   Thu, 30 Sep 2021 17:56:25 +0200
Message-Id: <20210930155633.2745201-3-frieder@fris.de>
In-Reply-To: <20210930155633.2745201-1-frieder@fris.de>
References: <20210930155633.2745201-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

VDD_SOC should be 800 mV in suspend and 850 mV in run mode. VDD_DRAM
should be 950 mV for DDR clock frequencies of 1.5 GHz.

This information is taken from the datasheet and the uboot-imx code.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 03b3516abd64..b12fb7ce6686 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -92,10 +92,12 @@ regulators {
 			reg_vdd_soc: BUCK1 {
 				regulator-name = "buck1";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <900000>;
+				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <850000>;
+				nxp,dvs-standby-voltage = <800000>;
 			};
 
 			reg_vdd_arm: BUCK2 {
@@ -111,7 +113,7 @@ reg_vdd_arm: BUCK2 {
 			reg_vdd_dram: BUCK3 {
 				regulator-name = "buck3";
 				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <900000>;
+				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.33.0

