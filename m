Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100533E3084
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbhHFUp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245146AbhHFUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:45:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63991C0613CF;
        Fri,  6 Aug 2021 13:45:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso6949954wmp.1;
        Fri, 06 Aug 2021 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7bYcfTOZDcpH82FxHaeIsdSguONpuaB31Nv9U1ySCU=;
        b=I1JyJ3Ttyq6+1dtizwBqjPfnWC3n0L/uC+AiHThuqHh4g7OQx05ebfAmlMLfMnk0XZ
         F9GXgGeZITtrI3FP0lj8fSTXfLwMm3HyXfR8FqTZRhVMUyu8w9V/KvbXWLLo5JLJwJcG
         6aU31rDrvWjuFwnCZ1KpB4LLzk/BgOc5Fc2i/zpuCgoY7idDSj6Ni9x7mV+sT+83jpxt
         PwPZR8KIJciDvb++A5aEiVgycgPRnSv6zIjBpF49O/DA3F6Tbe8AO0ZgOki8jdSiOZFB
         1CD+GVJnMXHmsVwWlYPhQpZZ17t39G+vWwmfRshOQ0vO+KUlqQlT554AmF+cTdDQRU8n
         +MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7bYcfTOZDcpH82FxHaeIsdSguONpuaB31Nv9U1ySCU=;
        b=cmJr2AIUl9eDtjApf3ZzdHmnQzQGFdQKh6AX+OVDi6j6Mp1zlQjvt/QvTViwrtyqnV
         QTB6qc2nlsWYS3CzpEKqpOaufdX7vCVEctGGLoTXFPonrXxADtofLU410CUFmYuIDXgb
         lcnhAX3t78MFbEmanjzXaBU6peQKU1VgV6qW3QuIsAvhAVTuTfP0iCnfvtsYSLQzWsCD
         sLhQti6SyeBVlwzih5IVPMvmuHJoJbhiXU9c3Bv1HM2lwqOxsL3BajLL5gQxk7lLzTbC
         HtTHu0avoJ9a4zZiFVvEEFawG2coHNsSLAKTu9KdLj1KtCnASy6ZJJC7x+bUQ3dcI1JN
         OsQw==
X-Gm-Message-State: AOAM531ZUedY63cbXzmj+c50/TUj63yBb6EUr+wzuRdRAnVaYr7ZdpbK
        rUbsM4IHBxwu9pF3Ot9MsCs=
X-Google-Smtp-Source: ABdhPJyQPWALHgmtTsFTWvfNHemx0dQt+3Kb31xkmV0b5Sv9eSy3fYYN6HHjb8/r4SKrFcOw7VvYFw==
X-Received: by 2002:a1c:2984:: with SMTP id p126mr5065274wmp.58.1628282737988;
        Fri, 06 Aug 2021 13:45:37 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id y66sm9711543wmy.39.2021.08.06.13.45.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 06 Aug 2021 13:45:37 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/5] ARM: dts: NSP: Add DT files for Meraki MX65 series
Date:   Fri,  6 Aug 2021 21:44:35 +0100
Message-Id: <20210806204446.2981299-5-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210806204446.2981299-1-mnhagan88@gmail.com>
References: <20210806204446.2981299-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MX65 & MX65W Hardware info:
  - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
  - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
  - Storage: 1 GB (Micron MT29F8G08ABACA)
  - Networking: BCM58625 switch (2x 1GbE ports)
    2x Qualcomm QCA8337 switches (10x 1GbE ports total)
  - PSE: Broadcom BCM59111KMLG connected to LAN ports 11 & 12
  - USB: 1x USB2.0
  - Serial: Internal header
  - WLAN(MX65W Only): 2x Broadcom BCM43520KMLG on the PCI bus.

Note that a driver and firmware image for the BCM59111 PSE has been
released under GPL, but this is not present in the kernel.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 279 ++++++++++++++++++
 arch/arm/boot/dts/bcm958625-meraki-mx65.dts   |  24 ++
 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts  |  32 ++
 4 files changed, 337 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx65w.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 17f7bdab50ef..3586b540e3b6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -159,6 +159,8 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
 	bcm958625-meraki-mx64-a0.dtb \
 	bcm958625-meraki-mx64w.dtb \
 	bcm958625-meraki-mx64w-a0.dtb \
