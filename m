Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1924282D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhJJRyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhJJRyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:54:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB56C06176A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:52:42 -0700 (PDT)
Received: from dslb-188-104-061-167.188.104.pools.vodafone-ip.de ([188.104.61.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mZd02-0001WC-Ex; Sun, 10 Oct 2021 19:52:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/11] staging: r8188eu: remove odm ext trsw info
Date:   Sun, 10 Oct 2021 19:52:02 +0200
Message-Id: <20211010175204.24029-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010175204.24029-1-martin@kaiser.cx>
References: <20211010175204.24029-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ext trsw info is not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/odm.c     | 3 ---
 drivers/staging/r8188eu/include/odm.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index c094cffb9e6a..cf0881642207 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -243,9 +243,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_EXT_PA:
 		pDM_Odm->ExtPA = (u8)Value;
 		break;
-	case	ODM_CMNINFO_EXT_TRSW:
-		pDM_Odm->ExtTRSW = (u8)Value;
-		break;
 	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
 	default:
 		/* do nothing */
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 462424f0a49b..346dc04a50e6 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -270,7 +270,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_BOARD_TYPE,		/* ODM_BOARD_TYPE_E */
 	ODM_CMNINFO_EXT_LNA,		/* true */
 	ODM_CMNINFO_EXT_PA,
-	ODM_CMNINFO_EXT_TRSW,
 	/* HOOK BEFORE REG INIT-----------  */
 
 	/*  Dynamic value: */
@@ -652,8 +651,6 @@ struct odm_dm_struct {
 	u8	ExtLNA;
 	/*  with external PA  NO/Yes = 0/1 */
 	u8	ExtPA;
-	/*  with external TRSW  NO/Yes = 0/1 */
-	u8	ExtTRSW;
 
 	u32	BK_SupportAbility;
 	u8	AntDivType;
-- 
2.20.1

