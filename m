Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5DE359E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhDIMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIMGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:06:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B179AC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:06:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g17so5495446ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OpzO6iEWPwE29JkU6FF7enkdF/mZ+NhvRaZ/Aj/BP9A=;
        b=cjLzKhtTeL1ij4GndbOMM5LR4MV5OD0aRezVnz1JRuoxuH3BgxfZPqL2JDAlA/zXaI
         EaVrENqzktAccuLA6rkn3LbXYhLtmV1oWAy6YljLNBf7kLLp2UkXnqKRDiuFji26OuUx
         RV7YIXEv5AV8QQfBYfKiHvDipks5BHMFkiUSlJtNcClu9MvGD3cJv/ilt9hlok2+ZW3p
         7UAMdJWjdp5diBTgV5KUg+fcknjs8sPi64GNiU36pn+wzEaDTp7fZdbGimjDlBF7VROS
         u0Rfkos1BtD+scNO0yNBHPmmBwJA5sfm8wTs2Nsdnn4bH2LbYHo7o6od2SVh55N6F4Yg
         OKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OpzO6iEWPwE29JkU6FF7enkdF/mZ+NhvRaZ/Aj/BP9A=;
        b=fMn8HuMvU+aj6aYCFs2G2q0OdJjxo2UjxmdODU/W5CcMzF2vvVqwVpdr8zX9Q+0c2m
         wBiDksVrMP64TCQlHNQFxeyFncW680bZL6f7CnpyPbcfPiqX2JSr4h0NuyPAOfRwgkXH
         sGqNiPWuEzjsnlCLuqb/1rql5XXfN60n2Bo+ZK2JLyFJQ4l+8YxAM7TjMo7totZ46l1/
         SKDHwljhdB2zlXlRjdkUvaDzHqZxpGvnMCw49n93Ze7Xv5Je6yjsJJvoULz72jfXKQhZ
         PCYjmFTid+w4CcKR9M5YSX3IdGSlb7JqKAxb4T9ptyplT4PyUBPmE60Zz+2sdSz0NkC/
         uXIw==
X-Gm-Message-State: AOAM533/S/LOcoQB4n8HKT3VVzKyfQj3lemEP1S0L0KX+m4v19td+jtW
        xh3HbXbItDbqOPP5ReR9+egWTXSNVzMkDTnz
X-Google-Smtp-Source: ABdhPJw91GuFymhoZ3VzILHU5v4Yv3F/QGV7aMTNeYAp4HHPypWMzdraRU/tGC+3rLDVLpGc7Q+GnQ==
X-Received: by 2002:a17:906:1fd7:: with SMTP id e23mr5969987ejt.528.1617969989178;
        Fri, 09 Apr 2021 05:06:29 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id s11sm1356901edt.27.2021.04.09.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:06:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: include: Correct mispelled words in comments
Date:   Fri,  9 Apr 2021 14:06:22 +0200
Message-Id: <20210409120622.29540-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct misspelled words in comments of several files. Issue (largely)
detected by checkpatch.pl.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 .../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
 .../staging/rtl8723bs/include/basic_types.h   |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
 .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
 drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
 .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
 drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
 drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
 16 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
index fb80901f0788..4b3a7c051630 100644
--- a/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
+++ b/drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
@@ -34,7 +34,7 @@
 /*--------------------------Define Parameters-------------------------------*/
 
 /*  */
-/*        8192S Regsiter offset definition */
+/*        8192S Register offset definition */
 /*  */
 
 /*  */
@@ -43,7 +43,7 @@
 /*  2. 0x800/0x900/0xA00/0xC00/0xD00/0xE00 */
 /*  3. RF register 0x00-2E */
 /*  4. Bit Mask for BB/RF register */
-/*  5. Other defintion for BB/RF R/W */
+/*  5. Other definition for BB/RF R/W */
 /*  */
 
 
@@ -137,7 +137,7 @@
 #define		rFPGA0_AnalogParameter3		0x888	/*  Useless now */
 #define		rFPGA0_AnalogParameter4		0x88c
 
