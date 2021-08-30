Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CBB3FB7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhH3OOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:14:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33886 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237021AbhH3OOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:14:25 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mKi2T-0008I3-IP; Mon, 30 Aug 2021 16:13:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jacopo@jmondi.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: add isp node for px30
Date:   Mon, 30 Aug 2021 16:13:17 +0200
Message-Id: <20210830141318.66744-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Add the rkisp1 node and iommu for the px30 soc.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 64f643145688..500ef3af2a49 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1189,6 +1189,47 @@ vopl_mmu: iommu@ff470f00 {
 		status = "disabled";
 	};
 
+	isp: isp@ff4a0000 {
+		compatible = "rockchip,px30-cif-isp"; /*rk3326-rkisp1*/
+		reg = <0x0 0xff4a0000 0x0 0x8000>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "isp", "mi", "mipi";
+		clocks = <&cru SCLK_ISP>,
+			 <&cru ACLK_ISP>,
+			 <&cru HCLK_ISP>,
+			 <&cru PCLK_ISP>;
+		clock-names = "isp", "aclk", "hclk", "pclk";
+		iommus = <&isp_mmu>;
+		phys = <&csi_dphy>;
+		phy-names = "dphy";
+		power-domains = <&power PX30_PD_VI>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+
+	isp_mmu: iommu@ff4a8000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff4a8000 0x0 0x100>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power PX30_PD_VI>;
+		rockchip,disable-mmu-reset;
+		#iommu-cells = <0>;
+	};
+
 	qos_gmac: qos@ff518000 {
 		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff518000 0x0 0x20>;
-- 
2.29.2

