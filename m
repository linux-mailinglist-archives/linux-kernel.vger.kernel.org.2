Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4432BE83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381175AbhCCRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhCCNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B9C0698C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h98so23718542wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+MStikPfDla/YrgFsim+wcVpR21mbPxef0tFFhFog8=;
        b=ZxPSjAYBeY6Ew+0mFhPGBPYY8Lyk40dtOffmYtbori5yFJdKNqaMJMJ4bPkHDjQOR2
         SiGlbR9HHyRVwl++Vt8ramhkvCPBZ4SM3jZl9MH6WQV+SQrw/OsXzrJh90N8kfG6oSc0
         GtxuD7iALslsZBmuYINQ3CWxJ5jklICLZS8AdjWjmA95LTw3SAi8MxssOdHSPDoGwmv3
         Q9CLG05cLv7lPoTsXOcobB03h3+yJ1Em7U7yN3iUbcWXb8JrDgPD/KbWF4u6HSfeDBqO
         hLuu+f7Db0t497c+BSz1rm4+dglWkMOMoJh/lt8OQqxBgiYpj3VTmnv7eUuTE1NBuS/U
         Q2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+MStikPfDla/YrgFsim+wcVpR21mbPxef0tFFhFog8=;
        b=f0wgWTdyS5lpisDoLMw62IwNsg2/n1olZKcu4uGrX5eWwPkhTHyDrQ4vPHPiohqWKE
         FeAJlqV6mhcIPhoHqpcGfygUF1tnyxCiyNH6dTaESEA0/X446AuDQR7iyovX0F4Ybdh7
         aStItmdRjIIHAtSLOuKZno3Dl2ePvCyRdgWUODRDYY3TZLhtrXVyc6suwXpLmQeL4tdQ
         IbSQix7mkUl74tMDeeONX9tEleZ8oM45btCzPG9DtdONhIAWfBI0y/625hIXFBLHpQF5
         fNWfATtSyfttQIx7MEJAc7vEdrsEGfTGJJnDQGleWBPEV4gC77mPt9m+KsLJbJU7HFl2
         IAIw==
X-Gm-Message-State: AOAM532LNvPCJlkVZN8kKYZLmAC9g1oTO+3qeFqrIR+mFdD2lUCf4YRU
        NvIuNcfjWARzdPFTXavqJhrB+w==
X-Google-Smtp-Source: ABdhPJzLqIembOWI8dg3akIVz8pRPBnUzgJo227nUhNe6H9k+zht4gvQ/bdOAbNzhRgyqzED/CRomQ==
X-Received: by 2002:adf:f2c3:: with SMTP id d3mr27872270wrp.380.1614779055888;
        Wed, 03 Mar 2021 05:44:15 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 40/53] drm/vmwgfx/vmwgfx_shader: Demote kernel-doc abuses and fix-up worthy headers
Date:   Wed,  3 Mar 2021 13:43:06 +0000
Message-Id: <20210303134319.3160762-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:134: warning: Function parameter or member 'res' not described in 'vmw_res_to_shader'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:663: warning: Function parameter or member 'base' not described in 'vmw_user_shader_base_to_res'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:695: warning: Function parameter or member 'p_base' not described in 'vmw_user_shader_base_release'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:965: warning: Function parameter or member 'dev_priv' not described in 'vmw_compat_shader_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:965: warning: Function parameter or member 'size' not described in 'vmw_compat_shader_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:965: warning: Excess function parameter 'tfile' description in 'vmw_compat_shader_add'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-37-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index 905ae50aaa2ae..a0db065640131 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -125,7 +125,7 @@ static const struct vmw_res_func vmw_dx_shader_func = {
 	.commit_notify = vmw_dx_shader_commit_notify,
 };
 
-/**
+/*
  * Shader management:
  */
 
@@ -654,7 +654,7 @@ int vmw_dx_shader_add(struct vmw_cmdbuf_res_manager *man,
 
 
 
-/**
+/*
  * User-space shader management:
  */
 
@@ -686,7 +686,7 @@ static void vmw_shader_free(struct vmw_resource *res)
 			    vmw_shader_size);
 }
 
-/**
+/*
  * This function is called when user space has no more references on the
  * base object. It releases the base-object's reference on the resource object.
  */
@@ -945,13 +945,13 @@ int vmw_shader_remove(struct vmw_cmdbuf_res_manager *man,
  * vmw_compat_shader_add - Create a compat shader and stage it for addition
  * as a command buffer managed resource.
  *
+ * @dev_priv: Pointer to device private structure.
  * @man: Pointer to the compat shader manager identifying the shader namespace.
  * @user_key: The key that is used to identify the shader. The key is
  * unique to the shader type.
  * @bytecode: Pointer to the bytecode of the shader.
  * @shader_type: Shader type.
- * @tfile: Pointer to a struct ttm_object_file that the guest-backed shader is
- * to be created with.
+ * @size: Command size.
  * @list: Caller's list of staged command buffer resource actions.
  *
  */
-- 
2.27.0

