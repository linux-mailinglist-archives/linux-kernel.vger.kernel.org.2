Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32A4105D0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbhIRJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244451AbhIRJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D7C061764
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso8483847wmd.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BOVmXisC9Kf5hDyUsyWtLHig+wyv3YkaN9lOjzZc4oY=;
        b=igFpQY9euEUiSZkhPcKISese4z1KDicyU9+lAWaVLPDnSKk27lPWcF1ePBJahIdsv7
         tx8HJpijUrWj96wQVRoivZKYAEqC3tb2za2wQHP8XoRuOEPWjHTvYdW8c2i500vAD1nY
         S6ztO6LAQ/DLI1w7GStA/EXHH0W1VOHH9FLdrd9zKGHYzdpbvJPC8nHCvurSWrW17q++
         kkd/wUgrjcef4qKu5WvNR8Etm3+nLL8iyQCk1ORrQvV5dmGB5rwtBgF5Tvwhskas6XFU
         GUJ0MGuj/p92Q67bXZWC2sC6Z4D96WzQ3crXXmSciGuvGIngA+9zuc64BTVtptLVIgxk
         OgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BOVmXisC9Kf5hDyUsyWtLHig+wyv3YkaN9lOjzZc4oY=;
        b=g/F6LlTBVKBNc9BTz5/2aM17uPd4RbkBAW18cGkCEZjG+A01rJq2+8OdK8dmEtDocA
         4MOGLzhzTE2uaDC0jtq4g6c8xoeFfVVi0HLA/sC/MB+TItX8HMBfsNimDX/6q8VGotSc
         329qNW0sYcumTU8WaiGUIDEg+MLRdsBK+WVfcjg3UPT1YRfYnVH4t1hLd+QeB6oxjZUn
         ro4c+oxVXjYXqBUUHFensS+Oc/RnJatj15sBwd3m0r2QVQPLgMd31kZ43QcbW00NXckh
         +JpWNLRDnT2bFRRk395ysRVev9YzFrR9/Lk0tGuhaxwKMaIIooVQM3PpL14BfzaX0+c5
         J5jw==
X-Gm-Message-State: AOAM532nvdi7WelX+2AqIqgWWp+OcDAtNIy9EpiHmZBSvR2EDsJOcjiZ
        XNBADOQ1G0Oy2ZiYY+EKFkE=
X-Google-Smtp-Source: ABdhPJxkxYgUiqcHePCYMycRsrvFc/+fQF1+klsgENTs3yBPlMZkzygOvZQcf0yKDnlz4I5U9RghiA==
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr1899552wmj.183.1631959076606;
        Sat, 18 Sep 2021 02:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:57:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: r8188eu: remove odm_ConfigRF_RadioB_8188E()
Date:   Sat, 18 Sep 2021 11:57:20 +0200
Message-Id: <20210918095727.13591-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_ConfigRF_RadioB_8188E() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c     | 8 --------
 drivers/staging/r8188eu/include/odm_RegConfig8188E.h | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 1bc3b49cd67f..5f6f0ae5196e 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -34,14 +34,6 @@ void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data
 	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_A, Addr | maskforPhySet);
 }
 
-void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
-{
-	u32  content = 0x1001; /*  RF_Content: radiob_txt */
-	u32 maskforPhySet = (u32)(content & 0xE000);
-
-	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_B, Addr | maskforPhySet);
-}
-
 void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
 {
 	ODM_Write1Byte(pDM_Odm, Addr, Data);
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
index 86b5b2d24210..634454bffdb6 100644
--- a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
@@ -10,9 +10,6 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data,
 void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm,
 			       u32 Addr, u32 Data);
 
-void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm,
-			       u32 Addr, u32 Data);
-
 void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data);
 
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
-- 
2.33.0

