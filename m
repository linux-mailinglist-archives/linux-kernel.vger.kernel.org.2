Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C24F32BE8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385783AbhCCRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbhCCNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:50:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339AC0698C9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u16so5734695wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQZLwiGbcenEghtj8sEs+9poNaFVOCqZR7K7Xf38sg8=;
        b=n3k/mYhgTVnHgN7Ksfu7aElbcegmINNz9xrSIIvHZH18JgTBt11GqX7B0Y+I4LRWWA
         EwFoC9NUaYXdvKsaBubKCaIiZflXprHJfSsViCJHiSsOHixKTZFbYB5rh525AeiAVHSR
         36oWRWiloNGWsDa+rxNY/prI4gFRA+mKYqo5blvhxgoS0Bwlkw+OxP/9BHEsGOK6qlW7
         2LevQxx2Hk2c4vpJMepQpKQluHx3bvehHuffE9AL8WW2npB+naUskSkyeNGhA6WzSYAb
         Wa/xGxB1YZZ/W9nog6dOoDUdh8T1vKKGix0mPXr2JcLCIgpr0GfPRiF0eS2xi0osra1Q
         FamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQZLwiGbcenEghtj8sEs+9poNaFVOCqZR7K7Xf38sg8=;
        b=uns+4LrqGFCs0YNxe1slFlhLp8GxVaaEPKqzqgQTUC07gkZXVRqNzOe2rgKOzffwYt
         WeqoMpR/ntqVcbhhaBKEw0gImidjntnGEXZ51d37mwXetlqOIJ3J8LnCy8pHaAMDSx+I
         BSl4+ggS/n86zw1Wlk8/zs3zhnDREthivt1oT8zB/zbdxAYpQllKo5+IAaod7GkkRWb4
         hSzrYzToeitgsFMYLI3iPjwMwhUvo4mvMSXNy0I2t19uaonkLlOhnW/gdi/RbooP8UtB
         baMuE7nYm2xW0AoCDT8oFiW4wCU0dwAeWtCF/ZQWCGiBMJ9W7WD1xgr350olPNUcolpF
         fz7g==
X-Gm-Message-State: AOAM533l8QxXCKM4AzrNmCFxqPI98Rte1pqytdKa/30cXurXIzZGQI3v
        n/n58a2fynf4qpQzULXvaEpPLg==
X-Google-Smtp-Source: ABdhPJxF6VT4N2VE6MuYcxHrcHSbjMveLyChxN9mxuaLwDgciE9MnDOkdOw+Vb/W9TF7+FsO2DOypg==
X-Received: by 2002:a5d:6d0c:: with SMTP id e12mr26592738wrq.136.1614779062329;
        Wed, 03 Mar 2021 05:44:22 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 46/53] drm/vmwgfx/vmwgfx_so: Add description for 'vmw_view's 'rcu' member
Date:   Wed,  3 Mar 2021 13:43:12 +0000
Message-Id: <20210303134319.3160762-47-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_so.c:73: warning: Function parameter or member 'rcu' not described in 'vmw_view'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181601.3432599-4-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
index 7369dd86d3a9c..2877c7b43bd78 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
@@ -42,6 +42,7 @@
 /**
  * struct vmw_view - view metadata
  *
+ * @rcu: RCU callback head
  * @res: The struct vmw_resource we derive from
  * @ctx: Non-refcounted pointer to the context this view belongs to.
  * @srf: Refcounted pointer to the surface pointed to by this view.
-- 
2.27.0

