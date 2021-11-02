Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B744293B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKBIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhKBIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:21:42 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF827C061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:19:06 -0700 (PDT)
Received: from 74.172.62.81.static.wline.lns.sme.cust.swisscom.ch ([81.62.172.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mhp0Z-0007h9-9p; Tue, 02 Nov 2021 09:19:03 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/5] staging: r8188eu: remove ODM_Write4Byte
Date:   Tue,  2 Nov 2021 09:18:33 +0100
Message-Id: <20211102081833.18054-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211102081833.18054-1-martin@kaiser.cx>
References: <20211102081833.18054-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ODM_Write4Byte wrapper and call rtw_write32 directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c    | 4 +---
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index cbac5d908d67..655fc420eb28 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -626,13 +626,11 @@ _PHY_ReloadMACRegisters(
 	)
 {
 	u32 i;
-	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
-	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
 
 	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++)
 		rtw_write8(adapt, MACReg[i], (u8)MACBackup[i]);
 
-	ODM_Write4Byte(dm_odm, MACReg[i], MACBackup[i]);
+	rtw_write32(adapt, MACReg[i], MACBackup[i]);
 }
 
 void
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 4ac76e7892ca..966712bd3bcb 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-void ODM_Write4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 Data)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	rtw_write32(Adapter, RegAddr, Data);
-}
-
 void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 2b07ec44fdca..64c29c1da19d 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -19,8 +19,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-void ODM_Write4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 Data);
-
 void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
 		   u32 BitMask, u32 Data);
 
-- 
2.20.1

