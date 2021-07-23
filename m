Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD033D4313
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhGWWGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 18:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231954AbhGWWGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 18:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627080396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RiCWPDLq/IwjIj91kkA7Pcr42xwKm/fhjaL1ZW3wKCE=;
        b=Gv/hblwWtWiwQMcOpy0teZA+flNgLcWhgGwRa3CA2D1cUGd2dWEpEL/7qRC7Q5kkdh26KW
        qRN5FhbMmBtY3i0Zdc9h7UFH5ncMbXTNUmYi+hUqmpMz/C20UOyLG/pifyyBT8XLBnQeIb
        StH8YNBX75kzPpmLwv3BfvHkLnPUP2g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-mDsdXVSANk6DK-Fu-eDNFQ-1; Fri, 23 Jul 2021 18:46:34 -0400
X-MC-Unique: mDsdXVSANk6DK-Fu-eDNFQ-1
Received: by mail-qv1-f70.google.com with SMTP id t18-20020a0cd4120000b02902fbda5d4988so2713174qvh.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RiCWPDLq/IwjIj91kkA7Pcr42xwKm/fhjaL1ZW3wKCE=;
        b=Z4Eki3909sZT/yELw3+vbP9KgZEBguGDhj+3N682ZfHbgsgkVx72FiqEi4IN/huqJd
         q35aJQ54XuaLAN7/UJsKWFkmLnW+3UgYFyMdfOhAofDNogJXQaP3zmxQi5WoL9k/kEmn
         jc1JVk/YvdJPpwDTQLQUd/eaIF7mxoZr9HAmILbbVfzWpFxof4pGM3mXKE3wu8jrZ+Cq
         f9WFpMv/dgvM7a2KdtJQuW4H3FLeEKf7OUACuOKrak9EEsCVi7JVJpdJnsgFerR7CZGB
         xIgnqvgS3X3NKqBaF6K1GF+Gt6XF0/VtpkZ+pVxE5/cRrmJaXB+t6/XnNvljst0XqX2j
         jWug==
X-Gm-Message-State: AOAM532KOehZt1FU07YCswSCWmt4CDpwqgH8hA+3IFwICrfhQry497wg
        vJEefa+KdilyP18815lcvpea1Rgy6Mz0kBXrSRSXMGVFtQemDd1o9X9ml8rfhgxIEzlczaSvlmT
        /GahFSIgBOyUgkI5g8286SQWlnrQfCjsLkLRrHCs7XGz5EU4RWwfI68bMwtkYfolmwjPnrf41e6
        s=
X-Received: by 2002:a05:620a:1242:: with SMTP id a2mr6809436qkl.443.1627080394329;
        Fri, 23 Jul 2021 15:46:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9opdH/xj/91JB/lCrSTujZ8qm/Lf4qAgq6FcaqUeEky+BnrkB+7w88P4OSpPcjO9aAxJF9A==
X-Received: by 2002:a05:620a:1242:: with SMTP id a2mr6809411qkl.443.1627080394059;
        Fri, 23 Jul 2021 15:46:34 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f10bb48.dynamic.kabel-deutschland.de. [31.16.187.72])
        by smtp.gmail.com with ESMTPSA id f13sm1536040qkk.29.2021.07.23.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:46:33 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, Arnd Bergmann <arnd@kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] nouveau: make backlight support non optional
Date:   Sat, 24 Jul 2021 00:46:17 +0200
Message-Id: <20210723224617.3088886-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past this only led to compilation issues. Also the small amount of
extra .text shouldn't really matter compared to the entire nouveau driver
anyway.

Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/Kbuild              |  2 +-
 drivers/gpu/drm/nouveau/Kconfig             | 13 ++---------
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 ----
 drivers/gpu/drm/nouveau/nouveau_connector.h | 24 ---------------------
 4 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
index 60586fb8275e..f6957e7ad807 100644
--- a/drivers/gpu/drm/nouveau/Kbuild
+++ b/drivers/gpu/drm/nouveau/Kbuild
@@ -49,7 +49,7 @@ nouveau-y += nouveau_ttm.o
 nouveau-y += nouveau_vmm.o
 
 # DRM - modesetting
