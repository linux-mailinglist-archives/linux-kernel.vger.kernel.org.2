Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0DE4282D1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhJJRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhJJRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:54:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607EC061767
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:52:41 -0700 (PDT)
Received: from dslb-188-104-061-167.188.104.pools.vodafone-ip.de ([188.104.61.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mZd01-0001WC-JR; Sun, 10 Oct 2021 19:52:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/11] staging: r8188eu: remove odm hct test info
Date:   Sun, 10 Oct 2021 19:52:01 +0200
Message-Id: <20211010175204.24029-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010175204.24029-1-martin@kaiser.cx>
References: <20211010175204.24029-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "in hct test" variable is never set, it's always 0.

Remove the variable and fix up the one place where it was used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c          | 3 ---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 2 +-
 drivers/staging/r8188eu/include/odm.h      | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index f76bdf3d9a80..c094cffb9e6a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -246,9 +246,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_EXT_TRSW:
 		pDM_Odm->ExtTRSW = (u8)Value;
 		break;
-	case	ODM_CMNINFO_BINHCT_TEST:
-		pDM_Odm->bInHctTest = (bool)Value;
-		break;
 	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 2ae1a001d339..8e419fd88a12 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -143,7 +143,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		if (pPktinfo->bPacketMatchBSSID) {
 			u8 SQ, SQ_rpt;
 
-			if (pPhyInfo->RxPWDBAll > 40 && !dm_odm->bInHctTest) {
+			if (pPhyInfo->RxPWDBAll > 40) {
 				SQ = 100;
 			} else {
 				SQ_rpt = pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index a4e5d4f9f0b9..462424f0a49b 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -271,7 +271,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_EXT_LNA,		/* true */
 	ODM_CMNINFO_EXT_PA,
 	ODM_CMNINFO_EXT_TRSW,
-	ODM_CMNINFO_BINHCT_TEST,
 	/* HOOK BEFORE REG INIT-----------  */
 
 	/*  Dynamic value: */
@@ -655,7 +654,6 @@ struct odm_dm_struct {
 	u8	ExtPA;
 	/*  with external TRSW  NO/Yes = 0/1 */
 	u8	ExtTRSW;
-	bool	bInHctTest;
 
 	u32	BK_SupportAbility;
 	u8	AntDivType;
-- 
2.20.1

