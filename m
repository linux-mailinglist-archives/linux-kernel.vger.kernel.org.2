Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A121340411E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347727AbhIHWko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346814AbhIHWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:40:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDCC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 15:39:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x6so5490765wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ev+Bp/+/AMJyfm0UPz2j6n4X4wGybMjpIdHclYnCg/o=;
        b=XoPCeYcVtDCNVDvml1OplWQIFZnPPc1xDU8NZ2a7e8L7mOqk4mrrhF+O41E+0IyPey
         FkStPjoZ49pulEufZbgPVCi/ZS6pZeH6HGHgBYd1jLxetRcifV8sOJDOqImyQca3DIDE
         p3/4RNXkhPfAwMVYxWrA2/nvIimN97K0VrowPO7frmFOheSRG2RgJ5HPVOlU3mFGhqV1
         kPVdxGdEh5KdkuqMqUuhD9Lqfhd4/GgMvOyA0DPrkVjF8NiGQo9dzw/+GqBafOum+rW4
         8xZUb4s7LFBwYfKdOdkXV5m7mQXeNoXVKEh37Lp0QonvTVaWEAnSiz5+dcbjiiVy/+xv
         wVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ev+Bp/+/AMJyfm0UPz2j6n4X4wGybMjpIdHclYnCg/o=;
        b=j8RjQ+G2cgGpBA2E42bh8oUDlk+iUlYO05uBGMF2Aia/uGRfyfaUfC27sOnAwbFI5Y
         n5DgU9la9PVmxmamt1N+bbdkdtT2bnztdZ7fAX0rI28g4t+N0zGxHS3muDcXGAcmvjYw
         Z6CbegqNAJdzA/2cklv0LcvJoOX2VnLk0sq+vQ5RC4SdLzpGKmJ57QNIJDQWZzehzu0M
         /LmPH4W/ib1B0+184qsU8NVbLQ7OqPGyjQ8WhMoeYSLRcWZiQH/W1i0hSn92uQAacOO5
         5kXBbisutTpI9IJA/cQriNYv7rMtwcXaYPI44nuMHwUwxg3ISFQL9KcoVn0rEWeau6xO
         i6qQ==
X-Gm-Message-State: AOAM531EGJuSp63o+B/FG3m0O/62JtY09MuPGv9PSLM8A0SWBCiVcLIp
        RMx4eOX/IlzUWOuEV7d+ryc=
X-Google-Smtp-Source: ABdhPJwrjXLx+d3AllDMvWicC0tH55HHMoXrbFIT7Uc4xoWkUieZkV0WBkSej/+rgMZH4LDdW3SIFw==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr563415wrr.332.1631140771063;
        Wed, 08 Sep 2021 15:39:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id d29sm428643wrc.6.2021.09.08.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:39:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: remove unused rtl8192c_PHY_GetHWRegOriginalValue()
Date:   Thu,  9 Sep 2021 00:39:03 +0200
Message-Id: <20210908223903.10516-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908223903.10516-1-straube.linux@gmail.com>
References: <20210908223903.10516-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8192c_PHY_GetHWRegOriginalValue() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  | 18 ------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h   |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index dd0008bcceb6..94febe0edd35 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -609,24 +609,6 @@ int PHY_RFConfig8188E(struct adapter *Adapter)
 	return rtStatus;
 }
 
-void
-rtl8192c_PHY_GetHWRegOriginalValue(
-		struct adapter *Adapter
-	)
-{
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
-
-	/*  read rx initial gain */
-	pHalData->DefaultInitialGain[0] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XAAGCCore1, bMaskByte0);
-	pHalData->DefaultInitialGain[1] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
-	pHalData->DefaultInitialGain[2] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XCAGCCore1, bMaskByte0);
-	pHalData->DefaultInitialGain[3] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XDAGCCore1, bMaskByte0);
-
-	/*  read framesync */
-	pHalData->framesync = (u8)PHY_QueryBBReg(Adapter, rOFDM0_RxDetector3, bMaskByte0);
-	pHalData->framesyncC34 = PHY_QueryBBReg(Adapter, rOFDM0_RxDetector2, bMaskDWord);
-}
-
 static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
 			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
 			       u8 *BW40PowerLevel)
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index e5662fa9c918..ee4b26ecd19d 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -185,9 +185,6 @@ int PHY_MACConfig8188E(struct adapter *adapter);
 int PHY_BBConfig8188E(struct adapter *adapter);
 int PHY_RFConfig8188E(struct adapter *adapter);
 
-/* Read initi reg value for tx power setting. */
-void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
-
 /*  BB TX Power R/W */
 void PHY_SetTxPowerLevel8188E(struct adapter *adapter, u8 channel);
 
-- 
2.33.0

