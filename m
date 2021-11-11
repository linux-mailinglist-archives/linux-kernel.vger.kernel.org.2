Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7433044DD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhKKVaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhKKV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:29:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19E5C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 13:27:07 -0800 (PST)
Received: from ipservice-092-217-091-158.092.217.pools.vodafone-ip.de ([92.217.91.158] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mlHb2-0006fH-OO; Thu, 11 Nov 2021 22:27:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/7] staging: r8188eu: remove haldata's EEPROMVID / PID
Date:   Thu, 11 Nov 2021 22:26:38 +0100
Message-Id: <20211111212644.9011-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are used only in a (disabled) debug print.

In practice, lsusb can be used to read the actual vid and pid.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c       | 8 --------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
 drivers/staging/r8188eu/include/rtl8188e_spec.h | 2 --
 3 files changed, 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index ef1ae95d7db0..563b7c0a2c90 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -985,23 +985,15 @@ static void Hal_EfuseParsePIDVID_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
 
 	if (!AutoLoadFail) {
-		/*  VID, PID */
-		haldata->EEPROMVID = EF2BYTE(*(__le16 *)&hwinfo[EEPROM_VID_88EU]);
-		haldata->EEPROMPID = EF2BYTE(*(__le16 *)&hwinfo[EEPROM_PID_88EU]);
-
 		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
 		haldata->EEPROMCustomerID = *(u8 *)&hwinfo[EEPROM_CUSTOMERID_88E];
 		haldata->EEPROMSubCustomerID = EEPROM_Default_SubCustomerID;
 	} else {
-		haldata->EEPROMVID			= EEPROM_Default_VID;
-		haldata->EEPROMPID			= EEPROM_Default_PID;
-
 		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
 		haldata->EEPROMCustomerID		= EEPROM_Default_CustomerID;
 		haldata->EEPROMSubCustomerID	= EEPROM_Default_SubCustomerID;
 	}
 
-	DBG_88E("VID = 0x%04X, PID = 0x%04X\n", haldata->EEPROMVID, haldata->EEPROMPID);
 	DBG_88E("Customer ID: 0x%02X, SubCustomer ID: 0x%02X\n", haldata->EEPROMCustomerID, haldata->EEPROMSubCustomerID);
 }
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index d7db1dfc39d0..84fa65972039 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -175,8 +175,6 @@ struct hal_data_8188e {
 	u8	BoardType;
 
 	/*  EEPROM setting. */
-	u16	EEPROMVID;
-	u16	EEPROMPID;
 	u16	EEPROMSVID;
 	u16	EEPROMSDID;
 	u8	EEPROMCustomerID;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 01aeaa4ac605..cfab7ad08947 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -1345,8 +1345,6 @@ Current IOREG MAP
 #define	EEPROM_DEFAULT_BT_OPTION		0x10
 
 /*  For debug */
-#define EEPROM_Default_PID			0x1234
-#define EEPROM_Default_VID			0x5678
 #define EEPROM_Default_CustomerID		0xAB
 #define	EEPROM_Default_CustomerID_8188E		0x00
 #define EEPROM_Default_SubCustomerID		0xCD
-- 
2.20.1

