Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6B64480D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbhKHOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237676AbhKHOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636380430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPjF0q/sVEPX9a+zAsNTT+5st42KW0ioDba0FRy7So0=;
        b=BA9yDJrynNZMfXjo7k/zZdd4RFy0dYFIvJldlZKKKvXpgBuSjA91GrIjZ2u0a4Tr36QSiD
        HwIox0A5uOxlIFfM3eEPgYEq5ssVWIu5zbOwNUcLicR6UGQtNE0Ia7A8S+vQ6qyx0qcxmg
        0DLH7W9l+hpynxI458JwxkPFn2uMSeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-EogNyic4MD22yMtRdeM-VA-1; Mon, 08 Nov 2021 09:07:08 -0500
X-MC-Unique: EogNyic4MD22yMtRdeM-VA-1
Received: by mail-wr1-f70.google.com with SMTP id j12-20020adf910c000000b0015e4260febdso4054882wrj.20
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPjF0q/sVEPX9a+zAsNTT+5st42KW0ioDba0FRy7So0=;
        b=k6DbfZzkTxolv+l+7Ftfd1tyH9z+PTUlEG9IZuNJAPSsnoCkPhBKQxd0jP5Ur2298z
         v0zdUGM3CPzgLlHSc6xSXHap9rhG45LagQMmDpJINS+NxXmiTJCZ3FwYRT2jod+3Xg8c
         4dm6cEdMdhmghjeWscoVY/yE9LqmU+l9PAHlJqKMCKqtlZAcSVR/YkWe037GQBHMm1/a
         p6prDGRx059BdA2iHyKc/SH0FB5DCseCdLaN6lSA28huWO9mDyQ1L3MeNCxWPUQY6W4A
         eJft5mfuTT6KgslsTtw1UuDXkqjO+KCLtaaG6vX29BaYFh4V3cIEcF3Xhpde/zl6h21F
         llxA==
X-Gm-Message-State: AOAM5312d10JSpyo0yhTc/Wl/Dfu39FnUfTMJ6Urz0qMi8aX+6xDMiBt
        3QtzKXuavwh0lJQQaJaeS9JrjP01vcP/WODxvu7U1rca/8auVLoIgjJ5DXQbo11zOaPecq6/DXh
        3EvZjDnCWJgp8DLdROOxPCuYaMcqrmf1CyPgz16q4eX1nNtMre1kfjIfz/Zaxd1U00iFpc5FZYG
        4=
X-Received: by 2002:a5d:6481:: with SMTP id o1mr48028052wri.305.1636380427646;
        Mon, 08 Nov 2021 06:07:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpZwgscwTuqbX3FM0P7plr2LbKZCfnFDWGyt9ZGyuhmO5dPrrJxu4VvdTcsUZXQXtqpR3eCw==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr48027995wri.305.1636380427367;
        Mon, 08 Nov 2021 06:07:07 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m14sm10081696wrp.28.2021.11.08.06.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:07:06 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 4/6] drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
Date:   Mon,  8 Nov 2021 15:06:46 +0100
Message-Id: <20211108140648.795268-5-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108140648.795268-1-javierm@redhat.com>
References: <20211108140648.795268-1-javierm@redhat.com>
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

