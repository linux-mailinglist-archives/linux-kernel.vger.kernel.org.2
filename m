Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDC361B07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhDPIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhDPIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358DC061574;
        Fri, 16 Apr 2021 01:04:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s15so31185226edd.4;
        Fri, 16 Apr 2021 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+GJVl5A79GqQ5LebjTNhcSfSUHslIcyCgOWie7UI0c=;
        b=Muk+NOdvawddovM7SLiOoNvRCbMVyVW3sAoamwZBiFGQ2YBAbcHI0p8c/7YjBF5zhs
         Aum6cZ8segbMAJwwwIUCALOxJxSrl277KAcKPZhSeaASmMPqeiiIYhvF6N05Hk3RH9/J
         TJTb/LObh/5sXq1jp4Dfu6zL1ULkA6Ma27PT1RTaE7plGSr9JiTKkg1m5vfVwrEbeK3X
         HxkvvtTjrM2C7Bbf8pNTr/DlYCxfkyi9rGXssV30tXtfaqH1McF9oF1999rH2xwUr9Tr
         c8b9dK0BI2jgG7XcGBmK2kW9M1SPH/x4JonELJpcpeClosbYNiGvz1flEVKrcbgGalEZ
         yL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+GJVl5A79GqQ5LebjTNhcSfSUHslIcyCgOWie7UI0c=;
        b=tyOQiSJ02LEvul63vKPjUjHWsF36evcNmRPyuxkEMXIQ9LV3okSPU1F6qnLd+hMWbB
         IAcLTdQv/EToGhX+zboSVajDVmVsq2jogl7d5V9MBRg+oybjXOnjTabtrWq/MFHB++EO
         27KZ32rBFMue3l3b+Up2gSd8lskmUTuzGx7sKF0SLo+4/DhFbMcdRthu5ZPnt0m9lOCK
         s5qpYVEQlBdF7LGr6okS12VKdLco3W2JNSVxGTZH3VfKoQ4/ubIQRjjfcLbU1UCv7cwg
         LfVjtOjT4XVNieEgDyCeYvSw7AXSu7wAITFgc+rAqFRlffyom2Jp82togZ41thnLrAgX
         SwIA==
X-Gm-Message-State: AOAM530PzTz+rxM6BgB0hUz1VLe0+sT/xNk6FBV3deOuVqtvfPkVZvXZ
        Gkpw5TBNZxNJPQXJcap8T1E=
X-Google-Smtp-Source: ABdhPJzuVSHXEILKd8+m9imL5V3K2bAF8Yb0hmxLx7ANpTilFv9VD8lRAFEd4xQLX9FFuWeuOgddSw==
X-Received: by 2002:a05:6402:27ca:: with SMTP id c10mr8229426ede.382.1618560289267;
        Fri, 16 Apr 2021 01:04:49 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.04.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:04:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/15] ARM: dts: rockchip: Fix power-controller node names for rk3066a
Date:   Fri, 16 Apr 2021 10:03:28 +0200
Message-Id: <20210416080342.18614-2-jbx6244@gmail.com>
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
Changed
---
 arch/arm/boot/dts/rk3066a.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 252750c97..bbc3bff50 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -755,7 +755,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pd_vio@RK3066_PD_VIO {
+		power-domain@RK3066_PD_VIO {
 			reg = <RK3066_PD_VIO>;
 			clocks = <&cru ACLK_LCDC0>,
 				 <&cru ACLK_LCDC1>,
@@ -782,7 +782,7 @@
 				 <&qos_rga>;
 		};
 
-		pd_video@RK3066_PD_VIDEO {
+		power-domain@RK3066_PD_VIDEO {
 			reg = <RK3066_PD_VIDEO>;
 			clocks = <&cru ACLK_VDPU>,
 				 <&cru ACLK_VEPU>,
@@ -791,7 +791,7 @@
 			pm_qos = <&qos_vpu>;
 		};
 
-		pd_gpu@RK3066_PD_GPU {
+		power-domain@RK3066_PD_GPU {
 			reg = <RK3066_PD_GPU>;
 			clocks = <&cru ACLK_GPU>;
 			pm_qos = <&qos_gpu>;
-- 
2.11.0

