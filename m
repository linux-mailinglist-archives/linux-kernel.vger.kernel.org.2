Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEF3AFCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFVGJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:09:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:07:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m17so6698456plx.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 23:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=C2BsSCuEEmRCddtgAxqVh2meXkFZVrya2AaC0x0Wyy4=;
        b=Kx/SxTULRn3X9l2oxV9aWKSNrYRWKoHZPeqn9kHpKZsngkOXClFw+XgAcJfoStI/dh
         MYzvkWlGqOAhg6IriLEsc36iWmI1OLZ3VPy94jdPZu7Jn6PAep8co3L8dOjzf53UTzQb
         MNXVmFefn1Z37CkOwRc0CcyhK/CPiXAPUsCL9lU74gnnn8LfDOLUQzTs1lCX8xTKC4qE
         09kmWA629UUWajWfU4fRdtxeQy4mRsvAPOvN4nm0zrZRNNwVP+X7bxCUQD8RrDez5YXV
         eIgWnN/Jvj/xnDcqaJdC6isoDvhoWMFulADt8+8BfKrKYK5nCnawtPwhDJuVnZcbovXe
         07Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=C2BsSCuEEmRCddtgAxqVh2meXkFZVrya2AaC0x0Wyy4=;
        b=FoYAyUzL5K+RFPnwLAa6vRytlLc1VfHfi2+ier72G31r9qksMtGkQKe62yLf4x9NyD
         WMfdWq2S2oiw8XqGtreSwfPzYwgx51FbqpY7WLxs4XJLRCPoxEDqvP8PmYx/9dKrbOUa
         z2f0NU1B1cZfBkOifAUg993UBMGDSHRGbdVrzRg+nS8IxLvQiyt7+e0PQHnZ3KdplROf
         DW35GhO6h+IZrjxGflWUpluBNkE2zDRA4xM1r6XrQnbZJGoMy3AKPOxfL0MHC+sFCkGf
         m5mrQBmZVjtTnSosNCm6zPDHBc/ukFXw3gRB+4R+yVUG3peFUDZzQgvKavYiIug/44mS
         jASg==
X-Gm-Message-State: AOAM532F9Q74+NKZwnbjomtpy/+k4GLgjJEO0ybOhuWsBkc+rUiL9Hp7
        YbXsL2WW4Me/IZEUxMzZ++8=
X-Google-Smtp-Source: ABdhPJx8l2KGaKCkgy34p/BeK5Eyz7A6wHlEC6idFHdIMX3GIUtiOIGgLvMBHUZKYoGYExuIAoD4+g==
X-Received: by 2002:a17:903:2c3:b029:11b:cbb9:edfb with SMTP id s3-20020a17090302c3b029011bcbb9edfbmr21135204plk.12.1624342036348;
        Mon, 21 Jun 2021 23:07:16 -0700 (PDT)
Received: from reb0rn ([106.214.189.31])
        by smtp.gmail.com with ESMTPSA id r128sm5272007pfc.138.2021.06.21.23.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 23:07:15 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:37:06 +0530
From:   Aman Jain <ahjain2706@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] This patch replaces all the instances of dev_info with
 drm_info macro
Message-ID: <YNF+Cr9wHupnt3Za@reb0rn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a driver has multiple instances it is necessary to differentiate
between them in the logs. This was done with dev_info/warn/err since
DRM_INFO/WARN/ERROR don't do this. We now have drm_info/warn/err for
printing the relevant debug messages. Hence, this patch uses
drm_* macros to achieve drm-formatted logging

Signed-off-by: Aman Jain <ahjain2706@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115ae70e..75e84914c29b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -308,7 +308,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_VERDE:
 		case CHIP_OLAND:
 		case CHIP_HAINAN:
-			dev_info(&pdev->dev,
+			drm_info(&pdev->dev,
 				 "SI support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -320,7 +320,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_HAWAII:
 		case CHIP_KABINI:
 		case CHIP_MULLINS:
-			dev_info(&pdev->dev,
+			drm_info(&pdev->dev,
 				 "CIK support disabled by module param\n");
 			return -ENODEV;
 		}
-- 
2.30.2

