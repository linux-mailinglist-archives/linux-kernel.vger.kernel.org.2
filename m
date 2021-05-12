Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F04637B7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:27:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4368C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:26:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so33717934ejy.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMAtkouy/UQHrdTj1Ln2w4uJpCPejRtEz1B0Xgr6qJ4=;
        b=lRem6m6mNyxYTmNSN+B48ut74tpPFWUlTDXZTXWdJ9g3LQi+GIr5g4aWK7sTeMZ0B6
         qzSHX8pN65PW3YUd7nBFaE5C8g6EtZqzt9nkX9kdWqYH85pmYZJWp2ZOgvEoiwt8Arwf
         4DP0UflQdUg/EAOuQE1MReNMGFO16sFB/qhhEEcQdzLxY4940qlAkDHif7hWZ7C/6uJ+
         8yp+6bcsMnYjm6U1czKukgMBkanwPhKTyb41rB3HSMw4C9xd+LBXV2HY5+KZXE+7/FAe
         1NHcOmZ2Q6KIYUW6uWrTiGSfLe6rkAsR77SF/xNb//xHT9MmGTBZnRS+MKnMVV8q/TjQ
         l4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NMAtkouy/UQHrdTj1Ln2w4uJpCPejRtEz1B0Xgr6qJ4=;
        b=Yos461uZ8tOSoeMf9DhCPB9J7vuf2N+YFgBpzqg7gHL+4maIID43H9PW7xf/3A6U2c
         QkkKAuBaSICwnYT8H8Wcsp4aKBOI2Kd7lsQLIMvV6d4aG9yni1NcUWOYalWF9bJjGz0t
         kqArUQHoj2Kbv9YM07dDZz0upzzZ80/loo6Eo/97x/GHB/8EXfcEPdUU/kmWU0GeWUo2
         3Vre3CAldqqNXAEK5mnyJwiDZFnGC/Gi/AeBuoC6dmSXwWR4gPIHuUM76hlfPO+stVso
         Tgb/xZ9V8RHbBQ97D/w7H9dg5hkgOyUlpBbjBLdV2v9rWuyBLL42lW/TueJD/UcTwIOO
         WpqQ==
X-Gm-Message-State: AOAM531duxrAtHBaQqzRvP4ea/rNj+y5bfe9wE6GiYM64MYDB53IX8xS
        lWrk+3trLhG4bAv1wS0DCgA=
X-Google-Smtp-Source: ABdhPJy6+KsjMc7QIOlXs0YiNhWM+EIHgLXW4KiuDaN2yf7P7VhKgbzOSian+YJ1xJofsG+kn5ot9Q==
X-Received: by 2002:a17:906:3b13:: with SMTP id g19mr36287442ejf.238.1620807978124;
        Wed, 12 May 2021 01:26:18 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id s17sm3355797ejz.78.2021.05.12.01.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 01:26:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: Remove two set but unused variables
Date:   Wed, 12 May 2021 10:26:14 +0200
Message-Id: <20210512082614.30890-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed two set but unused variables. Issue detected by GCC.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index c42fd36c88ef..3b8be8137683 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1629,7 +1629,7 @@ void PHY_IQCalibrate_8723B(
 	s32 result[4][8];	/* last is final result */
 	u8 i, final_candidate;
 	bool bPathAOK, bPathBOK;
-	s32 RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC, RegTmp = 0;
+	s32 RegE94, RegE9C, RegEA4, RegEB4, RegEBC, RegEC4, RegTmp = 0;
 	bool is12simular, is13simular, is23simular;
 	bool bSingleTone = false, bCarrierSuppression = false;
 	u32 IQK_BB_REG_92C[IQK_BB_REG_NUM] = {
@@ -1646,7 +1646,6 @@ void PHY_IQCalibrate_8723B(
 /* 	u32 		Path_SEL_BB = 0; */
 	u32 		GNT_BT_default;
 	u32 		StartTime;
-	s32			ProgressingTime;
 
 	if (!ODM_CheckPowerStatus(padapter))
 		return;
@@ -1777,22 +1776,18 @@ void PHY_IQCalibrate_8723B(
 		RegE94 = result[i][0];
 		RegE9C = result[i][1];
 		RegEA4 = result[i][2];
-		RegEAC = result[i][3];
 		RegEB4 = result[i][4];
 		RegEBC = result[i][5];
 		RegEC4 = result[i][6];
-		RegECC = result[i][7];
 	}
 
 	if (final_candidate != 0xff) {
 		pDM_Odm->RFCalibrateInfo.RegE94 = RegE94 = result[final_candidate][0];
 		pDM_Odm->RFCalibrateInfo.RegE9C = RegE9C = result[final_candidate][1];
 		RegEA4 = result[final_candidate][2];
-		RegEAC = result[final_candidate][3];
 		pDM_Odm->RFCalibrateInfo.RegEB4 = RegEB4 = result[final_candidate][4];
 		pDM_Odm->RFCalibrateInfo.RegEBC = RegEBC = result[final_candidate][5];
 		RegEC4 = result[final_candidate][6];
-		RegECC = result[final_candidate][7];
 		bPathAOK = bPathBOK = true;
 	} else {
 		pDM_Odm->RFCalibrateInfo.RegE94 = pDM_Odm->RFCalibrateInfo.RegEB4 = 0x100;	/* X default value */
@@ -1844,10 +1839,6 @@ void PHY_IQCalibrate_8723B(
 	}
 
 	pDM_Odm->RFCalibrateInfo.bIQKInProgress = false;
-
-	ProgressingTime = jiffies_to_msecs(jiffies - StartTime);
-
-
 }
 
 
@@ -1856,7 +1847,6 @@ void PHY_LCCalibrate_8723B(struct dm_odm_t *pDM_Odm)
 	bool		bSingleTone = false, bCarrierSuppression = false;
 	u32 		timeout = 2000, timecount = 0;
 	u32 		StartTime;
-	s32			ProgressingTime;
 
 #if DISABLE_BB_RF
 	return;
@@ -1882,6 +1872,4 @@ void PHY_LCCalibrate_8723B(struct dm_odm_t *pDM_Odm)
 
 
 	pDM_Odm->RFCalibrateInfo.bLCKInProgress = false;
-
-	ProgressingTime = jiffies_to_msecs(jiffies - StartTime);
 }
-- 
2.31.1

