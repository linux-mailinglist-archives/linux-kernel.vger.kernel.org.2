Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA94282D3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhJJRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhJJRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:54:45 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699AC061745
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:52:44 -0700 (PDT)
Received: from dslb-188-104-061-167.188.104.pools.vodafone-ip.de ([188.104.61.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mZd04-0001WC-KS; Sun, 10 Oct 2021 19:52:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/11] staging: r8188eu: remove odm ext lna info
Date:   Sun, 10 Oct 2021 19:52:04 +0200
Message-Id: <20211010175204.24029-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010175204.24029-1-martin@kaiser.cx>
References: <20211010175204.24029-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ext lna info is never set. Remove it and fix up the one place
where it's read.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c     | 7 +------
 drivers/staging/r8188eu/include/odm.h | 3 ---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 7d31067d95a8..5bb5ce950438 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -237,9 +237,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_BOARD_TYPE:
 		pDM_Odm->BoardType = (u8)Value;
 		break;
-	case	ODM_CMNINFO_EXT_LNA:
-		pDM_Odm->ExtLNA = (u8)Value;
-		break;
 	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
@@ -494,7 +491,7 @@ void odm_DIG(struct odm_dm_struct *pDM_Odm)
 
 	/* 1 Boundary Decision */
 	if ((pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8723A)) &&
-	    ((pDM_Odm->BoardType == ODM_BOARD_HIGHPWR) || pDM_Odm->ExtLNA)) {
+	    (pDM_Odm->BoardType == ODM_BOARD_HIGHPWR)) {
 		if (pDM_Odm->SupportPlatform & (ODM_AP | ODM_ADSL)) {
 			dm_dig_max = DM_DIG_MAX_AP_HP;
 			dm_dig_min = DM_DIG_MIN_AP_HP;
@@ -729,8 +726,6 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 
 	if (!(pDM_Odm->SupportAbility & (ODM_BB_CCK_PD | ODM_BB_FA_CNT)))
 		return;
-	if (pDM_Odm->ExtLNA)
-		return;
 	if (pDM_Odm->bLinked) {
 		if (pDM_Odm->RSSI_Min > 25) {
 			CurCCK_CCAThres = 0xcd;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 90539fa2ef2d..f4b427cfaeee 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -268,7 +268,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_IC_TYPE,		/* ODM_IC_TYPE_E */
 	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
 	ODM_CMNINFO_BOARD_TYPE,		/* ODM_BOARD_TYPE_E */
-	ODM_CMNINFO_EXT_LNA,		/* true */
 	/* HOOK BEFORE REG INIT-----------  */
 
 	/*  Dynamic value: */
@@ -646,8 +645,6 @@ struct odm_dm_struct {
 	u8	RFType;
 	/*  Board Type Normal/HighPower/MiniCard/SLIM/Combo/. = 0/1/2/3/4/. */
 	u8	BoardType;
-	/*  with external LNA  NO/Yes = 0/1 */
-	u8	ExtLNA;
 
 	u32	BK_SupportAbility;
 	u8	AntDivType;
-- 
2.20.1

