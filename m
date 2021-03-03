Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A2732BE91
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385841AbhCCRcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447360AbhCCNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D814C0698C5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so23750558wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEJvtnthzxGLrB5bQwa4uMR+8QlI7X4kpk4nucMTE3c=;
        b=M3vfJNlivn2MoPxBwPRWD4bTTqeqqG8QnJoarAygkTYue/NKMFOklFxuJPRD4hPDGR
         n29NRPFIHqLXys8C0/TLJRC1IiyQJiSwdI96kiLnquGwIc1Q2EprMXp2s/OmL5e1ppvE
         zt3wJKtimq5Fqv6t/Tppo9p5QJyfYLq6DSVM7GywQNabq/fXvDzTtJmFfY368k5dufGZ
         JWZDg/rqsmdWQz54JeK6Q1eXYSl4Y2lcjN1Oe2yyQGBpUPnTab4IVQiS4C1Ch38dR81N
         u40lqKp3osyQFcCWbZOWzvUjCbweeaFd+Em42nbsPDkaab76WQxvgAxyopt4BKk0dHnD
         cS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEJvtnthzxGLrB5bQwa4uMR+8QlI7X4kpk4nucMTE3c=;
        b=FRvYj7WfSJLTrHwwpQYtaTb2ge4Hw3YvhcooMinItgV9XF5VArnM+u5ZXED+sNxNu0
         16zTJTlz0TwJ23goQf7I3cA0i6AoaQeTQ86UR4m6RQCsVzIlT5mVLhVy+6KZfOFgCRBp
         Zsw1I52DKwlIAqQIAA65v5xzzAVLZKi/7FVehCA6O36/62HHK9Pc2h4yU47KMIbLbA3q
         tIWZInPa5cLyT9DThtvyzMBddMOWYRJkG2EhiLspf2+sotmSSKECZgWFe7TiuLr4nNmR
         cE7kbFjE+dbPJXpQYLr5IlKaiJmWlulxMWVA5HBYaLn/Y7dWePmfjQiXyWteRHy/lNwR
         hi7Q==
X-Gm-Message-State: AOAM530t/yqT6fGRy6oRy2h1MXHKcbx8cZ34E+hJtc0rZsXThegAk/E0
        7fAOTCwxXIWKC/lwCu3BOnHEyg==
X-Google-Smtp-Source: ABdhPJxd8tXaGDq8DipT3hL1GqitxbrI9v1AI6atczwx3xV3+lTp+RKru1jUJ4ndP3PEbZXuiorlJQ==
X-Received: by 2002:adf:f743:: with SMTP id z3mr26906208wrp.304.1614779059267;
        Wed, 03 Mar 2021 05:44:19 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 43/53] drm/vmwgfx/vmwgfx_stdu: Add some missing param/member descriptions
Date:   Wed,  3 Mar 2021 13:43:09 +0000
Message-Id: <20210303134319.3160762-44-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:77: warning: Function parameter or member 'pitch' not described in 'vmw_stdu_dirty'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'content_fb_type' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'display_width' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'display_height' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'cpp' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:682: warning: Function parameter or member 'user_fence_rep' not described in 'vmw_kms_stdu_dma'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-41-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index fbe9778813648..01567534f4fae 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -61,6 +61,7 @@ enum stdu_content_type {
  * @bottom: Bottom side of bounding box.
  * @fb_left: Left side of the framebuffer/content bounding box
  * @fb_top: Top of the framebuffer/content bounding box
+ * @pitch: framebuffer pitch (stride)
  * @buf: buffer object when DMA-ing between buffer and screen targets.
  * @sid: Surface ID when copying between surface and screen targets.
  */
@@ -109,8 +110,11 @@ struct vmw_stdu_update_gb_image {
  *               content_vfbs dimensions, then this is a pointer into the
  *               corresponding field in content_vfbs.  If not, then this
  *               is a separate buffer to which content_vfbs will blit to.
- * @content_type:  content_fb type
- * @defined:  true if the current display unit has been initialized
+ * @content_fb_type: content_fb type
+ * @display_width:  display width
+ * @display_height: display height
+ * @defined:     true if the current display unit has been initialized
+ * @cpp:         Bytes per pixel
  */
 struct vmw_screen_target_display_unit {
 	struct vmw_display_unit base;
@@ -652,6 +656,7 @@ static void vmw_stdu_bo_cpu_commit(struct vmw_kms_dirty *dirty)
  * @file_priv: Pointer to a struct drm-file identifying the caller. May be
  * set to NULL, but then @user_fence_rep must also be set to NULL.
  * @vfb: Pointer to the buffer-object backed framebuffer.
+ * @user_fence_rep: User-space provided structure for fence information.
  * @clips: Array of clip rects. Either @clips or @vclips must be NULL.
  * @vclips: Alternate array of clip rects. Either @clips or @vclips must
  * be NULL.
-- 
2.27.0

