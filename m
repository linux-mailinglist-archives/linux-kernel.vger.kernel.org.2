Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C8403B50
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbhIHORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhIHORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:17:49 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA816C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:16:41 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNT-00CSbk-NC
        for linux-kernel@vger.kernel.org; Wed, 08 Sep 2021 16:16:39 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNH-00CSXe-Hk; Wed, 08 Sep 2021 16:16:27 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNH-000ZcN-2B; Wed, 08 Sep 2021 16:16:27 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>, Bert Vermeulen <bert@biot.com>
Subject: [PATCH v3 3/5] ARM: dts: Add basic support for Airoha EN7523
Date:   Wed,  8 Sep 2021 16:16:04 +0200
Message-Id: <20210908141606.136792-4-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908141606.136792-1-bert@biot.com>
References: <20210908141606.136792-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add basic support for Airoha EN7523, enough for booting to console.

The UART is basically 8250-compatible, except for the clock selection.
A clock-frequency value is synthesized to get this to run at 115200 bps.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/boot/dts/Makefile       |   2 +
 arch/arm/boot/dts/en7523-evb.dts |  26 +++++++
 arch/arm/boot/dts/en7523.dtsi    | 114 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 arch/arm/boot/dts/en7523-evb.dts
 create mode 100644 arch/arm/boot/dts/en7523.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 863347b6b65e..3525ace2d2e0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -174,6 +174,8 @@ dtb-$(CONFIG_ARCH_DAVINCI) += \
 	da850-lego-ev3.dtb
 dtb-$(CONFIG_ARCH_DIGICOLOR) += \
 	cx92755_equinox.dtb
+dtb-$(CONFIG_ARCH_AIROHA) += \
+	en7523-evb.dtb
 dtb-$(CONFIG_ARCH_EXYNOS3) += \
 	exynos3250-artik5-eval.dtb \
 	exynos3250-monk.dtb \
diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
new file mode 100644
index 000000000000..fa595b97bdd8
--- /dev/null
+++ b/arch/arm/boot/dts/en7523-evb.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/* Bootloader installs ATF here */
+/memreserve/ 0x80000000 0x80000;
+
+#include "en7523.dtsi"
+
+/ {
+	model = "Airoha EN7523 Evaluation Board";
+	compatible = "airoha,en7523-evb", "airoha,en7523";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0x1fbf0000 console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
new file mode 100644
index 000000000000..034bd1de2cd6
--- /dev/null
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		npu_binary@84000000 {
+			no-map;
+			reg = <0x84000000 0xA00000>;
+		};
+
+		npu_flag@84B0000 {
+			no-map;
+			reg = <0x84B00000 0x100000>;
+		};
+
+		npu_pkt@85000000 {
+			no-map;
+			reg = <0x85000000 0x1A00000>;
+		};
+
+		npu_phyaddr@86B00000 {
+			no-map;
+			reg = <0x86B00000 0x100000>;
+		};
+
+		npu_rxdesc@86D00000 {
+			no-map;
+			reg = <0x86D00000 0x100000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller@9000000 {
+		compatible = "arm,gic-v3";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x09000000 0x20000>, <0x09080000 0x80000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <25000000>;
+	};
+
+	uart1: serial@1fbf0000 {
+		compatible = "ns8250";
+		reg = <0x1fbf0000 0x30>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <1843200>;
+		status = "okay";
+	};
+};
-- 
2.25.1

