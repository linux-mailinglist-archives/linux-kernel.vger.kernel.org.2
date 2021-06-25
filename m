Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55203B40E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhFYJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhFYJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:53:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96367C061574;
        Fri, 25 Jun 2021 02:50:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e22so9921649wrc.1;
        Fri, 25 Jun 2021 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZO5u/6pDWKzzSomryd0rz22fToGF/wQIJsnLa3t0o4=;
        b=axXF/PYmPO0Ih8yvRD8gnf4EH3KvVxaWhS0CSOtHcoonNpwwz63DFzBA+hGCMszgFB
         lKg3t7kTTauE+V73SYhguwZhAOD/YMOU2KBoSv0ZSA4Ia5iMChDENPjM0ILh9/vOWo0n
         OKOy/2Md+DM5SYQ2RI6EF5CPa70NcweR05f5N5DT4cHwpfyNQtRI0AFOH5Md+MaHIW6s
         gHrWVZ/0zhFlRmDtJzp2Jk65nXm2hMV8vBjypas70gmAm97I1VJBF5mXqtI/Sx7BiMlr
         +oHkUXmM+0jJiQzFpSLO2MDoCLEtlvQOOiR8Zkfda2iSdC5bRbMI4lhRXm4qnL98s+YS
         AWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZO5u/6pDWKzzSomryd0rz22fToGF/wQIJsnLa3t0o4=;
        b=IYGasDyQV+msgy/7970dZ1AgvZY7CJcWh7rMm6DEPV3vFdB0X1e8QVCUvOR7fauGds
         cGu+37t1pDCM+2LPAyiQgJHuluQX8LIo5bKheIVyaQSAd/S4hgahIwnsS/H96r5ePLLL
         doSOq0WRFEdmGQo5iCjfD9RGtNdHwahL8syuCDd5FO/JwYeTzAzVgcgQjg0l07JE6hvC
         bnn1qcNBFgt6jZ+9643Un5yIESmtJmMPFReCWFk5DzvWEUYiRTk5ErZMhlz4/P6t0aGA
         z/EFJR4X5okwPtNYW9OteUI7xiGso/V/RujH+boCTYtJAGGtCOgSROC2KnZ7HKgfXO2P
         xBAg==
X-Gm-Message-State: AOAM5335SW6GAc3i+TtwkY2THWdUd6EQb5VOSQXVG2+xtf0PfunfgJ7Y
        ydHhdSugbFWToEtPteXhLDc6PAtmSEo=
X-Google-Smtp-Source: ABdhPJy7HuVDArt+9+sYwvEik2CMbd5g4Tak4Me88lVTzYEusyxW7pHVkoPRkskmOQPMpq1Tw5waUg==
X-Received: by 2002:adf:f30d:: with SMTP id i13mr9821882wro.119.1624614642772;
        Fri, 25 Jun 2021 02:50:42 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id 2sm5432075wrz.87.2021.06.25.02.50.42
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 25 Jun 2021 02:50:42 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] ARM: dts: NSP: Add DT files for Meraki MX64 series
Date:   Fri, 25 Jun 2021 10:49:49 +0100
Message-Id: <20210625095000.3358973-3-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625095000.3358973-1-mnhagan88@gmail.com>
References: <20210625095000.3358973-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MX64 & MX64W Hardware info:
  - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
  - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
  - Storage: 1 GB (Micron MT29F8G08ABACA)
  - Networking: BCM58625 internal switch (5x 1GbE ports)
  - USB: 1x USB2.0
  - Serial: Internal header
  - WLAN(MX64W only): 2x Broadcom BCM43520KMLG on the PCI bus

This patch adds the Meraki MX64 series-specific bindings. Since some
devices make use of the older A0 SoC, changes need to be made to
accommodate this case, including removal of coherency options and
modification to the secondary-boot-reg.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |   4 +
 .../boot/dts/bcm958625-meraki-kingpin.dtsi    | 163 ++++++++++++++++++
 .../arm/boot/dts/bcm958625-meraki-mx64-a0.dts |  45 +++++
 arch/arm/boot/dts/bcm958625-meraki-mx64.dts   |  15 ++
 .../boot/dts/bcm958625-meraki-mx64w-a0.dts    |  55 ++++++
 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts  |  23 +++
 6 files changed, 305 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f8f09c5066e7..83560b05f797 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -154,6 +154,10 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
 	bcm958525xmc.dtb \
 	bcm958622hr.dtb \
 	bcm958623hr.dtb \
+	bcm958625-meraki-mx64.dtb \
+	bcm958625-meraki-mx64-a0.dtb \
+	bcm958625-meraki-mx64w.dtb \
+	bcm958625-meraki-mx64w-a0.dtb \
 	bcm958625hr.dtb \
 	bcm988312hr.dtb \
 	bcm958625k.dtb
