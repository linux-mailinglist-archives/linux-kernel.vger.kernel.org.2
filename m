Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C9361B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbhDPIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhDPIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA54C061574;
        Fri, 16 Apr 2021 01:05:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i3so5501248edt.1;
        Fri, 16 Apr 2021 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKq3KmV45GoK0Thnkb+rqanYcWMZ9fjuF6uc/TWZBZk=;
        b=QAK0m+2Ktjo4jCGtKjxWzKfZLS07us4t2oJdDBfhHSqcHOnCuBqjYvHxxlD/SxzWEt
         MNSguBWKJGnp2qKvNo8TzwGEm41sH9WP7jzsIsVDcSZdTg8n04foMRDXn51FlMAnDk9H
         i0TixkLKdQW5vzGcuozk/8NRbXUwxTwiY+0yIPNttrW2sKYgXerPym+HXx2KM2xgpoLq
         C1I3cL5gFsBhOZnSCP45xHD9IoPL+8FlNHT4KAmqAROpA0AtKIuSQ4M9qPy2gcG/RNHJ
         IRd7zyvubfV5LjUPtoXhBxMJG9hpjbyo3HdT3DYf3mlK6Suo2yGStaPZvcgHY6wZYZ6m
         P+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKq3KmV45GoK0Thnkb+rqanYcWMZ9fjuF6uc/TWZBZk=;
        b=aRb3T1ZYV2gynvQ/kA76W+tUZ6oDPHodeg9Ku8qoiwym01+4Na0CaeWuNiLt8NaqoL
         M7qAQhNQN6AFtyVQlKLED9hn8achbpMUwltZqM/lIu0k+aQz9lBSzX33WLv2qWA+uyXW
         HTglhm/37gyR5e9uxU3DevVypb+H5bdSdGQTXOSinRY9iqosLrrTEclVlLPzntjnc+Lh
         AKPRy0F6cbmZ46LlWryvVxx5rWRGyniTBEcQ/zsf37NkMGEXBCQJvBs7j3mn81KcBNo9
         uj+KeukNAJsaVbBbtsbV0iu2+RfVoCuYexM0YEoUoHoBMr0TdRCsOGAI696RD1EdHN/E
         plCw==
X-Gm-Message-State: AOAM533wQm8+wbO1H3jqZVovFg6EJJSQZyTi+kA4kdOLodSp1Zk/AAo9
        Lz212Qcfwe5fW+Uj3x2TlcA=
X-Google-Smtp-Source: ABdhPJwm4LfKIikXTUkxeMDmmC/gw3VFpQzFU7OMCfQHwPepJ8PPF3l43WuWywR9p9t52+fo+MLQlg==
X-Received: by 2002:a50:9feb:: with SMTP id c98mr391891edf.104.1618560311568;
        Fri, 16 Apr 2021 01:05:11 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:05:11 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/15] arm64: dts: rockchip: Fix power-controller node names for px30
Date:   Fri, 16 Apr 2021 10:03:32 +0200
Message-Id: <20210416080342.18614-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
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

