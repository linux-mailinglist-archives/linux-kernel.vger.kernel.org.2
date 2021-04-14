Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD535FD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhDNVTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhDNVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDDC061756;
        Wed, 14 Apr 2021 14:19:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f8so25411232edd.11;
        Wed, 14 Apr 2021 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKq3KmV45GoK0Thnkb+rqanYcWMZ9fjuF6uc/TWZBZk=;
        b=YqKT4SI1v9R4LEvk80UH8n+sy4MPcpTpPrLcdOogMHQtV3Yr2OKlCMFlQdM0xJVE/0
         f9hr5PPin5yzuvlOrYJv4zHDDMyPwiqDK3tVwx6ILst5vw/m3hxfXyAH/ObdqXL4XbHh
         RwMQmxr9qi3yHblVUOdbKpD9HXtFK9f5Iv7ZejpXbbWVyEn2tVu0q9ddNOCC6SnQr4R8
         fcR5IidNI9ToVEMVwwfNvclMKNJRxmIPVDcxXLOZFL699noNvAa/MleSD2tLln5bp8XU
         RdHoNtdtUs6IskhA9Gpqn9lFfRLUIhKjU9u9OVtbPENIpl3c7HGJ3Zd1g25vsOg5cIHK
         FuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKq3KmV45GoK0Thnkb+rqanYcWMZ9fjuF6uc/TWZBZk=;
        b=DWVcLz/H+I3IGBD7k0/QMV6SshsdOYKYpwkc14a/RlKd/EWlLRUeuWuX/JDTdWnCFv
         sYWDEvXZEQTfwg+gQqTPzoe37G9Fo11Agh4TOBVcUfYxGuuyRg2oWr9cnm3XJtLkqiRt
         //wZveOKd2X8Rpog+uH3pLvwIo8hpDM+ECERgECfqQ9K7knmcMa+wcp1nu0Xvfl24oPF
         uyTHl7f7Hm3qxOhdQG4NNI8Ikfl3ZQ0YG0AVTRIfUq0Kg1WfEfkDO0hVDDoYZFf/l+6s
         a+5iGE0dJGXHS8XOtJ3NZttagyPE60ojIFKfWCnhqNmfJ9+kh8dwkmT1dUZpf4NuBJnF
         MTCg==
X-Gm-Message-State: AOAM5339qDLtt6fQ7PQH1cdrPYPC7RKWnk1XaRt5ulC8Oxw73HGxTmr7
        jaxyCWv6RNlmP8+UuoqnEk4=
X-Google-Smtp-Source: ABdhPJwGaoyXbcXZZDDR9Bdi4koV4AolNtt2HiuR/HCyC01ILpIZK2Opxa2GHecgZn/knYI/amUKMw==
X-Received: by 2002:a05:6402:515:: with SMTP id m21mr238606edv.382.1618435148888;
        Wed, 14 Apr 2021 14:19:08 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:08 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] arm64: dts: rockchip: Fix power-controller node names for px30
Date:   Wed, 14 Apr 2021 23:18:49 +0200
Message-Id: <20210414211856.12104-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210414211856.12104-1-jbx6244@gmail.com>
References: <20210414211856.12104-1-jbx6244@gmail.com>
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

