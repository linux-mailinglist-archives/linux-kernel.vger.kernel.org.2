Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A900383D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhEQTdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhEQTdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:33:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427FC06138D
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so195027wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qMQVIiAtd4R+eX9A5kzaFE7n4k/GD8veZK25Hsqb0Y4=;
        b=YNahRo2zUE2C6Cd8aNbuIEI8966LR5td1XBG0LnPYE+z+Vb+r3enGiK0DH9hY/yzv3
         0K+yDTRmdDnZ8mVCVNolbl+iTm56KS+66CBpl2Ab91IrkEsezGm9mKJ3w7MMElBQfZ64
         X3XtEBCsWmnm+IFOpKiS96BX94n8wT5gAqnPulzO/N+lWn0+zpXtiIg6p45yn4NQJ4MM
         7c4KPHX2usg+cCjm7bZb4L0BGvrs/KpdOngKY0l0LacRyOfQaOfXzryk4Ne/F7cgQfHV
         1Ngcs75/RlnB6zf8MPR4jPn/qglSfVXxWccinvkW6XTKSDTRRRM1BmXSWNUfggLCVw1t
         mDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qMQVIiAtd4R+eX9A5kzaFE7n4k/GD8veZK25Hsqb0Y4=;
        b=LU/lvQyYnmX9JD8VLxLKk3dEDEZWNqwHW7/ASG9BrrqsUC9WHkxUWvTpuXGmwwxDiR
         9+rAHC5CiHZqIf+rTol4tZQqe7seCsrcnJ7RiMrX1xEswZ373trVsQbxjtz25NJVRJGf
         69OE1DJKiSq6oN42VeCNp/TQQFo/5NEVbPNsqSuQXQKKFKu978T/peRbixbD99c+h0nJ
         0gFC8ukfPitMZmssLoq9gkRuv+KlCOFNWH+c5C91ulMX1ic88mxE/WbZaJ/vkbPkUn6O
         6w1f6EPeUBT2Q47JyA4gnBUQyyG9pRaRufANDYe5SNZDjNENrfJcmNC94+dxG7RU1NLf
         xinw==
X-Gm-Message-State: AOAM532YCFE3BQIJxcR7TWkCybOR3hIH1Xh49S90boHYftRD4WRJ4Dbr
        4PtW3aEaj6SYZaHL8My0kUuF2iWwyH5RUA==
X-Google-Smtp-Source: ABdhPJyZcZrbvnM5hmc8qpXvsEUWNK+NrDQST6l219mVNkTo6l8+jPkki6KSDmP8QpPYNoBo9iBBuw==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr1152164wmc.142.1621279941272;
        Mon, 17 May 2021 12:32:21 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e10sm18928907wrw.20.2021.05.17.12.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:32:20 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/5] ARM: gemini: add device tree for ssi1328
Date:   Mon, 17 May 2021 19:32:05 +0000
Message-Id: <20210517193205.691147-6-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193205.691147-1-clabbe@baylibre.com>
References: <20210517193205.691147-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSI 1328 is a NAS box running a SL3516 SoC.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/gemini-ssi1328.dts | 162 +++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 arch/arm/boot/dts/gemini-ssi1328.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bb30d13c9c60..0a9f6001b90b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -220,6 +220,7 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
 	gemini-rut1xx.dtb \
 	gemini-sl93512r.dtb \
 	gemini-sq201.dtb \
+	gemini-ssi1328.dtb \
 	gemini-wbd111.dtb \
 	gemini-wbd222.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += \
diff --git a/arch/arm/boot/dts/gemini-ssi1328.dts b/arch/arm/boot/dts/gemini-ssi1328.dts
new file mode 100644
index 000000000000..1112007c9d6f
--- /dev/null
+++ b/arch/arm/boot/dts/gemini-ssi1328.dts
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Corentin Labbe <clabbe@baylibre.com>
+ * Device Tree file for SSI 1328
+ */
+
+/dts-v1/;
+
+#include "gemini.dtsi"
+
+/ {
+	model = "SSI 1328";
+	compatible = "ssi,1328", "cortina,gemini";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory@0 {
+		/* 128 MB */
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	aliases {
+		mdio-gpio0 = &mdio0;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,19200n8 initrd=0x800000,9M";
+		stdout-path = &uart0;
+	};
+
+	mdio0: mdio {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
+			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* LAN Marvell 88E1118 */
+		phy0: ethernet-phy@1 {
+			reg = <1>;
+			device_type = "ethernet-phy";
+			/* We lack the knowledge of necessary GPIO to achieve
+			 * Gigabit
+			 */
+			max-speed = <100>;
+		};
+		/* WAN ICPlus IP101A */
+		phy1: ethernet-phy@2 {
+			reg = <2>;
+			device_type = "ethernet-phy";
+		};
+	};
+};
+
+&ethernet {
+	status = "okay";
+	ethernet-port@0 {
+		phy-mode = "rgmii";
+		phy-handle = <&phy0>;
+	};
+	ethernet-port@1 {
+		phy-mode = "rgmii";
+		phy-handle = <&phy1>;
+	};
+};
+
+&flash {
+	status = "okay";
+	/* 32MB of flash */
+	reg = <0x30000000 0x03200000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "RedBoot";
+			reg = <0x00000000 0x00020000>;
+			read-only;
+		};
+		partition@20000 {
+			label = "Kernel";
+			reg = <0x00020000 0x00300000>;
+		};
+		partition@320000 {
+			label = "Ramdisk";
+			reg = <0x00320000 0x00600000>;
+		};
+		partition@920000 {
+			label = "Application";
+			reg = <0x00920000 0x00600000>;
+		};
+		partition@f20000 {
+			label = "VCTL";
+			reg = <0x00f20000 0x00020000>;
+			read-only;
+		};
+		partition@f40000 {
+			label = "CurConf";
+			reg = <0x00f40000 0x000a0000>;
+			read-only;
+		};
+		partition@fe0000 {
+			label = "FIS directory";
+			reg = <0x00fe0000 0x00200000>;
+			read-only;
+		};
+	};
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_default_pins>;
+};
+
+&ide0 {
+	status = "okay";
+};
+
+&ide1 {
+	status = "okay";
+};
+
+&sata {
+	cortina,gemini-ata-muxmode = <0>;
+	cortina,gemini-enable-sata-bridge;
+	status = "okay";
+};
+
+&syscon {
+	pinctrl {
+		/*
+		 * gpio0agrp cover line 0-4
+		 * gpio0bgrp cover line 5
+		 */
+		gpio0_default_pins: pinctrl-gpio0 {
+			mux {
+				function = "gpio0";
+				groups = "gpio0agrp", "gpio0bgrp";
+			};
+		};
+		pinctrl-gmii {
+			/* This platform use both the ethernet ports */
+			mux {
+				function = "gmii";
+				groups = "gmii_gmac0_grp", "gmii_gmac1_grp";
+			};
+		};
+	};
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.26.3

