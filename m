Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E563673B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbhDUTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbhDUTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:47:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A28C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e5so13850923wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fG85dbebKoSteYYPivVE8kWXsCAyDtNNlGMTLX6zqlw=;
        b=etWKGeAx/x3qUoLi/y3SSHai4Jy9Be89Vz6wWtbp3/JpV22IOnAi8X6tLsDKoLlDMu
         NsR+OkLxq24eSdHklEDCJ8z8dTxzE65YyRJQtpK6oFhyoKgYGAvhv3V/wP8Ko0RCukKh
         kaOWNfiV3834c8INNrPmn920FQGgppAP6SRQGjXVKaHqA0wcsvyyupXwI6DY1HwtI4YM
         VKwTTeFpxsS94g0/JmmNy06vN7NeOt7a0Kq+C+kYLYzDR8DYBDVpZ/xyYW7GUp52UjLy
         dPFYBOQpKAYhfYWPLDWv00t6/kRtpcsIY8vXZgWibmTDn6uz6Xl4nQgthiFIwCPYvtUs
         Mu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fG85dbebKoSteYYPivVE8kWXsCAyDtNNlGMTLX6zqlw=;
        b=sp4/yyK+D4kVfx/UVHVp20qzAD7cePTbw7sXNScP/8mFLTUDAL7gf6U9pTYlGAdNvI
         RTedUyXj8JJeaQOFWA+wReX1h6Eav0BqnSCXP0PLKAyj1rjkPyEAOCpMFPqc4BL6Jutg
         XvKHgSiruSwSL9TZ4xxFhXb2JQUdBgBKs8wjmLO9+ojKztb3vaNAzqLeoRs2/DOOHR+q
         hqnkEih9ZrXuRpSBsjjRJyIJLnquOH4hydn696Wal6X+58ouQJ/K8xQB91uMlcX6Y0Y6
         8DWJPeSJOjsRibnEEAlCoy/gytI1jmmylT/BQZ2kFj2fOKOCaED6uZRwd2ESHn8PmmVC
         /9Lg==
X-Gm-Message-State: AOAM532Tl/YkEkd5EmmD7dXMvSSGRC5NXw7zifuyZ3uhOgwvc9gnsNRq
        PEiTM8YLfjd3aAvQgaxA/DJi6AHlX+NFSQ==
X-Google-Smtp-Source: ABdhPJx8xeSxs2+tkJWE8YUNHn4xmhjUGtPY2imH1F2SiUxoBmdMSB+rtYG4dt8hDV11lteiAjVNsg==
X-Received: by 2002:a5d:640f:: with SMTP id z15mr29104558wru.221.1619034423874;
        Wed, 21 Apr 2021 12:47:03 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id c6sm13004217wmr.0.2021.04.21.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:47:02 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 1/5] drm: drm_atomic.c: Adjust end of block comment
Date:   Wed, 21 Apr 2021 20:46:54 +0100
Message-Id: <387b6b852a72d6a98133cead5e4d0e3c39dd5094.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line with */ on the last line of a block comment to follow the
Linux kernel coding conventions.
Problem found by checkpatch.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_atomic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 46dceb51c90f..e42d9fc5d9ff 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -385,7 +385,8 @@ static int drm_atomic_crtc_check(const struct drm_crtc_state *old_crtc_state,
 
 	/* The state->enable vs. state->mode_blob checks can be WARN_ON,
 	 * as this is a kernel-internal detail that userspace should never
-	 * be able to trigger. */
+	 * be able to trigger.
+	 */
 	if (drm_core_check_feature(crtc->dev, DRIVER_ATOMIC) &&
 	    WARN_ON(new_crtc_state->enable && !new_crtc_state->mode_blob)) {
 		DRM_DEBUG_ATOMIC("[CRTC:%d:%s] enabled without mode blob\n",
-- 
2.25.1

