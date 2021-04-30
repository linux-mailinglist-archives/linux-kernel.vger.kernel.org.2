Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F036FCF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhD3O6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhD3O6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591BDC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f24so7141412ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TVYammkl8ZNcJo8mdkE77hHWM+9bJ8+VczMb0ee9es=;
        b=Dt93daB2CJtDNlFPrNxjDO4adyJgk7S3oMnj3MVdXO7TgjGW1KSgLM7M1PEPd2hOLX
         NviIDIn/O1ti5AXho0QqMUqWcMJv3jH2RGFi2E5B6uGDKEQwKxJt3/ChEFLsD+YfKlc/
         8OVc4hkHsWnsZgBNXznS/fdRgIJYTvBG/jaVM/NTluZFZIBjI2Ym/8U9hPL2mchmeMB5
         pcxbOCFgSmOwFpZ0DbmMLLqgS8RyzLIuoiYi0SUubbWQHXjIr3NZ10dFGklR/j4q1vDj
         +qXg4xZZxTI8i2gb1Uv3uZUU0Vcab+KNHScRlo0FlvdIQOQIktYbVRjL+4o489YQOmjm
         +Ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TVYammkl8ZNcJo8mdkE77hHWM+9bJ8+VczMb0ee9es=;
        b=dv5bK2EfH5JxP51JgS+rF55Ygryw+QDgG4jka6Pg2GVP38KqLx79oSy+e9eJg4tK/k
         Eqd5KlceEQsyXu1TsXxEQnn0LP8ya5guvCc2/r7sLN/yRNs9a+JOZPlA7UeM8r52+4EF
         M9mV881o6+3s1PMliL1ihtYGOaFwpa8ZpQq2GtNklzCjxfNIev0Von/uU7iEVteSiD7e
         1kiiPjweuife0hhmm26OwpT93fasg3tah4IKzJohdOq5s69rN2fZ6/kkhcDSEFZ27fWG
         wAqQxsIZpmc7eNz9BmBYlQu4GCFSH/WIRFlLup5KE7lw+fHSbKDZzTv9VoQUOzQb29xr
         x5yA==
X-Gm-Message-State: AOAM532tPpa4QnrxY1GNHcOOycrVNDtyy5r79ullaA9BtwfNxMlCCyZP
        n1K3BAX6OKuOjTtC9+yOMiQjrOaBE+8=
X-Google-Smtp-Source: ABdhPJzME1IcGKykGxNml2U+mzyPhC9wDKT/+uDE0I3jqKydAbzgomoY8yXUKxhUhwcO3itlldEvWw==
X-Received: by 2002:a17:906:27c3:: with SMTP id k3mr4802727ejc.519.1619794630834;
        Fri, 30 Apr 2021 07:57:10 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id p21sm1543320edw.18.2021.04.30.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/43] staging: rtl8723bs: remove if-else blocks left empty by ODM_RT_TRACE deletion
Date:   Fri, 30 Apr 2021 16:56:24 +0200
Message-Id: <0e1196ebf56787f62dcbfbcba1fcbc2ed37a65ce.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove if-else blocks left empty by ODM_RT_TRACE deletion.
remove unused variables to suppress compiler warnings.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c       | 13 -------------
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c |  9 +--------
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c    |  8 --------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index 2e10817bf3dd..b8e385fdda89 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -118,9 +118,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 
 	/* 4 3. Initialize ThermalValues of RFCalibrateInfo */
 
-	if (pDM_Odm->RFCalibrateInfo.bReloadtxpowerindex)
-		{}
-
 	/* 4 4. Calculate average thermal meter */
 
 	pDM_Odm->RFCalibrateInfo.ThermalValue_AVG[pDM_Odm->RFCalibrateInfo.ThermalValue_AVG_index] = ThermalValue;
@@ -273,16 +270,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		/*  to increase TX power. Otherwise, EVM will be bad. */
 		/*  */
 		/*  2012/04/25 MH Add for tx power tracking to set tx power in tx agc for 88E. */
-		if (ThermalValue > pDM_Odm->RFCalibrateInfo.ThermalValue) {
-			if (c.RfPathCount > 1)
-				{}
-
-		} else if (ThermalValue < pDM_Odm->RFCalibrateInfo.ThermalValue) { /*  Low temperature */
-
-			if (c.RfPathCount > 1)
-				{}
-
-		}
 
 		if (ThermalValue > pHalData->EEPROMThermalMeter) {
 			for (p = ODM_RF_PATH_A; p < c.RfPathCount; p++)
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 471418f3f724..858aafc24931 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -689,8 +689,7 @@ static u8 phy_PathA_RxIQK8723B(
 		(tmp < 0xf)
 	)
 		result |= 0x02;
-	else							/* if Tx not OK, ignore Rx */
-		{}
+
 	return result;
 }
 
@@ -988,8 +987,6 @@ static u8 phy_PathB_RxIQK8723B(struct adapter *padapter, bool configPathB)
 		(tmp < 0xf)
 	)
 		result |= 0x02;
-	else
-		{}
 
 	return result;
 }
@@ -1500,7 +1497,6 @@ static void phy_IQCalibrate_8723B(
 				result[t][2] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][3] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 			break;
-		} else {
 		}
 	}
 
@@ -1533,13 +1529,10 @@ static void phy_IQCalibrate_8723B(
 				result[t][6] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				result[t][7] = (PHY_QueryBBReg(pDM_Odm->Adapter, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
 				break;
-			} else {
 			}
 		}
 
 /* Allen end */
-		if (0x00 == PathBOK) {
-		}
 	}
 
 	/* Back to BB mode, load original value */
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
index cfcbc3741803..bedce2c10b22 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
@@ -9,16 +9,8 @@
 
 void odm_PathDiversityInit(void *pDM_VOID)
 {
-	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_PATH_DIV))
-		{}
 }
 
 void odm_PathDiversity(void *pDM_VOID)
 {
-	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_PATH_DIV))
-		{}
 }
-- 
2.20.1

