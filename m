Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC7443D98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhKCHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:19:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2AC061714;
        Wed,  3 Nov 2021 00:16:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t7so1605020pgl.9;
        Wed, 03 Nov 2021 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sw2ZfxdhteQblMHs+KiJAQ/BwsczDF3dqqFFUzXxrXE=;
        b=T1ppavJnFKWb16xfwDAB8AemYcwiaiSud5MMCedgSfnCWOflus8tK1K9pI04o99oWU
         7U8qYJ7G2bFCjZrJXaD7MsEZI5V69SVHG8OjKPqj/p+TFTqu1HVWsHOGEeP91jOC+60M
         iYFe5nqZmfge/Ta6B2nQuv6+hSFiJvYWjAAh+0gCmM4hm0XVz1i83edwU0vWpaKL494i
         tE08nodeunw6K1qYXHgmlQd6VcuhGuOwlBaWsHlStjwJwKb3KH/98H8Aonl/F93uUeIr
         /rWsxW8KJ6aaqa1D8kZu0Ky/yuG7CFJ7kAP9L3rRRDl+rY0qzSlLU+Bi5jEyH/LJtxfK
         uF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sw2ZfxdhteQblMHs+KiJAQ/BwsczDF3dqqFFUzXxrXE=;
        b=C865/4SisCQv8YCoG0tIKlkcIIG8l6oP2UkcHN/f7/hS3OquTHeR54DL4t7pHdejnt
         I30RyW52+hiuJn17Pb3n9YAi3EGXYSuzIXstfwmmhLYoRB4Ws/ALjVxrQ/sQGFLBsssg
         x5khr6p1Pkwj0PLrplgIofQXuEoZLgAZNrFNUCmjD/6oVV0UiaJK/5ECGaIwL//ARFnn
         +NgLjWCMLOF4IlRsyqf7dGJS1JxLKb+12AmM5BiM21AEfopxPCJaPkgMt/XEKnhMPyW5
         Wv2dpJqSNBVDl211K0VEqmkIy0N9yHtiY+h/OyDMtWs5gxZetG50bnsXgRNpGWzwMQ1k
         zpcA==
X-Gm-Message-State: AOAM533VsLOhvawqnEW9Rnh/1ySn1mhuDDOSl6Ddk9u/vhe/Go7KVoe6
        3xET7XJOlY7dXWGMtWoz8t4=
X-Google-Smtp-Source: ABdhPJxfUtmBMU09f037nYGfNCimCCCS2wUatgv2jcaqjr2OkX3AWUQJqMM1sg6TRB3LXHp1ABMf9g==
X-Received: by 2002:a62:7f4a:0:b0:44d:292f:cc24 with SMTP id a71-20020a627f4a000000b0044d292fcc24mr42299793pfd.58.1635923804171;
        Wed, 03 Nov 2021 00:16:44 -0700 (PDT)
Received: from howard-System-Product-Name.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id b2sm1039281pgh.33.2021.11.03.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:16:43 -0700 (PDT)
From:   Howard Chiu <howard10703049@gmail.com>
X-Google-Original-From: Howard Chiu <howard.chiu@quantatw.com>
To:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        Howard Chiu <howard.chiu@quantatw.com>
Subject: [PATCH v1] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Date:   Wed,  3 Nov 2021 15:14:18 +0800
Message-Id: <20211103071417.388388-1-howard.chiu@quantatw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial introduction of Facebook Bletchley equipped with
Aspeed 2600 BMC SoC.

Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
---
 arch/arm/boot/dts/Makefile                    |    1 +
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 1160 +++++++++++++++++
 2 files changed, 1161 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..2cc2d804e75a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1474,6 +1474,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-wedge400.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
+	aspeed-bmc-facebook-bletchley.dtb \
 	aspeed-bmc-ibm-everest.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