-#define		rFPGA0_XA_LSSIReadBack		0x8a0	/*  Tranceiver LSSI Readback */
+#define		rFPGA0_XA_LSSIReadBack		0x8a0	/*  Transceiver LSSI Readback */
 #define		rFPGA0_XB_LSSIReadBack		0x8a4
 #define		rFPGA0_XC_LSSIReadBack		0x8a8
 #define		rFPGA0_XD_LSSIReadBack		0x8ac
@@ -206,7 +206,7 @@
 #define		rOFDM0_TRSWIsolation		0xc0c
 
 #define		rOFDM0_XARxAFE			0xc10  /* RxIQ DC offset, Rx digital filter, DC notch filter */
-#define		rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
+#define		rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imbalance matrix */
 #define		rOFDM0_XBRxAFE				0xc18
 #define		rOFDM0_XBRxIQImbalance		0xc1c
 #define		rOFDM0_XCRxAFE				0xc20
diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index 76304086107a..57bb717327ce 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -187,7 +187,7 @@
 		); \
 }
 
-/*  Get the N-bytes aligment offset from the current length */
+/*  Get the N-bytes alignent offset from the current length */
 #define N_BYTE_ALIGMENT(__Value, __Aligment) ((__Aligment == 1) ? (__Value) : (((__Value + __Aligment - 1) / __Aligment) * __Aligment))
 
 #define TEST_FLAG(__Flag, __testFlag)		(((__Flag) & (__testFlag)) != 0)
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index cec8d5ac0e2e..c97e6421a0db 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -425,7 +425,7 @@ struct adapter {
 	/* 	The driver will show up the desired channel number when this flag is 1. */
 	u8 bNotifyChannelChange;
 
-	/* pbuddystruct adapter is used only in  two inteface case, (iface_nums =2 in struct dvobj_priv) */
+	/* pbuddystruct adapter is used only in two interface case, (iface_nums =2 in struct dvobj_priv) */
 	/* PRIMARY ADAPTER's buddy is SECONDARY_ADAPTER */
 	/* SECONDARY_ADAPTER's buddy is PRIMARY_ADAPTER */
 	/* for iface_id > SECONDARY_ADAPTER(IFACE_ID1), refer to padapters[iface_id]  in struct dvobj_priv */
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index a1e1b76b5d8a..6bcc443d59fb 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -158,7 +158,7 @@
 (rate == DESC_RATEVHTSS2MCS6) ? "VHTSS2MCS6" : \
 (rate == DESC_RATEVHTSS2MCS7) ? "VHTSS2MCS7" : \
 (rate == DESC_RATEVHTSS2MCS8) ? "VHTSS2MCS8" : \
-(rate == DESC_RATEVHTSS2MCS9) ? "VHTSS2MCS9" : "UNKNOW"
+(rate == DESC_RATEVHTSS2MCS9) ? "VHTSS2MCS9" : "UNKNOWN"
 
 
 enum{
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 2cd18eb57244..b14585cb0233 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -768,14 +768,14 @@ Default: 00b.
 #define IMR_BCNDMAINT3			BIT28		/*  Beacon DMA Interrupt 3 */
 #define IMR_BCNDMAINT2			BIT27		/*  Beacon DMA Interrupt 2 */
 #define IMR_BCNDMAINT1			BIT26		/*  Beacon DMA Interrupt 1 */
-#define IMR_BCNDOK8				BIT25		/*  Beacon Queue DMA OK Interrup 8 */
-#define IMR_BCNDOK7				BIT24		/*  Beacon Queue DMA OK Interrup 7 */
-#define IMR_BCNDOK6				BIT23		/*  Beacon Queue DMA OK Interrup 6 */
-#define IMR_BCNDOK5				BIT22		/*  Beacon Queue DMA OK Interrup 5 */
-#define IMR_BCNDOK4				BIT21		/*  Beacon Queue DMA OK Interrup 4 */
-#define IMR_BCNDOK3				BIT20		/*  Beacon Queue DMA OK Interrup 3 */
-#define IMR_BCNDOK2				BIT19		/*  Beacon Queue DMA OK Interrup 2 */
-#define IMR_BCNDOK1				BIT18		/*  Beacon Queue DMA OK Interrup 1 */
+#define IMR_BCNDOK8				BIT25		/*  Beacon Queue DMA OK Interrupt 8 */
+#define IMR_BCNDOK7				BIT24		/*  Beacon Queue DMA OK Interrupt 7 */
+#define IMR_BCNDOK6				BIT23		/*  Beacon Queue DMA OK Interrupt 6 */
+#define IMR_BCNDOK5				BIT22		/*  Beacon Queue DMA OK Interrupt 5 */
+#define IMR_BCNDOK4				BIT21		/*  Beacon Queue DMA OK Interrupt 4 */
+#define IMR_BCNDOK3				BIT20		/*  Beacon Queue DMA OK Interrupt 3 */
+#define IMR_BCNDOK2				BIT19		/*  Beacon Queue DMA OK Interrupt 2 */
+#define IMR_BCNDOK1				BIT18		/*  Beacon Queue DMA OK Interrupt 1 */
 #define IMR_TIMEOUT2			BIT17		/*  Timeout interrupt 2 */
 #define IMR_TIMEOUT1			BIT16		/*  Timeout interrupt 1 */
 #define IMR_TXFOVW				BIT15		/*  Transmit FIFO Overflow */
@@ -784,9 +784,9 @@ Default: 00b.
 #define IMR_RXFOVW				BIT12		/*  Receive FIFO Overflow */
 #define IMR_RDU					BIT11		/*  Receive Descriptor Unavailable */
 #define IMR_ATIMEND				BIT10		/*  For 92C, ATIM Window End Interrupt. For 8723 and later ICs, it also means P2P CTWin End interrupt. */
-#define IMR_BDOK				BIT9		/*  Beacon Queue DMA OK Interrup */
+#define IMR_BDOK				BIT9		/*  Beacon Queue DMA OK Interrupt */
 #define IMR_HIGHDOK				BIT8		/*  High Queue DMA OK Interrupt */
-#define IMR_TBDOK				BIT7		/*  Transmit Beacon OK interrup */
+#define IMR_TBDOK				BIT7		/*  Transmit Beacon OK interrupt */
 #define IMR_MGNTDOK			BIT6		/*  Management Queue DMA OK Interrupt */
 #define IMR_TBDER				BIT5		/*  For 92C, Transmit Beacon Error Interrupt */
 #define IMR_BKDOK				BIT4		/*  AC_BK DMA OK Interrupt */
@@ -956,13 +956,13 @@ Default: 00b.
 #define IMR_BCNDMAINT3_88E		BIT23		/*  Beacon DMA Interrupt 3 */
 #define IMR_BCNDMAINT2_88E		BIT22		/*  Beacon DMA Interrupt 2 */
 #define IMR_BCNDMAINT1_88E		BIT21		/*  Beacon DMA Interrupt 1 */
-#define IMR_BCNDOK7_88E			BIT20		/*  Beacon Queue DMA OK Interrup 7 */
-#define IMR_BCNDOK6_88E			BIT19		/*  Beacon Queue DMA OK Interrup 6 */
-#define IMR_BCNDOK5_88E			BIT18		/*  Beacon Queue DMA OK Interrup 5 */
-#define IMR_BCNDOK4_88E			BIT17		/*  Beacon Queue DMA OK Interrup 4 */
-#define IMR_BCNDOK3_88E			BIT16		/*  Beacon Queue DMA OK Interrup 3 */
-#define IMR_BCNDOK2_88E			BIT15		/*  Beacon Queue DMA OK Interrup 2 */
-#define IMR_BCNDOK1_88E			BIT14		/*  Beacon Queue DMA OK Interrup 1 */
+#define IMR_BCNDOK7_88E			BIT20		/*  Beacon Queue DMA OK Interrupt 7 */
+#define IMR_BCNDOK6_88E			BIT19		/*  Beacon Queue DMA OK Interrupt 6 */
+#define IMR_BCNDOK5_88E			BIT18		/*  Beacon Queue DMA OK Interrupt 5 */
+#define IMR_BCNDOK4_88E			BIT17		/*  Beacon Queue DMA OK Interrupt 4 */
+#define IMR_BCNDOK3_88E			BIT16		/*  Beacon Queue DMA OK Interrupt 3 */
+#define IMR_BCNDOK2_88E			BIT15		/*  Beacon Queue DMA OK Interrupt 2 */
+#define IMR_BCNDOK1_88E			BIT14		/*  Beacon Queue DMA OK Interrupt 1 */
 #define IMR_ATIMEND_E_88E			BIT13		/*  ATIM Window End Extension for Win7 */
 #define IMR_TXERR_88E				BIT11		/*  Tx Error Flag Interrupt Status, write 1 clear. */
 #define IMR_RXERR_88E				BIT10		/*  Rx Error Flag INT Status, Write 1 clear */
diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index df5c7b747498..babcb03a7c23 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -389,7 +389,7 @@ struct hal_com_data {
 	u8 OutEpQueueSel;
 	u8 OutEpNumber;
 
-	/*  2010/12/10 MH Add for USB aggreation mode dynamic shceme. */
+	/*  2010/12/10 MH Add for USB aggregation mode dynamic scheme. */
 	bool		UsbRxHighSpeedMode;
 
 	/*  2010/11/22 MH Add for slim combo debug mode selective. */
diff --git a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
index 0837506b6be8..0a2e60770668 100644
--- a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
+++ b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
@@ -14,7 +14,7 @@
 	4: LPS--Low Power State
 	5: SUS--Suspend
 
-	The transision from different states are defined below
+	The transition from different states are defined below
 	TRANS_CARDEMU_TO_ACT
 	TRANS_ACT_TO_CARDEMU
 	TRANS_CARDEMU_TO_SUS
diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 87cbad525393..517ae3b51386 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -136,7 +136,7 @@ enum {
 	RESET_SECURITYPRIV, /*  add for CONFIG_IEEE80211W, none 11w also can use */
 	FREE_ASSOC_RESOURCES, /*  add for CONFIG_IEEE80211W, none 11w also can use */
 	DM_IN_LPS_WK_CID,
-	DM_RA_MSK_WK_CID, /* add for STA update RAMask when bandwith change. */
+	DM_RA_MSK_WK_CID, /* add for STA update RAMask when bandwidth change. */
 	BEAMFORMING_WK_CID,
 	LPS_CHANGE_DTIM_CID,
 	BTINFO_WK_CID,
@@ -514,7 +514,7 @@ struct drvextra_cmd_parm {
 	unsigned char *pbuf;
 };
 
-/*------------------- Below are used for RF/BB tunning ---------------------*/
+/*------------------- Below are used for RF/BB tuning ---------------------*/
 
 struct	getcountjudge_rsp {
 	u8 count_judge[MAX_RATES_LENGTH];
@@ -567,7 +567,7 @@ struct RunInThread_param {
 
 Result:
 0x00: success
-0x01: sucess, and check Response.
+0x01: success, and check Response.
 0x02: cmd ignored due to duplicated sequcne number
 0x03: cmd dropped due to invalid cmd code
 0x04: reserved.
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 87a1fa8f347e..5deb73fe3885 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -57,11 +57,11 @@
 
 /* ifdef UNDER_MPTEST */
 #define	WIFI_MP_STATE							0x00010000
-#define	WIFI_MP_CTX_BACKGROUND				0x00020000	/*  in continous tx background */
-#define	WIFI_MP_CTX_ST						0x00040000	/*  in continous tx with single-tone */
-#define	WIFI_MP_CTX_BACKGROUND_PENDING	0x00080000	/*  pending in continous tx background due to out of skb */
-#define	WIFI_MP_CTX_CCK_HW					0x00100000	/*  in continous tx */
-#define	WIFI_MP_CTX_CCK_CS					0x00200000	/*  in continous tx with carrier suppression */
+#define	WIFI_MP_CTX_BACKGROUND				0x00020000	/*  in continuous tx background */
+#define	WIFI_MP_CTX_ST						0x00040000	/*  in continuous tx with single-tone */
+#define	WIFI_MP_CTX_BACKGROUND_PENDING	0x00080000	/*  pending in continuous tx background due to out of skb */
+#define	WIFI_MP_CTX_CCK_HW					0x00100000	/*  in continuous tx */
+#define	WIFI_MP_CTX_CCK_CS					0x00200000	/*  in continuous tx with carrier suppression */
 #define   WIFI_MP_LPBK_STATE					0x00400000
 /* endif */
 
@@ -168,7 +168,7 @@ struct tx_provdisc_req_info {
 	u8 			benable;					/* 	This provision discovery request frame is trigger to send or not */
 };
 
-struct rx_provdisc_req_info {	/* When peer device issue prov_disc_req first, we should store the following informations */
+struct rx_provdisc_req_info {	/* When peer device issue prov_disc_req first, we should store the following information */
 	u8			peerDevAddr[ETH_ALEN];		/*	Peer device address */
 	u8 			strconfig_method_desc_of_prov_disc_req[4];	/* 	description for the config method located in the provisioning discovery request frame. */
 																	/* 	The UI must know this information to know which config method the remote p2p device is requiring. */
@@ -177,7 +177,7 @@ struct rx_provdisc_req_info {	/* When peer device issue prov_disc_req first, we
 struct tx_nego_req_info {
 	u16 				peer_channel_num[2];		/* 	The channel number which the receiver stands. */
 	u8			peerDevAddr[ETH_ALEN];		/*	Peer device address */
-	u8 			benable;					/* 	This negoitation request frame is trigger to send or not */
+	u8 			benable;					/* 	This negotiation request frame is trigger to send or not */
 };
 
 struct group_id_info {
@@ -228,9 +228,9 @@ struct wifidirect_info {
 	u8 				profileindex;	/* 	Used to point to the index of profileinfo array */
 	u8 				peer_operating_ch;
 	u8 				find_phase_state_exchange_cnt;
-	u16 					device_password_id_for_nego;	/* 	The device password ID for group negotation */
+	u16 					device_password_id_for_nego;	/* 	The device password ID for group negotiation */
 	u8 				negotiation_dialog_token;
-	u8				nego_ssid[WLAN_SSID_MAXLEN];	/*	SSID information for group negotitation */
+	u8				nego_ssid[WLAN_SSID_MAXLEN];	/*	SSID information for group negotiation */
 	u8 				nego_ssidlen;
 	u8 				p2p_group_ssid[WLAN_SSID_MAXLEN];
 	u8 				p2p_group_ssid_len;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 393eeecaf3a0..5e6cf63956b8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -112,7 +112,7 @@ extern unsigned char WMM_PARA_OUI[];
 /*  Note: */
 /* 	We just add new channel plan when the new channel plan is different from any of the following */
 /* 	channel plan. */
-/* 	If you just wnat to customize the acitions(scan period or join actions) about one of the channel plan, */
+/* 	If you just want to customize the actions(scan period or join actions) about one of the channel plan, */
 /* 	customize them in rt_channel_info in the RT_CHANNEL_LIST. */
 /*  */
 enum {
diff --git a/drivers/staging/rtl8723bs/include/rtw_mp.h b/drivers/staging/rtl8723bs/include/rtw_mp.h
index 26dec21bf0f1..2788ad80b114 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mp.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mp.h
@@ -101,7 +101,7 @@ struct mpt_context {
 	/*  For MP Tx Power index */
 	u8 	TxPwrLevel[2];	/*  rf-A, rf-B */
 	u32 		RegTxPwrLimit;
-	/*  Content of RCR Regsiter for Mass Production Test. */
+	/*  Content of RCR Register for Mass Production Test. */
 	u32 		MptRCR;
 	/*  true if we only receive packets with specific pattern. */
 	bool			bMptFilterPattern;
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 5450d20b44a6..0a48f1653be5 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -112,7 +112,7 @@ enum rt_rf_power_state {
 #define	RT_RF_OFF_LEVL_FREE_FW		BIT(4)	/*  FW free, re-download the FW */
 #define	RT_RF_OFF_LEVL_FW_32K		BIT(5)	/*  FW in 32k */
 #define	RT_RF_PS_LEVEL_ALWAYS_ASPM	BIT(6)	/*  Always enable ASPM and Clock Req in initialization. */
-#define	RT_RF_LPS_DISALBE_2R			BIT(30)	/*  When LPS is on, disable 2R if no packet is received or transmittd. */
+#define	RT_RF_LPS_DISALBE_2R			BIT(30)	/*  When LPS is on, disable 2R if no packet is received or transmitted. */
 #define	RT_RF_LPS_LEVEL_ASPM			BIT(31)	/*  LPS with ASPM */
 
 #define	RT_IN_PS_LEVEL(ppsc, _PS_FLAG)		((ppsc->cur_ps_level & _PS_FLAG) ? true : false)
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index d007f90d02c3..9c3cdcc990fa 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -132,7 +132,7 @@ struct rx_pkt_attrib	{
 	u8 order;
 	u8 privacy; /* in frame_ctrl field */
 	u8 bdecrypted;
-	u8 encrypt; /* when 0 indicate no encrypt. when non-zero, indicate the encrypt algorith */
+	u8 encrypt; /* when 0 indicates no encryption; when non-zero, indicates the encryption algorithm */
 	u8 iv_len;
 	u8 icv_len;
 	u8 crc_err;
@@ -227,7 +227,7 @@ struct recv_priv {
 
 	struct __queue	recv_buf_pending_queue;
 
-	/* For display the phy informatiom */
+	/* For display the phy information */
 	u8 is_signal_dbg;	/*  for debug */
 	u8 signal_strength_dbg;	/*  for debug */
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index 73d020cfd0d1..e45753d17313 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -142,7 +142,7 @@ struct pkt_attrib {
 	u32 pktlen;		/* the original 802.3 pkt raw_data len (not include ether_hdr data) */
 	u32 last_txcmdsz;
 	u8 nr_frags;
-	u8 encrypt;	/* when 0 indicate no encrypt. when non-zero, indicate the encrypt algorith */
+	u8 encrypt;	/* when 0 indicates no encryption; when non-zero, indicates the encryption algorithm */
 	u8 iv_len;
 	u8 icv_len;
 	u8 iv[18];
diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index abde3e3df988..69c377eeeaf0 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -329,7 +329,7 @@ struct	sta_priv {
 	 */
 	struct sta_info *sta_aid[NUM_STA];
 
-	u16 sta_dz_bitmap;/* only support 15 stations, staion aid bitmap for sleeping sta. */
+	u16 sta_dz_bitmap;/* only support for 15 stations, aid bitmap for sleeping stations. */
 	u16 tim_bitmap;/* only support 15 stations, aid = 0~15 mapping bit0~bit15 */
 
 	u16 max_num_sta;
diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 69e714a6d87c..036cf57c65a9 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -678,7 +678,7 @@ struct ADDBA_request {
 
 #define	P2P_PROVISION_TIMEOUT				5000	/* 	5 seconds timeout for sending the provision discovery request */
 #define	P2P_CONCURRENT_PROVISION_TIMEOUT	3000	/* 	3 seconds timeout for sending the provision discovery request under concurrent mode */
-#define	P2P_GO_NEGO_TIMEOUT					5000	/* 	5 seconds timeout for receiving the group negotation response */
+#define	P2P_GO_NEGO_TIMEOUT					5000	/* 	5 seconds timeout for receiving the group negotiation response */
 #define	P2P_CONCURRENT_GO_NEGO_TIMEOUT		3000	/* 	3 seconds timeout for sending the negotiation request under concurrent mode */
 #define	P2P_TX_PRESCAN_TIMEOUT				100		/* 	100ms */
 #define	P2P_INVITE_TIMEOUT					5000	/* 	5 seconds timeout for sending the invitation request */
-- 
2.31.1

