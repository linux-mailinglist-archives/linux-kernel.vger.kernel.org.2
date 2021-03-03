Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6432BE79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbhCCRao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444859AbhCCNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:47:10 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C8C0610CC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w11so23713791wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKXL5BSpeJS4vDI/7s0Xoa8UxotBBglASR7mfOE+iBg=;
        b=hNtRCCCeLUyw2wuwWNSPLsnqiGi3UnjiOYd/907z/VkaGS03CORudaoeEzoKYZ21wW
         +3n5IBsv3gkbasx+n2cCWCAVea13G1Q2ZSB42y0CxowYWrDBqA8kfycGf+Er+H0FFCao
         eOSqiLNTpDXNLn+wzbAXzjtF7CDA2C9NOgQidByinmGlam0z4LrTrH+o4lYwzfAyY4cf
         pFoNb7a7tau9SJERVtEOs1XJvnlQYlOHvSXJy21Bqs3m4amKs0motl60th9pOXMi8xb1
         OP+1xku4Uf7V/QHBacsXBTLLPOqCCGr8UP9Ad8BEGyrrgUA5Jg6BxQ03ADsmG/MePKtP
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKXL5BSpeJS4vDI/7s0Xoa8UxotBBglASR7mfOE+iBg=;
        b=nRQZ/B5K5PxE5CvJuoXAi0x6Bifu+iUgJbaOyoZirT/BkO5N9ZqlASLR0MCkqaTykk
         +tafKRov7y7V9PhxnA5U28boXNLuKVdfJot3Do7vQ5Q4NGSd9GWLxGdUvL2fTeCsWPJH
         lB6t4rf0QH66mxWM1te86S1r0pmXe5D4Wwygg9XH5Lm4aCMhyg/QJF7ahFG9x4Z/P9mb
         LNUWVHCEzsm+T4lA4uHL7YA+7P8Lc4KXyuV/qaqNAfU6T5MPeiCDTIjIikLOIm66LcKl
         Kp+qo4J5q4at22Amkkk9nbvwCBTz4jtYxBpndXLLnKBIy7yRpsivADesEFFBjacRoMa1
         GHUA==
X-Gm-Message-State: AOAM532hNR5wP7pgRXLB7/tTq7E/pez2l8UNm0lnYXJwEIuAiD4F/4Pd
        x7qOr4BQk5/tSN/Qfh+hXnYUrg==
X-Google-Smtp-Source: ABdhPJwNCO3+9KCWRQseXqqpuCUbrFtzHY3to+3rr+R+ZVPWB8etjMgXEtTt0twcjo+u4u2lpoLRhA==
X-Received: by 2002:adf:b641:: with SMTP id i1mr27693700wre.295.1614779043159;
        Wed, 03 Mar 2021 05:44:03 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 29/53] drm/vmwgfx/vmwgfx_ttm_buffer: Supply some missing parameter descriptions
Date:   Wed,  3 Mar 2021 13:42:55 +0000
Message-Id: <20210303134319.3160762-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:275: warning: Function parameter or member 'p_offset' not described in 'vmw_piter_start'
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c:676: warning: Function parameter or member 'evict' not described in 'vmw_move_notify'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-12-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index dbb068830d800..6a44567e4ba52 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -265,6 +265,7 @@ static dma_addr_t __vmw_piter_sg_addr(struct vmw_piter *viter)
  *
  * @viter: Pointer to the iterator to initialize
  * @vsgt: Pointer to a struct vmw_sg_table to initialize from
+ * @p_offset: Pointer offset used to update current array position
  *
  * Note that we're following the convention of __sg_page_iter_start, so that
  * the iterator doesn't point to a valid page after initialization; it has
@@ -664,6 +665,7 @@ static int vmw_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_resourc
  * vmw_move_notify - TTM move_notify_callback
  *
  * @bo: The TTM buffer object about to move.
+ * @evict: Unused
  * @mem: The struct ttm_resource indicating to what memory
  *       region the move is taking place.
  *
-- 
2.27.0

