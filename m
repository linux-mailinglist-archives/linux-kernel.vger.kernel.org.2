Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA96343BB58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhJZUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhJZUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:03:49 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1BC061570;
        Tue, 26 Oct 2021 13:01:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q16so804480ljg.3;
        Tue, 26 Oct 2021 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixtBSKhlM5RJeYoi6sIB/twD1T61aXRVqcD6skfC0C4=;
        b=OASvt0WNZosZEZgHQuH8VNU02bUZyY3BDytmDoB62eyIAfV6yXTow0cBabMkYAbWYy
         oIBB7Qxosao/Vpidt1V33S9hhybw/bgbj9zDM/dKUg74KiYjgW1/VMsGAu3v9HWIwrXi
         kCOFdXz+PdAvF8c5clnbl3luoqQhr0sZY8imjodZVbu8UycGKoawN/SelKj0cCmGAg1V
         reL3pVF77cyAThFPXCCd7yw/X8GVS4vWMmvaqISoszSXzeTb1MX9k7vzQ80k1a77D1yx
         EP/R753qh8Zb//YZVscmYaryJRpA76F9VxwDCeKJk2l/mQtRLpAmHUScsvvaLI+QvIAx
         uCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixtBSKhlM5RJeYoi6sIB/twD1T61aXRVqcD6skfC0C4=;
        b=VSfxwyoz6EPTiUrqSvJefOCk0nJli+BInPBmkh/yemBMeKPzvQGrRa8DSeTBwggv/W
         lzZV2QfVzQ5Z1sGtdBMvljUJ79Tz8EbX9i9riX1mfMJNqOS1QlcDh5r9NPoQKvgHGTQP
         nWRpDIkKfoOR+JTZhxX0FAocvN5gjNSSe4LOH7wfJGPiotFXzPgSohqNCtS3mc26ldOK
         Qe5UcXcYDw7+GttBkZZZqD8RN8TZSQ6S7pS7ni/anCB5cRigPvIGiDKxJTZqsNeK4v4L
         oA3EX1coJyopbZRAhucx4P56HddOv6iu26K08aIFsY51+p6dgF6lEP3e7BYQ9fTg8UgE
         Mu9Q==
X-Gm-Message-State: AOAM532cRUsMlsgN0NxeagORP4mH7JlWlOE0muD9wWI8KE1Oxz06+i4E
        6NpHS+yvChWsXWiXO+Jwc0JUyCUOmM2qIA==
X-Google-Smtp-Source: ABdhPJzIfFctBTfgVls2IZEdAjOeMzERzyJj26kMXRMddH9jsu2AwiH0X/heXUB/4NLOJSZOLi7w0w==
X-Received: by 2002:a05:651c:2104:: with SMTP id a4mr1861591ljq.82.1635278483010;
        Tue, 26 Oct 2021 13:01:23 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-11-233.ip.moscow.rt.ru. [46.242.11.233])
        by smtp.gmail.com with ESMTPSA id x7sm2020720lfu.116.2021.10.26.13.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 13:01:22 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH] ARM: dts: aspeed: Add AMD DaytonaX BMC
Date:   Tue, 26 Oct 2021 23:00:56 +0300
Message-Id: <20211026200058.2183-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial version of device tree for the BMC in the AMD DaytonaX
platform.

AMD DaytonaX platform is a customer reference board (CRB) with an
Aspeed ast2500 BMC manufactured by AMD.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts | 327 ++++++++++++++++++
 2 files changed, 328 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..01cfd803d273 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1457,6 +1457,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2600-evb-a1.dtb \
 	aspeed-ast2600-evb.dtb \
 	aspeed-bmc-amd-ethanolx.dtb \
+	aspeed-bmc-amd-daytonax.dtb \
 	aspeed-bmc-ampere-mtjade.dtb \
 	aspeed-bmc-arm-centriq2400-rep.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
new file mode 100644
index 000000000000..93ad4262a786
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 AMD Inc.
+// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "AMD DaytonaX BMC";
+	compatible = "amd,daytonax-bmc", "aspeed,ast2500";
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+
+	aliases {
+		serial0 = &uart1;
+		serial4 = &uart5;
+	};
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlycon";
+	};
+	leds {
+		compatible = "gpio-leds";
+
+		fault {
+			gpios = <&gpio ASPEED_GPIO(A, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		identify {
+			gpios = <&gpio ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
+			      <&adc 10>, <&adc 11>, <&adc 12>, <&adc 13>, <&adc 14>,
+			      <&adc 15>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+};
+
+&uart1 {
+	//Host Console
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart5 {
+	//BMC Console
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default
+		     &pinctrl_adc1_default
+		     &pinctrl_adc2_default
+		     &pinctrl_adc4_default
+		     &pinctrl_adc5_default
+		     &pinctrl_adc6_default
+		     &pinctrl_adc7_default
+		     &pinctrl_adc8_default
+		     &pinctrl_adc9_default
+		     &pinctrl_adc10_default
+		     &pinctrl_adc11_default
+		     &pinctrl_adc12_default
+		     &pinctrl_adc13_default
+		     &pinctrl_adc14_default
+		     &pinctrl_adc15_default>;
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","","FAULT_LED","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"CHASSIS_ID_BTN","","","","","","","",
+	/*D0-D7*/	"","","ASSERT_BMC_READY","","","","","",
+	/*E0-E7*/	"MON_P0_RST_BTN","ASSERT_RST_BTN","MON_P0_PWR_BTN","ASSERT_PWR_BTN","",
+			"MON_P0_PWR_GOOD","MON_PWROK","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
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
+	/*Z0-Z7*/	"","","","","","","","",
+	/*AA0-AA7*/	"","","","","","","","",
+	/*AB0-AB7*/	"","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&kcs1 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x60>;
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x62>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xCA2>;
+};
+
+&kcs4 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0x97DE>;
+};
+
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>, <0x81>;
+};
+
+&lpc_ctrl {
+	//Enable lpc clock
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+	&pinctrl_pwm1_default
+	&pinctrl_pwm2_default
+	&pinctrl_pwm3_default
+	&pinctrl_pwm4_default
+	&pinctrl_pwm5_default
+	&pinctrl_pwm6_default
+	&pinctrl_pwm7_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan@2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan@3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
+	};
+
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+
+	fan@5 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05>;
+	};
+
+	fan@6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06>;
+	};
+
+	fan@7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07>;
+	};
+
+	fan@8 {
+		reg = <0x08>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x08>;
+	};
+
+	fan@9 {
+		reg = <0x09>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x09>;
+	};
+
+	fan@10 {
+		reg = <0x0a>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0a>;
+	};
+
+	fan@11 {
+		reg = <0x0b>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0b>;
+	};
+
+	fan@12 {
+		reg = <0x0c>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0c>;
+	};
+
+	fan@13 {
+		reg = <0x0d>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0d>;
+	};
+
+	fan@14 {
+		reg = <0x0e>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0e>;
+	};
+
+	fan@15 {
+		reg = <0x0f>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0f>;
+	};
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vhub {
+	status = "okay";
+};
+
-- 
2.25.1

