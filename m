Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8F355D25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhDFUtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbhDFUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:49:07 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1979C06174A;
        Tue,  6 Apr 2021 13:48:58 -0700 (PDT)
Received: from ipservice-092-217-067-214.092.217.pools.vodafone-ip.de ([92.217.67.214] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lTscx-0005Yc-Bh; Tue, 06 Apr 2021 22:48:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/11] staging: rtl8188eu: remove unused efuse hal components
Date:   Tue,  6 Apr 2021 22:48:19 +0200
Message-Id: <20210406204829.18130-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct hal_data_8188e contains some components related to efuses which
are not used for rtl8188eu.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/rtl8188eu/include/rtl8188e_hal.h  |  4 ----
 drivers/staging/rtl8188eu/include/rtw_efuse.h | 20 -------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index 6035c12ec578..0c4c23be1dd5 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -211,10 +211,6 @@ struct hal_data_8188e {
 	u8	bAPKThermalMeterIgnore;
 
 	bool	EepromOrEfuse;
-	/* 92C:256bytes, 88E:512bytes, we use union set (512bytes) */
-	u8	EfuseMap[2][HWSET_MAX_SIZE_512];
-	u8	EfuseUsedPercentage;
-	struct efuse_hal	EfuseHal;
 
 	u8	Index24G_CCK_Base[MAX_RF_PATH][CHANNEL_MAX_NUMBER];
 	u8	Index24G_BW40_Base[MAX_RF_PATH][CHANNEL_MAX_NUMBER];
diff --git a/drivers/staging/rtl8188eu/include/rtw_efuse.h b/drivers/staging/rtl8188eu/include/rtw_efuse.h
index 5926fc9b5e6b..74182c32c4ec 100644
--- a/drivers/staging/rtl8188eu/include/rtw_efuse.h
+++ b/drivers/staging/rtl8188eu/include/rtw_efuse.h
@@ -56,26 +56,6 @@ struct pgpkt {
 	u8 word_cnts;
 };
 
-/*------------------------------Define structure----------------------------*/
-struct efuse_hal {
-	u8 fakeEfuseBank;
-	u32	fakeEfuseUsedBytes;
-	u8 fakeEfuseContent[EFUSE_MAX_HW_SIZE];
-	u8 fakeEfuseInitMap[EFUSE_MAX_MAP_LEN];
-	u8 fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN];
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
-};
-
 u8 Efuse_CalculateWordCnts(u8 word_en);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data);
-- 
2.20.1

