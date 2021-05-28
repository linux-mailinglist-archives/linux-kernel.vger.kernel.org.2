Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371C0394333
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhE1NIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhE1NHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E42C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h24so1285847ejy.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRDj0MZVdTsSCC1Yf3hrs6Pt5+GzbpR4T0o/AaDM1so=;
        b=le92jVWjnEdA6redTACjRiKgL2NgrE87F0JvfHKsxfuifm2jTp16JBup34YX7nDupa
         qWQxUmK1nk8QhbJ6/SebSibILZ94srX5WDvugZRT7DePZBdqw1g8PLrgtov5U1tap8l6
         PjOn4C0xkEBn/nGocm9U+4L0j/wz2XxqNRsS5pH25Hb3FuXvtKbpQ4vlX5AIURE4r3Tc
         tSkAN1LTdKD+GLcDqFVco0ni0pw276ndduPPVqtk/3tMLfZE/qVNJolEM8gPJ4D6vPYX
         dbYCGGCxKA//VzGHTJfKmGQECY0QxKajXc7LUJ3YyM/26QVdP09G8SJPyw6HPjNPoqnV
         IXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRDj0MZVdTsSCC1Yf3hrs6Pt5+GzbpR4T0o/AaDM1so=;
        b=MgrIJxE6BqbP2iUtyezSWn9f1PL/4BuyiTMi9qS5uOsRskEHtharW84NRFjKYTCyc9
         3aTYLt7z2f9KhjL6ttuPDTva04sJZiuJ1U4vG0VPcjDubrbPEki6yure3tKnrnMno6q5
         scrpvll0dFteVBzhhkq3sTnkkqxBgvjdN46eof6zA00tn7YInDrjsj6fGDSDIJrVIv2+
         wVMfsVpoY0XFqv0ft+azFie4w+nKUccWZaky4ovmbhm4NlnUvqGOnIHKq2xR0jMYPJBI
         l14oJiIgQ3vCkdwc4eVIetFMmxAR/sDHr9iVAJ5DGVIVeoINEKJ8x/SOiKA6t2fjmL3c
         QD5g==
X-Gm-Message-State: AOAM530wHrOe943Tp+RtT065m31zfx8M/3GRi1VC3TLtmPaJxazt2Irw
        XIXdiXp47Gzq2pYGXhjXkg==
X-Google-Smtp-Source: ABdhPJzN2bFZQ/fRjfwL+SSSResnIJ4d7NrC0RuT1/aM7rHhN33jSvaMZPlKhuoDcWNeqB7on3W4+g==
X-Received: by 2002:a17:906:4a5a:: with SMTP id a26mr9053546ejv.548.1622207176474;
        Fri, 28 May 2021 06:06:16 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id u21sm2322778ejg.50.2021.05.28.06.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:06:16 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 3/5] drm: rockchip: add missing registers for RK3066
Date:   Fri, 28 May 2021 15:05:52 +0200
Message-Id: <20210528130554.72191-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528130554.72191-1-knaerzche@gmail.com>
References: <20210528130554.72191-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dither_up, dsp_lut_en and data_blank registers to enable their
respective functionality for RK3066's VOP.

While at that also fix .rb_swap and .format registers for all windows,
which have to be set though RK3066_SYS_CTRL1 register.
Also remove .scl from win1: Scaling is only supported on the primary
plane.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

 Changes in v3:
 - added patch

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 2aa6d937a078..b7c51933729f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -355,8 +355,8 @@ static const struct vop_win_phy rk3066_win0_data = {
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.format_modifiers = format_modifiers_win_full,
 	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 0),
-	.format = VOP_REG(RK3066_SYS_CTRL0, 0x7, 4),
-	.rb_swap = VOP_REG(RK3066_SYS_CTRL0, 0x1, 19),
+	.format = VOP_REG(RK3066_SYS_CTRL1, 0x7, 4),
+	.rb_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 19),
 	.act_info = VOP_REG(RK3066_WIN0_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3066_WIN0_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3066_WIN0_DSP_ST, 0x1fff1fff, 0),
@@ -367,13 +367,12 @@ static const struct vop_win_phy rk3066_win0_data = {
 };
 
 static const struct vop_win_phy rk3066_win1_data = {
-	.scl = &rk3066_win_scl,
 	.data_formats = formats_win_full,
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.format_modifiers = format_modifiers_win_full,
 	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 1),
-	.format = VOP_REG(RK3066_SYS_CTRL0, 0x7, 7),
-	.rb_swap = VOP_REG(RK3066_SYS_CTRL0, 0x1, 23),
+	.format = VOP_REG(RK3066_SYS_CTRL1, 0x7, 7),
+	.rb_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 23),
 	.act_info = VOP_REG(RK3066_WIN1_ACT_INFO, 0x1fff1fff, 0),
 	.dsp_info = VOP_REG(RK3066_WIN1_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3066_WIN1_DSP_ST, 0x1fff1fff, 0),
@@ -388,8 +387,8 @@ static const struct vop_win_phy rk3066_win2_data = {
 	.nformats = ARRAY_SIZE(formats_win_lite),
 	.format_modifiers = format_modifiers_win_lite,
 	.enable = VOP_REG(RK3066_SYS_CTRL1, 0x1, 2),
-	.format = VOP_REG(RK3066_SYS_CTRL0, 0x7, 10),
-	.rb_swap = VOP_REG(RK3066_SYS_CTRL0, 0x1, 27),
+	.format = VOP_REG(RK3066_SYS_CTRL1, 0x7, 10),
+	.rb_swap = VOP_REG(RK3066_SYS_CTRL1, 0x1, 27),
 	.dsp_info = VOP_REG(RK3066_WIN2_DSP_INFO, 0x0fff0fff, 0),
 	.dsp_st = VOP_REG(RK3066_WIN2_DSP_ST, 0x1fff1fff, 0),
 	.yrgb_mst = VOP_REG(RK3066_WIN2_MST, 0xffffffff, 0),
@@ -414,6 +413,9 @@ static const struct vop_common rk3066_common = {
 	.dither_down_en = VOP_REG(RK3066_DSP_CTRL0, 0x1, 11),
 	.dither_down_mode = VOP_REG(RK3066_DSP_CTRL0, 0x1, 10),
 	.dsp_blank = VOP_REG(RK3066_DSP_CTRL1, 0x1, 24),
+	.dither_up = VOP_REG(RK3066_DSP_CTRL0, 0x1, 9),
+	.dsp_lut_en = VOP_REG(RK3066_SYS_CTRL1, 0x1, 31),
+	.data_blank = VOP_REG(RK3066_DSP_CTRL1, 0x1, 25),
 };
 
 static const struct vop_win_data rk3066_vop_win_data[] = {
-- 
2.27.0

