Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2505C3E3470
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhHGJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhHGJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FCC061798
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so10646444wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPndQDaxyiG3jrsoqJVhXHV4P1NA8knQl6XJxmATvj0=;
        b=aBAVsiJKu6YBvtzM5OfjgZiVVE3LcvxOEaE/O16uOCvsgLgRvF59fE09xyJTFy8P9w
         C0Q5ufntaCbHm4XFNA6SRNDLh8WFHv3sCkv3rsN4qzr/P+bfmp11dTRoyZKT3puKg4P4
         4jBcn/ptwzc9URDHmN8JAo1brCORsB8a6vu7VyStZ33YXVNGAl4X3KMLWnUoofBnDixn
         H1WjtIgig4B7hRBYa8S2adZLjdHeq+3mUuxQJpjb+F3R1lyAJ4Vmcp9JoYhgF+S1Is+W
         AJXBLdVW3rW+/uNy7R156Hc7NJG9XtxJL2v7Wb44yhXz4DOucaWjxqRh4xYelsr4RaGG
         XN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPndQDaxyiG3jrsoqJVhXHV4P1NA8knQl6XJxmATvj0=;
        b=H+baxldLm1YhmflBUk5kxTwEYOc7q67RHQnmOqNrIxPLDxRhGbIFL+DHaFjPJopGvk
         6quY0YlXVqmF6JnEQ4ON48rt6xnB3r5Qz1LSwD4ogHgBpWg9jDGa8QG5UKBKPGtkZ77v
         Y9Ugeyg8TRi39U1DUaiY/yZAXROOMaSGxs2Dw+rdoctJydaXPBtVD7NIc2gfN0/a3zS7
         IRtdo113YelSBraRu6vx0iEiMHj8zusBlpg6EZmJRg6WAecAsgZBcf04fpMxUdfD8nHI
         p9sHh2Z+cUofypKoYRl8PLKWfCkRONa9oVDJ3VFMedLcTpm9hNri2L4y9xPEBQn48tXu
         RNuA==
X-Gm-Message-State: AOAM531DaVzaJh3X9jgd8sL73ZjyXdm/gh/9/z8HJxUyjELStk7Xpcak
        ZDCOxSNVhJ65YRdTZ7DxRpx7fpBPJMw=
X-Google-Smtp-Source: ABdhPJxpHXbVCiKXkXzJ5MZE2JKxiSI0SoBy3R53wX/1p84LWroJk0UEd89Uvv3nVux0fXtwFZeCFA==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr7327391wme.76.1628329701880;
        Sat, 07 Aug 2021 02:48:21 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id p22sm11062009wma.10.2021.08.07.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:21 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/21] staging: rtl8723bs: remove empty files
Date:   Sat,  7 Aug 2021 11:47:57 +0200
Message-Id: <92cba6beb56150635ab4c7985d733c93fba7fe83.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty files after function move,
hal/odm_RTL8723B.h has only an unused
macro declaration.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile           |  1 -
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c |  8 --------
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h | 12 ------------
 drivers/staging/rtl8723bs/hal/odm_precomp.h  |  1 -
 4 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index fe45200ff53c..159ca1b9016b 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -35,7 +35,6 @@ r8723bs-y = \
 		hal/odm_HWConfig.o \
 		hal/odm_NoiseMonitor.o \
 		hal/odm_RegConfig8723B.o \
-		hal/odm_RTL8723B.o \
 		hal/rtl8723b_cmd.o \
 		hal/rtl8723b_dm.o \
 		hal/rtl8723b_hal_init.o \
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
deleted file mode 100644
index 66bda505c01e..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include "odm_precomp.h"
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
deleted file mode 100644
index 12b3ca90a43d..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef	__ODM_RTL8723B_H__
-#define __ODM_RTL8723B_H__
-
-#define	DM_DIG_MIN_NIC_8723	0x1C
-
-#endif
diff --git a/drivers/staging/rtl8723bs/hal/odm_precomp.h b/drivers/staging/rtl8723bs/hal/odm_precomp.h
index 5041c9535e9a..edce506022a5 100644
--- a/drivers/staging/rtl8723bs/hal/odm_precomp.h
+++ b/drivers/staging/rtl8723bs/hal/odm_precomp.h
@@ -43,7 +43,6 @@
 #include "HalHWImg8723B_RF.h"
 #include "HalHWImg8723B_BB.h"
 #include "Hal8723BReg.h"
-#include "odm_RTL8723B.h"
 #include "odm_RegConfig8723B.h"
 
 #endif	/*  __ODM_PRECOMP_H__ */
-- 
2.20.1

