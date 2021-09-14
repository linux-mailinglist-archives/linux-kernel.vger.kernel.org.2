Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E240B71C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhINSnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhINSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:43:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD0C061767;
        Tue, 14 Sep 2021 11:42:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so21790136wrr.9;
        Tue, 14 Sep 2021 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ApBGn7VsjGvZYRPP4n5f95vzaxAoc+aB8E6/mGL1rI=;
        b=NVVyyD02LM6Uju7M4/wX4QgAXtwAFU0ILGf3hYkPEFV+vyLm6QU5Pmm2prpzcg3nLX
         wKlB4/v/YxF5C5K8tg6uq2pYlU/FYvr3dainU/ApRhN2TRzZku8TMDcLc8oegRskgh25
         wANZCc2oxAUaxqIUGNLxM+c0QJFR5v/4zYKVm3wVy/gKBZl6FqnHFCbbf/W5kx+7saxm
         fRhoCA1VTZbX+petZ2/kh9Y4ybJ6+ldQjyI5SFR1q9xPm/sEYjrTkoLy6WbYQ7CGqubZ
         LZbzxoReVxnjftI5FdPmuwVJ8gLqjfZVelc4Er4ZY1Xtt+78FwfzE5ELzJo5nnAZ3VMg
         upqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ApBGn7VsjGvZYRPP4n5f95vzaxAoc+aB8E6/mGL1rI=;
        b=AAWi9LztSu4zlv/qKYLXOOtbuBqRGrftHaEmR8ISOfZ62JKlSlQfNhn0SeWmgYCERG
         XodykfaqrhSqOOv1kXRTNNHPXmAIlpYgffgL4auD36d+rsqhU36Kgw2PR+e5v2Qy2bo3
         jdxTUMiI3hl/k++myknsH4+WCaCd4z5FRBU2+lcheNabbizskk+QrlSV/kUR8dcZYT+b
         jQEgykGNB8nJ6F3ZXjYJGQqywLjUGTGEcTGze+8w7QGyOW7WKboa5r6TEV10lOZECIaK
         nJ/oRmCI5Wjgla7/trkmSrzHnc8z0BciiCCM44Er0WaW35qHLMrybDNuwc8HIMn+CkNh
         1AXA==
X-Gm-Message-State: AOAM5337ajR5UPwveR2P9PXsnPFYUmAz/4JIWT5/43xptZbtjITeUnnr
        rAmnQ0IzyCNMXDSDHV3Vw4RgwA9j4Vo=
X-Google-Smtp-Source: ABdhPJxFfMOkrk5X6zq6WnstG9za28HVrCWr5U+hngP7JVwpsY0oOHOgYSfPx9ABvuSYJgYi6AyuCg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr602031wro.355.1631644930948;
        Tue, 14 Sep 2021 11:42:10 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id t9sm11439764wrg.4.2021.09.14.11.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:42:10 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W
Date:   Tue, 14 Sep 2021 20:41:41 +0200
Message-Id: <20210914184141.32700-4-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914184141.32700-1-romain.perier@gmail.com>
References: <20210914184141.32700-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wireless Tag IDO-SBC2D06-V1B-22W[1] is an SBC powered by SSD202D
with a dual Ethernet and a connector for a 4-inch and 7-inch display.
It embeds a System-On-Module IDO-SOM2D01[2] with an Mstar SSD202 SoC
dual-core Cortex-A7 CPU @ 1.2Ghz , 2D GPU, 128 MB DDR3 (on-chip) and
a 256MB SPI NAND flash. This commit adds basic definition for this
board.

1. http://linux-chenxing.org/infinity2/ido-sbc2d06
2. http://www.wireless-tag.com/portfolio/ido-som2d01

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 .../devicetree/bindings/arm/mstar/mstar.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/mstar-infinity2m-ssd201-som2d01.dtsi  | 20 +++++++++++++
 ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts | 23 +++++++++++++++
 ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi | 28 +++++++++++++++++++
 5 files changed, 74 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi

diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
index a316eef1b728..10efd703717e 100644
--- a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
@@ -25,6 +25,8 @@ properties:
           - enum:
               - honestar,ssd201htv2 # Honestar SSD201_HT_V2 devkit
               - m5stack,unitv2 # M5Stack UnitV2
+              - wirelesstag,ido-som2d01 # Wireless Tag IDO-SOM2D01
+              - wirelesstag,ido-sbc2d06-v1b-22w # Wireless Tag IDO-SBC2D06-1VB-22W
           - const: mstar,infinity2m
 
       - description: infinity3 boards
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..7f0e92cea716 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1448,6 +1448,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	mstar-infinity-msc313-breadbee_crust.dtb \
+	mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dtb \
 	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
 	mstar-infinity2m-ssd202d-unitv2.dtb \
 	mstar-infinity3-msc313e-breadbee.dtb \
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
new file mode 100644
index 000000000000..34df472fed71
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ * Author: Romain Perier <romain.perier@gmail.com>
+ */
+
+/ {
+	reg_vcc_dram: regulator-vcc-dram {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_dram";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
new file mode 100644
index 000000000000..20b40b711d4f
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ * Author: Romain Perier <romain.perier@gmail.com>
+ */
+
+/dts-v1/;
+#include "mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Wireless Tag IDO-SBC2D06-1VB-22W";
+	compatible = "wirelesstag,ido-sbc2d06-v1b-22w", "wirelesstag,ido-som2d01", "mstar,infinity2m";
+
+	leds {
+		compatible = "gpio-leds";
+		sys_led {
+			gpios = <&gpio SSD20XD_GPIO_GPIO85 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
new file mode 100644
index 000000000000..d877aff85033
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ * Author: Romain Perier <romain.perier@gmail.com>
+ */
+
+/dts-v1/;
+#include "mstar-infinity2m-ssd202d.dtsi"
+#include "mstar-infinity2m-ssd201-som2d01.dtsi"
+
+/ {
+	model = "Wireless Tag IDO-SOM2D01 (SSD202D)";
+	compatible = "wirelesstag,ido-som2d01", "mstar,infinity2m";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&reg_vcc_dram {
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+};
-- 
2.33.0

