Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA83F97D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244804AbhH0KG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244708AbhH0KGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p4aikmi0g6nX7SuLm/Bk6aLBr61zFNCjsy8EnVkGMSU=;
        b=gjSHhqy3Vn41gF5/dSYnOI1kao7HgOOJRZSMePSoYIGLhNRArnCedE6XMVtvqytsu+LkBQ
        Kiw02mc9x6ZmsiIMjzjbS3JS+GMLnN8IO80nYV8YFaFyC/JCISR7LTEWmICNAIXwWcAbaE
        HQ5Wgy358MUsV2lUNYIA5a/ojffhdmQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-1cl0p8uXMv6DjR8epJlRlw-1; Fri, 27 Aug 2021 06:06:02 -0400
X-MC-Unique: 1cl0p8uXMv6DjR8epJlRlw-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so1898006wmj.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p4aikmi0g6nX7SuLm/Bk6aLBr61zFNCjsy8EnVkGMSU=;
        b=amwJ5iVeKtqCZ2oSWtfoMeSz/4zqp4idq3DjJS7KWZ5NBjtPloCmcpEli8XBn/rlTF
         Uuml59Xqw34N2YH1Jk0Jqw3jg/ibFmNl9Qfyyr+MeyZrN9nxXjdHG6I6qiEfIOTAHOv+
         3R5YKWkbMBBFqV1tDhqaEldr1uyjik7eNT4EmyF1sKMmDdBxubj/U2EBXNZAFjJ7Ykdb
         rguHaEJohGvcJ0STFi0tmWSpP+6AMsYW13g4koxrxVhjSOEUz3z/vkZM23LnsUDzxVx0
         kua01xE/i4dp0pZ71looG7eq2e6uZwkfR+u1komsCO2sWPyE6bU1HFNOz1kM0X8AOxfJ
         J2Ig==
X-Gm-Message-State: AOAM532v1HsglgLeVSsv+UOH6al3ffcbOERa+htXu7inpmYX42VA+Kss
        aVXnZ829WsphCUMV8DIbra1fdLbWeGeTbGgcP2liaQ8UrZJdLnPmSpmCw99lR4/3seeT3S0MYSo
        284+QuiV2rTQXUNJ+eCNbPpo8Wzu3LKPcNqy4kn8VmPxDuIXHfHAHmsWGosKDLKClrCC7U/AbxG
        Q=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr13186012wml.47.1630058760694;
        Fri, 27 Aug 2021 03:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweQKtGcTVQCT5oK+T9jojfllLFKvn1d+zXGWWo3Yar8zcxTOTUijovtCiHgZqBsq9Js5k20w==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr13185978wml.47.1630058760467;
        Fri, 27 Aug 2021 03:06:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d28sm4834317wrc.4.2021.08.27.03.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:06:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 4/4] drm: Make fbdev emulation depend on FB_CORE instead of FB
Date:   Fri, 27 Aug 2021 12:05:57 +0200
Message-Id: <20210827100557.1578746-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the fbdev core has been split in FB_CORE and FB, make DRM fbdev
emulation layer to just depend on the former.

This allows to disable the CONFIG_FB option if is not needed, which will
avoid the need to explicitly disable all the legacy fbdev drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8fc40317f2b..7806adb02f1 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -103,7 +103,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
-	depends on FB
+	depends on FB_CORE
 	select DRM_KMS_HELPER
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-- 
2.31.1

