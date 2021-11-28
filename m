Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14C460674
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357788AbhK1NY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357423AbhK1NWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:44 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99ADC06175A;
        Sun, 28 Nov 2021 05:19:27 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id v23so17508693iom.12;
        Sun, 28 Nov 2021 05:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFQET7el7Opw4znEKx5bdZ3qUb7koHAvlkGb7XoonGE=;
        b=ES0O4PKjArPkblwuWsK8QkYstK/tEd7rrYNVNQGasToPOJTq/NZEeZ0rJagbcDZA67
         5pjUVyW1X5VcQIx7aB46ZPwUxebTXjCF2bI02nmhRhtIuFPfjnRZ+Y/Q4n1x72H3xpew
         52lhCnkyRTSXa0qu4L5u1XcN7mo1ZELg5D/lIr5ESod9zQZcSZsuYdbmSeHsG5n+Hrkt
         /s7H5Ycdh0T3dhtBRjLsos3PI3bbCLoMXqnDJgAtmM3sHFaR130JKeXj0vPUWxm7A/Kx
         uq5WhGXlVde3WONtkBqq5F3lb+SuKXBJKkVZl5vmKuDQlmNz+t40+ff1uIC/OFGmUP5c
         Fd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFQET7el7Opw4znEKx5bdZ3qUb7koHAvlkGb7XoonGE=;
        b=VWPpsCRcz996XqMOqODSW/YivzQipFnqJ1Cf/jX2vZUKg5becURkdG3dXe/reaESdy
         J+CFsh/F9sddx5apy8Ta88ojnIMnW1dxfD+vLgOpZNzr+x3vEOyreLktD3QXdFt/FCDH
         CjGEcU7v6/BOr/l71ixQTVuyhoDj1kKS3XiTLNx0hj/0tidG71BihC+7OGd1uqhGsOa8
         gVl4Zln454yVtRs9NamO+t6uvlOnNdUVUSD5h0lpeE51BrWdaPZ5k5Sh+QJIVGJx9GOg
         J61+/dL487/t96jk+gVQ5SzeSnga8HrWPKt9fhKPuloHo6nHs7mYiufiAsSKx/Epwm8G
         WA7w==
X-Gm-Message-State: AOAM530B2zgUyqT7pawAOZk73mTrnTXEKcA3K3+2g/Jypf0f6OqgPywz
        nasneRtTCrDC3hWM/dHN+vc=
X-Google-Smtp-Source: ABdhPJweHVlw4ydCevxhOzQEt6yGQdu9pUe8VDb0of+VsCmQ6jBk0pG21yrsVtV0rzUVyeAf8ZMWWg==
X-Received: by 2002:a05:6602:140d:: with SMTP id t13mr53771441iov.120.1638105566979;
        Sun, 28 Nov 2021 05:19:26 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:26 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/9] arm64: dts: imx8mn: add GPC node
Date:   Sun, 28 Nov 2021 07:18:49 -0600
Message-Id: <20211128131853.15125-7-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
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
index ba23b416b5e6..ef1699a9cd7d 100644
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
@@ -640,6 +642,53 @@ src: reset-controller@30390000 {
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

