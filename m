Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7234D447
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhC2PsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhC2PsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:48:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61AAC061574;
        Mon, 29 Mar 2021 08:48:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so13362957wrc.3;
        Mon, 29 Mar 2021 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f6jb3HpQvHBT9+AQJCHaKcgG4jn5W/0ADPaJiHCDtrc=;
        b=Je+++jIk+IVT0VRtz2acicor2wJeRnaQGOVPo7T3dbwCVFCYqEoUAdxHM21s1vcYEa
         bYUxxNAzHETRANXKZJkUgqQr2Jrv0f8AIzG+ucQRGgVUfLS5cMti+D1GtNVa8rpuCAk1
         l3799f5jBHfX5eseXcPyf3OHusf7RflZS9Bq0V3VdsOizZiF57o3NMxqWUqJLd3VQM6c
         aT/PE8SKbAc2fHjO4P2thAlAEoRlLGaUVf6JEhgs/8kmat+4tpRA4kgHyW/EwE3Ccx6N
         KfK8w6ulBRwfAnub4hYBCgR/N4oz7f9x8NORtBoHzoUiAoMCN4Pl2GugLXiL9SSBeDGH
         FoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f6jb3HpQvHBT9+AQJCHaKcgG4jn5W/0ADPaJiHCDtrc=;
        b=KZaBm6Nv+AgIqgyknOpUf+F+yeEQ0/1zWP+yeVgNMJ3SW0aASaDy4o+h5VkbXe7Vxf
         bS/xhmLIkFKSsebTfbsooRsCBJXMI06NABasouiQkHOWOg+yagAqoYeznngu3kbqVsDr
         iEKJ6FqucpVv9sWQ2DrFqUUQOYK8SEBxkdkC4xmjVp95Mxf0PcrOjtjMCI0w2UNQKF4H
         aGrtC4TFHeDFZJJwvnhHLYyMQgIVVe2tLLk/sAAPBWTJO0BMhxFIly+728RHDtVoewxo
         erDQ1SEuuVrK1g2wW6YJGCAuLWfufiOiRIXE05f6m2MCPKI4I95J+RrwRvbPHdDPW+rk
         YxAQ==
X-Gm-Message-State: AOAM531iJaR3eAHzwNH8GW+EX0T+XkWi8Wc0pJqKl6bF0DTyecE+BZSP
        x6quqRnvWZe015sZWQdgggM=
X-Google-Smtp-Source: ABdhPJxY18dR3uFMhn9ZZy2RWX586iqntUwgCdRnctmfKhusbZ0sdn1j+Aalj7f73TXaVo17BCSi0g==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr29094382wrw.328.1617032883378;
        Mon, 29 Mar 2021 08:48:03 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b131sm24987323wmb.34.2021.03.29.08.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:48:03 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Drazen Spio <drazsp@gmail.com>
Subject: [PATCH 3/3] arm64: dts: meson: add initial device-tree for MeCool KIII Pro
Date:   Mon, 29 Mar 2021 15:47:53 +0000
Message-Id: <20210329154753.30074-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329154753.30074-1-christianshewitt@gmail.com>
References: <20210329154753.30074-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MeCool (Videostrong) KIII Pro is based on the Amlogic Q200 reference
board with an S912 chip and the following specs:

- 3GB DDR3 RAM
- 16GB eMMC
- 10/100/1000 Base-T Ethernet
- BCM4335 Wireless (802.11 b/g/n/ac, BT 4.0)
- DVB-C/T/T2/S/S2 (AVL6862TA demod + R912 tuner)
- HDMI 2.0a video
- S/PDIF optical output
- CVBS/Analogue output
- 4x USB 2.0 ports
- IR receiver
- 1x Power button (with integrated blue LED)
- 1x Update/Reset button (underside)
- 1x micro SD card slot

Tested-by: Drazen Spio <drazsp@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-gxm-mecool-kiii-pro.dts | 113 ++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index f8f515c93055..a58ccecfcb55 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-minix-neo-u9h.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dts
new file mode 100644
index 000000000000..0651756d7fb5
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dts
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/*
+ * Author: Christian Hewitt <christianshewitt@gmail.com>
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
+	compatible = "videostrong,gxm-kiii-pro", "amlogic,s912", "amlogic,meson-gxm";
+	model = "MeCool KIII Pro";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0xC0000000>;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Update";
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
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			panic-indicator;
+		};
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&external_phy>;
+
+	amlogic,tx-delay-ns = <2>;
+
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
+	linux,rc-map-name = "rc-mecool-kiii-pro";
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

