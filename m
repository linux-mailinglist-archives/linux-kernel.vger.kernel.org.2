Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664674234C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhJFAHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhJFAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:16 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CCEC061753;
        Tue,  5 Oct 2021 17:05:25 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so1094352ilm.4;
        Tue, 05 Oct 2021 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/mItAfD+DmXPI/U2/7d84lAQbIbOWle9iFNPVWbFVBQ=;
        b=Lt64vf3/f+3uG11aIAcDt7gkgRUbULrkKKVPo1X3OTTCCV/XZ6aLz2pXPOJMGjmKTC
         +qAqdRmaq7t0FjJgYPLKnSO+UyoSfzhQYKUX89+7YUEMgqsB6kdcXsHw4vqpmw6D/mx5
         oAhUcylQx6TOzKiLIE8g8K3aZUb/VFl9jKYGhAyPtC3A54uWPXiumwP2Dksz256uU18p
         RmMDOb8FBIa8NN0Ry612axrlM36IKyARf3h9ncSEQQQBv/oVS4ilAyPMEelIDOS9hLfC
         PvESJ5o+oQiq+ZZNpYe1fePdpeYyTaE7j7cSt7/9f0YHkfRkF4B3NQupa/1txwx4ZQKf
         8o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/mItAfD+DmXPI/U2/7d84lAQbIbOWle9iFNPVWbFVBQ=;
        b=CVN+7Ec8xWUjJUiUxTX06gsfFD0Zef1CjUeXP2CR878mUDzGC8QTPQIG+oeNAG1NnH
         MC1fBiK1yv3fRLM1k6zlpzlKaBgtFb9KB6U0KHR8J8BgUBVTDBqKBUi3K3nDiPxt2355
         k2RdS88uQKQtsIc3fl/G/++K77prG1Ef5vptD/1jxfyjj0JepdHdKUtlgwZBNiXKkz9A
         xuNTR4G1sszaDT9p8uG9U9vV4sjT8+mY39/WnHcacLoYJ+E8CrOvj/6sUx7VdUzsE1BT
         CRyCx9CHa151dqeDSNE8RkEAF8q6Gr1IyhdgkfpIFC277CpLetwhXDYlc0MmMk9zcrc+
         IeSA==
X-Gm-Message-State: AOAM533lA0kXhd74tmgD7LKTND19PCK+BK4Aoqrm9tK1awVA4IQAxUdF
        ZHCyjHm33vWoM7Jy//r0JkQ=
X-Google-Smtp-Source: ABdhPJwBY6Xxa2lxCFj5Qd2WVcBILAKok0OjZoVUS87WNziPjmy/1kf13BRW3NjVy3L19xgfXw8UUA==
X-Received: by 2002:a05:6e02:1808:: with SMTP id a8mr2108025ilv.119.1633478724491;
        Tue, 05 Oct 2021 17:05:24 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:24 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: imx8mn: add GPC node
Date:   Tue,  5 Oct 2021 19:05:01 -0500
Message-Id: <20211006000505.627334-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006000505.627334-1-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the GPC, including all the PGC power domains,
some of them are not fully functional yet, as they require interaction
with the blk-ctrls to properly power up/down the peripherals.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index da6c942fb7f9..4191b5bfcdf3 100644
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
+						clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
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
+							 <&clk IMX8MN_CLK_GPU_SHADER_DIV>,
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
2.25.1

