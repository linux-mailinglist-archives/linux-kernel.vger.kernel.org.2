Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B632BE8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385813AbhCCRcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhCCNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:50:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56838C0698C7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b18so17254283wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3gvwy4PeYzRI9ULf7uVbTevm9nR5Ng81aAgPUCWA6Q=;
        b=R5yJXjEroR+aAi5Xo5prsTIr/z57v+n/ht4ttCxnmCgCgDUAoyafUan/HKuwL8hmru
         p6Xj+KOnUCFDgVgm/K+RfNQX0xdutyUZxzVweat79ABuc6H9HUmMKWNIX0GzuUvQEDK/
         o+P1o9sT8ivFFizyKdZ0R/eRtXsqxYfOHVi8YmEB7fe8JaFj+jN+o3HSZVtT8r1Y8IAr
         /PZ8UmBQjMDa61BkBmQMRLCWB/+QCgExg2QROjsbEaxM5ltcy1QwgGgFsuZedmzp0YmQ
         x/3grCp1SksM5OttzERnm8ZwIcuL4Nk4ZzP8uGKYMoqiJIyNQY06zXNtYwBkoo8szfNz
         TFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3gvwy4PeYzRI9ULf7uVbTevm9nR5Ng81aAgPUCWA6Q=;
        b=WRnUxI+v7R4EwsDxaBhU0uPZapuy9otF2iTkkZ0xjoxPwrt3jIxBRhxlRWkdvQQ7Tq
         5ops4J9ZXJt4gKIoGXYqBQWuKceB3dZmQKfydnO8LKMcmuI9+QvV1w1ZYwnDYdD/7boQ
         ZykUXgNlC2b2EAcGTRCx4WroVqOMQ+622DfLQ2ogdkN0Q5kAlFAOb4fDv1prlzpUONhx
         Jtib/GhgGc/WTU8MtL9yusRaK7v3zV7IrnlvnWIQElUwdzfWYQpqdpCN7Neu1b/+fUX3
         LOg+CLCo4AqzkFzJYT5dPp2Hzkbozs8cCMCL7EjX2FwNfSryGIP8P853z+Akh+XXxfwg
         KB1A==
X-Gm-Message-State: AOAM532kCAGTcAeo3N6/pLGPkFzzdh3InHcE8+mI2wykOszc0UHJznWX
        fCSOq7EIla+UD2I/4kKGOZKkvqZa7X+GPg==
X-Google-Smtp-Source: ABdhPJxTgYB4TmAEXy3KphfxYNatkvoStNo1An/KK6I8g+XVkZeTGR0YU5SR4hYQAuv6X3wLQ2J/WQ==
X-Received: by 2002:a5d:404f:: with SMTP id w15mr22820266wrp.106.1614779061148;
        Wed, 03 Mar 2021 05:44:21 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 45/53] drm/vmwgfx/vmwgfx_cotable: Fix a couple of simple documentation problems
Date:   Wed,  3 Mar 2021 13:43:11 +0000
Message-Id: <20210303134319.3160762-46-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c:72: warning: Function parameter or member 'unbind_func' not described in 'vmw_cotable_info'
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c:308: warning: Function parameter or member 'val_buf' not described in 'vmw_cotable_unbind'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-3-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index ba658fa9cf6c6..42321b9c8129f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -63,6 +63,7 @@ struct vmw_cotable {
  * @min_initial_entries: Min number of initial intries at cotable allocation
  * for this cotable type.
  * @size: Size of each entry.
+ * @unbind_func: Unbind call-back function.
  */
 struct vmw_cotable_info {
 	u32 min_initial_entries;
@@ -297,7 +298,7 @@ int vmw_cotable_scrub(struct vmw_resource *res, bool readback)
  *
  * @res: Pointer to the cotable resource.
  * @readback: Whether to read back cotable data to the backup buffer.
- * val_buf: Pointer to a struct ttm_validate_buffer prepared by the caller
+ * @val_buf: Pointer to a struct ttm_validate_buffer prepared by the caller
  * for convenience / fencing.
  *
  * Unbinds the cotable from the device and fences the backup buffer.
-- 
2.27.0