+	bcm958625-meraki-mx65.dtb \
+	bcm958625-meraki-mx65w.dtb \
 	bcm958625hr.dtb \
 	bcm988312hr.dtb \
 	bcm958625k.dtb
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
new file mode 100644
index 000000000000..8860f2fefc63
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX65 series (Alamo).
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm958625-meraki-mx6x-common.dtsi"
+
+/ {
+	keys {
+		compatible = "gpio-keys-polled";
+		autorepeat;
+		poll-interval = <20>;
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpioa 8 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			/* green:wan1-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 25 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			/* green:wan1-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 24 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			/* green:wan2-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 27 GPIO_ACTIVE_LOW>;
+		};
+
+		led-3 {
+			/* green:wan2-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <3>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 26 GPIO_ACTIVE_LOW>;
+		};
+
+		led-4 {
+			/* amber:power */
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_AMBER>;
+			gpios = <&gpioa 3 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		led-5 {
+			/* white:status */
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpioa 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	mdio-mii-mux {
+		compatible = "mdio-mux-mmioreg";
+		reg = <0x1803f1c0 0x4>;
+		mux-mask = <0x2000>;
+		mdio-parent-bus = <&mdio_ext>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio@0 {
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy_port6: phy@0 {
+				reg = <0>;
+			};
+
+			phy_port7: phy@1 {
+				reg = <1>;
+			};
+
+			phy_port8: phy@2 {
+				reg = <2>;
+			};
+
+			phy_port9: phy@3 {
+				reg = <3>;
+			};
+
+			phy_port10: phy@4 {
+				reg = <4>;
+			};
+
+			switch@10 {
+				compatible = "qca,qca8337";
+				reg = <0x10>;
+				dsa,member = <1 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						ethernet = <&sgmii1>;
+						phy-mode = "sgmii";
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan8";
+						phy-handle = <&phy_port6>;
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan9";
+						phy-handle = <&phy_port7>;
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan10";
+						phy-handle = <&phy_port8>;
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan11";
+						phy-handle = <&phy_port9>;
+					};
+
+					port@5 {
+						reg = <5>;
+						label = "lan12";
+						phy-handle = <&phy_port10>;
+					};
+				};
+			};
+		};
+
+		mdio-mii@2000 {
+			reg = <0x2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy_port1: phy@0 {
+				reg = <0>;
+			};
+
+			phy_port2: phy@1 {
+				reg = <1>;
+			};
+
+			phy_port3: phy@2 {
+				reg = <2>;
+			};
+
+			phy_port4: phy@3 {
+				reg = <3>;
+			};
+
+			phy_port5: phy@4 {
+				reg = <4>;
+			};
+
+			switch@10 {
+				compatible = "qca,qca8337";
+				reg = <0x10>;
+				dsa,member = <2 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					port@0 {
+						reg = <0>;
+						ethernet = <&sgmii0>;
+						phy-mode = "sgmii";
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan3";
+						phy-handle = <&phy_port1>;
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan4";
+						phy-handle = <&phy_port2>;
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan5";
+						phy-handle = <&phy_port3>;
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan6";
+						phy-handle = <&phy_port4>;
+					};
+
+					port@5 {
+						reg = <5>;
+						label = "lan7";
+						phy-handle = <&phy_port5>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&srab {
+	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
+	status = "okay";
+	dsa,member = <0 0>;
+
+	ports {
+		port@0 {
+			label = "wan1";
+			reg = <0>;
+		};
+
+		port@1 {
+			label = "wan2";
+			reg = <1>;
+		};
+
+		sgmii0: port@4 {
+			label = "sw0";
+			reg = <4>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		sgmii1: port@5 {
+			label = "sw1";
+			reg = <5>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		port@8 {
+			ethernet = <&amac2>;
+			reg = <8>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65.dts b/arch/arm/boot/dts/bcm958625-meraki-mx65.dts
new file mode 100644
index 000000000000..d1b684dcdbfa
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx65.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX65.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-alamo.dtsi"
+
+/ {
+	model = "Cisco Meraki MX65";
+	compatible = "meraki,mx65", "brcm,bcm58625", "brcm,nsp";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts b/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
new file mode 100644
index 000000000000..a2165aba3676
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx65w.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX65W.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-alamo.dtsi"
+
+/ {
+	model = "Cisco Meraki MX65W";
+	compatible = "meraki,mx65w", "brcm,bcm58625", "brcm,nsp";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
-- 
2.26.3

