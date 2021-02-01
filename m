Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1C130B1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhBAVGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBAVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:05:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3789EC06174A;
        Mon,  1 Feb 2021 13:05:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g10so18159880wrx.1;
        Mon, 01 Feb 2021 13:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Bn7PH0wrR7CqoJxTwdalhGxT/l60oUdzQ/t+CWunU0=;
        b=n7pRTEtFU/Na7sXTjNFGQ2i5gcGUB0u2Kb96jSAd8FkI9Y2qCp6vR8u20hmtkf+nC9
         Vln0hZ1Qh5aM7qRcS1rl1jZiLnE6+HcAki7pGud9tFdjslbaU38EbAzI+qNflqWumJYM
         il/TLIiv7cdUF/axEw63efTuotnx6W5mgso61+EvHg4lB9t9EWDD+1pmtfVgKcFsjeMo
         /8Pi/bI33Ba0k3fM6I5cs+SKr22QuGvWJyoj8Zx4gyzHKj+ephLYsvBfgVeiUfcYAk3s
         tspESvB7+iMY82GUmXfNl3crV9krvrRyD6MVHB9pgtnQyyZaZUbsoQhPaJ2i0XrPUacx
         Yubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Bn7PH0wrR7CqoJxTwdalhGxT/l60oUdzQ/t+CWunU0=;
        b=p1d/33Eo8CpcOSruWsvYRK5WoDGMfkiHfMvvUfInQ6sw4RjGWyAhGn/w5Yqs7Qt526
         WVgA4u6F3cnF7RcUnEg0koLGOzB9n0p3a475cNHGi5j+ZZj1JofvUrAmEl98UFGuIWjD
         ms/4Mzv/es5gCF1SAQ2nS0FLGJCCljgeU7kWLCe2WO2cl5MkoWzloOLW+yNIqjCD2oEn
         qZOk9GvKKSqtZV4UKvTty/YNuz2G+3b3jkPG/x2st7vYIzzrI27gwlAJFg8zfHWvcdNA
         p2GA1YZjAYgR8TpHf/t/G9CZD/k9153LSI1A38cc2icOjPKZ1U+L9h1xhlQezXL4YoYL
         KCYw==
X-Gm-Message-State: AOAM531PB5sjDfIenjeHQJM1HEfmoATSBmVF4gJo01KRbHIZmrcBQ59+
        09pNpOKVfD7z+Q4gbhTAqrMQX/l58an9xg==
X-Google-Smtp-Source: ABdhPJwc8+dbopAR0Ydcu9iN3y8Zs0lgf6s5e6mnHNeZc0ULs6zYir/Fy1BH60tvqR4Hkk+sruNduA==
X-Received: by 2002:a05:6000:1245:: with SMTP id j5mr8186726wrx.333.1612213514947;
        Mon, 01 Feb 2021 13:05:14 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 36sm29769846wrj.97.2021.02.01.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:05:14 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: add initial device-tree for Minix NEO U9-H
Date:   Mon,  1 Feb 2021 21:05:08 +0000
Message-Id: <20210201210508.1528-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201210508.1528-1-christianshewitt@gmail.com>
References: <20210201210508.1528-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minix NEO U9-H is based on the Amlogic Q200 reference board with an
S912-H chip and the following specs:

- 2GB DDR3 RAM
- 16GB eMMC
- 10/100/1000 Base-T Ethernet
- AP6356S Wireless (802.11 a/b/g/n/ac, BT 4.1)
- RTC chip
- HDMI 2.1 video
- S/PDIF optical output
- ES8323 audio codec
- Analogue headphone output
- 3x USB 2.0 ports (1x OTG)
- IR receiver
- 1x Power LED (white)
- 1x Power button (rear)
- 1x Update/Reset button (underside)
- 1x micro SD card slot

Tested-by: Wes Bradley <komplex@live.ie>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-gxm-minix-neo-u9h.dts   | 120 ++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index dce41cd3f347..46e67de3d6d2 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-minix-neo-u9h.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dts
new file mode 100644
index 000000000000..a414cd39c2b1
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dts
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "minix,neo-u9h", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Minix Neo U9-H";
+
+	leds {
+		compatible = "gpio-leds";
+
+		white {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			panic-indicator;
+		};
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		button@0 {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+	phy-mode = "rgmii";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_15 */
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ir {
+	linux,rc-map-name = "rc-minix-neo";
+};
+
+&i2c_B {
+	status = "okay";
+	pinctrl-0 = <&i2c_b_pins>;
+	pinctrl-names = "default";
+
+	rtc: rtc@51 {
+		status = "okay";
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		wakeup-source;
+	};
+};
+
+&sd_emmc_a {
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
-- 
2.17.1

