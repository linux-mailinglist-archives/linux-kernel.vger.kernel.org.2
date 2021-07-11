Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB93C3C3D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhGKOhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhGKOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:37:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC24C0613DD;
        Sun, 11 Jul 2021 07:34:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id go30so948897ejc.8;
        Sun, 11 Jul 2021 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KMpCtnfaLEg5DaHCw+GoHXChsJFsIMroC3QE08V4048=;
        b=EZpEgBlLKsCstEcEydwcr4vun9+LrNiEq5MFO8775o54SAj02ymkNSFN+culRhxVSm
         +rxheICDsx/zjDVGnnbgY76XTWaFaoONBwFBRmR2TLdTRjbk3LJlA/1gvRwihOEvVX7B
         ET0RixME2xpU79S6ogcbb9dSUZNd50V7ygn//qOu6BNhfcN4kTFhRMS9EDNSfbEE6cYb
         lXYQU4ZMeX3onmmDdksU35IXakP700XVsEOUkep7YUdpAW7smYtIX7gSJRCAsokHxYJo
         ZzZl5xqUnieNLnhjtb8oteMBB7yL4jgtCDcThjTZm3wV4BTJ2I6/xSwmpjBDUcjin2hZ
         4wKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KMpCtnfaLEg5DaHCw+GoHXChsJFsIMroC3QE08V4048=;
        b=puWhqXrnqqsFjDHqJKTFTaWVnKMw069HkNWX5qMdG6LEU7yrk2SJnVZ5HCW9/qsqTD
         qr5pQ4Umbn/5pA2sYZLf3H1nCCOflzeoV5FLbXndFxBgFs6pLOIkFoL+OFWpBTmhL23U
         2OFvrrdp6Yn6P0qegDCRSZoDVywZYWHkpukDv2TwzIubx6mtc8J3K60uEIPG4vPnRFZB
         H63eYPW4xepFYxJHWQUqacNsqr52BTM0MIOkvU/y+Pgz8HALQkG/HlfnV6TYBta8d0fU
         IZsSgFyd3Ei6HbEAg6EyLGBTErT6RkN5pAbOAlDvQ2xdJAKZNh7JKPxhmPrq+zwDQFW6
         dNbg==
X-Gm-Message-State: AOAM531x80RCYtmoCQgJBd4mUdhj6ZhvkZXkUpg0q1QXQ0CyYFIkb6CM
        7Pnsi/zCmK0tHft3KOvaQZAW15WmQoB3mA==
X-Google-Smtp-Source: ABdhPJydr21UCMUsXHZCCZ+viDDPIXWW3OglmgYv2AhQ0Jl9vV1o7k14ED90Syn/Ta2DpBDDClurJQ==
X-Received: by 2002:a17:906:1344:: with SMTP id x4mr48974884ejb.44.1626014080406;
        Sun, 11 Jul 2021 07:34:40 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a23sm4687076edt.42.2021.07.11.07.34.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 07:34:40 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: remove interrupt-names from iommu nodes
Date:   Sun, 11 Jul 2021 16:34:30 +0200
Message-Id: <20210711143430.14347-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210711143430.14347-1-jbx6244@gmail.com>
References: <20210711143430.14347-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu driver gets the interrupts by platform_get_irq(),
so remove interrupt-names property from iommu nodes.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 5 -----
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 5 -----
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 8 --------
 3 files changed, 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 8c821acb2..becc1c61b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -623,7 +623,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff330200 0 0x100>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "h265e_mmu";
 		clocks = <&cru ACLK_H265>, <&cru PCLK_H265>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -634,7 +633,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff340800 0x0 0x40>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vepu_mmu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -656,7 +654,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff350800 0x0 0x40>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vpu_mmu";
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -667,7 +664,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "rkvdec_mmu";
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -700,7 +696,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff373f00 0x0 0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vop_mmu";
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 4c64fbefb..4217897cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -709,7 +709,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff900800 0x0 0x100>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "iep_mmu";
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -721,7 +720,6 @@
 		reg = <0x0 0xff914000 0x0 0x100>,
 		      <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "isp_mmu";
 		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -733,7 +731,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vop_mmu";
 		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -745,7 +742,6 @@
 		reg = <0x0 0xff9a0440 0x0 0x40>,
 		      <0x0 0xff9a0480 0x0 0x40>;
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "hevc_mmu";
 		clocks = <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -757,7 +753,6 @@
 		reg = <0x0 0xff9a0800 0x0 0x100>;
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vepu_mmu", "vdpu_mmu";
 		clocks = <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3871c7fd8..aa5d7dca3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1240,7 +1240,6 @@
 		reg = <0x0 0xff650000 0x0 0x800>;
 		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vepu", "vdpu";
 		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
 		clock-names = "aclk", "hclk";
 		iommus = <&vpu_mmu>;
@@ -1251,7 +1250,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff650800 0x0 0x40>;
 		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vpu_mmu";
 		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1273,7 +1271,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff660480 0x0 0x40>, <0x0 0xff6604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vdec_mmu";
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VDU>;
@@ -1284,7 +1281,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff670800 0x0 0x40>;
 		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "iep_mmu";
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1666,7 +1662,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff8f3f00 0x0 0x100>;
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vopl_mmu";
 		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VOPL>;
@@ -1723,7 +1718,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff903f00 0x0 0x100>;
 		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vopb_mmu";
 		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VOPB>;
@@ -1761,7 +1755,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "isp0_mmu";
 		clocks = <&cru ACLK_ISP0_WRAPPER>, <&cru HCLK_ISP0_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1773,7 +1766,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "isp1_mmu";
 		clocks = <&cru ACLK_ISP1_WRAPPER>, <&cru HCLK_ISP1_WRAPPER>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-- 
2.11.0

