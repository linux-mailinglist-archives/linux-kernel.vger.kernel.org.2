Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117FC361B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhDPIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhDPIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F44C061574;
        Fri, 16 Apr 2021 01:05:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mh2so19275034ejb.8;
        Fri, 16 Apr 2021 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loIVksKZEL5F0wKKCjoxiHiwkxUopdNbbRXrt2wSAqM=;
        b=AOc5l5Dp1zlGt43dbbcFR3FZ95PVy5Jr8jjiUpOGQaK7jjvKES7dwc98iJCKlcfzn3
         b4L6WZ5ktHY3U21nMwax3oBpvMUX53GGS2uRVvE2BGR4LWXNXFi4gQn5ujgaW+9mIl2M
         UUy7GYPIiq+6esTv0zynG8tVPnmNr+l8oy8iDM9i1swZj9KaxlTVyTfNToBEuZxaPENt
         AavoZllHwQh1c6HGhzFRV81jEpb5q4GJfcuUrNgeAu/ATwT57Eu2cYpxgb4MtUeNKX+z
         BRJy9rZkqSFE/Dm8EyEYS0t+4dr+eYvI4ZG7SK9mSDvOBI0Z+c1xxEMWfafJOX7p73Vj
         J+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=loIVksKZEL5F0wKKCjoxiHiwkxUopdNbbRXrt2wSAqM=;
        b=ES8SdoYkE8HePzbfM7AtKdkp1WSj0/4CwVoIZBPbb/75eS8TuUksBl0tHSkuNWHa2l
         tfSE/ipjEmQRBg+7UvnswNSagSt7UgxJdMz9AKSRfKf/xqYlts6fw28WGvu1lW6CQ2cD
         wHjnMvU1HYlDoZm3Ub9vjcjvVANa6oH8uxXKUU5343EZdU29p8GTO8oXS4a9y1OktsD/
         oNI06ijY2/KTaBmfwBEu2LnPW+b6kxBdR0U0xFfBf4FAKxOc3Rxf+4hDEAdvvk2+0qqU
         rKUfmDgRVq/IsjIl0H6t8lt8Lb7WaE8GCtzulVntqTokBvyfbN93zqsWJtz5HC2sRwNn
         TQ6g==
X-Gm-Message-State: AOAM531gTZbvy2yxTK6ckAn1a6w+0HChIr3mvIWJvkHXnIlKk3VyYrNm
        d1B/8ZHGPjSLOb3dvFU+h2A=
X-Google-Smtp-Source: ABdhPJzrYgal1KeTeKfOtrV3DEtIf/7GBICCi+eIL8caD9x5fqzMvMvb4sSG+7/e7hTuyfknpxCqqg==
X-Received: by 2002:a17:906:4119:: with SMTP id j25mr7210531ejk.459.1618560301126;
        Fri, 16 Apr 2021 01:05:01 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.04.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:05:00 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/15] ARM: dts: rockchip: Fix power-controller node names for rk3288
Date:   Fri, 16 Apr 2021 10:03:30 +0200
Message-Id: <20210416080342.18614-4-jbx6244@gmail.com>
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

