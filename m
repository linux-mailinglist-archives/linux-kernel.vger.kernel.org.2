Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCACE40783E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhIKN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbhIKN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:15 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9D7C0613E2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:24:02 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP2z2-000604-SL; Sat, 11 Sep 2021 15:23:52 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove write-only variable bLCKInProgress
Date:   Sat, 11 Sep 2021 15:23:38 +0200
Message-Id: <20210911132338.1415-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bLCKInProgress in struct odm_rf_cal is never read. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 4 ----
 drivers/staging/r8188eu/include/odm.h        | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 6e0abaf58791..d9693c8014ce 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -1212,16 +1212,12 @@ void PHY_LCCalibrate_8188E(struct adapter *adapt)
 		timecount += 50;
 	}
 
-	dm_odm->RFCalibrateInfo.bLCKInProgress = true;
-
 	if (dm_odm->RFType == ODM_2T2R) {
 		phy_LCCalibrate_8188E(adapt, true);
 	} else {
 		/*  For 88C 1T1R */
 		phy_LCCalibrate_8188E(adapt, false);
 	}
-
-	dm_odm->RFCalibrateInfo.bLCKInProgress = false;
 }
 
 static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2t)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 7c8f082930dd..cda8b3ffe0be 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -679,7 +679,6 @@ struct odm_rf_cal {
 	u32	Reg864;
 
 	bool	bIQKInitialized;
-	bool	bLCKInProgress;
 	bool	bAntennaDetected;
 	u32	ADDA_backup[IQK_ADDA_REG_NUM];
 	u32	IQK_MAC_backup[IQK_MAC_REG_NUM];
-- 
2.20.1

