Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E390F401FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbhIFS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244577AbhIFS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752FC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i6so10555783edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzPelLdVfXcZusGWTbFLBkXbLqPS315v8dl3+8wOr+M=;
        b=ce/91P5detsLyb2Afa8woJzFZgTe/d2En08Gv6QYfLWZLW3xi2qBdFVjddBai/J356
         W+QRUgOKItbrx9BUe4fhOVsuhPUFj5XOmdmgZxvdqLu0ctT1LwpVGU+Z5iIK0qcRnsvY
         eETwYjXNDtUf5vGhhd//EQz9Ag+Cq6SyJvNKU77N+i0wlW0FTeWK+5Ek4KXjuo9GKP99
         wE9/UdLEeOksrOg27glO9UgHTPQKyAR37ejqhJVk/nKHqf2D4XRop+4DucrgUI8MSG8z
         /KhAeF4sovamTCbiRpLMXLdTC8BckNaayq4rPb2nsZUe7emdQOKdTA8s2v4ehEHyLHr8
         OAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzPelLdVfXcZusGWTbFLBkXbLqPS315v8dl3+8wOr+M=;
        b=sofGNuEEOAePTtM1mfRE6NckpS7HNa7STsTESbzT2REUicV1LOxHyNs4sffHpS0Myx
         OsiebSUMk8qD1n/lChXHiT5JFRMAnwBXw9xQpZ6DwBMKBEdjlXFswwMpR2A9NGUO82MU
         uvKv1nfP9Kmr7sBSwtG5qwGN7dcrMqtb2nr77zz4uAAyNLgCqd2j1NZ6vpLwOPr3Tzzs
         cejbHr/WA0oCzDB15AtaqaeBUAjaYjpIfqzL35Z3KfRP35nKSdQPDWC+K31ukS5ot5xk
         gvu8r4Bp+bQ4wuTIa/cAqKyHc/JB4W5rXJhvFKFvLYvinJhjdh70wvsmEhNjo0QDJnzW
         zmoA==
X-Gm-Message-State: AOAM531uVpejPNJIWLc5XGmBRvWDoKSnTY5+u+rQz1khjUmFtyWhLyLs
        vGG/DSp6OyEvfERDTYm32t0=
X-Google-Smtp-Source: ABdhPJxwqZu4VK6szZAwTyKyEos8BVwcd2xXTUs/A4aQHdcp0mqiPRXSiTv6MnQ5E0Wdl2wsJMt+Rw==
X-Received: by 2002:a05:6402:1cb4:: with SMTP id cz20mr14712040edb.0.1630952719882;
        Mon, 06 Sep 2021 11:25:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 25/40] staging: r8188eu: remove EFUSEGetEfuseDefinition from hal_ops
Date:   Mon,  6 Sep 2021 20:24:23 +0200
Message-Id: <20210906182438.5417-26-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove EFUSEGetEfuseDefinition hal_ops and remove its wrapper
EFUSE_GetEfuseDefinition(). Call rtl8188e_EFUSE_GetEfuseDefinition()
directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c      | 44 +++++--------------
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  6 +--
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 13 +++---
 drivers/staging/r8188eu/include/hal_intf.h    |  4 +-
 drivers/staging/r8188eu/include/rtw_efuse.h   |  2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 22 +++++-----
 6 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index faf6cefaa4f0..42462a91ac58 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -157,30 +157,6 @@ ReadEFuseByte(
 	*pbuf = (u8)(value32 & 0xff);
 }
 
