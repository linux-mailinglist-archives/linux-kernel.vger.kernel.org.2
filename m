Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1C4337C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhJSNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbhJSNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:54:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2CEC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so2836011wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3xaDGd5SiSRwBvg63JopBcro3FsB36YKI7Ymti5lbo=;
        b=e8buj+HAEr2ahjbxvicGaqczJm6Bg2VgdSr7Jt/zIu8NzE0Da5S2cuItXH7VBwOoCm
         3Whrt22tZpWSYQdE3WyuuH5DuQgOB/bytgWo3o+xUH5AWKgRDILpoHxvlj+maOqwZr46
         Yks0Cm+vsG/ZWZ+tU0tw46ujdzHzybHLdD2qxoc4xBs5kTTSCTYwohxGOSGOnPwNDnv5
         Ksrk4lWojd825v87wHdu3fMVSeH5tnwfNSlxas90PutVNF23mE/mEVM/L+JIaj9zU+KH
         R+b9b/LjfdKzWrOlkugNpkyjgpPGEiSeaPTbz7fHAoVfDeyrT+cMNc+K23JULoib1irF
         pCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3xaDGd5SiSRwBvg63JopBcro3FsB36YKI7Ymti5lbo=;
        b=ub6G2SJRBFDeR7KsZvQEXvxvA+jwiaLqS6r74xAbNAK7VdnM8pM4QcCumY1byqQuM9
         p/t1d/NZNUP4IZspetbJlV+LKpPp9vnGaFkilTOMpn/h2mxk2rlzQ7cMvBs7QuFNlEHz
         MUbaPcq4o9TBDnnhsD85Sc1bLwCiWKf+KLOgl7UjaaWWVYE8ev2wmweyx2cLhgLBjMEH
         ofKdGg0kyrg9ID9OmpOD8S3x4KByzLLmK7Jc4ldh5tfXR1lBgto8grnZwoRpoDGNkFjr
         4sGxdAHRi23CU3VX6HEg7iVLtzAmn7OGZPIVFYAS9PU+RCsR3Lzbnx3+FeGS/dsdjDyZ
         uyHQ==
X-Gm-Message-State: AOAM530+V4QEYBAKYJMbcfZElSCHR8pkFg6GoLoNn0CK87mkBOpfKpX/
        zBbZ7sgWgv0SB9KXZGDbnOM=
X-Google-Smtp-Source: ABdhPJz7OlARBSlDJWkP5MueamYixkEJUYBuRFAXfxLGz5NPP8YUK11dZVEAwpIZDLPgkWn5DyKEtQ==
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr6072991wml.39.1634651505533;
        Tue, 19 Oct 2021 06:51:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id i203sm2280699wma.48.2021.10.19.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:51:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/7] staging: r8188eu: remove unused cases from ODM_CmnInfo{Hook,Update}
Date:   Tue, 19 Oct 2021 15:51:34 +0200
Message-Id: <20211019135137.9893-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019135137.9893-1-straube.linux@gmail.com>
References: <20211019135137.9893-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused cases from ODM_CmnInfo{Hook,Update}.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 30 ---------------------------
 drivers/staging/r8188eu/include/odm.h | 10 ---------
 2 files changed, 40 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index ef29540983b1..3aa84078319e 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -249,36 +249,12 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_CHNL:
 		pDM_Odm->pChannel = (u8 *)pValue;
 		break;
-	case	ODM_CMNINFO_DMSP_GET_VALUE:
-		pDM_Odm->pbGetValueFromOtherMac = (bool *)pValue;
-		break;
-	case	ODM_CMNINFO_BUDDY_ADAPTOR:
-		pDM_Odm->pBuddyAdapter = (struct adapter **)pValue;
-		break;
-	case	ODM_CMNINFO_DMSP_IS_MASTER:
-		pDM_Odm->pbMasterOfDMSP = (bool *)pValue;
-		break;
 	case	ODM_CMNINFO_SCAN:
 		pDM_Odm->pbScanInProcess = (bool *)pValue;
 		break;
 	case	ODM_CMNINFO_POWER_SAVING:
 		pDM_Odm->pbPowerSaving = (bool *)pValue;
 		break;
-	case	ODM_CMNINFO_ONE_PATH_CCA:
-		pDM_Odm->pOnePathCCA = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_DRV_STOP:
-		pDM_Odm->pbDriverStopped =  (bool *)pValue;
-		break;
-	case	ODM_CMNINFO_PNP_IN:
-		pDM_Odm->pbDriverIsGoingToPnpSetPowerSleep =  (bool *)pValue;
-		break;
-	case	ODM_CMNINFO_INIT_ON:
-		pDM_Odm->pinit_adpt_in_progress =  (bool *)pValue;
-		break;
-	case	ODM_CMNINFO_ANT_TEST:
-		pDM_Odm->pAntennaTest =  (u8 *)pValue;
-		break;
 	case	ODM_CMNINFO_NET_CLOSED:
 		pDM_Odm->pbNet_closed = (bool *)pValue;
 		break;
@@ -314,12 +290,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	case	ODM_CMNINFO_RSSI_MIN:
 		pDM_Odm->RSSI_Min = (u8)Value;
 		break;
-	case	ODM_CMNINFO_RA_THRESHOLD_HIGH:
-		pDM_Odm->RateAdaptive.HighRSSIThresh = (u8)Value;
-		break;
-	case	ODM_CMNINFO_RA_THRESHOLD_LOW:
-		pDM_Odm->RateAdaptive.LowRSSIThresh = (u8)Value;
-		break;
 	}
 }
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 6aac90fcf3cc..1ad7ee5919ef 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -243,16 +243,8 @@ enum odm_common_info_def {
 	ODM_CMNINFO_BW,			/*  ODM_BW_E */
 	ODM_CMNINFO_CHNL,
 
-	ODM_CMNINFO_DMSP_GET_VALUE,
-	ODM_CMNINFO_BUDDY_ADAPTOR,
-	ODM_CMNINFO_DMSP_IS_MASTER,
 	ODM_CMNINFO_SCAN,
 	ODM_CMNINFO_POWER_SAVING,
-	ODM_CMNINFO_ONE_PATH_CCA,	/*  ODM_CCA_PATH_E */
-	ODM_CMNINFO_DRV_STOP,
-	ODM_CMNINFO_PNP_IN,
-	ODM_CMNINFO_INIT_ON,
-	ODM_CMNINFO_ANT_TEST,
 	ODM_CMNINFO_NET_CLOSED,
 	ODM_CMNINFO_MP_MODE,
 /*  POINTER REFERENCE----------- */
@@ -262,8 +254,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_WIFI_DISPLAY,
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
-	ODM_CMNINFO_RA_THRESHOLD_HIGH,		/*  u8 */
-	ODM_CMNINFO_RA_THRESHOLD_LOW,		/*  u8 */
 	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
 	ODM_CMNINFO_BT_DISABLED,
 	ODM_CMNINFO_BT_OPERATION,
-- 
2.33.1

