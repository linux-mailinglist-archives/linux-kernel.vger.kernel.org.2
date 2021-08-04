Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9A3E0291
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhHDOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhHDOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:00:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D76C0613D5;
        Wed,  4 Aug 2021 07:00:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m12so2348951wru.12;
        Wed, 04 Aug 2021 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UQh0XuwEqlgV75Ps3B/F3ylifl0qiT4/8PBf3CQWjYw=;
        b=eOyvHSKNYGyaO+vNyt8TYAy1znDJI8bWYgVrTFZz5Bh49tY0KEY5Vic1ZUjMTCQ6Yl
         UI31ZFXG4+EiUC3ZBUz8GiMzvh8S1gGc+zUG/ytz21FqPFlmcYtaLyyxR/M0KN/pmzzo
         rM5gOufWNkQvVvbbpKWbLqJygPdhOE9jxfriqlmd0j2OzS2+TmgAM9eYLVZz04EnCiku
         OpqN3IitHJxMHd3XBRR6n9h2M0vrDdfe8YhC7GyyDQkVC+/U7JlkXVzfkurVPwfPHnoV
         sAEvF+dCFHI/LLkvDOr0dejQSrPCGh9uEy10GzfLbWywyPBRPsVReY5ogQoIaBehq0iC
         8UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UQh0XuwEqlgV75Ps3B/F3ylifl0qiT4/8PBf3CQWjYw=;
        b=EbQTiklrTyGtRQKlX9lGu+hysj6BKVrkMI7wTUk7XZfRVrYXtWe9E1adkakMCcrYFQ
         rGrh2sdSGOSU66CYbN31zRA5uQfo3HYVNUVV23UoGrjirC4MIw2D+xj9JBWm8RH2F2km
         ooNqPGGiXyGolrhbviqnSKkyCLnE7g6R8zHfXXgntJPzgNplzwS64MuCapkruAiHPPs6
         y2Jb+kfg3fRSWcrtOdlYLz8lrbi+nbNWs69vukpeJxtW+Zt5Nr3RWEUQPnNKeqamCyq+
         4NrlU6ImjCnbRpzuVpHIyI/nTbnsgzGGd/JIrlPEPuMCHiVISJxXbtR3wEXgvp3V0iO9
         oE7w==
X-Gm-Message-State: AOAM532Wou+l+2/x8R6HTTTv/bRZWSNgvxz9alGqEHXESiswaqFQn2R1
        BtoTTaQzP513L6krS5pvyDY=
X-Google-Smtp-Source: ABdhPJzllF+zFHrspGUKzLn3qA7J6fHTwUA8j7nohSTy8ysuKuNFdqGA5vH04F7Jcz/A/DMK8TJUFA==
X-Received: by 2002:a5d:6904:: with SMTP id t4mr28597192wru.187.1628085633684;
        Wed, 04 Aug 2021 07:00:33 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k1sm2812902wrz.61.2021.08.04.07.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:00:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add audio playback to nexbox-a1
Date:   Wed,  4 Aug 2021 14:00:29 +0000
Message-Id: <20210804140029.4445-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index dfa7a37a1281..236c0a144142 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "meson-gxm.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "nexbox,a1", "amlogic,s912", "amlogic,meson-gxm";
@@ -24,6 +25,13 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	spdif_dit: audio-codec-0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
@@ -75,6 +83,59 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "NEXBOX-A1";
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
+	pinctrl-0 = <&spdif_out_h_pins>;
+	pinctrl-names = "default";
 };
 
 &cec_AO {
-- 
2.17.1

