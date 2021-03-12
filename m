Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA233967F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhCLS2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhCLS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:28:31 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14EFC061574;
        Fri, 12 Mar 2021 10:28:31 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 81so26718236iou.11;
        Fri, 12 Mar 2021 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWNhe9dJQ3ag2eX70RL00e1AnWi27EMOiKtuadHWJ0Q=;
        b=eUUdDAvpkRkMI+utW0xNpVrfKnM86fWQOsZ6UqS+rsleepMMWr2xH2DK0H5LCx7zDa
         VJHuS6/5WcytSVqZSea6kwa2y5j1cpHDedPkX7X7yc3m95omrwUVbVzp+ufR9/y7jmGZ
         racJ2LqD24CDfKOnnSNwxs60QUqllEUY1sXJnLtFEh8geIOaMkBZWJQbloCrERoLiWUJ
         SafKKCLxOS8kSuVS5Qha0IJ5fZBVskGExo3+eMBynMgXRmLRoLfEHK8Ke1nDqmdm2POG
         Gtt/LeKl9m3Qswr4HCDJRZj62A2R9JNl6pHMPGojg0RU10ORbmjXl09xd5w1f/u7ruZN
         1OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWNhe9dJQ3ag2eX70RL00e1AnWi27EMOiKtuadHWJ0Q=;
        b=eVC9heHIWJuUnuaiz0gRlUQaI4r2eCxQOBwDbbYnWGiQsBAyCqL1PyJopitNzIIte/
         9Gt5vYgME7P9dvkjuW0tnL3bnj3J4fGKQf4qeQR9liEUFNUseJMhmLr7ybfRteaaWSCq
         v2Bw+Sneh7dyhxXlCv1rNVwsSDO6OtqPxdKBcWzGW84KWNiCXPxwY+iUV+rV5G/WLWIC
         uEsplLYbOfpTi7b4juZZdrPv7z517+BD3JQyt+XEe0ZbxHLLyed1bOJsPPkZGCZPo5KQ
         meUpaC4d0AOIZIdj1JeXrboqzs8PrTVN8iLxqra/L9R0TS/6Dqj0y1a8MHSEimOXh28V
         ZULw==
X-Gm-Message-State: AOAM533zfmi6FJF3rd4H/L9VR/+tBjCgdkFYiJJ1So0ep2AdgOSYstJT
        uT1n+SUORS8/lohuAtqZORU=
X-Google-Smtp-Source: ABdhPJwOYD/fFQCZr+WT/V/B/MdaYkVunLyBj7gDq/C87o9IX+iMMS6GvPklm/TBw0m+jZc97xHMCQ==
X-Received: by 2002:a6b:5818:: with SMTP id m24mr409973iob.144.1615573711177;
        Fri, 12 Mar 2021 10:28:31 -0800 (PST)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id c5sm1415362ioi.0.2021.03.12.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:28:30 -0800 (PST)
From:   Tianling Shen <cnsztl@gmail.com>
X-Google-Original-From: Tianling Shen <cnsztl@immortalwrt.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Bauer <mail@david-bauer.net>,
        Tianling Shen <cnsztl@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
Date:   Sat, 13 Mar 2021 02:27:55 +0800
Message-Id: <20210312182755.14018-2-cnsztl@immortalwrt.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312182755.14018-1-cnsztl@immortalwrt.org>
References: <20210312182755.14018-1-cnsztl@immortalwrt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianling Shen <cnsztl@gmail.com>

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
[minor adjustments]
Co-developed-by: Marty Jones <mj8263788@gmail.com>
Signed-off-by: Marty Jones <mj8263788@gmail.com>
[fixed format issues]
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   | 183 ++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 62d3abc17a24..c3e00c0e2db7 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
new file mode 100644
index 000000000000..54183edb8cf1
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -0,0 +1,183 @@
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
+			default-state = "on";
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
+&display_subsystem {
+	status = "disabled";
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

