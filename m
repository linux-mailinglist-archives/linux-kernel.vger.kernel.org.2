Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368C3376291
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhEGJDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbhEGJDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:03:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6907C061763;
        Fri,  7 May 2021 02:02:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id F21E21F43DC6
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 4/6] ARM: dts: rockchip: rk3036: Remove useless interrupt-names on IOMMU node
Date:   Fri,  7 May 2021 11:02:30 +0200
Message-Id: <20210507090232.233049-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
References: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless interrupt-names property for IOMMU node

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 47a787a12e55..16753dc50bf3 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -140,7 +140,6 @@ vop_mmu: iommu@10118300 {
 		compatible = "rockchip,iommu";
 		reg = <0x10118300 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vop_mmu";
 		clocks = <&cru ACLK_LCDC>, <&cru HCLK_LCDC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-- 
2.25.1