-nouveau-$(CONFIG_DRM_NOUVEAU_BACKLIGHT) += nouveau_backlight.o
+nouveau-y += nouveau_backlight.o
 nouveau-y += nouveau_bios.o
 nouveau-y += nouveau_connector.o
 nouveau-y += nouveau_display.o
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 9436310d0854..2e159b0ea7fb 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -7,14 +7,13 @@ config DRM_NOUVEAU
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_TTM_HELPER
-	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
-	select ACPI_VIDEO if ACPI && X86 && BACKLIGHT_CLASS_DEVICE && INPUT
+	select BACKLIGHT_CLASS_DEVICE
+	select ACPI_VIDEO if ACPI && X86 && INPUT
 	select X86_PLATFORM_DEVICES if ACPI && X86
 	select ACPI_WMI if ACPI && X86
 	select MXM_WMI if ACPI && X86
 	select POWER_SUPPLY
 	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
-	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
 	select INPUT if ACPI && X86
 	select THERMAL if ACPI && X86
 	select ACPI_VIDEO if ACPI && X86
@@ -85,14 +84,6 @@ config NOUVEAU_DEBUG_PUSH
 	  Say Y here if you want to enable verbose push buffer debug output
 	  and sanity checks.
 
-config DRM_NOUVEAU_BACKLIGHT
-	bool "Support for backlight control"
-	depends on DRM_NOUVEAU
-	default y
-	help
-	  Say Y here if you want to control the backlight of your display
-	  (e.g. a laptop panel).
-
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
 	depends on DEVICE_PRIVATE
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 093e1f7163b3..b30fd0f4a541 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1712,9 +1712,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *sta
 	struct drm_device *dev = encoder->dev;
 	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_connector *nv_connector;
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight;
-#endif
 	struct nvbios *bios = &drm->vbios;
 	bool hda = false;
 	u8 proto = NV507D_SOR_SET_CONTROL_PROTOCOL_CUSTOM;
@@ -1790,12 +1788,10 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *sta
 
 		nv50_audio_enable(encoder, nv_crtc, nv_connector, state, mode);
 
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 		backlight = nv_connector->backlight;
 		if (backlight && backlight->uses_dpcd)
 			drm_edp_backlight_enable(&nv_connector->aux, &backlight->edp_info,
 						 (u16)backlight->dev->props.brightness);
-#endif
 
 		break;
 	default:
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index 40f90e353540..88ed64efe9e9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -45,7 +45,6 @@
 struct nvkm_i2c_port;
 struct dcb_output;
 
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 struct nouveau_backlight {
 	struct backlight_device *dev;
 
@@ -54,7 +53,6 @@ struct nouveau_backlight {
 
 	int id;
 };
-#endif
 
 #define nouveau_conn_atom(p)                                                   \
 	container_of((p), struct nouveau_conn_atom, state)
@@ -133,9 +131,7 @@ struct nouveau_connector {
 	struct nouveau_encoder *detected_encoder;
 	struct edid *edid;
 	struct drm_display_mode *native_mode;
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_backlight *backlight;
-#endif
 	/*
 	 * Our connector property code expects a nouveau_conn_atom struct
 	 * even on pre-nv50 where we do not support atomic. This embedded
@@ -220,29 +216,9 @@ nouveau_conn_mode_clock_valid(const struct drm_display_mode *,
 			      const unsigned max_clock,
 			      unsigned *clock);
 
-#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 extern int nouveau_backlight_init(struct drm_connector *);
 extern void nouveau_backlight_fini(struct drm_connector *);
 extern void nouveau_backlight_ctor(void);
 extern void nouveau_backlight_dtor(void);
-#else
-static inline int
-nouveau_backlight_init(struct drm_connector *connector)
-{
-	return 0;
-}
-
-static inline void
-nouveau_backlight_fini(struct drm_connector *connector) {
-}
-
-static inline void
-nouveau_backlight_ctor(void) {
-}
-
-static inline void
-nouveau_backlight_dtor(void) {
-}
-#endif
 
 #endif /* __NOUVEAU_CONNECTOR_H__ */
-- 
2.31.1

