Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0C3526B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhDBGpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhDBGpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:45:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA64C0613E6;
        Thu,  1 Apr 2021 23:45:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso3875953wmi.3;
        Thu, 01 Apr 2021 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IXrsfM/bzMtfG8sk9rGtjCWcXsrIlDFcIC5xqhsxNUQ=;
        b=XXWDfPnhi5QTmEkyP9dgE7t253bfQKkETi44apcA0dbFdDCqShlDFMB2MFuvXIGhDl
         1pVie3m9RznqEMSqNj1YvBhOgsYv8Dcw0al72AubcvqAk+hnTud+AZswi4y4w3U3Nkcd
         CXYb86hR38UD7pdOe+Uay3T6XmJ0RAuUGgSvccmH7KW1dvm7up2cs+4nRjRkzlr02Osd
         m6Rgh6enO9YloqXvUIjzGUUndMrwiOx08pgvIF4yiai8CD2XhalcnnYPNrtqV0nXFbFD
         iG9ZbO+Pjt7CXQ/WingDcSwYVgN2RtfFjyKfd7Wvo99Lf/4rhICNy3STJqpHUCSo+LKd
         Xlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IXrsfM/bzMtfG8sk9rGtjCWcXsrIlDFcIC5xqhsxNUQ=;
        b=UuNq4tY5zbiZfIlso/ng2ieuyNGWdAO79awJ4cReG165NTrdHGs11plUMqsP8dl7PM
         WhFtG1L1l2+Ef0W8iN2Os5YcUBlgcMRbIFc0AjgqDGJCPiQ/ePfPRurT0PTzgur0i59T
         +RErATo0CXcLEzWQKqSB/Q8uEmciXmCE2hiQ11eBF9DlDOLN54jPzgiTsiMnmPZE/d1A
         SW09K4MVS4Mc2ThjNtw4Wy1g0XZmXZVxOZIHQNKQTNQ6WnauRD/ZnR5iUzZSB4VykF2H
         HvdQ+63FgQC66fLx4UZVyvcpwFPq7hPhiA3ZFpd9Xs1QMtq7iX2lu6tpa79nIE+QexIG
         NJ3Q==
X-Gm-Message-State: AOAM530TY6sv9uAV6HFR8DnmHnrxrHQ+x//POKzFsxsGiAF+yW9PnwXY
        fxxKbVF1q4lyjCpFpkxJ+LrokjAHiXM=
X-Google-Smtp-Source: ABdhPJw7QRHWHHVnYtQ9i82pbjvzX4UeYRh1S9npADu4fuBzoegfyDWvLO3aAc8sPtpGkCE/49QH9w==
X-Received: by 2002:a7b:c24f:: with SMTP id b15mr11202016wmj.59.1617345929937;
        Thu, 01 Apr 2021 23:45:29 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m17sm13627131wrx.92.2021.04.01.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 23:45:29 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: meson: add initial device-tree for MeCool KII Pro
Date:   Fri,  2 Apr 2021 06:45:20 +0000
Message-Id: <20210402064521.30579-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064521.30579-1-christianshewitt@gmail.com>
References: <20210402064521.30579-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MeCool (Videostrong) KII Pro is based on the Amlogic P230 reference
board with an S905D chip and the following specs:

- 2GB DDR3 RAM
- 16GB eMMC
- 10/100 Base-T Ethernet
- BCM4335 Wireless (802.11 b/g/n/ac, BT 4.0)
- DVB-C/T/T2/S/S2 (AVL6862TA demod + R848 tuner)
- HDMI 2.0a video
- S/PDIF optical output
- CVBS/Analogue output
- 4x USB 2.0 ports
- IR receiver
- 1x Power button (with integrated blue LED)
- 1x micro SD card slot

Tested-by: Drazen Spio <drazsp@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../meson-gxl-s905d-mecool-kii-pro.dts        | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index aebd49c88719..f8f515c93055 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-mecool-kii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts
new file mode 100644
index 000000000000..5ab5d3aa0646
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dts
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/*
+ * Author: Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905d.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "videostrong,gxl-kii-pro", "amlogic,s905d", "amlogic,meson-gxl";
+	model = "MeCool KII Pro";
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
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+};
+
+&ir {
+	linux,rc-map-name = "rc-mecool-kii-pro";
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

