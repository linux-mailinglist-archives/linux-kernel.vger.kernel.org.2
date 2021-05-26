Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AB3912F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhEZIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhEZIt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE5C061348
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso15017131wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AktsaW6Bskrl1AG9i/afTuE+QfmnEvj7VSG37dmiSWQ=;
        b=AMLIuKLP7eSD0sQl6i4Ap0vsy36DUSOgzVtp8L5oSEfnpTJCzDcp/yKF22mI0y26sa
         SpDRKYEjS2uXTV5SIW5Vt8N8WRp8mz/NdmqBk3bbvU0awuGVjIZf8aKWVcK80HsUbptz
         RBz5KT8u+J8qZUe3iXi9/qnh67ZzNWd16LXytB8ttHMVFungJYt+R/wb8iI3y55ckGjo
         iKNvXoLB5a9wf23OAC6Jl3Gbg1005Vt3ykvMblCgbv4f3URaUYHZxKliCVHtiqPP2cgA
         gPQ8tMpzPPzPdJdyo/90eMDMW1QWpa13GO/7syQKyh+U67CCcZBpf2LETCS7N+LhXIpS
         ci6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AktsaW6Bskrl1AG9i/afTuE+QfmnEvj7VSG37dmiSWQ=;
        b=NGf88THdgsef0B09I/8+MRxDwBEzXAHQfTm5xgjZCDElJO/jxAXqdYv6FS81zCK3/A
         2xdxle9LlXlF8JdMtIcfBbWFxZpq0oKxFumYyISpaA8MxgPAAHrUksdJurgETFUe8KoB
         AtJnn2F6PxK8cTotNHBlwWA2MHiSTgi+haTF05dujIejz09y4eq8yk3qXqlNUEyiApqS
         xW2gpOF9eUBB/rXoTeg/rHddGJsE50AyQ2wFXJO14YR8Y8hRwBXe38n/Cc/YHUB33HvI
         B8IBBUirqM/NzmdCa5dN3NBMZEVE+/vEmv/7Fhl914EyVEcvEpnds+4N3wtgIUHfKsgQ
         qKaA==
X-Gm-Message-State: AOAM530UbmIcKOww65wqm59WNoGlD28qqmxNqM1JOKb+FY96yTbqPLRp
        dPd5oyW+LRBdtg7NxkXIo6DyUA==
X-Google-Smtp-Source: ABdhPJwx3JNUrEk+A41Ghrk79W/6tF7/o6fr6xpd7rM4y6GJ9Wa2Ujsktlv5HTFdW68nwOBkfQ7m0Q==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr28003511wmi.101.1622018875645;
        Wed, 26 May 2021 01:47:55 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/34] drm/amd/display/modules/hdcp/hdcp_psp: Remove unused function 'mod_hdcp_hdcp1_get_link_encryption_status()'
Date:   Wed, 26 May 2021 09:47:16 +0100
Message-Id: <20210526084726.552052-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.c:374:22: warning: no previous prototype for ‘mod_hdcp_hdcp1_get_link_encryption_status’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 26f96c05e0ec8..06910d2fd57a0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -371,19 +371,6 @@ enum mod_hdcp_status mod_hdcp_hdcp1_link_maintenance(struct mod_hdcp *hdcp)
 	return status;
 }
 
-enum mod_hdcp_status mod_hdcp_hdcp1_get_link_encryption_status(struct mod_hdcp *hdcp,
-							       enum mod_hdcp_encryption_status *encryption_status)
-{
-	*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
-
-	if (mod_hdcp_hdcp1_link_maintenance(hdcp) != MOD_HDCP_STATUS_SUCCESS)
-		return MOD_HDCP_STATUS_FAILURE;
-
-	*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP1_ON;
-
-	return MOD_HDCP_STATUS_SUCCESS;
-}
-
 enum mod_hdcp_status mod_hdcp_hdcp2_create_session(struct mod_hdcp *hdcp)
 {
 	struct psp_context *psp = hdcp->config.psp.handle;
-- 
2.31.1

