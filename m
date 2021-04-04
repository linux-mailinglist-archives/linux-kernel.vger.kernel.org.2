Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B91353830
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhDDNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhDDNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 09:10:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B89C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 06:10:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c17so6581428pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpP8iuj2W2E0/RJV7xhpUQW/zqPiNVan0e9pCvjPrtQ=;
        b=BjAUMjEn4FzCwiElEg3/+kaGl/m7HWc9qNG9hmk1sn7SSqF7CHC9miFrsYYHXVyIe/
         LKZIH9i2USzppgAUIwiJ4qvm2qf+6E1N8aucrpa5rqjZJg4+puWO3pjv2g7uevOo3Kg3
         gzLdEwtIPIOrVffcpNzvV5cRzW9XKgDEXGhECnx+x2SHRQnOxocgg4TXKRdRS3t5i1Yo
         fEKLO+00KCdlI8XpV6G3sP+1wT4jhe3g9RtHv3J9moxcV+bfQNh3zWhjay5dXraVq5dU
         HD5c0P15r7pZ2PFX3/lQd1tTMwdI08rz+ynK9gXb1ObKe/TVtMkjhsclpk/Rj0PuK3cX
         G5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpP8iuj2W2E0/RJV7xhpUQW/zqPiNVan0e9pCvjPrtQ=;
        b=Z1jEx/aegwPsZ2UVNJxCqnmZ0Sa/KeilqONuePg5Xxq8u2IhonabkmViaAoJ4uuPWx
         CsiEw5egRrJpjrjvc27mK4FWejPE4c2AbH/PFpmZWAcpF7mL1r+89+UTEt6AVbwPP8mt
         OkUd9alFt7J0uRpLhyjYxckhijcu2lnQowpagzkPwBbmuyUQP9bHkW+IZVRhKUN5ZYq4
         IlYeoMhja6Gw52X8XaZTShIFipPHnffbtuIpqzfRsH3Ub3/JS04GtwJt/C2DPTEhDCtF
         ABbhlPPp2KhovctJKJEZKGtxIlVN1sG2XcQrOqeMKV48aAdXNJyackRkUi3PTY35VDIE
         4TUw==
X-Gm-Message-State: AOAM533Hp5WuDa1OyqYAHQ2UASCOUCr2k7JRewZho973B1Z10KOQAu3A
        2f8U7cgY3zqZNH925++NNrq7VSGar1hTfg==
X-Google-Smtp-Source: ABdhPJxVFzfKOQ4Ql0GqjyWB/1kfYFcr2gtNUiF8Rsm4VBLQTmuvdAVXDcKelqAVvT94GEkXcK1wtw==
X-Received: by 2002:a62:e805:0:b029:1f8:16ba:4518 with SMTP id c5-20020a62e8050000b02901f816ba4518mr19404817pfi.37.1617541852107;
        Sun, 04 Apr 2021 06:10:52 -0700 (PDT)
Received: from adolin ([49.207.202.237])
        by smtp.gmail.com with ESMTPSA id mv9sm364214pjb.29.2021.04.04.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 06:10:51 -0700 (PDT)
Date:   Sun, 4 Apr 2021 18:40:46 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] drm/vkms: Refactor vkms_composer_worker() to prep for
 virtual_hw mode
Message-ID: <e948dc1de2c7de246c81728248d7c6cdca7b4fd6.1617539357.git.sylphrenadin@gmail.com>
References: <cover.1617539357.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617539357.git.sylphrenadin@gmail.com>
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

Changes in V3:
- Refactor patchset (Melissa)
Change in V2:
- Add vkms_composer_common() (Daniel)
---
 drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_drv.h      |  3 +
 2 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 66c6842d70db..91b33c9c2f47 100644
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
+	ret = vkms_composer_common(crtc_state, out, crtc_state->wb_pending, &crc32);
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

