Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD443FA5A6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhH1MlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhH1Mk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:40:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F3C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 05:40:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c4so5797356plh.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Zy9gkrL+JNg6cRW4icctxicuy4ZeA0G5BPg5O9lEsNU=;
        b=bwjBnqx4LEGWPO1ua6UvMdtVFJQGbeRev3+UpUcHQGbuzxEJ2ReH569Qo0oF/c+OVm
         xenJdUNtkbo4C0M4/yfDu2VMy2+SwdEYYavcPlxwWEypx+Zc9xSaUJBtWrnCTJBOYrHE
         aYprmhZnHHk0Ixd8cGEu3aJD0mBeV//r3D8VjdN2kzxSiADJzfOmEd+zZSU/m38qo/FS
         wn+lVLIPupqW6Vm1T2YwdXNQ6PJOL1f3Uia+1cly3357KNXcQ9FExymCIk/hoiviZwhw
         mTiZnqUwICb3nUIy35RvBee2EJFur70+YoecPqRtUiqOzXEghtKnzhoOQX/CukIaQttZ
         Acdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zy9gkrL+JNg6cRW4icctxicuy4ZeA0G5BPg5O9lEsNU=;
        b=NmAdW1m0qa/k34KHEvGmiwPNjg2Jr30GCLIC6XwKSBQiqVP6SxZETfbJH3gAZ+Kz0H
         1wCsE30cvfkZU2tIpuclnMGs/dpD7Z1c9Wqqk/5EVcGCrkaQHg1KDXPDAxjYA2ZC/QI2
         lor+tDozth9OVCfYQeXi9NgqIzbfMyxjG8gJzHZ0Zf3ou+tpsYCZVbHCYpqckg44PFfj
         w6LmGAMS0X4IOLgLo4lzOVur7NaHHB1UJbOIkOjJCiCq2VPuSEa0zxzWMCgognJQTlQI
         IaZg49zx7x3VR3CxhBdfftJiJtKOJIYFWUygvqSzaEqqHjZScho+ls12hbgkrq1F08AH
         c7hw==
X-Gm-Message-State: AOAM5330iI3VKk/ySAPdiyXNs1wa5dq2GehgMQcpY6Ub/VNk3pMH36ot
        XXLNIDYBPImGcL8xTqxieYf4
X-Google-Smtp-Source: ABdhPJxU5fwbsuc0VGnWo5NfZ2kAr86vT5sENmLWWX05JxS+Ngw0j7+c9e6KFEnnaOUnwcJuGMeSeA==
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id m1-20020a170902bb8100b0012da7ec3d85mr13385759pls.17.1630154407725;
        Sat, 28 Aug 2021 05:40:07 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id a20sm15116122pjh.46.2021.08.28.05.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 05:40:07 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] GPU: drm: fix style errors
Date:   Sat, 28 Aug 2021 18:09:42 +0530
Message-Id: <20210828123942.1556-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes style issues in drm_ioctl.c

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/gpu/drm/drm_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index be4a52dc4d6f..1355879ab809 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -725,7 +725,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_REVOKE_LEASE, drm_mode_revoke_lease_ioctl, DRM_MASTER),
 };
 
-#define DRM_CORE_IOCTL_COUNT	ARRAY_SIZE( drm_ioctls )
+#define DRM_CORE_IOCTL_COUNT	ARRAY_SIZE(drm_ioctls)
 
 /**
  * DOC: driver specific ioctls
@@ -834,8 +834,8 @@ long drm_ioctl(struct file *filp,
 	if (drm_dev_is_unplugged(dev))
 		return -ENODEV;
 
-       if (DRM_IOCTL_TYPE(cmd) != DRM_IOCTL_BASE)
-               return -ENOTTY;
+	if (DRM_IOCTL_TYPE(cmd) != DRM_IOCTL_BASE)
+		return -ENOTTY;
 
 	is_driver_ioctl = nr >= DRM_COMMAND_BASE && nr < DRM_COMMAND_END;
 
-- 
2.17.1

