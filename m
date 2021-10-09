Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE67427916
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbhJIKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhJIKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:46:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE2C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 03:44:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so37664001wrg.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ks4Rqh46v5CyBYF2ay+xbKrnRkWuCYMNGLOMnRH/Zk=;
        b=b6qNh5kIGgBQ/EFKEC2zp6oTn6UR31uO/DJVTixIJj1pJ/krY5FCUi6FC9GYSYe/mu
         RvdDlxkQmX6UL/Jzou8UsvoHNrXWDd8TxaMy9tRJHFC7JJwiYefl0bfIADqvQF5yy5p/
         1x/sk+NfZjgYR11fkdvru7vxrfgmtuCQ+loKx1gyoezzXVDPb+JYZ0H3rjYBbRSMpeJu
         ZZ91LT2GSTJQ+QCD4AKBIPDRd09IJ1/djJL57fNZrkUvwdAQcN0KC0kCs2QkRtr9y9cY
         +s5q2LqGJow6yrfe4GPcsqU4wlRjNQZjhpE30DJIC5a5K2XPYzKdQlS/jLRHudwOzSmu
         2n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ks4Rqh46v5CyBYF2ay+xbKrnRkWuCYMNGLOMnRH/Zk=;
        b=bC+2hdahPzZaeWGoTpaLtoAqfi4vaJ+e5ejV9lYGr6eMAxqI+AeJCQqAxCmrYJ3Xh+
         HcdDjBX7IWXOrmzS85pVFmQ+AU30S8qH68OngWDSaWj5lHdkVJwH87EireQ5e2bAoblX
         zRsZz9BhV9P7mioNvUlB+DsQVmgxgqv8jb+c9MU4AblkSRovLPgnc4fJzO9dcIhGcmGY
         7+FmRB00P3lcTUkxtPeKUzdKRLpxke2PxWVACm+pvzkgro3y6JC95TVVZVnG995qbBe2
         s4X11m5X3BGrZjS1na4P0dWQJS5/9E45oKxC4JZXOV/dH1qnCV5vmNay8Lo1eHq7ueoF
         jgTg==
X-Gm-Message-State: AOAM5305Z2B6bp926HtNYQwyww+ob7zYzYE15dkYRgPpGLfNrsvD4usc
        arZ0UltGhAuAbkAlj18t7PI=
X-Google-Smtp-Source: ABdhPJxNfl10d2+GEYTnfELkyzriRwhqM9rTTlc0bGJm9fzybS78/2xaKBL+XZmiWHTtKjsZtSVpuw==
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr10447854wry.87.1633776273627;
        Sat, 09 Oct 2021 03:44:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id a81sm1905431wmd.30.2021.10.09.03.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 03:44:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove unused macros and defines from rtl8188e_hal.h
Date:   Sat,  9 Oct 2021 12:44:17 +0200
Message-Id: <20211009104419.8811-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macros and defines from rtl8188e_hal.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/rtl8188e_hal.h    | 55 -------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 66ecd3c3ac13..5fdee1c6299c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -19,29 +19,10 @@
 
 #include "odm_precomp.h"
 
-/*  Fw Array */
-#define Rtl8188E_FwImageArray		Rtl8188EFwImgArray
-#define Rtl8188E_FWImgArrayLength	Rtl8188EFWImgArrayLength
-
-#define RTL8188E_FW_UMC_IMG			"rtl8188E\\rtl8188efw.bin"
-#define RTL8188E_PHY_REG			"rtl8188E\\PHY_REG_1T.txt"
-#define RTL8188E_PHY_RADIO_A			"rtl8188E\\radio_a_1T.txt"
-#define RTL8188E_PHY_RADIO_B			"rtl8188E\\radio_b_1T.txt"
-#define RTL8188E_AGC_TAB			"rtl8188E\\AGC_TAB_1T.txt"
-#define RTL8188E_PHY_MACREG			"rtl8188E\\MAC_REG.txt"
-#define RTL8188E_PHY_REG_PG			"rtl8188E\\PHY_REG_PG.txt"
-#define RTL8188E_PHY_REG_MP			"rtl8188E\\PHY_REG_MP.txt"
-
 /* 		RTL8188E Power Configuration CMDs for USB/SDIO interfaces */
 #define Rtl8188E_NIC_PWR_ON_FLOW		rtl8188E_power_on_flow
-#define Rtl8188E_NIC_RF_OFF_FLOW		rtl8188E_radio_off_flow
 #define Rtl8188E_NIC_DISABLE_FLOW		rtl8188E_card_disable_flow
-#define Rtl8188E_NIC_ENABLE_FLOW		rtl8188E_card_enable_flow
-#define Rtl8188E_NIC_SUSPEND_FLOW		rtl8188E_suspend_flow
-#define Rtl8188E_NIC_RESUME_FLOW		rtl8188E_resume_flow
-#define Rtl8188E_NIC_PDN_FLOW			rtl8188E_hwpdn_flow
 #define Rtl8188E_NIC_LPS_ENTER_FLOW		rtl8188E_enter_lps_flow
