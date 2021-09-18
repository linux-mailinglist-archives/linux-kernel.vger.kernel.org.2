Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D094105D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbhIRJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbhIRJ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6422C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t8so12254611wri.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoBjKuAUIrqbP3exqakCt2vgFtdI/tJF3GNqO0fS3j0=;
        b=Ox7zDSD410YxA6Jsf1uhzjcNeueHkAHxdJGWH4aU/QZL+AOmKqFUdAiZPhbv2y9F4z
         2905eK4d5AzuNopZe0VW8qd0uN4bRn1qUoAviujORUnkaPLX1JCwyMEFwIYoK/SSklUQ
         9jHliF5FhkyOZOCKnTiXkSiA2xA/3CgqT66tBUQQT9nBzfIvrubyWSGwSbF1xRCcIflB
         KHWuL6l6Wx7qlzUGLNKiEOl1xQAj1tklmyIH7a5xKl6aFpuwooXw/DaDXUmHSbXMImAW
         rDP20Q+FYwbXFadhSOT6ekDG2B2Jj2mZE6+suK3G+tk9R2WNbmqoIXfTxQ7JKbBygM/n
         R/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoBjKuAUIrqbP3exqakCt2vgFtdI/tJF3GNqO0fS3j0=;
        b=seJHfQMvB4aiB7tPzMkjvUafSLQffm9aVII5Wp2KgMnCx0RuVs2X7E7sO8E3Ai1bqi
         wlqAu5vmQePw2LhAfnL+XcQ1oI8eQioqPXmuElslQ47TjGN/HAB5dxW6b05HSfrBcxEq
         0rgc1fDBD03nWDzx6SwNkuLSeRN9d28effPRKOG+38w4xeFe5BegLXpVBJwkpmrIYVC/
         kd+mLAnWG0zXRw/8yw0ynj8WztIiUbSeoR52fggOeAEtqjGsNZ+cfACWBrAQq2VJpTZH
         7U71Bw5h8uNjnOur8BJ24itPXqDS2Opr7eoSUL1kN/cxm7Pglddr6FJc5330IW0liRUH
         0wUA==
X-Gm-Message-State: AOAM532BWImGwR5UL5rOr6z1lsIlrnebHpZ5IAuRNN035gDqANjuvFGs
        h1m2wyvScoFC5Q73lVu217E=
X-Google-Smtp-Source: ABdhPJxjof1kHIGNOKsUajD2R19NjrwkzNm2It0qYZJZ7aSUELu5C6Uw2xkU1acWb4ObN3YNEclgIA==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr17051583wrx.130.1631959077442;
        Sat, 18 Sep 2021 02:57:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:57:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: r8188eu: remove ODM_DIG_LowerBound_88E()
Date:   Sat, 18 Sep 2021 11:57:21 +0200
Message-Id: <20210918095727.13591-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_DIG_LowerBound_88E() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 9 ---------
 drivers/staging/r8188eu/include/odm_RTL8188E.h | 2 --
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index c64a291f9966..7270ce68cfd2 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -3,15 +3,6 @@
 
 #include "../include/odm_precomp.h"
 
-void ODM_DIG_LowerBound_88E(struct odm_dm_struct *dm_odm)
-{
-	struct rtw_dig *pDM_DigTable = &dm_odm->DM_DigTable;
-
-	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
-		pDM_DigTable->rx_gain_range_min = (u8)pDM_DigTable->AntDiv_RSSI_max;
-	/* If only one Entry connected */
-}
-
 static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 {
 	u32	value32;
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index 00d2678532f8..96e50c9224aa 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -11,8 +11,6 @@
 #define	MAIN_ANT_CGCS_RX	0
 #define	AUX_ANT_CGCS_RX	1
 
-void ODM_DIG_LowerBound_88E(struct odm_dm_struct *pDM_Odm);
-
 void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *pDM_Odm);
 
 void ODM_AntennaDiversity_88E(struct odm_dm_struct *pDM_Odm);
-- 
2.33.0

