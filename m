Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A063808A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhENLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhENLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:38:11 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25737C061574;
        Fri, 14 May 2021 04:37:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 7BD8C222567;
        Fri, 14 May 2021 13:36:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YuOpJ9Xe6iI3; Fri, 14 May 2021 13:36:55 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        David Wu <david.wu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 3/3] arm64: dts: rockchip: add gmac to rk3308 dts
Date:   Fri, 14 May 2021 13:38:13 +0200
Message-Id: <20210514113813.2093534-4-t.schramm@manjaro.org>
In-Reply-To: <20210514113813.2093534-1-t.schramm@manjaro.org>
References: <20210514113813.2093534-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3308 SoC has a gmac with only the RMII interface exposed. This
commit adds it to the RK3308 dtsi.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 0c5fa9801e6f..b815ce73e5c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -637,6 +637,28 @@ nfc: nand-controller@ff4b0000 {
 		status = "disabled";
 	};
 
+	gmac: ethernet@ff4e0000 {
+		compatible = "rockchip,rk3308-gmac";
+		reg = <0x0 0xff4e0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX_TX>,
+			 <&cru SCLK_MAC_RX_TX>, <&cru SCLK_MAC_REF>,
+			 <&cru SCLK_MAC>, <&cru ACLK_MAC>,
+			 <&cru PCLK_MAC>, <&cru SCLK_MAC_RMII>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_ref",
+			      "clk_mac_refout", "aclk_mac",
+			      "pclk_mac", "clk_mac_speed";
+		phy-mode = "rmii";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rmii_pins &mac_refclk_12ma>;
+		resets = <&cru SRST_MAC_A>;
+		reset-names = "stmmaceth";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
-- 
2.31.1

