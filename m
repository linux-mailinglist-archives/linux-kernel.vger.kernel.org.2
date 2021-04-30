Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6F37013F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhD3TcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhD3Tb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:31:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7FFC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:31:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s20so21317496plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKrCMFaUZYfC0G8NCT7F60Xv834i4CVQddCUf4DQYq0=;
        b=cTPHj+Vz4O5A0F8McNO8BVWBJKCM+QJSRwxLLEwWGmsMDEns00UnT5P061Rbph8rt+
         6EfiKvfguHCzoBDfVKTAbn663PqpZyTpotGSy/BkUO8EgBOUiYYIobp/jk8CxAZK3S7U
         dswSQJK4GMfzaZ4ToJ+bg2lbeTx+WbMmDD5Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKrCMFaUZYfC0G8NCT7F60Xv834i4CVQddCUf4DQYq0=;
        b=nBb3LFqtLIhhH67ZEUvQ5G+ASTKdbdJtAwWRiDVTC5uUoq0Gaq4UvDQoSpUCiIPBdv
         ozrxcYVwH3qsLe4GhJy3QUMgw02XcoXcO9TT9yC201JQfawwWry45JIIoI8FrOExTWcS
         zLZXVqP5jcvyGVUYiFw4yxPttL57+InC3BbTbEx1colxV0pIkJwQjOINtRKGaDzvDZcv
         KA2mAslz1lF+IEdBJ3wb8F7ImqgydJnM0jgJbq1avoSI7ltvUmkKlQ/hDNT/6n1y8pDI
         vAyxLjQitlTP//Pzeq9EKRe0fAVQjV3xOgdC5W8PbbNccDnkTLqfyfWEfMmg5VPHEnFF
         w6eA==
X-Gm-Message-State: AOAM531uXOCkkwBa9GfDic+/nxRuYCRMaMeu4UYuHHb42c2RH27yIifT
        cGWJtR2aMSTFvYiMICSkMRbYAA==
X-Google-Smtp-Source: ABdhPJyWXB03cIj9xky5L3f/X35TMsnbMkOr8+xmL7ReqVKkoBkiONcQBBzP1LUaiv5gnOs2rZuwyg==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr6766979pjr.96.1619811067805;
        Fri, 30 Apr 2021 12:31:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dacb:8fee:a41f:12ac])
        by smtp.gmail.com with ESMTPSA id t6sm3143500pjl.57.2021.04.30.12.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 12:31:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>, aravindh@codeaurora.org,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 1/6] drm/msm: Move vblank debug prints to drm_dbg_vbl()
Date:   Fri, 30 Apr 2021 12:30:59 -0700
Message-Id: <20210430193104.1770538-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210430193104.1770538-1-swboyd@chromium.org>
References: <20210430193104.1770538-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put these debug prints in the vblank code into the appropriate vblank
category via drm_dbg_vbl().

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: aravindh@codeaurora.org
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
 drivers/gpu/drm/msm/msm_drv.c                        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 9a69fad832cd..9bb2d13a1f44 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -416,7 +416,7 @@ static int dpu_encoder_phys_vid_control_vblank_irq(
 		goto end;
 	}
 
-	DRM_DEBUG_KMS("id:%u enable=%d/%d\n", DRMID(phys_enc->parent), enable,
+	DRM_DEBUG_VBL("id:%u enable=%d/%d\n", DRMID(phys_enc->parent), enable,
 		      atomic_read(&phys_enc->vblank_refcount));
 
 	if (enable && atomic_inc_return(&phys_enc->vblank_refcount) == 1)
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 196907689c82..ad79c37d4df9 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -683,7 +683,7 @@ int msm_crtc_enable_vblank(struct drm_crtc *crtc)
 	struct msm_kms *kms = priv->kms;
 	if (!kms)
 		return -ENXIO;
-	DBG("dev=%p, crtc=%u", dev, pipe);
+	drm_dbg_vbl(dev, "crtc=%u", pipe);
 	return vblank_ctrl_queue_work(priv, pipe, true);
 }
 
@@ -695,7 +695,7 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc)
 	struct msm_kms *kms = priv->kms;
 	if (!kms)
 		return;
-	DBG("dev=%p, crtc=%u", dev, pipe);
+	drm_dbg_vbl(dev, "crtc=%u", pipe);
 	vblank_ctrl_queue_work(priv, pipe, false);
 }
 
-- 
https://chromeos.dev

