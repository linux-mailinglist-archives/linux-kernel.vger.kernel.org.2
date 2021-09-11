Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BACB407843
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhIKN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhIKN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10EEC0617AE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g16so6887128wrb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4m9mJssrqG/NmF5Cx2Pbp99k9OyrxMssGnUz8bhdveI=;
        b=WCnt1qn9wskR8EOztENndhkcglJYRe7uLUq9hUof2Mo2K4lS56EVCI6cDPvbv+ign/
         bji5JxC4liRkZINJv9O0rpY5Zikaz2dnNM/flhf86aW26zzQDSG/3HP05xV76n1m/Fow
         KC1DvMI5plGBKaMkjzPAFnE6XeuNqksorFU4iBdcxg7uskY0Q3reZUtUU5lmyan2cxlN
         yI7F6GFIt4ZH+fbJcyP/bJLjGT6sqcLyA0mb2/n1IL1t8OgmigS8Yj7iv3+w/xaaWfg5
         c/jEOvTrGmTRQpm93/QizY5D6/sFae+qkuNdx74SQ8YmuNVjAJRF4pq08c4Zkj3qd6VP
         PMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4m9mJssrqG/NmF5Cx2Pbp99k9OyrxMssGnUz8bhdveI=;
        b=auGAthlG+H/o1MFeJfZ9BfeinTVLAi0qWTgifwkr0PAxeuhYYubPv4JK0e64vX2fcu
         bk3XTmpJ7eAqvLu9oIVbHib7kOt6in7IKVqbuqbxeEwybCCXIMLdlNqHsd2OqR2ArkiP
         kV46f582MeJiLx9h4oh+bN9lXBsssD/ZoBo2JNFt8p0t/hyDFyxYPCqb+uzkWlfZZhUV
         viN8VYa5PQjE1fpR9uc3XVRy+wW1yOsBu9K4dqMP/Gp459p46j9h5bOcymuzd2vbG4iM
         eQDwY5S6G4mZuR87WMsqo7lxB0pXijwBwPeLDAzQHs4GZKCLlPOk+uwnhy0OgxvYVmbm
         WRQg==
X-Gm-Message-State: AOAM5320rUPnFtvNbOXn+Lqx5BsWz/ITR0NfnVgKROi1fCgGsDPdTYYo
        ZI/1wWCQ04bkC3LXRi0/jus=
X-Google-Smtp-Source: ABdhPJz4sAOXzIUG8W2l6DQEIIm89WHkk67pZt+8g035DPlKfyob82o1XlV4PM3uW7S3KBBXqkmYaw==
X-Received: by 2002:a5d:4a08:: with SMTP id m8mr3112111wrq.263.1631366834406;
        Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/18] staging: r8188eu: remove unused ODM_IsWorkItemScheduled()
Date:   Sat, 11 Sep 2021 15:26:28 +0200
Message-Id: <20210911132635.30369-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_IsWorkItemScheduled() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 5 -----
 drivers/staging/r8188eu/include/odm_interface.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index c4ab858db29b..7fd450575eb4 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -93,11 +93,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 	return !memcmp(pBuf1, pBuf2, length);
 }
 
-/*  Work item relative API. FOr MP driver only~! */
-void ODM_IsWorkItemScheduled(void *pRtWorkItem)
-{
-}
-
 /*  ODM Timer relative API. */
 void ODM_StallExecution(u32 usDelay)
 {
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 65749c213cb9..f6c23fd9b31b 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -95,9 +95,6 @@ void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length);
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
-/*  ODM MISC-workitem relative API. */
-void ODM_IsWorkItemScheduled(void *pRtWorkItem);
-
 /*  ODM Timer relative API. */
 void ODM_StallExecution(u32 usDelay);
 
-- 
2.33.0

