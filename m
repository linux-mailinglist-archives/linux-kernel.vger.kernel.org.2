Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FDF3CC6CF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 01:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhGQXdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 19:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhGQXdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 19:33:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66DC061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 16:30:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l7so16498412wrv.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJiK6ZPfj0SXkTk/BERUcE9u2Ss9uOY9yYEJynNuJRE=;
        b=sWxRlKLGfombM7n/SQKbdgHjDcsYANaqKK/V/9slxJwdEmWNMzIfZVXIhxZUztF/QQ
         bgjYQwlRzHaWIjJZWhWLKjZmSo8LrtSEOLUzbRvzAl0F4oxhKVjycAq854htHPN+mWMc
         kHnWO+hb89Hi/nQnYb7w0dTTMvlgvxu18R/yJd9pXul3B7X+zkVOiiPX48iop/9paaMg
         A+kkkAlHgwmX5ANsFL23EDu3EH6EDCoJigDqX8By2uwMRp8LsH7zRyX38By/hGbeHMR8
         h+ePVEJgXKa5go3Oy8Z4SpeSefYI94WUBJTV6zKMgl4FcMlbwafLOquB+J+ExPboqR3w
         kDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJiK6ZPfj0SXkTk/BERUcE9u2Ss9uOY9yYEJynNuJRE=;
        b=N2bKNjsLRBI+dHwW4Jf77GUIaUYLgBPHieujODAzIoAlKrNbJnYH4guWfDTJZ+0zVZ
         fwj2tG3wvWSBTkyt9Dys905pqbVcR3igyp9SFxBlIMq5Tc6Ixi5suDT2LTigwPbDSyLB
         C1/h2gygxAnBYngbBFtjnYyLj+BgVpyREwgMa+24W5a2gTFRtixAX4TvDOI7efnhuT1L
         WAkzxkYb2gHtoWDjmWntgN2GlP8rD306P3fnyu95J67FeVJISPSmI4u8VO4i4qGy5gLL
         pAqXpwPjfiE6LhXrthgEV42bM5IDy5XT4Qy+F0G8rge3gmr8aIYkPCTbnqZenOZJxPoe
         Xr3g==
X-Gm-Message-State: AOAM5330jKZ9kWccCdQu58SRRHrrojFE+CZCLk8527sjWGf/DxK4ZXmk
        YtQ4nvOHORGW2fRpvEDS5zM=
X-Google-Smtp-Source: ABdhPJwVTlimgC+HBeL7qBCgE7Kt4D4zsydJswDaUEdpNebka11e9Ob4P7IdljCl6B1/fVutj9prpg==
X-Received: by 2002:adf:facf:: with SMTP id a15mr21055072wrs.39.1626564637959;
        Sat, 17 Jul 2021 16:30:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q19sm14824051wmq.38.2021.07.17.16.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:30:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] ARM: dts: meson8b: ec100: wire up the RT5640 audio codec
Date:   Sun, 18 Jul 2021 01:30:30 +0200
Message-Id: <20210717233030.331273-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
References: <20210717233030.331273-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek RT5640 codec is connected to the SoC's I2S interface.
Describe this in the .dts together with the codec's LDO1 enable GPIO so
audio can be played on the Endless Mini.
While here, add a note about the realtek,ldo1-en-gpios for which the
EC100 uses GPIO_BSD_EN. Due to driver limitations this pin cannot be
used currently.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 8e48ccc6b634..e404bdccdab9 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -96,6 +96,32 @@ rtc32k_xtal: rtc32k-xtal-clk {
 		#clock-cells = <0>;
 	};
 
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "M8B-EC100";
+
+		assigned-clocks = <&clkc CLKID_MPLL0>,
+				  <&clkc CLKID_MPLL1>,
+				  <&clkc CLKID_MPLL2>;
+		assigned-clock-rates = <270950400>,
+				       <294912000>,
+				       <393216000>;
+
+		dai-link-0 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
+		};
+
+		dai-link-1 {
+			sound-dai = <&aiu AIU_CPU CPU_I2S_ENCODER>;
+			dai-format = "i2s";
+			mclk-fs = <256>;
+
+			codec-0 {
+				sound-dai = <&rt5640>;
+			};
+		};
+	};
+
 	usb_vbus: regulator-usb-vbus {
 		/*
 		 * Silergy SY6288CCAC-GP 2A Power Distribution Switch.
@@ -242,6 +268,14 @@ vddee: regulator-vddee {
 	};
 };
 
+&aiu {
+	status = "okay";
+
+	pinctrl-0 = <&i2s_am_clk_pins>, <&i2s_out_ao_clk_pins>,
+		    <&i2s_out_lr_clk_pins>, <&i2s_out_ch01_ao_pins>;
+	pinctrl-names = "default";
+};
+
 &cpu0 {
 	cpu-supply = <&vcck>;
 };
@@ -283,9 +317,19 @@ &i2c_A {
 
 	rt5640: codec@1c {
 		compatible = "realtek,rt5640";
+
 		reg = <0x1c>;
+
+		#sound-dai-cells = <0>;
+
 		interrupt-parent = <&gpio_intc>;
 		interrupts = <13 IRQ_TYPE_EDGE_BOTH>; /* GPIOAO_13 */
+
+		/*
+		 * TODO: realtek,ldo1-en-gpios is connected to GPIO_BSD_EN.
+		 * We currently cannot configure this pin correctly.
+		 * Luckily for us it's in the "right" state by default.
+		 */
 		realtek,in1-differential;
 	};
 };
-- 
2.32.0

