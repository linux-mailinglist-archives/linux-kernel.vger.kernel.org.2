Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CACF394335
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhE1NIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhE1NHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC588C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lz27so5189773ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MW0JHxZuI2Zb8ESdRdSCjrHhcXSDEM8LLD+9HCmxueM=;
        b=NXyErXuuCFvYRyHv6PKtelWFJwX0pCLLtkw1Ax6t9V++bMU/W+XsKExHHRhBYUm+VB
         MF3SzFEmpTW6qfvLm6hyYCD5o0f/a/NyevjTVrFtlbLUvSx2cAyZwU0XPUqltZQF8wfY
         IyUyDgPj34Jh/YbThZpknN8bYfFMf3sLRKdmfOmNIhcUW48zXbDZKT1hiKTdR96dZDpU
         83DlAnMQGDHfviEAFYTp24vy4UAdCFz5mncNgutp3rOnkrzCzDxEhiSQg7vjws9y9zBb
         /071FQz5gbcD4LDAUN7+6Ydf33ZpG/OE6mCIB76x3o4vLh6bYWvFcQmkhFvBX3zFdFDJ
         IvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MW0JHxZuI2Zb8ESdRdSCjrHhcXSDEM8LLD+9HCmxueM=;
        b=k2TBpLkUtO0Elugy4ApA63k7tshJFDsJ7Ny/GiLuTw4IsEd954pK1AHL9xkWKm4N16
         ceGFMtAAcbtzRY+tNsTO4SvVcNz6wexRAZWtosLMsDgtARANCo1d61uw2RV71RbK0+G+
         v6tmZbvaJ2evl71H4gjx/eDAt3g+yAO1kOPt8eTvK74upybpDIBXS8Ptg7W8VcNcOqu8
         zPShcvu3Fb/85NGE0sEoMUhGY4XjBjv1tN/zCgQTXnkgEUZ9VEuLCRKcfAOO2OuhYmEc
         zmqPScOSGGShEcjVXov1fhiwI62i73VvmWpRrp5yYukrXPlg3rDuQRPX/5FHeMoJeMqB
         DpfA==
X-Gm-Message-State: AOAM5323HHCdtdix92ila4y/olMVy1SQuHOQaeagQwMheXO8c+EASlwp
        jcbtGTJKZEnTgLDXDh8jlA==
X-Google-Smtp-Source: ABdhPJz+OvGcA2tPJTL3NpUU85LDUV0aYC2bpveQ4Mp2vRSX+6IkJuQMfvbFfJzASrEuYymoVJNqvA==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18mr1882298ejp.420.1622207177464;
        Fri, 28 May 2021 06:06:17 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id u21sm2322778ejg.50.2021.05.28.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:06:17 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 4/5] drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
