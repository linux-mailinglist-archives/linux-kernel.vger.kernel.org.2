Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703B742F854
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbhJOQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbhJOQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E59C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y3so27606124wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptBaQ/8TQM1EowzYMrzwxMw23j9xvcGBj+Eo0T9DNWo=;
        b=pvIUzzUjiiVxrXj+OVblyGOAbd5nK/Nr4JMFjPRPybY2m/oFwhAO8xrUTGkBpgRSZg
         bxJ+dK7xX/Fbkl9G9b9gsMuBbfFkHhSi4Vb0bCavZmUoelC2EX1SVFEM1QoDjdu0569g
         pcpA2VQvVbqNz9i+5505v0bDOVVqgu7AaietGBXWfrwTBCzBApZFsZ6FBcb/uO5J2Kb3
         NQW3n3DbanP1NncRdmd4QqlgREtVGeMrz7MSGfI+9jSqBdl0GnW0QsTstCTWH6TY8LH4
         +qmMzaq4nQPxlCPFLffi4By5ZuUezgGeMY87PrxHBbsH3GLOEO7RCq7+3XevVB+c7eSn
         DvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptBaQ/8TQM1EowzYMrzwxMw23j9xvcGBj+Eo0T9DNWo=;
        b=HPhskDtQ8TERb4I4rZ4++4ks/QKtXQ1HQQDryEUnYtJ2MuWviNO5XuEnflmZDbNFIt
         0dOkRCHiWIbn/CWudjbTO8NijJvTWA9i9ZWKa24JVtoVFE4qvo4D/x/xNqTtTop3ydwg
         fB+05KSn3WxpDbKGmtCidz7TWFaT866gHLgsJKvE43uf/xuY/k6mhuaWkqZ6rRbk4rsv
         OlnJUv7+CXE3hviFnGpPXx5JQIh2SYZ38iUzZXTLBA23olb7tuNY5DVpHCZ+n/Cq702L
         Zf2nYnbaugEwt0o2iMbSChTdMDazuP6gN+nlN8fU1lLfSPycW5Oo0moorew+lPiRQMwU
         13bA==
X-Gm-Message-State: AOAM532pPgEIkDkLihcj2/GCHRNrStXzMwwzWHyCpnBBT2TfDUqg6uHZ
        dNtDXa3g031HwsfiXLMrdiyHpeTjBYM=
X-Google-Smtp-Source: ABdhPJy8UVIvYzmU5MByUWK2SIG1sBx2C6B4KqLZLvJwYescuQXpt2YIB8G2dDedXdkmmiXdLlb1Ag==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr2565820wrc.254.1634315718121;
        Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: r8188eu: remove ODM_AntselStatistics_88C()
Date:   Fri, 15 Oct 2021 18:35:04 +0200
Message-Id: <20211015163507.9091-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_AntselStatistics_88C() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 21 ---------------------
 drivers/staging/r8188eu/include/odm.h |  3 ---
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 28bd6f36cddd..d3d13164ca8f 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1016,27 +1016,6 @@ void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
 	ODM_AntennaDiversityInit_88E(pDM_Odm);
 }
 
-void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId, u32 PWDBAll, bool isCCKrate)
-{
-	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
-
-	if (pDM_SWAT_Table->antsel == 1) {
-		if (isCCKrate) {
-			pDM_SWAT_Table->CCK_Ant1_Cnt[MacId]++;
-		} else {
-			pDM_SWAT_Table->OFDM_Ant1_Cnt[MacId]++;
-			pDM_SWAT_Table->RSSI_Ant1_Sum[MacId] += PWDBAll;
-		}
-	} else {
-		if (isCCKrate) {
-			pDM_SWAT_Table->CCK_Ant2_Cnt[MacId]++;
-		} else {
-			pDM_SWAT_Table->OFDM_Ant2_Cnt[MacId]++;
-			pDM_SWAT_Table->RSSI_Ant2_Sum[MacId] += PWDBAll;
-		}
-	}
-}
-
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
 {
 	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV))
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index db24678eb0bc..a8e9089433ba 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -899,7 +899,4 @@ void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm,
 
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 
-void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
-			      u32 PWDBAll, bool isCCKrate);
-
 #endif
-- 
2.33.0