-/*  */
-/* 	Description: */
-/* 		1. Execute E-Fuse read byte operation according as map offset and */
-/* 		    save to E-Fuse table. */
-/* 		2. Referred from SD1 Richard. */
-/*  */
-/* 	Assumption: */
-/* 		1. Boot from E-Fuse and successfully auto-load. */
-/* 		2. PASSIVE_LEVEL (USB interface) */
-/*  */
-/* 	Created by Roger, 2008.10.21. */
-/*  */
-/* 	2008/12/12 MH	1. Reorganize code flow and reserve bytes. and add description. */
-/* 					2. Add efuse utilization collect. */
-/* 	2008/12/22 MH	Read Efuse must check if we write section 1 data again!!! Sec1 */
-/* 					write addr must be after sec5. */
-/*  */
-
-void EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool pseudo
-	)
-{
-	pAdapter->HalFunc.EFUSEGetEfuseDefinition(pAdapter, efuseType, type, pOut, pseudo);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	EFUSE_Read1Byte
  *
@@ -205,7 +181,7 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 	u32 k = 0;
 	u16 contentLen = 0;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
 
 	if (Address < contentLen) {	/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
@@ -385,8 +361,8 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 	u8 res = _FAIL;
 	u8 (*rw8)(struct adapter *, u16, u8*);
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&real_content_len, false);
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&real_content_len, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 
 	if (start_addr > real_content_len)
 		return _FAIL;
@@ -421,7 +397,7 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 u16 efuse_GetMaxSize(struct adapter *padapter)
 {
 	u16 max_size;
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
 	return max_size;
 }
 /*  */
@@ -438,7 +414,7 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
@@ -456,7 +432,7 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
@@ -479,7 +455,7 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	u8 ret = _SUCCESS;
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
@@ -571,7 +547,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 	u8 ret = _SUCCESS;
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, false);
 
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
@@ -738,7 +714,7 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
 
 	rtl8188e_EfusePowerSwitch(pAdapter, false, true);
 
-	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
 	rtl8188e_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
 
@@ -769,7 +745,7 @@ void EFUSE_ShadowMapUpdate(
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(pAdapter);
 	u16 mapLen = 0;
 
-	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
 	if (pEEPROM->bautoload_fail_flag)
 		memset(pEEPROM->efuse_eeprom_data, 0xFF, mapLen);
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index 7cb3f55ff58e..48f0f3b8dbb8 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -913,7 +913,7 @@ int rtl8188eu_oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 
 	if ((addr + cnts) > max_available_size)
 		return NDIS_STATUS_NOT_ACCEPTED;
@@ -944,7 +944,7 @@ int rtl8188eu_oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 
 	if ((addr + cnts) > max_available_size)
 		return NDIS_STATUS_NOT_ACCEPTED;
@@ -1055,7 +1055,7 @@ int rtl8188eu_oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
 	u16	maplen = 0;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&maplen, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&maplen, false);
 
 	*poid_par_priv->bytes_rw = 0;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index eed32dd6ee28..47bc2f6ee37e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1047,7 +1047,7 @@ static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 e
 	}
 }
 
