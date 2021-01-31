Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98BD309AC2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 06:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhAaF5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 00:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhAaFzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 00:55:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93BC0613ED;
        Sat, 30 Jan 2021 21:54:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id s24so9315083wmj.0;
        Sat, 30 Jan 2021 21:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+AW/kKV57MV1Hg+Mxh63gGp9E1qwTrjnLtYXQZusbg=;
        b=MGCDMbs4pGnpYYCve9uEvfF4M93qP/pW/Oz5YXgn1PEe3yoKnRW5DwvlKTdX04VboD
         QPivn5mY+BXDcBRUdCkSVOW96bHeDnEIFj6EhE5hlvIALblnedVqpXN+zYS4MxxrmVh6
         L7+n/KODPVtyl/af/voeznsvtRMYELIvkhO2pptSg6LIoqA/p875S6cRgfsEcP2UZUsY
         mv1jlYHrftUKiefxMh97/euXVnX3gS7GBWuAkXCw2sm5zbeNZGT8XznP+IbrJDrbiqRj
         uYV3pedWRaXYBx8DRlYejDzJ+5vqV8q/J6xG/TFsB8s9wsTyehLe3yeAZcziUcerm3sm
         Cyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+AW/kKV57MV1Hg+Mxh63gGp9E1qwTrjnLtYXQZusbg=;
        b=ZR4EQSszz3L/IF5yqZwiamXP/fQDYmPLt33ySwnarjs92U/1KXMzcfzXUbzFnZWpkE
         gYjm261eId6XSVIJ8dvjokAmP+MWSJWDeDrtLn7v8NyNsD3ixAGkDeH0eAnW9hJr8lIq
         TghNViGEZ4dSrdQXqd22kh711p7KR1Yp16RulwZCh+gipA0Lj2nflnJVM3tULlOsBTfc
         IKK8ZAKSxE+R3UMdSnpn3vbS1eamv7Xvt1UtMhgUXVp/tnL/WfYN2/5yKa296T7oW7Qm
         ltwnYhwzTfJKat5aZvn/JmG0ETPFu8pIBySIkBcCkHhcr3T1xvgR8lvxp4L7j+h03mNx
         vq+A==
X-Gm-Message-State: AOAM532RbWDE1op9hwQBhYbDYqExNUX9/kyk1AsGtY3Ud1sfn1XS1okO
        wucpeW6Sx5ZmDeXuHaPlq0w=
X-Google-Smtp-Source: ABdhPJxWRA8y/2Vty7z1wN5H0YKyPzpEX6KiEi97oYHtSefO+dWzS8tMs9vdQVCIrwEEaiLWsbTO/A==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr9757373wmq.174.1612072454843;
        Sat, 30 Jan 2021 21:54:14 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c9sm20056589wrw.76.2021.01.30.21.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 21:54:14 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: meson: add initial device-tree for ODROID-HC4
Date:   Sun, 31 Jan 2021 05:53:58 +0000
Message-Id: <20210131055358.21293-6-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210131055358.21293-1-christianshewitt@gmail.com>
References: <20210131055358.21293-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODROID-HC4 is a derivative of the C4 with minor differences:

- 16MB XT25F128B SPI-NOR flash
- 2x SATA ports via ASM1061 PCIe to SATA controller
- 7-pin header with SPI and I2C for 1-inch OLED display and RTC
- 1x USB 2.0 host port

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

