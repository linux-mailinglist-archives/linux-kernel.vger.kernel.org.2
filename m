Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A7A43C3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhJ0HXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240466AbhJ0HXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635319265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gce9oVMY0zq8KDp8Fp86o9qyEruiLkF3GO4tnEsUK/s=;
        b=bzYNjeYirvdQMv4UPj14NsO27LKC5yPuIR4n7G4J2JEUnCs/873KdkWqfKdhRC2fI8qnGt
        CuyhLu0TWkA1yT4U5GOkqScIS4lhdCNIbECwPFYxuUkNiwOUEUL8bKN9aMr9h6bx4M0EMn
        6u8B8dbaBlOIyIznpg+XhZ3uOAd8B5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231--CxOP0yeNuGrYHR7PU_agw-1; Wed, 27 Oct 2021 03:21:04 -0400
X-MC-Unique: -CxOP0yeNuGrYHR7PU_agw-1
Received: by mail-wr1-f70.google.com with SMTP id u15-20020a5d514f000000b001687ebddea3so316936wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gce9oVMY0zq8KDp8Fp86o9qyEruiLkF3GO4tnEsUK/s=;
        b=01wve0Yv5+u+tQbkRqGMKRTSOLs7uKmmI5Gd6fszsFkd3ir77hDcnWPSj6fUhCcwV4
         7H9JlupwltkAPYR3MJWdBgomxJ+5NAur7Mq3Y8VYjUYGCld5nK5J08fCZi9abcFwbSnV
         +EtcvQUdZ98wO+k4jpfdda5NadA7KHTzME0FA9HBcp2VE4t0ZIea+cpkSmiXEhN64i25
         ucS8HwMCsU+ajzAcgFw2+n5X1AkBCy0ptQSn1F8P+nfVRhaOKOv6ecGnP7g9iJ/qvzIS
         ecm0LQfSVU4cF6QqeUS8uqdtFTphr5SkgTMx8eycnI1T0a911ZhHSHpzuFXzwU6LlnA7
         2VDQ==
X-Gm-Message-State: AOAM532CcY8mv4xae8YffrtfjwJim+UlqRBxTOD4UagIZE+QYcVpZxMk
        2UwGj9cx2ghKnJ62XOR1ssKvAWH0903BMyTqidnv1WePmoMWaMobqSmiZQDtluIXkTAVX2SkB5f
        w5RudqhKzZJM0W8+yrcAlDtncSjLvA5nlKKhsVvGRs7xCIUfG6wKlIohYFQGJEg+cI7GMlDIp+K
        A=
X-Received: by 2002:a5d:64ec:: with SMTP id g12mr38031074wri.140.1635319262737;
        Wed, 27 Oct 2021 00:21:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2QZl4wgpE3MGzR+UZM6wz0rF26X0UVEKfVH7zxog9HKxoxD4LYrPBsVqm8Yi97HpTOeg4jw==
X-Received: by 2002:a5d:64ec:: with SMTP id g12mr38031038wri.140.1635319262521;
        Wed, 27 Oct 2021 00:21:02 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id r1sm279858wmq.15.2021.10.27.00.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:21:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Make DRM_FBDEV_EMULATION deps more robust to fix linker errors
Date:   Wed, 27 Oct 2021 09:20:44 +0200
Message-Id: <20211027072044.4105113-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the CONFIG_DRM_FBDEV_EMULATION Kconfig symbol can lead to linker
errors, if CONFIG_DRM_KMS_HELPER is built-in but CONFIG_FB as a module.

Because in that case the drm_kms_helper.o object will have references to
symbols that are defined in the fb.ko module, i.e:

  $ make bzImage modules
    DESCEND objtool
    CALL    scripts/atomic/check-atomics.sh
    CALL    scripts/checksyscalls.sh
    CHK     include/generated/compile.h
    GEN     .version
    CHK     include/generated/compile.h
    UPD     include/generated/compile.h
    CC      init/version.o
    AR      init/built-in.a
    LD      vmlinux.o
    MODPOST vmlinux.symvers
    MODINFO modules.builtin.modinfo
    GEN     modules.builtin
    LD      .tmp_vmlinux.kallsyms1
  ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
  drm_fb_helper.c:(.text+0x2a0): undefined reference to `fb_set_suspend'
  ...

To prevent this, make following changes to the config option dependencies:

  * Depend on FB && !(DRM_KMS_HELPER=y && FB=m), to avoid invalid configs.
  * Depend on DRM_KMS_HELPER instead selecting it, to avoid circular deps.

Reported-by: Justin M. Forbes <jforbes@fedoraproject.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

This fixes linker errors found when building the Fedora kernel package
for the s390x architecture:

https://kojipkgs.fedoraproject.org//work/tasks/9849/77859849/build.log

 drivers/gpu/drm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index cea777ae7fb9..9a21e57b4a0d 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -103,8 +103,8 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
-	depends on FB
-	select DRM_KMS_HELPER
+	depends on FB && !(DRM_KMS_HELPER=y && FB=m)
+	depends on DRM_KMS_HELPER
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.31.1

