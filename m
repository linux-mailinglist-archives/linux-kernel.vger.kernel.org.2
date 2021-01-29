Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046BB308618
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhA2GxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhA2Gwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:52:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4CC061786;
        Thu, 28 Jan 2021 22:51:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z16so3686827wml.2;
        Thu, 28 Jan 2021 22:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VP2CCHQBNXtKJCFkUJhVL9cJo4wDQJQBLx9guRyCYbE=;
        b=lAFERyn16t6IKH/B04xnGPDSjZabYoJgG5eo0coz6k9LcA6YQuuwyLlv44vRC5dC4Y
         gnAKe/btYtvAxPXbxbEy5J/xiknphQ+9cUmw0NFtRLg/mVMOX/sMqoI99ybA7lzPavbI
         iwN5TgWc94kMh/g2x/PthN/bbRtc+59JvaWRVbsyhRNooH8eACo+KzueUt+6r0zJqzbB
         AeZq1/kqPf2nbRniehVZMAfH6/W6vPA6xrsiLeVI2uNNCkzkKB3eJJX++DmDdtX5k1Xw
         HqcdNDhSr1+4hp9rlwtdkTrRsADxh0Zz45wqfLd6prnb+N8/Fmf1WuesakekYNSzRXgs
         oN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VP2CCHQBNXtKJCFkUJhVL9cJo4wDQJQBLx9guRyCYbE=;
        b=WyDFC7urIaZhJ9vXB9x9PJnVzIoSJJ+CmjX9HHSSWL3o7lC9mh+v550a0dlKC/GPZC
         X6Vvd1Bhgl6pbkCcVuwxeLZfU6EFF3MSNEX7gnvSOIjjv+34rzEB86GoSQ6RSwQlO6kq
         RbVICAd8Ksr9lDKE6kqpIrKyul+4P9hIcxw3uOfaSjhGahIEtqD13i3QtA6e9+LjMSgC
         FDLXW6SMnLpHfX3W/kOYCti9BATjZouQYLkRwIjxZChm1DHDH8ZVE/wV4aHTqzMUL5Eo
         WDSq80Y4ODG+57Rf/MkwV600MRyyhGtytXSA1vhP0SeCLnfBmrj3F/WnYPGw0l7E8fx2
         89iw==
X-Gm-Message-State: AOAM531QRFjXC/eJn0dtl8DCHiRthJ6ZlBm8ojQA5LEBdcwmT3cNGAxM
        OouYWWyC9c2cEE+mG3z7q+k=
X-Google-Smtp-Source: ABdhPJzewy07pHgft5spDvtWcpL0Z0Jzf7htu4T7gYqWUbTeHW/zs2BxZAinDBd9hp04xwerCswt+g==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr2382899wml.26.1611903114076;
        Thu, 28 Jan 2021 22:51:54 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b7sm11501236wrs.50.2021.01.28.22.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:51:53 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH 5/5] arm64: dts: meson: add initial device-tree for ODROID-HC4
Date:   Fri, 29 Jan 2021 06:51:37 +0000
Message-Id: <20210129065137.5473-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129065137.5473-1-christianshewitt@gmail.com>
References: <20210129065137.5473-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODROID-HC4 is a derivative of the C4 with minor differences:

- 128MB SPI-NOR flash
- 2x SATA ports via ASM1061 PCIe to SATA controller
- 7-pin header with SPI and I2C for 1-inch OLED display and RTC
- 1x USB 2.0 host port

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 96 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index f3c8a85fe987..78a569d7fa20 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -47,5 +47,6 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
new file mode 100644
index 000000000000..bf15700c4b15
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Dongjin Kim <tobetter@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-sm1-odroid.dtsi"
+
+/ {
+	compatible = "hardkernel,odroid-hc4", "amlogic,sm1";
+	model = "Hardkernel ODROID-HC4";
+
+	aliases {
+		rtc0 = &rtc;
+		rtc1 = &vrtc;
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		cooling-levels = <0 120 170 220>;
+		pwms = <&pwm_cd 1 40000 0>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio_ao GPIOAO_11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			panic-indicator;
+		};
+
+		led-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio_ao GPIOAO_7 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	sound {
+		model = "ODROID-HC4";
+	};
+};
+
+&cpu_thermal {
+	cooling-maps {
+		map {
+			trip = <&cpu_passive>;
+			cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&ir {
+	linux,rc-map-name = "rc-odroid";
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-0 = <&i2c2_sda_x_pins>, <&i2c2_sck_x_pins>;
+	pinctrl-names = "default";
+
+	rtc: rtc@51 {
+		status = "okay";
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+		wakeup-source;
+	};
+};
+
+&pcie {
+	status = "okay";
+	reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+};
+
+&pwm_cd {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_d_x6_pins>;
+};
+
+&sd_emmc_c {
+	status = "disabled";
+};
+
+&usb {
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};
-- 
2.17.1

