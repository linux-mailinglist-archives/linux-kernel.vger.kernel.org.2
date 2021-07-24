Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0353D4761
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhGXKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 06:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhGXKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 06:38:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99991C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:19:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b6so5891797pji.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtMk+ANh4DuxEoD3swFwLh1zqoMdf700cXOW5hW9VCs=;
        b=pjZCOOSFL9/1Jw3Kg+6QQe9VtN1niEfY89EHxMu2RoDJIEEM3GeExXQpN+6n0Xdh0n
         u3HHiSB0Pr2kaUCJAsdbnVgBec3Tj7lKVUqCJMkU4HmsiR/xQTTeTO7yt/NmDhREyB5E
         kBMMPhhuOaypHSgt3N7xROk3xAjJpTJK+cFdAi3zC4zBWsYEsmCrdr3nl4cTOTJpeA8D
         upOLTZFpnhjkCD/J+HNokKPkQVsLXM3wOnL+SoAZlEFXN4yMtc9mDrIUTkKqLOpvRUJ+
         Wb5ne6DvJONJAgV6jIQFjgvoPUE8R3VbBrGBu4zmY9D/gI68zp8/6ufehAu953/2wlNq
         6oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtMk+ANh4DuxEoD3swFwLh1zqoMdf700cXOW5hW9VCs=;
        b=Wve3GNGhTl5rXKYufblVvZL7+c7Png0D5tUdm/uWY9vmI9NG+kmyCZ4Oylp4FkzB32
         s11AF0YbnPujug9Mfe8bK280Dqw04fgxvEjEbadY/M1gUB4gq4iqVQs4AGEuTyZQyPTy
         /Ubwwxs5RdRQu19kDVv+H7RUJJonKhUg82pQVm11fplqi94ZomA5xRJN8F8hdECvcBi1
         Ak+grhnHS4v6rwtjPavPA9o+p3Wb5v0eWtoEOBeFq4q4c0gmBGccYXLf3qiCC9b/lGoM
         s+qKk6gCGpYiTmvONcUy7qwj0FxPrRVx2jDfbtqc/8II9vD76u0U3lh/87uecLqN5oEt
         150w==
X-Gm-Message-State: AOAM530CVMVtZQIKI2GI0fh4rA/xPwgqNB00ktZArcHTYewaSQnYrdgi
        A3iOBSNdnhKKS2URmRT8f80=
X-Google-Smtp-Source: ABdhPJwjecatOou2FojjS4Q5ivhQZzJu9dQ5hERPjw61bfMZF5fKRgk86NeYWnsy8MHcwdqY3PoxRg==
X-Received: by 2002:a63:4d61:: with SMTP id n33mr9008079pgl.219.1627125569239;
        Sat, 24 Jul 2021 04:19:29 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id v15sm21310057pff.105.2021.07.24.04.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 04:19:28 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 3/3] drm/vmwgfx: fix potential UAF in vmwgfx_surface.c
Date:   Sat, 24 Jul 2021 19:18:24 +0800
Message-Id: <20210724111824.59266-4-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724111824.59266-1-desmondcheongzx@gmail.com>
References: <20210724111824.59266-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_file.master should be protected by either drm_device.master_mutex
or drm_file.master_lookup_lock when being dereferenced. However,
drm_master_get is called on unprotected file_priv->master pointers in
vmw_surface_define_ioctl and vmw_gb_surface_define_internal.

This is fixed by replacing drm_master_get with drm_file_get_master.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 0eba47762bed..5d53a5f9d123 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -865,7 +865,7 @@ int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
 	user_srf->prime.base.shareable = false;
 	user_srf->prime.base.tfile = NULL;
 	if (drm_is_primary_client(file_priv))
-		user_srf->master = drm_master_get(file_priv->master);
+		user_srf->master = drm_file_get_master(file_priv);
 
 	/**
 	 * From this point, the generic resource management functions
@@ -1534,7 +1534,7 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 
 	user_srf = container_of(srf, struct vmw_user_surface, srf);
 	if (drm_is_primary_client(file_priv))
-		user_srf->master = drm_master_get(file_priv->master);
+		user_srf->master = drm_file_get_master(file_priv);
 
 	res = &user_srf->srf.res;
 
-- 
2.25.1

