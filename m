Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C50454973
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhKQPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:02:15 -0500
Received: from marcansoft.com ([212.63.210.85]:57482 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhKQPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:02:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8F59841F5D;
        Wed, 17 Nov 2021 14:59:09 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 2/3] drm/format-helper: Add drm_fb_xrgb8888_to_xrgb2101010_dstclip()
Date:   Wed, 17 Nov 2021 23:58:28 +0900
Message-Id: <20211117145829.204360-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117145829.204360-1-marcan@marcan.st>
References: <20211117145829.204360-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add XRGB8888 emulation support for devices that can only do XRGB2101010.

This is chiefly useful for simpledrm on Apple devices where the
bootloader-provided framebuffer is 10-bit, which already works fine with
simplefb. This is required to make simpledrm support this too.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/gpu/drm/drm_format_helper.c | 64 +++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |  4 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 69fde60e36b3..5998e57d6ff2 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -378,6 +378,60 @@ void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst, unsigned int dst_pitch
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
 
+static void drm_fb_xrgb8888_to_xrgb2101010_line(u32 *dbuf, u32 *sbuf,
+						unsigned int pixels)
+{
+	unsigned int x;
+
+	for (x = 0; x < pixels; x++) {
+		*dbuf++ = ((sbuf[x] & 0x000000FF) << 2) |
+			  ((sbuf[x] & 0x0000FF00) << 4) |
+			  ((sbuf[x] & 0x00FF0000) << 6);
+	}
+}
+
+/**
+ * drm_fb_xrgb8888_to_xrgb2101010_dstclip - Convert XRGB8888 to XRGB2101010 clip
+ * buffer
+ * @dst: XRGB2101010 destination buffer (iomem)
+ * @dst_pitch: destination buffer pitch
+ * @vaddr: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ *
+ * Drivers can use this function for XRGB2101010 devices that don't natively
+ * support XRGB8888.
+ *
+ * This function applies clipping on dst, i.e. the destination is a
+ * full (iomem) framebuffer but only the clip rect content is copied over.
+ */
+void drm_fb_xrgb8888_to_xrgb2101010_dstclip(void __iomem *dst,
+					    unsigned int dst_pitch, void *vaddr,
+					    struct drm_framebuffer *fb,
+					    struct drm_rect *clip)
+{
+	size_t linepixels = clip->x2 - clip->x1;
+	size_t dst_len = linepixels * 4;
+	unsigned int y, lines = clip->y2 - clip->y1;
+	void *dbuf;
+
+	dbuf = kmalloc(dst_len, GFP_KERNEL);
+	if (!dbuf)
+		return;
+
+	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
+	dst += clip_offset(clip, dst_pitch, sizeof(u32));
+	for (y = 0; y < lines; y++) {
+		drm_fb_xrgb8888_to_xrgb2101010_line(dbuf, vaddr, linepixels);
+		memcpy_toio(dst, dbuf, dst_len);
+		vaddr += fb->pitches[0];
+		dst += dst_pitch;
+	}
+
+	kfree(dbuf);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_dstclip);
+
 /**
  * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
  * @dst: 8-bit grayscale destination buffer
@@ -464,6 +518,10 @@ int drm_fb_blit_rect_dstclip(void __iomem *dst, unsigned int dst_pitch,
 		fb_format = DRM_FORMAT_XRGB8888;
 	if (dst_format == DRM_FORMAT_ARGB8888)
 		dst_format = DRM_FORMAT_XRGB8888;
+	if (fb_format == DRM_FORMAT_ARGB2101010)
+		fb_format = DRM_FORMAT_XRGB2101010;
+	if (dst_format == DRM_FORMAT_ARGB2101010)
+		dst_format = DRM_FORMAT_XRGB2101010;
 
 	if (dst_format == fb_format) {
 		drm_fb_memcpy_dstclip(dst, dst_pitch, vmap, fb, clip);
@@ -482,6 +540,12 @@ int drm_fb_blit_rect_dstclip(void __iomem *dst, unsigned int dst_pitch,
 							  vmap, fb, clip);
 			return 0;
 		}
+	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
+		if (fb_format == DRM_FORMAT_XRGB8888) {
+			drm_fb_xrgb8888_to_xrgb2101010_dstclip(dst, dst_pitch,
+							       vmap, fb, clip);
+			return 0;
+		}
 	}
 
 	return -EINVAL;
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index e86925cf07b9..a0faa710878b 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -29,6 +29,10 @@ void drm_fb_xrgb8888_to_rgb888(void *dst, void *src, struct drm_framebuffer *fb,
 void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip);
+void drm_fb_xrgb8888_to_xrgb2101010_dstclip(void __iomem *dst,
+					    unsigned int dst_pitch, void *vaddr,
+					    struct drm_framebuffer *fb,
+					    struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
 			      struct drm_rect *clip);
 
-- 
2.33.0

