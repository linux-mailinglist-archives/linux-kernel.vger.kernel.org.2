Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF0362F92
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhDQLbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhDQLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE9BC061760;
        Sat, 17 Apr 2021 04:30:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f8so35247358edd.11;
        Sat, 17 Apr 2021 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKq3KmV45GoK0Thnkb+rqanYcWMZ9fjuF6uc/TWZBZk=;
        b=PEhMasUhF8WIb09xJNUIEjTjvqqQIllOpZfAMlRMR0KJSfbmA2B1jLwI7ww75tECb4
         Tao8WAnKUPHY1Zwh2GI7xg23kw2+0NA1GVf150BS5OJO+VkjybdcG99CIoPXTTtLltKB
         ZEKMLkQ9iMqBLGT9SVuWZnBKCfZrpB6WzBjGt61lm2F5vsmKYB0dCOf8BUc0KDvtpraC
         3rleoPD3eAnghJGTIMbhNfDpJG4nQfit8I8ykb2bL2fo1Gd+T8bvjCKrfNvGqNOQXB2O
         nVID14ulcTIjs0gT08rOXQWJoRkETtG+w3hZWFgO9MOJ8j7MTbys8nqIiThK2JngqthD
         pcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKq3KmV45GoK0Thnkb+rqanYcWMZ9fjuF6uc/TWZBZk=;
        b=sURjF9TQIKoBidmTWAvbst9mdZWWfiwq37FGwQ3YPimm4F4yf4D00Y22BHdRWkNC0Y
         aQFQmgdDgMrShiLUobzIKytrw2srFM5di4DeFhzKDtpOVEGtdZwzw46e1aa3XXeekSPX
         FdcpZ2mvnw1IVj443ixk/Laqo8d7/V6BuC6AQ0muKpp9B/RPgob2K8Sww40AmfJ7N0aS
         uzf26t4AIWi/Nf4D85wTnMI3jh6bVCC8fIuM8pwd5bFZL/02c7uoB2E6Z+6hpODssXCl
         CNSLeudtMeCwI0RnbLACD/YmuyHxd3gXnEzufrwn07YvrzW7umV4nztj3u36yLExZxeV
         49Ww==
X-Gm-Message-State: AOAM531WWYN/HxfZCIyJ96xV3sbXt4H17TdY09Rw/APH2jbKqs4YzpnH
        vm5Ro+shkW413IqM0wCqygI=
X-Google-Smtp-Source: ABdhPJz9jTyw9bu/lBJspSVBQJBzwjKv4oSVk0TOgj5DNBsv+gYfSsQpTtj1u3SPZBCaBf+hEdaYPA==
X-Received: by 2002:aa7:c5c2:: with SMTP id h2mr1108826eds.38.1618659006109;
        Sat, 17 Apr 2021 04:30:06 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:05 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/15] arm64: dts: rockchip: Fix power-controller node names for px30
Date:   Sat, 17 Apr 2021 13:29:42 +0200
Message-Id: <20210417112952.8516-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Use more generic names (as recommended in the device tree specification
or the binding documentation)

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 09baa8a16..2b43c3d72 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -244,20 +244,20 @@
 			#size-cells = <0>;
 
 			/* These power domains are grouped by VD_LOGIC */
-			pd_usb@PX30_PD_USB {
+			power-domain@PX30_PD_USB {
 				reg = <PX30_PD_USB>;
 				clocks = <&cru HCLK_HOST>,
 					 <&cru HCLK_OTG>,
 					 <&cru SCLK_OTG_ADP>;
 				pm_qos = <&qos_usb_host>, <&qos_usb_otg>;
 			};
-			pd_sdcard@PX30_PD_SDCARD {
+			power-domain@PX30_PD_SDCARD {
 				reg = <PX30_PD_SDCARD>;
 				clocks = <&cru HCLK_SDMMC>,
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sdmmc>;
 			};
-			pd_gmac@PX30_PD_GMAC {
+			power-domain@PX30_PD_GMAC {
 				reg = <PX30_PD_GMAC>;
 				clocks = <&cru ACLK_GMAC>,
 					 <&cru PCLK_GMAC>,
@@ -265,7 +265,7 @@
 					 <&cru SCLK_GMAC_RX_TX>;
 				pm_qos = <&qos_gmac>;
 			};
-			pd_mmc_nand@PX30_PD_MMC_NAND {
+			power-domain@PX30_PD_MMC_NAND {
 				reg = <PX30_PD_MMC_NAND>;
 				clocks =  <&cru HCLK_NANDC>,
 					  <&cru HCLK_EMMC>,
@@ -278,14 +278,14 @@
 				pm_qos = <&qos_emmc>, <&qos_nand>,
 					 <&qos_sdio>, <&qos_sfc>;
 			};
-			pd_vpu@PX30_PD_VPU {
+			power-domain@PX30_PD_VPU {
 				reg = <PX30_PD_VPU>;
 				clocks = <&cru ACLK_VPU>,
 					 <&cru HCLK_VPU>,
 					 <&cru SCLK_CORE_VPU>;
 				pm_qos = <&qos_vpu>, <&qos_vpu_r128>;
 			};
-			pd_vo@PX30_PD_VO {
+			power-domain@PX30_PD_VO {
 				reg = <PX30_PD_VO>;
 				clocks = <&cru ACLK_RGA>,
 					 <&cru ACLK_VOPB>,
@@ -301,7 +301,7 @@
 				pm_qos = <&qos_rga_rd>, <&qos_rga_wr>,
 					 <&qos_vop_m0>, <&qos_vop_m1>;
 			};
-			pd_vi@PX30_PD_VI {
+			power-domain@PX30_PD_VI {
 				reg = <PX30_PD_VI>;
 				clocks = <&cru ACLK_CIF>,
 					 <&cru ACLK_ISP>,
@@ -312,7 +312,7 @@
 					 <&qos_isp_wr>, <&qos_isp_m1>,
 					 <&qos_vip>;
 			};
-			pd_gpu@PX30_PD_GPU {
+			power-domain@PX30_PD_GPU {
 				reg = <PX30_PD_GPU>;
 				clocks = <&cru SCLK_GPU>;
 				pm_qos = <&qos_gpu>;
-- 
2.11.0

