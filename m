Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE99B437927
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhJVOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233167AbhJVOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634913655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Y7NfcTUc72UdelkpBwzcJihYziKx3J+s0xf/LWrgkY=;
        b=Rdr2lXn06lHitfsnm+78clXiF9OwFUZcoqvr4bA09u1zUqs4DtzG9yLJ6BWe/v1yh7iYN/
        WnH2N6zq5D2WfjNo0LZ6YBVVPBR2sR6m9wGW2j4hDFHoRYORym8cBJCti8oyNS9diq60MK
        Dr0uXY6B3mJIQAF+ub9S6EewFVTUuUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-gvKF18UQN8God2XVuS4Vnw-1; Fri, 22 Oct 2021 10:40:53 -0400
X-MC-Unique: gvKF18UQN8God2XVuS4Vnw-1
Received: by mail-wr1-f70.google.com with SMTP id x1-20020adfffc1000000b001679fc9c018so1005875wrs.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 07:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y7NfcTUc72UdelkpBwzcJihYziKx3J+s0xf/LWrgkY=;
        b=Kq6//pl+qXvEb6dVCr6PSc9bkXcD0sxX6pLd5tk2UMmHpyjc2kaHkmfDewd3ER8WQs
         dR2cdig3g9aDPtAoA4oNsfdkBXzXVK8f4sY3DRjFtolL8efFc71r86IhVpyK0B9ncbOf
         l3gh5SDdFsoXKapAwEGzRdLYhKTr+9+oOEAT3zIXbhSI8A1ub1opUTY2doJRfmT8+D9/
         jr3keMrdMfi+z7mx5SbKrdizC0waC5BzImt2TVZDrvo8yemiyusTNzpMnSbmu1DDiNm0
         9ndx11jDI3ctOg6XFiXa7Nf0kPU276QtkLorJJl62IhigGYtQk+sxKsXDIdtsVzz1tGw
         YkSg==
X-Gm-Message-State: AOAM530pUIvYhdcSc0c9IDDBQOH9cpJICNx1afC604GbKTIsGZW9iqym
        Yp/Bmb2FLHutHl4ekC0J/I+pgN7TJroew2ZWnH/xZ0DJJ3MRTOD0ljdFzPPmIBvOFDO+ks0oS6b
        pTjrbxFIgQnHY3zCbRxWPXNgF49vyqwLGg9opevvsWLwhgeBlosoY0GMhHH633a50JWduF9QWRT
        I=
X-Received: by 2002:adf:a556:: with SMTP id j22mr256031wrb.431.1634913649913;
        Fri, 22 Oct 2021 07:40:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrA+8XKgUdKV8FF09Xl8lAf5kXXVCvm7L8ndkX22MUwJziJuYxZIq41IahfWM7uQNg5ZEQQQ==
X-Received: by 2002:adf:a556:: with SMTP id j22mr255978wrb.431.1634913649537;
        Fri, 22 Oct 2021 07:40:49 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id r205sm8579459wma.3.2021.10.22.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:40:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [RFC PATCH] drm/aperture: Add param to disable conflicting framebuffers removal
Date:   Fri, 22 Oct 2021 16:40:40 +0200
Message-Id: <20211022144040.3418284-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simpledrm driver allows to use the frame buffer that was set-up by the
firmware. This gives early video output before the platform DRM driver is
probed and takes over.

But it would be useful to have a way to disable this take over by the real
DRM drivers. For example, there may be bugs in the DRM drivers that could
cause the display output to not work correctly.

For those cases, it would be good to keep the simpledrm driver instead and
at least get a working display as set-up by the firmware.

Let's add a drm.remove_fb boolean kernel command line parameter, that when
set to false will prevent the conflicting framebuffers to being removed.

Since the drivers call drm_aperture_remove_conflicting_framebuffers() very
early in their probe callback, this will cause the drivers' probe to fail.

Thanks to Neal Gompa for the suggestion and Thomas Zimmermann for the idea
on how this could be implemented.

Suggested-by: Neal Gompa <ngompa13@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Hello,

I'm sending this as an RFC because I wasn't sure about the correct name for
this module parameter, and also if 'remove_fb=0' is intitutive or instead a
parameter that's enabled is preferred (i.e: 'disable_fb_removal=1').

Best regards,
Javier

 drivers/gpu/drm/drm_aperture.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 74bd4a76b253..0b454c8f7465 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -14,6 +14,11 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 
+static bool drm_aperture_remove_fb = true;
+module_param_named(remove_fb, drm_aperture_remove_fb, bool, 0600);
+MODULE_PARM_DESC(remove_fb,
+		 "Allow conflicting framebuffers removal [default=true]");
+
 /**
  * DOC: overview
  *
@@ -283,6 +288,9 @@ static void drm_aperture_detach_drivers(resource_size_t base, resource_size_t si
  * This function removes graphics device drivers which use memory range described by
  * @base and @size.
  *
+ * The conflicting framebuffers removal can be disabled by setting the drm.remove_fb=0 kernel
+ * command line option. When this is disabled, the function will return an -EINVAL errno code.
+ *
  * Returns:
  * 0 on success, or a negative errno code otherwise
  */
@@ -292,7 +300,12 @@ int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_
 #if IS_REACHABLE(CONFIG_FB)
 	struct apertures_struct *a;
 	int ret;
+#endif
+
+	if (!drm_aperture_remove_fb)
+		return -EINVAL;
 
+#if IS_REACHABLE(CONFIG_FB)
 	a = alloc_apertures(1);
 	if (!a)
 		return -ENOMEM;
@@ -322,6 +335,9 @@ EXPORT_SYMBOL(drm_aperture_remove_conflicting_framebuffers);
  * for any of @pdev's memory bars. The function assumes that PCI device with
  * shadowed ROM drives a primary display and so kicks out vga16fb.
  *
+ * The conflicting framebuffers removal can be disabled by setting the drm.remove_fb=0 kernel
+ * command line option. When this is disabled, the function will return an -EINVAL errno code.
+ *
  * Returns:
  * 0 on success, or a negative errno code otherwise
  */
@@ -331,6 +347,9 @@ int drm_aperture_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 	resource_size_t base, size;
 	int bar, ret = 0;
 
+	if (!drm_aperture_remove_fb)
+		return -EINVAL;
+
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
 		if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
 			continue;
-- 
2.31.1

