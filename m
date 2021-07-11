Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4C3C3D59
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhGKOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhGKOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 10:37:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1DC0613E5;
        Sun, 11 Jul 2021 07:34:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w14so11200386edc.8;
        Sun, 11 Jul 2021 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G4/vKfc2PJjfZ6X6kw4yk+dkdCYzRok+fw9mXUFf5m8=;
        b=oKdZfBRmfRjQ2nC5RuHWchA+ZFmmiWpy/LzF38bR0HrH3juk8rLV2jZHXtQqjEi0XQ
         zwnXrQR2fDoyPcQrmWv+lemhvhswrqk0B86HprJSH8GOHS5hmijnG/Cx5J/NHg1ylxHc
         Loc2xOyFyCHF8OPqQHWVBYCrAl0r6HEbvQVQAEsTQRm0AAeegDP68PH4N8fEepTLw1A8
         cmvenbGrrOk2Xprt9p/ZXr8CD4i+SyzQ5o31AoI6OS9OCb0j7hw6mrf6PPJ+antmS2X1
         1gmYUXKtd+dUeUxnrs2MPYIfiL7wrkXPaAT2KsYj92ANlSKj2nKoCKTqzeN559H1yHV0
         Nvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4/vKfc2PJjfZ6X6kw4yk+dkdCYzRok+fw9mXUFf5m8=;
        b=ieHhIwCz+LIefzj6mj+2uuowXfF6jVpsSclfKE4C/gPdJ+/ieS/ag7INgq9w6piJjs
         LNq52mWF2DcX6V63gh/HKod7P9Xmi9KeQOt2h73PimpTkFcxLsGx5V9q2xjeq10XlcTx
         z2wGeQkZfAMyJ09K12imrrcjAjz1xSfD5WPsq6cYdk4HvRojMmVz++3XA/XtYyHvCyLS
         lBhrDuh2q3qmF2+Hp/g6MfKbcWPE5UAxBgN2VqzbcKnSmmZWyNlkFWximlI8FyzLveBV
         jW5uQQASkIDID0VfRmFHa9bCHD+QI7e1+jYJ9I+Kdb5a5SOAs4BQdg8f1H4l30gJn+H/
         cTGQ==
X-Gm-Message-State: AOAM530ss5V8XH6iQw11g26ruRgf8BAyezdAvFEhQL8yoPVeBidmkgRa
        f+v9FIhunlnySFn3VnENI6w=
X-Google-Smtp-Source: ABdhPJxZrywtkxC9y5RlZG3iDoxJXZHnaFv84JhTwmO+affOXrUL0sp1Ig/rHM/d7sD0A0gZ2yaUCQ==
X-Received: by 2002:aa7:c652:: with SMTP id z18mr1530065edr.361.1626014079744;
        Sun, 11 Jul 2021 07:34:39 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a23sm4687076edt.42.2021.07.11.07.34.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 07:34:39 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: remove interrupt-names from iommu nodes
Date:   Sun, 11 Jul 2021 16:34:29 +0200
Message-Id: <20210711143430.14347-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu driver gets the interrupts by platform_get_irq(),
so remove interrupt-names property from iommu nodes.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9c5a7791a..4dcdcf17c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -987,7 +987,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff900800 0x0 0x40>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "iep_mmu";
 		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -998,7 +997,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "isp_mmu";
 		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1059,7 +1057,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vopb_mmu";
 		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3288_PD_VIO>;
@@ -1109,7 +1106,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff940300 0x0 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vopl_mmu";
 		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk", "iface";
 		power-domains = <&power RK3288_PD_VIO>;
@@ -1252,7 +1248,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff9a0800 0x0 0x100>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vpu_mmu";
 		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
@@ -1263,7 +1258,6 @@
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff9c0440 0x0 0x40>, <0x0 0xff9c0480 0x0 0x40>;
 		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "hevc_mmu";
 		clocks = <&cru ACLK_HEVC>, <&cru HCLK_HEVC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-- 
2.11.0

