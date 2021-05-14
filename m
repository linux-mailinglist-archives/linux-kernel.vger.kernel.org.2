Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029B7380A89
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhENNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:44:00 -0400
Received: from mail.manjaro.org ([176.9.38.148]:33214 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234003AbhENNnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:43:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 8A96C221198;
        Fri, 14 May 2021 15:42:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gTEIUq_ewz4f; Fri, 14 May 2021 15:42:35 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v3 2/7] ARM: dts: sun8i: v3s: add DMA properties to peripherals supporting DMA
Date:   Fri, 14 May 2021 15:44:00 +0200
Message-Id: <20210514134405.2097464-3-t.schramm@manjaro.org>
In-Reply-To: <20210514134405.2097464-1-t.schramm@manjaro.org>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DMA properties to all peripherals supporting DMA on the
Allwinner V3s, enabling accelerated data transfer to them.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index f0296ab46137..3eaa8703e2ac 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -285,6 +285,8 @@ crypto@1c15000 {
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_CE>;
 			reset-names = "ahb";
 		};
@@ -446,6 +448,8 @@ uart0: serial@1c28000 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART0>;
+			dmas = <&dma 6>, <&dma 6>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
@@ -457,6 +461,8 @@ uart1: serial@1c28400 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART1>;
+			dmas = <&dma 7>, <&dma 7>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
@@ -468,6 +474,8 @@ uart2: serial@1c28800 {
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART2>;
+			dmas = <&dma 8>, <&dma 8>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_UART2>;
 			pinctrl-0 = <&uart2_pins>;
 			pinctrl-names = "default";
@@ -547,6 +555,8 @@ spi0: spi@1c68000 {
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_pins>;
 			resets = <&ccu RST_BUS_SPI0>;
-- 
2.31.1

