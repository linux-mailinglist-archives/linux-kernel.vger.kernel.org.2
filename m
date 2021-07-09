Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF453C28E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhGISMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGISMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:12:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F0C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 11:10:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so6505921pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OS58rij80ElucW0PY66L5D8ExybPJH/1VgMC6duZHlU=;
        b=go5RVxO2kU2+etrFfSYo+VyLT/24peH+yKtEuAV1pK4ASOt71ljZc69/msO+AOs6i7
         fOyDdnkdLvrsk3LrtdRRlWFx3uTOD0xyo/L732NKQTseg8H7fmz5D82oLFNtGQIfcnK4
         JhjVMtJB2lp2IQnICyNIWd4Dug0zI5FsholSkTe+T90w6bO02wObP/MQXq5GOKxqxP0J
         K8YFOnkIZXZBItWwjYw+Li6GoBsR5yyMOggOOBa3Ick9gTbzVAsGG7w8+3CaMnZryQWr
         PnSgP8cfXhax6lyhulFiDfQV4rOYiAnKeXt/+7Y8BMyIfZeJBvxxivt8hIthzRutqZ5t
         FsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OS58rij80ElucW0PY66L5D8ExybPJH/1VgMC6duZHlU=;
        b=SSwN0/0I6jog/QS59rKys97/tMH70p4bO4FRJG/hN9EpG/LPpAJJPgxJOEGHkJDliF
         QspgnFoHgwVCCCwdC3DH989GgBMFgYwf1yHgxT8ooouuT8Qz6VBPGoCkGR189AtXewUs
         z0FJFztN0Ssc3hipP24He/G7MXxI2AjlMzU3XPGN3w8kgDK4GjXroSaWvIEaFQQW1FSB
         gcfFqAptqZvbMuReL1IKNKNKT3tfceM1kc+es6mVczvXXmXQ5n5MvplAeVg1ije2p90W
         rjhMHId6Ytg8wNXCslO3sr614zbSLDqhzetxxAJ7wmdSLIPZAge7HIiMDWRaYfDcdFgb
         BU/g==
X-Gm-Message-State: AOAM533u9JkBkL97Cs9dWaAXKdairMAu38ngrytXz+LWnaeO2ag96ZuS
        qyXKSeaNnvj6L2R6Pq9mec0=
X-Google-Smtp-Source: ABdhPJyEQMTdU+dbkSplr0x7yUpZrsCTQPP9k0UdRh8tLZ+tNWCO0MuXx7Hu1OoAykafDNxJuPcFXw==
X-Received: by 2002:a17:90a:b00a:: with SMTP id x10mr176749pjq.77.1625854203158;
        Fri, 09 Jul 2021 11:10:03 -0700 (PDT)
Received: from tong-desktop.local ([2601:647:4200:13::844])
        by smtp.googlemail.com with ESMTPSA id b65sm7003737pfa.32.2021.07.09.11.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:10:02 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v1] fix vmwgfx compilation error due to a missing include
Date:   Fri,  9 Jul 2021 11:09:43 -0700
Message-Id: <20210709180944.2533114-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes vmwgfx driver compilation error due to a missing include

drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_init’:
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:678:8: error: implicit declaration of function ‘ttm_range_man_init’ [-Werror=implicit-function-declaration]
  678 |  ret = ttm_range_man_init(&dev_priv->bdev, TTM_PL_VRAM, false,
      |        ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c: In function ‘vmw_vram_manager_fini’:
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:690:2: error: implicit declaration of function ‘ttm_range_man_fini’ [-Werror=implicit-function-declaration]
  690 |  ttm_range_man_fini(&dev_priv->bdev, TTM_PL_VRAM);
      |  ^~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 6f5ea00973e0..6eb93aa2f311 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -37,6 +37,7 @@
 #include <drm/drm_sysfs.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_placement.h>
+#include <drm/ttm/ttm_range_manager.h>
 #include <generated/utsrelease.h>
 
 #include "ttm_object.h"
-- 
2.25.1

