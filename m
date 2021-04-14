Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECC35FD25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhDNVTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhDNVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C1C061574;
        Wed, 14 Apr 2021 14:19:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so25488848edc.0;
        Wed, 14 Apr 2021 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loIVksKZEL5F0wKKCjoxiHiwkxUopdNbbRXrt2wSAqM=;
        b=Txnutc60o/j/AkKNmGyoN4Rt7gCWA2CX+TVKgLpSFL/ydK3eYSxmXjW72M9gANbqwT
         uHB1Ngvt/So8airX5rNR5p+U4QppzWHwuSW3pUPOFYNDU426qgPX4/NeSqEMCfqoUCdY
         L+bu12Cxqocekc3pkkLPZ/+Y+1KTFLlCVkZ+bWY6vFHC7LvDPjbpMXJ/2R+dUlAVYuz6
         kvx6CzT8/QpOudUMFVSMeWlUecejYdGYI3WasIl9q9sH8+dSHKOYTabdRPt+NOF6O/BA
         0lipia02vk2RBAVg6I4ihGSx2O0CAI2Y68qcbTvIs5X1AnEajDVBe+7WQEl7rJmUHelk
         gHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=loIVksKZEL5F0wKKCjoxiHiwkxUopdNbbRXrt2wSAqM=;
        b=UujW4TjyXRWwtUdnAgHP8FcxGQmgWB/u1f2u5K/MKXhuJBM4zLN85A84BJYaWfB9Fq
         xDHJbn5AQk1E7kVGVJuG8/ZOmZ0yr9ZBKfs8JaWpWKgEZWfpiaOMXeasutsupu4NIISN
         tHdZjSWXJPu28KP7RmiAhA6VTXhAz0hdrZvjo+QX1mzhhkZSAiUJXn12s3MrgGWZfbDV
         7BRFp1gCoIOe2AhMifIRtU6D0T3bOSU7PNYflSRVhtjguVAdUKrhHe/M5xnMbwUS7NgM
         gLzsgEeZ3HwtrvwcSXS7s4K0TlFTdIJEz4G3YcUrcCkAGy6tbUE5XWHFNkqaTGS4b6qX
         Gbvg==
X-Gm-Message-State: AOAM531qL4IydW4iYKe2skhp2PBHZTtv53FzQiIJN5yjHqOtqBKja9Q5
        SgC1JicYDKA7Wgrc/ITI1hI=
X-Google-Smtp-Source: ABdhPJzlI8k1Ch2cg4wHXi2bjATLUor4PBl2TPterEPTFBM1f9HXKPYK3TubrJIRa+Y/VOCh5NzzdQ==
X-Received: by 2002:a50:8d8a:: with SMTP id r10mr251153edh.132.1618435147990;
        Wed, 14 Apr 2021 14:19:07 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/11] arm: dts: rockchip: Fix power-controller node names for rk3288
Date:   Wed, 14 Apr 2021 23:18:48 +0200
Message-Id: <20210414211856.12104-4-jbx6244@gmail.com>
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
 arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ea7416c31..6f4d7929e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -769,7 +769,7 @@
 			 *	*_HDMI		HDMI
 			 *	*_MIPI_*	MIPI
 			 */
-			pd_vio@RK3288_PD_VIO {
+			power-domain@RK3288_PD_VIO {
 				reg = <RK3288_PD_VIO>;
 				clocks = <&cru ACLK_IEP>,
 					 <&cru ACLK_ISP>,
@@ -811,7 +811,7 @@
 			 * Note: The following 3 are HEVC(H.265) clocks,
 			 * and on the ACLK_HEVC_NIU (NOC).
 			 */
-			pd_hevc@RK3288_PD_HEVC {
+			power-domain@RK3288_PD_HEVC {
 				reg = <RK3288_PD_HEVC>;
 				clocks = <&cru ACLK_HEVC>,
 					 <&cru SCLK_HEVC_CABAC>,
@@ -825,7 +825,7 @@
 			 * (video endecoder & decoder) clocks that on the
 			 * ACLK_VCODEC_NIU and HCLK_VCODEC_NIU (NOC).
 			 */
-			pd_video@RK3288_PD_VIDEO {
+			power-domain@RK3288_PD_VIDEO {
 				reg = <RK3288_PD_VIDEO>;
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
@@ -836,7 +836,7 @@
 			 * Note: ACLK_GPU is the GPU clock,
 			 * and on the ACLK_GPU_NIU (NOC).
 			 */
-			pd_gpu@RK3288_PD_GPU {
+			power-domain@RK3288_PD_GPU {
 				reg = <RK3288_PD_GPU>;
 				clocks = <&cru ACLK_GPU>;
 				pm_qos = <&qos_gpu_r>,
-- 
2.11.0

