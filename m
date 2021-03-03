Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22932BE85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385712AbhCCRbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhCCNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E8C061D7D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k66so6403936wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZfWPfWVAydp9c1JpExjEII7q1h7jeahnMQCqr/L+ySU=;
        b=saVDJ26t7oNKFUQwsL+FnoC2ZeIneC/6VVDLmxgPYUX1pI0oKfXk4WX6kmwcoLuznA
         RPNORFIetrA5fZ3XUOUmrTO49N/yLveaGeuNP/ZHO9hauUsb6wgXkxyJqiy5Y0eNJMCv
         SSbRJc3XSDmr9jQNPV3/aoZrr/oa6DvZJIiUxGj4gUlgv7/T48AWqh14qPdYZ8PQifmm
         Y9F58Q4TA1bVdvipYTzEZO8yx7iTtg2Yxwz2DZmFe+dLpVM/sVtdwhL5p6d1nKmyCP9F
         KSBBamRx9CwXZk+2h2/jK/4ybKIjSaYXgnAA17ObttEc6CjoRrAP4AVktpguf5AyiKaZ
         N6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZfWPfWVAydp9c1JpExjEII7q1h7jeahnMQCqr/L+ySU=;
        b=iDDYgHHTC72cs1PnKw4V3O5d/uMCMnW17y9ilXeFp2bXyIJ/sd+veuIipFRYySFMQR
         KwL3UqC5vRRLc1Px8uTCDRNAhxQ+yNssBHSnhm3jsgoWA7z5rjVsY/h2LH7UeorFrwjj
         bQS+OgeFI8KerOUqw1rgNdangUIh8mvly4zc/wZKkO7Ejfmv9tnnlVBii1ooXtYa8lZa
         42KbdM+P4GiNbznH4L0eMWQOWWAFY/035w9ifTUHVYKD3jk2ukq3WEJjwwZTxlm+Wye3
         efxOcA2ond1BPkXXP2Ae4FrtzHlcxBACCVV8iOnc2UfncJ4tz4hUd/Zxr/BZssmEEaGb
         VUwg==
X-Gm-Message-State: AOAM533Egv8ShEEspY27hWa/lCrcWfP0Bibpghl44w3n5g4suof/vn4f
        8egBYmGaCD4nAzoKnrTcz9w7EiK12TqNhg==
X-Google-Smtp-Source: ABdhPJzKqaRFAfr31zi+5FIk/MARWWGNhTdr0Nx16XjCRm4v+emDYuXZ8xw9OmJ7u4fIu8FyrYWlqw==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr8570012wmh.56.1614779050376;
        Wed, 03 Mar 2021 05:44:10 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 35/53] drm/vmwgfx/vmwgfx_bo: Remove superfluous param description and supply another
Date:   Wed,  3 Mar 2021 13:43:01 +0000
Message-Id: <20210303134319.3160762-36-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:142: warning: Excess function parameter 'pin' description in 'vmw_bo_pin_in_vram_or_gmr'
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:647: warning: Function parameter or member 'p_base' not described in 'vmw_user_bo_alloc'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-28-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 63dbc44eebe0b..ab0844b47d4d7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -131,7 +131,6 @@ int vmw_bo_pin_in_placement(struct vmw_private *dev_priv,
  *
  * @dev_priv:  Driver private.
  * @buf:  DMA buffer to move.
- * @pin:  Pin buffer if true.
  * @interruptible:  Use interruptible wait.
  * Return: Zero on success, Negative error code on failure. In particular
  * -ERESTARTSYS if interrupted by a signal
@@ -635,6 +634,7 @@ static void vmw_user_bo_ref_obj_release(struct ttm_base_object *base,
  * @handle: Pointer to where the handle value should be assigned.
  * @p_vbo: Pointer to where the refcounted struct vmw_buffer_object pointer
  * should be assigned.
+ * @p_base: The TTM base object pointer about to be allocated.
  * Return: Zero on success, negative error code on error.
  */
 int vmw_user_bo_alloc(struct vmw_private *dev_priv,
-- 
2.27.0

