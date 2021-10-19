Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7C433E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhJSSM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhJSSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:12:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357AC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:10:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m42so13465156wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkQbOoP/+0N5j4wytKxJfGYLSAuO1fbKKTQCyzqNEpc=;
        b=ZAwL72nMvl8TZfTQepywrkwV7ioeJAUrEnyM2HrUBojS+OCkLHwmYwpHNbRIsSe5gI
         P8UOh0ne0mxguVVlK/pF6AY8Jhjy+U8YpRBmmrYf6tAWPVEIJq8l4PWd4UH8dJg6IRWx
         pM6B+9pfH8L7vnmRcoTgb7BoIu++BXvUPy1zlbbztIJgNtQD8X0FEd8j8iAylUV8zwUK
         JTBQhMEmDw6X4D7N1NApqDNpCgNcHI/QWBwbYkdvYMHMB4gkxxXK984GMK1clGmk3ZdH
         OoC7XJgno9aBIQdLpFV3ZB0NL09dAm8dFH7+CWd8ZNvS2eWKZDTUGK/0EDYu84UCdJvr
         n3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkQbOoP/+0N5j4wytKxJfGYLSAuO1fbKKTQCyzqNEpc=;
        b=jXEBLEBSds5JPylaacVouBfSeLipY0A52plVi7G1tcHM+BtCYcj++q/rSj/ifXnbTE
         yrUnD6N2eLy8WEwULpq2YtCLVmRVe4GTVa9A+3F3JiQ523rISf3n2fdYyvP/N0/R7h6/
         DIPGR6SaxfgwFjVXkRWFB/zTH+Kdwfvu3NUK9GmfTfpj0yuWpobkVbZ0w7AWxUPOF5bq
         ejIdlgglt0I15uZmM5EJDxSWXlMPovkgBbZbWr3Ea3zzipoLdL3VnUPxBUGOujqUiUxd
         hAmpB89wUm6C0ljCY3zRcBOfvuaIekWATI77dy3JeF2zi5L6eJlPl7c+asUhKWcmX2SE
         Mf8g==
X-Gm-Message-State: AOAM532Y6OqNHJNwVhJHUPE1W2fplFjJUVn/RTUbch8hAvygK5tkiEUN
        vdXKFNXJa92lRAZkWIG0G6TVUa+a94s=
X-Google-Smtp-Source: ABdhPJwDTK6c1LsA20fuK4Ogpi1SXUC1fvQIs3S0dKO9MfZhXz+PO+ZSWdQI8kQ/4/asgaInGjujKA==
X-Received: by 2002:adf:bb81:: with SMTP id q1mr46649180wrg.119.1634667043622;
        Tue, 19 Oct 2021 11:10:43 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id 73sm2871763wmb.40.2021.10.19.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:10:43 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/sun4i: virtual CMA addresses are not needed
Date:   Tue, 19 Oct 2021 20:10:28 +0200
Message-Id: <20211019181028.4190737-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver never uses virtual address of DRM CMA buffers. Switch to CMA
helpers which don't deal with virtual mapping.

This was actually already the case before commit ad408c766cef
("drm/sun4i: Use DRM_GEM_CMA_VMAP_DRIVER_OPS for GEM operations"),
but only convenient macro at the time used helpers with virtual
mapping.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 54dd562e294c..b630614b3d72 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -53,7 +53,7 @@ static const struct drm_driver sun4i_drv_driver = {
 	.minor			= 0,
 
 	/* GEM Operations */
-	DRM_GEM_CMA_DRIVER_OPS_VMAP_WITH_DUMB_CREATE(drm_sun4i_gem_dumb_create),
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(drm_sun4i_gem_dumb_create),
 };
 
 static int sun4i_drv_bind(struct device *dev)
-- 
2.33.1

