Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EDC3E1EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhHEW27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbhHEW2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:28:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76201C0617A2;
        Thu,  5 Aug 2021 15:28:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so13165852pjb.2;
        Thu, 05 Aug 2021 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHv9Z6X5hPUNyFnl0cBikCh2bIwfmM7wAKv/qs4AZk8=;
        b=XcSPJDPQyHkluikv1DfAIHIopKL/8WCTWndEqyBsI2obrrvS5XmrSZHNo8h+0zBNt/
         LF7JP86+VFKSjlUsQrnEvZNhgCKJpr4//E8qMt7SFz7Klpcz8EeAVr5Bh1ojsUZHRSa2
         dlsAp+ZVV1C4UW97T5avOXLTYVCtvWm7R2q6ZohYzr8tedp6VF55FhvBRbULeHIc+5uO
         ZbOmurhL7rkjq/36TLUFCq7qBz69rBj4va5Sl8Ksymu5lnqsZpJLntVCb1NtCc8vz3MF
         X+JByRGCW6bG+1QaYYOSOyOGVTpoeFc3ezEaoX+bSMzOYQJqTSa+95QFtOexERWjbXlN
         QGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mHv9Z6X5hPUNyFnl0cBikCh2bIwfmM7wAKv/qs4AZk8=;
        b=hoy2SbbtmZUv2C9vsm2vhtfIuRGesagtrOd1NwX3tgYKa/6R50gmtAvNfc0Yi1cjGc
         QRs9mpyDuDbCZvYe/2SEqUYvpMdY5t67EdIf53Loi7nNiNw4kJfeUptm5wXOZVZxCPdv
         kSz43jU8WUQfWtKJwTClSWpY2Yd6S3V6LxIuvoUL3LQFE8a6pH9lSOSxOPJA34uCYdZQ
         AyzPh6Mlv7z+WCQiwvNpMQheFxYBLEgMWMwrqi+vBrcNuCyPyJrOESPpvBuzvohJGKkN
         8BpazlqQLY1NJ52h+5qpozsgiycUi+dKpdvKeMn6E06dUvISRJGLzhHiNWaCsBy45rI/
         wbww==
X-Gm-Message-State: AOAM531ohaErdCvF3kH2CujdL6g4EEAWNLidDA2vpFqRTOtgOvMpJ3es
        uRiXtlIeoKK2wgg3rnCa3W0UDl08wDc1bElqbgw=
X-Google-Smtp-Source: ABdhPJxZ5c5vp+QzG6+QEptFhR8Vy6gQ7lohKCJuIjKLe0Cc60gFGAD+n26P7st10DMpsMtlxIlCTQ==
X-Received: by 2002:a17:90a:d190:: with SMTP id fu16mr17848636pjb.157.1628202513947;
        Thu, 05 Aug 2021 15:28:33 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b26sm8082292pfo.47.2021.08.05.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:28:33 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper (AST2600) BMC
Date:   Thu,  5 Aug 2021 15:28:16 -0700
Message-Id: <20210805222818.8391-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add initial version of device tree for Facebook Cloudripper (AST2600) BMC.

Cloudripper is Facebook's next generation switch platform with an AST2600
BMC integrated for health monitoring purpose.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - added more notes about the new platform in patch description.
  - "spi1" was removed as the driver is not ready.
  - "mac3" properties were updated with pinctrl, and etc.

 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-cloudripper.dts   | 539 ++++++++++++++++++
 2 files changed, 540 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 90aed2c2959a..74c760038f28 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1409,6 +1409,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
