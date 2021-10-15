Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A342F855
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhJOQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbhJOQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CCDC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so27586028wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukS08Jg1OXlGw3g90VUiXACIFGwP+irykXAVnZlrZbo=;
        b=eN25eT0QHb2mIXllre1Xlp5sHTPp10ByuUXGihq4tyqxYxIlnTAS7XyN+AK/FBX2oM
         QA2JewYUU1jKnikGKQ2LFf3ODbvItHHHZyqxcxgnGQnM8Cbi4WS3tGcjTCPJzexeYEDi
         Fe7KOurswXDS5atzsneJ3VKNJuhryAEejGH8sGIXL96smh6HZu9l/fUbZfnPX6Wpm5ms
         uprg5AazwZFvvbjE3wmSFD/aMAlcUsIHLc8PHDqfOzyAfRGbXhVeVa3aQpds41Cqa5sn
         +9WUz/8gMx+5uEYkJWXPDtDFa+u6f2HoEAu7MD0/FLq63rEPLDZWVigousif/nuzK4dr
         H5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukS08Jg1OXlGw3g90VUiXACIFGwP+irykXAVnZlrZbo=;
        b=Tyf7AM9BWa+KQ5BIpnLWHOOe77jZImq+HcmJ9Jhm6mxnmv5Km/Xd4J8aL2DxWkLYb0
         qEKYbMOooSqCuBbnHmoEmLNx52PwHPv0SLkQIS7jMDRDUNE+RgQdNIZRv8tAKdqBy6Ja
         SCPhv9SIx5DUa/xpUpjaWhA0MF8No8ML//4hsZfzKi2DhEoZ+ERw/juzINKDyfI8cpBl
         lxtnRudq71u/IQ5na88PW5Mw/bIyqdk+iVWjLNMiEdkgYCk8Fls4We+69izF53cIN5Qj
         ofiqdvLUxuZ/s+UzDJM2WzHL+RffImGoO6lsY2J1AFnGEgxNgHr/nBavouhceUD9YQor
         WQXg==
X-Gm-Message-State: AOAM530xTWOh9mQRbLwxLmoRZyF/UxsoxOgnbzJBsExJiSwfi7z5yvDN
        pXAGAefb35aQSzgT+A1+MJE=
X-Google-Smtp-Source: ABdhPJxWyRpReJa6HrHmVUXhx8LT8cKRE7SUmYQi8b22wLHmxm2/Ob+IoeDDKMejw6zI1pIYvOH6KA==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr16020553wri.3.1634315718769;
        Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: r8188eu: pBandType is never set
Date:   Fri, 15 Oct 2021 18:35:05 +0200
Message-Id: <20211015163507.9091-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pBandType is never set, it stays at the default value 0. Remove it
from odm_dm_struct and remove related unneeded code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
 drivers/staging/r8188eu/hal/odm.c            | 3 ---
 drivers/staging/r8188eu/include/odm.h        | 8 --------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index f01ee3cd8795..8e9fbc9cf84d 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -317,7 +317,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][4];
 					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][5];
 
-					if ((X != 0) && (*dm_odm->pBandType == ODM_BAND_2_4G)) {
+					if (X != 0) {
 						if ((X & 0x00000200) != 0)	/* consider minus */
 							X = X | 0xFFFFFC00;
 						ele_A = ((X * ele_D) >> 8) & 0x000003FF;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index d3d13164ca8f..85bc5050cda5 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -243,9 +243,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_WM_MODE:
 		pDM_Odm->pWirelessMode = (u8 *)pValue;
 		break;
-	case	ODM_CMNINFO_BAND:
-		pDM_Odm->pBandType = (u8 *)pValue;
-		break;
 	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
 		pDM_Odm->pSecChOffset = (u8 *)pValue;
 		break;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index a8e9089433ba..9745069060d7 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -273,7 +273,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_TX_UNI,
 	ODM_CMNINFO_RX_UNI,
 	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
-	ODM_CMNINFO_BAND,		/*  ODM_BAND_TYPE_E */
 	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
 	ODM_CMNINFO_SEC_MODE,		/*  ODM_SECURITY_E */
 	ODM_CMNINFO_BW,			/*  ODM_BW_E */
@@ -405,11 +404,6 @@ enum odm_wireless_mode {
 	ODM_WM_AUTO	= BIT(5),
 };
 
-/*  ODM_CMNINFO_BAND */
-enum odm_band_type {
-	ODM_BAND_2_4G	= BIT(0),
-};
-
 /*  ODM_CMNINFO_SEC_CHNL_OFFSET */
 enum odm_sec_chnl_offset {
 	ODM_DONT_CARE	= 0,
@@ -635,8 +629,6 @@ struct odm_dm_struct {
 	u64	*pNumRxBytesUnicast;
 	/*  Wireless mode B/G/A/N = BIT(0)/BIT(1)/BIT(2)/BIT(3) */
 	u8	*pWirelessMode; /* ODM_WIRELESS_MODE_E */
-	/*  Frequence band 2.4G/5G = 0/1 */
-	u8	*pBandType;
 	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
 	u8	*pSecChOffset;
 	/*  Security mode Open/WEP/AES/TKIP = 0/1/2/3 */
-- 
2.33.0

