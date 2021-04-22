Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF223686AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhDVSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:40:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02507C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:39:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y3so18392121eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeakXfmAJOS4QPn/pFkDvo7FQKYVhQEklCs4O1KqYzg=;
        b=Te3StrIurIlXM7JD0tojCAKgXyZmenFjxEvny1HGsbiD5E7hyVbsxG4Aj4pxpRpPbD
         +PyuBGAcSh0IeQpGQpaCI2OSd64pl6ayBmKaG465/3kmXYrlfAiDoAKL6KvwhuAvJV6M
         OxiF52j1YskkcEHtYxLIp8dTvkQRBC8VVMqbeSeL0GSd71w7kZdhCFditMGTuHXjjtwP
         qtWSM4YSG/jU38tDcjNXFFaZk7ER4QPrPFg/GfIJqjF6G6vP3OA+Hj4lFbIMh47fwYz5
         gE+YI74DF3vdpQkbZG1jvWZatfWYnahtIfpib4OazwOIa8IN4a1KsfV24ReaCy1o5802
         bnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeakXfmAJOS4QPn/pFkDvo7FQKYVhQEklCs4O1KqYzg=;
        b=bY5HWeWf675SjelLqqmAwDQgssmFC/lxfrIPLl5mj2yTVlPpolX9IDrL0ZXcPdbA/Y
         B+d+N/Ex/uo5PPTZRIRgFnl22+KLCU3nK8pdroU63kqxlKjYiEKUCo75Ft/JYbu4jo6z
         dmjhvAWmSYSoNB8pbWtih1Y3/4AgNhf6DWPVZdhsWw8oYlpXyo3N2/Fk7MEkCyoHNdEB
         9IJbDq0lyyTPEUc18Yr5nLEZR3abkBtwkVibW0+IG+RnCrfHXOcuvvyAk8wlOrL3p1nR
         ivJCo93iab1YozJGm5GaGsu5VYsEvD6Go8DWRJn8vZh6fHReMmZmQp6UFKdlJVBXWIDX
         3lhA==
X-Gm-Message-State: AOAM530dkXmUb++n+gzPJrhcyEIjw+ExgqWNIU6FHuSoRe5T+PNr5B1T
        s5E1R+x1kXW2gc4Z+E34K+4=
X-Google-Smtp-Source: ABdhPJyrkgyuKenetMv/b2b/dzOblKLM356T2egkkIzB73xGh5E19RA5LUF8Sg+TyrLsgOrN2y5QIw==
X-Received: by 2002:aa7:c7da:: with SMTP id o26mr5636731eds.244.1619116766695;
        Thu, 22 Apr 2021 11:39:26 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id c12sm3152896edx.54.2021.04.22.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:39:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] drm/amd/amdgpu/amdgpu_drv.c: Replace drm_modeset_lock_all with drm_modeset_lock
Date:   Thu, 22 Apr 2021 20:39:19 +0200
Message-Id: <20210422183919.14959-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_modeset_lock_all() is not needed here, so it is replaced with
drm_modeset_lock(). The crtc list around which we are looping never
changes, therefore the only lock we need is to protect access to
crtc->state.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---

Changes from v1: Removed unnecessary braces around single statement
block.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 671ec1002230..adfeec2b17c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1439,17 +1439,15 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	if (amdgpu_device_has_dc_support(adev)) {
 		struct drm_crtc *crtc;
 
-		drm_modeset_lock_all(drm_dev);
-
 		drm_for_each_crtc(crtc, drm_dev) {
-			if (crtc->state->active) {
+			drm_modeset_lock(&crtc->mutex, NULL);
+			if (crtc->state->active)
 				ret = -EBUSY;
+			drm_modeset_unlock(&crtc->mutex);
+			if (ret < 0)
 				break;
-			}
 		}
 
-		drm_modeset_unlock_all(drm_dev);
-
 	} else {
 		struct drm_connector *list_connector;
 		struct drm_connector_list_iter iter;
-- 
2.31.1

