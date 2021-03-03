Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D96432BE89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385756AbhCCRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbhCCNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E0C0698C6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u14so23750625wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOctN99VtPEuQxbAuDG+BL97SKhd9D03A4O1vAmIt6Y=;
        b=x6AS3LdRZBrN0y7y9+yjdOVvm8tDGN/HEUOtMVjCZPG+CFbIJ5nhNd18RoubmKm5nk
         QJrQ0u0DEhDPBCi/46gCWz5HvChhh3OpU8U/72idR18uOEYM9B25aUTkk2xjPzt5O6E8
         y8xKk4QSRoGHmDGoQ0mj3IGsZoC4Zk+XhA9K6297bFOE27mhdEHeYx8av+etATMockOE
         xQBM2XqCPIbKdFQCvNfyw8mihI+Zlclsiv7/h3+FqOEEMVIaecA0WmUxksKdztL68oll
         b1doidTR/jl8lEl+3PZuWLX7sAqCTX4sjSe9fZTsJAcB+FMVnAyy1uaQ3ZuRlOKrwh3f
         10tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOctN99VtPEuQxbAuDG+BL97SKhd9D03A4O1vAmIt6Y=;
        b=ugULKPyCS62nek33YuFZDi+TT5UMjr3M/YnMTM5D6EeK7i5Wl3WRaQR80/06IG4eCo
         JblopLOzQz12WCHYl80/uSI9zY6ChywClERsm1fDz9O67L41op4jRTP10dwOGrYKH9YR
         gNSrTJjzrNUQxdCUBVUID1Ru9dRQZ4XH0OCK24vBZeMUsBEyqy+MDmYu7Wp/QeIMrMfo
         lVwZHEba5COwJfZaiSNr0kfG9pVUlNW6Q6nY9r+eqUgTtY5DzSevhOAFM68XC0grUwf2
         ujwrmyzOCPZoRkV/Z59+Os2qr5I+w9Hfp4u3zkyI6oAE1Wmt0LSkc8cdrSKwrTvXsv/1
         su/Q==
X-Gm-Message-State: AOAM532jD1H5UNXiCZBDjsE1tyXJY0eo0mIjRTq5M3IPNc5XUTucM129
        LQ6X8bpw/6hLDBPQiY5W8EC5CQ==
X-Google-Smtp-Source: ABdhPJzWAhPL4kiG7yhb50nxJvSoEjvKFJhiIu9Cydmb4z7sldATR7YLT0R/RJMGixwEdXh1m6ZH3w==
X-Received: by 2002:a5d:4a0e:: with SMTP id m14mr27417003wrq.73.1614779060225;
        Wed, 03 Mar 2021 05:44:20 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:19 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 44/53] drm/vmwgfx/vmwgfx_cmdbuf: Fix misnaming of 'headers' should be plural
Date:   Wed,  3 Mar 2021 13:43:10 +0000
Message-Id: <20210303134319.3160762-45-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:137: warning: Function parameter or member 'headers' not described in 'vmw_cmdbuf_man'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-2-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 3158924ffa852..2e23e537cdf52 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -89,7 +89,7 @@ struct vmw_cmdbuf_context {
  * @max_hw_submitted: Max number of in-flight command buffers the device can
  * handle. Immutable.
  * @lock: Spinlock protecting command submission queues.
- * @header: Pool of DMA memory for device command buffer headers.
+ * @headers: Pool of DMA memory for device command buffer headers.
  * Internal protection.
  * @dheaders: Pool of DMA memory for device command buffer headers with trailing
  * space for inline data. Internal protection.
-- 
2.27.0

