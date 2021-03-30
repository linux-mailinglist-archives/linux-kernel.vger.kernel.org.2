Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70134E41F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhC3JOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhC3JOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:14:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD93C0613D8;
        Tue, 30 Mar 2021 02:14:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z2so15483326wrl.5;
        Tue, 30 Mar 2021 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3r1pwXvk7uC70y7vqvQXyGK5FdrZ6W9wwaKab/u7P58=;
        b=u4byfqUYplUxBynsw8i/dyJdzc5QEdD9UFTqPTS2iIpO2DdeCMsopL1YCxgC1P9Z9M
         2qoXL4dX5RroOAZmrhwc+A0G1asmxzHmL4ERz5G0GHFUvifcTpQH7DXeNIyFg641CYTL
         xlPDOE0ELP32OS2q7xaoHU0I4YQQPqOUv6OcpDMCxbQZZRgeiF6v8P6wPeJR1mf0NT52
         GqGxPDyjdCGCxljtfvV9xIHotLuqPKxp0w5LLm7wxLfJ1hv4fmAtOZPPiKIojaV8joEi
         cX+Jj4wekA9cM6hlxgKjTXG9pF7qJXOYRTh8OxJ/1Lsb1AoNUSKdNdGiH47hIaeSAjWu
         xtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3r1pwXvk7uC70y7vqvQXyGK5FdrZ6W9wwaKab/u7P58=;
        b=K0d03rlzKP2P8eBcePjPgBzGgjrVLqRDCiONMbdN4PL6SS1ZYkwr9nS10KARMSpRvB
         BANQi2qshgyfS6xdqGw9yHXl6rFSUjT1yETHsMFsEcYM23yG3n5/G7eJEge3r/zLls2a
         QarYG/P5cvZmuqKo6AGaF2qmHzZ35auec4IDnxWnMypOXHpTuc8A5+4OtGOQ/nZBmZmY
         dTcwJT2zTfRJXlaRYqbLoHZWlBa67uqQVx20cqn45PFvGDpcXLdBRrkYDQbo7wNh+GnY
         Whc+SXMX9i4T4Up73NmVwPLalqjNXACBD1BzYxgM1PKGLdK7nAbUhVYus/ld6DfMoDTW
         yLmQ==
X-Gm-Message-State: AOAM5332dIjK86I3u4JxeQWA1IlHWkaCdxq6N4BavPkvW61mwZeMP09L
        +vMJ/P4b0rScd6zPtgnXOTg=
X-Google-Smtp-Source: ABdhPJzRGW5GxYIeT9zi7wY+Sm1RMyuJYCj17MAl9j7kEQ4Lh02dEiuvpTwW7NfQFDrP5Dv+NM6LtA==
X-Received: by 2002:a5d:634f:: with SMTP id b15mr30457733wrw.310.1617095671457;
        Tue, 30 Mar 2021 02:14:31 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id l8sm33305840wrx.83.2021.03.30.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:14:31 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 3/4] arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
Date:   Tue, 30 Mar 2021 11:14:25 +0200
Message-Id: <20210330091426.95030-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330091426.95030-1-adrien.grassein@gmail.com>
References: <20210330091426.95030-1-adrien.grassein@gmail.com>
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
 .../boot/dts/freescale/imx8mq-nitrogen.dts    | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index 04992cbba56e..da5a95ffa8b4 100644
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
@@ -193,6 +209,105 @@ rtc@68 {
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
+&gpio3 {
+	max7323_intterupt {
+		gpio-hog;
+		gpios = <15 0>;
+		input;
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
@@ -368,6 +483,19 @@ MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x49
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

