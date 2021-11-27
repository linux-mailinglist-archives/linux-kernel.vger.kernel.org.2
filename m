Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B422645FF2F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355293AbhK0OZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349146AbhK0OXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:23:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA544C061746;
        Sat, 27 Nov 2021 06:19:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t9so8237125wrx.7;
        Sat, 27 Nov 2021 06:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wFuxDU6XuWJPQiYwJY3rcE0CQIucc2FP/TwiBCR7CM=;
        b=oDf9Td0LQWW6yd0qcV4bAzAIio053nSL93uf21Zr6S6ZK0esGNNF2itq6zCtD1NPaC
         reFQTtWpZPcIIUqigbnRuxMrgWo9hETNjrfJnTDeI2bUotBbD1mZs8nU7O93pCc6Ou3k
         Dtg4UHtknxhfrPEoJ3uphlJsySTmA6YJwZq+RIUQtFx+Mif/IlxCkOlItxEu1sILGaRb
         bp+gwsJVyLaKoOx0jC1Ao4Sd5Jku8u5gYzT1KHF3UUdhbp4IDMzk49rUZEkp/khtJblx
         n4T+VNlvLazXXO0+Bm1UMXX/bik9lL3C6lsMBJFqRryD1PRHjzxefq/J6W9BqOpUhqGg
         zqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wFuxDU6XuWJPQiYwJY3rcE0CQIucc2FP/TwiBCR7CM=;
        b=vGNuCnrDfVVgmMeOk8ZGwXo0XJYnYCMGZM2H9ApzM4NM1IFYo1/36OHkKq44h2jhu7
         6o1BbJr2rsfk9fvPlBQw1LjuCh2+uSjWZiREVAwWs8k55DEMk+IqW/7q7JPGXQtFwaF7
         w9f80Pr+oeIcvgsSK3jFmmUIQHkRBkcI+TuG0PtHdu15k2/wSEZQIeIx9KCsrTgID9QL
         LGj99O4dZKjWAUL4lt2jHB+ee3uhV4vSX2Rneq4HKBDGlbApsKT0C+lLYad9BwcseHMc
         KqTYyCahvjqTS1DmGBIT7ezJF9Kdl/7ep6QFLAa8L+RogqDOMc+WPST+qIV2y/03PJoI
         dmuw==
X-Gm-Message-State: AOAM530JS12xsqfGoHZb81WJw8kxh/xm2Bk/BU3jK/EvMK3KzUg6SCeO
        XhGki9ZvsxZsILCI6DfqumI=
X-Google-Smtp-Source: ABdhPJxz/q4qsNt0TFfidBSuwLFbxLSBCnsbvAP17diM4xDFsKLyto01NbYiDUP6zBNQxJRjlvNybA==
X-Received: by 2002:a5d:47c9:: with SMTP id o9mr21402130wrc.348.1638022788307;
        Sat, 27 Nov 2021 06:19:48 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1sm8509839wrn.63.2021.11.27.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:19:48 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Add spi nodes on rk356x
Date:   Sat, 27 Nov 2021 15:19:08 +0100
Message-Id: <20211127141910.12649-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the four spi nodes (spi0, spi1, spi2, spi3) to the
rk356x dtsi. These are from the downstream device tree, though
I have double-checked that their interrupts and DMA numbers are
correct. I have also tested spi1 with an SPI device.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 46d9552f6028..a058a9e9d5d7 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -39,6 +39,10 @@ aliases {
 		serial7 = &uart7;
 		serial8 = &uart8;
 		serial9 = &uart9;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
 	};
 
 	cpus {
@@ -742,6 +746,66 @@ wdt: watchdog@fe600000 {
 		clock-names = "tclk", "pclk";
 	};
 
+	spi0: spi@fe610000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe610000 0x0 0x1000>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 20>, <&dmac0 21>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0m0_cs0 &spi0m0_cs1 &spi0m0_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi1: spi@fe620000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe620000 0x0 0x1000>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 22>, <&dmac0 23>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi1m0_cs0 &spi1m0_cs1 &spi1m0_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi2: spi@fe630000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe630000 0x0 0x1000>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_SPI2>, <&cru PCLK_SPI2>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 24>, <&dmac0 25>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi2m0_cs0 &spi2m0_cs1 &spi2m0_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi3: spi@fe640000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe640000 0x0 0x1000>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_SPI3>, <&cru PCLK_SPI3>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 26>, <&dmac0 27>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi3m0_cs0 &spi3m0_cs1 &spi3m0_pins>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	uart1: serial@fe650000 {
 		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
 		reg = <0x0 0xfe650000 0x0 0x100>;
-- 
2.34.1

