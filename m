Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D755407842
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhIKN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EE6C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so6916894wrb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJCyfTokEhHfgTnnxy1BvdGBBwQkrjyqqQqN2UOJMyQ=;
        b=SAyvh4z1InkWKE5hDuLpivAu1WOHSDW8H172/yWzZDCRiyycHfBI06oM6n5JuDcZiT
         mV2iimi4ahD5sxTdJXPINhIv8s55Q6Hynv0Nt0GzuoerIO3aybPZI+ueW9rrdKkXUFqG
         c44DH3AcY5lWifwbvHbg7bMao28nMoKNx6ryKrI3nkJRjNHc1otUzkuwkf9CIJ4UoqZb
         B2YxZv90vrHrKMtCuciVT1zXLmijkmvKDjsCjZqHKi65HIUI+vPciNn4cz2pul6wDC/C
         TDwT5KZa04OOccSgH9bCC9wlSYgpfWpe7Fzf2u6rs1aLR2UABrXmsRxdctzIlMm2XdFR
         2vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJCyfTokEhHfgTnnxy1BvdGBBwQkrjyqqQqN2UOJMyQ=;
        b=NUomkjPXxUkVkFy4jvkkiEeOUHZ7DHHaAABlUm7uPZoVZpfIMMzsvPo8VcumIuYl9o
         aYoBVKucQL0zMhh3XXy3u3OXXrhQDDdgjrAKnpwZ4GiMNKqXL+i/O1cqBrPfw56Nmf7W
         RiTA8eWtGlgp4gDPyXCE31clsFJRRICCEQvbfZ1lIJAPAb/m47WwG7hwr6wGPMzAYGSI
         Tu093Z6wLO1ZwU4GEXRY4goqC2a8u4JCtvNygz4iiX5Us7nhFuAu1P+/WUWX5xnaMT4u
         O0uKMULpB0G+z9inqiVwWgdAUyU5nyIxLBFc2ifZ0jXzMxpESndcy6aG4KkbA51NYTA/
         cjew==
X-Gm-Message-State: AOAM530sqzwYoid38kd6WoFTvaB+Vu3xfRgGxief7aR28tqpmW4tvYlJ
        bf5ql86o96FgeaHft+K8tA9rmpUGOyishQ==
X-Google-Smtp-Source: ABdhPJzvJD5tsyX1j9spggdroPR2PXRbz7fBRJoh/OZZGaC2Oo2Efg5Zk/zF3+SEl2EQzNh3iexbjQ==
X-Received: by 2002:a05:6000:34a:: with SMTP id e10mr3212280wre.421.1631366827593;
        Sat, 11 Sep 2021 06:27:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/18] staging: r8188eu: remove unused ODM_ReleaseSpinLock()
Date:   Sat, 11 Sep 2021 15:26:20 +0200
Message-Id: <20210911132635.30369-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_ReleaseSpinLock() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 5 -----
 drivers/staging/r8188eu/include/odm_interface.h | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index ab9100d4b1e1..d45eacabfbd6 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -93,11 +93,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 	return !memcmp(pBuf1, pBuf2, length);
 }
 
-/*  ODM MISC relative API. */
-void ODM_ReleaseSpinLock(struct odm_dm_struct *pDM_Odm, enum RT_SPINLOCK_TYPE type)
-{
-}
-
 /*  Work item relative API. FOr MP driver only~! */
 void ODM_InitializeWorkItem(struct odm_dm_struct *pDM_Odm, void *pRtWorkItem,
 			    RT_WORKITEM_CALL_BACK RtWorkItemCallback,
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 7eccf459b636..4769087b9412 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -95,10 +95,6 @@ void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length);
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
-/*  ODM MISC-spin lock relative API. */
-void ODM_ReleaseSpinLock(struct odm_dm_struct *pDM_Odm,
-			 enum RT_SPINLOCK_TYPE type);
-
 /*  ODM MISC-workitem relative API. */
 void ODM_InitializeWorkItem(struct odm_dm_struct *pDM_Odm, void *pRtWorkItem,
 			    RT_WORKITEM_CALL_BACK RtWorkItemCallback,
-- 
2.33.0

