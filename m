Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50FA44E767
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhKLNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232373AbhKLNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1s41S2hPwpPT7g2xpXi235aPAB5NLJoO6nNF2Iym4o=;
        b=AUEdCj5W6yMIB9ZXPEvegwJ3qwa9AxD5hWvmiTiwLBanCtd4J/7DwSXqUIcKJwIZujz9LW
        UtEQWL1SQcIiz/klKwx72Rji3TLZnzkvjUREKwdHsMsDyROeMt56UzAc+3dgaFg8IzrdLF
        7yyGyMXBaSbWOKuXdcEnrOb5oQ5QeGE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-bheTXS7YN-OjalpA8aKJAw-1; Fri, 12 Nov 2021 08:32:53 -0500
X-MC-Unique: bheTXS7YN-OjalpA8aKJAw-1
Received: by mail-wm1-f72.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso6304039wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1s41S2hPwpPT7g2xpXi235aPAB5NLJoO6nNF2Iym4o=;
        b=GZwT1m2CChOvmnl8wXzJ8WZFBbjSvQYp6kMYdb92zchrqmQokLiU5pYAxt/GXDmZtm
         iHwtxFVlWKLtjv/e2V8hijgs+SOFUP0GLTHHd0YwrXzj9FXCKi5tSH/AQEZsrseHDk2v
         z27XjD1jb8ERspvUG/1JZCNvMz/T8NMt/ktM7j5e86A83sQFL4zhzwfTtiN8l9FExeB+
         v1Ycw1Kj1q7v7alp7p0N3g1jMMCWI5PIo4toMi5MhcCaUY+j6I8iX8VFxOWwTpQ70DZu
         Y14tEqvMRHU4vME44HiF48qxCpV4wfWZM2rl0wwOreYORI52SsjVBUszW6kuLfIrkBcG
         Y3BA==
X-Gm-Message-State: AOAM531t5Ft1BLMWZZHQdyzLn9tnKt8U+f/sT8MTgxFr4wyeFqBWNxFD
        XoO10JxSsbozGHf6bhkmFPEoWroPH2KjivbWMKjj12NPewm30+vwLnH56hJxr3bTv5dnpShwSl+
        zTsnNVA7i0QYZIc/sPWh8/V3HIr0LDx1wGZa0Rw23CP3X0G4nMqtaFuoJZQ1UrRWgHeZCTZNZR6
        Y=
X-Received: by 2002:a7b:cf0f:: with SMTP id l15mr17452515wmg.92.1636723972386;
        Fri, 12 Nov 2021 05:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0Xujucpr+TCy5KQx1Uvs84Rns+3FCYJpzpxCgAXAGddQEWARAJGBX35Wrmx2RbfGOXF7SbQ==
X-Received: by 2002:a7b:cf0f:: with SMTP id l15mr17452471wmg.92.1636723972162;
        Fri, 12 Nov 2021 05:32:52 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm5733470wrv.78.2021.11.12.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:32:51 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 4/6] drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
Date:   Fri, 12 Nov 2021 14:32:28 +0100
Message-Id: <20211112133230.1595307-5-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112133230.1595307-1-javierm@redhat.com>
References: <20211112133230.1595307-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This relationship was only for historical reasons and the nomodeset option
should be available even on platforms that don't enable CONFIG_VGA_CONSOLE.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/Kconfig  | 6 ++++++
 drivers/gpu/drm/Makefile | 2 +-
 include/drm/drm_drv.h    | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git drivers/gpu/drm/Kconfig drivers/gpu/drm/Kconfig
index fb144617055b..483d534eb074 100644
--- drivers/gpu/drm/Kconfig
+++ drivers/gpu/drm/Kconfig
@@ -8,6 +8,7 @@
 menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
+	select DRM_NOMODESET
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select HDMI
 	select FB_CMDLINE
@@ -493,6 +494,11 @@ config DRM_EXPORT_FOR_TESTS
 config DRM_PANEL_ORIENTATION_QUIRKS
 	tristate
 
+# Separate option because nomodeset parameter is global and expected built-in
+config DRM_NOMODESET
+	bool
+	default n
+
 config DRM_LIB_RANDOM
 	bool
 	default n
diff --git drivers/gpu/drm/Makefile drivers/gpu/drm/Makefile
index c74810c285af..fa16d3e0bbdc 100644
--- drivers/gpu/drm/Makefile
+++ drivers/gpu/drm/Makefile
@@ -33,7 +33,7 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += drm_privacy_screen.o drm_privacy_screen_x86.
 
 obj-$(CONFIG_DRM_DP_AUX_BUS) += drm_dp_aux_bus.o
 
-obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
+obj-$(CONFIG_DRM_NOMODESET) += drm_nomodeset.o
 
 drm_cma_helper-y := drm_gem_cma_helper.o
 obj-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_cma_helper.o
diff --git include/drm/drm_drv.h include/drm/drm_drv.h
index 89e26a732175..da0c836fe8e1 100644
--- include/drm/drm_drv.h
+++ include/drm/drm_drv.h
@@ -601,10 +601,6 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
 
 int drm_dev_set_unique(struct drm_device *dev, const char *name);
 
-#ifdef CONFIG_VGA_CONSOLE
 extern bool drm_firmware_drivers_only(void);
-#else
-static inline bool drm_firmware_drivers_only(void) { return false; }
-#endif
 
 #endif
-- 
2.33.1

