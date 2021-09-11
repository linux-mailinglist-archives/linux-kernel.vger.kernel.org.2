Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449BB407850
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhIKNaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73527C06179A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so3249955wml.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POwxzOGbaxERw6tzIml22WJjBb0QN0x5uUL6a441S9o=;
        b=n+Okq3Snw94UeY/WLWGfGkE8kMNRH7WvKolSF69MPAa0vsclEHzWCtIzk8uKSjAx0q
         rckB2Cy9dI5gJYoY0YifbIiE7GqZf3iUX17EBndgagjQmq+EuZUidP2GdVvtsaDKU2Ym
         DuQLjuJO3Lmagz5CT6jG7Ex6Iel2wR3RAI3H45lc9o2qBIKWxHzLVpeY5T952JDl4x0y
         ZrgTk9ZhVSpa27StwB7NTT4WKx1IJR6qLAegfz1gjs+Sd9r6NMDfwFwtyqGBldQjFjcc
         ktGQTwrDjEE8s+UxhwDSrzA0L1m7Vm73Gn0858metk7MwZP7+Bcz9A5Mpei61+3zHdB9
         j2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POwxzOGbaxERw6tzIml22WJjBb0QN0x5uUL6a441S9o=;
        b=zYEc77LJGqUe55L3xi1tzWyaf/9UphbmnHpeBbdFoxL8dpu+1pxPvvaq/lbrFX93H8
         4UxnmTcQJL6LjtduW0modBCodyzrhtmj0wLI+teMX6HX8HxaXOJ+dfHZ0HX7EwUVVsmA
         dVG0VeYxCOlXPVn/VanGBkMrW0AISSBvsIlfMKUSbKPzJ3hUJHV99mo5VxbQheEz2oYm
         IT3J6JjC2trljeoCeMafBQ6MVYcpB8PaFxCUJxJt62udTCVkCnHQNdKd8j7zx2zV7rHA
         j4bPZpeyq1668PB3k12UhyNXfSgBmKKWXw5vDROWY7/BAsbSUWCUEwbN/eTLfNJRsqEd
         EoUQ==
X-Gm-Message-State: AOAM531+bdSUBCR6sJnJPQLYU9FhYRss4OLL2wiBlgnJ4zH1vIddp//U
        QZcUvJj7FoI7bD1aTEFAsvIWuF5Tb5xg6Q==
X-Google-Smtp-Source: ABdhPJwq31v9puiy3U7yJRfW4uu/9kvxeCJjAKhpobDzq2HnHmOAwjfQcVgqHLJtvR+qb+o1p6rMnw==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr2720287wmn.176.1631366831145;
        Sat, 11 Sep 2021 06:27:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/18] staging: r8188eu: remove unused ODM_StartWorkItem()
Date:   Sat, 11 Sep 2021 15:26:24 +0200
Message-Id: <20210911132635.30369-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_StartWorkItem() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ----
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index ee1d2cb232a5..2ec73d998f0a 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -94,10 +94,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  Work item relative API. FOr MP driver only~! */
-void ODM_StartWorkItem(void *pRtWorkItem)
-{
-}
-
 void ODM_StopWorkItem(void *pRtWorkItem)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 6f65ae519b4f..febdbe7548ba 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -96,8 +96,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM MISC-workitem relative API. */
-void ODM_StartWorkItem(void *pRtWorkItem);
-
 void ODM_StopWorkItem(void *pRtWorkItem);
 
 void ODM_FreeWorkItem(void *pRtWorkItem);
-- 
2.33.0

