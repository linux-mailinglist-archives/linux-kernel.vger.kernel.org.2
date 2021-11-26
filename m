Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86F45F126
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378331AbhKZP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhKZPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:55:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E415AC0619EB;
        Fri, 26 Nov 2021 07:44:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 137so8502225wma.1;
        Fri, 26 Nov 2021 07:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cSeWfhEbavNzmvOss4FAgbn9tZPKzO6/SplA5Hffp4=;
        b=G6mcWzcYp7e91PM3gab7OIfErFk73WW8RZYGaUEooLYuCWmVbOwubIwAVoZP05Bdm0
         ZwbvJI4Z4NvnoN9wu0eKqJfukOznzNwNDc+LwzdHmFTuuT2Emhhr7pZJP9ZnSzaWmLHP
         Iiz6QiWSSQKQBc8KNqOmUPPAnZ/cTIGrTKY7sqU+Q9Cdg47buxsVlIJHTTFrcnc60I+X
         hbD5XLTVJhsuC7kJQv+J3EmQ0Bmbduvka2Tf8zfEEDo3tG2MuZ1+IXqYiVK71I9yb76D
         sdJzo26ZbBfQyas48wF+XY3vrr6UyjWC8sQBt6aT6Lnhbb2XUP3JUTmJUjqMulKlU0nO
         aS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cSeWfhEbavNzmvOss4FAgbn9tZPKzO6/SplA5Hffp4=;
        b=otw8eoG2/Z1vgYLDczJBjOyboiYoY0zpwGk2YuMnbf2it6VQHdQNbUyaOOVzwJUzsu
         X4DKqnabSrqPywEPoWCkMKkVcRk2KDFS9ndDNRJDPWS7DfoylCl7NrHQ3zaryfGmtaMs
         r8RY2OJqMrsk6RWAD9ShnizcuIegguIeX95rWKeci1IpsPMczVDGz8qNvueGZhx7oTSK
         O5R23oK4gEhMMe7l7+nFZeY4vTTOVoBMBv4D5qvNG3aCmC6M6h2IJ/z6MTxUAZymcRFI
         y1FZtA38spxpKeTmUXEQ3dKFLBB7Ydqx6VFpKx0ylYW+WoDS57nCgBLAEoiSvDodYu6H
         Hghw==
X-Gm-Message-State: AOAM533I7naxD5D5F2flUDbEjc2kjAI6i8P9wVBOo3wFRNF6CGT8kyhH
        VeH2iEneUXMJHU7qvKIQqrY=
X-Google-Smtp-Source: ABdhPJwXJqy2sr4dEeGSQAcAmKe4wzYDxJAqSpm+IEb8Foz3+w8Uyrezn/76WHNM8c4aI/9AZIsmrg==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr16535310wmc.89.1637941443439;
        Fri, 26 Nov 2021 07:44:03 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p13sm11372400wmi.0.2021.11.26.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:44:03 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: Add spi nodes on rk356x
Date:   Fri, 26 Nov 2021 16:43:43 +0100
Message-Id: <20211126154344.724316-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
References: <20211126154344.724316-1-frattaroli.nicolas@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 68 ++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 46d9552f6028..57c0197cc65a 100644
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
@@ -742,6 +746,70 @@ wdt: watchdog@fe600000 {
 		clock-names = "tclk", "pclk";
 	};
 
+	spi0: spi@fe610000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe610000 0x0 0x1000>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru CLK_SPI0>, <&cru PCLK_SPI0>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 20>, <&dmac0 21>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default", "high_speed";
+		pinctrl-0 = <&spi0m0_cs0 &spi0m0_cs1 &spi0m0_pins>;
+		pinctrl-1 = <&spi0m0_cs0 &spi0m0_cs1 &spi0m0_pins_hs>;
+		status = "disabled";
+	};
+
+	spi1: spi@fe620000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe620000 0x0 0x1000>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 22>, <&dmac0 23>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default", "high_speed";
+		pinctrl-0 = <&spi1m0_cs0 &spi1m0_cs1 &spi1m0_pins>;
+		pinctrl-1 = <&spi1m0_cs0 &spi1m0_cs1 &spi1m0_pins_hs>;
+		status = "disabled";
+	};
+
+	spi2: spi@fe630000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe630000 0x0 0x1000>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru CLK_SPI2>, <&cru PCLK_SPI2>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 24>, <&dmac0 25>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default", "high_speed";
+		pinctrl-0 = <&spi2m0_cs0 &spi2m0_cs1 &spi2m0_pins>;
+		pinctrl-1 = <&spi2m0_cs0 &spi2m0_cs1 &spi2m0_pins_hs>;
+		status = "disabled";
+	};
+
+	spi3: spi@fe640000 {
+		compatible = "rockchip,rk3568-spi", "rockchip,rk3066-spi";
+		reg = <0x0 0xfe640000 0x0 0x1000>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru CLK_SPI3>, <&cru PCLK_SPI3>;
+		clock-names = "spiclk", "apb_pclk";
+		dmas = <&dmac0 26>, <&dmac0 27>;
+		dma-names = "tx", "rx";
+		pinctrl-names = "default", "high_speed";
+		pinctrl-0 = <&spi3m0_cs0 &spi3m0_cs1 &spi3m0_pins>;
+		pinctrl-1 = <&spi3m0_cs0 &spi3m0_cs1 &spi3m0_pins_hs>;
+		status = "disabled";
+	};
+
 	uart1: serial@fe650000 {
 		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
 		reg = <0x0 0xfe650000 0x0 0x100>;
-- 
2.34.0

