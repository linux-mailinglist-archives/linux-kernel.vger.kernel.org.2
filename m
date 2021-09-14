Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE240B2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhINPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhINPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:17:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199EC061574;
        Tue, 14 Sep 2021 08:16:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c21so12639711edj.0;
        Tue, 14 Sep 2021 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=y4C7y9yJzTQudhCL/GHuZMtYngDM40ymN0HTRwvsckQ=;
        b=iAVdVA2EgO9QsXTzpLndE0Po4h/y/qQrRmQfUiLtKaar7C2wTdegTmqF7Nu+TysdKp
         5BAqiDSPftJYqaKPWzzGkWDgHfvj/and+2n6wpJlZ4zIoIvdDXUbiP8jul2L9Ofj3kQy
         tSxR2zWKZ0QWEXIZA5mEuSKwcktjF++SnMQTwqD9an+7rgCUBrWnj0CTFMMGzKLqoocF
         lPZqSQ23U/MlVvR5AetSppaPTUIQ0R+WMJ/DFLnqCAODCccVRrAnncsLPG0AI0Eu/M5M
         CX2CeUXsbl+DObJdSGvA0OUWDHnFYFsl3CgbNGTHULTrMBYp8uOfw9Z0ZWw3k9rx2b3A
         4qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4C7y9yJzTQudhCL/GHuZMtYngDM40ymN0HTRwvsckQ=;
        b=e5LUaXDr9H7NCkp6Uz4CsXpzMZ3uJMaTS901KJSoxHqo+vXOmIKXtGMbpYgmZ7wAQM
         GeJN1hB2ckf2mrOpdmY8sbpir0bHXTR9EvtoINm7dxQylZuTUeUby3+AATOcU2yhlvBS
         axUemMwVVuPPjGUNcvkbI0xBU04ICJhSap8h5d7b7wfwKuqK7MubtbJFJfqpkN+cggkB
         GRw2nXOPA4WqJgRqEJTaMOyvKBkfr7CHaXwoi1yVxegSxLJL6RC2VuOnGMO33X8y9/Wy
         pCL0g2i30QeWjcJ9uv7eBwxc/f+lInqUjFIl8q8ICasx4tc8EWOQe5YbnWhTOBVPhnU6
         udfQ==
X-Gm-Message-State: AOAM533ETY+OjOUmdJQBhmf+8roFh42KstOpS8xwRZmy1tV+yqQKlxVW
        jnwZYIA18vd9l3LUb8UFV3Q=
X-Google-Smtp-Source: ABdhPJxcpflDkKriUpwXnmQ91xvw+QQ2tRPyfz+7x2m8TLRQSCCUzKP02myJJM14tbNU0Ev45LWzUA==
X-Received: by 2002:a05:6402:2c9:: with SMTP id b9mr20207344edx.109.1631632595532;
        Tue, 14 Sep 2021 08:16:35 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x12sm4932833edd.51.2021.09.14.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:16:35 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add audio playback to rbox-pro
Date:   Tue, 14 Sep 2021 15:16:31 +0000
Message-Id: <20210914151631.2841-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support limited to HDMI i2s and SPDIF (LPCM).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
This reworks an earlier submission which was rejected due to errant
inclusion of some regulators with the patch.

 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index dde7cfe12cff..50137aafab10 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 #include "meson-gxm.dtsi"
+#include <dt-bindings/sound/meson-aiu.h>
 
 / {
 	compatible = "kingnovel,r-box-pro", "amlogic,s912", "amlogic,meson-gxm";
@@ -33,6 +34,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
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
 
@@ -90,6 +98,59 @@
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
+
+	sound {
+		compatible = "amlogic,gx-sound-card";
+		model = "RBOX-PRO";
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
 
 &ethmac {
-- 
2.17.1
