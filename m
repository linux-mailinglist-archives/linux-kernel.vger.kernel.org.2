Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC144F4B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhKMS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhKMS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:50 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6BC061206
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:55 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBr-0002H8-U6; Sat, 13 Nov 2021 19:55:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/15] staging: r8188eu: merge Efuse_ReadAllMap into EFUSE_ShadowMapUpdate
Date:   Sat, 13 Nov 2021 19:55:10 +0100
Message-Id: <20211113185518.23941-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Efuse_ReadAllMap is small, it's called only by EFUSE_ShadowMapUpdate.
This patch merges the two functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 42 +++++-------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index d799d0c7817f..2999313dfe69 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -215,35 +215,6 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 	}
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	Efuse_ReadAllMap
- *
- * Overview:	Read All Efuse content
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/11/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 *Efuse)
-{
-	u16 mapLen = 0;
-
-	rtl8188e_EfusePowerSwitch(pAdapter, true);
-
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
-
-	rtl8188e_ReadEFuse(pAdapter, 0, mapLen, Efuse);
-
-	rtl8188e_EfusePowerSwitch(pAdapter, false);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	EFUSE_ShadowMapUpdate
  *
@@ -267,8 +238,13 @@ void EFUSE_ShadowMapUpdate(struct adapter *pAdapter)
 
 	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
-	if (pEEPROM->bautoload_fail_flag)
+	if (pEEPROM->bautoload_fail_flag) {
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
-	else
-		Efuse_ReadAllMap(pAdapter, pEEPROM->efuse_eeprom_data);
-} /*  EFUSE_ShadowMapUpdate */
+		return;
+	}
+
+	rtl8188e_EfusePowerSwitch(pAdapter, true);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
+	rtl8188e_ReadEFuse(pAdapter, 0, mapLen, pEEPROM->efuse_eeprom_data);
+	rtl8188e_EfusePowerSwitch(pAdapter, false);
+}
-- 
2.20.1