new file mode 100644
index 000000000000..af30be95fb23
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -0,0 +1,1160 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/usb/pd.h>
+
+/ {
+	model = "Facebook Bletchley BMC";
+	compatible = "facebook,bletchley-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		bootargs = "console=ttyS4,115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+		  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+		  <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+		  <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+
+	switchphy: ethernet-phy@0 {
+		// Fixed-link
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		sys_log_id {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&front_leds 0 GPIO_ACTIVE_HIGH>;
+		};
+		fan0_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_ioexp 8 GPIO_ACTIVE_HIGH>;
+		};
+		fan1_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_ioexp 9 GPIO_ACTIVE_HIGH>;
+		};
+		fan2_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_ioexp 10 GPIO_ACTIVE_HIGH>;
+		};
+		fan3_blue {
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_ioexp 11 GPIO_ACTIVE_HIGH>;
+		};
+		fan0_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_ioexp 12 GPIO_ACTIVE_HIGH>;
+		};
+		fan1_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_ioexp 13 GPIO_ACTIVE_HIGH>;
+		};
+		fan2_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_ioexp 14 GPIO_ACTIVE_HIGH>;
+		};
+		fan3_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_ioexp 15 GPIO_ACTIVE_HIGH>;
+		};
+		sled0_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled0_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled0_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled0_leds 1 GPIO_ACTIVE_LOW>;
+		};
+		sled1_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled1_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled1_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled1_leds 1 GPIO_ACTIVE_LOW>;
+		};
+		sled2_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled2_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled2_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled2_leds 1 GPIO_ACTIVE_LOW>;
+		};
+		sled3_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled3_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled3_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled3_leds 1 GPIO_ACTIVE_LOW>;
+		};
+		sled4_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled4_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled4_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled4_leds 1 GPIO_ACTIVE_LOW>;
+		};
+		sled5_ember {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled5_leds 0 GPIO_ACTIVE_LOW>;
+		};
+		sled5_blue {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&sled5_leds 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&mac2 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&switchphy>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii3_default>;
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+	};
+};
+
+&uart5 {
+	// Workaround for A0
+	compatible = "snps,dw-apb-uart";
+};
+
+&i2c0 {
+	status = "okay";
+	/* TODO: Add HSC MP5023 */
+	/* TODO: Add ADC INA230 */
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	sled0_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","SLED0_BMC_CCG5_INT","SLED0_INA230_ALERT","SLED0_P12V_STBY_ALERT",
+		"SLED0_SSD_ALERT","SLED0_MS_DETECT","SLED0_MD_REF_PWM","",
+		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_MD_DECAY",
+		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","SLED0_AC_PWR_EN";
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+		gpio@8 {
+			reg = <8>;
+		};
+		gpio@9 {
+			reg = <9>;
+		};
+		gpio@10 {
+			reg = <10>;
+		};
+		gpio@11 {
+			reg = <11>;
+		};
+		gpio@12 {
+			reg = <12>;
+		};
+		gpio@13 {
+			reg = <13>;
+		};
+		gpio@14 {
+			reg = <14>;
+		};
+		gpio@15 {
+			reg = <15>;
+		};
+	};
+
+	sled0_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED0_EMBER_LED","SLED0_BLUE_LED","SLED0_RST_IOEXP","",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	sled0_fusb302: typec-portc@54 {
+		compatible = "fcs,fusb302";
+		reg = <0x54>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(3000, 12000, 3000)
+					PDO_PPS_APDO(3000, 11000, 3000)>;
+			op-sink-microwatt = <10000000>;
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	/* TODO: Add HSC MP5023 */
+	/* TODO: Add ADC INA230 */
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	sled1_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","SLED1_BMC_CCG5_INT","SLED1_INA230_ALERT","SLED1_P12V_STBY_ALERT",
+		"SLED1_SSD_ALERT","SLED1_MS_DETECT","SLED1_MD_REF_PWM","",
+		"SLED1_MD_STBY_RESET","SLED1_MD_IOEXP_EN_FAULT","SLED1_MD_DIR","SLED1_MD_DECAY",
+		"SLED1_MD_MODE1","SLED1_MD_MODE2","SLED1_MD_MODE3","SLED1_AC_PWR_EN";
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+		gpio@8 {
+			reg = <8>;
+		};
+		gpio@9 {
+			reg = <9>;
+		};
+		gpio@10 {
+			reg = <10>;
+		};
+		gpio@11 {
+			reg = <11>;
+		};
+		gpio@12 {
+			reg = <12>;
+		};
+		gpio@13 {
+			reg = <13>;
+		};
+		gpio@14 {
+			reg = <14>;
+		};
+		gpio@15 {
+			reg = <15>;
+		};
+	};
+
+	sled1_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED1_EMBER_LED","SLED1_BLUE_LED","SLED1_RST_IOEXP","",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	sled1_fusb302: typec-portc@54 {
+		compatible = "fcs,fusb302";
+		reg = <0x54>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(3000, 12000, 3000)
+					PDO_PPS_APDO(3000, 11000, 3000)>;
+			op-sink-microwatt = <10000000>;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	/* TODO: Add HSC MP5023 */
+	/* TODO: Add ADC INA230 */
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	sled2_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","SLED2_BMC_CCG5_INT","SLED2_INA230_ALERT","SLED2_P12V_STBY_ALERT",
+		"SLED2_SSD_ALERT","SLED2_MS_DETECT","SLED2_MD_REF_PWM","",
+		"SLED2_MD_STBY_RESET","SLED2_MD_IOEXP_EN_FAULT","SLED2_MD_DIR","SLED2_MD_DECAY",
+		"SLED2_MD_MODE1","SLED2_MD_MODE2","SLED2_MD_MODE3","SLED2_AC_PWR_EN";
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+		gpio@8 {
+			reg = <8>;
+		};
+		gpio@9 {
+			reg = <9>;
+		};
+		gpio@10 {
+			reg = <10>;
+		};
+		gpio@11 {
+			reg = <11>;
+		};
+		gpio@12 {
+			reg = <12>;
+		};
+		gpio@13 {
+			reg = <13>;
+		};
+		gpio@14 {
+			reg = <14>;
+		};
+		gpio@15 {
+			reg = <15>;
+		};
+	};
+
+	sled2_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED2_EMBER_LED","SLED2_BLUE_LED","SLED2_RST_IOEXP","",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	sled2_fusb302: typec-portc@54 {
+		compatible = "fcs,fusb302";
+		reg = <0x54>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(3000, 12000, 3000)
+					PDO_PPS_APDO(3000, 11000, 3000)>;
+			op-sink-microwatt = <10000000>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	/* TODO: Add HSC MP5023 */
+	/* TODO: Add ADC INA230 */
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	sled3_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","SLED3_BMC_CCG5_INT","SLED3_INA230_ALERT","SLED3_P12V_STBY_ALERT",
+		"SLED3_SSD_ALERT","SLED3_MS_DETECT","SLED3_MD_REF_PWM","",
+		"SLED3_MD_STBY_RESET","SLED3_MD_IOEXP_EN_FAULT","SLED3_MD_DIR","SLED3_MD_DECAY",
+		"SLED3_MD_MODE1","SLED3_MD_MODE2","SLED3_MD_MODE3","SLED3_AC_PWR_EN";
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+		gpio@8 {
+			reg = <8>;
+		};
+		gpio@9 {
+			reg = <9>;
+		};
+		gpio@10 {
+			reg = <10>;
+		};
+		gpio@11 {
+			reg = <11>;
+		};
+		gpio@12 {
+			reg = <12>;
+		};
+		gpio@13 {
+			reg = <13>;
+		};
+		gpio@14 {
+			reg = <14>;
+		};
+		gpio@15 {
+			reg = <15>;
+		};
+	};
+
+	sled3_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED3_EMBER_LED","SLED3_BLUE_LED","SLED3_RST_IOEXP","",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	sled3_fusb302: typec-portc@54 {
+		compatible = "fcs,fusb302";
+		reg = <0x54>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(3000, 12000, 3000)
+					PDO_PPS_APDO(3000, 11000, 3000)>;
+			op-sink-microwatt = <10000000>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	/* TODO: Add HSC MP5023 */
+	/* TODO: Add ADC INA230 */
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	sled4_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","SLED4_BMC_CCG5_INT","SLED4_INA230_ALERT","SLED4_P12V_STBY_ALERT",
+		"SLED4_SSD_ALERT","SLED4_MS_DETECT","SLED4_MD_REF_PWM","",
+		"SLED4_MD_STBY_RESET","SLED4_MD_IOEXP_EN_FAULT","SLED4_MD_DIR","SLED4_MD_DECAY",
+		"SLED4_MD_MODE1","SLED4_MD_MODE2","SLED4_MD_MODE3","SLED4_AC_PWR_EN";
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+		gpio@8 {
+			reg = <8>;
+		};
+		gpio@9 {
+			reg = <9>;
+		};
+		gpio@10 {
+			reg = <10>;
+		};
+		gpio@11 {
+			reg = <11>;
+		};
+		gpio@12 {
+			reg = <12>;
+		};
+		gpio@13 {
+			reg = <13>;
+		};
+		gpio@14 {
+			reg = <14>;
+		};
+		gpio@15 {
+			reg = <15>;
+		};
+	};
+
+	sled4_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED4_EMBER_LED","SLED4_BLUE_LED","SLED4_RST_IOEXP","",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	sled4_fusb302: typec-portc@54 {
+		compatible = "fcs,fusb302";
+		reg = <0x54>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(3000, 12000, 3000)
+					PDO_PPS_APDO(3000, 11000, 3000)>;
+			op-sink-microwatt = <10000000>;
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	/* TODO: Add HSC MP5023 */
+	/* TODO: Add ADC INA230 */
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	sled5_ioexp: pca9539@76 {
+		compatible = "nxp,pca9539";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","SLED5_BMC_CCG5_INT","SLED5_INA230_ALERT","SLED5_P12V_STBY_ALERT",
+		"SLED5_SSD_ALERT","SLED5_MS_DETECT","SLED5_MD_REF_PWM","",
+		"SLED5_MD_STBY_RESET","SLED5_MD_IOEXP_EN_FAULT","SLED5_MD_DIR","SLED5_MD_DECAY",
+		"SLED5_MD_MODE1","SLED5_MD_MODE2","SLED5_MD_MODE3","SLED5_AC_PWR_EN";
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+		gpio@8 {
+			reg = <8>;
+		};
+		gpio@9 {
+			reg = <9>;
+		};
+		gpio@10 {
+			reg = <10>;
+		};
+		gpio@11 {
+			reg = <11>;
+		};
+		gpio@12 {
+			reg = <12>;
+		};
+		gpio@13 {
+			reg = <13>;
+		};
+		gpio@14 {
+			reg = <14>;
+		};
+		gpio@15 {
+			reg = <15>;
+		};
+	};
+
+	sled5_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SLED5_EMBER_LED","SLED5_BLUE_LED","SLED5_RST_IOEXP","",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	sled5_fusb302: typec-portc@54 {
+		compatible = "fcs,fusb302";
+		reg = <0x54>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+					PDO_VAR(3000, 12000, 3000)
+					PDO_PPS_APDO(3000, 11000, 3000)>;
+			op-sink-microwatt = <10000000>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf85263";
+		reg = <0x51>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	hdc1080@40 {
+		compatible = "ti,hdc1080";
+		reg = <0x40>;
+	};
+
+	front_leds: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"SYSTEM_LOG_ID_LED","PWRGD_P5V_STBY","PWRGD_P1V0_DVDD","PWRGD_P1V0_AVDD",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@3 {
+			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	adm1278@11 {
+		compatible = "adi,adm1278";
+		reg = <0x11>;
+	};
+
+	tmp421@4c {
+		compatible = "ti,tmp421";
+		reg = <0x4c>;
+	};
+
+	tmp421@4f {
+		compatible = "ti,tmp421";
+		reg = <0x4f>;
+	};
+
+	fan_ioexp: pca9552@67 {
+		compatible = "nxp,pca9552";
+		reg = <0x67>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"FAN0_PRSNT","FAN1_PRSNT","FAN2_PRSNT","FAN3_PRSNT",
+		"FAN0_PWRGD","FAN1_PWRGD","FAN2_PWRGD","FAN3_PWRGD",
+		"","","","",
+		"","","","";
+
+		gpio@0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@3 {
+			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@4 {
+			reg = <4>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@5 {
+			reg = <5>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@6 {
+			reg = <6>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@7 {
+			reg = <7>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@8 {
+			reg = <8>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@9 {
+			reg = <9>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@10 {
+			reg = <10>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@11 {
+			reg = <11>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@12 {
+			reg = <12>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@13 {
+			reg = <13>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@14 {
+			reg = <14>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+		gpio@15 {
+			reg = <15>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+};
+
+&i2c13 {
+	multi-master;
+	aspeed,hw-timeout-ms = <1000>;
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"alert_sled1","alert_sled2",
+			"alert_sled3","alert_sled4",
+			"alert_sled5","alert_sled6",
+			"p12v_aux_alert1","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&adc0 {
+	vref = <1800>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref = <2500>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
-- 
2.25.1

