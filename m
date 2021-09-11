Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D8407848
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhIKNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbhIKN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD59C0613A6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so1829429wrq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGq1DOZhi2DNROmAcO611vpT6ynI2fgaBofSq8o3i7w=;
        b=M8mvdCRCLQmauFY9inBdiw4Mo6qS/cHpA33/4IMipeYI5aP5KKRtbAVV+cjxC5An43
         FDr1TMO4Y6gkzblsoCmS6Vsq2Zwqfwxor8c844ZSCRnhSTy5fz87wbyucCbYNRarcjrn
         QOzm47vgi0HdcOB0+/SPST9r+mnx4IKSAqbIAQYsRsYiHs7EX7ES1UWpKOm2nf0R7ngg
         apDtE5Ir9xug2buVAF9eIIvDoZe/3+7nLU9k1mr9/pkKO72yCx6wof6PhfqeFobc4G+I
         +QFy3ggDh2b+XgKDxQQcmx/KdUD6DE3KpCazvNZjWqGn548IiKfebgtCmj/fXYngFcQ8
         3PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGq1DOZhi2DNROmAcO611vpT6ynI2fgaBofSq8o3i7w=;
        b=bM9uqYuSof+Mpwl9IMun9rlYW5/NkYpHU/4QvD9ABs6W4f5U/8QrpKrjsmVnROr7LK
         66C6Ht3aGZzEWVgzBgDFoeO15C/xfnJa/j4jrzT4cEtXIL+Io9qm5vhZSUG9ktktygQk
         fH6+rX0DRY0jRPT/FSj6BffYk4loOrv7Lb96UtBfMznRH4bj1vXHtdIsmC9YneOXDxWR
         DNSQT5fsur8SbsoFCeWjxAYID+P6nn2TxaarY5TdxteWHmYsCHIrxwJqOHPhph4jbWSU
         iabr9y/dDagXaW5z1cHPd3vBXyDMS1P32TUyOWFMmANwW5M6tzelLYCoXCPkfq2PPA9j
         2hMA==
X-Gm-Message-State: AOAM530JRepuetiYimlDn0ZHXKjr1ThmY0evCllsSUg4q0pA4TZEEXNb
        biIcXDpk0W9+ULjGO43Yo20=
X-Google-Smtp-Source: ABdhPJycwvGBSYQm+HxMTd16arWN4J0UoxfS06jcnxyPO9uH1582OYskiSixFQcDZtW4Ewizb5XmWA==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr3230772wru.230.1631366838270;
        Sat, 11 Sep 2021 06:27:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/18] staging: r8188eu: remove unused ODM_AllocateMemory()
Date:   Sat, 11 Sep 2021 15:26:32 +0200
Message-Id: <20210911132635.30369-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_AllocateMemory() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 5 -----
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index bbbb11b6cc58..4e56ebf30e76 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -71,11 +71,6 @@ u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32
 }
 
 /*  ODM Memory relative API. */
-void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length)
-{
-	*pPtr = vzalloc(length);
-}
-
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
 {
 	return !memcmp(pBuf1, pBuf2, length);
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index a50b874fc2d1..2b103aecd859 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -87,8 +87,6 @@ u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
 		 u32 RegAddr, u32 BitMask);
 
 /*  Memory Relative Function. */
-void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length);
-
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
-- 
2.33.0

