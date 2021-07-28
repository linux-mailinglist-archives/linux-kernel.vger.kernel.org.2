Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4361C3D94E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhG1SBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhG1SBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42423C061765;
        Wed, 28 Jul 2021 11:01:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f22so3080499qke.10;
        Wed, 28 Jul 2021 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkK6x6zm6GWAYlSexAP9I420ulpovKLeZWcigiEH4qE=;
        b=rfa/0mI5PgYXeAiHADQGinO4cVfzsm2WrTDv0/QZj8NgCuAWcQaxNYTB5alyA4Dw+j
         qJLSw4gdjZ8yoZXH18o5NuSyG0N3G+sulL4Zj5HW8Ldvkf1x41jpi/jD2ravFQbCrPTb
         3FUz+iO9FO9fNzctfNas7AsGyZpa0386kPqk8SHToxTJkZMGW+nrzJVlr++zxSdUQ5uE
         jwsM00xrqXmjfIvBTZeAs5HG15EW7U6kCUBEGpZpu46NipWZbDdZ9KjogLsBFmkP5o8O
         7GC0Yq88iilX8Xn7epXTqF0ML6XMlb4cQFLf7NGxRNGoHSA/S1OXvcmtRCNpURHIOdAR
         aXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkK6x6zm6GWAYlSexAP9I420ulpovKLeZWcigiEH4qE=;
        b=QJCNB7TZGb/NqmrwRZeFvWe0HTpM4sPzG6mh2cuoca8nipUuU7lDpbAoDI+Ia1pgUF
         s+e06rIr2go1L4Mhyteq5rvg5NKcOIFNoct1/7YmICKZ/aPTTyjPcQe0h3paCzZkzEyq
         4ZizJBPSxSND1fZcw0+bpiVwaC9xfvhyG0hJhRbYNNlSAoE62vXtq9KGX0f6CjFsb395
         2786Y3QdHn+0hYqlAoOsAi1fiq1pArv5KZpeijm8dPeCEJvkt/VyXd10oSfJAeUPU985
         CjvWtS9fM5HEsMucjB9Ge4rZ575m8RoN158gCOdbFBZu22EQd4BsjbOvTsmhQ+nPp0ob
         ZTGw==
X-Gm-Message-State: AOAM530us5tQkFPEm/V20VYqH4weXBIMErHW+9YtZhmwgMcCMJH3w+rU
        vSB0j/0c4InuamHNNBZFXUs=
X-Google-Smtp-Source: ABdhPJweete4r2BIayV6eiYOYWBt8ZtcIm0PWhCwh6+YQZB/vt+uFHtHFfdC+CjMTubMKuVK3Pileg==
X-Received: by 2002:a37:7141:: with SMTP id m62mr922459qkc.496.1627495263435;
        Wed, 28 Jul 2021 11:01:03 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:01:02 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: rockchip: enable gmac node on quartz64-a
Date:   Wed, 28 Jul 2021 14:00:33 -0400
Message-Id: <20210728180034.717953-8-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the gmac controller on the Pine64 Quartz64 Model A.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a3cdb6c2bec6..b239f314b38a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -11,6 +11,7 @@ / {
 	compatible = "pine64,quartz64-a", "rockchip,rk3566";
 
 	aliases {
+		ethernet0 = &gmac1;
 		mmc0 = &sdmmc0;
 		mmc1 = &sdhci;
 	};
@@ -19,6 +20,13 @@ chosen: chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	gmac1_clkin: external-gmac1-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "gmac1_clkin";
+		#clock-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -116,6 +124,29 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru SCLK_GMAC1>, <&gmac1_clkin>;
+	clock_in_out = "input";
+	phy-supply = <&vcc_3v3>;
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m0_miim
+		     &gmac1m0_tx_bus2
+		     &gmac1m0_rx_bus2
+		     &gmac1m0_rgmii_clk
+		     &gmac1m0_clkinout
+		     &gmac1m0_rgmii_bus>;
+	snps,reset-gpio = <&gpio0 RK_PC3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	phy-handle = <&rgmii_phy1>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -336,6 +367,13 @@ regulator-state-mem {
 	};
 };
 
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
-- 
2.25.1

