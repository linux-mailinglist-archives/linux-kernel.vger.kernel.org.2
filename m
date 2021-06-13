Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A83A578F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFMKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:21:05 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33694 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhFMKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:21:00 -0400
Received: by mail-wr1-f49.google.com with SMTP id a20so11047712wrc.0;
        Sun, 13 Jun 2021 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sROUK6Dva1JQuoPMs/jXitnbxB+zZqBPPto4386z0vs=;
        b=iEgzLk4om3CmXjGeHduPgS2tuE9n3w+7odBDhtldN2Yh0eUUEKkZvWwgig1b8zBRSi
         mDrO76P+6hQPZj2A7hcA6Jg55sbL/IiWjRaaaS7PaLMI8ODUjLHMkr+Vyi8PcRYutstv
         68bgXhbnSd0336Pu4qeGJ434ZUct7+HUYxHlDnhmDqEu367sjQru1cmps7HNSawkUx2A
         OZcIdlAfMElRM6yHaIXfqS9nAYb3g7otdd7mmXF+0iqZMxF7CHzUYs/rnmhxAVYgz8H4
         ZKsmTXusnS4JOAhw5y1Wve0Ad5gGiR9UuluLr4RapqmxMaa8asfxGGKzK1WllkNLmEjA
         ix3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sROUK6Dva1JQuoPMs/jXitnbxB+zZqBPPto4386z0vs=;
        b=XGdz8VTNAYh985paO/UDDUDn/7icTibwvbBMd5WC+Ipd4v3WbTr+z7nMFTe1Lq7Mob
         4xxiMDFKMhIMT1Cwf4rYwlIOaFBvA56hKPTLF0FR+GU09pW7q1dy/ZkiDwbj9SDIuPO0
         Eqc7gwqCsjUeQkbDP0Pg95+SJBbZ1kVp8DifpeudxCLapbivElCKzqLlxEkLm6VuLidy
         CiHyxQc7qgnvvZG/NesGAT9XHB9Q+1bdQ1omGRU95pssqo9dine9zR0bcMJJ8/HNjXfc
         VTne990sGkZVV3hP5FAxKbuBiQQMBiuE3xjBUCQc5q37pV+yZWdV/51HZzp/bm9k48H/
         HMVQ==
X-Gm-Message-State: AOAM531Rtqpk8mTve/f5ukWNgjatIBijobCT+pRHFeDgPEPAN2VGTRNk
        jA2ayWiw5DVWiCM6IWAiEFs=
X-Google-Smtp-Source: ABdhPJxFcpzxxe157MZ8aKlQCWnikrDr1kv2KTXlwrxueiNotMzM77Tc4PNfKmNDW+nWzts8vNjvWQ==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr13021764wrj.365.1623579478974;
        Sun, 13 Jun 2021 03:17:58 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id j7sm13157035wrm.93.2021.06.13.03.17.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 03:17:58 -0700 (PDT)
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] ARM: dts: NSP: Add common bindings for MX64/MX65
Date:   Sun, 13 Jun 2021 11:16:45 +0100
Message-Id: <20210613101658.3242777-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210613101658.3242777-1-mnhagan88@gmail.com>
References: <20210613101658.3242777-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bindings are required for all Meraki MX64/MX65 devices. These
common bindings include memory (2GB), PWM LEDs, AMAC, I2C (AT24), NAND
partitions, EHCI, OHCI and pinctrl.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 .../dts/bcm958625-meraki-mx6x-common.dtsi     | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi

diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
new file mode 100644
index 000000000000..91ab586209f1
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Common Bindings for Cisco Meraki MX64 (Kingpin) and MX65 (Alamo) devices.
+ *
+ * Copyright (C) 2020-2021 Matthew Hagan <mnhagan88@gmail.com>
+ */
+
+#include "bcm-nsp.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x80000000>;
+	};
+
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led-1 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_RED>;
+			pwms = <&pwm 1 50000>;
+			max-brightness = <255>;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			pwms = <&pwm 2 50000>;
+			max-brightness = <255>;
+		};
+
+		led-3 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_BLUE>;
+			pwms = <&pwm 3 50000>;
+			max-brightness = <255>;
+		};
+	};
+};
+
+&amac2 {
+	status = "okay";
+};
+
+&ccbtimer0 {
+        status = "okay";
+};
+
+&ehci0 {
+        status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	at24@50 {
+		compatible = "atmel,24c64";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+};
+
+&L2 {
+        arm,io-coherent;
+        prefetch-data = <1>;
+        prefetch-instr = <1>;
+};
+
+&nand {
+	nandcs@0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
+
+		brcm,nand-oob-sector-size = <27>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition@80000 {
+			label = "shmoo";
+			reg = <0x80000 0x80000>;
+			read-only;
+		};
+
+		partition@100000 {
+			label = "bootkernel1";
+			reg = <0x100000 0x300000>;
+		};
+
+		partition@400000 {
+			label = "nvram";
+			reg = <0x400000 0x100000>;
+		};
+
+		partition@500000 {
+			label = "bootkernel2";
+			reg = <0x500000 0x300000>;
+		};
+
+		partition@800000 {
+			label = "ubi";
+			reg = <0x800000 0x3f700000>;
+		};
+	};
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_leds>;
+
+	pwm_leds: pwm_leds {
+		function = "pwm";
+		groups = "pwm1_grp", "pwm2_grp", "pwm3_grp";
+	};
+};
+
+&pwm {
+	status = "okay";
+	#pwm-cells = <2>;
+};
+
+&uart0 {
+        clock-frequency = <62500000>;
+        status = "okay";
+};
-- 
2.26.3

