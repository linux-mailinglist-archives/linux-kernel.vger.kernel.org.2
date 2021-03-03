Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC632BE88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385741AbhCCRb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447355AbhCCNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D25C0698C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u16so5734265wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oU+Wuk0/TjV8ruLVEbq6ixpjRneTtMF4qHY1z5Ned04=;
        b=q18eepXedncQkYrl7klqtSmyDsv1da3LROy3QdvrfbU4mhiYOow55NlC78cGMJgA4C
         +GqgDuboY2FgIAY9TSeBbzjPOkPhkKsh7+7UNDRyjUdgXfmDz9dnTN5wQfjwzcnDO+IP
         qEZJCDueuZ/8dUhqZuD3xLnZu0EtraaFy4HzVGdD+QsUgs89Lf8rJMxMG5Gt/5CSBmxv
         jhUsJhSCPxYAjbSqDfO8IaS2rxC5grdYGZUqLkV0/R7Th3+rmSYHFfLutzrfLU4Xclp+
         5j2th56OokJ5gqK0uC3EidXW/5JfJ+FoK7bL268Je2dRQZy9qy0mxxOCaJHt4o0sRu1r
         eU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oU+Wuk0/TjV8ruLVEbq6ixpjRneTtMF4qHY1z5Ned04=;
        b=QltbRwgnE4FK+oh+gXbnbTL9ejAYBNSilWyS+A72AC8ESFQgyGlzVk342oezXH9749
         dQNcoBD3s3pBsE/I5D+VlpajBnbL5pS6E8zPoWmKDoN1LRffyeW40/q0ewSTRVw6oNFg
         YHw31ECHthCmtWg3Y7osKZGiFafiaWktIJRuXQmU+Y0RCu89h/kzYG9fIaD1h9nzDb3z
         rmD/JP6xMUOWeSGpranbhAiQgWkLj2ZN3XdgR9M3eQuf3wgCZKIo+spkrGC+N2qaNb0b
         FQrwqR4iutBUJ9EeMtwn+ezJ5/XDFjB8R2OSwgY1MHlV3LrsggCOwdgtPAjqLSFVpe6g
         KnTw==
X-Gm-Message-State: AOAM5317UTnewaX42+hxLFCJCKNnqhUjqm9uqs3qA+RGpyBVwJPySWGt
        1UEW5BoBMK4kk/P5+8fGg7ggWQ==
X-Google-Smtp-Source: ABdhPJxAWbIB9dzrj4kD6cvlizaCG/C3XcFqBAgW0/W0ST4tthKwcOPqZQAVqX04CamVOPFrRTadFg==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr27041197wrs.317.1614779054571;
        Wed, 03 Mar 2021 05:44:14 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 39/53] drm/vmwgfx/vmwgfx_cmdbuf_res: Rename param description and remove another
Date:   Wed,  3 Mar 2021 13:43:05 +0000
Message-Id: <20210303134319.3160762-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also fix a small formatting issue.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:83: warning: Function parameter or member 'res_type' not described in 'vmw_cmdbuf_res_lookup'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:83: warning: Excess function parameter 'resource_type' description in 'vmw_cmdbuf_res_lookup'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:161: warning: Excess function parameter 'man' description in 'vmw_cmdbuf_res_revert'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c:330: warning: Cannot understand  *

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-36-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 44d858ce4ce7f..92509fbf2fd1d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -69,7 +69,7 @@ struct vmw_cmdbuf_res_manager {
  * vmw_cmdbuf_res_lookup - Look up a command buffer resource
  *
  * @man: Pointer to the command buffer resource manager
- * @resource_type: The resource type, that combined with the user key
+ * @res_type: The resource type, that combined with the user key
  * identifies the resource.
  * @user_key: The user key.
  *
@@ -148,7 +148,6 @@ void vmw_cmdbuf_res_commit(struct list_head *list)
 /**
  * vmw_cmdbuf_res_revert - Revert a list of command buffer resource actions
  *
- * @man: Pointer to the command buffer resource manager
  * @list: Caller's list of command buffer resource action
  *
  * This function reverts a list of command buffer resource
@@ -327,7 +326,6 @@ void vmw_cmdbuf_res_man_destroy(struct vmw_cmdbuf_res_manager *man)
 }
 
 /**
- *
  * vmw_cmdbuf_res_man_size - Return the size of a command buffer managed
  * resource manager
  *
-- 
2.27.0

