Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E7326148
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhBZKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:31:32 -0500
Received: from mail.manjaro.org ([176.9.38.148]:51420 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhBZKbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:31:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id DC0343DC0E3E;
        Fri, 26 Feb 2021 11:30:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LGqetle-cRJc; Fri, 26 Feb 2021 11:30:22 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/3] ARM: dts: sun8i: V3s/V3/S3: add dma controller node
Date:   Fri, 26 Feb 2021 11:30:26 +0100
Message-Id: <20210226103028.729172-2-t.schramm@manjaro.org>
In-Reply-To: <20210226103028.729172-1-t.schramm@manjaro.org>
References: <20210226103028.729172-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s, V3 and S3 SoCs have a dma controller. Add it to the dts.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index f8f19d8fa795..89286d3d35d1 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -163,6 +163,15 @@ syscon: system-control@1c00000 {
 			ranges;
 		};
 
+		dma: dma-controller@1c02000 {
+			compatible = "allwinner,sun8i-v3s-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		tcon0: lcd-controller@1c0c000 {
 			compatible = "allwinner,sun8i-v3s-tcon";
 			reg = <0x01c0c000 0x1000>;
-- 
2.30.1

