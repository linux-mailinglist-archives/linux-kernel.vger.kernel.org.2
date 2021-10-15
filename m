Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8742F853
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbhJOQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbhJOQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:37:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB3C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g25so27363995wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8a4rJPFjAQSzvszKFGwkCpLD2dtRen783VqL2ERI5pg=;
        b=C4YqqqBfPNFyCZKoo6hAuuY2ANWSWDNUR+OP62LLpvd5rApMfi1UYReQ4vgH3VLghH
         OHHFdDpv2Arw7n6srcQLJWs4L5aI+IEpd1KLGlmC2gX5S2JwNCyILr0YOPYvE1VxK2Q9
         o0OB8GDDLJEreFIDADEeTkZpeLaV2HlBY8qmXxJGWsgDETK2PfDeCFkIvDUeaZtZjbyg
         Bb4qCy807NcqEU8QrXmR5JEt1pE5HwXMWFPhwF33Y1D8ut05ZDxpmv6n7DSx6/j15o3m
         PZ6VLjjFvfZzTlVPNU+3UBhemjMAQFllo1g0JxNeAZpApWHMaaPQYy6VC5PxQXXUd0Ay
         DOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8a4rJPFjAQSzvszKFGwkCpLD2dtRen783VqL2ERI5pg=;
        b=mQwN6zrw2zoMquNzQJ63knnxVjTlU+gVvT5bOU180J+uSkM4qnl2tMZJlUgczLW4dm
         FciH+5xvF2Ng9Uvun71kCplLQcgXENsDso1aki2sNpIg1Zgq2BHOG5qiZt7hyvEmLqVW
         kxwRQPxYMb2GNk3nR10kMs0q6xhDo/qP8jorXLUYILnJVtBLsGLNSXQo7rgorj9u6tSl
         oFLBWBJu9sxvaqMMFb9WjHJkxm5vPPVB5/awKU2j1/5Xp5+EjvJ50eT7cDRzF085fstA
         Kf9E1GaZMvwg725VYmIwwzfP0NpXqJ6qgpRrVNMipdu92phFYhNbSck+O3R87obhYawn
         wIqQ==
X-Gm-Message-State: AOAM5321wAnwFlBx2V9SMR9EmH6HYaSx8P7RoDmND36uCLqiovdYZnyX
        leMCCfnsTqf00hAMZJCF3wI=
X-Google-Smtp-Source: ABdhPJznGjgureci6zD392KkWCZNi0R3A10/lwT6+1Xnv+CJp7w9jYy65XyBFrfrI4+usu1zw5FFVw==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr15390785wru.177.1634315717477;
        Fri, 15 Oct 2021 09:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ad78])
        by smtp.gmail.com with ESMTPSA id c17sm5489593wrq.4.2021.10.15.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:35:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: r8188eu: remove GetPSDData()
Date:   Fri, 15 Oct 2021 18:35:03 +0200
Message-Id: <20211015163507.9091-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function GetPSDData() is not used, remove it. It is the only user of
ConvertTo_dB() and ODM_StallExecution(), remove these two functions
and the now unused dB_Invert_Table as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 59 -------------------
 drivers/staging/r8188eu/hal/odm_interface.c   |  5 --
 drivers/staging/r8188eu/include/odm.h         |  5 --
 .../staging/r8188eu/include/odm_interface.h   |  2 -
 4 files changed, 71 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 030bc7bd9905..28bd6f36cddd 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -5,17 +5,6 @@
 
 #include "../include/odm_precomp.h"
 
-static const u16 dB_Invert_Table[8][12] = {
-	{1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4},
-	{4, 5, 6, 6, 7, 8, 9, 10, 11, 13, 14, 16},
-	{18, 20, 22, 25, 28, 32, 35, 40, 45, 50, 56, 63},
-	{71, 79, 89, 100, 112, 126, 141, 158, 178, 200, 224, 251},
-	{282, 316, 355, 398, 447, 501, 562, 631, 708, 794, 891, 1000},
-	{1122, 1259, 1413, 1585, 1778, 1995, 2239, 2512, 2818, 3162, 3548, 3981},
-	{4467, 5012, 5623, 6310, 7079, 7943, 8913, 10000, 11220, 12589, 14125, 15849},
-	{17783, 19953, 22387, 25119, 28184, 31623, 35481, 39811, 44668, 50119, 56234, 65535}
-};
-
 /* avoid to warn in FreeBSD ==> To DO modify */
 static u32 EDCAParam[HT_IOT_PEER_MAX][3] = {
 	/*  UL			DL */
@@ -1142,51 +1131,3 @@ void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
 	pxmitpriv->last_tx_bytes = pxmitpriv->tx_bytes;
 	precvpriv->last_rx_bytes = precvpriv->rx_bytes;
 }
-
-/*  need to ODM CE Platform */
-/* move to here for ANT detection mechanism using */
-
-u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point, u8 initial_gain_psd)
-{
-	u32 psd_report;
-
-	/* Set DCO frequency index, offset=(40MHz/SamplePts)*point */
-	ODM_SetBBReg(pDM_Odm, 0x808, 0x3FF, point);
-
-	/* Start PSD calculation, Reg808[22]=0->1 */
-	ODM_SetBBReg(pDM_Odm, 0x808, BIT(22), 1);
-	/* Need to wait for HW PSD report */
-	ODM_StallExecution(30);
-	ODM_SetBBReg(pDM_Odm, 0x808, BIT(22), 0);
-	/* Read PSD report, Reg8B4[15:0] */
-	psd_report = ODM_GetBBReg(pDM_Odm, 0x8B4, bMaskDWord) & 0x0000FFFF;
-
-	psd_report = (u32)(ConvertTo_dB(psd_report)) + (u32)(initial_gain_psd - 0x1c);
-
-	return psd_report;
-}
-
-u32 ConvertTo_dB(u32 Value)
-{
-	u8 i;
-	u8 j;
-	u32 dB;
-
-	Value = Value & 0xFFFF;
-	for (i = 0; i < 8; i++) {
-		if (Value <= dB_Invert_Table[i][11])
-			break;
-	}
-
-	if (i >= 8)
-		return 96;	/*  maximum 96 dB */
-
-	for (j = 0; j < 12; j++) {
-		if (Value <= dB_Invert_Table[i][j])
-			break;
-	}
-
-	dB = i * 12 + j + 1;
-
-	return dB;
-}
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index c97104c3682f..7ddba39a0f4b 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -77,11 +77,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  ODM Timer relative API. */
-void ODM_StallExecution(u32 usDelay)
-{
-	udelay(usDelay);
-}
-
 void ODM_delay_ms(u32 ms)
 {
 	mdelay(ms);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 21e08a9f8bf8..db24678eb0bc 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -880,11 +880,6 @@ void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm);
 bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI,
 		      bool bForceUpdate, u8 *pRATRState);
 
-u32 ConvertTo_dB(u32 Value);
-
-u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point,
-	       u8 initial_gain_psd);
-
 u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid,
 			u32 ra_mask, u8 rssi_level);
 
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 3af58e853828..17a315d19a50 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -50,8 +50,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM Timer relative API. */
-void ODM_StallExecution(u32 usDelay);
-
 void ODM_delay_ms(u32 ms);
 
 void ODM_delay_us(u32 us);
-- 
2.33.0

