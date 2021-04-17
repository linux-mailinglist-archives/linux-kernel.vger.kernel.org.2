Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5AF362F80
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhDQLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhDQLa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3FC061756;
        Sat, 17 Apr 2021 04:30:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so45803353ejc.10;
        Sat, 17 Apr 2021 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+GJVl5A79GqQ5LebjTNhcSfSUHslIcyCgOWie7UI0c=;
        b=mI7B55bRImlRSl0jtkGMQ6TQ3X4RL5Xpb6VEyC7uOX+zN9Lo+LSmoA5FRgURwlog8K
         WDEwpUSxGODYTC32RxOouVkLnR+XQRj0kiTO07X0FkwWpNy0yphAoK2EtNTRdn07I1I2
         ZXSi1yn/yKtZYSUD+Lsx7BzsOuwPvysnkickKN6UxK0wdcVSiDQkY1uT4hpj6EPjYdLI
         Ufw8dMAfi+nR3dV6fuYkA/sWRsFh6diFSwcj43Ss7O8B0OSWD2tMbmVnbGXPHJFVWXw+
         XM8mxAhHye9xfkM4kfU+Z40xnpEirr5Fu+vMVxhWWGYRvbM5nx7Ub3M1zR6l+zn+q2fo
         bLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+GJVl5A79GqQ5LebjTNhcSfSUHslIcyCgOWie7UI0c=;
        b=G6n1UYoe4wcx9+TbaKM+wlUYtogZ7hBmdGkizV1uT6yERn69ohifENSF8Tfulf5YhF
         MGjGaMYApfGFUohAQYUi4hfQuf2sXLKQANxKFPmD69udkK7zxCEZFP5goLacto+PQg/+
         gM8KottjBKY2mZtNhD6iphQ8hPyXJLesM2ubc8MgLxPHzSFkspGtmQbSYaEocCarln5Q
         dAnCNMJzCMGgg0Py8Pkw//b6A9BLW69wsac/mmOb9JvkrgEJbMPHsLgOBUZMdIbA3YSB
         pRYH8vt/B9Xr/3JGdWtaFzHW1cuRH4372jwkZ8j8HVXpfT6VksUKcr6vLa7HAg08driS
         fq6w==
X-Gm-Message-State: AOAM5333UmRmfoSdt8D0Qa+uOkcAaem/UGChH1/6zSSNYqYS5hdVU5aW
        cFpn8CItA6r/WT648pNY6ksn2BeOCLDPPagK
X-Google-Smtp-Source: ABdhPJzDVAR8+Jst5e5xqhLNCiSCa45CaZa5X5szmQKZlsZM5q4BY0pACUM+IOZ+YE7e2/e2q0Rwqw==
X-Received: by 2002:a17:906:95cb:: with SMTP id n11mr13042389ejy.251.1618659001651;
        Sat, 17 Apr 2021 04:30:01 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/15] ARM: dts: rockchip: Fix power-controller node names for rk3066a
Date:   Sat, 17 Apr 2021 13:29:38 +0200
Message-Id: <20210417112952.8516-2-jbx6244@gmail.com>
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

