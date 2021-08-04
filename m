Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2243E02A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhHDODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbhHDODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:03:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1DC0613D5;
        Wed,  4 Aug 2021 07:03:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l18so2394575wrv.5;
        Wed, 04 Aug 2021 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=19plOpPW+WVmw0cGjj3q24slWnf3YHJuW1TftKQHmww=;
        b=FDUQYip0F00orvtkAkIcR8qVk3zv/e3ZQ5O0oxkQ72xrb2I84rrvuEftw3nY8nyu8I
         n4kmGGki9xlL4IqZZC2CXDbb1X1f0teTyHkAH+pbrxXkeNu0DMild6XLdq4QvT+vbQxO
         u2gsNHlCQU6i6o6b7/PXHu9dxM3JovsXf6zAoC3UGJx82OHEHLEn5Tbsz333HhuWf1rW
         eRZGk6qsgJ5FrAhZnGK10g9hUnWyxoidZ8sgnhHzMqixSaDndmpgq9DIpVHidSOstYL4
         VILszrfoqM1wIa3bwB/Vi/rEocfZh2eTWAYDz0/R2QiLZ7ruV68242mLf+Ptufrm9Buc
         09qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=19plOpPW+WVmw0cGjj3q24slWnf3YHJuW1TftKQHmww=;
        b=PLZVAYwONrKtgerY7hvJ4nAAvh8IGe8pvWTGo6CSIh9iPTbPXab5D4G4DK8H0NIOEH
         i2qE+FnggllsAQAwvWEkGeqwSVSFLVHskQOuM7hfz7hiWgMgT0b5D5P+4OMPVxg3oowR
         TLye9bOsa7p2OOmmZ23fFTS7vUr6fTVSLOA/3XOmy0i41rbFTMrU3WfNW28jyx8vO3jT
         MruFMkud5rwwHt1KKKCTZvGJsOMhBinGntFSDg3wycfhmOR7iovtOJyXG6TlH2aveN2F
         vw62Hl5aHthTcyRH1LxYGAO+ykry3usCfqq5aWpfO/0fiUKPpq5v/SCF0auz+s6cVucA
         dwfg==
X-Gm-Message-State: AOAM533FdxbkOVelaWvUMPOOZvrNrH6ttaseRQhe/Vtr1ouGfCPMGpeE
        6PJnWD8NrLXHAtwkbM/HIss=
X-Google-Smtp-Source: ABdhPJzrgSNIUtASBt18jfFqj4fSRQ5BFiwT4yllI7pX4XWLIC3af4Re6vBNJy6vUhU0ie7Hqhmc3w==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr28634456wrv.329.1628085782448;
        Wed, 04 Aug 2021 07:03:02 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f5sm2752654wrs.5.2021.08.04.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:03:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add audio playback to vega-s95 dtsi
Date:   Wed,  4 Aug 2021 14:02:58 +0000
Message-Id: <20210804140258.4666-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Tested-by: Oleg Ivanov <150balbes@yandex.ru>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 9b0b81f191f1..66daf3af34c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "meson-gxbb.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "tronsmart,vega-s95", "amlogic,meson-gxbb";
@@ -17,6 +18,13 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -97,6 +105,59 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "VEGA-S95";
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-parents = <0>, <0>, <0>;
+		assigned-clock-rates = <294912000>,
+				       <270950400>,
+				       <393216000>;
+		status = "okay";
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_FIFO>;
+		};
+
+		dai-link-2 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&aiu AIU_HDMI CTRL_I2S>;
+			};
+		};
+
+		dai-link-3 {
+			sound-dai = <&aiu AIU_CPU CPU_SPDIF_ENCODER>;
+
+			codec-0 {
+				sound-dai = <&spdif_dit>;
+			};
+		};
+
+		dai-link-4 {
+			sound-dai = <&aiu AIU_HDMI CTRL_OUT>;
+
+			codec-0 {
+				sound-dai = <&hdmi_tx>;
+			};
+		};
+	};
+};
+
+&aiu {
+	status = "okay";
+	pinctrl-0 = <&spdif_out_y_pins>;
+	pinctrl-names = "default";
 };
 
 &cec_AO {
-- 
2.17.1

