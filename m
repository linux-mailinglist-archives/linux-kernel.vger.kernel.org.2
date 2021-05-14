Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA3380A86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhENNn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:43:58 -0400
Received: from mail.manjaro.org ([176.9.38.148]:33182 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhENNnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:43:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id C4B47220A62;
        Fri, 14 May 2021 15:42:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YXMWuC8QmCu1; Fri, 14 May 2021 15:42:34 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v3 1/7] ARM: dts: sun8i: v3s: add DMA controller to v3s dts
Date:   Fri, 14 May 2021 15:43:59 +0200
Message-Id: <20210514134405.2097464-2-t.schramm@manjaro.org>
In-Reply-To: <20210514134405.2097464-1-t.schramm@manjaro.org>
References: <20210514134405.2097464-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3s and V3 feature a DMA controller.
This commit adds it to the V3s dtsi.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index eb4cb63fef13..f0296ab46137 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
+ * Copyright (C) 2021 Tobias Schramm <t.schramm@manjaro.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -172,6 +173,15 @@ nmi_intc: interrupt-controller@1c000d0 {
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
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
2.31.1

