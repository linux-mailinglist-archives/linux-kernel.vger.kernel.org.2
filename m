Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A633A376292
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhEGJDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhEGJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:03:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C3C061763;
        Fri,  7 May 2021 02:02:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id AA6481F43DCB
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 5/6] ARM64: dts: rockchip: rk3036: Remove useless interrupt-names properties
Date:   Fri,  7 May 2021 11:02:31 +0200
Message-Id: <20210507090232.233049-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
References: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless interrupt-names properties for IOMMU nodes

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index c45b0cfcae09..47d0c29fd8d0 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1068,7 +1068,6 @@ vopb_mmu: iommu@ff460f00 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff460f00 0x0 0x100>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vopb_mmu";
 		clocks = <&cru ACLK_VOPB>, <&cru HCLK_VOPB>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power PX30_PD_VO>;
@@ -1109,7 +1108,6 @@ vopl_mmu: iommu@ff470f00 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff470f00 0x0 0x100>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vopl_mmu";
 		clocks = <&cru ACLK_VOPL>, <&cru HCLK_VOPL>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power PX30_PD_VO>;
-- 
2.25.1

