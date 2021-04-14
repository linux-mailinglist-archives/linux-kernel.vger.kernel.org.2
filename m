Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC15F35FD23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhDNVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhDNVTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5742CC06175F;
        Wed, 14 Apr 2021 14:19:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so25421121edb.8;
        Wed, 14 Apr 2021 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQOvTm7HW4RD6s7O1xMZhkEYd1hzrRk65QKfsGi+jms=;
        b=rsEvIs5MpwhcLt07fi9PBMTXXJxzbm3C6ZqTT4hDsr9PasOFPa9Jkbi7xy6K0a4geq
         ioUd1/lUr9Vla9cqBmOZgj/2o6kQv9HrVytBjYOnOugUKRz4bbI40eJbPFSuFNnVCR5z
         ubfmoCkb5Y6vcJ0t3j0UvhIb4RJBPxBKpReoRgxvqt+oK99cl4Xci8wusQ0vJU3sUH0F
         yS4WiNThYvjsw4/aggV+G1DiMYpyXqixO7ETdNO5T2Y5UAvvIonDGdtyLoKCeciAUczA
         WDPXP1/MtbkLhO58mVts/eUdr1b5u/i2zcxV7KoplvY3IMDmSpAbDuqaQGrKb2SofjoT
         9grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQOvTm7HW4RD6s7O1xMZhkEYd1hzrRk65QKfsGi+jms=;
        b=EZWNw/MIuXUoX1TZHtBMUNgW9MTs4+qC+dXfhzrLUA08mXoN0HOhfTx10mDEFwknwR
         YJtjvP4Jf/EMuDYdqovNI30nIzkzHXxBMEOnmjvQNLGiDKQzVh2DlU/d96OpBmH0p4tR
         jk+VUixdTyoK8BKAZjmTrZaDEU/lhJaipxqiR44FWjkFv1Xp5MYjxIYb4eLhWrIWrZxi
         ev1uZdBl2GdWPB3AglnOZ1eTnYnAvApZPhh8IVuk1YkDFiEdq70jgDbw/Ns4vRPxJkB8
         rj5M32rQ5NOwP2GXjdPZOcZCIC01RdVBIcEmAPnnbsvIbLnzNC164uxfeC41cUC7VQKi
         AIag==
X-Gm-Message-State: AOAM530AcjZ0wms3/6aUgCHe9THIMi/iYPNJjywV4ka+cHLpxzSK8T7b
        HaENY3lOAAVCGfPZzIhan9k=
X-Google-Smtp-Source: ABdhPJyFWbXJhvk4/cDkTJvMpCpvHp93/hwrmIrQOblAEJr3laTAngz9SsM9McyxftZIPxp1Vo3jFw==
X-Received: by 2002:aa7:c694:: with SMTP id n20mr229716edq.51.1618435147176;
        Wed, 14 Apr 2021 14:19:07 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/11] arm: dts: rockchip: Fix power-controller node names for rk3188
Date:   Wed, 14 Apr 2021 23:18:47 +0200
Message-Id: <20210414211856.12104-3-jbx6244@gmail.com>
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
 arch/arm/boot/dts/rk3188.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 2298a8d84..5db32fdbe 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -699,7 +699,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pd_vio@RK3188_PD_VIO {
+		power-domain@RK3188_PD_VIO {
 			reg = <RK3188_PD_VIO>;
 			clocks = <&cru ACLK_LCDC0>,
 				 <&cru ACLK_LCDC1>,
@@ -721,7 +721,7 @@
 				 <&qos_rga>;
 		};
 
-		pd_video@RK3188_PD_VIDEO {
+		power-domain@RK3188_PD_VIDEO {
 			reg = <RK3188_PD_VIDEO>;
 			clocks = <&cru ACLK_VDPU>,
 				 <&cru ACLK_VEPU>,
@@ -730,7 +730,7 @@
 			pm_qos = <&qos_vpu>;
 		};
 
-		pd_gpu@RK3188_PD_GPU {
+		power-domain@RK3188_PD_GPU {
 			reg = <RK3188_PD_GPU>;
 			clocks = <&cru ACLK_GPU>;
 			pm_qos = <&qos_gpu>;
-- 
2.11.0