Date:   Fri, 28 May 2021 15:05:53 +0200
Message-Id: <20210528130554.72191-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528130554.72191-1-knaerzche@gmail.com>
References: <20210528130554.72191-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With
commit 2aae8ed1f390 ("drm/rockchip: Add per-pixel alpha support for the PX30 VOP")
alpha support was introduced for PX30's VOP.
RK3036, RK3066, RK3126 and RK3188 VOPs support alpha blending in the
same manner.
With the exception of RK3066 all of them support pre-multiplied alpha.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

 Changes in v2:
 - rephrase commit message

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b7c51933729f..4d18b42f522b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -104,6 +104,9 @@ static const struct vop_win_phy rk3036_win0_data = {
 	.uv_mst = VOP_REG(RK3036_WIN0_CBR_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3036_WIN0_VIR, 0xffff, 0),
 	.uv_vir = VOP_REG(RK3036_WIN0_VIR, 0x1fff, 16),
+	.alpha_mode = VOP_REG(RK3036_DSP_CTRL0, 0x1, 18),
+	.alpha_en = VOP_REG(RK3036_ALPHA_CTRL, 0x1, 0),
+	.alpha_pre_mul = VOP_REG(RK3036_DSP_CTRL0, 0x1, 29),
 };
 
 static const struct vop_win_phy rk3036_win1_data = {
@@ -119,6 +122,9 @@ static const struct vop_win_phy rk3036_win1_data = {
 	.dsp_st = VOP_REG(RK3036_WIN1_DSP_ST, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(RK3036_WIN1_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3036_WIN1_VIR, 0xffff, 0),
+	.alpha_mode = VOP_REG(RK3036_DSP_CTRL0, 0x1, 19),
+	.alpha_en = VOP_REG(RK3036_ALPHA_CTRL, 0x1, 1),
+	.alpha_pre_mul = VOP_REG(RK3036_DSP_CTRL0, 0x1, 29),
 };
 
 static const struct vop_win_data rk3036_vop_win_data[] = {
@@ -185,6 +191,9 @@ static const struct vop_win_phy rk3126_win1_data = {
 	.dsp_st = VOP_REG(RK3126_WIN1_DSP_ST, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(RK3126_WIN1_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3036_WIN1_VIR, 0xffff, 0),
+	.alpha_mode = VOP_REG(RK3036_DSP_CTRL0, 0x1, 19),
+	.alpha_en = VOP_REG(RK3036_ALPHA_CTRL, 0x1, 1),
+	.alpha_pre_mul = VOP_REG(RK3036_DSP_CTRL0, 0x1, 29),
 };
 
 static const struct vop_win_data rk3126_vop_win_data[] = {
@@ -364,6 +373,8 @@ static const struct vop_win_phy rk3066_win0_data = {
 	.uv_mst = VOP_REG(RK3066_WIN0_CBR_MST0, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3066_WIN0_VIR, 0xffff, 0),
 	.uv_vir = VOP_REG(RK3066_WIN0_VIR, 0x1fff, 16),
+	.alpha_mode = VOP_REG(RK3066_DSP_CTRL0, 0x1, 21),
+	.alpha_en = VOP_REG(RK3066_BLEND_CTRL, 0x1, 0),
 };
 
 static const struct vop_win_phy rk3066_win1_data = {
@@ -380,6 +391,8 @@ static const struct vop_win_phy rk3066_win1_data = {
 	.uv_mst = VOP_REG(RK3066_WIN1_CBR_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3066_WIN1_VIR, 0xffff, 0),
 	.uv_vir = VOP_REG(RK3066_WIN1_VIR, 0x1fff, 16),
+	.alpha_mode = VOP_REG(RK3066_DSP_CTRL0, 0x1, 22),
+	.alpha_en = VOP_REG(RK3066_BLEND_CTRL, 0x1, 1),
 };
 
 static const struct vop_win_phy rk3066_win2_data = {
@@ -393,6 +406,8 @@ static const struct vop_win_phy rk3066_win2_data = {
 	.dsp_st = VOP_REG(RK3066_WIN2_DSP_ST, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(RK3066_WIN2_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3066_WIN2_VIR, 0xffff, 0),
+	.alpha_mode = VOP_REG(RK3066_DSP_CTRL0, 0x1, 23),
+	.alpha_en = VOP_REG(RK3066_BLEND_CTRL, 0x1, 2),
 };
 
 static const struct vop_modeset rk3066_modeset = {
@@ -478,6 +493,9 @@ static const struct vop_win_phy rk3188_win0_data = {
 	.yrgb_mst = VOP_REG(RK3188_WIN0_YRGB_MST0, 0xffffffff, 0),
 	.uv_mst = VOP_REG(RK3188_WIN0_CBR_MST0, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3188_WIN_VIR, 0x1fff, 0),
+	.alpha_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 18),
+	.alpha_en = VOP_REG(RK3188_ALPHA_CTRL, 0x1, 0),
+	.alpha_pre_mul = VOP_REG(RK3188_DSP_CTRL0, 0x1, 29),
 };
 
 static const struct vop_win_phy rk3188_win1_data = {
@@ -492,6 +510,9 @@ static const struct vop_win_phy rk3188_win1_data = {
 	.dsp_st = VOP_REG(RK3188_WIN1_DSP_ST, 0x0fff0fff, 0),
 	.yrgb_mst = VOP_REG(RK3188_WIN1_MST, 0xffffffff, 0),
 	.yrgb_vir = VOP_REG(RK3188_WIN_VIR, 0x1fff, 16),
+	.alpha_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 19),
+	.alpha_en = VOP_REG(RK3188_ALPHA_CTRL, 0x1, 1),
+	.alpha_pre_mul = VOP_REG(RK3188_DSP_CTRL0, 0x1, 29),
 };
 
 static const struct vop_modeset rk3188_modeset = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
index 6e9fa5815d4d..0b3cd65ba5c1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
@@ -955,6 +955,7 @@
 #define RK3188_DSP_CTRL0		0x04
 #define RK3188_DSP_CTRL1		0x08
 #define RK3188_INT_STATUS		0x10
+#define RK3188_ALPHA_CTRL		0x14
 #define RK3188_WIN0_YRGB_MST0		0x20
 #define RK3188_WIN0_CBR_MST0		0x24
 #define RK3188_WIN0_YRGB_MST1		0x28
-- 
2.27.0

