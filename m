Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE63C79F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhGMXOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhGMXOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:14:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B26AC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:11:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u1so786865wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSb3ObAo4ylOUw0FlyxhZx8xAa3rKpfUqluE9lkrXRM=;
        b=X2+0woRl6dwUbgPxnKsHnNPShGzW7Zlak3pDlZy1mXIZ24tnJZtXQ8U/WX6dKzUCmk
         MuIPurdh7dcQT+ZADiIScnXTtPxvUSN8ptkY1CztSrUPIxenRPOFVkZT0n3GtF1U2TOx
         83SFDq3Lg4r+exQ59RnRwDou7neb4hTKTQdLCgUic6jZufLOtSn10gNVnOZ3cMaTTjlH
         11IheQ9BaOO619bnnOHYjbJp140JoymFgjOcDT18U26NWWLF/zTeRkTCV1zC2KqH61X5
         6TILsuLNIoRkyGQLPJ6rupEgdcPXM82U8PKiCwFj/Ez+tv+sKb2274NqlBL9Gvi803dw
         OwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSb3ObAo4ylOUw0FlyxhZx8xAa3rKpfUqluE9lkrXRM=;
        b=ACmiJxEPrhjNvyIZgQQLeGtsR23lyZ0z1GOpcXcpOPgh//Ixdo5O2UB5EafcODwUl8
         u0aHyLYXi8CgAUtwfKYJoIzKnkpnnPXYbELJnvaTRwjmzET1lNKrFlrDtu2caIA6usgj
         t9YCzTe/iGJyXT/hQioX09cl4YVbO2027S04e4Lq2S8gl5owL4LggQby8bleh5EGoAhu
         8kDxre6tlz49G9rOzzJdg8crTnSbqpGb1NWffSYnrlrNWHSJvWoraZ9TBs8wWDkyaDLk
         uAJartkjii2SEy9M/EZzhzqzFlhgu/7P07Scn68PwfRTsWm2cV7deglTcbFbcZ4UzB9d
         VVJw==
X-Gm-Message-State: AOAM532m13r8lt2etHSzlRz086eiPNtrBesJw/h27OSSAv9eymlJWlIW
        e7PGct0nDt5K/HLqyCSDYQiblMHkzj8=
X-Google-Smtp-Source: ABdhPJxu5zW+U7tPxlUasKv+D8P4pl4jIiUS1ggFku8BsXHu7/b6Gu6oF8K1Q+KoYQybmzxmmludSA==
X-Received: by 2002:adf:e581:: with SMTP id l1mr8643410wrm.116.1626217870639;
        Tue, 13 Jul 2021 16:11:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id y16sm3551608wmq.1.2021.07.13.16.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:11:10 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson: Add the AIU audio controller
Date:   Wed, 14 Jul 2021 01:11:02 +0200
Message-Id: <20210713231103.2994354-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713231103.2994354-1-martin.blumenstingl@googlemail.com>
References: <20210713231103.2994354-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the AIU audio controller to the Amlogic Meson6/8/8b/8m2 SoC DT. This
provides I2S and SPDIF outputs as well as codec glues for the internal
HDMI controller.
Also add the clock inputs and pin mux definitions on Meson8/8b/8m2. On
Meson6 this is omitted because we neither have a clock nor pin
controller node there yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi   | 11 ++++++
 arch/arm/boot/dts/meson8.dtsi  | 63 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index bd0e864964e9..6a30ed54ca83 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	#address-cells = <1>;
@@ -36,6 +37,16 @@ hhi: system-controller@4000 {
 				reg = <0x4000 0x400>;
 			};
 
+			aiu: audio-controller@5400 {
+				compatible = "amlogic,aiu";
+				#sound-dai-cells = <2>;
+				reg = <0x5400 0x2ac>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
+					     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "i2s", "spdif";
+				status = "disabled";
+			};
+
 			assist: assist@7c00 {
 				compatible = "amlogic,meson-mx-assist", "syscon";
 				reg = <0x7c00 0x200>;
diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 686c7b7c79d5..f80ddc98d3a2 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -317,6 +317,29 @@ mali: gpu@c0000 {
 	};
 }; /* end of / */
 
