Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4F362F89
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhDQLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4369C061756;
        Sat, 17 Apr 2021 04:30:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so45869352ejr.5;
        Sat, 17 Apr 2021 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQOvTm7HW4RD6s7O1xMZhkEYd1hzrRk65QKfsGi+jms=;
        b=CgPgDFVMFq4wllk5FFa1xNBr7y56TJ+/lHd6jY59UqI461ikZYhrRFISMACkizptnr
         HD647c74C9VDclkXW2dcnJFU+HrSiFQDEbh/x+7KZ6UjNzSJKsGMg4q80tBT3Cal17UD
         MqCqkQv/rIyCgH6UVL0NEiBdyiutBpX5resdcSHN1alPUDL6/oSsoeqaSptqisb+o5ha
         WYZkAv35cjPr4H+6EHXQEr5YHJ4hSL/m+d57AfNBLPOcvD+uT9WXviMKCLZX/DksxoA3
         lEz8l+ibZIqsmuB9tX9C5tQ2NCau44q2oF6ReF2DoLaPBVsrwtiCRkoRFCCc35NJ9Ke2
         A4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQOvTm7HW4RD6s7O1xMZhkEYd1hzrRk65QKfsGi+jms=;
        b=LKa/sh9/bNqbO+4qcuAfcNazAx9gi90EyRJlSKkGfdawSa57dl47VFu7i+zJ18Cgbc
         WZtO7VcHl2GZWDwp22jqU7dMqCvvKAT59vTOhbuOQxhMBJZf9hwsNDE4dUJCvtonKbOD
         GlRJylsQJf5iLRYzZuTZzWRMyo27BVZO8keYcALuuSZdxRxdF21+vW/ovFAYASd/T71b
         xIgxpZA6ApMlB9zaXK3N7JMJXQ+KN3u0e+Whq+kM1ItBx0lhZKezGBetHrA9l8b5vb/G
         7LUxNhQKzR92/hW8qJsVNAi5H/Bvk67e5JuAc/Ndth+e/18nKfi99Q3suBE/+x2GD3nL
         lmkg==
X-Gm-Message-State: AOAM532F4vba32F37tWEiz1HD62r/oQhh/4GkHNDoMpMzRJp87t3wvxG
        ZPtMVgsKpTZDJVTtr9TpF/cR/Pv3lVf60Hao
X-Google-Smtp-Source: ABdhPJxfglDgxhOK30cKBoqGhNOQm9LskaGGLQXeiVFJ3oOMuR/4cR85mcvbO4ZlTi/1cmPGP6fWPQ==
X-Received: by 2002:a17:906:2cd1:: with SMTP id r17mr12523353ejr.429.1618659002697;
        Sat, 17 Apr 2021 04:30:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/15] ARM: dts: rockchip: Fix power-controller node names for rk3188
Date:   Sat, 17 Apr 2021 13:29:39 +0200
Message-Id: <20210417112952.8516-3-jbx6244@gmail.com>
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

