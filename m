Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08B35FD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhDNVTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhDNVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F2C061574;
        Wed, 14 Apr 2021 14:19:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w23so25423375edx.7;
        Wed, 14 Apr 2021 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+GJVl5A79GqQ5LebjTNhcSfSUHslIcyCgOWie7UI0c=;
        b=f0cKVSPoC4MoEi6nHgfWgSdtZ5R+jozAZbNXNJc2a3sek7K1aJDpk9a+58ELzHFGNy
         kevtpSF2WXQYFinqCKMFiBWYCJTXjIk2m0IBYOim6JWAzcm3JCicFUHOoNbagkWblqzF
         K82UIFEVEPnqf1DE2fy0IGmsRSF1Z6SSo+mR4skzEkSQmM5EUT61V8EGLe0YV/13YaPf
         Ed5BFzFLYu+5xlxZTBVKCpb1jMUcb55n99At4PsjJxCvwUcyfEyvBTWlD23fSJ5feNUY
         1Y+sf0MwXY8pj+En0v91GO4LlCnozXfyTtJ6SFkgPWgd2Y3CXa8PKJQwBo9BHDQW339f
         zKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+GJVl5A79GqQ5LebjTNhcSfSUHslIcyCgOWie7UI0c=;
        b=okjiEot9YZhII+4O13ApssNE+ZKvTgCKXd8NXLeaQps10IwisPq1SxC7PAirEiH/Vb
         VWoO4nVj1pVuMhyo1nHLmM4Hwz6lm+yf1859WpegvSEY2vD2vz5DzsssyIQb6ixS2D+S
         1qiBFgrj+GbVYGb/SKTk1vXgXB7IZazgb2tNz+NLtZdoQvVXIxjZGIQfT1cM3liZa82T
         1cyBY8esglJHtuCjlTcgWzCKA68CuOT+sT1kC1xLOBOJFXhYx32lKNk60Yu+H8Gt3E46
         003SZZr2MsfAHfG11YxmtVlc/PRD669f75MNPYLnJo66fVCmsP7Q7GInnrFx8sJsEP9p
         3vWw==
X-Gm-Message-State: AOAM531T0ErDdu4yhUz6LXjOKo6EX6Fp9XakrslMrtkESsJXBjJtAblY
        reGCLMACdeddFouyQYqDS4Q=
X-Google-Smtp-Source: ABdhPJxK5qIHA/uXDaWy2+zAkiizoGLDNGJaHWXKb6phO+7md7EaoeT+9GxDHfMf70XykvrUXmbilQ==
X-Received: by 2002:aa7:cc94:: with SMTP id p20mr210790edt.353.1618435146411;
        Wed, 14 Apr 2021 14:19:06 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/11] arm: dts: rockchip: Fix power-controller node names for rk3066a
Date:   Wed, 14 Apr 2021 23:18:46 +0200
Message-Id: <20210414211856.12104-2-jbx6244@gmail.com>
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

