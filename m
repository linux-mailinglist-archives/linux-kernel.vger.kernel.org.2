Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8871632BEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574598AbhCCRdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbhCCOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:01:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC6C0698CB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 7so23757717wrz.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iycuw02Ze2lHNSA405Xw+zB9o0y7L/MHkkRIkUAmng8=;
        b=thFldj+NR7/yJQFlx5CmFrSDIqztiJhVtzEIncot0oT9IuZefM8LS0OIhOXMeciq+1
         pt7Ymt7WJXTsvEKX/HUnsWKzPuFY48/YLBIW3LpFe+iOsB+uzaUF+EMcvtGogOomdHXM
         teioDoBTjwhsvvC5sObP3W4piv5q9tiMO4unVsGZV652CmmLfL+V0m3cSBas82wBMgaA
         w6NzkVxZ/IP+NegS6rg0+alFY9+A1Nfbdnj6glWZOyQ45oMiB/EfaNWGiSAUOoMwHENy
         08FpX3SzMS2AdhNEaofx7ToAK0fWTQNl/Y3S1B/zlB2WyGJGfUuB7Yj14FiKCN40Tbfj
         VaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iycuw02Ze2lHNSA405Xw+zB9o0y7L/MHkkRIkUAmng8=;
        b=p/DE6z5xRi1WoXWx6fWcBRYTDpjKQfgAQeT2wO359Yl65Jk5+zTtm8k7YjeBgT7DtM
         89VDCL7PKbZfc2EZWQdeIgDQPtYYBwbvokZtERmV/U3nWvbp+EoGCL6deDD2xsTDkp25
         KuxGrcutpVvnCrn3duYuvPsdbkQXVmNkEJfuRM76WmOmp91EFjGVKZNThvC9LIfOV8bE
         mSE+AWM567dkLRBmw4kbFfSJTGI3nwCHCQs0l0egcUE9rc5bqabqicSRuSN2amqqk99g
         Sm22hao8b8GqMRuUxj0FLY3OtRqvvJh2CTe8Uhurjd6LCruJMUmiSyLwHtS7r3+6pHxd
         Oj3A==
X-Gm-Message-State: AOAM530mDOclezByV8qG69dAal2x3B5eR4lixZPDyjqPVy3H0AN8dMXr
        8br5hikq8ArWb9JV7xFg2Wpj0Q==
X-Google-Smtp-Source: ABdhPJxahbBIE2LRClKS78/6HsclGgIdKNslueE6t2fTii73se5u0IQl5HPtgslGGaA+a/JlY6OszQ==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr16916292wrs.43.1614779065836;
        Wed, 03 Mar 2021 05:44:25 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 49/53] drm/vmwgfx/vmwgfx_blit: Add description for 'vmw_bo_cpu_blit's 'diff' param
Date:   Wed,  3 Mar 2021 13:43:15 +0000
Message-Id: <20210303134319.3160762-50-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:452: warning: Function parameter or member 'diff' not described in 'vmw_bo_cpu_blit'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-8-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 9f2779ddcf083..118db24eb756c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -431,6 +431,7 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
  * @src_stride: Source stride in bytes.
  * @w: Width of blit.
  * @h: Height of blit.
+ * @diff: The struct vmw_diff_cpy used to track the modified bounding box.
  * return: Zero on success. Negative error value on failure. Will print out
  * kernel warnings on caller bugs.
  *
-- 
2.27.0