+&aiu {
+	compatible = "amlogic,aiu-meson8", "amlogic,aiu";
+	clocks = <&clkc CLKID_AIU_GLUE>,
+		 <&clkc CLKID_I2S_OUT>,
+		 <&clkc CLKID_AOCLK_GATE>,
+		 <&clkc CLKID_CTS_AMCLK>,
+		 <&clkc CLKID_MIXER_IFACE>,
+		 <&clkc CLKID_IEC958>,
+		 <&clkc CLKID_IEC958_GATE>,
+		 <&clkc CLKID_CTS_MCLK_I958>,
+		 <&clkc CLKID_CTS_I958>;
+	clock-names = "pclk",
+		      "i2s_pclk",
+		      "i2s_aoclk",
+		      "i2s_mclk",
+		      "i2s_mixer",
+		      "spdif_pclk",
+		      "spdif_aoclk",
+		      "spdif_mclk",
+		      "spdif_mclk_sel";
+	resets = <&reset RESET_AIU>;
+};
+
 &aobus {
 	pmu: pmu@e0 {
 		compatible = "amlogic,meson8-pmu", "syscon";
@@ -340,6 +363,38 @@ gpio_ao: ao-bank@14 {
 			gpio-ranges = <&pinctrl_aobus 0 0 16>;
 		};
 
+		i2s_am_clk_pins: i2s-am-clk-out {
+			mux {
+				groups = "i2s_am_clk_out_ao";
+				function = "i2s_ao";
+				bias-disable;
+			};
+		};
+
+		i2s_out_ao_clk_pins: i2s-ao-clk-out {
+			mux {
+				groups = "i2s_ao_clk_out_ao";
+				function = "i2s_ao";
+				bias-disable;
+			};
+		};
+
+		i2s_out_lr_clk_pins: i2s-lr-clk-out {
+			mux {
+				groups = "i2s_lr_clk_out_ao";
+				function = "i2s_ao";
+				bias-disable;
+			};
+		};
+
+		i2s_out_ch01_ao_pins: i2s-out-ch01 {
+			mux {
+				groups = "i2s_out_ch01_ao";
+				function = "i2s_ao";
+				bias-disable;
+			};
+		};
+
 		uart_ao_a_pins: uart_ao_a {
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
@@ -460,6 +515,14 @@ mux {
 			};
 		};
 
+		spdif_out_pins: spdif-out {
+			mux {
+				groups = "spdif_out";
+				function = "spdif";
+				bias-disable;
+			};
+		};
+
 		spi_nor_pins: nor {
 			mux {
 				groups = "nor_d", "nor_q", "nor_c", "nor_cs";
diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index c02b03cbcdf4..b49b7cbaed4e 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -279,6 +279,29 @@ mali: gpu@c0000 {
 	};
 }; /* end of / */
 
+&aiu {
+	compatible = "amlogic,aiu-meson8b", "amlogic,aiu";
+	clocks = <&clkc CLKID_AIU_GLUE>,
+		 <&clkc CLKID_I2S_OUT>,
+		 <&clkc CLKID_AOCLK_GATE>,
+		 <&clkc CLKID_CTS_AMCLK>,
+		 <&clkc CLKID_MIXER_IFACE>,
+		 <&clkc CLKID_IEC958>,
+		 <&clkc CLKID_IEC958_GATE>,
+		 <&clkc CLKID_CTS_MCLK_I958>,
+		 <&clkc CLKID_CTS_I958>;
+	clock-names = "pclk",
+		      "i2s_pclk",
+		      "i2s_aoclk",
+		      "i2s_mclk",
+		      "i2s_mixer",
+		      "spdif_pclk",
+		      "spdif_aoclk",
+		      "spdif_mclk",
+		      "spdif_mclk_sel";
+	resets = <&reset RESET_AIU>;
+};
+
 &aobus {
 	pmu: pmu@e0 {
 		compatible = "amlogic,meson8b-pmu", "syscon";
@@ -302,6 +325,46 @@ gpio_ao: ao-bank@14 {
 			gpio-ranges = <&pinctrl_aobus 0 0 16>;
 		};
 
+		i2s_am_clk_pins: i2s-am-clk-out {
+			mux {
+				groups = "i2s_am_clk_out";
+				function = "i2s";
+				bias-disable;
+			};
+		};
+
+		i2s_out_ao_clk_pins: i2s-ao-clk-out {
+			mux {
+				groups = "i2s_ao_clk_out";
+				function = "i2s";
+				bias-disable;
+			};
+		};
+
+		i2s_out_lr_clk_pins: i2s-lr-clk-out {
+			mux {
+				groups = "i2s_lr_clk_out";
+				function = "i2s";
+				bias-disable;
+			};
+		};
+
+		i2s_out_ch01_ao_pins: i2s-out-ch01 {
+			mux {
+				groups = "i2s_out_01";
+				function = "i2s";
+				bias-disable;
+			};
+		};
+
+		spdif_out_1_pins: spdif-out-1 {
+			mux {
+				groups = "spdif_out_1";
+				function = "spdif_1";
+				bias-disable;
+			};
+		};
+
 		uart_ao_a_pins: uart_ao_a {
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
-- 
2.32.0

