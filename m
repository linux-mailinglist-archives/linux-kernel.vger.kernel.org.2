Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3732BE8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385792AbhCCRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbhCCNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:50:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C88DC0698C8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:25 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o7-20020a05600c4fc7b029010a0247d5f0so2871398wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qqHnZY9azPURq/zESXDkivU/6fDs3hRcSOtRIxqVho=;
        b=KHHkfD9oMrDLgRGT9BRw5QflsrbtFF3LreHHXNdLoUenAu3jbytf104HvLb7XWSeoJ
         SVMtJgdIrBSIAa+e1T7fCS/BrqQEFmXq/pGqaG/qRCT4Q7/U4PKuGoQI5XV7TqfwzEM4
         xhqFTH8QfJVdSkAgfFRES9Kuu4EwWaNLUWnD4JVXYvZhaGYMWphzo2zxOg0xlAGIsy24
         nakblZCIrZoZjzEFp2tnyeLL/GC2ml/D70+t2ArnjLuPCHd8VaCfi0UwfN8mfFStkALw
         VoWDH1d7kIn49EJT0qO8PZSo/nMqEqbrR2n6UcOMgL/z3l1vgKv+qIydVp05R/0pkDB8
         QFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qqHnZY9azPURq/zESXDkivU/6fDs3hRcSOtRIxqVho=;
        b=SApeU33ENg8syUuaGw6gfE5oUfsTIq10YH8/NVdEo3tVr/JqPnSA0OhLPyxK6jtxKW
         txFeIq7RFCrylf5K8pNBHHb0+sLHzQy1xQN8jlcIlpVsJEavEUC39s6O5gS5MY9+CRDx
         YkysPep1VQbuFNM4Ipw7RDuV0+XzWpkebdIiNc3F92z95dVfEtwSYuYyp0CXVhWcrfu9
         DtHKjTCfdi9kVxg2L2t9wKm+2YkvjkJcCOi5r/9S5I/lwkyFp6JCmHKS0F3ZX2pnMb9R
         MDx3GtqGpAqDgnLptZjNVcOxjGODFvI9d6/4Vw42WQYcADOQr5Y+sXqL6pwWofe/ZwIX
         ZN8g==
X-Gm-Message-State: AOAM532TRKTUYbHRrCVkEKbNifSAkqF0Kt+vBYijUug2fglL4MGCfI5X
        GD7uHMFJMkXZD6w/Kpmnzx4NQA==
X-Google-Smtp-Source: ABdhPJz9votcon5DHgeLgHgLV3hpp3bV0kvfgrgW9O58tctnt1s1Gl+oDWKTuwCob4HsDlWt6cVzAg==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr9055056wmc.104.1614779063880;
        Wed, 03 Mar 2021 05:44:23 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 47/53] drm/vmwgfx/vmwgfx_binding: Provide some missing param descriptions and remove others
Date:   Wed,  3 Mar 2021 13:43:13 +0000
Message-Id: <20210303134319.3160762-48-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:340: warning: Function parameter or member 'shader_slot' not described in 'vmw_binding_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:340: warning: Function parameter or member 'slot' not described in 'vmw_binding_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:376: warning: Function parameter or member 'from' not described in 'vmw_binding_transfer'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:498: warning: Function parameter or member 'to' not described in 'vmw_binding_state_commit'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:498: warning: Excess function parameter 'ctx' description in 'vmw_binding_state_commit'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:498: warning: Excess function parameter 'scrubbed' description in 'vmw_binding_state_commit'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:520: warning: Function parameter or member 'cbs' not described in 'vmw_binding_rebind_all'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:520: warning: Excess function parameter 'ctx' description in 'vmw_binding_rebind_all'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:795: warning: Function parameter or member 'shader_slot' not described in 'vmw_emit_set_sr'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-5-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
index 180f6dbc9460d..81f525a82b77f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
@@ -330,6 +330,8 @@ static void vmw_binding_drop(struct vmw_ctx_bindinfo *bi)
  *
  * @cbs: Pointer to the context binding state tracker.
  * @bi: Information about the binding to track.
+ * @shader_slot: The shader slot of the binding.
+ * @slot: The slot of the binding.
  *
  * Starts tracking the binding in the context binding
  * state structure @cbs.
@@ -367,6 +369,7 @@ void vmw_binding_add_uav_index(struct vmw_ctx_binding_state *cbs, uint32 slot,
  * vmw_binding_transfer: Transfer a context binding tracking entry.
  *
  * @cbs: Pointer to the persistent context binding state tracker.
+ * @from: Staged binding info built during execbuf
  * @bi: Information about the binding to track.
  *
  */
@@ -484,9 +487,8 @@ void vmw_binding_res_list_scrub(struct list_head *head)
 /**
  * vmw_binding_state_commit - Commit staged binding info
  *
- * @ctx: Pointer to context to commit the staged binding info to.
+ * @to:   Staged binding info area to copy into to.
  * @from: Staged binding info built during execbuf.
- * @scrubbed: Transfer only scrubbed bindings.
  *
  * Transfers binding info from a temporary structure
  * (typically used by execbuf) to the persistent
@@ -511,7 +513,7 @@ void vmw_binding_state_commit(struct vmw_ctx_binding_state *to,
 /**
  * vmw_binding_rebind_all - Rebind all scrubbed bindings of a context
  *
- * @ctx: The context resource
+ * @cbs: Pointer to the context binding state tracker.
  *
  * Walks through the context binding list and rebinds all scrubbed
  * resources.
@@ -789,6 +791,7 @@ static void vmw_collect_dirty_view_ids(struct vmw_ctx_binding_state *cbs,
  * vmw_binding_emit_set_sr - Issue delayed DX shader resource binding commands
  *
  * @cbs: Pointer to the context's struct vmw_ctx_binding_state
+ * @shader_slot: The shader slot of the binding.
  */
 static int vmw_emit_set_sr(struct vmw_ctx_binding_state *cbs,
 			   int shader_slot)
-- 
2.27.0

