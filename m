Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C467394330
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhE1NIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhE1NHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7684C061761
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss26so5261218ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbLfIFthjQtZlat7RQdN/8yMEDgpJIwnw/QpuFVzqeI=;
        b=E7bhan7NhUuVUJZuxUfPhvZxTg20U/P/6O1vrBdsdaL6+UjcvkjtNpH5Ouw2M61oq/
         uCrsNHccZda3hmuSWGImGDMoetf+MXqY8I7qHmeKSj0rYmhYsTX3c0SADTxs+N5T253j
         FeLN0rT50121dOaZqRKF7xH9TqN1G5ZokSmm7BB/7YYikDeB5HGptZuz/0nNlnVmA1wU
         OP4tqM+ieLqZvPVvHxr4b86HX0ZcMfGIX45K7zABxJBSpu0oy+01sPe9n69J+P5V9Mpd
         DeHfmIKnF7jV64fWLBRNrembZ4KsUZ72hg5W95Ifa6iiwEX10YlSJdz9fwjhnvl2Pk3w
         iT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbLfIFthjQtZlat7RQdN/8yMEDgpJIwnw/QpuFVzqeI=;
        b=Yx/VCMtvqaIYwB2jsChWaE4uGbSH+zPFR9Dd0YsoSUbn6LxygKZtkY7Dw3RJrwelS/
         A95ICCrZEMGfF5h2SIO7DIOAfenHaFWpUvsWl6WF58r8gcGGa3G5z5JpXZlHErOUC2uj
         rrgEESZOrjfljuC9ZlFY6I1A6AakE+N+G1qd/86FSzPkSiGqlRs8H9QDFIrjVedEw2p+
         4wH8MB5fAV3oCMtcKH2TUWCCkC6zt8BqndLS1M4+U3P60Wpr8EgsdHSnbcUjz7ZGbwdH
         Ge1pYJ+U699/qdRnOeFw2w0yZ2wLaOH4WmCRi4Gq50C+SQpw7w+j9DKQAiH88pxhTpZV
         zW4w==
X-Gm-Message-State: AOAM533oF1lkfd7QJWQkUKMK30PtzvwJbVIDRWCHuNUR7+MjuoooDWCh
        OKXpYGjVaFIYC61TlicNJQ==
X-Google-Smtp-Source: ABdhPJzwwAQrY+FztbwSr53CEKhDkKAur6hWhbtxnRbmwG3xEJRjfGri3LkImQAzeg5HEwQJjikb5A==
X-Received: by 2002:a17:906:7a13:: with SMTP id d19mr6110323ejo.69.1622207174527;
        Fri, 28 May 2021 06:06:14 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id u21sm2322778ejg.50.2021.05.28.06.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 06:06:14 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 1/5] drm: rockchip: add scaling for RK3036 win1
Date:   Fri, 28 May 2021 15:05:50 +0200
Message-Id: <20210528130554.72191-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528130554.72191-1-knaerzche@gmail.com>
References: <20210528130554.72191-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers needed to make scaling work on RK3036's win1.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

 Changes in v2:
 - rephrase commit message

 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 80053d91a301..b046910129fb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -77,15 +77,20 @@ static const uint64_t format_modifiers_win_lite[] = {
 	DRM_FORMAT_MOD_INVALID,
 };
 
-static const struct vop_scl_regs rk3036_win_scl = {
+static const struct vop_scl_regs rk3036_win0_scl = {
 	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
 	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
 	.scale_cbcr_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
 };
 
+static const struct vop_scl_regs rk3036_win1_scl = {
+	.scale_yrgb_x = VOP_REG(RK3036_WIN1_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(RK3036_WIN1_SCL_FACTOR_YRGB, 0xffff, 16),
+};
+
 static const struct vop_win_phy rk3036_win0_data = {
-	.scl = &rk3036_win_scl,
+	.scl = &rk3036_win0_scl,
 	.data_formats = formats_win_full,
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.format_modifiers = format_modifiers_win_full,
@@ -102,6 +107,7 @@ static const struct vop_win_phy rk3036_win0_data = {
 };
 
 static const struct vop_win_phy rk3036_win1_data = {
+	.scl = &rk3036_win1_scl,
 	.data_formats = formats_win_lite,
 	.nformats = ARRAY_SIZE(formats_win_lite),
 	.format_modifiers = format_modifiers_win_lite,
-- 
2.27.0

