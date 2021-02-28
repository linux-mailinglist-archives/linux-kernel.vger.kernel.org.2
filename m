Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8882327330
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhB1PrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhB1Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:28 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E213BC06121D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h4so9778518pgf.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+tLTcgEC7NuZoaHUtchsSbxzlGgEOMmhAAuknqUUUU=;
        b=rx4ROMwIEp314rdXOpwVr1WQ7G/EqCyB1/1vZNPqyv4lTuFwebnPAe09jle/CqkGjw
         uFCPjonWBETPqE9GICTPJ4/MbCXIpl1qnFKUMrvuRBWWi1tP35gSnNV+56vj8KdbRgVM
         J4mUwxzaeKGLd5n1MkgAIMDGzxZDXCpllib1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+tLTcgEC7NuZoaHUtchsSbxzlGgEOMmhAAuknqUUUU=;
        b=fR6regSReKCca7fpL/UOljneNPOQ/bn+v70IJtW3YvuPnq8l4QhWAOjol8j9vRdIBl
         vA5VCxc5liamC+qVbsi7LH8i90dwsuTlTuAg5XLCgCnoH893HH+MvpxdDea/1WV9RGBC
         8SXI7pP0FUbrmgm/3hNLrJm6Mi0SlsWcxXqTutPI9JuOy2qhoQoE5ru6RVGg5Gxq2gVo
         Trtg0jBtXeCro0mQaIPav0w9cTzwdF1v6d0eLkpmfyT8uKErGlmE7MHU0Rro2FoqUFA/
         FI9bLT/BYlS0zdfnI6hjI21povBolvgyUV7h4okgU2pREkRLOKOOTazkac3rp8rU9m8V
         eebA==
X-Gm-Message-State: AOAM533VZxq2hpX3hV05aEYh/PV6mD9QagTKSyd6YB8xHMSaxK9qJv02
        BT4PgcdasISLHZLkAMAvqjWzYg==
X-Google-Smtp-Source: ABdhPJzlSS9w7YsKCT9U8IESeZc3nqXf3LWJcsI7p60fO8anMofol3oH/hpeRLOVghHS5x5zYjpkcQ==
X-Received: by 2002:a05:6a00:22ca:b029:1ed:f915:ca98 with SMTP id f10-20020a056a0022cab02901edf915ca98mr11319685pfj.68.1614527052458;
        Sun, 28 Feb 2021 07:44:12 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:44:12 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 07/10] ARM: dts: stm32: Add Engicam i.Core STM32MP1 SoM
Date:   Sun, 28 Feb 2021 21:13:20 +0530
Message-Id: <20210228154323.76911-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

General features:
- STM32MP157A
- Up to 1GB DDR3L
- 4GB eMMC
- 10/100 Ethernet
- USB 2.0 Host/OTG
- I2S
- MIPI DSI to LVDS
- rest of STM32MP157A features

i.Core STM32MP1 needs to mount on top of Engicam baseboards
for creating complete platform solutions.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- add device_type 

 .../boot/dts/stm32mp157a-icore-stm32mp1.dtsi  | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi

diff --git a/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi
new file mode 100644
index 000000000000..01166ccacf2b
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-icore-stm32mp1.dtsi
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/ {
+	compatible = "engicam,icore-stm32mp1", "st,stm32mp157";
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		mcuram2: mcuram2@10000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10000000 0x40000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@10040000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10040000 0x1000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@10041000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10041000 0x1000>;
+			no-map;
+		};
+
+		vdev0buffer: vdev0buffer@10042000 {
+			compatible = "shared-dma-pool";
+			reg = <0x10042000 0x4000>;
+			no-map;
+		};
+
+		mcuram: mcuram@30000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x30000000 0x40000>;
+			no-map;
+		};
+
+		retram: retram@38000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x38000000 0x10000>;
+			no-map;
+		};
+	};
+
+	vddcore: regulator-vddcore {
+		compatible = "regulator-fixed";
+		regulator-name = "vddcore";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
+
+	vdd: regulator-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vdd_usb: regulator-vdd-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vdda: regulator-vdda {
+		compatible = "regulator-fixed";
+		regulator-name = "vdda";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	vdd_ddr: regulator-vdd-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_ddr";
+		regulator-min-microvolt = <1350000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+	};
+
+	vtt_ddr: regulator-vtt-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt_ddr";
+		regulator-min-microvolt = <675000>;
+		regulator-max-microvolt = <675000>;
+		regulator-always-on;
+		vin-supply = <&vdd>;
+	};
+
+	vref_ddr: regulator-vref-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_ddr";
+		regulator-min-microvolt = <675000>;
+		regulator-max-microvolt = <675000>;
+		regulator-always-on;
+		vin-supply = <&vdd>;
+	};
+
+	vdd_sd: regulator-vdd-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	v3v3: regulator-v3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	v2v8: regulator-v2v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "v2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+		vin-supply = <&v3v3>;
+	};
+
+	v1v8: regulator-v1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "v1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&v3v3>;
+	};
+};
+
+&dts {
+	status = "okay";
+};
+
+&i2c2 {
+	i2c-scl-falling-time-ns = <20>;
+	i2c-scl-rising-time-ns = <185>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c2_pins_a>;
+	pinctrl-1 = <&i2c2_sleep_pins_a>;
+	status = "okay";
+};
+
+&ipcc {
+	status = "okay";
+};
+
+&iwdg2{
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&m4_rproc{
+	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
+			<&vdev0vring1>, <&vdev0buffer>;
+	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
+	mbox-names = "vq0", "vq1", "shutdown";
+	interrupt-parent = <&exti>;
+	interrupts = <68 1>;
+	status = "okay";
+};
+
+&rng1 {
+	status = "okay";
+};
+
+&rtc{
+	status = "okay";
+};
+
+&vrefbuf {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	vdda-supply = <&vdd>;
+	status = "okay";
+};
-- 
2.25.1

