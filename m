Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5A423150
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhJEUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhJEUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:10:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D525C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:08:57 -0700 (PDT)
Received: from ipservice-092-217-085-112.092.217.pools.vodafone-ip.de ([92.217.85.112] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mXqk9-000847-6e; Tue, 05 Oct 2021 22:08:53 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 9/9] staging: r8188eu: support interface is always usb
Date:   Tue,  5 Oct 2021 22:08:21 +0200
Message-Id: <20211005200821.19783-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211005200821.19783-1-martin@kaiser.cx>
References: <20211005200821.19783-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We set ODM_CMNINFO_INTERFACE to ODM_ITRF_USB as this driver supports
only usb. Therefore, dm_odm->SupportInterface is always ODM_ITRF_USB.

Simplify some if conditions accordingly. Remove/replace two empty
functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 58 +++++++---------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 86c2e03dcdce..2383f965f689 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -17,54 +17,34 @@ static u8 odm_QueryRxPwrPercentage(s8 AntPower)
 		return 100 + AntPower;
 }
 
-/*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
-/*  IF other SW team do not support the feature, remove this section.?? */
-static s32 odm_sig_patch_lenove(struct odm_dm_struct *dm_odm, s32 CurrSig)
-{
-	return 0;
-}
-
-static s32 odm_sig_patch_netcore(struct odm_dm_struct *dm_odm, s32 CurrSig)
-{
-	return 0;
-}
-
 static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 CurrSig)
 {
 	s32 RetSig = 0;
 
-	if ((dm_odm->SupportInterface  == ODM_ITRF_USB) ||
-	    (dm_odm->SupportInterface  == ODM_ITRF_SDIO)) {
-		if (CurrSig >= 51 && CurrSig <= 100)
-			RetSig = 100;
-		else if (CurrSig >= 41 && CurrSig <= 50)
-			RetSig = 80 + ((CurrSig - 40) * 2);
-		else if (CurrSig >= 31 && CurrSig <= 40)
-			RetSig = 66 + (CurrSig - 30);
-		else if (CurrSig >= 21 && CurrSig <= 30)
-			RetSig = 54 + (CurrSig - 20);
-		else if (CurrSig >= 10 && CurrSig <= 20)
-			RetSig = 42 + (((CurrSig - 10) * 2) / 3);
-		else if (CurrSig >= 5 && CurrSig <= 9)
-			RetSig = 22 + (((CurrSig - 5) * 3) / 2);
-		else if (CurrSig >= 1 && CurrSig <= 4)
-			RetSig = 6 + (((CurrSig - 1) * 3) / 2);
-		else
-			RetSig = CurrSig;
-	}
+	if (CurrSig >= 51 && CurrSig <= 100)
+		RetSig = 100;
+	else if (CurrSig >= 41 && CurrSig <= 50)
+		RetSig = 80 + ((CurrSig - 40) * 2);
+	else if (CurrSig >= 31 && CurrSig <= 40)
+		RetSig = 66 + (CurrSig - 30);
+	else if (CurrSig >= 21 && CurrSig <= 30)
+		RetSig = 54 + (CurrSig - 20);
+	else if (CurrSig >= 10 && CurrSig <= 20)
+		RetSig = 42 + (((CurrSig - 10) * 2) / 3);
+	else if (CurrSig >= 5 && CurrSig <= 9)
+		RetSig = 22 + (((CurrSig - 5) * 3) / 2);
+	else if (CurrSig >= 1 && CurrSig <= 4)
+		RetSig = 6 + (((CurrSig - 1) * 3) / 2);
+	else
+		RetSig = CurrSig;
+
 	return RetSig;
 }
 
 static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
 {
-	if ((dm_odm->SupportPlatform == ODM_MP) &&
-	    (dm_odm->SupportInterface != ODM_ITRF_PCIE) && /* USB & SDIO */
-	    (dm_odm->PatchID == 10))
-		return odm_sig_patch_netcore(dm_odm, CurrSig);
-	else if ((dm_odm->SupportPlatform == ODM_MP) &&
-		 (dm_odm->SupportInterface == ODM_ITRF_PCIE) &&
-		 (dm_odm->PatchID == 19))
-		return odm_sig_patch_lenove(dm_odm, CurrSig);
+	if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 10))
+		return 0;
 	else
 		return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
 }
-- 
2.20.1

