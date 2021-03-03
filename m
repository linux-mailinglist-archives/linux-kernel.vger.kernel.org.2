Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8032BEA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574630AbhCCRd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbhCCOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:01:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF7C0698CC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l12so23739182wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sz9Cp9ck6lJ+tMgVjEzPh2tJa07UDmiPup+Dgs8FC3o=;
        b=iRy5BujrVB9UEC5KMSnntpLfMBSYx0sVYaWNWZtKRMbnfDlkW/xumxxReE2x6f5B+j
         C0YnAMlW/JaMuXcrib4m8rvnxbyOZ36xtoSET7LYyASMvRURQhfJ7pf8bl+g61GAK/np
         twPqCvB89X+kHDseXK0/0AcK3ZFQREgadEuf4s6F5u7rpsa9yGgbVByv8gCdVwye7pZR
         eW4VH77/+ncFbnovCOdTWhN12gKBWETnnMn3yqNib52JMaMAjMggvud4liml0Oznjr6H
         NUrXh02BQETuPOpXgl6++cFz53olwrsHgUlUBbSl/5PfOJnaoV20ZB2d0nKg42s3n9Mg
         3MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sz9Cp9ck6lJ+tMgVjEzPh2tJa07UDmiPup+Dgs8FC3o=;
        b=h9pdhR/FkObfAZnKjTKY6tUr8CTFWqVItOogRu66IB0R/WfyY+xBZd2ACQ2Cd3p5bQ
         qJGndEhcuf7Tl9ozXFblBQozMOw2E/sk3Ohxi+HFNkwPK2xQnGzrqD31USKHP5UFbI7Z
         Meyt0PxRY7Ec9TqFAT7dP7Gk5LQdzV3u51JJnjlxwBhewM59NSJvm6ibSvTkbMCFVN9N
         I9+vYN8+31bgKeiGcGpZ42OUyxsjM2Jq/y44oa9luBH7+B+o1BMy5D2LHZRI51LFXNBj
         M9SZniCseQ5rygUJlB0GlNRlcnXgkRMwSYlydw3eWuspajDgAGNjfaFQ6eUXnzwgswWg
         PX9w==
X-Gm-Message-State: AOAM5336JHcpJXTEFFmdvzK9lKT1DOJXHHpmglmKAk8i/KHBjrpv6Vqt
        6Mt6btLaTxTXD4x14GQ0BHHFsw==
X-Google-Smtp-Source: ABdhPJxZtKJwNy4AEa9+LfCn/Kqgk+fd8Wxe16REP0b9PL7P3uOVtkPWy2CEDF6SiwDSEhPhb5aGQQ==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr27897680wrx.166.1614779066850;
        Wed, 03 Mar 2021 05:44:26 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 50/53] drm/vmwgfx/vmwgfx_validation: Add some missing struct member/function param descriptions
Date:   Wed,  3 Mar 2021 13:43:16 +0000
Message-Id: <20210303134319.3160762-51-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:85: warning: Function parameter or member 'dirty' not described in 'vmw_validation_res_node'
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:85: warning: Function parameter or member 'dirty_set' not described in 'vmw_validation_res_node'
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:216: warning: Function parameter or member 'res' not described in 'vmw_validation_find_res_dup'
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c:216: warning: Excess function parameter 'vbo' description in 'vmw_validation_find_res_dup'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-9-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
index f2e2bf6d1421f..e7570f422400d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
@@ -48,7 +48,6 @@ struct vmw_validation_bo_node {
 	u32 as_mob : 1;
 	u32 cpu_blit : 1;
 };
-
 /**
  * struct vmw_validation_res_node - Resource validation metadata.
  * @head: List head for the resource validation list.
@@ -64,6 +63,8 @@ struct vmw_validation_bo_node {
  * @first_usage: True iff the resource has been seen only once in the current
  * validation batch.
  * @reserved: Whether the resource is currently reserved by this process.
+ * @dirty_set: Change dirty status of the resource.
+ * @dirty: Dirty information VMW_RES_DIRTY_XX.
  * @private: Optionally additional memory for caller-private data.
  *
  * Bit fields are used since these structures are allocated and freed in
@@ -205,7 +206,7 @@ vmw_validation_find_bo_dup(struct vmw_validation_context *ctx,
  * vmw_validation_find_res_dup - Find a duplicate resource entry in the
  * validation context's lists.
  * @ctx: The validation context to search.
- * @vbo: The buffer object to search for.
+ * @res: Reference counted resource pointer.
  *
  * Return: Pointer to the struct vmw_validation_bo_node referencing the
  * duplicate, or NULL if none found.
-- 
2.27.0

