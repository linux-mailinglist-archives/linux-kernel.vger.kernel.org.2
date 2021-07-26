Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC2A3D6A43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhGZWy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhGZWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:54:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187AC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:34:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso1389925pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+66KfoweN1Ee2V/z8f+apJdNLDFgl8859mlwwnYsf8=;
        b=bfhY6VwKlj+C3dibhtf+6FCziD4F30M0czf6J4IRYrHfmUOuY9+D+9m+J8afHMwrHp
         uaToPQMdviXDDvnQSs2HOIaOkldYqGRKFaN2idV1tmuk6Qb19xj/RancvYxD47v/H5+t
         ehvvRfrandEFu66JzyYprwJKr7jPchYza/+lMDxscdb33M+RN2FZnU5pIBqA1GqDaJzo
         NFwVtJq/L9vwUjpq2I9s7wAjoAvJ3UKqBSHLb0XcZQqCuCjJYDQ/kLU8RzQ5lvh7WGkQ
         y0qCqw28sz5urBKttycjjqnUP9tXKccGSqpSKZM1uZZ6bUhZAUPWl547KCCtWOIs2A6Z
         EJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+66KfoweN1Ee2V/z8f+apJdNLDFgl8859mlwwnYsf8=;
        b=WCBSig/D1ry1UvbUwIdjI1MjYaHNnm+t/xIcYFGLnEkK8D/nld4YMPVbfgO3WTtpJX
         QBYNmb92T6aR/ayk24UBkHNF54IJI76Uu1NUJjFbhnwnAO9SJxVikpAdcUD7Q18p+4XL
         CFgo+7XA+8wEwiPKWCNrPpUBNQjrLVZARQMSEsO9LeCl/qfXyAgsKvUwGorA029QpAiZ
         kMjDWgy5+2UB5hGlCcqXstHj7L7WdXBrC8BRZFn2gxgHDkQh/3B4fIy+FV14tN5hRpna
         3wQG7onkLXEweyJpLYNh8eNwKGtk6Q+uSM8xsJykiYBlTE5LApY0SNmo00RQbaw/VZkK
         HPiA==
X-Gm-Message-State: AOAM5328QxIKtVa0jURDY1YUuMeC6VXoSxnWMP0OzP7MD881tBa9sYjt
        ASjdd5G9qYuDJIJqG+NBI1c=
X-Google-Smtp-Source: ABdhPJwhCMg1vxAUIgBpCE4SBwS5qWyulr+AZ6krJy2fdCYh/e6aJXgSEQEuwjqmqVRzGiLIeX4Plw==
X-Received: by 2002:a17:90a:6a86:: with SMTP id u6mr1319647pjj.207.1627342491492;
        Mon, 26 Jul 2021 16:34:51 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id u6sm1152304pfn.31.2021.07.26.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:34:50 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Matthew Brost <matthew.brost@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 3/4] drm/atomic-helper: Set fence deadline for vblank
Date:   Mon, 26 Jul 2021 16:38:50 -0700
Message-Id: <20210726233854.2453899-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726233854.2453899-1-robdclark@gmail.com>
References: <20210726233854.2453899-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For an atomic commit updating a single CRTC (ie. a pageflip) calculate
the next vblank time, and inform the fence(s) of that deadline.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index bc3487964fb5..f81b20775b15 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1406,6 +1406,40 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/*
+ * For atomic updates which touch just a single CRTC, calculate the time of the
+ * next vblank, and inform all the fences of the of the deadline.
+ */
+static void set_fence_deadline(struct drm_device *dev,
+			       struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc, *wait_crtc = NULL;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state;
+	ktime_t vbltime;
+	int i;
+
+	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
+		if (!wait_crtc)
+			return;
+		wait_crtc = crtc;
+	}
+
+	/* If no CRTCs updated, then nothing to do: */
+	if (!wait_crtc)
+		return;
+
+	if (drm_crtc_next_vblank_time(wait_crtc, &vbltime))
+		return;
+
+	for_each_new_plane_in_state (state, plane, new_plane_state, i) {
+		if (!new_plane_state->fence)
+			continue;
+		dma_fence_set_deadline(new_plane_state->fence, vbltime);
+	}
+}
+
 /**
  * drm_atomic_helper_wait_for_fences - wait for fences stashed in plane state
  * @dev: DRM device
@@ -1435,6 +1469,8 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 	struct drm_plane_state *new_plane_state;
 	int i, ret;
 
+	set_fence_deadline(dev, state);
+
 	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
 		if (!new_plane_state->fence)
 			continue;
-- 
2.31.1

