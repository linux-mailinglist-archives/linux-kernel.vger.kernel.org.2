Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52323D6A41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhGZWyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhGZWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:54:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22FC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:34:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b6so15163704pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbCW32LfSHCHAkiAwgfCI+KXCphqw3RtU6lMEfGs4FM=;
        b=K7q0iQ+y4WkqT1bVjpFLpq2Mqb2axCqi3h4Q2onnI0EzLhJZARQ/qTyYNRBYJ9l1DE
         7GZO8TjDe7AZ+qALiz6rF/b8fgT8J2Pf4sduYXHwQRzEO5WobDLtcyD1Mgqk3yGETTIk
         H6c3UJEVgPHOXWNMgxcHjvWo3eaOXzaJKXyLybJ8mHHUF0TZw3+zWyJWlKYN6ayjEAV5
         LNAzrjKa6OJf+Zszw7Q32fI4KDy+KYNsvtdNbJe9smE73vR7qN4jfm1KdbIuwQC8eFr0
         LdIu9cO1MTVz+49dy146/Pcbqnt5FdDj0Ljf+PF0WyFTYntjdV29dBlGwwjlWvdK2jOr
         ZI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbCW32LfSHCHAkiAwgfCI+KXCphqw3RtU6lMEfGs4FM=;
        b=f+/gbJ1gwgpEJF906KxoKg13RuImO/NohX7xgku+wnyfOGVbGvIB0G7LdxzwbCmp+1
         LX6NNvSQFIoi8xToVUvT9trOpVNuvpId7yEW4bb5FeceMCnWQdO4HFbkEfnRB50SuvUL
         BjDaMpb/l/dx+XrpH4JGru6j2zeqjrlwfmurEArw3s0TaFTHYeKhhbINSZTweAX1Zv0e
         T/C8qxS74dSLAshCefFP66e3/IILOGuceiOFYfw2TegxEAirsSqbZv0CEPLbMrCDJz5a
         74krNMG4dFTMZFF7/zBjm/kOfs97uaVL39n6Z7t9XHiHDOq86cIxC8sLzBYecTu2j73D
         yF/g==
X-Gm-Message-State: AOAM530381BU4qPeGYdQe4yY27k/F1O/26AhOsZ0l55sz1H173sH/MLX
        OoV8eMAk9daHQpBO2R6WKbo=
X-Google-Smtp-Source: ABdhPJxoQiLmHlotD+gpMoGdvL3iH855w/RTYJTvJFSV12JczIXixU5zFwe1jY6beM1RPKlKx/Hotg==
X-Received: by 2002:a63:d74c:: with SMTP id w12mr20458925pgi.91.1627342489183;
        Mon, 26 Jul 2021 16:34:49 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id ns18sm720850pjb.31.2021.07.26.16.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:34:48 -0700 (PDT)
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
Subject: [RFC 2/4] drm/vblank: Add helper to get next vblank time
Date:   Mon, 26 Jul 2021 16:38:49 -0700
Message-Id: <20210726233854.2453899-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210726233854.2453899-1-robdclark@gmail.com>
References: <20210726233854.2453899-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_vblank.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_vblank.h     |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 3417e1ac7918..88c824c294dc 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -980,6 +980,37 @@ u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
 
+/**
+ * drm_crtc_next_vblank_time - calculate the time of the next vblank
+ * @crtc: the crtc for which to calculate next vblank time
+ * @vblanktime: pointer to time to receive the next vblank timestamp.
+ *
+ * Calculate the expected time of the next vblank based on time of previous
+ * vblank and frame duration
+ */
+int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime)
+{
+	unsigned int pipe = drm_crtc_index(crtc);
+	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
+	u64 count;
+
+	if (!vblank->framedur_ns)
+		return -EINVAL;
+
+	count = drm_vblank_count_and_time(crtc->dev, pipe, vblanktime);
+
+	/*
+	 * If we don't get a valid count, then we probably also don't
+	 * have a valid time:
+	 */
+	if (!count)
+		return -EINVAL;
+
+	*vblanktime = ktime_add(*vblanktime, ns_to_ktime(vblank->framedur_ns));
+
+	return 0;
+}
+
 static void send_vblank_event(struct drm_device *dev,
 		struct drm_pending_vblank_event *e,
 		u64 seq, ktime_t now)
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 733a3e2d1d10..a63bc2c92f3c 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_device *dev);
 u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
 u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
 				   ktime_t *vblanktime);
+int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vblanktime);
 void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
 			       struct drm_pending_vblank_event *e);
 void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
-- 
2.31.1

