Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C274D407854
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhIKNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbhIKN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53603C0617A8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so3429374wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toaiDr+HoqgKeTV9ngK7JxzaY+3rXFsfglZo4z2EJLQ=;
        b=V1Z/OELEeH5lxksZ0YQ+tl5MVWphV49Jo6mcyGDh2bRXGEc6zidqFSeLWUyq8ORRdF
         zw7m/2KixAY4BzbzJi2wdIU/ETH65+wO+1moMnw1gDr7yduBeSuoCO3Er/NrppDzFV+F
         z3KGBjcedwTQKCGsbEMhG0V8Ia8PosWWpyoZU2C16gwsvk0CXGku2g4rDpGlhq9kQLL9
         OE+zbL61u6U4YhJOtkyGzM6W3SyCKxfJOhZ+ZPL164aMkGchczVZ1rwuN35h1+RFwNI3
         Ljs6rX5R9glSSJNU2r7vyq47KEtur6Y8E4G8gaAQFwyPHhEEGAjFzQwnRNuguWnplqJD
         4Kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toaiDr+HoqgKeTV9ngK7JxzaY+3rXFsfglZo4z2EJLQ=;
        b=jVJpx48KXzZdJHA68d56Rg4PiQU7f2gDeK43f1q24hYr3moW7WBVbp5OnhqNYmr4Z4
         DxEJZGM6gI/YFpdF6u9PjUlpJn4b00Pb1HlSmLSjauDWS1e1BJLuyU+IbDTt0PWMWGsF
         FjQPqxYoC30JjQ0seLHqmhTEtCtDWFwwLc7oGeXDr4HoYiLlG1onbvea095vU9Cap5FW
         28TZrA595hjzKBXMllgcksgDf0V+TAzhvjqoAKy0Rq6LNZOenfvqXSLZupugEMIFrHeA
         X4hpxO3nJId5MCxXarP0br9gN1clCh1YW9uggJHKxqPwYA1Oy2pKq7Nlzgow+hyv/1Ru
         E1Jg==
X-Gm-Message-State: AOAM53238qs6uw0LRF71JnS1qtey6a+dGKOsCAxa65KBqQ3YZyOeIOu8
        GYIaKdDh/ViefeXnd9bnbsY=
X-Google-Smtp-Source: ABdhPJxVR32gp+dMlRDi+/S0MaXwrTzGbB05iAYAMdK8KDjvcQyjj6ZFuX2ol8kHcTA8hML3OP3Vaw==
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr2688909wmd.87.1631366831959;
        Sat, 11 Sep 2021 06:27:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/18] staging: r8188eu: remove unused ODM_StopWorkItem()
Date:   Sat, 11 Sep 2021 15:26:25 +0200
Message-Id: <20210911132635.30369-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_StopWorkItem() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ----
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 2ec73d998f0a..bd9d9f832eaf 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -94,10 +94,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  Work item relative API. FOr MP driver only~! */
-void ODM_StopWorkItem(void *pRtWorkItem)
-{
-}
-
 void ODM_FreeWorkItem(void *pRtWorkItem)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index febdbe7548ba..5ed4061d2f48 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -96,8 +96,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM MISC-workitem relative API. */
-void ODM_StopWorkItem(void *pRtWorkItem);
-
 void ODM_FreeWorkItem(void *pRtWorkItem);
 
 void ODM_ScheduleWorkItem(void *pRtWorkItem);
-- 
2.33.0

