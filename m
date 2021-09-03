Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B6400833
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350734AbhICXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350727AbhICXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:17:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C0C061575;
        Fri,  3 Sep 2021 16:16:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i21so1111375ejd.2;
        Fri, 03 Sep 2021 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnw6WzrVj6kVz7+rhXWWV0P1D+1rQjUWR64V6tXpcQc=;
        b=LUy4S5O3JpUY6Tl+oGYBAq42NZWaI/sMarxUr2Acgv4qDjateQV1MESdAljoiBEN5x
         voXVsB2Jjo6tEcDBWlh6PERG6UG72yEuWJph9IP19xZeNdhdRuAjZUE6R2i+AyXsTREX
         38f9EpjowbY2D6zHtIxOGh14Z48HWkUiAdQPNRWxdosm4GeOKzpYtC5t7IgY/YcUs4aT
         h+Esers0HD8QmxvAjnID+HmlKmJAFvCuj6HT2ETpWZ+NUgX39BcfYd6vxM6pimt0iugO
         cTbBswjwVVKQUWJVwIOyQoJHQfnnMQhob8bnYYA4x8on413eq553u3Tv00w1k0JV6eel
         arjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnw6WzrVj6kVz7+rhXWWV0P1D+1rQjUWR64V6tXpcQc=;
        b=Hf9rNWz3HmyYD8Y8+DRxcSxcyaLaKxT+eFxzHDdLV0NV+Ywfki7oBaUVoqcFcFBx3c
         vTwD0kbIwGRsW25774vWBnZJlRPPDzE+eaBYff3iBt3tFXwQxRMSzAbY0V8H8jms9dX/
         wXxE+QKlnyvPQP5ROrYldhgTADW+tjslf4ID/l9MFqex9jIcPJ9++6jyUSvaP66CYJeH
         oiqLWfBGofS9ZrrxKtbK3oPIm7QWU9PT5DVJHOSiYSFyKxZtbrqYzg1V9gCuK1m7Kumd
         9qcnQ+xRCbg/pjnmsNV7kJUwZeC8Wu4fEb+xG5snxz8WJ2toco+1ntv4GcecxtCT4ZCX
         PJig==
X-Gm-Message-State: AOAM532GAPc3eG+SJZRuU3H9731NXuGJSv58FA5fIE4NA5t5M8yfaQVz
        KsO4btn4F/i/VX7eY98Au64=
X-Google-Smtp-Source: ABdhPJxzM4YsGJ8U585f3WpC8RcJQjrrCZEpX0sY4ISI8TQzQaDLnqZogbWyNKtyY5x1UIrRhBzMcQ==
X-Received: by 2002:a17:906:8399:: with SMTP id p25mr1324360ejx.449.1630711000888;
        Fri, 03 Sep 2021 16:16:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r11sm214068ejy.71.2021.09.03.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:16:40 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] arm64: dts: rockchip: add analog audio on Quartz64
Date:   Sat,  4 Sep 2021 01:15:36 +0200
Message-Id: <20210903231536.225540-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
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
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a244f7b87e38..3a87c0240b30 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -58,6 +58,20 @@ led-diy {
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
@@ -199,8 +213,13 @@ rk817: pmic@20 {
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
@@ -389,9 +408,23 @@ regulator-state-mem {
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
+	rockchip,trcm-sync-tx-only;
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
2.33.0

