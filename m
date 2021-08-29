Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9951F3FAD94
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhH2R5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhH2R5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 13:57:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:56:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so7862492wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4EhJ3FPSzsKM7SEta7e07FUT7o8JEpBt1gE+sBpoJo=;
        b=UPqpnhfVNWxVx1QcQPDCIvPoW2Z/Wg9+Dr0TcD1u3YDxeaSntck1CrYMd5EL3y+Vqk
         h2VksJaiDHQdCdrLmBOJSafK/a/IziB7V5LlHOdnWjIJUf1ppwPrd+bIZmP5w9Rhv9u7
         OYqaxTkRqkpQhPJehiDcarr1VHFW/dqzqFh+VUpWeBBVoP1yG49Edpz4VLN/bzVtVi+Y
         xs4uCCigvDFBu6rRQI7/6M9DwtQupKWvwxp5bQPXqYYo33HhbISAvA8K5rarIveR5nl2
         GWJ9fFzLKR8L+E0rBu/50eZPs7UHxlcPMZDuiKIaEt/8twlM+/UI6PARSnDU0stFdJFm
         WuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4EhJ3FPSzsKM7SEta7e07FUT7o8JEpBt1gE+sBpoJo=;
        b=OK8UX6X9d1SKSX1blLkcmihehBOvdbfISVmVXNxjHFaYM7WU731N2v2xuHtKAtbwIW
         LwZ5M1mdNHlF31TZj6g6s6QRCGHHpPhURacD5qw18N66XLTmpTCoM0j7XTwemkhkvR4j
         oUKrH674U3X0A8lg58Dof1o1JgWG+qgDW+OqhkTedvn0kih5QqxI6chue3xbaCBxNZhO
         LUpOK8463s072wdECJNnjk8YQy2hs2vVn8bEwSPnqePlxzaCV8Q32Pju6doYTQcJBjEm
         +CH+GuHK8TqvXIpjTKu1OOUYL7EELXUF1HasbRRtBKUQNRFYbhYb9nao9DVDNx5Xfoq6
         Uomg==
X-Gm-Message-State: AOAM531qNw2NKu6RrhXRxMOybTVPaFnE8x3im/ewl3eW50/OZ8QbKs5v
        BSc31JJ3WfSGZusJy9e1NHo=
X-Google-Smtp-Source: ABdhPJzlo1G1QoNBGoK8JLr8hi5vnDmctNqjiO91Tt6OJAThHLL1Yqy8Ss000Tm8oABFGc6ngZIIWw==
X-Received: by 2002:a1c:25c7:: with SMTP id l190mr15218198wml.118.1630259800179;
        Sun, 29 Aug 2021 10:56:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id k25sm13765256wrd.42.2021.08.29.10.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 10:56:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: refactor field of struct odm_rf_cal
Date:   Sun, 29 Aug 2021 19:56:24 +0200
Message-Id: <20210829175624.5915-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829175624.5915-1-straube.linux@gmail.com>
References: <20210829175624.5915-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the field IQKMatrixRegSetting of struct odm_rf_cal to be not
an array. The driver is for chips that operate in the 2.4 GHz band only.
So only the first element of the array is used and there is no need for
an array.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 12 ++++++------
 drivers/staging/r8188eu/include/odm.h        |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 1b0e1e7307cd..6e0abaf58791 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -279,8 +279,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 
 				/* Adujst OFDM Ant_A according to IQK result */
 				ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000) >> 22;
-				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][0];
-				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][1];
+				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][0];
+				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][1];
 
 				/*  Revse TX power table. */
 				dm_odm->BbSwingIdxOfdm		= (u8)OFDM_index[0];
@@ -314,8 +314,8 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000) >> 22;
 
 					/* new element A = element D x X */
-					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][4];
-					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][5];
+					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][4];
+					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][5];
 
 					if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
 						if ((X & 0x00000200) != 0)	/* consider minus */
@@ -1182,8 +1182,8 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 /* by sherry 20120321 */
 	if (final_candidate < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
-		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
+			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][i] = result[final_candidate][i];
+		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.bIQKDone = true;
 	}
 
 	_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index d9041ee576bb..7c8f082930dd 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -260,7 +260,6 @@ struct odm_rate_adapt {
 
 #define AVG_THERMAL_NUM		8
 #define IQK_Matrix_REG_NUM	8
-#define IQK_Matrix_Settings_NUM	1+24+21
 
 #define	DM_Type_ByFWi		0
 #define	DM_Type_ByDriver	1
@@ -664,7 +663,7 @@ struct odm_rf_cal {
 
 	u8	ThermalValue_HP[HP_THERMAL_NUM];
 	u8	ThermalValue_HP_index;
-	struct ijk_matrix_regs_set IQKMatrixRegSetting[IQK_Matrix_Settings_NUM];
+	struct ijk_matrix_regs_set IQKMatrixRegSetting;
 
 	u8	Delta_IQK;
 	u8	Delta_LCK;
-- 
2.33.0

