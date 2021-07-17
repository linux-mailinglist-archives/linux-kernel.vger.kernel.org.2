Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5E3CC6CD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 01:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhGQXdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhGQXdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 19:33:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D4C061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 16:30:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so3054028wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsVloxEGjSteK4U7+lXhhEQfJStMyVYbpRaRDn0jLto=;
        b=J+U+9/QycuPEanBet1BEi5lgWbUua9ldGZEuMBNS4BYUQhwrxG8Jjp/l5bDdkA4rDW
         XsJKSv9P4B9KKovPfWOE+uvS1vWveAk0b6eJlTT4/9YXu0rHolnYBvQKcTQLjdUUvKdk
         qxIXzR8MOSqCUIpWyyvvV8cllttE6w21KBlQePoTayqOz+Nmdk6L0aF2lUJEu3dgUElB
         VHv9icGzEddE6ENhifGZgikgvy/kmQg4BP42bLVRZh850M94wdj6RLNgCNJbKbLXGW/F
         DoeuDvTKJ7pP5gLFuSwwdn09GDfJMbnYv9rAE1092pHglvuEqx6Th3EZsksrZTrcSY+C
         iSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsVloxEGjSteK4U7+lXhhEQfJStMyVYbpRaRDn0jLto=;
        b=nqvprTW0EdsTnn6XLmtU1H45jiF4SHMibd6e8PumEjtxVCme5a1GfpvsMzS3sLPO2n
         xa0PaaAais7Tss1Y+Vwb98vIvZWR+NZs2u3Lts2aQt0sBDSCKnkhL7Xalr2fDSqSXSF/
         HSdYLIEUrfXdA2rpBIWxkroJ4t4vRTg9aJBXE0Ru8vIpEECzWZ6aHbkE2yg94eWP22Ql
         5S4SN2JKqKv/htZzVBb6h3llqlFZur+U8kGZR8dxr7ZFhp3vSYQA2NyTczdfeTN2jgBg
         3rSCMspGEs5qaQkcmSBipcy38406ynXSmdVZ1n+9J/OsAZtn2Q0EAtw/w8E83OcDlbeW
         p79g==
X-Gm-Message-State: AOAM533MTdS+5fDJQ+KlsVtfVYFeyoxTPRM/WU5B6ka7NznVmesfwxX0
        6WL1f8reg2hWSqZY3aMqms0=
X-Google-Smtp-Source: ABdhPJywMQVKPjUbVi7xolNMlKaN+tPpKAzZJFYFqum6WncftMz8NZBUlZIVwOeRhGVmsHQli/H1hQ==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr24465294wme.161.1626564637171;
        Sat, 17 Jul 2021 16:30:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q19sm14824051wmq.38.2021.07.17.16.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:30:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] ARM: dts: meson: Add the AIU audio controller
Date:   Sun, 18 Jul 2021 01:30:29 +0200
Message-Id: <20210717233030.331273-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
References: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson.dtsi   | 12 +++++++
 arch/arm/boot/dts/meson8.dtsi  | 63 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index bd0e864964e9..3be7cba603d5 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	#address-cells = <1>;
@@ -36,6 +37,17 @@ hhi: system-controller@4000 {
 				reg = <0x4000 0x400>;
 			};
 
+			aiu: audio-controller@5400 {
+				compatible = "amlogic,aiu";
+				#sound-dai-cells = <2>;
+				sound-name-prefix = "AIU";
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

