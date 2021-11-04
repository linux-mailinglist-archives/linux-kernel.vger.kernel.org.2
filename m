Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4B544571D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhKDQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhKDQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98724C061224;
        Thu,  4 Nov 2021 09:18:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i79so7220376ioa.13;
        Thu, 04 Nov 2021 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFTXi1b35fScPQaVH64rQYOP74MFEiiFUB9mLytG3wM=;
        b=Ha8JhqhawDsbOpvzin4j+AP/vpnM6Hi0l3LcAp7W/NE3QBgrZOTsdxDhkT3J8tz2KX
         PjzEgIeqeroB7YVzbZngyFepjOhf1UxSBcheVDm4H8wFpundb+6b+lps+2USwil7Sqxj
         zcfP0EOmy4V4IkWJG+NCFZ7Q47tUeFeMxbrYTCp3ELFBoCnfSkSV0znLw+84+H2wvQye
         DLyDtv5Wti2TZnT1qzEF4hxkTn59N4+jiKXiEZgl6V+jbV7WB5RQ4P4iQFATEwO3k8TG
         SbfbPIRkB+BX0cI3lJPftmVe8A2glHsmrPetfxDxjaOkdGkELarq57ZeunLzmQZlSGh8
         MFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFTXi1b35fScPQaVH64rQYOP74MFEiiFUB9mLytG3wM=;
        b=RBDGRz9qoIhoLwq79HNzKtTIVSIW3Z877an/K9N9uJKIJpdy8d8db5o0vQ5/lIQq+6
         kS0qBGlGjNKPLaak5tPSoRghQBKExG+5nfO978N+3xL9Hye6KzV9dz+VLORYOTmoe5ro
         VxqvJtqh/y7Lmd2McP6cfzsj2HUiAFDuIlZqeKu7Z9Oo2iv1qmR7QwDML8N2jLZbWjuM
         0Izvkgo5pxpjOczXmz2kqw9s82vjrSP2wgumfLM6lAZU3xEmVPKDjo9GRNoyPDkTYWfR
         6ZMXVpPxUQvlcSXgvkqehaPY+pbY99fE1oV16bZajBMibZ6yIVhjkW02WmZQ5rBSwgrb
         NuZg==
X-Gm-Message-State: AOAM530qGLOue6O3K+5mNIN+T3frLj34E0Xct4eAZ5+Hvb92YIrdQwNd
        /yuMp9umdLJYupKUKYSyTBI=
X-Google-Smtp-Source: ABdhPJyc2LJ/npIS2vJ9C1mMZKYx8IfEJpb+VCTcvPl45VugOaPt8MJH6qwbf+e5QlF2phnYUmga2A==
X-Received: by 2002:a6b:7705:: with SMTP id n5mr20432153iom.173.1636042718741;
        Thu, 04 Nov 2021 09:18:38 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:38 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/9] arm64: dts: imx8mn: add GPC node
Date:   Thu,  4 Nov 2021 11:18:01 -0500
Message-Id: <20211104161804.587250-7-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the GPC, including all the PGC power domains,
some of them are not fully functional yet, as they require interaction
with the blk-ctrls to properly power up/down the peripherals.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index da6c942fb7f9..f5bafd9db673 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include <dt-bindings/clock/imx8mn-clock.h>
+#include <dt-bindings/power/imx8mn-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -612,6 +614,53 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mn-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_hsiomix: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MN_CLK_USB_BUS>;
+					};
+
+					pgc_otg1: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_gpumix: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
+						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_SHADER>,
+							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_AHB>;
+						resets = <&src IMX8MQ_RESET_GPU_RESET>;
+					};
+
+					pgc_dispmix: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_DISPMIX>;
+						clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+							 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
+					};
+
+					pgc_mipi: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_MIPI>;
+						power-domains = <&pgc_dispmix>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.32.0

