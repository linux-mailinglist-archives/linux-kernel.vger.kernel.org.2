Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095E1407844
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhIKN37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbhIKN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5AAC0617A9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g74so3115859wmg.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p01o0QxDqYd8viyOgbR3daJCfiCCbU6aM9fya+aInb8=;
        b=ZbhB65qJpxk5QG7/3h7y9Ofep5yrr9lR12BHgCRwOSLGUEdS2ULDGHLllF/W0tp884
         aFptRvCY++/Ru4n18HvuXqQo3xrw/VWoxpGHOzmE4rI0zWkA+IdAxUs1aMGgZtln04oO
         Lafz9q7qrebwVIJXv5r1pdyJnvuMouRB/s8diT79o/8SWuaBmilDgQcRwcQLLPyzaPkd
         efyPYRdny9NN3yt486xN4DigiW2tPE7+MW9KtjwqJ6RTYuv2fOCBkyi+OLcTRJEW3D+g
         IdkLG/VVnmSbWB2XQ7CJeoukUFCWPup84qDhJ17YgDsw/jYXLUAssXl2c1Ab5/kkhFZU
         S13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p01o0QxDqYd8viyOgbR3daJCfiCCbU6aM9fya+aInb8=;
        b=7N/l5J/wa1nEfb2T4XMh06mhCfqDEybhBSWSvY79s1dN8MYeGQHqUqmZMdFOLawLtu
         FJRNHvTB4dgrFLBc27nBNOeB+1HvFgOpGz/xnLKul0+Ha4gi11x+W5ggNJB9eaiteESo
         hL+d2le/4votpFSgMqJ7CRh7ZDS5APDL96WO0LDZezNk1TqF4RrImXnsVL8N1wtsnw86
         9ZD0DJd4MSGN+sl/Jxl5tf9/ykoVSGOhjFGswYL6eO2HZzB8a5MJbHZ9cRrNiGRj+8vW
         /if9P0z8J/UKkvfY0R7WT1Py3X8rLEeTnfKc9Rk/r9Nh0bBrv92CM3vFshrEbHOk8mOj
         Kk7A==
X-Gm-Message-State: AOAM532FsLJ3RN34wMSpXegMjl1OUHECrfjowutChcgaRFwtX+jyFHPW
        zCu70ALwK+KJfabLi06QSVKkKzzDTvunIw==
X-Google-Smtp-Source: ABdhPJyPwOxI1xEJQ7cieLgRwaYCH3zZ2K5q8f2kheJIoTcrluUtWO2/oOSmiAYUrsggl7dd4XI6EA==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr2741822wmh.46.1631366832803;
        Sat, 11 Sep 2021 06:27:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/18] staging: r8188eu: remove unused ODM_FreeWorkItem()
Date:   Sat, 11 Sep 2021 15:26:26 +0200
Message-Id: <20210911132635.30369-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_FreeWorkItem() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ----
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index bd9d9f832eaf..f3b6fb886550 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -94,10 +94,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  Work item relative API. FOr MP driver only~! */
-void ODM_FreeWorkItem(void *pRtWorkItem)
-{
-}
-
 void ODM_ScheduleWorkItem(void *pRtWorkItem)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 5ed4061d2f48..dd14f465e4d8 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -96,8 +96,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM MISC-workitem relative API. */
-void ODM_FreeWorkItem(void *pRtWorkItem);
-
 void ODM_ScheduleWorkItem(void *pRtWorkItem);
 
 void ODM_IsWorkItemScheduled(void *pRtWorkItem);
-- 
2.33.0

