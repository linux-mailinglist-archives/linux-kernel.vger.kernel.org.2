Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB08431409C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhBHUhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbhBHTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:17:56 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B03C06178B;
        Mon,  8 Feb 2021 11:17:15 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m17so5656415ioy.4;
        Mon, 08 Feb 2021 11:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIfE0BvfZVoAYmQCo3XOHdikwlOFZuMhWiFKWJRteT8=;
        b=Dhkabv8gRujAjQQwbnPhYXUUwDTw49eRqi+idVaJiHtPJzXgwYkZGR5Cvp3/wpkXqD
         ASH9c3pArDrz71VR6dtqLdiIk1t9U4wiM7oEO3w//22NfFCZMvT1k3UEW1/dfdtw5Nr/
         DnQBWwqzqtC7OCyMCp10Ll4AvMmPIisUC/fFU37vMRn7s+0ApgQzq+xc2cHJ9vhMSbWP
         0YX7dqEe7NI6E/gXsIaLfkEjaXzpXIKIFhEAl2+OUwltMwxXxQk7ZUl2YBp+7b3800CF
         6pQQRdLhhMgrTO2kLpMQrtoNujbtocLQMxwXT2PMB9tdwylWe6Puku66rQ3EFFgqUBiv
         3Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIfE0BvfZVoAYmQCo3XOHdikwlOFZuMhWiFKWJRteT8=;
        b=kAyRgzQZ6YA+yo9xZn1ADzrxPJUT6f9rS7MH0ODiKnFBD9um7xLeMjIEV56mj+zkZo
         0BUOQJCu+jQLRmiXMWdTpIaQWkzJrWfxZg/FVDRo9no2txKL0M41E4Eg2or236hbm54+
         pWlhsiDeI3cooWmyxY4xHi7yFym6De8xZ6E/+kJo/jI51I9/2RlPNbxuxNADka9XONcp
         PvNh3cEH9Rlp333c+czPA77q/K9EDNmCPsInBpTsB6BCm/gpgFX8qMSPDLb8sgIft9SU
         WbhHLONTaODmfLajWDfTcR7WyYYwuBusmjRDkxkh7/GEE4E0jOIV0HSAK4PFa78jRKgw
         GHDg==
X-Gm-Message-State: AOAM533GJAHkV2psdlDSsBl6Bb8jWZ2+3M6cAibSi0oHAEi7FCagOPRx
        v0K1zZ9eLmTsbTw7AYp7Vp0=
X-Google-Smtp-Source: ABdhPJzcv3bu3rRvywoNUS3tEyeCyDw4dCK3m0+rTpK/hwjjR7jMnq9bQXs9ZGRei0DRr0ImEgiDSg==
X-Received: by 2002:a6b:b70f:: with SMTP id h15mr3269388iof.172.1612811835481;
        Mon, 08 Feb 2021 11:17:15 -0800 (PST)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id j25sm9429645iog.27.2021.02.08.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:17:14 -0800 (PST)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        David Bauer <mail@david-bauer.net>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
Date:   Tue,  9 Feb 2021 03:16:46 +0800
Message-Id: <20210208191646.6511-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210208191646.6511-1-cnsztl@gmail.com>
References: <20210208191646.6511-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the NanoPi R4S from FriendlyArm.

Rockchip RK3399 SoC
1GB DDR3 or 4GB LPDDR4 RAM
Gigabit Ethernet (WAN)
Gigabit Ethernet (PCIe) (LAN)
USB 3.0 Port x 2
MicroSD slot
Reset button
WAN - LAN - SYS LED

[initial DTS file]
Co-developed-by: Jensen Huang <jensenhuang@friendlyarm.com>
Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
Co-developed-by: Marty Jones <mj8263788@gmail.com>
Signed-off-by: Marty Jones <mj8263788@gmail.com>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   | 178 ++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1ab55a124a87..eb2e13532012 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-leez-p710.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
new file mode 100644
index 000000000000..b8e8d03eee0a
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * FriendlyElec NanoPC-T4 board device tree source
+ *
+ * Copyright (c) 2020 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2018 Collabora Ltd.
+ *
+ * Copyright (c) 2020 Jensen Huang <jensenhuang@friendlyarm.com>
+ * Copyright (c) 2020 Marty Jones <mj8263788@gmail.com>
+ * Copyright (c) 2021 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3399-nanopi4.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPi R4S";
+	compatible = "friendlyarm,nanopi-r4s", "rockchip,rk3399";
+
+	/delete-node/ gpio-leds;
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
+		pinctrl-names = "default";
+
+		lan_led: led-0 {
+			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
+			label = "nanopi-r4s:green:lan";
+		};
+
+		sys_led: led-1 {
+			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
+			label = "nanopi-r4s:red:sys";
+		};
+
+		wan_led: led-2 {
+			gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
+			label = "nanopi-r4s:green:wan";
+		};
+	};
+
+	/delete-node/ gpio-keys;
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reset_button_pin>;
+
+		reset {
+			debounce-interval = <50>;
+			gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	vdd_5v: vdd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		/*
+		 * With 20KHz PWM and an EVERCOOL EC4007H12SA fan, these levels
+		 * work out to 0, ~1200, ~3000, and 5000RPM respectively.
+		 */
+		cooling-levels = <0 12 18 255>;
+		#cooling-cells = <2>;
+		fan-supply = <&vdd_5v>;
+		pwms = <&pwm1 0 50000 0>;
+	};
+};
+
+&cpu_thermal {
+	trips {
+		cpu_warm: cpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_hot: cpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map2 {
+			trip = <&cpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map3 {
+			trip = <&cpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&emmc_phy {
+	status = "disabled";
+};
+
+&fusb0 {
+	status = "disabled";
+};
+
+&pcie0 {
+	max-link-speed = <1>;
+	num-lanes = <1>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+
+	pcie@0 {
+		reg = <0x00000000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+};
+
+&pinctrl {
+	/delete-node/ gpio-leds;
+	gpio-leds {
+		lan_led_pin: lan-led-pin {
+			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		sys_led_pin: sys-led-pin {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led_pin: wan-led-pin {
+			rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	/delete-node/ rockchip-key;
+	rockchip-key {
+		reset_button_pin: reset-button-pin {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sdhci {
+	status = "disabled";
+};
+
+&sdio0 {
+	status = "disabled";
+};
+
+&sdmmc {
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+};
+
+&u2phy0_host {
+	phy-supply = <&vdd_5v>;
+};
+
+&u2phy1_host {
+	status = "disabled";
+};
+
+&usbdrd_dwc3_0 {
+	dr_mode = "host";
+};
+
+&vcc3v3_sys {
+	vin-supply = <&vcc5v0_sys>;
+};
-- 
2.17.1

