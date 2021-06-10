Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD03A37E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFJXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFJXbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:31:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56CC061574;
        Thu, 10 Jun 2021 16:28:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c9so4027092wrt.5;
        Thu, 10 Jun 2021 16:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTpjcEscnkXt8biWria3TPVvbm38R/l/UTSx1WwHNQ4=;
        b=HV8O5Wx+mQNMN2vpuSzv6+t3TN3t8AVdOuLrs6e0MI3vI0yveOfPUCL09T29xrwxX/
         niGf6R3taOBFa8NYD4uEp0yNeNLCyMyzyYf6gKdaAGJ4EPvWR426NVveEtldotO7Nd91
         LKyfqy+Ribef0jOKTR61fp1aymO05HvpUYUqc/vJLoIcUeOpgTnL9Wzdxbw5d9PX4ebR
         wSN92PxI4lp2g4eseZu5R7VwHs+3zRQY8SxKzo4mNY2Z/KIs6psFnXmRKzbLaLkI3ao7
         h7uV6+I6mveGb0jP+TOEuP4Sp0nZKDE9vEHqI/5Cvy0U+lCuln3iwJSOL/Z6KSHqx+TZ
         4Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTpjcEscnkXt8biWria3TPVvbm38R/l/UTSx1WwHNQ4=;
        b=UCrrwE0DmA+2oJ71qdDJP0YQRwE0BC/ceA3aZBMQZcZ9PTRClfocCfvMGlHto3lvZj
         j0ZBwtGDJq2jvPUW9MtidqjcYTMuh3ahqrDMd4ib5u2xLRp+ZU4O3rvhUsaIbD5IPsok
         gzZ2SFhlrUu1QKHWz4Aw0uiWnGRkNxQ+W4cV82p1C0axWRQU5NNGduQtCmcf7ZxxtlH/
         LIrzN6PKUnWM7biDfOLDOoDwORlsKlRSiXf9N09I+JkUIij0EV9N5vk9lAv9e5DpaQj+
         ftl4CelBovxd8TV+pCNtvtdkvVcQsgkYRaqguM0yUyHebCyAikR3X2LejhZ2TypgiIep
         ghzg==
X-Gm-Message-State: AOAM533NTf0hqiqqfaMxzPr64hOoPUyFwmDZ15rkexu+zPc7LTaYiIY5
        T6eE0xciroV/FUyRyEuf8x0=
X-Google-Smtp-Source: ABdhPJyCoU8FCEn23JKM5OCnln6DG5M5qDbzdTAbzlnFUMV2OTYKEdslyh579et4/sWhtyi1REg0Yw==
X-Received: by 2002:adf:de03:: with SMTP id b3mr788972wrm.15.1623367738500;
        Thu, 10 Jun 2021 16:28:58 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id f14sm9786849wmq.10.2021.06.10.16.28.57
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 16:28:58 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] ARM: dts: NSP: Add DT files for Meraki MX64 series
Date:   Fri, 11 Jun 2021 00:27:16 +0100
Message-Id: <20210610232727.1383117-5-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610232727.1383117-1-mnhagan88@gmail.com>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MX64 Hardware info:
  - CPU: Broadcom BCM58625 Cortex A9 @ 1200Mhz
  - RAM: 2 GB (4 x 4Gb SK Hynix H5TC4G83CFR)
  - Storage: 1 GB (Micron MT29F8G08ABACA)
  - Networking: BCM58625 internal switch (5x 1GbE ports)
  - USB: 1x USB2.0
  - Serial: Internal header

This patch adds the Meraki MX64 series. Since some devices make use of
the older A0 SoC, changes need to be made to accommodate this device,
including removal of dma-coherent and change in the secondary-cpu
address. The MX64W devices have 2x Broadcom BCM43520KMLG on the PCI bus.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 .../boot/dts/bcm958625-meraki-kingpin.dtsi    | 131 ++++++++++++++++++
 .../arm/boot/dts/bcm958625-meraki-mx64-a0.dts |  45 ++++++
 arch/arm/boot/dts/bcm958625-meraki-mx64.dts   |  15 ++
 .../boot/dts/bcm958625-meraki-mx64w-a0.dts    |  55 ++++++++
 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts  |  23 +++
 5 files changed, 269 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx64w.dts

