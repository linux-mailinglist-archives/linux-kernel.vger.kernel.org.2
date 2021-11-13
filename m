Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2903844F4B3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhKMS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 13:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbhKMS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:58:50 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE44C061208
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 10:55:56 -0800 (PST)
Received: from dslb-188-096-147-224.188.096.pools.vodafone-ip.de ([188.96.147.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlyBs-0002H8-Ug; Sat, 13 Nov 2021 19:55:53 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/15] staging: r8188eu: use efuse map length define directly
Date:   Sat, 13 Nov 2021 19:55:11 +0100
Message-Id: <20211113185518.23941-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211113185518.23941-1-martin@kaiser.cx>
References: <20211113185518.23941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of the efuse data section is constant. We can use the
corresponding define directly, there's no need to get the length
from rtl8188e_EFUSE_GetEfuseDefinition.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 2999313dfe69..1a999d41483b 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -6,6 +6,7 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/rtw_efuse.h"
+#include "../include/rtl8188e_hal.h"
 
 /*------------------------Define local variable------------------------------*/
 u8 fakeEfuseBank;
@@ -234,17 +235,13 @@ void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata)
 void EFUSE_ShadowMapUpdate(struct adapter *pAdapter)
 {
 	struct eeprom_priv *pEEPROM = &pAdapter->eeprompriv;
-	u16 mapLen = 0;
-
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
 
 	if (pEEPROM->bautoload_fail_flag) {
-		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
+		memset(pEEPROM->efuse_eeprom_data, 0xFF, EFUSE_MAP_LEN_88E);
 		return;
 	}
 
 	rtl8188e_EfusePowerSwitch(pAdapter, true);
-	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, TYPE_EFUSE_MAP_LEN, (void *)&mapLen);
-	rtl8188e_ReadEFuse(pAdapter, 0, mapLen, pEEPROM->efuse_eeprom_data);
+	rtl8188e_ReadEFuse(pAdapter, 0, EFUSE_MAP_LEN_88E, pEEPROM->efuse_eeprom_data);
 	rtl8188e_EfusePowerSwitch(pAdapter, false);
 }
-- 
2.20.1

