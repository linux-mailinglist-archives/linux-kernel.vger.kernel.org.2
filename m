Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC06427BF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJIQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhJIQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:26 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA5C061762;
        Sat,  9 Oct 2021 09:27:29 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y17so13349310ilb.9;
        Sat, 09 Oct 2021 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTpsExQ8NamYQf/+IYrF69SQcKnFXgrmlw9puVHWJw8=;
        b=eYnH3AbYG32wJveudkI9fy/JsjOTHNn1n7fr7TTRoUAbFpI2UBSDhQLfGgEgfgOeBw
         lDOHFHvSF037QwiN+UlbCUvhN89OzbBw000DquSv5QTAa51RJYevZY8Y0BQ7Fbgbd+dk
         xikvNtWR20VHCsxi5wvgo8sg00xuYNx06NaAyyVJndikdZd4sVnwKLNESSl3YLRDb6c1
         OE1QcaymRC1rxwmVVNCTGIxi04UkHD6eZhT81ilx/8MWeHZM681qsKnBoOq7aWOJpyRK
         e6qm7rfrNM9QqE8EtyHhx4rTz7hr4K2AXHPBJhpixbEwgkxdDxr4A0v+ccf31ihww5oK
         c4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTpsExQ8NamYQf/+IYrF69SQcKnFXgrmlw9puVHWJw8=;
        b=V4zNZvCF70AkvDur4+RiaCCxtwWVHN8e96V/2A04brm8n9NYCWBDOjtA6UlSqmmJI7
         nhuJk2XYsIRvd+Dbsgbk0ijleOAqz+gGMl++ykmqoBhPmKi+zzKl22daOVvftzcjoTMD
         u1R3U8khW//fDTA/PYuIkLnDX4OS8vzvOASaugz5klP7vKhTyMbIGZQVy98e3ERuioW5
         cgLQwJlqY+kpuSwo9K9Z16HsUqjx+VB1uauWo0rPw3WItvR7KGp2CVPSpJiCj9HdraBa
         CEbyBHolZndqIFTkN60o0jhWnf7HNe/P357mPbZMPzGoOFkghkdji839LSiFrkZiFbuj
         Dwrw==
X-Gm-Message-State: AOAM533Fhb7maGVg3GQCZLRrf7EUZGtRmS969B9T+fhQo8aDBROz9SXl
        OYxaeexdcj88z+E+CS4EMCk=
X-Google-Smtp-Source: ABdhPJzX1A10R4H8p83amb5cAgknM+f3WwQ9V9z+SZ5omdKy2iuxLQRp2Zdbp/pqERG6X+dYWUrgYQ==
X-Received: by 2002:a05:6e02:c03:: with SMTP id d3mr12823255ile.79.1633796848925;
        Sat, 09 Oct 2021 09:27:28 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:28 -0700 (PDT)
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
Subject: [PATCH V2 6/9] arm64: dts: imx8mn: add GPC node
Date:   Sat,  9 Oct 2021 11:26:56 -0500
Message-Id: <20211009162700.1452857-7-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
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
2.25.1

