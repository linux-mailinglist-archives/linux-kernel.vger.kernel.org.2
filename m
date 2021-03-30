Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB034E33E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhC3Ify (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhC3IfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:35:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73093C061764;
        Tue, 30 Mar 2021 01:35:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so7940084wmj.1;
        Tue, 30 Mar 2021 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gq3tSHnSw9aVXfzQgBJxuc0BvG/e1csZVMI3mejUQE=;
        b=ABxL5/TtDmSx/ozQApu1tTJIcorvqNexeTPLIB+Afx6XCzqAYOwD8f+3P9TVhmQVC1
         AsWcBZ2KVL6Pu+3Sx6+kC28hrlXpmOQvqg72eQ9SnfSn6ZrXyCg7S6GwKofqkaqUgS0Q
         +Bfiz5KYdo18hlaWGxcHQh2iJeRD1NjuLtuRw3mrg0EaANTPaJc+RpRudnbFb7wSY+ls
         +n73wvcoR6S7/O74VT9p6iqE3PiEZihW6AiGSqXZbMlMwa3KTLt9GthFn69i897rSby2
         Sz47NW7R66soD3QHY2IYpzLYLsPpw2AniJQpJOLoAED6OjUGsTYQ75CgIfnTDafp6RZT
         GUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gq3tSHnSw9aVXfzQgBJxuc0BvG/e1csZVMI3mejUQE=;
        b=sWvjrA51S4JRYGLxd/bYi7U9mRcDLqp1DcD9T4p4EgBW2As16/GKP1E13NFUlQaG1i
         5q83aJvQ17R13al33/GQaCOeH8Z9Hk7mhEvlhhwx/h6qIUKRCz1Tth3gu19bi0Y/XxA9
         RespRbw93O26NqUi4rrP7rsAr76p5OF1His04vqQqeL4kHwyLWyfa/S40GwVSutwpZ5N
         LCCFpxuTrEtyRSLnrgi7Kq25/yFrEscm2TwRzTCRHUo64fqzpzba4sI5UKoiJFD23zvc
         wWYzxhMS82qY/LuCTc8hsr/Mw2AqTX0zWrtSZPH0eOPR5h0xvHwfukhutNs7uqbxWCZ1
         Jtog==
X-Gm-Message-State: AOAM532urV+YpNJdK9XmmwnD3FuHCyJMFatkN9o+m/UvLgkAb9ky6AXL
        iqsuk5V8OzFmkD+MGgFsBA4=
X-Google-Smtp-Source: ABdhPJyTTralJPnhk9b+D8bZwCzk5aBNI2F0/ytN+WMdZD7+a6Cj7s430Dw283jY8Pq16n+L3JMUPQ==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr2910628wmf.47.1617093322192;
        Tue, 30 Mar 2021 01:35:22 -0700 (PDT)
Received: from localhost.localdomain (2a01cb0008bd2700a086f61fd085ac55.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:a086:f61f:d085:ac55])
        by smtp.gmail.com with ESMTPSA id g9sm32830263wrp.14.2021.03.30.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 01:35:21 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 3/4] arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
Date:   Tue, 30 Mar 2021 10:35:13 +0200
Message-Id: <20210330083514.5874-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330083514.5874-1-adrien.grassein@gmail.com>
References: <20210330083514.5874-1-adrien.grassein@gmail.com>
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
index 7a52e247c527..1c1feaf6facd 100644
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
@@ -185,6 +201,105 @@ rtc@68 {
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
@@ -360,6 +475,19 @@ MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x49
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

