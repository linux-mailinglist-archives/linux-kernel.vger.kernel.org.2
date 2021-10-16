Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C61430240
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhJPK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbhJPK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:56:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFBC061765;
        Sat, 16 Oct 2021 03:54:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so53356104lfa.11;
        Sat, 16 Oct 2021 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wi/go2f54ZbFfXhsHlUc3orIWIsyjFbHjZPbW+7SsAo=;
        b=mm0NoWBd/yh40pLFmYxh4KC3h1iEnZuhD97go3OXuJu2tfNMkRp5zufOro5MtTKo80
         IVk5sOPQKgMaIKtZQk7xQJ88+qGdfeXuMI/RRN0qoZ5qhl1i6h82btNMHwV1KHpYvQX1
         sFY1Rniuur2YtuXXrWx4n3jC47xoEv9ff/N+ZFRqyRMmUrOD4pDSxU8XYXz9JCpDdBiU
         2XObNpz9YGikcj3ilQxdfJhpBsI4JIfNkYAI+d86XrJV55EL6fzBJr7iWAet/pIxJr19
         /G8iZUMFuEAYuCiX0n7GoimqD75H6Lm+afrUBznQmO6M+zdsPNgjGA5M6U3Af/Uufb3l
         9QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wi/go2f54ZbFfXhsHlUc3orIWIsyjFbHjZPbW+7SsAo=;
        b=oFoQrrYBjxaSCHa6AH6o1nGiL/RXFjYNc4Kgubd8wfgAvuP9JABRaeijN2Cy456ufd
         hVjs/GAJINbtf4a/Yt4tnmrg4m0J22kpUZAzJO2ncYS66lBxzFGaMfejKTEK85Q4IAb6
         SpSX2QbiyxQC4gJUV7uURWOc14QCI/rRIHhK5PXskxPME6h0gbteoyiP1MdOw1NYIwb1
         m+REHsfMnEQ4ZMc4jR5ec8/n0bOCEv1c6dRrMb8L+q2Jn9lCXfG7fesAmxlLNiLubOd6
         nuML3b67TbtRAq2vANBKha3nhm5kNpQaXSmdTiVZgmNVp8F2Ji6F1VZHyLcVvJK+xIbn
         aI7g==
X-Gm-Message-State: AOAM532GuzKfb7B3sO1RWId5r3x6X5k8JPp8GCTq8YrCCoK7e+a2ubc0
        NpPqLTaBYJ7UjdRAidpUcrUmnqvFn/M=
X-Google-Smtp-Source: ABdhPJx0lDdpb3RXSHcHSQ++uPgL5lbFYzlr1mpV7ObRZ57GyoodD3AUn7zkOb63SBfoN/XoNEbOdw==
X-Received: by 2002:a05:6512:150:: with SMTP id m16mr16762581lfo.331.1634381689825;
        Sat, 16 Oct 2021 03:54:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r3sm814224lfc.131.2021.10.16.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:54:49 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: Add analog audio on Quartz64
Date:   Sat, 16 Oct 2021 12:53:53 +0200
Message-Id: <20211016105354.116513-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
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
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a244f7b87e38..f1261f25cb35 100644
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
@@ -392,6 +411,16 @@ regulator-state-mem {
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
2.33.1

