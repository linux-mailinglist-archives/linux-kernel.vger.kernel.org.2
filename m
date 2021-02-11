Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB333195F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBKWlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhBKWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:41:40 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CCEC061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:41:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x136so4643851pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6yvPNRRNRl+hAEm+aAT4OMwWbagrM0k8oerqfFt/Fk=;
        b=YY4SkTg7rV4kPjQAkZOLvLicOXO6Y+7cVQ/0LiM1pIHZgGh1E3le3JNADcZA9QBqwD
         RAPUqPDgumgL705j+GvlBu0L6iJycVzgsFNx1q5EHNd9O1z54qA7fR078HEud6FvhRbc
         eqXDmistUlMI3PCbnvlRLq4NNrGQBymskySB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6yvPNRRNRl+hAEm+aAT4OMwWbagrM0k8oerqfFt/Fk=;
        b=C5U5cdWDauHkJnJuMtq/P7VA9m/5opTCG1FpXFG3il/eWKmCiOMhcLL08rVJhOKr6s
         4YlF0sv0fZHeAZM6hhqSDveGEdN5WhWqr/LG6YoVb0B0EzAxV5QQdsjHJEl5wpDfknlf
         Uztm2JJOKiZDgzdFIukLVQ9j8VXnHTI8XW1d3L7lCGwqB6MSV5RSGk9azzavYVYz2eeR
         M/gTF//EMQ4PZpdbaB128BsQBb4RL234ADYaRn3ANWIxWKdF3C8bbeEI4wRmOYrd7IWY
         P/X0Ju6sHDYbEv9mneQIGmLW4T1pEkUcgPRxBm+HSV3pUVBeChkQv9ipvuOsNnzVGjdg
         JFtA==
X-Gm-Message-State: AOAM533xH1nNCdSt7coWaGaZTzxEfsaqjvRvT/r2sWuHJMDWYkXbH+Su
        2uEWsSXHfEZIgFeGCFNpuTBPYQ==
X-Google-Smtp-Source: ABdhPJzT0xSERmgIjPMidxbPCsmfbyLhZNGEakqTmas5KJF/Xma8ce2B7quh8a1ulXA9ffLJ4R3uZA==
X-Received: by 2002:a62:8416:0:b029:1dd:9d4e:7002 with SMTP id k22-20020a6284160000b02901dd9d4e7002mr321648pfd.18.1613083260119;
        Thu, 11 Feb 2021 14:41:00 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f038:5688:cf3c:eca2])
        by smtp.gmail.com with ESMTPSA id i67sm6675454pfc.153.2021.02.11.14.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:40:59 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm/kms: Use nested locking for crtc lock instead of custom classes
Date:   Thu, 11 Feb 2021 14:40:58 -0800
Message-Id: <20210211224058.2853809-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to make up custom lock classes here, we can simply use
mutex_lock_nested() and pass in the index of the crtc to the locking
APIs instead. This helps lockdep understand that these are really
different locks while avoiding having to allocate custom lockdep
classes.

Cc: Krishna Manikandan <mkrishn@codeaurora.org>
Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Fixes: b3d91800d9ac ("drm/msm: Fix race condition in msm driver with async layer updates")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 7 +++++--
 drivers/gpu/drm/msm/msm_kms.h    | 8 ++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 6a326761dc4a..edcaccaa27e6 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -57,10 +57,13 @@ static void vblank_put(struct msm_kms *kms, unsigned crtc_mask)
 
 static void lock_crtcs(struct msm_kms *kms, unsigned int crtc_mask)
 {
+	int crtc_index;
 	struct drm_crtc *crtc;
 
-	for_each_crtc_mask(kms->dev, crtc, crtc_mask)
-		mutex_lock(&kms->commit_lock[drm_crtc_index(crtc)]);
+	for_each_crtc_mask(kms->dev, crtc, crtc_mask) {
+		crtc_index = drm_crtc_index(crtc);
+		mutex_lock_nested(&kms->commit_lock[crtc_index], crtc_index);
+	}
 }
 
 static void unlock_crtcs(struct msm_kms *kms, unsigned int crtc_mask)
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 4735251a394d..d8151a89e163 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -157,7 +157,6 @@ struct msm_kms {
 	 * from the crtc's pending_timer close to end of the frame:
 	 */
 	struct mutex commit_lock[MAX_CRTCS];
-	struct lock_class_key commit_lock_keys[MAX_CRTCS];
 	unsigned pending_crtc_mask;
 	struct msm_pending_timer pending_timers[MAX_CRTCS];
 };
@@ -167,11 +166,8 @@ static inline int msm_kms_init(struct msm_kms *kms,
 {
 	unsigned i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++) {
-		lockdep_register_key(&kms->commit_lock_keys[i]);
-		__mutex_init(&kms->commit_lock[i], "&kms->commit_lock[i]",
-			     &kms->commit_lock_keys[i]);
-	}
+	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++)
+		mutex_init(&kms->commit_lock[i]);
 
 	kms->funcs = funcs;
 

base-commit: 182b4a2d251305201b6f9cae29067f7112f05835
-- 
https://chromeos.dev

