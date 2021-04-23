Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87528369AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbhDWTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhDWTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:08:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E715C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:07:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a18so13408807qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0KplKB6ILQwW/bgPpQ2738PMI2LhpDDm2bWSz1MytY=;
        b=p9tM9Ml/bb+DAfrlK7YmRL+mRcxyVGxfnBT/LiM/+FT9VhfncEr5/a8mJcp/gHk1OH
         F30BpiXsNmC5qo8mwMC2DcRXKBVyYlxA3oareOGufhx3d4CMqIZ7r+yXVNxoKPoSfE0O
         njo4Pfmxc3f2tMuoLqOZEW7QkVaypawq3sg/9fmmszxzcMvAkmC9uwodEt5UFVQT4p4F
         srfzvkKs7vHWV+qxY6jZ9x1y/A+PwYWBif/Lsm29DevYfqVOd2yRrF0TNl65+VTIqYpX
         xgmN8gK4/vTR6fFoTAgzcOjmrdbtV1MAU+s1K8lCysNgGoe7opJtxE7sQM1Dx4VebYY1
         rUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0KplKB6ILQwW/bgPpQ2738PMI2LhpDDm2bWSz1MytY=;
        b=Qj46X4lko+N3yA5lcRMNgqWjjjRUvX5ybztAO2PM2wW5EKSk0gDxVuA11CY7TVfwoN
         zqSKbBlx5CW+toddKNhukiWqQC6zmMF6KrmmManuch6LMNBb705QZm060YGO8m4Z0uPx
         t+r2b2BCrBhb3P2+ieVB8fweQ8EcNnl1U/rkXg0VL2xWpThhAMAyrj8DQbCS2FgSuczZ
         xgWWE/ISptbKwoGidAKEEY8gbQqhNE7/fMEZ8Eypg5gu1HN0DQeTh/K+vOw4xk19I3ll
         xw6jY2cUoiX+tavH6OQslGLF1Slt08W0jk0fTXflp8Pyd6pTFI8TEX3Dc7Zu0t8tiRRY
         Wz7A==
X-Gm-Message-State: AOAM531ONsoCXbP7LU6IC6epfnyjlUtRhNSMNjFSlnWivJ0D3Jr1f5M8
        LQEnVtdBB01ZOfNLy6d6wpqHcQ==
X-Google-Smtp-Source: ABdhPJy5sUSoIk7bk/07y8I+N/+VOsacXAk9XOEaeraz2zOzi+bCBuue96VHvdQn8xMwE7kLPrSNUQ==
X-Received: by 2002:ac8:6654:: with SMTP id j20mr5106910qtp.328.1619204852376;
        Fri, 23 Apr 2021 12:07:32 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id t184sm4898250qkd.77.2021.04.23.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:07:31 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: fix minor version to indicate MSM_PARAM_SUSPENDS support
Date:   Fri, 23 Apr 2021 15:04:20 -0400
Message-Id: <20210423190420.25217-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the minor version to indicate that MSM_PARAM_SUSPENDS is supported.

Fixes: 3ab1c5cc3939 ("drm/msm: Add param for userspace to query suspend count")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7bb34ae95037..a63e969e5efb 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -42,7 +42,7 @@
  * - 1.7.0 - Add MSM_PARAM_SUSPENDS to access suspend count
  */
 #define MSM_VERSION_MAJOR	1
-#define MSM_VERSION_MINOR	6
+#define MSM_VERSION_MINOR	7
 #define MSM_VERSION_PATCHLEVEL	0
 
 static const struct drm_mode_config_funcs mode_config_funcs = {
-- 
2.26.1