diff --git a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
new file mode 100644
index 000000000000..7c487c74fd10
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64 series (Kingpin).
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm958625-meraki-mx6x-common.dtsi"
+
+/ {
+
+	keys {
+		compatible = "gpio-keys-polled";
+		autorepeat;
+		poll-interval = <20>;
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpioa 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			/* green:lan1-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 19 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			/* green:lan1-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 18 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			/* green:lan2-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 24 GPIO_ACTIVE_LOW>;
+		};
+
+		led-3 {
+			/* green:lan2-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <3>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 20 GPIO_ACTIVE_LOW>;
+		};
+
+		led-4 {
+			/* green:lan3-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <4>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 26 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			/* green:lan3-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <5>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 25 GPIO_ACTIVE_LOW>;
+		};
+
+		led-6 {
+			/* green:lan4-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <6>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
+		};
+
+		led-7 {
+			/* green:lan4-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <7>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 27 GPIO_ACTIVE_LOW>;
+		};
+
+		led-8 {
+			/* green:wan-left */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <8>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 30 GPIO_ACTIVE_LOW>;
+		};
+
+		led-9 {
+			/* green:wan-right */
+			function = LED_FUNCTION_ACTIVITY;
+			function-enumerator = <9>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioa 29 GPIO_ACTIVE_LOW>;
+		};
+
+		led-a {
+			/* amber:power */
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_AMBER>;
+			gpios = <&gpioa 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-b {
+			/* white:status */
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpioa 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&srab {
+	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
+	status = "okay";
+
+	ports {
+		port@0 {
+			label = "lan1";
+			reg = <0>;
+		};
+
+		port@1 {
+			label = "lan2";
+			reg = <1>;
+		};
+
+		port@2 {
+			label = "lan3";
+			reg = <2>;
+		};
+
+		port@3 {
+			label = "lan4";
+			reg = <3>;
+		};
+
+		port@4 {
+			label = "wan";
+			reg = <4>;
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
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts b/arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
new file mode 100644
index 000000000000..f9c8180293ed
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64 with A0 SoC.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-kingpin.dtsi"
+
+/ {
+	model = "Cisco Meraki MX64(A0)";
+	compatible = "meraki,mx64-a0", "brcm,bcm58625", "brcm,nsp";
+};
+
+&amac2 {
+	/delete-property/ dma-coherent;
+};
+
+&cpu1 {
+	secondary-boot-reg = <0xffff042c>;
+};
+
+&ehci0 {
+	/delete-property/ dma-coherent;
+};
+
+&i2c0 {
+	/delete-property/ dma-coherent;
+};
+
+&L2 {
+	/delete-property/ arm,io-coherent;
+	/delete-property/ prefetch-data;
+	/delete-property/ prefetch-instr;
+};
+
+&mailbox {
+	/delete-property/ dma-coherent;
+};
+
+&ohci0 {
+	/delete-property/ dma-coherent;
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64.dts b/arch/arm/boot/dts/bcm958625-meraki-mx64.dts
new file mode 100644
index 000000000000..58addd69688a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64 with B0+ SoC.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-kingpin.dtsi"
+
+/ {
+	model = "Cisco Meraki MX64";
+	compatible = "meraki,mx64", "brcm,bcm58625", "brcm,nsp";
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts b/arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
new file mode 100644
index 000000000000..807720d21660
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64W with A0 SoC.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-kingpin.dtsi"
+
+/ {
+	model = "Cisco Meraki MX64W(A0)";
+	compatible = "meraki,mx64w-a0", "brcm,bcm58625", "brcm,nsp";
+};
+
+&amac2 {
+	/delete-property/ dma-coherent;
+};
+
+&cpu1 {
+	secondary-boot-reg = <0xffff042c>;
+};
+
+&ehci0 {
+	/delete-property/ dma-coherent;
+};
+
+&i2c0 {
+	/delete-property/ dma-coherent;
+};
+
+&L2 {
+	/delete-property/ arm,io-coherent;
+	/delete-property/ prefetch-data;
+	/delete-property/ prefetch-instr;
+};
+
+&mailbox {
+	/delete-property/ dma-coherent;
+};
+
+&ohci0 {
+	/delete-property/ dma-coherent;
+};
+
+&pcie0 {
+	/delete-property/ dma-coherent;
+	status = "okay";
+};
+
+&pcie1 {
+	/delete-property/ dma-coherent;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64w.dts b/arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
new file mode 100644
index 000000000000..8d37cd56c093
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64W with B0+ SoC.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm958625-meraki-kingpin.dtsi"
+
+/ {
+	model = "Cisco Meraki MX64W";
+	compatible = "meraki,mx64w", "brcm,bcm58625", "brcm,nsp";
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

