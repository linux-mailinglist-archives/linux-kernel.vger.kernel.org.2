Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7203444F4B4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhKMS7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbhKMS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:50 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10416C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:58 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBt-0002H8-VL; Sat, 13 Nov 2021 19:55:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/15] staging: r8188eu: rtl8188e_EFUSE_GetEfuseDefinition is unused
Date:   Sat, 13 Nov 2021 19:55:12 +0100
Message-Id: <20211113185518.23941-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we use the map length directly, rtl8188e_EFUSE_GetEfuseDefinition
is no longer needed and can be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 68 -------------------
 drivers/staging/r8188eu/include/hal_intf.h    |  1 -
 drivers/staging/r8188eu/include/rtw_efuse.h   | 10 ---
 3 files changed, 79 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 55b750b4d6ff..b7d5b5775ff5 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -835,74 +835,6 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8
 	ReadEFuseByIC(Adapter, _offset, _size_byte, pbuf);
 }
 
-/* Do not support BT */
-static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 type, void *pOut)
-{
-	switch (type) {
-	case TYPE_EFUSE_MAX_SECTION:
-		{
-			u8 *pMax_section;
-			pMax_section = (u8 *)pOut;
-			*pMax_section = EFUSE_MAX_SECTION_88E;
-		}
-		break;
-	case TYPE_EFUSE_REAL_CONTENT_LEN:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
-		}
-		break;
-	case TYPE_EFUSE_CONTENT_LEN_BANK:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
-		}
-		break;
-	case TYPE_AVAILABLE_EFUSE_BYTES_BANK:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
-		}
-		break;
-	case TYPE_AVAILABLE_EFUSE_BYTES_TOTAL:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E - EFUSE_OOB_PROTECT_BYTES_88E);
-		}
-		break;
-	case TYPE_EFUSE_MAP_LEN:
-		{
-			u16 *pu2Tmp;
-			pu2Tmp = (u16 *)pOut;
-			*pu2Tmp = (u16)EFUSE_MAP_LEN_88E;
-		}
-		break;
-	case TYPE_EFUSE_PROTECT_BYTES_BANK:
-		{
-			u8 *pu1Tmp;
-			pu1Tmp = (u8 *)pOut;
-			*pu1Tmp = (u8)(EFUSE_OOB_PROTECT_BYTES_88E);
-		}
-		break;
-	default:
-		{
-			u8 *pu1Tmp;
-			pu1Tmp = (u8 *)pOut;
-			*pu1Tmp = 0;
-		}
-		break;
-	}
-}
-
-void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut)
-{
-	Hal_EFUSEGetEfuseDefinition88E(pAdapter, type, pOut);
-}
-
 void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	u32				value32;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1f69aae7cb0e..693eb32fe1a9 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -122,7 +122,6 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
 void rtl8188e_free_hal_data(struct adapter *padapter);
 void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 PwrState);
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf);
-void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 type, void *pOut);
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 7c4c84d74bc2..fe421fff127a 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -11,16 +11,6 @@
 #define	EFUSE_WIFI				0
 #define	EFUSE_BT				1
 
-enum _EFUSE_DEF_TYPE {
-	TYPE_EFUSE_MAX_SECTION				= 0,
-	TYPE_EFUSE_REAL_CONTENT_LEN			= 1,
-	TYPE_AVAILABLE_EFUSE_BYTES_BANK		= 2,
-	TYPE_AVAILABLE_EFUSE_BYTES_TOTAL	= 3,
-	TYPE_EFUSE_MAP_LEN					= 4,
-	TYPE_EFUSE_PROTECT_BYTES_BANK		= 5,
-	TYPE_EFUSE_CONTENT_LEN_BANK			= 6,
-};
-
 /* E-Fuse */
 #define EFUSE_MAP_SIZE      512
 #define EFUSE_MAX_SIZE      256
-- 
2.20.1

