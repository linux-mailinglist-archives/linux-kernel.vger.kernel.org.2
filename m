Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7214740783F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhIKN3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF7C061797
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n5so6826957wro.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZDLKIG02S57iTgea+fzcYhjGfU+Y6z/F7xXcBTQO7sk=;
        b=khr1+Ts8uUAV2Jd72Zwr4SK9Yorkz1mUSjJI4wmtZhEBBXawqaVKi2mUoDBUEdzCs5
         KDdOeX2Ht2nVW5i6DhB6wXfibOxJc9LKrvjkGUs/DLwKLqiYjWoEcwm9FmrV5ODckZ7Z
         LwUUb05VZxasw+aDIhwZ0m7mCo/mVexR/rogfn6Odb7tIYxtC+Vd/piEs6lTP46ErDZ4
         7onOOHkx3IrF/4/ZiiKJ3gR5hJSRrYhZIWvXGBCV0M00gjP+FC/bo8vy7BsCn+n/kdsX
         BvBMYjysQHQAJq16u0QIBm+eej1y01c3wu+R6PmibgQ46rw7rYpNKgek6lBBuXRa5VOP
         VTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZDLKIG02S57iTgea+fzcYhjGfU+Y6z/F7xXcBTQO7sk=;
        b=tOmar6LpP6/nw4UiSOXVgf40VKZMXI8qvflXJXjH+RFFnbQz5TpxK5XzHN7RJiYJzK
         cZkMr6Ep2R7on2eyqHOt23zvGADKDhQoNC2DEJKyb8ztjd4P9d54Bk78gA3OtQpSuki0
         txnA2zRIZs7/sl/uZ6BdQoftO6O/Wpm/9HaKHjoVn6mMvueYL6lYlwW1ZmPZoGb+5Qsj
         GzDf2HizFRYK1F/uSgRLlLfCafCN3/y0FeX3XtpCdKX733skyT2ZESixkhsPXEUx7R7n
         N+dd4nI/aAGkvl09TYj5S5aGIFLslEe3TS7r2MQ4pa70NamnL+bFNwxOyZkKBV8bB+Ug
         KPEA==
X-Gm-Message-State: AOAM532iK+nKpnAi5RtrTsK2RDVbFTrB4Kdx0JL2nKUjfDnWQhhQLBBz
        LcYxWjcNrhLUk+f3kKaTqfk=
X-Google-Smtp-Source: ABdhPJy92YBonb8jFzGRvPw83j0lHDfOttGY3Sy8T8AOzB3IdRKycfCNEAXp5v7NS1dwWReQe9xt6w==
X-Received: by 2002:adf:f892:: with SMTP id u18mr3062773wrp.31.1631366830397;
        Sat, 11 Sep 2021 06:27:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/18] staging: r8188eu: remove unused ODM_InitializeWorkItem()
Date:   Sat, 11 Sep 2021 15:26:23 +0200
Message-Id: <20210911132635.30369-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_InitializeWorkItem() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 80c8a18f3791..ee1d2cb232a5 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -94,12 +94,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  Work item relative API. FOr MP driver only~! */
-void ODM_InitializeWorkItem(struct odm_dm_struct *pDM_Odm, void *pRtWorkItem,
-			    RT_WORKITEM_CALL_BACK RtWorkItemCallback,
-			    void *pContext, const char *szID)
-{
-}
-
 void ODM_StartWorkItem(void *pRtWorkItem)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 45caa73c0af0..6f65ae519b4f 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -96,10 +96,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM MISC-workitem relative API. */
-void ODM_InitializeWorkItem(struct odm_dm_struct *pDM_Odm, void *pRtWorkItem,
-			    RT_WORKITEM_CALL_BACK RtWorkItemCallback,
-			    void *pContext, const char *szID);
-
 void ODM_StartWorkItem(void *pRtWorkItem);
 
 void ODM_StopWorkItem(void *pRtWorkItem);
-- 
2.33.0

