Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7F3526B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhDBGpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDBGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:45:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6BC06178A;
        Thu,  1 Apr 2021 23:45:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v11so3873354wro.7;
        Thu, 01 Apr 2021 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cn/8ILoD5s5Dh5zITptK5TboPaT+aFmsLGpYXHYpaB4=;
        b=lCVwxWYdYrvt5VpIMzpbbsjyJE/IhxzWpoWKLnzRzXFCD1NsLQxrJY4Vi/oSc3nQ3o
         wXETpL+cPaBi9tctu6tnR82Wu3XWyuWeJhrPP/pl6XeqhvP39nzkustBVFd/h9rNK/kV
         L+HNPRFpIHvuz4dQz2zDAuA3nT702/mAxQaXz4LH6Wn/wU+I3j8PeFTgZIMWYlTshLM+
         089x2x6hg9RsVAcDxj2nO0bYhdfFc7yEqDSqKFSJjpy5AeGEPcvz0lC/yBhJJembUCPw
         eqb35g0Q9hOlraS05CPO9vcy+X+7ivxK8EVQmMLNHuhlDSuE44ZHZEIQuYwvoyVWyeKf
         /X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cn/8ILoD5s5Dh5zITptK5TboPaT+aFmsLGpYXHYpaB4=;
        b=UsQqtd8nl+5vZRQBrfqTC0MdVTZw7mWcAL4vIhYeDFYNtkHmeuYJRo8H/GEg2xVtoW
         m1X+VumeI+cdulCYGNiNS2aFKm06aHvvBQIgMR6pWrsgc4Fjis8If2SXGjN9Dh1Ivamh
         VfzLUW2s1xg2mjVeCHipDo/gAUrWmoY8EkjaaCrCqQTQU0nwoj9evjYfrPi73pJB14ba
         Q1S3uhStqYz7alRfqtA6LT10Gprvn927GMCQOvqARz2vNO47boJKAL8byLr/4g39MBnC
         qK3qoKxFXqrC3U1nlERmMEOoenlwRHoNQCvcgOek5kmZjMLruX4nLGFekBa7uGUSFyXq
         xtfw==
X-Gm-Message-State: AOAM530sXL8mfwx10iwEefie4NtgBDQfrt7nBVpR/BaBl/UpR66pJ+0c
        otdPqC3j9u9H7W1am9qrdqs=
X-Google-Smtp-Source: ABdhPJzgo8cjX9IrWv3F8dhDtPbpi+1KVYJgtPO4Gga6YL7fp1SggBziC6OQA4O50jQABuaMOs8J5A==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr13840800wrs.229.1617345931798;
        Thu, 01 Apr 2021 23:45:31 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m17sm13627131wrx.92.2021.04.01.23.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 23:45:31 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: add initial device-tree for MeCool KIII Pro
Date:   Fri,  2 Apr 2021 06:45:21 +0000
Message-Id: <20210402064521.30579-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064521.30579-1-christianshewitt@gmail.com>
References: <20210402064521.30579-1-christianshewitt@gmail.com>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

