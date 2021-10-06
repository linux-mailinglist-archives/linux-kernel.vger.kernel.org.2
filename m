Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141A2423A41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhJFJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhJFJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:12:09 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D5C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:10:17 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mY2wH-0006je-Ik; Wed, 06 Oct 2021 11:10:13 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] staging: r8188eu: hal data's customer id is always 0
Date:   Wed,  6 Oct 2021 11:09:47 +0200
Message-Id: <20211006090949.1694-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211006090949.1694-1-martin@kaiser.cx>
References: <20211006090949.1694-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CustomerID in struct hal_data_8188e is never set, it remains at the
default value 0.

Remove CustomerID and fix the two places where it was used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 -
 drivers/staging/r8188eu/include/rtw_eeprom.h  | 55 -------------------
 4 files changed, 2 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 1a0176a60704..1bfe12b5fefb 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -52,7 +52,7 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
 
-	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PATCH_ID, hal_data->CustomerID);
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PATCH_ID, 0);
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
 
 	if (hal_data->rf_type == RF_1T1R)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 1e6885d75bf3..61d3209953f7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1420,7 +1420,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				}
 
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-					RetryLimit = (haldata->CustomerID == RT_CID_CCX) ? 7 : 48;
+					RetryLimit = 48;
 				else /*  Ad-hoc Mode */
 					RetryLimit = 0x7;
 			} else if (type == 1) {
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index b374398bad24..66ecd3c3ac13 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -209,8 +209,6 @@ struct txpowerinfo24g {
 
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
-	u16	CustomerID;
-
 	u16	FirmwareVersion;
 	u16	FirmwareVersionRev;
 	u16	FirmwareSubVersion;
diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index d0c812cf5cc2..e517239bd75e 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -40,61 +40,6 @@
 #define	EEPROM_CID_CLEVO		0x13
 #define	EEPROM_CID_WHQL			0xFE
 
-/*  Customer ID, note that: */
-/*  This variable is initiailzed through EEPROM or registry, */
-/*  however, its definition may be different with that in EEPROM for */
-/*  EEPROM size consideration. So, we have to perform proper translation
- *  between them. */
-/*  Besides, CustomerID of registry has precedence of that of EEPROM. */
-/*  defined below. 060703, by rcnjko. */
-enum RT_CUSTOMER_ID {
-	RT_CID_DEFAULT = 0,
-	RT_CID_8187_ALPHA0 = 1,
-	RT_CID_8187_SERCOMM_PS = 2,
-	RT_CID_8187_HW_LED = 3,
-	RT_CID_8187_NETGEAR = 4,
-	RT_CID_WHQL = 5,
-	RT_CID_819x_CAMEO  = 6,
-	RT_CID_819x_RUNTOP = 7,
-	RT_CID_819x_Senao = 8,
-	RT_CID_TOSHIBA = 9,	/*  Merge by Jacken, 2008/01/31. */
-	RT_CID_819x_Netcore = 10,
-	RT_CID_Nettronix = 11,
-	RT_CID_DLINK = 12,
-	RT_CID_PRONET = 13,
-	RT_CID_COREGA = 14,
-	RT_CID_CHINA_MOBILE = 15,
-	RT_CID_819x_ALPHA = 16,
-	RT_CID_819x_Sitecom = 17,
-	RT_CID_CCX = 18, /*  It's set under CCX logo test and isn't demanded
-			  * for CCX functions, but for test behavior like retry
-			  * limit and tx report. By Bruce, 2009-02-17. */
-	RT_CID_819x_Lenovo = 19,
-	RT_CID_819x_QMI = 20,
-	RT_CID_819x_Edimax_Belkin = 21,
-	RT_CID_819x_Sercomm_Belkin = 22,
-	RT_CID_819x_CAMEO1 = 23,
-	RT_CID_819x_MSI = 24,
-	RT_CID_819x_Acer = 25,
-	RT_CID_819x_AzWave_ASUS = 26,
-	RT_CID_819x_AzWave = 27, /*  For AzWave in PCIe,i
-				  * The ID is AzWave use and not only Asus */
-	RT_CID_819x_HP = 28,
-	RT_CID_819x_WNC_COREGA = 29,
-	RT_CID_819x_Arcadyan_Belkin = 30,
-	RT_CID_819x_SAMSUNG = 31,
-	RT_CID_819x_CLEVO = 32,
-	RT_CID_819x_DELL = 33,
-	RT_CID_819x_PRONETS = 34,
-	RT_CID_819x_Edimax_ASUS = 35,
-	RT_CID_819x_CAMEO_NETGEAR = 36,
-	RT_CID_PLANEX = 37,
-	RT_CID_CC_C = 38,
-	RT_CID_819x_Xavi = 39,
-	RT_CID_819x_FUNAI_TV = 40,
-	RT_CID_819x_ALPHA_WD=41,
-};
-
 struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		bloadfile_fail_flag;
-- 
2.20.1

