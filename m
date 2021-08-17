Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD623EEAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbhHQKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbhHQKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:13:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26378C061764;
        Tue, 17 Aug 2021 03:12:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d11so37553972eja.8;
        Tue, 17 Aug 2021 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WAfNuRfJO7LeOVVvDRI/y8LyLau5VABNm838AmnyFo=;
        b=sFILswKo5rBl8VwdDLoIIvAVcnob6dPfqeX2siC87rmtwvaCx7LtTVboU2RXnjg1ts
         hijTkqlQytVV7Uq90+qwGvPZrAlrNDcoKa/VzcwtBhm/+Paw/Z7unj27SDKrLQanlrGq
         7OeCDfx3EBYZB3dJvi+W63IHIir6GmqTgO1QoXRhcPGt72+ec2CpQaKLUjgqMIi+lnJE
         j+bh6jMz/zBK5PbX4FLPGUXP22EWibpTRbMGYgi9kKa1dBMnxmGj5ccV35Re2p65FuxQ
         yCPNM1cJcn8mLwNYS/f4KyYP1ZT+bNELlwgVaAwdBtx5leqHoLt5AXlnsXgU/mrfuMqp
         RWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WAfNuRfJO7LeOVVvDRI/y8LyLau5VABNm838AmnyFo=;
        b=pQo17aFHX/YIEDMJehtVsBrczejbBsVZum3MIuC2q5hyr2u0Ufq9rhDFeWfcgZvI6X
         KpBgY3e5aN7szoFEN/tW2Ig3K+MREQTnO2KE5TBQqYSIvPy7LtJAWbxPNyvL+KYSdxCh
         6LOjuSB07xkkvCg9wnSGEkm8y6MrjXi1GwWTVnFBuGml/+0vmEW6e4KhiMa7WsCkgS5G
         bjmxAIl9nT26/oFDWmEevSBCo+0ax/ajJ6PB/i2tngQj/QQFZBAu7jb7GoOkE7fJ7a6J
         WMqrj9BNTcl5UlBu6Vj3uL4cibZz5W5iCtraou+G/Qur26d7lCjVAo4ALQRxBMTDZ+w5
         ehag==
X-Gm-Message-State: AOAM531pqpFVmNrUyWwrSGHI7HoJnY+QbLlKgYmR+lKgIsa1sf6ZMVmL
        efnqt14oUeAGKUtQOoPIC77bc4OrrkWFwg==
X-Google-Smtp-Source: ABdhPJz/ptHl1gRntKfY8he/WLyUVFrDG6r1VcZrRTjoEkImPkiQEAGArE18Td5ZEvY1tX4N9i/utA==
X-Received: by 2002:a17:906:6815:: with SMTP id k21mr3131060ejr.371.1629195161808;
        Tue, 17 Aug 2021 03:12:41 -0700 (PDT)
Received: from localhost.localdomain ([185.213.155.232])
        by smtp.gmail.com with ESMTPSA id m6sm822920edq.22.2021.08.17.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:12:41 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: add analog audio on Quartz64
Date:   Tue, 17 Aug 2021 12:11:19 +0200
Message-Id: <20210817101119.423853-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Quartz64 Model A, the I2S1 TDM controller is connected
to the rk817 codec in I2S mode. Enabling it and adding the
necessary simple-sound-card and codec nodes allows for analog
audio output on the PINE64 Quartz64 Model A SBC.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index b239f314b38a..8da4d1f600c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/sound/rockchip,i2s-tdm.h>
 #include "rk3566.dtsi"
 
 / {
@@ -50,6 +51,20 @@ led-diy {
 		};
 	};
 
+	rk817-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK817";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&rk817>;
+		};
+	};
+
 	vcc12v_dcin: vcc12v_dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -174,8 +189,13 @@ rk817: pmic@20 {
 		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
 		clock-output-names = "rk808-clkout1", "rk808-clkout2";
 
+		#sound-dai-cells = <0>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int_l>;
+		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
 		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
@@ -364,9 +384,23 @@ regulator-state-mem {
 				};
 			};
 		};
+
+		rk817_codec: codec {
+		};
+
 	};
 };
 
+&i2s1_8ch {
+	status = "okay";
+	rockchip,trcm-sync = <RK_TRCM_TX>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx
+		     &i2s1m0_lrcktx
+		     &i2s1m0_sdi0
+		     &i2s1m0_sdo0>;
+};
+
 &mdio1 {
 	rgmii_phy1: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.32.0

