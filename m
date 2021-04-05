Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBE353C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhDEGOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDEGOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:14:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E132C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 23:14:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso5338232pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 23:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/IfExfus1vocG71Vx4LOl+ryphcS1zaeMleudxBDVe4=;
        b=LNqJUbOBmtkq/pIR+aMV8v+ADtgKF2hv6BhM2ORxRQAZYP+bDu2hZ5gYWoWmyxTVoS
         gLAv7dTIaUTUYZVJiIC8oQJ4JR8znjaC6xNwgQI2Fd9VokuQTyYtujXadRn/mnURerSI
         LgSFFeJYRzp9D7ZTJTcjBP2Fc/eRfgutsP3PJw2i9GAjaiz8hluidJFTtv/BCJPODZWM
         btpw5ZU9iSNccmFwvTxGBh+SNs9hZQkkb3jgpgcedQw9q2D4aYeQnk/CrXVonQtg+Z3H
         1iPENJ9vTO5Jj+AkW0UHvG2Y67y4mQUAUaG1nkZid/MEet/sWRm2PVtLZJltdDF/X5TF
         kDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/IfExfus1vocG71Vx4LOl+ryphcS1zaeMleudxBDVe4=;
        b=tozXyFO0/WepJ3oQ8oAgPoIvcT86eRzyVl9Ou719aIEPWmIFCic59ZkAGRpnyg4XKr
         PKCkx097sqLfh+5qok9upE5868rexOtv6LxgDioX2WSUI6o5tZqm3WaS2kT5ef621nGv
         RoqXvjRuvD0uKqeZI2KAV+1gqj+RtINKnci8Zx4CPYVcJC8v3qwivF2buBrOkcECXIrv
         ILqHVEmk/oZqc+lEtsEkWFnzgz8hiPMUOMeQDfV7RwQ1hsRZPJ3eTN2g7JAbtP0457ES
         nfTzqYIObfEMxZ9brYyhNK5mONjahrqb0S78BlAyHXYgIkz3nr4pB8Qb+ifBVmvddnm6
         nuMA==
X-Gm-Message-State: AOAM531Mrxb/aeIlz/oEakQQz/w5LaU0y4wLtzIIVs7hbZk9KiAUQCKT
        lyhpyebA8zlBSdzwi3DJCgc=
X-Google-Smtp-Source: ABdhPJw5C1RHbU+Vyv09zgSuaDM1ux/Oavq8hzT4zWBRDFqRDxRcDHwcb/ShyV5d2O9IJpBovppm2Q==
X-Received: by 2002:a17:90a:eb93:: with SMTP id o19mr15106473pjy.59.1617603273447;
        Sun, 04 Apr 2021 23:14:33 -0700 (PDT)
Received: from adolin ([49.207.194.193])
        by smtp.gmail.com with ESMTPSA id em16sm3320954pjb.43.2021.04.04.23.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 23:14:33 -0700 (PDT)
Date:   Mon, 5 Apr 2021 11:44:28 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] drm/vkms: Refactor vkms_composer_worker() to prep for
 virtual_hw mode
Message-ID: <ab3492843ea631c51a3ff8dcf8e3f7af96aaed60.1617602076.git.sylphrenadin@gmail.com>
References: <cover.1617602076.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617602076.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new functions vkms_composer_common() and vkms_crtc_composer().
The actual plane composition work has been moved to the helper function,
vkms_composer_common() which is called by both vkms_composer_worker()
and vkms_crtc_composer(). vkms_crtc_composer() can be used when we
implement virtual_hw mode.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in V4:
- Fix warning
Changes in V3:
- Refactor patchset (Melissa)
Change in V2:
- Add vkms_composer_common() (Daniel)
---
 drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_drv.h      |  3 +
 2 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 66c6842d70db..0d2bad3ff849 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -169,6 +169,44 @@ static int compose_planes(void **vaddr_out,
 	return 0;
 }
 
+int vkms_composer_common(struct vkms_crtc_state *crtc_state,
+			 struct vkms_output *out, bool wb_pending, uint32_t *crc32)
+{
+	struct vkms_composer *primary_composer = NULL;
+	struct vkms_composer *cursor_composer = NULL;
+	void *vaddr_out = NULL;
+	int ret;
+
+	if (crtc_state->num_active_planes >= 1)
+		primary_composer = crtc_state->active_planes[0]->composer;
+	if (crtc_state->num_active_planes == 2)
+		cursor_composer = crtc_state->active_planes[1]->composer;
+	if (!primary_composer)
+		return -EINVAL;
+	if (wb_pending)
+		vaddr_out = crtc_state->active_writeback;
+
+	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
+	if (ret) {
+		if (ret == -EINVAL && !wb_pending)
+			kfree(vaddr_out);
+		return -EINVAL;
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
@@ -185,12 +223,9 @@ void vkms_composer_worker(struct work_struct *work)
 						composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-	struct vkms_composer *primary_composer = NULL;
-	struct vkms_composer *cursor_composer = NULL;
 	bool crc_pending, wb_pending;
-	void *vaddr_out = NULL;
-	u32 crc32 = 0;
 	u64 frame_start, frame_end;
+	u32 crc32 = 0;
 	int ret;
 
 	spin_lock_irq(&out->composer_lock);
@@ -210,36 +245,9 @@ void vkms_composer_worker(struct work_struct *work)
 	if (!crc_pending)
 		return;
 
-	if (crtc_state->num_active_planes >= 1)
-		primary_composer = crtc_state->active_planes[0]->composer;
-
-	if (crtc_state->num_active_planes == 2)
-		cursor_composer = crtc_state->active_planes[1]->composer;
-
-	if (!primary_composer)
-		return;
-
-	if (wb_pending)
-		vaddr_out = crtc_state->active_writeback;
-
-	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
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
@@ -247,6 +255,20 @@ void vkms_composer_worker(struct work_struct *work)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
 }
 
+void vkms_crtc_composer(struct vkms_crtc_state *crtc_state)
+{
+	struct drm_crtc *crtc = crtc_state->base.crtc;
+	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
+	u32 crc32 = 0;
+	int ret;
+
+	ret = vkms_composer_common(crtc_state, out, crtc_state->wb_pending, &crc32);
+	if (ret == -EINVAL)
+		return;
+
+	drm_crtc_add_crc_entry(crtc, true, 0, &crc32);
+}
+
 static const char * const pipe_crc_sources[] = {"auto"};
 
 const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 35540c7c4416..538315140585 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -125,8 +125,11 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
 			   size_t *values_cnt);
 
 /* Composer Support */
+int vkms_composer_common(struct vkms_crtc_state *crtc_state, struct vkms_output *out,
+			 bool wb_pending, uint32_t *crcs);
 void vkms_composer_worker(struct work_struct *work);
 void vkms_set_composer(struct vkms_output *out, bool enabled);
+void vkms_crtc_composer(struct vkms_crtc_state *crtc_state);
 
 /* Writeback */
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
-- 
2.25.1

