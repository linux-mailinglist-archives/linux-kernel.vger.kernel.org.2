Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40C3DCC93
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhHAQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhHAQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 12:04:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DE6C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 09:04:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so10778933pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qWjHcNc9/cKIzWTM8p61ItynnbVxNw2Lx8bEmqmAetI=;
        b=nE+QduxE8NhfYgjAcdepIT+KzHO6Mq/IoqdxRNSSwCEBZvfdHRRWQtcX3Hc+Jor5P3
         Ofavidc15wIUeDkwgXQrg1cUp19fsaK+L92bB6li95L1O6C4cXVzHP7vhDF/8MvMyR64
         oHc7npopMH4HfjORPUyr8vPmuyc3Oj37PB/QEtet94g98Ph++ft2Ho85zLBQfuWyJ9Eo
         eCezJFfhd4ZHR5dhbrpZabX/5LjXJnokC+BIH5Z+bKNGPZJVNIw3A1CeibtSRx22k1jK
         +YBKa18RoVZuTtCVe470RKEmFmoCA/OnIoEc45KSYpB4Py+guTJMtF/bDMTVsRa7eK21
         JOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWjHcNc9/cKIzWTM8p61ItynnbVxNw2Lx8bEmqmAetI=;
        b=PeNliFB93MOYDwtgXyddHRrvqgbxj0WKP8Ai6Dv+553JOxt2X5l+Wj+cHiHhUovzJW
         MEy++y0aMIlst5QvoFZA3EbSFta1cUqQIZ5jprDBP41nprI5fX5j42h3nICj7g0qlYHP
         ScwF+gkPm71maBVHCDyiI5k2/NTRfknpFOZpu6zCUmQplXJpJccrlsXkO9JOq0afuRHq
         6CJhzdeV0sVM8+yZLxLXRIP5Rpkr2NgKN8KZyhsEWSfVRw1FRjOVW7fumXmSCxqicpu2
         brDaVv/AhmXE10eBa6b7E2jdZFDyH2k8p2GvLs9Z/w6HNEqopr8JV7+CEMwPU3ueL/cV
         QEQw==
X-Gm-Message-State: AOAM533iu1gCi/CHFMEu2oByDEpiLBycviVdwjxZPh7EgibOvCbALCl0
        080Mv1IjGBlNnQVUWjxhE+Y=
X-Google-Smtp-Source: ABdhPJzfNy1c5HJoUaRcbqftHZkZl+7/2xFDQiwQh/atJajKc6AcevU4q/eYjGT3IXo0Lybf1J478w==
X-Received: by 2002:a17:90a:ba8e:: with SMTP id t14mr13385953pjr.176.1627833850298;
        Sun, 01 Aug 2021 09:04:10 -0700 (PDT)
Received: from adolin ([49.207.203.94])
        by smtp.gmail.com with ESMTPSA id x7sm8581978pfn.70.2021.08.01.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 09:04:10 -0700 (PDT)
Date:   Sun, 1 Aug 2021 21:33:00 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/2] drm/vkms: Refactor vkms_composer_worker() to prep for
 virtual_hw mode
Message-ID: <8aadb60b4d4768dc5518f12a5952909a388212c2.1627831087.git.sylphrenadin@gmail.com>
References: <cover.1627831087.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627831087.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function vkms_composer_common(). The actual plane
composition work has been moved to the helper function,
vkms_composer_common() which is called by vkms_composer_worker()
and will be called in the implementation of virtual_hw mode
as well.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V5:
- Move vkms_crtc_composer() to the patch that introduces
virtual_hw mode (Melissa)
- Fix checkpatch errors(Melissa)
Changes in V4:
- Fix warning
Changes in V3:
- Refactor patchset (Melissa)
Change in V2:
- Add vkms_composer_common() (Daniel)
---
 drivers/gpu/drm/vkms/vkms_composer.c | 76 ++++++++++++++++------------
 drivers/gpu/drm/vkms/vkms_drv.h      |  2 +
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index ead8fff81f30..bf3d576db225 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -206,6 +206,47 @@ static int compose_active_planes(void **vaddr_out,
 	return 0;
 }
 
+int vkms_composer_common(struct vkms_crtc_state *crtc_state,
+			 struct vkms_output *out, bool wb_pending, uint32_t *crc32)
+{
+	struct vkms_composer *primary_composer = NULL;
+	struct vkms_plane_state *act_plane = NULL;
+	void *vaddr_out = NULL;
+	int ret;
+
+	if (crtc_state->num_active_planes >= 1) {
+		act_plane = crtc_state->active_planes[0];
+		if (act_plane->base.base.plane->type == DRM_PLANE_TYPE_PRIMARY)
+			primary_composer = act_plane->composer;
+	}
+
+	if (!primary_composer)
+		return -EINVAL;
+	if (wb_pending)
+		vaddr_out = crtc_state->active_writeback;
+
+	ret = compose_active_planes(&vaddr_out, primary_composer, crtc_state);
+
+	if (ret) {
+		if ((ret == -EINVAL || ret == -ENOMEM) && !wb_pending)
+			kfree(vaddr_out);
+		return ret;
+	}
+
+	*crc32 = compute_crc(vaddr_out, primary_composer);
+
+	if (wb_pending) {
+		drm_writeback_signal_completion(&out->wb_connector, 0);
+		spin_lock_irq(&out->composer_lock);
+		crtc_state->wb_pending = false;
+		spin_unlock_irq(&out->composer_lock);
+	} else {
+		kfree(vaddr_out);
+	}
+
+	return 0;
+}
+
 /**
  * vkms_composer_worker - ordered work_struct to compute CRC
  *
@@ -222,10 +263,7 @@ void vkms_composer_worker(struct work_struct *work)
 						composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-	struct vkms_composer *primary_composer = NULL;
-	struct vkms_plane_state *act_plane = NULL;
 	bool crc_pending, wb_pending;
-	void *vaddr_out = NULL;
 	u32 crc32 = 0;
 	u64 frame_start, frame_end;
 	int ret;
@@ -247,37 +285,9 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!crc_pending)
 		return;
 
-	if (crtc_state->num_active_planes >= 1) {
-		act_plane = crtc_state->active_planes[0];
-		if (act_plane->base.base.plane->type == DRM_PLANE_TYPE_PRIMARY)
-			primary_composer = act_plane->composer;
-	}
-
-	if (!primary_composer)
-		return;
-
-	if (wb_pending)
-		vaddr_out = crtc_state->active_writeback;
-
-	ret = compose_active_planes(&vaddr_out, primary_composer,
-				    crtc_state);
-	if (ret) {
-		if (ret == -EINVAL && !wb_pending)
-			kfree(vaddr_out);
+	ret = vkms_composer_common(crtc_state, out, wb_pending, &crc32);
+	if (ret == -EINVAL)
 		return;
-	}
-
-	crc32 = compute_crc(vaddr_out, primary_composer);
-
-	if (wb_pending) {
-		drm_writeback_signal_completion(&out->wb_connector, 0);
-		spin_lock_irq(&out->composer_lock);
-		crtc_state->wb_pending = false;
-		spin_unlock_irq(&out->composer_lock);
-	} else {
-		kfree(vaddr_out);
-	}
-
 	/*
 	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
 	 */
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8c731b6dcba7..01beba424f18 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -132,6 +132,8 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 			   size_t *values_cnt);
 
 /* Composer Support */
+int vkms_composer_common(struct vkms_crtc_state *crtc_state, struct vkms_output *out,
+			 bool wb_pending, uint32_t *crcs);
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
 
-- 
2.31.1

