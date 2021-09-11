Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A70407851
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhIKNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5CCC061764
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so3249812wml.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oj7vQGxgyu7rJkvqI51taxiHsAhwORuTJgNLc1WmslU=;
        b=ZEg13UNkd02SJOXUvwf4/AmEOTQ+WsUDP7GVt/N066AwWW7yxK/nIFhrd8DmX4baxc
         SxGFarz691D6lroJnhpRh/2DMJ1OOIAISh+x+fmsQiYrZWwxxu/79PKpIQZ3t5QansHh
         XlE0QZSRoZtK2CrgynflWvW9EB4n0/ntDbXKlOOrYfSJ0LLP0JVE/nQGaxd/lk2zTBvE
         61cmtPkHBcogYDLRq3K0lpIulcWRvkUP/XbSJwqq8AuaEiw7M/ISQG0SE2UTZBJDZUII
         PvY8D/yF/GWX2ge+3c5tQpvehZpGu4YhLH6vzyp1mzBgy17mFqcCcyfuAuOkiPyFiVR/
         1lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oj7vQGxgyu7rJkvqI51taxiHsAhwORuTJgNLc1WmslU=;
        b=VGZm3KRpZGm0s9IkcPVzFzT+RW/giI9PAinNce0nFh8Vfr0U609LSkT5kqOIs7e4Vj
         xI/rce3IEAK3QOMD1akmxzqzIUXjlHd2GS83JaEZfVOnoIbjePOJRDS7Isy+rpk5cAz2
         ZNw+LjQcKuCFG2metbbn8vKbHU12VIaYV/KjgGaMBgJr+e++YHP5/dI43F4EInfsdNPt
         UA8hf5cxulYc2EFa/kwoaFKveXEBjhsI89nrYtcjUmQ3cZEyPbiAQJZdymONr68WQeeW
         HvbVe+Xz/+ECTZlaLU52w5vCKKZLkHRmxgA9Q2PNw3JKLhfqT3EmNzkV4Lypzab0nyGQ
         8Yng==
X-Gm-Message-State: AOAM531MhRtn22ixCmQHGCnXp6H48CT73Q5m3I4yrz6T5X18V3DkVecO
        KVorj5ltQ5KYRBSpU52sCng=
X-Google-Smtp-Source: ABdhPJxgKwg/qDJLKcUXMBkvZhJ99sE2AOeXDOJNfghyagKkmCpNxtnx0sr/5eA3Nw2qAZ3Lr/idqg==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2663458wmb.112.1631366826800;
        Sat, 11 Sep 2021 06:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/18] staging: r8188eu: remove unused ODM_AcquireSpinLock()
Date:   Sat, 11 Sep 2021 15:26:19 +0200
Message-Id: <20210911132635.30369-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_AcquireSpinLock() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ----
 drivers/staging/r8188eu/include/odm_interface.h | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index c33ef4736ff6..ab9100d4b1e1 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -94,10 +94,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  ODM MISC relative API. */
-void ODM_AcquireSpinLock(struct odm_dm_struct *pDM_Odm, enum RT_SPINLOCK_TYPE type)
-{
-}
-
 void ODM_ReleaseSpinLock(struct odm_dm_struct *pDM_Odm, enum RT_SPINLOCK_TYPE type)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 9109d72915cd..7eccf459b636 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -96,9 +96,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM MISC-spin lock relative API. */
-void ODM_AcquireSpinLock(struct odm_dm_struct *pDM_Odm,
-			 enum RT_SPINLOCK_TYPE type);
-
 void ODM_ReleaseSpinLock(struct odm_dm_struct *pDM_Odm,
 			 enum RT_SPINLOCK_TYPE type);
 
-- 
2.33.0

