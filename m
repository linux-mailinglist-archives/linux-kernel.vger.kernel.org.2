Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD13AE42E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFUH2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFUH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:27:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BB6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so1627611pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTGm4JdvD3Vra2uimR9VdWCccBLfDRHg1bYd/TgBubU=;
        b=PFJ+240oebdQnrjo/n/RAYbIElojZ4FKbPovvcLEqUz4yBbkyVuFvAOGUWXkm30rfe
         75bW0/Ce4RgwAgC4v3Vrk7kmCKD6qi1mkuF5f0eGUUYyW6TGPpMB4W5gED+bP1XNgU3J
         fcUqMyXjuP9ETuCKYHTX4nrwrmYudt7xQPSBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTGm4JdvD3Vra2uimR9VdWCccBLfDRHg1bYd/TgBubU=;
        b=Gpi7Qiq6h99DTOUBjTHM4ptNEQGlKlh4ke2DYT6G95T0FQzCcTQVfLvvY2t2Wy5Al9
         Bbnc3NyBjNFZNnCcgMp7PtwCLKuXZ4uI4TFoXl323VQ+E2YKoE/3gVtxEe/+yATNUbKg
         w1/MkGseSvWNfkXlik12wjBMB8K2wYTvIg8nGKnFuG36LIx57AONg3SSq5HShw4xjtuF
         rnf1ZRbUfNM6A9zX/3wR2Gi4zQwVOXtF/SjEWFnfyhbAiPYyA/rdRS5iFfxYIofp9VAC
         VXmsGu1isTfZwGAsef4sDHyUDQvKTllTDZ+EyuIvvQco2MrHcSSKptpkpi42NcuOuC8k
         6dvw==
X-Gm-Message-State: AOAM531N9qzoQZ5CyLPbIwkBqsFy0DjNFZrXyhAL23UxXRVLCJ+ABA+0
        bsDU+z8is6HaSpzOpOEHAW1DJw==
X-Google-Smtp-Source: ABdhPJySHSLKRyuhIZrudYf++tyEsD+0GgBX+hyzQUfgAdzn15cvpKaHOeRlq0FvEo+n97tiu5R9dg==
X-Received: by 2002:a63:185b:: with SMTP id 27mr23058306pgy.164.1624260340808;
        Mon, 21 Jun 2021 00:25:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00a:a884:139:e97f:a55d:7f66])
        by smtp.gmail.com with ESMTPSA id 21sm13951294pfh.103.2021.06.21.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:25:40 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 9/9] arm64: dts: imx8mm-icore: Enable LVDS panel for EDIMM2.2
Date:   Mon, 21 Jun 2021 12:54:24 +0530
Message-Id: <20210621072424.111733-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072424.111733-1-jagan@amarulasolutions.com>
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable LVDS Panel for Engicam i.Core MX8MMini EDIMM2.2 board.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../freescale/imx8mm-icore-mx8mm-edimm2.2.dts | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
index a4a2ada14835..f1256c9c9bd7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dts
@@ -14,9 +14,51 @@ / {
 	compatible = "engicam,icore-mx8mm-edimm2.2", "engicam,icore-mx8mm",
 		     "fsl,imx8mm";
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pwm1>;
+		pwms = <&pwm1 0 1000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
 	chosen {
 		stdout-path = &uart2;
 	};
+
+	panel {
+		compatible = "yes-optoelectronics,ytc700tlag-05-201c";
+		backlight = <&backlight>;
+		data-mapping = "vesa-24";
+
+		port {
+			panel_out_bridge: endpoint {
+				remote-endpoint = <&bridge_out_panel>;
+			};
+		};
+	};
+};
+
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			dsi_out_bridge: endpoint {
+				remote-endpoint = <&bridge_in_dsi>;
+				data-lanes = <0 1>;
+			};
+		};
+	};
 };
 
 &fec1 {
@@ -35,9 +77,43 @@ &i2c4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
+
+	bridge@2c {
+		compatible = "ti,sn65dsi84";
+		reg = <0x2c>;
+		enable-gpios = <&gpio3 9  GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dsi_bridge_enable>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in_dsi: endpoint {
+					remote-endpoint = <&dsi_out_bridge>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out_panel: endpoint {
+					remote-endpoint = <&panel_out_bridge>;
+				};
+			};
+		};
+	};
 };
 
 &iomuxc {
+	pinctrl_dsi_bridge_enable: dsibridgeenablegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_DATA03_GPIO3_IO9	0x19
+			MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8	0x19
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -52,6 +128,12 @@ MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_PWM1_OUT     0x19
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
@@ -77,6 +159,14 @@ MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
 	};
 };
 
+&lcdif {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-- 
2.25.1

