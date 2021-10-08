Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18E7426F88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhJHR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:28:25 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B30EC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:26:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so32043836wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fah6fMg3qj46qR+RN20MjI9vCGiqxDv/9mCcKXLHlzU=;
        b=qEBIWBGsMqbjtO+6chLcT7CNx4AIvrqniID3DIg4cZqWDsqvVU/rZuFNc7Z1bjYwsz
         GtNJtOx7k7JUhDgAKz5bRnGdHSZr2Io4h09AhVCw7ZZjDR7zZVje6gi0j9qLaBSYAd4T
         AcQa0UZjetlmWQkjIQtZY88fUjWi0UjcVzVnf1EVZIutuuNi20pCoQRNyRnJy3k0MhJH
         T+iQUvp8CNVhI4BM8dMg0tHf6clkrLY81CtpMH8jqZgJygvyD3ub33L30M05u32ZidG0
         +XMyWi8chHA2Dw2sa43U9ipk6rgd5IVHSix4vnPVUk10Hmn9bXeLn4d+xLIPN/qZPOA2
         j/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fah6fMg3qj46qR+RN20MjI9vCGiqxDv/9mCcKXLHlzU=;
        b=kATjd98t8vqlE6/YQNEH0aoHlb1JKW8AVMPj5xps3Mfw8HiHcvvuHcxuwVuctkbt+9
         yAG8+zsuuz8sWDXZKBqYH4/qZA/qL6DxN0BxWlMTJbe3OxUw1xGocnYEMupuxF2r+9PN
         AOdaj8xJpxdiYdlWfUzKhqNtqvQRINDVnUMwAZXbvWbKlHK+LHdYb5y9wi4AWy82pe/7
         sMS+sLUJSeisaJXbQ6Wnbx4Vc1mO5lMY5V0qrF72+Njkx1FfMUxAeP6DCribjtMD6wz7
         Vy8qy5Imd0ycXGVRM4VwH5jdfaDXJVClMcAW0p5intFcPPA3jga+f7GaY69C36sSa71R
         BJGg==
X-Gm-Message-State: AOAM531VvRuV5v1M+fVQt2e9znzVvqL6c5kyJvK8Dde6UVuw2VneQWKS
        5zoYPldSYhBusUxuci7cqpU=
X-Google-Smtp-Source: ABdhPJwL/0AmBXev2xD93BuHSliY7tqUR4qWFZvht8EafV6HhK29M/t7wRT82QC30LmkHgh8vnOCOA==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr4849133wmq.26.1633713988669;
        Fri, 08 Oct 2021 10:26:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id 61sm3212780wrl.94.2021.10.08.10.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:26:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove some dead code
Date:   Fri,  8 Oct 2021 19:26:21 +0200
Message-Id: <20211008172621.8721-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver SupportICType is ODM_RTL8188E and SupportInterface is
ODM_ITRF_USB. Remove an if statement that is never true and remove
function odm_DIGbyRSSI_LPS() which is used only in this dead if block.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Tested on x86_64 with Inter-Tech DMG-02.

 drivers/staging/r8188eu/hal/odm.c     | 59 +--------------------------
 drivers/staging/r8188eu/include/odm.h | 14 -------
 2 files changed, 1 insertion(+), 72 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index bc49dc856a60..d3f8c7442daf 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -186,17 +186,7 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 	odm_FalseAlarmCounterStatistics(pDM_Odm);
 	odm_RSSIMonitorCheck(pDM_Odm);
 
-	/* For CE Platform(SPRD or Tablet) */
-	/* 8723A or 8189ES platform */
-	/* NeilChen--2012--08--24-- */
-	/* Fix Leave LPS issue */
-	if ((pDM_Odm->Adapter->pwrctrlpriv.pwr_mode != PS_MODE_ACTIVE) &&/*  in LPS mode */
-	    ((pDM_Odm->SupportICType & (ODM_RTL8723A)) ||
-	    (pDM_Odm->SupportICType & (ODM_RTL8188E) &&
-	    ((pDM_Odm->SupportInterface  == ODM_ITRF_SDIO)))))
-		odm_DIGbyRSSI_LPS(pDM_Odm);
-	else
-		odm_DIG(pDM_Odm);
+	odm_DIG(pDM_Odm);
 	odm_CCKPacketDetectionThresh(pDM_Odm);
 
 	if (*pDM_Odm->pbPowerSaving)
@@ -456,53 +446,6 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	}
 }
 
-/* Need LPS mode for CE platform --2012--08--24--- */
-/* 8723AS/8189ES */
-void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm)
-{
-	struct adapter *pAdapter = pDM_Odm->Adapter;
-	struct false_alarm_stats *pFalseAlmCnt = &pDM_Odm->FalseAlmCnt;
-
-	u8 RSSI_Lower = DM_DIG_MIN_NIC;   /* 0x1E or 0x1C */
-	u8 bFwCurrentInPSMode = false;
-	u8 CurrentIGI = pDM_Odm->RSSI_Min;
-
-	if (!(pDM_Odm->SupportICType & (ODM_RTL8723A | ODM_RTL8188E)))
-		return;
-
-	CurrentIGI = CurrentIGI + RSSI_OFFSET_DIG;
-	bFwCurrentInPSMode = pAdapter->pwrctrlpriv.bFwCurrentInPSMode;
-
-	/*  Using FW PS mode to make IGI */
-	if (bFwCurrentInPSMode) {
-		/* Adjust by  FA in LPS MODE */
-		if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_LPS)
-			CurrentIGI = CurrentIGI + 2;
-		else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1_LPS)
-			CurrentIGI = CurrentIGI + 1;
-		else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0_LPS)
-			CurrentIGI = CurrentIGI - 1;
-	} else {
-		CurrentIGI = RSSI_Lower;
-	}
-
-	/* Lower bound checking */
-
-	/* RSSI Lower bound check */
-	if ((pDM_Odm->RSSI_Min - 10) > DM_DIG_MIN_NIC)
-		RSSI_Lower = (pDM_Odm->RSSI_Min - 10);
-	else
-		RSSI_Lower = DM_DIG_MIN_NIC;
-
-	/* Upper and Lower Bound checking */
-	if (CurrentIGI > DM_DIG_MAX_NIC)
-		CurrentIGI = DM_DIG_MAX_NIC;
-	else if (CurrentIGI < RSSI_Lower)
-		CurrentIGI = RSSI_Lower;
-
-	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
-}
-
 void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 48d383f91c16..ac053312d817 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -4,18 +4,6 @@
 #ifndef	__HALDMOUTSRC_H__
 #define __HALDMOUTSRC_H__
 
-/*  */
-/* 3 PSD Handler */
-/* 3============================================================ */
-
-/*  LPS define */
-#define DM_DIG_FA_TH0_LPS		4 /*  4 in lps */
-#define DM_DIG_FA_TH1_LPS		15 /*  15 lps */
-#define DM_DIG_FA_TH2_LPS		30 /*  30 lps */
-#define RSSI_OFFSET_DIG			0x05;
-
-/*  structure and define */
-
 /*  Add for AP/ADSLpseudo DM structuer requirement. */
 /*  We need to remove to other position??? */
 struct rtl8192cd_priv {
@@ -972,8 +960,6 @@ u32 ConvertTo_dB(u32 Value);
 u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point,
 	       u8 initial_gain_psd);
 
-void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm);
-
 u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid,
 			u32 ra_mask, u8 rssi_level);
 
-- 
2.33.0

