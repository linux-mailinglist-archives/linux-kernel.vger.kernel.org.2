Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D163B0160
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFVKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:31:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42106 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVKb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:31:26 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lvdeX-00031Z-Vt; Tue, 22 Jun 2021 12:29:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com
Subject: [PATCH 10/10] arm64: dts: rockchip: add watchdog to rk3568
Date:   Tue, 22 Jun 2021 12:29:07 +0200
Message-Id: <20210622102907.99242-2-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210622102907.99242-1-heiko@sntech.de>
References: <20210622102907.99242-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add the watchdog node to rk3568.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 33db226b46cb..e9fa795b379e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -443,6 +443,14 @@ i2c5: i2c@fe5e0000 {
 		status = "disabled";
 	};
 
+	wdt: watchdog@fe600000 {
+		compatible = "rockchip,rk3568-wdt", "snps,dw-wdt";
+		reg = <0x0 0xfe600000 0x0 0x100>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru TCLK_WDT_NS>, <&cru PCLK_WDT_NS>;
+		clock-names = "tclk", "pclk";
+	};
+
 	uart1: serial@fe650000 {
 		compatible = "rockchip,rk3568-uart", "snps,dw-apb-uart";
 		reg = <0x0 0xfe650000 0x0 0x100>;
-- 
2.29.2

