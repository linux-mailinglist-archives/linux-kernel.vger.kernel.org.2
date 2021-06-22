Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF03AFDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFVHR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:17:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:15:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e33so16316197pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=hYMNCenjCAhamfzLr7D05l56NW7Op2cCAbN+Ba2rTZA=;
        b=EdhUCpG7O4Q16Ez0skkCkQdvnmN5fFwngV683KHpsxyW6XJYaMwQRjGOgfYRCCpLSK
         I+njOcG95b3SWmK3C5Uc7vUD0m/+iOeIrjCNxJvs+wxuXjTUWfyO32lPP7sDmeTManiF
         2l1g7L7d19r5vrfHerlrRI3cnE5iyQRQWs87Ov8mLkajWOrBiJ+SHb6hsFmjjqhpYefz
         DhUGoEmXcnRiamMcxKqjumtekd8zO0yMAykzFxT0e/e27k1ye9msSiBfQXESTqYNxNuD
         sjVm4XlL8itEuUlmXFbXBRZC5zZKE9ipWGz7kdtqtRMBX9aAgsJk+XpoWkm9h3S2G0qO
         72GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=hYMNCenjCAhamfzLr7D05l56NW7Op2cCAbN+Ba2rTZA=;
        b=j3c8kfluxP0Xa4il9lcxLhgzl9M3WnBy2RExSWnNDc+ntsQcB9aNn2K3yy+o+YcQO3
         DLsbcd0yfEus51vdcTp+C0rD6zh/w97saBNqjspvz3Rp4kmX/LkcLwFjceD1Pq0fK4kG
         NoxT4h+jk9NU9xi1vs5iqmbjWYFCHsBZLOmUyiAjM6yU7uZ9kV7xvr79ltaTe170DK4T
         1Upy4i5vnvezOh0f/gZFCTjehY9p9zty53yPbzSFgqB6E4EOJBI14SBtzhIBEY3IFY/k
         40XUBVStrBONp4FU541lVV5qJ3ci9ZnyCdroHfmaDzpmoP/ZPPIMkCG3txXtdkeSoedb
         B5vg==
X-Gm-Message-State: AOAM531PY5CcLXbUdJL/xzk4hNz6xZUNsFA76ZI0d+zspJ7wS76kvZnp
        55K0QpMH0cuywikAvg8ePxc=
X-Google-Smtp-Source: ABdhPJx6EN8dmlbBNZm3FErHhTPfGD/MEHfB2M3Jx4aPORDAgnRtIUsyttVHAvBAmUBtJGlGyKrBqg==
X-Received: by 2002:aa7:81c5:0:b029:2f7:d4e3:78e9 with SMTP id c5-20020aa781c50000b02902f7d4e378e9mr2303784pfn.31.1624346139636;
        Tue, 22 Jun 2021 00:15:39 -0700 (PDT)
Received: from reb0rn ([106.214.189.31])
        by smtp.gmail.com with ESMTPSA id s16sm17666959pfc.33.2021.06.22.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:15:39 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:45:30 +0530
From:   Aman Jain <ahjain2706@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] This patch replaces all the instances of dev_info with
 drm_info
Message-ID: <YNGOEugOA232znQD@reb0rn>
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
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115ae70e..639c447d9a1f 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -49,6 +49,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/radeon_drm.h>
+#include <drm/drm_print.h>
 
 #include "radeon_drv.h"
 #include "radeon.h"
@@ -308,7 +309,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_VERDE:
 		case CHIP_OLAND:
 		case CHIP_HAINAN:
-			dev_info(&pdev->dev,
+			drm_info(&pdev->dev,
 				 "SI support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -320,7 +321,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
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

