Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9D44F4B8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhKMS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbhKMS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C490C06120F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:56:01 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBx-0002H8-Sc; Sat, 13 Nov 2021 19:55:57 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/15] staging: r8188eu: remove bt efuse definitions
Date:   Sat, 13 Nov 2021 19:55:16 +0100
Message-Id: <20211113185518.23941-14-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use bt efuses. Remove global variables and
definitions related to bt efuses.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    |  9 --------
 drivers/staging/r8188eu/include/rtw_efuse.h | 24 ---------------------
 2 files changed, 33 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index d226aee68085..b7f2274c62ac 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -15,15 +15,6 @@ u8 fakeEfuseContent[EFUSE_MAX_HW_SIZE] = {0};
 u8 fakeEfuseInitMap[EFUSE_MAX_MAP_LEN] = {0};
 u8 fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN] = {0};
 
-u32 BTEfuseUsedBytes;
-u8 BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
-u8 BTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
-u8 BTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
-
-u32 fakeBTEfuseUsedBytes;
-u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
-u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
-u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 /*------------------------Define local variable------------------------------*/
 
 #define REG_EFUSE_CTRL		0x0030
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 0696d850d2d3..b402531e639a 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -23,10 +23,6 @@
 
 #define		EFUSE_REPEAT_THRESHOLD_			3
 
-/*	The following is for BT Efuse definition */
-#define		EFUSE_BT_MAX_MAP_LEN		1024
-#define		EFUSE_MAX_BANK			4
-#define		EFUSE_MAX_BT_BANK		(EFUSE_MAX_BANK-1)
 /*--------------------------Define Parameters-------------------------------*/
 #define		EFUSE_MAX_WORD_UNIT			4
 
@@ -37,17 +33,6 @@ struct efuse_hal {
 	u8 fakeEfuseContent[EFUSE_MAX_HW_SIZE];
 	u8 fakeEfuseInitMap[EFUSE_MAX_MAP_LEN];
 	u8 fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN];
-
-	u16 BTEfuseUsedBytes;
-	u8 BTEfuseUsedPercentage;
-	u8 BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
-	u8 BTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN];
-	u8 BTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN];
-
-	u16 fakeBTEfuseUsedBytes;
-	u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
-	u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN];
-	u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN];
 };
 
 /*------------------------Export global variable----------------------------*/
@@ -57,15 +42,6 @@ extern u8 fakeEfuseContent[];
 extern u8 fakeEfuseInitMap[];
 extern u8 fakeEfuseModifiedMap[];
 
-extern u32 BTEfuseUsedBytes;
-extern u8 BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
-extern u8 BTEfuseInitMap[];
-extern u8 BTEfuseModifiedMap[];
-
-extern u32 fakeBTEfuseUsedBytes;
-extern u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
-extern u8 fakeBTEfuseInitMap[];
-extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
-- 
2.20.1