-static void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest)
+void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest)
 {
 	if (bPseudoTest)
 		Hal_EFUSEGetEfuseDefinition_Pseudo88E(pAdapter, efuseType, type, pOut);
@@ -1205,7 +1205,7 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 	u8 max_section = 0;
 	u8 tmp_header = 0;
 
-	EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
 
 	if (!data)
 		return false;
@@ -1341,7 +1341,7 @@ static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuse
 	u8 pg_header = 0, tmp_header = 0, pg_header_temp = 0;
 	u8 repeatcnt = 0;
 
-	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
 
 	while (efuse_addr < efuse_max_available_len) {
 		pg_header = ((pTargetPkt->offset & 0x07) << 5) | 0x0F;
@@ -1521,8 +1521,8 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 	u16	startAddr = 0, efuse_max_available_len = 0, efuse_max = 0;
 	struct pgpkt curPkt;
 
-	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
-	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&efuse_max, bPseudoTest);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&efuse_max, bPseudoTest);
 
 	if (efuseType == EFUSE_WIFI) {
 		if (bPseudoTest) {
@@ -1610,7 +1610,7 @@ hal_EfusePgCheckAvailableAddr(
 	u16	efuse_max_available_len = 0;
 
 	/* Change to check TYPE_EFUSE_MAP_LEN , because 8188E raw 256, logic map over 256. */
-	EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&efuse_max_available_len, false);
+	rtl8188e_EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&efuse_max_available_len, false);
 
 	if (Efuse_GetCurrentSize(pAdapter, efuseType, bPseudoTest) >= efuse_max_available_len)
 		return false;
@@ -1782,7 +1782,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	/*  Efuse related function */
-	pHalFunc->EFUSEGetEfuseDefinition = &rtl8188e_EFUSE_GetEfuseDefinition;
 	pHalFunc->EfuseGetCurrentSize = &rtl8188e_EfuseGetCurrentSize;
 	pHalFunc->Efuse_PgPacketRead = &rtl8188e_Efuse_PgPacketRead;
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e1bb1f30c7e9..6db73da08e2b 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -177,8 +177,6 @@ struct hal_ops {
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
 
-	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType,
-					u8 type, void *pOut, bool bPseudoTest);
 	u16	(*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType,
 				       bool bPseudoTest);
 	int	(*Efuse_PgPacketRead)(struct adapter *adapter, u8 offset,
@@ -221,6 +219,8 @@ void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
 			u16 _offset, u16 _size_byte, u8 *pbuf,
 			bool bPseudoTest);
+void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType,
+				       u8 type, void *pOut, bool bPseudoTest);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 18fb9a4d9a0e..1dc49d82abf4 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -114,8 +114,6 @@ u8 rtw_BT_efuse_map_write(struct adapter *adapter, u16 addr,
 u16 Efuse_GetCurrentSize(struct adapter *adapter, u8 efusetype, bool test);
 u8 Efuse_CalculateWordCnts(u8 word_en);
 void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
-void EFUSE_GetEfuseDefinition(struct adapter *adapt, u8 type, u8 type1,
-			      void *out, bool bPseudoTest);
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 19354eb41031..08b891b9c708 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4651,7 +4651,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		}
 		DBG_88E("%s: cnts =%d\n", __func__, cnts);
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EINVAL;
@@ -4690,7 +4690,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	} else if (strcmp(tmp[0], "mac") == 0) {
 		cnts = 6;
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%02x)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -4712,7 +4712,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 	} else if (strcmp(tmp[0], "vidpid") == 0) {
 		cnts = 4;
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%02x)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -4789,7 +4789,7 @@ static int rtw_mp_efuse_get(struct net_device *dev,
 		}
 		DBG_88E("%s: cnts =%d\n", __func__, cnts);
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -4945,7 +4945,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 		/* Change to check TYPE_EFUSE_MAP_LEN, because 8188E raw 256, logic map over 256. */
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -5020,7 +5020,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[1][kk], tmp[1][kk + 1]);
 		/* Change to check TYPE_EFUSE_MAP_LEN, because 8188E raw 256, logic map over 256. */
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -5058,7 +5058,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[1][kk], tmp[1][kk + 1]);
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -5097,7 +5097,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 		for (jj = 0, kk = 0; jj < cnts; jj++, kk += 2)
 			setdata[jj] = key_2char2num(tmp[2][kk], tmp[2][kk + 1]);
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if ((addr + cnts) > max_available_size) {
 			DBG_88E("%s: addr(0x%X)+cnts(%d) parameter error!\n", __func__, addr, cnts);
 			err = -EFAULT;
@@ -5152,7 +5152,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 	} else if (strcmp(tmp[0], "btfk2map") == 0) {
 		memcpy(pEfuseHal->BTEfuseModifiedMap, pEfuseHal->fakeBTEfuseModifiedMap, EFUSE_BT_MAX_MAP_LEN);
 
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if (max_available_size < 1) {
 			err = -EFAULT;
 			goto exit;
@@ -5164,7 +5164,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
 			goto exit;
 		}
 	} else if (strcmp(tmp[0], "wlfk2map") == 0) {
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if (max_available_size < 1) {
 			err = -EFAULT;
 			goto exit;
@@ -6032,7 +6032,7 @@ static int rtw_mp_thermal(struct net_device *dev,
 	Hal_GetThermalMeter(padapter, &val);
 
 	if (bwrite == 0) {
-		EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
+		rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_available_size, false);
 		if (2 > max_available_size) {
 			DBG_88E("no available efuse!\n");
 			return -EFAULT;
-- 
2.33.0

