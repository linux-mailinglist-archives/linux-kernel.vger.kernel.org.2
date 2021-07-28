Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751673D94E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhG1SBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhG1SBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:06 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13590C061796;
        Wed, 28 Jul 2021 11:01:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c18so3112554qke.2;
        Wed, 28 Jul 2021 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hlccHpa8acGXb7hg5ss9czD81tD5ZKFSFRVC1kWUrxw=;
        b=Ojz77QqKjmVztoMw3rsxwbE690JvJsOr2S8VEZWpAA5pf7u2buke7yp4IJ0NoaXvc1
         UwC6gt+9oj969NZ1poLr9aD1sudJr2kcGqllK12KJSWINb0XdcL8BUU0GcW2vMtEgd+Z
         MXI+f7XlI/LWHSOYmO+BXY4B6d5mqS3XGwjklvxeN4UK5Qd/d6A83ImexLtp3WoITgI7
         LeJ2EaMuoJa6T+i7lmXMOiyRnW715+g6WdjMjulFdp/lXkUj7aIWML38K5W9QivAnExw
         GM7RWAi/MNYkDU/e43XL5fPjq9fPABMbh2CzEYGhbu2s5P/PP95E/EBvQO6UB+XB2YG9
         PzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hlccHpa8acGXb7hg5ss9czD81tD5ZKFSFRVC1kWUrxw=;
        b=QxVsQgIDzyHDZZBH76Xvhk4NW1U0x+gBsi7cgwFDHngkmIjfOBXXh+AQq981FRmyAd
         pB7cY4hiqaYojQqFEitt7IvM5vh+KCi+KKbKpnXCC87K9JitLtResGnrdP0JGD0wabIO
         x8RJLOmZpiW7yMXvdXMHWZ9t+BWPXYOjA8XBBVbZR0b7u4KpGj6NOBUTN5lgYCcdqt8Q
         yMbg4ETwfzObPRESHr4AD6iwUbHvZnjj3JYbfZH/5msZtfeShryWZTLXZDGx6x83rlHE
         KANdxEbNhWnfmsJDzUMPsNKmb986yS5d8NlyRNOhxx6Ws4/5C0QQtaeMzS/eAOTO+hee
         ixOg==
X-Gm-Message-State: AOAM531ipBBCOz+hSEv4aS7PnjXh2z+WDo8Vzxa8GyisG/npnNmlJohs
        hrEmikn5viqJubKXGGwoIx4=
X-Google-Smtp-Source: ABdhPJwtPXGltmuVn4d51nUTh5OWU+sQ7JKCW1/OCoG25HkG/Rhw0OCR3b+6aoShqcjmf6mFLgugQA==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr924099qkj.432.1627495261134;
        Wed, 28 Jul 2021 11:01:01 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:01:00 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm64: dts: rockchip: add rk3568 tsadc nodes
Date:   Wed, 28 Jul 2021 14:00:31 -0400
Message-Id: <20210728180034.717953-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the thermal and tsadc nodes to the rk3568 device tree.
There are two sensors, one for the cpu, one for the gpu.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3568-pinctrl.dtsi     |  7 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 70 +++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
index a588ca95ace2..3b1efaf2646e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
@@ -2420,6 +2420,13 @@ spi3m1_cs1: spi3m1-cs1 {
 	};
 
 	tsadc {
+		/omit-if-no-ref/
+		tsadc_pin: tsadc-pin {
+			rockchip,pins =
+				/* tsadc_pin */
+				<0 RK_PA1 0 &pcfg_pull_none>;
+		};
+
 		/omit-if-no-ref/
 		tsadcm0_shut: tsadcm0-shut {
 			rockchip,pins =
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index fbd9f1c366ff..c74072941da1 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -50,6 +50,7 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
 			clocks = <&scmi_clk 0>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
@@ -58,6 +59,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
@@ -66,6 +68,7 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
@@ -74,6 +77,7 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
+			#cooling-cells = <2>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
@@ -773,6 +777,72 @@ uart9: serial@fe6d0000 {
 		status = "disabled";
 	};
 
+	thermal_zones: thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_alert1: cpu_alert1 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit: cpu_crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <20>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 1>;
+		};
+	};
+
+	tsadc: tsadc@fe710000 {
+		compatible = "rockchip,rk3568-tsadc";
+		reg = <0x0 0xfe710000 0x0 0x100>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru CLK_TSADC_TSEN>, <&cru CLK_TSADC>;
+		assigned-clock-rates = <17000000>, <700000>;
+		clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		resets = <&cru SRST_TSADC>, <&cru SRST_P_TSADC>,
+			 <&cru SRST_TSADCPHY>;
+		reset-names = "tsadc", "tsadc-apb", "tsadc-phy";
+		rockchip,grf = <&grf>;
+		rockchip,hw-tshut-temp = <95000>;
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&tsadc_pin>;
+		pinctrl-1 = <&tsadc_shutorg>;
+		pinctrl-2 = <&tsadc_pin>;
+		#thermal-sensor-cells = <1>;
+		status = "disabled";
+	};
+
 	saradc: saradc@fe720000 {
 		compatible = "rockchip,rk3568-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xfe720000 0x0 0x100>;
-- 
2.25.1

