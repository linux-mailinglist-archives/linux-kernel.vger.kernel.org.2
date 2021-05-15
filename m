Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C763B381B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 00:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhEOWRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 18:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235354AbhEOWQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 18:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621116905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uj0FnsDmx2/pl2qaIJyZPTU7rem4vQ2vcjf8oF9Zpos=;
        b=dmSS3LnUouyhdhF3TJbJnwiNotAadudJ6Po8Gh+f5uYBai1M41uStWuWtFnPtoupv+Calt
        RUCrcRv5BzRraxJzqng6+t6xRZLOeezdLWfhmHoyPKKP8SNFg1sEwBVwqMqhs5YkVpHTnc
        Xk/FNylERrPPexD7ZCn6vl2Z02PhySo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-ba_Ea4rBMbmmbnEZoRwhHA-1; Sat, 15 May 2021 18:15:03 -0400
X-MC-Unique: ba_Ea4rBMbmmbnEZoRwhHA-1
Received: by mail-wr1-f72.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso1546757wrf.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 15:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uj0FnsDmx2/pl2qaIJyZPTU7rem4vQ2vcjf8oF9Zpos=;
        b=TTjcLCJNIJp9G31xyIFtYEAa/PYbbn4rdjjy0lhqVdzd7qzf8NQNX1NkP+EEfrwIu4
         ZgnhBclQbRl4l2m1Iv5gDbkzcPGh1Tc1QQ/cLmFjzqA0Lk9kqAPvzr9BUBQLdm61POQ4
         cKkL1aRIfERx4WaEQX1PUKvh1Y8+8dedCKlbPeeLWkrevO2Rw00SJ1ihLxsFDF8yo6XY
         VcEiAYmYfp+EXU4Cj9XOGdVE8bxnd3ATnZr59KImvqAIVGAw2BjtgjTt47OP7EnrQFEH
         DsZET9KMw0cf7fTz9yCr+N2D57AjgSwaVJuPPFmFz7AKX5MjVoOe4AiV/J7wML0DkgWp
         uIJA==
X-Gm-Message-State: AOAM531Cvlo35s7Q+nLOvxblp8ODknG6vMxfSr4rk70EPIZXEgnDQMlO
        EiQ0EDEnWmyBZHf9Fzk76H2/TlmXMKKnMyFqbqDpKPe9bZDRBuqnHjbHErdav1o0IphjhZpXoyq
        5d2ZfQ6JYh80xBDg059GggMq3y/yF+Gkm5h5pC6YAKhMnanX6F0PE94EQKF9z721As8kpxngiQz
        8=
X-Received: by 2002:a1c:9a4a:: with SMTP id c71mr14231687wme.136.1621116902260;
        Sat, 15 May 2021 15:15:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3DRAaEOsMocZIjWgXpJWHgD+0UBOgPkcyX7580Aop0DadT4fIcQ2zAgGZMo+oom1e3PWTXA==
X-Received: by 2002:a1c:9a4a:: with SMTP id c71mr14231663wme.136.1621116902006;
        Sat, 15 May 2021 15:15:02 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id b15sm10632945wru.64.2021.05.15.15.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 15:15:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] drm/rockchip: remove early framebuffers before registering the fbdev
Date:   Sun, 16 May 2021 00:14:47 +0200
Message-Id: <20210515221447.429779-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are drivers that register framebuffer devices very early in the boot
process and make use of the existing framebuffer as setup by the firmware.

If one of those drivers has registered a fbdev, then the fbdev registered
by a DRM driver won't be bound to the framebuffer console. To avoid that,
remove any early framebuffer before registering a DRM framebuffer device.

By doing that, the fb mapped to the console is switched correctly from the
early fbdev to the one registered by the rockchip DRM driver:

    [   40.752420] fb0: switching to rockchip-drm-fb from EFI VGA

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index 2fdc455c4ad..e3e5b63fdcc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -4,6 +4,7 @@
  * Author:Mark Yao <mark.yao@rock-chips.com>
  */
 
+#include <drm/drm_aperture.h>
 #include <drm/drm.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
@@ -124,6 +125,15 @@ int rockchip_drm_fbdev_init(struct drm_device *dev)
 
 	drm_fb_helper_prepare(dev, helper, &rockchip_drm_fb_helper_funcs);
 
+	/* Remove early framebuffers (e.g: simplefb or efifb) */
+	ret = drm_aperture_remove_framebuffers(false, "rockchip-drm-fb");
+	if (ret) {
+		DRM_DEV_ERROR(dev->dev,
+			      "Failed to remove early framebuffers - %d.\n",
+			      ret);
+		return ret;
+	}
+
 	ret = drm_fb_helper_init(dev, helper);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev->dev,
-- 
2.31.1

