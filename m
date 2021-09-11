Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC2407849
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhIKNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbhIKN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A498AC0613A3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i23so6867376wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ow6H/nlu5TCk7P1uMwYJuJQQnJkQmKfjZydPQVpAxiM=;
        b=eIKV1ksU+EMWsofo9meCIQJNUKFeyAFcimZEtAQEJxSB75GXF0o7Myyn19P9HaoS1K
         GYvQ6ZW2j0oMPo7oM3/UWmWmzcQDNzGhTRO/v9al1zY3oZQoj5UjGgrVnKn0IrvFSn8d
         yvYlwPjbcSMQFiKVzITnQy2Uy1PwSNgawzwIOWmdCygXW95KqiJ5oI4L2TJzGipb1RCz
         Lk/xwkO+fBPibRPO9WpeU/ESnb0syaB6tNF6Hq4kPMKMs7ETI6wHNosbfgGTsCOKnTPb
         EE4EyqOyNdNX3MSZfJalQ325/Wv8F+YpcNMFd8YmWNSdKJPJXARr6hLUz73RAzDIBOmR
         ywKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ow6H/nlu5TCk7P1uMwYJuJQQnJkQmKfjZydPQVpAxiM=;
        b=QOLJHX6IH2ORbHPQxKkT+gtkZqEm0++gOSviKg1D8CMLvbu9HAZ39Yf7YO1nGKSEU0
         UdPSv32VChnDb+aXMboD7sUR5ONY0g2ZRnmoMcuJXpUpLDjDiSgHvE66F0nIraQeK7iP
         3uQ3WzuKicXx45CH7x/VtRZ3jJgErO03EGJVyOMrqTsxk76TYHx9Arz8QfLHFUuABfd9
         lOR8I7FsPUgYkJlmrkIRHFWYvDmcsUkXW4aMYJDXgXaMm4FaIgWhjCJ2rLAZEGi+hAyS
         1j9hfcEbW9UiML5+OagSoASvIm9VmxDACDJf/P4t09C96gyGcUye6g6Kbk6sLWVW2gim
         oayQ==
X-Gm-Message-State: AOAM531rmcPJ2C4HQk8zB5+CIMMEPx8L6Mum+fPOo1eED9jWf+E0LY1p
        i1dRqDQisUBKEJTGG/2pqAU=
X-Google-Smtp-Source: ABdhPJyv/XpgMaihQE47lvPbRh8lngApF5917HNqcfp3+N8WSsLYdfU103he9ctJ/EXGE0kV1Xd82g==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr3168878wre.26.1631366837289;
        Sat, 11 Sep 2021 06:27:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:16 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/18] staging: r8188eu: remove unused ODM_FreeMemory()
Date:   Sat, 11 Sep 2021 15:26:31 +0200
Message-Id: <20210911132635.30369-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_FreeMemory() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 987fad541337..bbbb11b6cc58 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -76,12 +76,6 @@ void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length)
 	*pPtr = vzalloc(length);
 }
 
-/*  length could be ignored, used to detect memory leakage. */
-void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length)
-{
-	vfree(pPtr);
-}
-
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
 {
 	return !memcmp(pBuf1, pBuf2, length);
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index e87ee60005c8..a50b874fc2d1 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -88,7 +88,6 @@ u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
 
 /*  Memory Relative Function. */
 void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length);
-void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length);
 
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
-- 
2.33.0

