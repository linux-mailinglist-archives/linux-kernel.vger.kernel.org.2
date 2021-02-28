Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A20327324
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhB1PpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhB1PpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28609C06178B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:50 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r5so9729848pfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8lgPS/H9UcN3+rMEGcheSYADrMFG557zp/WU7zuATY=;
        b=ZevkZMuKc2kHRQBdRPmP1lSgBnj4dYd+gpqQ6+pqsg3ErUUfJDOC4QTwuyuJ5DgoDw
         +kVSWw/GwALM1irm6nvHhsA0Xpv+/QALnkx5cKVucnvQl8NStEF3f+SXAj5h/OYO/mCJ
         XDZu9/My2Mk6ABpAoEbGG8NMRYhPzGJAGwOas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8lgPS/H9UcN3+rMEGcheSYADrMFG557zp/WU7zuATY=;
        b=EPZOEra3/J2G57fvcf7PlXSKdS2n8SsqM0E197WS4KO2M/kojrZPMkEyfDEpySibQC
         N2rucrxIfQfVvN2pG98u1u10nEl7zwaqxu23bY8ynUvra+7O8EbznvaSjQ1jJ+OfV+2p
         Ytpz5LUdheGTP1BdQE1qhdj9RBlcJ6aKaYHXXv97Ug4xeJMVMDql1WtfdBJ67eHv8cz0
         68V2lQgjcj9EWY7SDlbetb4NngTywe9l1Se6nEmHU7myHKulqgYMLrTXyx3Y07DIHdE0
         6MTIlpWrX3/gxBD/VEt6251Hzyw4piIo2uIWI5PyLtvTwLplgpIzjYtNmr/QlcGokj5g
         n1sQ==
X-Gm-Message-State: AOAM5320xbwU9HM0Mp9CMpKjWBTw2nsyxjsEVsCyD/+BQxlDAt5bXwZ1
        GjnKSq3uY3yZ1v7T/S1lpHKMVQ==
X-Google-Smtp-Source: ABdhPJzzru+AGTbE3uVaLrzySHKIxOD7dK4JNlZ2TR5iSmanm+uWYbh3+78UNUOuKWb2QgVbCqgfrA==
X-Received: by 2002:a63:c10:: with SMTP id b16mr10642346pgl.326.1614527029694;
        Sun, 28 Feb 2021 07:43:49 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:43:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Francesco Utel <francesco.utel@engicam.com>,
        Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v3 02/10] ARM: dts: stm32: Add Engicam MicroGEA STM32MP1 SoM
Date:   Sun, 28 Feb 2021 21:13:15 +0530
Message-Id: <20210228154323.76911-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroGEA STM32MP1 is a STM32MP157A based Micro SoM.

General features:
- STM32MP157AAC
- Up to 1GB DDR3L-800
- 512MB Nand flash
- I2S

MicroGEA STM32MP1 needs to mount on top of Engicam MicroDev carrier
boards for creating complete platform solutions.

Add support for it.

Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
Signed-off-by: Francesco Utel <francesco.utel@engicam.com>
Signed-off-by: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- add device_type
- updated commit message
Changes for v2:
- none

 .../dts/stm32mp157a-microgea-stm32mp1.dtsi    | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi

diff --git a/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
new file mode 100644
index 000000000000..0b85175f151e
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-microgea-stm32mp1.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) STMicroelectronics 2019 - All Rights Reserved
+ * Copyright (c) 2020 Engicam srl
+ * Copyright (c) 2020 Amarula Solutons(India)
+ */
+
+/ {
+	compatible = "engicam,microgea-stm32mp1", "st,stm32mp157";
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x10000000>;
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
+	vin: regulator-vin {
+		compatible = "regulator-fixed";
+		regulator-name = "vin";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	vddcore: regulator-vddcore {
+		compatible = "regulator-fixed";
+		regulator-name = "vddcore";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		vin-supply = <&vin>;
+	};
+
+	vdd: regulator-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&vin>;
+	};
+
+	vddq_ddr: regulator-vddq-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vddq_ddr";
+		regulator-min-microvolt = <1350000>;
+		regulator-max-microvolt = <1350000>;
+		regulator-always-on;
+		vin-supply = <&vin>;
+	};
+};
+
+&dts {
+	status = "okay";
+};
+
+&fmc {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&fmc_pins_a>;
+	pinctrl-1 = <&fmc_sleep_pins_a>;
+	status = "okay";
+
+	nand-controller@4,0 {
+		status = "okay";
+
+		nand@0 {
+			reg = <0>;
+			nand-on-flash-bbt;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
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

