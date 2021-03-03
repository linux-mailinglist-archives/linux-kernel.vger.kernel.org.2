Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6D32BE70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574161AbhCCRWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444542AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13CC061A2E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w7so5211549wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=87fsu4OIs39RkiShLHPl5EVCCmtcdhx0DNDxe5fguYo=;
        b=yCtW0Uu0wfAY7fOoVNPYGtXF8o5hem7JHg0aQPaKs1sqYNr2HI1Kz92nBLlu9Sgyzp
         gWRNdVmIkZmVmLYE87d51DQTZHDHFkInhe/0uWOYHxNS8ylaiX2lc4+/1L2qlCYAJU83
         2I6YOzEaC4vuqy2Anc91mviMDAV3TFqX9FlV9TOgUfzYTAm6uXMDo6ZSFTxzgFmT4o2e
         EL6Xwwx7p4d4NvcyXm1e2ZuX2otL/va7ZXsp+vQRLQdgNJUZ10wrAs0RU+n+aM+s0KtK
         9eEzRhiUuu1U2KC5dk77+h1PMAqrexS05ly8M7vuiqWh+vjHhwDdW8L5JTU/IqEifW2c
         kaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87fsu4OIs39RkiShLHPl5EVCCmtcdhx0DNDxe5fguYo=;
        b=cjtEKFD2Df/EtFB96YWWPgU6gdZmLVveIuuFXJhmzjq9GauQOUy1nzbrNNr5/CxpRJ
         T4AxX9sNi1hgVF1UTkmBq2yeDX18nz47VdWG46aYQ7c86lImVU4Mo+GXphx6pnAzeCvv
         Hwq3DG+em24pMzIOcpEovsN93qsNeI6ipB50dgQdSf78bHIWa6aEq5jXofSNXuYjYh/3
         yIdGf3i7fXwXdrqowRpbClMD0WEtB2hKIw8xCWIPKnKOzBRZnq6x/YgqURzowAZmkw+C
         Ti0942qa2FK33HVJez+by+5rMZVPNo8PvZIdXZJynCUWpXLT9AzrxRDTYUVYEu93wg3A
         AL2g==
X-Gm-Message-State: AOAM5321W+eHOfUc4C9A5jFN4ysK/yhQaWhCaJRDFo/E4Ha1O6kP3/+p
        xAlxWix2ivfaUEpl/G0ppqbkOA==
X-Google-Smtp-Source: ABdhPJwSSP5ajXSVF3sb05fD5DeVWuPDpNytZZZIY8O8dSnjhFg+WNyoynnV8pKhuEapCttCgPGPBg==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr9479504wmm.64.1614779038337;
        Wed, 03 Mar 2021 05:43:58 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 25/53] drm/vmwgfx/vmwgfx_kms: Mark vmw_{cursor,primary}_plane_formats as __maybe_unused
Date:   Wed,  3 Mar 2021 13:42:51 +0000
Message-Id: <20210303134319.3160762-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:256:23: warning: ‘vmw_cursor_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:248:23: warning: ‘vmw_primary_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:256:23: warning: ‘vmw_cursor_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:248:23: warning: ‘vmw_primary_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:256:23: warning: ‘vmw_cursor_plane_formats’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h:248:23: warning: ‘vmw_primary_plane_formats’ defined but not used [-Wunused-const-variable=]

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-8-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 03f3694015cec..6267ccf54944e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -245,7 +245,7 @@ struct vmw_framebuffer_bo {
 };
 
 
-static const uint32_t vmw_primary_plane_formats[] = {
+static const uint32_t __maybe_unused vmw_primary_plane_formats[] = {
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_RGB888,
@@ -253,7 +253,7 @@ static const uint32_t vmw_primary_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
-static const uint32_t vmw_cursor_plane_formats[] = {
+static const uint32_t __maybe_unused vmw_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
-- 
2.27.0

