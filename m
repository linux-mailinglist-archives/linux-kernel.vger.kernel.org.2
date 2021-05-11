Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180E937AF66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhEKThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhEKThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:37:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7355C06174A;
        Tue, 11 May 2021 12:36:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x5so21256559wrv.13;
        Tue, 11 May 2021 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8d71KOmZtSKlEO79aQEnL7ViCV2pmCZF2v0+nim6nA=;
        b=X7qFuuEzJwO5mi3bN09ZrZM3hzuEOepNNCQqRkfGOZfQZ8ObPey0u4wVaXvRG6jyRS
         D/iTDJt9xbhGYma2fo/1X87eaJzMevKV6chrc92RzOnHPPaezvRa/zEmmWmw5r9Y1jCc
         9jcTEb6pFf27l09BH9B+toK0Qdhj8BlzP2seqKI0NDoU2E56YhJ9OBUtRQ8NT8/dmTu9
         VPQVVM/wPRb9jlJclVdp8jq8SDzhmgC3XcQlt6zXnzIkwrasDWeLVUiuRszuDDPu5QjT
         J0VCuKAbBX9fFPuHZQH+PzClisX1w7CFTA7wXyHsmzPfxIv2C2U862t0+bxKOzWSmiMR
         tWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8d71KOmZtSKlEO79aQEnL7ViCV2pmCZF2v0+nim6nA=;
        b=q/to2hBFg8xRRF9kiJxmFCszvgO/UyeNIhEwh3K7nQ5lVWMDgkQFRmyfMeYUJmuNik
         y4eGy+j2JYmEIXhx/zIdluqExbH6MbFc1u1yUy8PMfYttJxJ/6cNnoOfZCNDOVDXo2kx
         vTdSkxXHrxpb3GoJHUKxH41Cx1DVsxwN/CGQkWEUVW71YVOEFdEbPNFVaXvwUKFMRwi1
         Mut1zwIFcer44kd2T9xYZKzPaHUwEx047pKlSNPFszi8uuWMDWhYH1T83TAD7MOUGRQa
         V6OrmqMuxAmI8b/DqQKHrnrmgjsVuHgc9RfMYi+CucA5vqhmUjjLmCyTLItVHu4ZsSZG
         9tuQ==
X-Gm-Message-State: AOAM532J9D+faIUcM44V3e2nZqmLYfwXYUjg4+gUGZ/OVI3lVdNVjZsi
        BbBo1q+S5OLQUADXbelbeOQ=
X-Google-Smtp-Source: ABdhPJwQHLIMX2KAlpjwqGIYR6bk3xMEx0/5fx15/ePKgM9sIedNE9vrbmwnpurJYqj7Fz8BGbGj6A==
X-Received: by 2002:adf:f212:: with SMTP id p18mr3123515wro.318.1620761768638;
        Tue, 11 May 2021 12:36:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:3e6:d280:2c6d:4527:c2ea:bb9a])
        by smtp.gmail.com with ESMTPSA id a76sm2604562wmd.16.2021.05.11.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:36:08 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 3/4] arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
Date:   Tue, 11 May 2021 21:36:00 +0200
Message-Id: <20210511193601.2584324-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511193601.2584324-1-adrien.grassein@gmail.com>
References: <20210511193601.2584324-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of the lt8912b in the DTB.
This adds the support of the DB_DSIHD daugther board from
Boundary Devices.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index 5553f3c84dbc..f70fb32b96b0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -34,6 +34,19 @@ power {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		ddc-i2c-bus = <&ddc_i2c_bus>;
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&lt8912_out>;
+			};
+		};
+	};
+
 	reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -81,6 +94,9 @@ reg_vref_5v: regulator-vref-5v {
 	};
 };
 
+&dphy {
+	status = "okay";
+};
 
 &fec1 {
 	pinctrl-names = "default";
@@ -194,6 +210,98 @@ rtc@68 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	pca9546: i2cmux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c4@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+
+			hdmi-bridge@48 {
+				compatible = "lontium,lt8912b";
+				reg = <0x48> ;
+				reset-gpios = <&max7323 0 GPIO_ACTIVE_LOW>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						hdmi_out_in: endpoint {
+							data-lanes = <1 2 3 4>;
+							remote-endpoint = <&mipi_dsi_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						lt8912_out: endpoint {
+							remote-endpoint = <&hdmi_connector_in>;
+						};
+					};
+				};
+			};
+		};
+
+		ddc_i2c_bus: i2c4@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+		};
+
+		i2c4@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <100000>;
+
+			max7323: gpio-expander@68 {
+				compatible = "maxim,max7323";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_max7323>;
+				gpio-controller;
+				reg = <0x68>;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
+
+&lcdif {
+	status = "okay";
+};
+
+&mipi_dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mipi_dsi_out: endpoint {
+				remote-endpoint = <&hdmi_out_in>;
+			};
+		};
+	};
+};
+
 &uart1 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -364,6 +472,19 @@ MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x49
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL			0x4000007f
+			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA			0x4000007f
+		>;
+	};
+
+	pinctrl_max7323: max7323grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15 0x19
+		>;
+	};
+
 	pinctrl_reg_arm_dram: reg-arm-dramgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SAI5_RXD3_GPIO3_IO24	0x16
-- 
2.25.1

