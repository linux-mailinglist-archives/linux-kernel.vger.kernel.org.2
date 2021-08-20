Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24653F33C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhHTS3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhHTS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:29:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32AC061575;
        Fri, 20 Aug 2021 11:28:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mf2so3415225ejb.9;
        Fri, 20 Aug 2021 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2TFOiJdD6/bVUi+HowGp/lkXbvGkSZjNzeuPAsFmZo=;
        b=Hf88SitH2sHhCyvdUquEOOLpu3bSpXYNlW/Yh2d9WI3ZxRTs9MNQYLvBlecNfNamct
         VXl7SWUq8duQtFMCrLYgcZtvILuUxEe3XOoCWPnnK7EMbVDFslmoSBELjg3ZXo1TFjZ2
         7nrc0CkXZjQ+Mm+aL4wG+7D8NwcIurb+XYJxmCC9Blt9+QEddvtjuyRiEoUV7ygH6vrW
         NkGfKQjJd5MTT6dw60W2+eC5006o/GUpbjMdmrNaGFtXiyczFNBZr2EcCvefKFTfHacH
         tv0QPfiFr0sjh8N5uy1niNdYnyTl0pA6/0diwuHYu5q2oSD/eXegGRq929PfdPrH62Kd
         +CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2TFOiJdD6/bVUi+HowGp/lkXbvGkSZjNzeuPAsFmZo=;
        b=scDgeC9CYwHj+jboTfDscWR1/li+of7fevZD9Xqm1jX6RRNvxFOP7ayc76Ia+ZFzgm
         /yrk+ELtxJohkadvKlLRq3QQgQ1Fn3zxvSGapSfYUl93S+A7xh9OxrQ3cuZ05W58QVRO
         bW+hKRcGXn5r4/yIDAMQWDx5ho8Ff4i+BzWrUmtzowTlR40M01z9hQTQRQdfELzhxZCG
         k67u7SWsacZFeZkKgVilv3rqRqJSvyRCKEoL1xQLsn8mr2mX+Jq4BFoc51P1BXhzvat0
         g+qRP2MtpgumTFz02OpFAXOwl8pbsCNNy7WDgoZ3klejgklj9MxaEOWDCA/HTS18oB+Q
         Z/xA==
X-Gm-Message-State: AOAM531gSsOqpbrUpK8zOrjImvx1MxkXPTiPI6b/OvvsopxLzugMrNch
        YVunP62av/SoTHOWA4aYQZ8=
X-Google-Smtp-Source: ABdhPJydRKKIbGPJcmnQMsf+qQjxZ2VmsIQ8pfrRLYKH5AeNCcUX+Ys0M5X+iVaGiUaGIkjboYXspg==
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr22586377ejd.268.1629484133925;
        Fri, 20 Aug 2021 11:28:53 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id n10sm3255724ejk.86.2021.08.20.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:28:53 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add analog audio on Quartz64
Date:   Fri, 20 Aug 2021 20:27:31 +0200
Message-Id: <20210820182731.29370-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
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
index b239f314b38a..c974b0e22ac0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -50,6 +50,20 @@ led-diy {
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
@@ -174,8 +188,13 @@ rk817: pmic@20 {
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
@@ -364,9 +383,23 @@ regulator-state-mem {
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
2.32.0