-#define Rtl8188E_NIC_LPS_LEAVE_FLOW		rtl8188E_leave_lps_flow
 
 #define DRVINFO_SZ	4 /*  unit is 8bytes */
 #define PageNum_128(_Len)	(u32)(((_Len)>>7) + ((_Len) & 0x7F ? 1 : 0))
@@ -49,7 +30,6 @@
 /*  download firmware related data structure */
 #define FW_8188E_SIZE			0x4000 /* 16384,16k */
 #define FW_8188E_START_ADDRESS		0x1000
-#define FW_8188E_END_ADDRESS		0x1FFF /* 0x5FFF */
 
 #define MAX_PAGE_SIZE			4096	/*  @ page : 4k bytes */
 
@@ -108,11 +88,6 @@ enum usb_rx_agg_mode {
       0x2400 /* 9k for 88E nornal chip , MaxRxBuff=10k-max(TxReportSize(64*8),
 	      * WOLPattern(16*24)) */
 
-#define MAX_TX_REPORT_BUFFER_SIZE		0x0400 /*  1k */
-
-/*  BK, BE, VI, VO, HCCA, MANAGEMENT, COMMAND, HIGH, BEACON. */
-#define MAX_TX_QUEUE			9
-
 #define TX_SELE_HQ			BIT(0)		/*  High Queue */
 #define TX_SELE_LQ			BIT(1)		/*  Low Queue */
 #define TX_SELE_NQ			BIT(2)		/*  Normal Queue */
@@ -134,11 +109,6 @@ enum usb_rx_agg_mode {
 #define WMM_NORMAL_TX_PAGE_BOUNDARY_88E			\
 	(WMM_NORMAL_TX_TOTAL_PAGE_NUMBER + 1) /* 0xA9 */
 
-/* 	Chip specific */
-#define CHIP_BONDING_IDENTIFIER(_value)	(((_value)>>22)&0x3)
-#define CHIP_BONDING_92C_1T2R	0x1
-#define CHIP_BONDING_88C_USB_MCARD	0x2
-#define CHIP_BONDING_88C_USB_HP	0x1
 #include "HalVerDef.h"
 #include "hal_com.h"
 
@@ -168,29 +138,11 @@ struct txpowerinfo24g {
 };
 
 #define EFUSE_REAL_CONTENT_LEN		512
-#define EFUSE_MAX_SECTION		16
-#define EFUSE_IC_ID_OFFSET		506 /* For some inferior IC purpose*/
 #define AVAILABLE_EFUSE_ADDR(addr)	(addr < EFUSE_REAL_CONTENT_LEN)
-/*  To prevent out of boundary programming case, */
-/*  leave 1byte and program full section */
-/*  9bytes + 1byt + 5bytes and pre 1byte. */
-/*  For worst case: */
-/*  | 1byte|----8bytes----|1byte|--5bytes--| */
-/*  |         |            Reserved(14bytes)	      | */
-
-/*  PG data exclude header, dummy 6 bytes frome CP test and reserved 1byte. */
-#define EFUSE_OOB_PROTECT_BYTES			15
-
-#define		HWSET_MAX_SIZE_88E		512
 
 #define		EFUSE_REAL_CONTENT_LEN_88E	256
 #define		EFUSE_MAP_LEN_88E		512
-#define EFUSE_MAP_LEN			EFUSE_MAP_LEN_88E
 #define		EFUSE_MAX_SECTION_88E		64
-#define		EFUSE_MAX_WORD_UNIT_88E		4
-#define		EFUSE_IC_ID_OFFSET_88E		506
-#define		AVAILABLE_EFUSE_ADDR_88E(addr)			\
-	(addr < EFUSE_REAL_CONTENT_LEN_88E)
 /*  To prevent out of boundary programming case, leave 1byte and program
  *  full section */
 /*  9bytes + 1byt + 5bytes and pre 1byte. */
@@ -198,12 +150,6 @@ struct txpowerinfo24g {
 /*  | 2byte|----8bytes----|1byte|--7bytes--| 92D */
 /*  PG data exclude header, dummy 7 bytes frome CP test and reserved 1byte. */
 #define		EFUSE_OOB_PROTECT_BYTES_88E	18
-#define		EFUSE_PROTECT_BYTES_BANK_88E	16
-
-/* 			EFUSE for BT definition */
-#define EFUSE_BT_REAL_CONTENT_LEN	1536	/*  512*3 */
-#define EFUSE_BT_MAP_LEN		1024	/*  1k bytes */
-#define EFUSE_BT_MAX_SECTION		128	/*  1024/8 */
 
 #define EFUSE_PROTECT_BYTES_BANK	16
 
@@ -367,7 +313,6 @@ struct hal_data_8188e {
 
 #define GET_HAL_DATA(__pAdapter)				\
 	((struct hal_data_8188e *)((__pAdapter)->HalData))
-#define GET_RF_TYPE(priv)		(GET_HAL_DATA(priv)->rf_type)
 
 /*  rtl8188e_hal_init.c */
 s32 rtl8188e_FirmwareDownload(struct adapter *padapter);
-- 
2.33.0

