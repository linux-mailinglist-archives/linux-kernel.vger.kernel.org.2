Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB1418036
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhIYHlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhIYHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 03:41:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E39C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:40:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so34105444wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zUoYPrdsXVCfbzQ591b/2xnz2JhbpgrLtyixMju3BfU=;
        b=JgTWNgML8CCG9X/ioFZCJuF4ADZDlgFQ6WFCxzjM4MUHDxULwnQZOOBU8eRZbzRcW0
         PfewMfMEhLogP4AfjaKTdwYSZUihvRwymPxLusSatfDV7OA33X/GBk+O8oQkRirb5Ccb
         wfybw7VWLrKq/UdPdu9DUzu3ixdSgUzFt3kfnrMNH5MLTM0W1FmPra3GZkydjZimP79a
         VOalmmHp+MFihh765UOhLQP5bMsp1sxmPlDz3ePscVFa4rvq9yJui5TaWyF0Xhz1AOWK
         FdW4baHWumeRgYbHPdPd68/acoQS200Dwt3TKvSmeQm+F5y0Ultgre1KLovbr/GfnSr1
         Hc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zUoYPrdsXVCfbzQ591b/2xnz2JhbpgrLtyixMju3BfU=;
        b=fHAeX17YK+aL6bk4+4y433CZRIOoTH98pMA+PVAD3xrJpkRoUjsqaDy6suxMt05QZJ
         bUQjuMi2S441u6dl+4UdgiOJoQhettwqFo9gq467kCY9fPJHgGX14miIJhOpktswcUec
         nRga41FPt3h1CoZguiUdxaQMRYEg3j9oe9zmuIJBnq/yEm6KUqQxBHFmHcFz8+iUe1Lz
         FWS7RHUgmNgpgiG2uEYC+eYFDBtWE5grkTQLG0bzRbAdC2I8DlExzgy3vjLJNl0dbDPl
         NA05cA5yHgI04W6VkZX1E6b4b2LwmX/Lf6wP+V9X8c/2twth/bXEmzexUqZgiOPupyCw
         pd8w==
X-Gm-Message-State: AOAM531aVCt3/Q8xNVvLICgWvPVkaLQ97KzXmFx3TZ5HBIs9AD1Y3VIR
        xmVxT6LhnfTpBK1fV1E2K0Q=
X-Google-Smtp-Source: ABdhPJynZRqMQpXwkL44WXWe7A68HlzQIzz3d4ASIFGZaRcsxh7HZf1upHkFZSWa9szCLqhJToPlng==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr15833269wry.364.1632555618376;
        Sat, 25 Sep 2021 00:40:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::dc89])
        by smtp.gmail.com with ESMTPSA id i187sm11343897wma.0.2021.09.25.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 00:40:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove ODM_CheckPowerStatus()
Date:   Sat, 25 Sep 2021 09:40:13 +0200
Message-Id: <20210925074013.14693-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ODM_CheckPowerStatus() returns always true. Checking its
return value is not necessary. Remove the function and related code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 34ca1d0066e8..f01ee3cd8795 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -627,24 +627,12 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u
 	}
 }
 
-/*  */
-/*  2011/07/26 MH Add an API for testing IQK fail case. */
-/*  */
-/*  MP Already declare in odm.c */
-static bool ODM_CheckPowerStatus(struct adapter *Adapter)
-{
-	return	true;
-}
-
 void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegisterNum)
 {
 	u32 i;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
-	if (!ODM_CheckPowerStatus(adapt))
-		return;
-
 	for (i = 0; i < RegisterNum; i++) {
 		ADDABackup[i] = ODM_GetBBReg(dm_odm, ADDAReg[i], bMaskDWord);
 	}
@@ -1074,8 +1062,6 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 	bool is2t;
 
 	is2t = (dm_odm->RFType == ODM_2T2R) ? true : false;
-	if (!ODM_CheckPowerStatus(adapt))
-		return;
 
 	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
 		return;
-- 
2.33.0

