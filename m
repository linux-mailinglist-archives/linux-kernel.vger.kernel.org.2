Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEE412673
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384675AbhITS6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385851AbhITSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC4C761184;
        Mon, 20 Sep 2021 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632160613;
        bh=SvqoDHMQRz9kNEKqEJuI5cMDNIKcZUTM+5LaGIm43aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVdm+/LKQlTGEHyX0fU9o8EU/2zTZA9yoVMdjCwO5MVyBKTT/bxst7vcB8eHYWpEb
         jiWvS9yzOihUo+kHuBIPFMrD25tkcPn73rhT7aNM13OAJ6JR93e2Xz1vhwsDMEMmMg
         nUKcY/B5OV3kQm96oVt0snDc+MWe0/JQ7Io6ER16GACH+AlJU7qoXLAMplrSYGiHs1
         S3gdq24MrIKsJmBVfJJnySQENUyiCtrVyfpnK8YmM6FaIUV7npA7n8PE5mPVjmAFQf
         6G4rccr0xv1k+cRHkF2EMNhRwsjnST6cEnhxBmbFHxMS6lxOB4AhRnBufXZZKCjqVB
         52tHbnpcZpdKQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 857095F861; Tue, 21 Sep 2021 01:56:51 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399: Hook up DMA for UARTs
Date:   Tue, 21 Sep 2021 01:56:47 +0800
Message-Id: <20210920175647.13008-2-wens@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920175647.13008-1-wens@kernel.org>
References: <20210920175647.13008-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The RK3399 has two DMA controllers, one of which is wired up to work
with the SPI controllers and UARTs. The SPI controllers are already
hooked up, but the UARTs aren't.

Add the "dmas" and "dma-names" to the UART device nodes to hook up DMA.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3871c7fd83b0..87d6e4eb1337 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -608,6 +608,8 @@ uart0: serial@ff180000 {
 		reg = <0x0 0xff180000 0x0 0x100>;
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 0>, <&dmac_peri 1>;
+		dma-names = "tx", "rx";
 		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -621,6 +623,8 @@ uart1: serial@ff190000 {
 		reg = <0x0 0xff190000 0x0 0x100>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 2>, <&dmac_peri 3>;
+		dma-names = "tx", "rx";
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -634,6 +638,8 @@ uart2: serial@ff1a0000 {
 		reg = <0x0 0xff1a0000 0x0 0x100>;
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 4>, <&dmac_peri 5>;
+		dma-names = "tx", "rx";
 		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -647,6 +653,8 @@ uart3: serial@ff1b0000 {
 		reg = <0x0 0xff1b0000 0x0 0x100>;
 		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 6>, <&dmac_peri 7>;
+		dma-names = "tx", "rx";
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -1142,6 +1150,8 @@ uart4: serial@ff370000 {
 		reg = <0x0 0xff370000 0x0 0x100>;
 		clocks = <&pmucru SCLK_UART4_PMU>, <&pmucru PCLK_UART4_PMU>;
 		clock-names = "baudclk", "apb_pclk";
+		dmas = <&dmac_peri 8>, <&dmac_peri 9>;
+		dma-names = "tx", "rx";
 		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
-- 
2.30.2

