Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1896361B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhDPIHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhDPIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:07:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE5C061574;
        Fri, 16 Apr 2021 01:07:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so40872087ejc.4;
        Fri, 16 Apr 2021 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5mB5QX7GLjRWhPxkNbmeC6oHdNd9j3nQs38k8Ij4Qs8=;
        b=AwTXqkjr9yEGijafn44dXzCqlv90zRICVYq1NM7xFRYQs8ohd6K5qu7MaKwfoWotwA
         CJ07paTYoSrQBgxZ+792KGnEQ1qJECo8KhFDyz98cVsF5y+2ynmOuwH6/kpPSKgTN2Cb
         OqFXY3T060fTjDWPPYGKb8sU+Pbtg12mCEViEnirTE/YkVs4ONwX4VGVP9lFCzjKJQnF
         K2Ewm4gPRYqPgrEiscZwx9na1EWfVqFdbDUW42Bx+9aZYAPOMurVo1r28S9Kh/SbjX/6
         ww9kFR2uoZvXb4Um3EZ80GmME7yaPPUkjMYo5D+v+ciu/+YiqZm/4pv1C23wqIDqWP+R
         meeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5mB5QX7GLjRWhPxkNbmeC6oHdNd9j3nQs38k8Ij4Qs8=;
        b=HuS9b1uIxQNhb+Qgbk5dhGrLiZDIdzdWAYqB5Ofn//V3+AtEuGYAztWwNLdZMTRWTS
         RVxzF0f1ngzHIIQfTTX5MImLZipCFHjnPV2HsicuqSF1O6Ze9w/mrfThMhX4MJY99/w1
         A/CJxi+p/Oge5oilOxk58oD4z0sRUaReKYk/1QpwQYG1PvXuXS7et4rRU8y/IWuumWjp
         0Y3vFQLC/Q3YiLjHg0M9Sn9UX/MWnOgSynBdM4Wu+VBu1wij3O9/vynZCbh1jW7+Bseg
         Ysivpx6V/GomEWGdY9mZcIeeT6We22J84Dq4a3BOyDlFt1OipylO38RlfSr2os+xEVE9
         fujw==
X-Gm-Message-State: AOAM533WB48KXGs4CrjfcmUxLzsyMKj7VCETTFnUTJURr/BP+VbGsFx4
        yfo9HQGN8YvkEzxfOmgzAkU=
X-Google-Smtp-Source: ABdhPJxsnwqZxHbQOdfYAN0xepj06UIJOHB4nn7GdsZK/03ovcNDupy6YDHMNbcqsqdmDQv2aZeobg==
X-Received: by 2002:a17:906:170a:: with SMTP id c10mr7051497eje.493.1618560444126;
        Fri, 16 Apr 2021 01:07:24 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:07:23 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/15] arm64: dts: rockchip: add #power-domain-cells to power domain nodes