diff --git a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
new file mode 100644
index 000000000000..8c4834f3496b
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64 series (Kingpin).
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm958625-meraki-mx6x-common.dtsi"
+
+#include <dt-bindings/input/input.h>
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+
+		orange_power {
+			label = "orange:power";
+			gpios = <&gpioa 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		lan1_right {
+			label = "green:lan1-right";
+			gpios = <&gpioa 18 GPIO_ACTIVE_LOW>;
+		};
+
+		lan1_left {
+			label = "green:lan1-left";
+			gpios = <&gpioa 19 GPIO_ACTIVE_LOW>;
+		};
+
+		lan2_right {
+			label = "green:lan2-right";
+			gpios = <&gpioa 20 GPIO_ACTIVE_LOW>;
+		};
+
+		lan2_left {
+			label = "green:lan2-left";
+			gpios = <&gpioa 24 GPIO_ACTIVE_LOW>;
+		};
+
+		lan3_right {
+			label = "green:lan3-right";
+			gpios = <&gpioa 25 GPIO_ACTIVE_LOW>;
+		};
+
+		lan3_left {
+			label = "green:lan3-left";
+			gpios = <&gpioa 26 GPIO_ACTIVE_LOW>;
+		};
+
+		lan4_right {
+			label = "green:lan4-right";
+			gpios = <&gpioa 27 GPIO_ACTIVE_LOW>;
+		};
+
+		lan4_left {
+			label = "green:lan4-left";
+			gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
+		};
+
+		wan_right {
+			label = "green:wan-right";
+			gpios = <&gpioa 29 GPIO_ACTIVE_LOW>;
+		};
+
+		wan_left {
+			label = "green:wan-left";
+			gpios = <&gpioa 30 GPIO_ACTIVE_LOW>;
+		};
+
+		white_status {
+			label = "white:status";
+			gpios = <&gpioa 31 GPIO_ACTIVE_HIGH>;
+		};
+	};
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
+			label = "cpu";
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
index 000000000000..aed9eb9fccd7
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64 with A0 SoC.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
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
+&cpu1 {
+	secondary-boot-reg = <0xffff042c>;
+};
+
+&L2 {
+	/delete-property/ arm,io-coherent;
+	/delete-property/ prefetch-data;
+	/delete-property/ prefetch-instr;
+};
+
+&amac2 {
+	/delete-property/ dma-coherent;
+};
+
+&mailbox {
+	/delete-property/ dma-coherent;
+};
+
+&ehci0 {
+	/delete-property/ dma-coherent;
+};
+
+&ohci0 {
+	/delete-property/ dma-coherent;
+};
+
+&i2c0 {
+	/delete-property/ dma-coherent;
+};
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx64.dts b/arch/arm/boot/dts/bcm958625-meraki-mx64.dts
new file mode 100644
index 000000000000..fe787fd7d660
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64 with B0+ SoC.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
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
index 000000000000..b7d88c542943
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64W with A0 SoC.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
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
+&cpu1 {
+	secondary-boot-reg = <0xffff042c>;
+};
+
+&L2 {
+	/delete-property/ arm,io-coherent;
+	/delete-property/ prefetch-data;
+	/delete-property/ prefetch-instr;
+};
+
+&amac2 {
+	/delete-property/ dma-coherent;
+};
+
+&mailbox {
+	/delete-property/ dma-coherent;
+};
+
+&ehci0 {
+	/delete-property/ dma-coherent;
+};
+
+&ohci0 {
+	/delete-property/ dma-coherent;
+};
+
+&i2c0 {
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
index 000000000000..aa29c96f2871
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx64w.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Bindings for Cisco Meraki MX64W with B0+ SoC.
+ *
+ * Copyright (C) 2021 Matthew Hagan <mnhagan88@gmail.com>
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

