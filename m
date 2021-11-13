Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4B44F4BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhKMS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhKMS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95615C061207
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:56:04 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyC0-0002H8-IJ; Sat, 13 Nov 2021 19:56:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 15/15] staging: r8188eu: remove the efuse_hal structure
Date:   Sat, 13 Nov 2021 19:55:18 +0100
Message-Id: <20211113185518.23941-16-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct efuse_hal is not used and can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 drivers/staging/r8188eu/include/rtw_efuse.h    | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 4bf1f5d0815a..31a46f204954 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -184,7 +184,6 @@ struct hal_data_8188e {
 	u8	bAPKThermalMeterIgnore;
 
 	bool	EepromOrEfuse;
-	struct efuse_hal	EfuseHal;
 
 	u8	Index24G_CCK_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	u8	Index24G_BW40_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 9174f3d635e4..4d8eff8e860e 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -26,15 +26,6 @@
 /*--------------------------Define Parameters-------------------------------*/
 #define		EFUSE_MAX_WORD_UNIT			4
 
-/*------------------------------Define structure----------------------------*/
-struct efuse_hal {
-	u8 fakeEfuseBank;
-	u32	fakeEfuseUsedBytes;
-	u8 fakeEfuseContent[EFUSE_MAX_HW_SIZE];
-	u8 fakeEfuseInitMap[EFUSE_MAX_MAP_LEN];
-	u8 fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN];
-};
-
 /*------------------------Export global variable----------------------------*/
 
 u8 Efuse_CalculateWordCnts(u8 word_en);
-- 
2.20.1

