Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAE381D57
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 09:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhEPHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 03:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233930AbhEPHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 03:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621151332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xMEHr3txinobPMiklkheMH3hCxm7Pua65lCR30BLejs=;
        b=MkpEm6VDbxNPa1SDlFZvFgTtpYYLBeSKaigAj3ixrtUhrne1y/KL2/LEg3gWpRiABCaZlA
        x0D54YTK+pRvdUXmrjaUyEfoVAd87KFrqZsgywfZAEBmRgDt+MA43sye53syT1Fb5YYNWT
        03lJyJMGGtebUfX3sz4qF/XchZqd4U0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-JFjkYlrHMDekWSt1rGqwXQ-1; Sun, 16 May 2021 03:48:50 -0400
X-MC-Unique: JFjkYlrHMDekWSt1rGqwXQ-1
Received: by mail-wm1-f71.google.com with SMTP id b16-20020a7bc2500000b029014587f5376dso2554851wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xMEHr3txinobPMiklkheMH3hCxm7Pua65lCR30BLejs=;
        b=KqgjaCZXMpG69woaJgjuea59j59XUtkUUUXQjchnsUmpaZ7siWlAv01nkdI30LyP8d
         tsNz+n50MLQAu1KR3Yol3xIX9HXFVViWuQySh468QqibS/r9PmdloWy99Du9W/i5C5V6
         SIgy+Ra7R7vKFt2RCXDIaJLkUAz468r2k0WGgnclv5abkzPcpsrWz91NIAY52yRCvU93
         xay3z7e1CpHouO4yfTaxPUmU0QuHDIPE+3oDPLwItDesuN4AA8xefvGuKbw27F6eFSfl
         QR02/lfiLu0iQFEZ5YSHiyKlE7f+I0nwAie8LxzZqeThusVvO66Dk2VeINrybJfuE+c6
         U7Ww==
X-Gm-Message-State: AOAM532Hcefb2RJQ9G8/5VusmIRp9YTAPEHt4QpNPiju51EY42nYEIBX
        JMQnN6dnyQLqpi4ZDiex4l7fcPUOFa3vCId+hb/AOa5fydSxKT2BKDjISroFiuOe1UKFtxuUTsc
        wavhGKHw8bizvhl/nW4YEA1ClQSKy5OQSpCMPE1z6+RCe8gKJA1YtHXkvLBx/4shmYN0a5M+9GL
        c=
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr57335900wmi.104.1621151328891;
        Sun, 16 May 2021 00:48:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRkzwXMjfjJhlzuX9LLoPTb6ClHg5TLaCME19q70w8+F6ekQW/0awjb4A7BinEgHO2w+/92g==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr57335881wmi.104.1621151328701;
        Sun, 16 May 2021 00:48:48 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o129sm16643610wmo.22.2021.05.16.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:48:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2] drm/rockchip: remove existing generic drivers to take over the device
Date:   Sun, 16 May 2021 09:48:33 +0200
Message-Id: <20210516074833.451643-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are drivers that register framebuffer devices very early in the boot
process and make use of the existing framebuffer as setup by the firmware.

If one of those drivers has registered a fbdev, then the fallback fbdev of
the DRM driver won't be bound to the framebuffer console. To avoid that,
remove any existing generic driver and take over the graphics device.

By doing that, the fb mapped to the console is switched correctly from the
early fbdev to the one registered by the rockchip DRM driver:

    [   40.752420] fb0: switching to rockchip-drm-fb from EFI VGA

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Move drm_aperture_remove_framebuffers() call to .bind callback (tzimmermann).
- Adapt subject line, commit message, etc accordingly.

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 212bd87c0c4..b730b8d5d94 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/iommu.h>
 
+#include <drm/drm_aperture.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
@@ -114,6 +115,15 @@ static int rockchip_drm_bind(struct device *dev)
 	struct rockchip_drm_private *private;
 	int ret;
 
+	/* Remove existing drivers that may own the framebuffer memory. */
+	ret = drm_aperture_remove_framebuffers(false, "rockchip-drm-fb");
+	if (ret) {
+		DRM_DEV_ERROR(dev,
+			      "Failed to remove existing framebuffers - %d.\n",
+			      ret);
+		return ret;
+	}
+
 	drm_dev = drm_dev_alloc(&rockchip_drm_driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
-- 
2.31.1

