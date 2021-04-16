Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD67361B09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbhDPIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhDPIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1FC061574;
        Fri, 16 Apr 2021 01:04:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so40861124ejc.4;
        Fri, 16 Apr 2021 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hQOvTm7HW4RD6s7O1xMZhkEYd1hzrRk65QKfsGi+jms=;
        b=AFPMnGAu7qRkenodHpWhCuvoT0axU6n611uuI3NWBEQ8zrdVTKOSBJl+Oauk7rq8rM
         6I/p5HCDy8GAFEC7DfP4FltqUbyT1dWdGTAiqUvTLoCeXDHiGufdeaxQWziIsPLZl8V7
         mx/nKaTVJ8gOMdsgmErXG4Q6mmRalInadumCUCrOHqdvGdFPXluwl338eVofkY4z479v
         2dFBAvJYLSXRoOSo3eNiRC1ZptacSaz6/HFl2S3fpmcHoq0tlkJ9aIJVaiSmSGnur5Gp
         WrN/xVji0YMAE482K1A41slRCCklqaRDP4dsMzLfX4eyopEXo5U07Ozpa6qxhXR/0Zpd
         sDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hQOvTm7HW4RD6s7O1xMZhkEYd1hzrRk65QKfsGi+jms=;
        b=okplzRQZeZr4uPp9RtpA3nHHGP7NNkWm9d9v3Xf4Pg4yhdXdZyyPq7b/ji8sSHjPwZ
         k7UXdgcM65lJW3xztjPI8oK16WcTNWuYAa1u+ANjsdafluqALUyPw+L0x1CsSXQYzwzH
         /1IVFYrHd0Wty8UppI3FG4nGMDFKj8PwOBJOOHJp8dg/jqqIBQ7lzuV+Edv3LiDWdZz+
         R8F+oXRFHiS+M0xy7wtCrHI8PkIsDIQBdVrN5/+afz9FpFKUdMgpjaMfUo9cSo0QSCsq
         vkfQAtcavWgEtRm6I4O513ajE2Q1pa8wKZfe7p2dqYdjIjOhgUKNFRTZtwYq3CyVy+5N
         kdBg==
X-Gm-Message-State: AOAM53222PyC5aH1EFOGpGsITXAdHPPlFSgnTe/aeDojm/kwTcOxMgku
        MjpKNsMyck9MVkqJXzofXKTAMFoeMNhydbnk
X-Google-Smtp-Source: ABdhPJyFkWgbgeXMuY8aMqWrjqIOYGKy3PvVSK0kY0r59k3eLtsb4MCwx+Jb+QLXXXLJrTsXgQ6JHg==
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr7183405ejf.248.1618560295196;
        Fri, 16 Apr 2021 01:04:55 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.04.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:04:54 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/15] ARM: dts: rockchip: Fix power-controller node names for rk3188
Date:   Fri, 16 Apr 2021 10:03:29 +0200
Message-Id: <20210416080342.18614-3-jbx6244@gmail.com>
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

