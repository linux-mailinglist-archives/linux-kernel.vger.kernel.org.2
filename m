Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2340784D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhIKNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00080C061760
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so1828820wrq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xORhzTVO5jZPwm65fjbWfekx9AYCufbudPIhVFIxJU=;
        b=fXWb4hC2LEJ8y8XJeGsDmDGu2HmT4pZPzLz0tTXO9ZHEwkOZtI0Rga5FocyczcUHro
         45hqXY9p4mFvrusY0Xd2KJBUxNjr2eRGfI7kOJ8HmfmOWhqAIGY7A0Q18Bq8BaOY7BiD
         CoLpOeL7jtvZgFTGNZzXQkqXufl3coeZZEuaGOedr2O8bHgTEIw+TmWp0va2CpyLAK74
         N5yqU65AEe+2rETDnHtKAWDLtAeCD8veftaWAnWvQuabJCez5BW0W1+VjodNln7evql6
         cUl0pLpUwwO/06DTP6MWbtWcnrhVzZ3ePbcL3EajGG3vDDlD/oyDuVt2Iw1lmIsvcmDj
         xKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xORhzTVO5jZPwm65fjbWfekx9AYCufbudPIhVFIxJU=;
        b=rbqKuNryNfzTrGE9Wikoa7WkPi85chSpjdbtbx3r64VMtzh4yXZeuE9rndz7KYegaj
         AlBQzqEtffT/BMLZqTzzyb4yylHnsl1t7FvigRzbncveybfJTaEk6w3OHA/R77CAtU7q
         ItD4ZK4IbTRePsAL2JwlffAs9ZzP8uWYobZrsBpMnOGcjAcV5ji/RK6MD+xgnfG32iOX
         KUvamE2KEzN7zQU7WjYMxbaNc8GSPgiBjsIRGrXcKExIf9Xo0Pa+ZZdGOTlVzJTngT+z
         /18VchwPCLKwibPUc1eSKOP5/Ej+nVqrgI0Ot2SuPXAA5LqDY4AFvBqZoqvbo8awDsaZ
         a3Ow==
X-Gm-Message-State: AOAM533juB8UbnOURft+i9sovcBwKbC2PNI5iPn+dh1P/oV5YsLNkK76
        CX5BtiaA87Fk82ng60zn6R0=
X-Google-Smtp-Source: ABdhPJy8BfXHBBY5NI8qS39K62ECNPdIm9Hu7RGUgN23ZnKBiA4bGW/GOKnl/4Ze2kvRfNIjRYsPRw==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr3197958wrz.242.1631366825605;
        Sat, 11 Sep 2021 06:27:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/18] staging: r8188eu: remove empty ODM_ReleaseTimer()
Date:   Sat, 11 Sep 2021 15:26:18 +0200
Message-Id: <20210911132635.30369-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_ReleaseTimer() is empty and its only caller is
ODM_ReleaseAllTimers(). Remove both functions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 7 -------
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ----
 drivers/staging/r8188eu/include/odm.h           | 2 --
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 4 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index f0fd88d98e95..011ebcdac797 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1414,13 +1414,6 @@ void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm)
 	ODM_CancelTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer);
 }
 
-void ODM_ReleaseAllTimers(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_ReleaseTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer);
-
-	ODM_ReleaseTimer(pDM_Odm, &pDM_Odm->FastAntTrainingTimer);
-}
-
 /* 3============================================================ */
 /* 3 Tx Power Tracking */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 5a01495d74bc..c33ef4736ff6 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -165,10 +165,6 @@ void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
 	_cancel_timer_ex(pTimer);
 }
 
-void ODM_ReleaseTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
-{
-}
-
 /*  ODM FW relative API. */
 u32 ODM_FillH2CCmd(u8 *pH2CBuffer, u32 H2CBufferLen, u32 CmdNum,
 		      u32 *pElementID, u32 *pCmdLen,
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 7c8f082930dd..a100fdf87379 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -1139,8 +1139,6 @@ void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm);
 
 void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm);
 
-void ODM_ReleaseAllTimers(struct odm_dm_struct *pDM_Odm);
-
 void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
 			      u32 PWDBAll, bool isCCKrate);
 
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 6b589413d56c..9109d72915cd 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -137,8 +137,6 @@ void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm,
 
 void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
 
-void ODM_ReleaseTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
-
 /*  ODM FW relative API. */
 u32 ODM_FillH2CCmd(u8 *pH2CBuffer, u32 H2CBufferLen, u32 CmdNum,
 		   u32 *pElementID, u32 *pCmdLen, u8 **pCmbBuffer,
-- 
2.33.0

