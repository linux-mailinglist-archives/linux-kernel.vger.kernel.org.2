Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF43E2621
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhHFIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:30:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33700
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244370AbhHFI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:28:47 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 04F2C3F349
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628238511;
        bh=MnUaf5AkYg+Ni/0LSttCAcjbb55nUmFOJYj+n4i9K3w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=P4oGF6+WmPMHoW/+Nvp6PeSgJeqm0idCwLiRZH6mtMz5jIQKGE7xI4xfBGhay3Oio
         PGvjqxTWfvlzwRUUAWQgKj6iUAT5WxELQZb4tshMU2UQL8yqOokAUwtju25Qz7Dxhh
         772QSTn594PVybrOUpZn3j/NKOmkQmEAOk84B7vFIY8l4y5oQiWOqbuWnGdSit8WTj
         rO7oOVKqDR12FIiWr3h/DshcpQ5EVqB9xDo9+e0fAhCYhz/dTlSAN/hzbqaP1l3nSG
         ouWYlZ6QeTKnppdm41chhK8yHBD2MwnyJdcQwZFZUW+dk4Rne0uPj99ZguoVxNCZsn
         G0pSM81772DLA==
Received: by mail-ed1-f69.google.com with SMTP id eg53-20020a05640228b5b02903bd6e6f620cso4535041edb.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MnUaf5AkYg+Ni/0LSttCAcjbb55nUmFOJYj+n4i9K3w=;
        b=bd9Z2IZ5IOG78YlY232XUWyU9zl0NqYTYQoWTKbpO8sWha0k9kw/sE6OVdQ/X0RA2g
         0VsVbCF7+JmF67Dk9zqZe63MoSTG7oVbNVGXE3jJ5VgXc/Sc2xvtxBI1vHkpZ3/UqWcU
         A0bEM/hBWb5OIO6foKYUw1K1IYMBvBFDTUBJbWfgOZ9rrDJPSgIP6m4bMc+tANRPkZRv
         bppjSswKyhv1LYGVVvYugvhCoKydEIasiF2BWQmOfRINX1EZhmKn67WaLJO6NjoODfQO
         t6KuXJynb/rtdFL9Voqq8tY1z7h+a+1MfgilXnEkp/U1QVCGukHUjFM7Dw7yzRFbKcTV
         cuHA==
X-Gm-Message-State: AOAM53041Gv94aoAF3wn8Q2tVDrR81io0aEihDTFFhHlB/2yTEQYDucl
        DFUy838GEsDCpRiXOr6XCLY4RnZKWBHUwtBH/yRDgG0RH8PuVfh5zXusAnUnFFhwo74y+2ycXSz
        zDH+YHnApyGSifdY6anoFytJ+S+KaDekCEoo7SjWFPw==
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr899449edr.9.1628238510740;
        Fri, 06 Aug 2021 01:28:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJfUgycduAl52oYXnvteqO8ZoEY3A8RvIKImSCxuG3Bnh0eITIFZhFGLfKLRGPgCkiNekYVg==
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr899433edr.9.1628238510602;
        Fri, 06 Aug 2021 01:28:30 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id ee11sm763943edb.26.2021.08.06.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:28:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] arm64: dts: synaptics: remove unused DTSI for AS370
Date:   Fri,  6 Aug 2021 10:26:35 +0200
Message-Id: <20210806082635.20239-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The as370.dtsi for Synaptics AS370 SoC does not have a user (DTS board
file), is uncompilable and untestable.  It was added back in 2018.  No
user appeared since that time, so assume it won't be added.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/arm/syna.txt          |   4 -
 arch/arm64/boot/dts/synaptics/as370.dtsi      | 173 ------------------
 2 files changed, 177 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi

diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
index d8b48f2edf1b..851f48ead927 100644
--- a/Documentation/devicetree/bindings/arm/syna.txt
+++ b/Documentation/devicetree/bindings/arm/syna.txt
@@ -18,10 +18,6 @@ stable binding/ABI.
 
 ---------------------------------------------------------------
 
-Boards with the Synaptics AS370 SoC shall have the following properties:
-  Required root node property:
-    compatible: "syna,as370"
-
 Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
 shall have the following properties:
 
diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
deleted file mode 100644
index 4bb5d650df9c..000000000000
--- a/arch/arm64/boot/dts/synaptics/as370.dtsi
+++ /dev/null
@@ -1,173 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (C) 2018 Synaptics Incorporated
- *
- * Author: Jisheng Zhang <jszhang@kernel.org>
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-
-/ {
-	compatible = "syna,as370";
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x0>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		cpu1: cpu@1 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x1>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		cpu2: cpu@2 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x2>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		cpu3: cpu@3 {
-			compatible = "arm,cortex-a53";
-			device_type = "cpu";
-			reg = <0x3>;
-			enable-method = "psci";
-			next-level-cache = <&l2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
-		};
-
-		l2: cache {
-			compatible = "cache";
-		};
-
-		idle-states {
-			entry-method = "psci";
-			CPU_SLEEP_0: cpu-sleep-0 {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x0010000>;
-				entry-latency-us = <75>;
-				exit-latency-us = <155>;
-				min-residency-us = <1000>;
-			};
-		};
-	};
-
-	osc: osc {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>,
-				     <&cpu1>,
-				     <&cpu2>,
-				     <&cpu3>;
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	soc@f7000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0xf7000000 0x1000000>;
-
-		gic: interrupt-controller@901000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x901000 0x1000>,
-			      <0x902000 0x2000>,
-			      <0x904000 0x2000>,
-			      <0x906000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-		apb@e80000 {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0xe80000 0x10000>;
-
-			uart0: serial@c00 {
-				compatible = "snps,dw-apb-uart";
-				reg = <0xc00 0x100>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&osc>;
-				reg-shift = <2>;
-				status = "disabled";
-			};
-
-			gpio0: gpio@1800 {
-				compatible = "snps,dw-apb-gpio";
-				reg = <0x1800 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				porta: gpio-port@0 {
-					compatible = "snps,dw-apb-gpio-port";
-					gpio-controller;
-					#gpio-cells = <2>;
-					ngpios = <32>;
-					reg = <0>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-				};
-			};
-
-			gpio1: gpio@2000 {
-				compatible = "snps,dw-apb-gpio";
-				reg = <0x2000 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				portb: gpio-port@1 {
-					compatible = "snps,dw-apb-gpio-port";
-					gpio-controller;
-					#gpio-cells = <2>;
-					ngpios = <32>;
-					reg = <0>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-				};
-			};
-		};
-	};
-};
-- 
2.30.2

