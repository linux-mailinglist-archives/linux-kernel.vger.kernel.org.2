Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F923C79F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhGMXOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbhGMXOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 19:14:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B59C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:11:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so218080wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWl1Vtp4REPunQuHP81GLtdpuPygHjaGQhTUxCn58D0=;
        b=f+xHksQOVZnAOtbQbk5DNKurXzF2JLVBFVEO+Wl6FuhaNLj5ZMv06DWOrhpD1JceHA
         3bCdar4rI5CXlp89SFulcQ+VT0+oj0fC/rgY6/KGpV/bJ3sNtKqQxA9SMYSUrPOsVuVY
         Z+LCcH1hOwbSdGMv54OHWg1HzGNWgXoQPn3hwjLwjvL8tZpcrIVWGr0FfB8WQU6xBuZU
         enggdKrn/byhMOB2F/ySVGipjAwzf28ZrPYeVMOBnk6uu6UiWuf+2bGeRxWmzsZtFfF/
         1pb+soBHHq+NmofNqKHpOns6jPwlFOmj/s9FzclVG+E8Vxm+feZ832zAsXxQdNEhoTDz
         VUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWl1Vtp4REPunQuHP81GLtdpuPygHjaGQhTUxCn58D0=;
        b=eS2zj887mD0R8HYteBnck6Ts+M5cnKOknt4XUi2Bm2Kkbh9kc8MiSiW62mUTkzJzYA
         deCTlwi+W27EcUphEy332IZa33ykit5JY76m4zdYnNvn3AYxAn90zFtHbLYvA0H1mS+I
         mnudhoX2p2R2lvwtyV+JuzRZuKuAWFLHC12McVZ7Aoq7t2w+7PTCYzgq2niZXfn8rI6C
         zZRFlOJ9LMngjKk9G3n4tFh1gITyweYmbUNBHVBK9CoMr2sJdVJD5s4odtYw2droKes0
         u+4JiUviAVxD8AzJhYau96n4YvAl6jzJMG+TgNQylGy/lgZtuk4rsWWStskipuZnWiKS
         ldfg==
X-Gm-Message-State: AOAM533JYGQtkHWi1G0Kn6blRA/xadr/yOHVIWWbgjzQz/e4ob/J8+bE
        A9vQ/c+mKY2tipbzc4g+aKc=
X-Google-Smtp-Source: ABdhPJxT0/VK6AQnrwEjVZgSRZKbRAjsJ/9U141iVpixe9DWQ5/xe2EfLg/RUDX5xPIRUkBMyOqeKg==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr620798wmj.56.1626217871429;
        Tue, 13 Jul 2021 16:11:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c041-6f00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c041:6f00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id y16sm3551608wmq.1.2021.07.13.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 16:11:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson8b: ec100: wire up the RT5640 audio codec
Date:   Wed, 14 Jul 2021 01:11:03 +0200
Message-Id: <20210713231103.2994354-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713231103.2994354-1-martin.blumenstingl@googlemail.com>
References: <20210713231103.2994354-1-martin.blumenstingl@googlemail.com>
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
 arch/arm/boot/dts/meson8b-ec100.dts | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 8e48ccc6b634..177feb09a66d 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -96,6 +96,33 @@ rtc32k_xtal: rtc32k-xtal-clk {
 		#clock-cells = <0>;
 	};
 
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "M8B-EC100";
+		audio-routing = "I2S Encoder Playback", "I2S FIFO Playback";
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
@@ -242,6 +269,14 @@ vddee: regulator-vddee {
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
@@ -283,9 +318,19 @@ &i2c_A {
 
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