Date:   Fri, 16 Apr 2021 10:03:35 +0200
Message-Id: <20210416080342.18614-9-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #power-domain-cells to power domain nodes, because they
are required by power-domain.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   |  8 ++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |  3 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 2b43c3d72..c96ebfe3e 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -250,12 +250,14 @@
 					 <&cru HCLK_OTG>,
 					 <&cru SCLK_OTG_ADP>;
 				pm_qos = <&qos_usb_host>, <&qos_usb_otg>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_SDCARD {
 				reg = <PX30_PD_SDCARD>;
 				clocks = <&cru HCLK_SDMMC>,
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sdmmc>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_GMAC {
 				reg = <PX30_PD_GMAC>;
@@ -264,6 +266,7 @@
 					 <&cru SCLK_MAC_REF>,
 					 <&cru SCLK_GMAC_RX_TX>;
 				pm_qos = <&qos_gmac>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_MMC_NAND {
 				reg = <PX30_PD_MMC_NAND>;
@@ -277,6 +280,7 @@
 					  <&cru SCLK_SFC>;
 				pm_qos = <&qos_emmc>, <&qos_nand>,
 					 <&qos_sdio>, <&qos_sfc>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_VPU {
 				reg = <PX30_PD_VPU>;
@@ -284,6 +288,7 @@
 					 <&cru HCLK_VPU>,
 					 <&cru SCLK_CORE_VPU>;
 				pm_qos = <&qos_vpu>, <&qos_vpu_r128>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_VO {
 				reg = <PX30_PD_VO>;
@@ -300,6 +305,7 @@
 					 <&cru SCLK_VOPB_PWM>;
 				pm_qos = <&qos_rga_rd>, <&qos_rga_wr>,
 					 <&qos_vop_m0>, <&qos_vop_m1>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_VI {
 				reg = <PX30_PD_VI>;
@@ -311,11 +317,13 @@
 				pm_qos = <&qos_isp_128>, <&qos_isp_rd>,
 					 <&qos_isp_wr>, <&qos_isp_m1>,
 					 <&qos_vip>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@PX30_PD_GPU {
 				reg = <PX30_PD_GPU>;
 				clocks = <&cru SCLK_GPU>;
 				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 35df57535..470da614e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -302,13 +302,16 @@
 
 			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VIDEO {
 				reg = <RK3328_PD_VIDEO>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VPU {
 				reg = <RK3328_PD_VPU>;
 				clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+				#power-domain-cells = <0>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 19614c2ce..99f85b1d9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -973,6 +973,7 @@
 				clocks = <&cru ACLK_IEP>,
 					 <&cru HCLK_IEP>;
 				pm_qos = <&qos_iep>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_RGA {
 				reg = <RK3399_PD_RGA>;
@@ -980,12 +981,14 @@
 					 <&cru HCLK_RGA>;
 				pm_qos = <&qos_rga_r>,
 					 <&qos_rga_w>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_VCODEC {
 				reg = <RK3399_PD_VCODEC>;
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
 				pm_qos = <&qos_video_m0>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_VDU {
 				reg = <RK3399_PD_VDU>;
@@ -993,6 +996,7 @@
 					 <&cru HCLK_VDU>;
 				pm_qos = <&qos_video_m1_r>,
 					 <&qos_video_m1_w>;
+				#power-domain-cells = <0>;
 			};
 
 			/* These power domains are grouped by VD_GPU */
@@ -1000,53 +1004,63 @@
 				reg = <RK3399_PD_GPU>;
 				clocks = <&cru ACLK_GPU>;
 				pm_qos = <&qos_gpu>;
+				#power-domain-cells = <0>;
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
 			power-domain@RK3399_PD_EDP {
 				reg = <RK3399_PD_EDP>;
 				clocks = <&cru PCLK_EDP_CTRL>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_EMMC {
 				reg = <RK3399_PD_EMMC>;
 				clocks = <&cru ACLK_EMMC>;
 				pm_qos = <&qos_emmc>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_GMAC {
 				reg = <RK3399_PD_GMAC>;
 				clocks = <&cru ACLK_GMAC>,
 					 <&cru PCLK_GMAC>;
 				pm_qos = <&qos_gmac>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_SD {
 				reg = <RK3399_PD_SD>;
 				clocks = <&cru HCLK_SDMMC>,
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sd>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_SDIOAUDIO {
 				reg = <RK3399_PD_SDIOAUDIO>;
 				clocks = <&cru HCLK_SDIO>;
 				pm_qos = <&qos_sdioaudio>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_TCPD0 {
 				reg = <RK3399_PD_TCPD0>;
 				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
 					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_TCPD1 {
 				reg = <RK3399_PD_TCPD1>;
 				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
 					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_USB3 {
 				reg = <RK3399_PD_USB3>;
 				clocks = <&cru ACLK_USB3>;
 				pm_qos = <&qos_usb_otg0>,
 					 <&qos_usb_otg1>;
+				#power-domain-cells = <0>;
 			};
 			power-domain@RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
+				#power-domain-cells = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1056,6 +1070,7 @@
 						 <&cru HCLK_HDCP>,
 						 <&cru PCLK_HDCP>;
 					pm_qos = <&qos_hdcp>;
+					#power-domain-cells = <0>;
 				};
 				power-domain@RK3399_PD_ISP0 {
 					reg = <RK3399_PD_ISP0>;
@@ -1063,6 +1078,7 @@
 						 <&cru HCLK_ISP0>;
 					pm_qos = <&qos_isp0_m0>,
 						 <&qos_isp0_m1>;
+					#power-domain-cells = <0>;
 				};
 				power-domain@RK3399_PD_ISP1 {
 					reg = <RK3399_PD_ISP1>;
@@ -1070,9 +1086,11 @@
 						 <&cru HCLK_ISP1>;
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
+					#power-domain-cells = <0>;
 				};
 				power-domain@RK3399_PD_VO {
 					reg = <RK3399_PD_VO>;
+					#power-domain-cells = <1>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 
@@ -1082,12 +1100,14 @@
 							 <&cru HCLK_VOP0>;
 						pm_qos = <&qos_vop_big_r>,
 							 <&qos_vop_big_w>;
+						#power-domain-cells = <0>;
 					};
 					power-domain@RK3399_PD_VOPL {
 						reg = <RK3399_PD_VOPL>;
 						clocks = <&cru ACLK_VOP1>,
 							 <&cru HCLK_VOP1>;
 						pm_qos = <&qos_vop_little>;
+						#power-domain-cells = <0>;
 					};
 				};
 			};
-- 
2.11.0

