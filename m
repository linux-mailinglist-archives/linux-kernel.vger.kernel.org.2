Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4334D446
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhC2PsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhC2PsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:48:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DAFC061574;
        Mon, 29 Mar 2021 08:48:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so6923164wmj.1;
        Mon, 29 Mar 2021 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8vTax4vGXeJlAusGjSxRFk/xedDbUBF4fuZSgptJcQ=;
        b=kNr8ermtOiF4nGD8VNP4DuvshX/MfsZ8hdtAs1s6WkDNABc6E9/jgz51a9vtWaf8Of
         nsG5CLAXi0eLqwc9tEzm26HGyRciIrMkH0Jvpoyte5MEDm/nTYqB0Gm0VeDZomr2uEH2
         yRegWMH0eZNfHi7U7xqRExDUfh/1EKSyU5vhmbtks9eB9TZCULig/Pjcb0MZRpHqz+4U
         1c1ETxNPuB3sk+NmC5aGQ+UbLF6HR3zwY9ltDLCyToeuMWEP4p9v4QjfA5S3gzqqwwnC
         LV+nu+eFztl4tXcp/T5TyoyXU3KFu4YyK+MXOjKpE3FjLIbpk9n+ourADjmEYmkjr3fk
         MnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8vTax4vGXeJlAusGjSxRFk/xedDbUBF4fuZSgptJcQ=;
        b=snmBo3qPnHPJkbr+VAygphuZuFaJIZr2KWU7ZJU2g6tje6+DEtTgRks9QSIrkCa0Vn
         UT3i/lzJbOM4xEiptWY9xHtkDzXaNNlJyKWfMsgrbugIYYS3nFkSdL/aisbSj/JmfiV+
         J5ELG1bRSE8R6A9pRvRFXKKJK+lOfEiH96yqzIxJxY/7wLy7tFUBdiOJE8QY68ZrRZ3V
         4LdxsqlwpIg1VlhAoNl0P2aovxECsWk89aIeWJ5/pBK/GFAlhf6Pz4spL5mKrjQ/LhC/
         08763X3T3r+XiVFzbxIjli5Qen4MTwy6D4zk7UcZaUUe4Hk8Eq2E4NvTtMLQLdlr6MUz
         Eufg==
X-Gm-Message-State: AOAM532Ysp3gXFWYERMsLUw9p2vV8jc0dx61UONNO3ha1EjjKA1R9Wa3
        CC6fBzxGQnz0w5UkKnUj2mc=
X-Google-Smtp-Source: ABdhPJxgPl9jPEbxeqm5eA964ZOa53TtaZwTejokGHmpP789ucLwIFiBOgMeWj/LULFaBLhGFh+LoA==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr17645918wmc.92.1617032881387;
        Mon, 29 Mar 2021 08:48:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b131sm24987323wmb.34.2021.03.29.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:48:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Drazen Spio <drazsp@gmail.com>
Subject: [PATCH 2/3] arm64: dts: meson: add initial device-tree for MeCool KII Pro
Date:   Mon, 29 Mar 2021 15:47:52 +0000
Message-Id: <20210329154753.30074-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329154753.30074-1-christianshewitt@gmail.com>
References: <20210329154753.30074-1-christianshewitt@gmail.com>
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