+	aspeed-bmc-facebook-cloudripper.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
new file mode 100644
index 000000000000..01ec3ce0a29d
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "ast2600-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Cloudripper BMC";
+	compatible = "facebook,cloudripper-bmc", "aspeed,ast2600";
+
+	aliases {
+		/*
+		 * PCA9548 (1-0070) provides 8 channels connecting to
+		 * SMB (Switch Main Board).
+		 */
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+
+		/*
+		 * PCA9548 (2-0070) provides 8 channels connecting to
+		 * SCM (System Controller Module).
+		 */
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+
+		/*
+		 * PCA9548 (3-0070) provides 8 channels connecting to
+		 * SMB (Switch Main Board).
+		 */
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
+		i2c38 = &imux38;
+		i2c39 = &imux39;
+
+		/*
+		 * PCA9548 (8-0070) provides 8 channels connecting to
+		 * PDB (Power Delivery Board).
+		 */
+		i2c40 = &imux40;
+		i2c41 = &imux41;
+		i2c42 = &imux42;
+		i2c43 = &imux43;
+		i2c44 = &imux44;
+		i2c45 = &imux45;
+		i2c46 = &imux46;
+		i2c47 = &imux47;
+
+		/*
+		 * PCA9548 (15-0076) provides 8 channels connecting to
+		 * FCM (Fan Controller Module).
+		 */
+		i2c48 = &imux48;
+		i2c49 = &imux49;
+		i2c50 = &imux50;
+		i2c51 = &imux51;
+		i2c52 = &imux52;
+		i2c53 = &imux53;
+		i2c54 = &imux54;
+		i2c55 = &imux55;
+	};
+
+	spi_gpio: spi-gpio {
+		num-chipselects = <2>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
+			   <&gpio0 ASPEED_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
+
+		eeprom@1 {
+			compatible = "atmel,at93c46d";
+			spi-max-frequency = <250000>;
+			data-size = <16>;
+			spi-cs-high;
+			reg = <1>;
+		};
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mdio1 {
+	status = "okay";
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy1: ethernet-phy@13 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0d>;
+	};
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+&i2c0 {
+	multi-master;
+	bus-frequency = <1000000>;
+};
+
+&i2c1 {
+	/*
+	 * PCA9548 (1-0070) provides 8 channels connecting to SMB (Switch
+	 * Main Board).
+	 */
+	i2c-switch@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux20: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux21: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux22: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux23: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c2 {
+	/*
+	 * PCA9548 (2-0070) provides 8 channels connecting to SCM (System
+	 * Controller Module).
+	 */
+	i2c-switch@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux28: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux29: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux30: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux31: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c3 {
+	/*
+	 * PCA9548 (3-0070) provides 8 channels connecting to SMB (Switch
+	 * Main Board).
+	 */
+	i2c-switch@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux34: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux35: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux36: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux37: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux38: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux39: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c6 {
+	lp5012@14 {
+		compatible = "ti,lp5012";
+		reg = <0x14>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		multi-led@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			color = <LED_COLOR_ID_MULTI>;
+			function = LED_FUNCTION_ACTIVITY;
+			label = "sys";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+		};
+
+		multi-led@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			color = <LED_COLOR_ID_MULTI>;
+			function = LED_FUNCTION_ACTIVITY;
+			label = "fan";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+		};
+
+		multi-led@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			color = <LED_COLOR_ID_MULTI>;
+			function = LED_FUNCTION_ACTIVITY;
+			label = "psu";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+		};
+
+		multi-led@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			color = <LED_COLOR_ID_MULTI>;
+			function = LED_FUNCTION_ACTIVITY;
+			label = "scm";
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+		};
+	};
+};
+
+&i2c8 {
+	/*
+	 * PCA9548 (8-0070) provides 8 channels connecting to PDB (Power
+	 * Delivery Board).
+	 */
+	i2c-switch@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux40: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux41: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux42: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux43: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux44: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux45: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux46: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux47: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
+	};
+};
+
+&i2c15 {
+	/*
+	 * PCA9548 (15-0076) provides 8 channels connecting to FCM (Fan
+	 * Controller Module).
+	 */
+	i2c-switch@76 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x76>;
+		i2c-mux-idle-disconnect;
+
+		imux48: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux49: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux50: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux51: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux52: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux53: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux54: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux55: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
-- 
2.17.1

