Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB58643FBF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJ2MFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhJ2MFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:05:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1150E610EA;
        Fri, 29 Oct 2021 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635508992;
        bh=2IyJsR8W6tA2KwPjXHjKViZaH1uY8qqJVOQ80yvHAQc=;
        h=From:To:Cc:Subject:Date:From;
        b=dvQh47BaFWFWxweGZR9oJCcL+p3cOgpXRp307Sk6XP8m0IBbZi7r9Yl5fOsmW8rqh
         oWOGhvZmgo2wd1FNkBzk2XnTLKocaJAzbq/gq0IYTAvOY2dKo/mTC2olFWAtgTeOUa
         CZdR8tPd7/gdznNhTq+IrWuGY/LxKyF4Ax+yifcaOfc2lHf3BREZIw9GWKW830lj13
         SQd5ITBddonm9nwOIUaTsHNBBqrOBZt+kAAjYsm+gyKwqkcs5tdK0xKoh/NJd7FLYY
         lkXoU4n1ejLlihwprDIALH6f1sTvgSzyvu8vl4W85hx/FIUhW2y2r8AIWozzBbdLgC
         kl5AlBQh1NllA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Acked-by : Jani Nikula" <jani.nikula@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: fb_helper: improve CONFIG_FB dependency
Date:   Fri, 29 Oct 2021 14:02:38 +0200
Message-Id: <20211029120307.1407047-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

My previous patch correctly addressed the possible link failure, but as
Jani points out, the dependency is now stricter than it needs to be.

Change it again, to allow DRM_FBDEV_EMULATION to be used when
DRM_KMS_HELPER and FB are both loadable modules and DRM is linked into
the kernel.

As a side-effect, the option is now only visible when at least one DRM
driver makes use of DRM_KMS_HELPER. This is better, because the option
has no effect otherwise.

Fixes: 606b102876e3 ("drm: fb_helper: fix CONFIG_FB dependency")
Suggested-by: Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c08860db2520..d2e6d8ce5000 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -117,9 +117,8 @@ config DRM_DEBUG_MODESET_LOCK
 
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
-	depends on DRM
-	depends on FB=y || FB=DRM
-	select DRM_KMS_HELPER
+	depends on DRM_KMS_HELPER
+	depends on FB=y || FB=DRM_KMS_HELPER
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.29.2

