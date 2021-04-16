Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EF361B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhDPIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhDPIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC50FC061574;
        Fri, 16 Apr 2021 01:05:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f8so31164603edd.11;
        Fri, 16 Apr 2021 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/yDtkquDn7nc6DMSPBoDqWrLbKvy8/S6Kb4jP/mkzo=;
        b=WLNVQikfEAjP+ytzwFec2iN+CglPKZLz0bJ5xw52oYwrvRh+7gdDNPHI7flL7Gm5JW
         zsDkh6HEKm/hLFbBFkeLinX/mayi4Pic5bS7jx+VObFn564dIhSOHB1OdzPwWhl7+IoE
         wYSzzDFAnGAE9emv8gCKN++3EWbMbwcGu5CXQF09KhVkn+DIhVTSvP+9yof//Hial6gz
         bxVx8Uz1DrCqvNQLpBySF6XvBXmKaNq7ojn0g2EhMXbQyagCSA4o8TfJmh4cDB1nPC/9
         +MoghNvs8wqD2KbYFMezm89SkOIAcrosKckRIZE9P8E/QsQYMX3d2so6L+PMggAigeev
         IY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y/yDtkquDn7nc6DMSPBoDqWrLbKvy8/S6Kb4jP/mkzo=;
        b=SSqSLsUohUNYUwnWKh5vA7Lvi5/eDLCvr9BQ3iUaLcmoiEDBu7+8rz5iUcQUS/r3CR
         zZfrH7ADaZcPNV/Fo6vUvDi38XmbZx454VOg6ujo73mo02D2cAJUmlN81zSeitSA5Cpi
         9LeY0EXQ8Ncsn58xw3M/t3r9ddwaTjni6GiP5Uugh9xuP+RDlAX3trWe2Cputk2Uk0vn
         8dPs3zJqpttANc/aOp4+fKZ3ZWZPXnTMWqoflrdh3byvv61/1IqeowAjDKsYNxDuzxMJ
         CFS3wquE4jkBQ8+BgHh27dV3cN6jwlj362Qz9U3TOuoG77hbQh+QHFkzFq436o3oofCC
         vZvw==
X-Gm-Message-State: AOAM532eYoje5AHKDJ/BJZW4gKmou867Wc/wEaqsvLGgkL1vgSgncquX
        hd24lKoKfeMkkojec5KLaHtRxt48OSangY8u
X-Google-Smtp-Source: ABdhPJwCw1fwteiFoZL3ZAnGDvpzhYZf5NOhP8aWBK+RM303/TLyQ2fDRR/IZEaVB9sdEdqloDn7wg==
X-Received: by 2002:a50:ec8c:: with SMTP id e12mr8602166edr.249.1618560307476;
        Fri, 16 Apr 2021 01:05:07 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.05.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:05:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/15] ARM: dts: rockchip: add #power-domain-cells to power domain nodes
Date:   Fri, 16 Apr 2021 10:03:31 +0200
Message-Id: <20210416080342.18614-5-jbx6244@gmail.com>
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

