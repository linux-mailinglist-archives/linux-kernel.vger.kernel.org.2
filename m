Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9075E44DD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhKKV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbhKKV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:29:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A27C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:27:07 -0800 (PST)
Received: from ipservice-092-217-091-158.092.217.pools.vodafone-ip.de ([92.217.91.158] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlHb4-0006fH-Vj; Thu, 11 Nov 2021 22:27:03 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/7] staging: r8188eu: remove haldata's EEPROMCustomerID
Date:   Thu, 11 Nov 2021 22:26:39 +0100
Message-Id: <20211111212644.9011-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211111212644.9011-1-martin@kaiser.cx>
References: <20211111212644.9011-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is used only in a (disabled) debug print.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 7 +------
 drivers/staging/r8188eu/hal/usb_halinit.c       | 4 +---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h | 2 --
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 84f3cfd571c6..9efdc846ba33 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1588,13 +1588,8 @@ void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo, bool Auto
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 
-	if (!AutoLoadFail) {
-		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CUSTOMERID_88E];
-	} else {
-		pHalData->EEPROMCustomerID = 0;
+	if (AutoLoadFail)
 		pHalData->EEPROMSubCustomerID = 0;
-	}
-	DBG_88E("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID);
 }
 
 void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 563b7c0a2c90..caef99d0926f 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -986,15 +986,13 @@ static void Hal_EfuseParsePIDVID_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 
 	if (!AutoLoadFail) {
 		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
-		haldata->EEPROMCustomerID = *(u8 *)&hwinfo[EEPROM_CUSTOMERID_88E];
 		haldata->EEPROMSubCustomerID = EEPROM_Default_SubCustomerID;
 	} else {
 		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
-		haldata->EEPROMCustomerID		= EEPROM_Default_CustomerID;
 		haldata->EEPROMSubCustomerID	= EEPROM_Default_SubCustomerID;
 	}
 
-	DBG_88E("Customer ID: 0x%02X, SubCustomer ID: 0x%02X\n", haldata->EEPROMCustomerID, haldata->EEPROMSubCustomerID);
+	DBG_88E("SubCustomer ID: 0x%02X\n", haldata->EEPROMSubCustomerID);
 }
 
 static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 84fa65972039..19aac5c7cffb 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -177,7 +177,6 @@ struct hal_data_8188e {
 	/*  EEPROM setting. */
 	u16	EEPROMSVID;
 	u16	EEPROMSDID;
-	u8	EEPROMCustomerID;
 	u8	EEPROMSubCustomerID;
 	u8	EEPROMVersion;
 	u8	EEPROMRegulatory;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index cfab7ad08947..8c62e8a2ca40 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -1345,8 +1345,6 @@ Current IOREG MAP
 #define	EEPROM_DEFAULT_BT_OPTION		0x10
 
 /*  For debug */
-#define EEPROM_Default_CustomerID		0xAB
-#define	EEPROM_Default_CustomerID_8188E		0x00
 #define EEPROM_Default_SubCustomerID		0xCD
 #define EEPROM_Default_Version			0
 
-- 
2.20.1

