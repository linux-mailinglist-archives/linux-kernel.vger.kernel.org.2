Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE02350AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCaXYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhCaXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:24:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83AC06175F;
        Wed, 31 Mar 2021 16:24:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so21280162wrd.1;
        Wed, 31 Mar 2021 16:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zo7Ozz9ZFKZ0atB3adNQDkSI8AV11LiEluu7vDY+9BY=;
        b=B4Dmi6T4UmKI6EcjMhH7qPp0Mcm+4ptCnZMI2G+gQaDn8swet6JHfSTmoZ1j+H5SFZ
         cYgOhek99bSYLQlK1v8KnSeo6RijTtEwKFij3l3PV8Lg0sn8RQDNz7DuoUTqVptDeM1o
         ENOgV+Q5HplZf6WWMVZw4V1bSem4VjIwajGxMliZGSrFgR6fTsLKxymI5D7+D36UUtPk
         WgzewVPsovx3trTTIQuCQqFiIpQ/0qWPAZPru2g1iqwHQjmN0hP2VhiihWwF0BpQGBdO
         wbgcEOZhHFpcJ5PrFFx+DiSQyBn91MEe0GqUEMdqIBsLfFK6C//H5RA4breTXKAnKO7P
         wU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zo7Ozz9ZFKZ0atB3adNQDkSI8AV11LiEluu7vDY+9BY=;
        b=TbhVGewXtw3oLhSnbSGQdCtrLSPDSu4dHc+DjJvxa4vYxffp/JD37QuKmss1O6DrxN
         lgH4LS45K5WdXPks5jnIiPNcX2ffLFd91sQmL6C/5b/va4fwiGPuKXAYMia8evXJ5sOI
         kWurv4OjEUP7Fbs5Epfc30RGBCv9qgZRBPe5ugvl4gPXGvhmYrauFSbVkN4gzCWeOmnF
         SD/djX9px9kqEgFruMwuG6UGy3FoUgMpbh67uSfSwSJxL66b4QKaRGVVDsZTsWn7NvE+
         /OSYW8zcQecFIb+kgNTp6eknooXdIfliP3XXx4hSK4kR+NjkihZhsIyuWo/K05IogEhg
         mS9Q==
X-Gm-Message-State: AOAM531ruJ1nszFcHtdxwfKl89mQGNSYpoGE+v2J3AJ0C7FGrUwzUVM4
        hdmtjTSBylkmpSXYvMzBnek=
X-Google-Smtp-Source: ABdhPJya5ttffKuaMbaSRiqrSslGOTIQwUAoRhLleoTDcELrFgAAQEqgJjXfDClx0D08D234Vo0FpQ==
X-Received: by 2002:adf:f186:: with SMTP id h6mr6279473wro.290.1617233040785;
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27007d57ea0d08d946c1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:7d57:ea0d:8d9:46c1])
        by smtp.gmail.com with ESMTPSA id t14sm6343041wru.64.2021.03.31.16.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 16:24:00 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 3/4] arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
Date:   Thu,  1 Apr 2021 01:23:55 +0200
Message-Id: <20210331232356.2204476-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232356.2204476-1-adrien.grassein@gmail.com>
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
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
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index 04992cbba56e..4ffd23ea705f 100644
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
@@ -193,6 +209,97 @@ rtc@68 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	pca9546: i2cmux9546@70 {
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
+			max7323: max7323@68 {
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
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ports {
+		port@1 {
+			reg = <1>;
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
@@ -368,6 +475,19 @@ MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x49
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

