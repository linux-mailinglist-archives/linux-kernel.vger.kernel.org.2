Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D923B3B51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhFYDux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhFYDuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:50:51 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93327C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 20:48:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 11so1755280oid.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 20:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPOpe/pbA8bUnGpZvYmFITp0NghwSmJn6dUDVrfCv+E=;
        b=hzs8Tl8EyDHus3ahR9b21fg/WfdJZlMs3DlXuyuWSukuoKTxim4HYJCFWVytM/+tmp
         eUHhrU25K52sd9THcIJKn/nehCWVBrSBhKWO6eM/U5V6pZpzRDQpTt7r0QZQqoZ8AYVE
         F4ZfrFDhvUwvLYRpVBCZfSUa9ThrBXSk0XgaLpDU0j/DnelILFiPtD5LHBUIHBrm6ETs
         dDKokJ+mSr+qX2mTSZC1BJLFRH+EIuKTGH5CF20O5k1YuzCJPIC2IDlj0bYO9C3HD0Sz
         kUFvtP2YFTFG11GYRiAcqha2nfHzQbihI2dWXHb/YQmO634KzQtFDcbHNbEK6WvTIW2b
         4YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YPOpe/pbA8bUnGpZvYmFITp0NghwSmJn6dUDVrfCv+E=;
        b=rtX/ryAdAW8xOo6BtyE9/deT1f0EG2CrR8xATcEkoBlpeMuWV2l5aULXIB0Dg5cibj
         KLACbw+SqGWQ1wtV7vRNxXOYzcNilAdazlrASseltuGddONX1RYoTR3TwiXvjlcWwNp4
         Ou0SwfSLi15Tz8wRGChA0i7/PzCD/wKVOkRUJa5BhVYlL3QIbdUQapoTL9PbJnllo21p
         LK6K9MD0OVsL5jEd1eRsVrmj0Dur0HOzUv7DtuBHlJBWX7ZbyoKmTgHkt6cnFbLiPW8r
         An8gtFTVmrkSyk5SXzaAfGbWWxTuPHFW1NGa4uoaogNOQ/fEkn8qPh6LRuxQToMMqPeh
         d7XQ==
X-Gm-Message-State: AOAM531x6tGk46IbIfdNziMbwvb9XxNN6fEQ3hXxVghmr1g2VWWcQCIo
        j87Vrvi7/op//QedzOCFVGbsJQ==
X-Google-Smtp-Source: ABdhPJzU2V+rYLSU0OS1yhD01/njJqJk4DxGcmQAc4IA2qxy0Ho+ormW5U1DV/f3M7TJxA4YLuQOIA==
X-Received: by 2002:a05:6808:251:: with SMTP id m17mr6547877oie.77.1624592909941;
        Thu, 24 Jun 2021 20:48:29 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d20sm1099480otq.62.2021.06.24.20.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 20:48:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dp: Add missing drm_device backpointer
Date:   Thu, 24 Jun 2021 20:47:21 -0700
Message-Id: <20210625034721.1287948-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'6cba3fe43341 ("drm/dp: Add backpointer to drm_device in drm_dp_aux")'
introduced a mandator drm_device backpointer in struct drm_dp_aux, but
missed the msm DP driver. Fix this.

Fixes: 6cba3fe43341 ("drm/dp: Add backpointer to drm_device in drm_dp_aux")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_aux.c     | 3 ++-
 drivers/gpu/drm/msm/dp/dp_aux.h     | 2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 4a3293b590b0..88659ed200b9 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -441,7 +441,7 @@ void dp_aux_deinit(struct drm_dp_aux *dp_aux)
 	dp_catalog_aux_enable(aux->catalog, false);
 }
 
-int dp_aux_register(struct drm_dp_aux *dp_aux)
+int dp_aux_register(struct drm_dp_aux *dp_aux, struct drm_device *drm_dev)
 {
 	struct dp_aux_private *aux;
 	int ret;
@@ -455,6 +455,7 @@ int dp_aux_register(struct drm_dp_aux *dp_aux)
 
 	aux->dp_aux.name = "dpu_dp_aux";
 	aux->dp_aux.dev = aux->dev;
+	aux->dp_aux.drm_dev = drm_dev;
 	aux->dp_aux.transfer = dp_aux_transfer;
 	ret = drm_dp_aux_register(&aux->dp_aux);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
index 0728cc09c9ec..7ef0d83b483a 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.h
+++ b/drivers/gpu/drm/msm/dp/dp_aux.h
@@ -9,7 +9,7 @@
 #include "dp_catalog.h"
 #include <drm/drm_dp_helper.h>
 
-int dp_aux_register(struct drm_dp_aux *dp_aux);
+int dp_aux_register(struct drm_dp_aux *dp_aux, struct drm_device *drm_dev);
 void dp_aux_unregister(struct drm_dp_aux *dp_aux);
 void dp_aux_isr(struct drm_dp_aux *dp_aux);
 void dp_aux_init(struct drm_dp_aux *dp_aux);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c26562bd85fe..2f0a5c13f251 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -259,7 +259,7 @@ static int dp_display_bind(struct device *dev, struct device *master,
 		return rc;
 	}
 
-	rc = dp_aux_register(dp->aux);
+	rc = dp_aux_register(dp->aux, drm);
 	if (rc) {
 		DRM_ERROR("DRM DP AUX register failed\n");
 		return rc;
-- 
2.29.2

