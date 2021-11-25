Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A327145DD27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356003AbhKYPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354302AbhKYPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:18:09 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45649C061758
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:14:58 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqGSc-0005zf-SU; Thu, 25 Nov 2021 16:14:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/6] staging: r8188eu: remove unused eeprom defines
Date:   Thu, 25 Nov 2021 16:14:35 +0100
Message-Id: <20211125151436.5895-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125151436.5895-1-martin@kaiser.cx>
References: <20211125151436.5895-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a number of eeprom defines which are not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/rtl8188e_spec.h   | 48 -------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index d56e1c052b84..e59fd2fe82c5 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -1283,52 +1283,15 @@ Current IOREG MAP
 
 #define	EEPROM_RF_BOARD_OPTION_88E		0xC1
 #define	EEPROM_RF_FEATURE_OPTION_88E		0xC2
-#define	EEPROM_RF_BT_SETTING_88E		0xC3
-#define	EEPROM_CUSTOMERID_88E			0xC5
 #define	EEPROM_RF_ANTENNA_OPT_88E		0xC9
 
-/*  RTL88EE */
-#define	EEPROM_MAC_ADDR_88EE			0xD0
-#define	EEPROM_VID_88EE				0xD6
-#define	EEPROM_DID_88EE				0xD8
-#define	EEPROM_SVID_88EE			0xDA
-#define	EEPROM_SMID_88EE			0xDC
-
 /* RTL88EU */
 #define	EEPROM_MAC_ADDR_88EU			0xD7
-#define	EEPROM_VID_88EU				0xD0
-#define	EEPROM_PID_88EU				0xD2
 #define EEPROM_USB_OPTIONAL_FUNCTION0		0xD4
 
 /*  RTL88ES */
 #define	EEPROM_MAC_ADDR_88ES			0x11A
 
-/* 		EEPROM/Efuse Value Type */
-#define EETYPE_TX_PWR				0x0
-
-/*  Default Value for EEPROM or EFUSE!!! */
-#define EEPROM_Default_TSSI			0x0
-#define EEPROM_Default_TxPowerDiff		0x0
-#define EEPROM_Default_CrystalCap		0x5
-/*  Default: 2X2, RTL8192CE(QFPN68) */
-#define EEPROM_Default_BoardType		0x02
-#define EEPROM_Default_TxPower			0x1010
-#define EEPROM_Default_HT2T_TxPwr		0x10
-
-#define EEPROM_Default_LegacyHTTxPowerDiff	0x3
-#define EEPROM_Default_ThermalMeter		0x12
-
-#define EEPROM_Default_AntTxPowerDiff		0x0
-#define EEPROM_Default_TxPwDiff_CrystalCap	0x5
-#define EEPROM_Default_TxPowerLevel		0x2A
-
-#define EEPROM_Default_HT40_2SDiff		0x0
-/*  HT20<->40 default Tx Power Index Difference */
-#define EEPROM_Default_HT20_Diff		2
-#define EEPROM_Default_LegacyHTTxPowerDiff	0x3
-#define EEPROM_Default_HT40_PwrMaxOffset	0
-#define EEPROM_Default_HT20_PwrMaxOffset	0
-
 #define EEPROM_Default_CrystalCap_88E		0x20
 #define	EEPROM_Default_ThermalMeter_88E		0x18
 
@@ -1338,13 +1301,7 @@ Current IOREG MAP
 #define		EEPROM_DEFAULT_24G_OFDM_DIFF	0X04
 
 #define		EEPROM_DEFAULT_DIFF		0XFE
-#define	EEPROM_DEFAULT_CHANNEL_PLAN		0x7F
 #define	EEPROM_DEFAULT_BOARD_OPTION		0x00
-#define	EEPROM_DEFAULT_FEATURE_OPTION		0x00
-#define	EEPROM_DEFAULT_BT_OPTION		0x10
-
-/*  For debug */
-#define EEPROM_Default_Version			0
 
 #define EEPROM_CHANNEL_PLAN_FCC			0x0
 #define EEPROM_CHANNEL_PLAN_IC			0x1
@@ -1361,11 +1318,6 @@ Current IOREG MAP
 #define EEPROM_USB_OPTIONAL1			0xE
 #define EEPROM_CHANNEL_PLAN_BY_HW_MASK		0x80
 
-#define EEPROM_CID_DEFAULT		0x0
-#define EEPROM_CID_TOSHIBA		0x4
-#define EEPROM_CID_CCX			0x10 /*  CCX test. */
-#define EEPROM_CID_QMI			0x0D
-#define EEPROM_CID_WHQL			0xFE
 #define	RTL_EEPROM_ID			0x8129
 
 #endif /* __RTL8188E_SPEC_H__ */
-- 
2.20.1

