Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE532BE82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380303AbhCCRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhCCNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8519C0698C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m1so6400193wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skXCklvbLkMdUopRkkr7nz9lm78nkYKqb32FzAH7TqM=;
        b=VYP0HDoLjO3oZLwwUXl4OtppTMndAhsqKdA/I28iUr+7kmM0FBHDRY5Nfgy6V3kYLP
         B1AF5yzPzAWn62i1s+UOzUSBjCqjeaZ+qInKZgPpSux/544nyXDvOaKXw/351XXI4qN3
         I0nUMq3JAkLpcUyCLUDbBpUs22MZnBfAqHUR6LNsWzPS9LZxtyuhzbEjiFqUaWdGJuhn
         TbLoxbcqysuDGfNlU1UvZVD3Ds0SurcGNzsA3R9vXsxlGtkccB6rgumvrSilo/mKlP8e
         BZ05EefhF15519Ozh159XAmZ8TrhLURNqOYKcsbSTI+swv1AXJhiliTHHjNpy8v4pRkZ
         19iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skXCklvbLkMdUopRkkr7nz9lm78nkYKqb32FzAH7TqM=;
        b=J08fMXCey6QCaRRZCX+MwANHW5Nw2K3JthgaJhD+WFD2J+kAs0nG8224m+j/lTDOEu
         wE8UBKYZmm+ho/cnhL3f25+O6yI/BiIBQmNu2xmy1sWw+Fe/oYluhzHb0jWxvL9m/RaF
         ctOqvyUTXxDdUgJXDMxP5VCxaZa3IbGYpHbjFoGdwNfmOGTqBlxdH49e5pz9RZucAYch
         4qkHMYk3B8yPzlXU/5u9tcIkRZTfy8Bl+Accu9B2X2cmngU1Edc3/AHbUUw29HrN/toD
         F6S7rauQjPGgmceTO1t0ESgQ/+UYYLzuXhseamRx6ExqeT3q3FW+FB/dy2bzs7KL3q64
         3/qQ==
X-Gm-Message-State: AOAM532XRRfXfXLGHOfdqVs83A3dFI7bm3oDU/WZ2IywUWyyRTOEWfZO
        4yPYt+cPsFGGaaDSp5nRBIbNBg==
X-Google-Smtp-Source: ABdhPJwe+gr1id7lFcISbMgFcWSv4o73aEwdV4x1IoMr0r1dFOC7mRTEkAOXQGqFKFeTquh12fefog==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr9541891wmq.159.1614779053381;
        Wed, 03 Mar 2021 05:44:13 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 38/53] drm/vmwgfx/vmwgfx_surface: Fix some kernel-doc related issues
Date:   Wed,  3 Mar 2021 13:43:04 +0000
Message-Id: <20210303134319.3160762-39-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:55: warning: Function parameter or member 'prime' not described in 'vmw_user_surface'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:55: warning: Function parameter or member 'backup_base' not described in 'vmw_user_surface'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:78: warning: cannot understand function prototype: 'struct vmw_surface_dirty '
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:173: warning: Function parameter or member 'header' not described in 'vmw_surface_dma'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:173: warning: Function parameter or member 'body' not described in 'vmw_surface_dma'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:173: warning: Function parameter or member 'cb' not described in 'vmw_surface_dma'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:173: warning: Function parameter or member 'suffix' not described in 'vmw_surface_dma'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:181: warning: Function parameter or member 'header' not described in 'vmw_surface_define'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:181: warning: Function parameter or member 'body' not described in 'vmw_surface_define'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:189: warning: Function parameter or member 'header' not described in 'vmw_surface_destroy'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:189: warning: Function parameter or member 'body' not described in 'vmw_surface_destroy'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:555: warning: Function parameter or member 'readback' not described in 'vmw_legacy_srf_unbind'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:1067: warning: Function parameter or member 'res' not described in 'vmw_gb_surface_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:1067: warning: Excess function parameter 'srf' description in 'vmw_gb_surface_create'
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:1067: warning: Excess function parameter 'cmd_space' description in 'vmw_gb_surface_create'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-34-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index f6cab77075a04..c3e55c1376eb8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -41,10 +41,12 @@
 /**
  * struct vmw_user_surface - User-space visible surface resource
  *
+ * @prime:          The TTM prime object.
  * @base:           The TTM base object handling user-space visibility.
  * @srf:            The surface metadata.
  * @size:           TTM accounting size for the surface.
- * @master: master of the creating client. Used for security check.
+ * @master:         Master of the creating client. Used for security check.
+ * @backup_base:    The TTM base object of the backup buffer.
  */
 struct vmw_user_surface {
 	struct ttm_prime_object prime;
@@ -69,7 +71,7 @@ struct vmw_surface_offset {
 };
 
 /**
- * vmw_surface_dirty - Surface dirty-tracker
+ * struct vmw_surface_dirty - Surface dirty-tracker
  * @cache: Cached layout information of the surface.
  * @size: Accounting size for the struct vmw_surface_dirty.
  * @num_subres: Number of subresources.
@@ -162,7 +164,7 @@ static const struct vmw_res_func vmw_gb_surface_func = {
 	.clean = vmw_surface_clean,
 };
 
-/**
+/*
  * struct vmw_surface_dma - SVGA3D DMA command
  */
 struct vmw_surface_dma {
@@ -172,7 +174,7 @@ struct vmw_surface_dma {
 	SVGA3dCmdSurfaceDMASuffix suffix;
 };
 
-/**
+/*
  * struct vmw_surface_define - SVGA3D Surface Define command
  */
 struct vmw_surface_define {
@@ -180,7 +182,7 @@ struct vmw_surface_define {
 	SVGA3dCmdDefineSurface body;
 };
 
-/**
+/*
  * struct vmw_surface_destroy - SVGA3D Surface Destroy command
  */
 struct vmw_surface_destroy {
@@ -544,6 +546,7 @@ static int vmw_legacy_srf_bind(struct vmw_resource *res,
  *
  * @res:            Pointer to a struct vmw_res embedded in a struct
  *                  vmw_surface.
+ * @readback:       Readback - only true if dirty
  * @val_buf:        Pointer to a struct ttm_validate_buffer containing
  *                  information about the backup buffer.
  *
@@ -1060,8 +1063,8 @@ int vmw_surface_reference_ioctl(struct drm_device *dev, void *data,
 /**
  * vmw_surface_define_encode - Encode a surface_define command.
  *
- * @srf: Pointer to a struct vmw_surface object.
- * @cmd_space: Pointer to memory area in which the commands should be encoded.
+ * @res:        Pointer to a struct vmw_resource embedded in a struct
+ *              vmw_surface.
  */
 static int vmw_gb_surface_create(struct vmw_resource *res)
 {
-- 
2.27.0

