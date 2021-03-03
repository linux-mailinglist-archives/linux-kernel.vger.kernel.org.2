Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B332BE8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385824AbhCCRc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447363AbhCCNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90692C0698C4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u14so23750441wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWkqFrvWeK76Y3iFCArRn0HDFC1AVp5EXu1AxGszpQA=;
        b=JDYmcNANhdbTHQufB6+ZlXI755geSXoJ34u2EDuKznl+G+oe16GAYHFpK8LqJ9InRv
         fb+qv2vU1wNpRN8GkIu8B78Z9MhFPYLvQ5RZBEPVwe9xuPfwJW7Uge8z3AMY/48S0sss
         L7Sfc3DpMwdYY3ITiVVa8R8wd1eD+keB1/dsz1g5oBRdrkgFPTiYrxT6iXC0QT2JHt8V
         uCSetT/eGRfMpqBjZy4oegCnccSqN6Qit6SfgAMwLFF9LOesQL3inwicuh4H/Ok8US1J
         pwqppOTdwzXNgF2uSPZdxJ9pkMK7AOSjheVbugoiIyOollZSLbhMV4S3GJ3PE3nHwso+
         +WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWkqFrvWeK76Y3iFCArRn0HDFC1AVp5EXu1AxGszpQA=;
        b=YHG9Lx50WqpUTsnh0JS3lt9SCayYvywYPghF4p6KkBREnwhMEsbQ8uUXYAX1s23Ira
         xZuxGXJekEShr8DmmXRF+b4qM60bOEmt/9g243BaeHrg3+ozNqg2Lo3ihXqYsvmx8ARB
         tYivAw0PgCwUX4Qx9z3z+V6pJ4sKLT1FmSwysmj+CaGTJKVVj/cMcC/LFEYRkh+rB/yO
         9GIrBnLmNeCJsioU/hitC7YPMcmjYk2kvHLFNkrRUxo1Nfi1QVQ7pfKrR2vTQvJUvec5
         0KiPhPjw/I1j7KgAxktCbMg66SmSmZ6iVJwbNXy1MQ5xATCEmXUR0V/Vbve1iYG2rCyg
         p7+g==
X-Gm-Message-State: AOAM533hL6RWOCPs619TQEZSboEf+n6vXvoF7cMfjklSs4ATCcurDiD/
        k6ao0lAvGumqknRlUQ6of3A6eg==
X-Google-Smtp-Source: ABdhPJw7H07jnRLOoG6m43qVmpJvmWYKHbzSMHAjc3d+Wg2Kjmi+Ql4lLmruLVzvUO8jjio1P0hjCg==
X-Received: by 2002:a5d:528f:: with SMTP id c15mr27393903wrv.142.1614779057184;
        Wed, 03 Mar 2021 05:44:17 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 41/53] drm/vmwgfx/vmwgfx_cmdbuf: Fix a bunch of missing or incorrectly formatted/named params
Date:   Wed,  3 Mar 2021 13:43:07 +0000
Message-Id: <20210303134319.3160762-42-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:58: warning: Function parameter or member 'block_submission' not described in 'vmw_cmdbuf_context'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:109: warning: cannot understand function prototype: 'struct vmw_cmdbuf_man '
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:164: warning: Function parameter or member 'handle' not described in 'vmw_cmdbuf_header'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:257: warning: Function parameter or member 'header' not described in '__vmw_cmdbuf_header_free'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:380: warning: Function parameter or member 'notempty' not described in 'vmw_cmdbuf_ctx_process'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:1168: warning: Function parameter or member 'context' not described in 'vmw_cmdbuf_preempt'
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:1193: warning: Function parameter or member 'context' not described in 'vmw_cmdbuf_startstop'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-38-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 45fbc41440f1e..3158924ffa852 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -48,6 +48,7 @@
  * @hw_submitted: List of command buffers submitted to hardware.
  * @preempted: List of preempted command buffers.
  * @num_hw_submitted: Number of buffers currently being processed by hardware
+ * @block_submission: Identifies a block command submission.
  */
 struct vmw_cmdbuf_context {
 	struct list_head submitted;
@@ -58,7 +59,7 @@ struct vmw_cmdbuf_context {
 };
 
 /**
- * struct vmw_cmdbuf_man: - Command buffer manager
+ * struct vmw_cmdbuf_man - Command buffer manager
  *
  * @cur_mutex: Mutex protecting the command buffer used for incremental small
  * kernel command submissions, @cur.
@@ -143,7 +144,7 @@ struct vmw_cmdbuf_man {
  * @cb_context: The device command buffer context.
  * @list: List head for attaching to the manager lists.
  * @node: The range manager node.
- * @handle. The DMA address of @cb_header. Handed to the device on command
+ * @handle: The DMA address of @cb_header. Handed to the device on command
  * buffer submission.
  * @cmd: Pointer to the command buffer space of this buffer.
  * @size: Size of the command buffer space of this buffer.
@@ -249,7 +250,7 @@ static void vmw_cmdbuf_header_inline_free(struct vmw_cmdbuf_header *header)
  * __vmw_cmdbuf_header_free - Free a struct vmw_cmdbuf_header  and its
  * associated structures.
  *
- * header: Pointer to the header to free.
+ * @header: Pointer to the header to free.
  *
  * For internal use. Must be called with man::lock held.
  */
@@ -365,10 +366,11 @@ static void vmw_cmdbuf_ctx_submit(struct vmw_cmdbuf_man *man,
 }
 
 /**
- * vmw_cmdbuf_ctx_submit: Process a command buffer context.
+ * vmw_cmdbuf_ctx_process - Process a command buffer context.
  *
  * @man: The command buffer manager.
  * @ctx: The command buffer context.
+ * @notempty: Pass back count of non-empty command submitted lists.
  *
  * Submit command buffers to hardware if possible, and process finished
  * buffers. Typically freeing them, but on preemption or error take
@@ -1161,6 +1163,7 @@ static int vmw_cmdbuf_send_device_command(struct vmw_cmdbuf_man *man,
  * context.
  *
  * @man: The command buffer manager.
+ * @context: Device context to pass command through.
  *
  * Synchronously sends a preempt command.
  */
@@ -1184,6 +1187,7 @@ static int vmw_cmdbuf_preempt(struct vmw_cmdbuf_man *man, u32 context)
  * context.
  *
  * @man: The command buffer manager.
+ * @context: Device context to start/stop.
  * @enable: Whether to enable or disable the context.
  *
  * Synchronously sends a device start / stop context command.
-- 
2.27.0

