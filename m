Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B144447F61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhKHMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239448AbhKHMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihYsTjIGFFK0sCaC1QK64DApGBNHXW4kTZaSzkld3oE=;
        b=hag+IH8jeqT4fvxA1+SGjF2rFoDUQ9bHINF/mu8dVWMsXly399KvhzYewbaGgVcW4uulQy
        O6fcJ58yuIIPAoUfjydJ93eil0obAhQ1Wf15rVtt0/552E65yHUZ4YM8sbYOrOO2ilVeMG
        gvml/mckKOcEns9xphwAfA+pvgFXlBg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-dp3ThJRmOz2j81EqheNyDg-1; Mon, 08 Nov 2021 07:16:06 -0500
X-MC-Unique: dp3ThJRmOz2j81EqheNyDg-1
Received: by mail-wr1-f69.google.com with SMTP id a2-20020a5d4d42000000b0017b3bcf41b9so3978636wru.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihYsTjIGFFK0sCaC1QK64DApGBNHXW4kTZaSzkld3oE=;
        b=ihuS3Z2bRQUEibegWuXDRprsFQJYqKbMYWSZjyNqY8xYkq22gfSTyzeCo6uCaEOYz1
         wGU4bliEF5K+WraYrquz7Kf/JSyycdesnmqRrANSSz0NmKxE91Hll13E/wg4cbA1nEYR
         Ei4Bcy0tFXfndm5ZVz+BJ4qssdKUJlt7AQpeDiBKZIhuC6PyJAu7YeLDmw3UtUw7WfLP
         mF939M2shzcdOisq9Exx1bWI6WfGiRJVmAxskwspWPw2GcBrY5/Erx0Su6TOYgpJIJ4I
         HGYNSlobq4nnj/ZZgkVvSBgHOJ5esJThYgthMCJCb2tVhzLqQN+HD0yaDX+eKmTeG9QC
         /ixw==
X-Gm-Message-State: AOAM533/dnWooWnLRy2frVJOySz/AbTHVw2E1teeT7h891dy3Cv6j28x
        Rgui8a3TVH7QHnf6X6kyn3LmzuQ8l5JVpEnFZ7mVkzTtxgg7cW40twiofRnBtE5QgZP059axPex
        OWqwdhjibgI2RyBVeBEnKKaLMTZ0lZjOYG5NeKtrEqUAdkB2SFqOtrMa/AF7npkTcujRJs9sN1s
        A=
X-Received: by 2002:adf:f44e:: with SMTP id f14mr98811503wrp.37.1636373765599;
        Mon, 08 Nov 2021 04:16:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEWXnM8yAOkIKPIbowIGiFO8iG5XYKaUBbKw2J150lfwX5eydvUmPC9K12Ua7FhaCuHRqXeA==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr98811458wrp.37.1636373765322;
        Mon, 08 Nov 2021 04:16:05 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q4sm16866866wrs.56.2021.11.08.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:04 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 4/6] drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
Date:   Mon,  8 Nov 2021 13:15:42 +0100
Message-Id: <20211108121544.776590-5-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108121544.776590-1-javierm@redhat.com>
References: <20211108121544.776590-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This relationship was only for historical reasons and the nomodeset option
should be available even on platforms that don't enable CONFIG_VGA_CONSOLE.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/Kconfig       | 6 ++++++
 drivers/gpu/drm/Makefile      | 2 +-
 include/drm/drm_mode_config.h | 4 ----
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
diff --git include/drm/drm_mode_config.h include/drm/drm_mode_config.h
index f4d407908348..4bb129040185 100644
--- include/drm/drm_mode_config.h
+++ include/drm/drm_mode_config.h
@@ -969,10 +969,6 @@ static inline int drm_mode_config_init(struct drm_device *dev)
 void drm_mode_config_reset(struct drm_device *dev);
 void drm_mode_config_cleanup(struct drm_device *dev);
 
-#ifdef CONFIG_VGA_CONSOLE
 extern bool drm_get_modeset(void);
-#else
-static inline bool drm_get_modeset(void) { return true; }
-#endif
 
 #endif
-- 
2.33.1

