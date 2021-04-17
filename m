Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D176362F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhDQLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhDQLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B88C061756;
        Sat, 17 Apr 2021 04:30:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so45808745ejy.7;
        Sat, 17 Apr 2021 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/yDtkquDn7nc6DMSPBoDqWrLbKvy8/S6Kb4jP/mkzo=;
        b=JVtQdxliNHew9UJXRleuPTV0x6mKumUSIEstFU27tHYgGJCd54pBjmPZFwpbnMCc7c
         LvKcYBho5CIZDpGbgO/YZVWCnknmkf0vqkXDv2HTQUqCYPqPYI1H4X0CosVlEv/v0+J5
         eqKGOu4jn/XBM18C87EKm78a2EznJoYiJ3QRjunxnRcwW5j27BWeSw/T2fvSlUwx3NBT
         WHONKtW4NDUDyeys75BtyA9Zf6+PijhFL83rkvi03n30cEOvrxMcmUhWirlVpIMPEcd0
         tWwcANaxybUZC+nUtBOD3Q6yw0FnAyk1unNxkUQeC3X2z0PiBDghHj4UlJlf7D7xmmq/
         nnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y/yDtkquDn7nc6DMSPBoDqWrLbKvy8/S6Kb4jP/mkzo=;
        b=ox8EWt+vUGkkJrKpBb2QNPnVeWP2gYlea1kB+HosufXOovpTE7QSEuz6WfLKgBqoZ0
         J29od8o2toZv+OqVCFTXYD5ptNpLfFKbpo+gsoco8TLuxc9cGHLohY3RY14TN08oSzjL
         77+LeV+36JupCN74r6LkI5VWGtTlA/UcQtJELkvjrW4s2PjwANVsqZcf+/yfEnldIEhc
         pFjo0sjHMC0wVOkW4y0zJspTCE2mEkG2TA1oyE8iJLyDDRor5brqBxV0oPp+1RPNCdqG
         KFNTZDwKKOa4u7jscU5RuWmAZSLwSMbNPW7Jutt3ePClsOuiIPRoDp32Tv91V9k3UfD/
         o48w==
X-Gm-Message-State: AOAM5337eNI5zfDR71Z+A2+cU8it1n/3HvyRsUU92IksWPPememDhDub
        ELG1VirBw+3HJb1gBdDwgak=
X-Google-Smtp-Source: ABdhPJzDoBj6/xJ06tVkE38Ey38Kytq1uR9lpSE/MKmlQftfuVM0C19wV7cTuV52+Guqu3Q10Yjm8g==
X-Received: by 2002:a17:906:fca1:: with SMTP id qw1mr12500022ejb.478.1618659004920;
        Sat, 17 Apr 2021 04:30:04 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:04 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/15] ARM: dts: rockchip: add #power-domain-cells to power domain nodes
Date:   Sat, 17 Apr 2021 13:29:41 +0200
Message-Id: <20210417112952.8516-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #power-domain-cells to power domain nodes, because they
are required by power-domain.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 3 +++
 arch/arm/boot/dts/rk3188.dtsi  | 3 +++
 arch/arm/boot/dts/rk3288.dtsi  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index bbc3bff50..8e087c34b 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -780,6 +780,7 @@
 				 <&qos_cif1>,
 				 <&qos_ipp>,
 				 <&qos_rga>;
+			#power-domain-cells = <0>;
 		};
 
 		power-domain@RK3066_PD_VIDEO {
@@ -789,12 +790,14 @@
 				 <&cru HCLK_VDPU>,
 				 <&cru HCLK_VEPU>;
 			pm_qos = <&qos_vpu>;
+			#power-domain-cells = <0>;
 		};
 
 		power-domain@RK3066_PD_GPU {
 			reg = <RK3066_PD_GPU>;
 			clocks = <&cru ACLK_GPU>;
 			pm_qos = <&qos_gpu>;
+			#power-domain-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 5db32fdbe..f438170b4 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -719,6 +719,7 @@
 				 <&qos_cif0>,
 				 <&qos_ipp>,
 				 <&qos_rga>;
+			#power-domain-cells = <0>;
 		};
 
 		power-domain@RK3188_PD_VIDEO {
@@ -728,12 +729,14 @@
 				 <&cru HCLK_VDPU>,
 				 <&cru HCLK_VEPU>;
 			pm_qos = <&qos_vpu>;
+			#power-domain-cells = <0>;
 		};
 
 		power-domain@RK3188_PD_GPU {
 			reg = <RK3188_PD_GPU>;
 			clocks = <&cru ACLK_GPU>;
 			pm_qos = <&qos_gpu>;
+			#power-domain-cells = <0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 6f4d7929e..bf2d8ab61 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -805,6 +805,7 @@
 					 <&qos_vio2_rga_r>,
 					 <&qos_vio2_rga_w>,
 					 <&qos_vio1_isp_r>;
+				#power-domain-cells = <0>;
 			};
 
 			/*
@@ -818,6 +819,7 @@
 					 <&cru SCLK_HEVC_CORE>;
 				pm_qos = <&qos_hevc_r>,
 					 <&qos_hevc_w>;
+				#power-domain-cells = <0>;
 			};
 
 			/*
@@ -830,6 +832,7 @@
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
 				pm_qos = <&qos_video>;
+				#power-domain-cells = <0>;
 			};
 
 			/*
@@ -841,6 +844,7 @@
 				clocks = <&cru ACLK_GPU>;
 				pm_qos = <&qos_gpu_r>,
 					 <&qos_gpu_w>;
+				#power-domain-cells = <0>;
 			};
 		};
 
-- 
2.11.0

