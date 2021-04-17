Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD213362F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhDQLbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhDQLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE5AC061574;
        Sat, 17 Apr 2021 04:30:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g17so34537619edm.6;
        Sat, 17 Apr 2021 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=loIVksKZEL5F0wKKCjoxiHiwkxUopdNbbRXrt2wSAqM=;
        b=Wlr2qa6/QfHxVOxXfIEZxF8uBM5rlPsBNoRnzYJ+REk7VK3Z1okoeqnYeuJsL5CRZl
         0JNIdCMq9KBnetBWsgO16iKeqAR/D9uqsmjNiH7WEZzFz0PGHP3D+cWVNQ567JSZ+hdg
         K/mjdpcaYB9hKq4MZh7FN8vQcbY5pK/rIorVKkzBOL3vtYOvFNKPrYw8h8nbVihSLsAk
         i4Xo7dOiSIDvHRi6APkMNAomLEYeyudOXyaTXA1q83vFBYm+hLpxSl597nHrXaBVtlrl
         Tq6r/AiGbZyoVwsirg6wIW+VeLjmwViBbA4nMbu0q802nswonddOge1rnRmZ7TehlzPH
         pTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=loIVksKZEL5F0wKKCjoxiHiwkxUopdNbbRXrt2wSAqM=;
        b=cmAZ4MONoZYoxXWz9DqscUnzR7WbDTJqgY8qtPwuHLSOiilmY6kiR6yLp/GGlmrbOZ
         DUpz+E1yFVbtu3hAdCXe2Frlg3S4TkjC7vYbpbh99gTvPritaWPxi/Pi/JQ8PqVUsrOI
         ew34ysigszzgYvBOI0tAYwNENYxSc6iZA55rz7IBhS3owSKoFFJVVV+mYwkSk6Avqxhw
         EAP96w73jbdiDq+trWN9nI1K+POOU07gSMKwx+tXRYxX3wxbwpqgtrcJ8yc9d5z3K0ju
         LHNRi31GF9ObR0hOqF805fCkSC5DXsJW3Scvh3f40fhy+pxCajyykTJGQHrs6FxH1VeY
         4Fsg==
X-Gm-Message-State: AOAM532boVzg9hzKy1dJ9cBwQKWdJZE9uxutfuOR6WeD/Mopi672Gt1F
        w+08v0pBCmskZ2VAhEY7fVAlXC7NtbgD6yX3
X-Google-Smtp-Source: ABdhPJwpMbh790Fc4oZvutMO1WvRv2Of0RpnGm89qrP02+vaGlXNNZ/kXFXUCCKNSH8k041Ru9VtUg==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr15002879edd.134.1618659003729;
        Sat, 17 Apr 2021 04:30:03 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:03 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/15] ARM: dts: rockchip: Fix power-controller node names for rk3288
Date:   Sat, 17 Apr 2021 13:29:40 +0200
Message-Id: <20210417112952.8516-4-jbx6244@gmail.com>
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

