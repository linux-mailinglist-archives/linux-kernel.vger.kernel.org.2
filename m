Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68A35AE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhDJOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04294C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so13012638ejz.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjbBfPVyaC4MGJ/Ud9uRphtmMDMv46G9Fk5sFPVHPHI=;
        b=opr+D6d/nYyG03/ygvPC7AserHaEzyHrcw03lLX/UVf6+z85OctQ3f8IoUY+QSTXhq
         nVk/eKoAv2i6JCcIPn+yW6A5KuUfTo5HzID5VvT+CPgFx/KExJkIGvs6NkxNfThMGmiW
         Zzdi4LOtyxl4jFCGTPzr+0HJR2ypjOeE8QD+lV2lCCeAT3eo5aEIkt4t/gPQkx9TttOb
         lkL7ZtXUsBIT0Sak5xjxm8ZDBVHTqJAd8aS5g9VAY0ej/VDURm7E1na5KrWAbsYueCVK
         4HkMm0EEtXNPoOz/FHTXMDBHVhnDeINbIE5PS/dYBx1M8Kjor8L47q0QDyRyw6N5P+y3
         VZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjbBfPVyaC4MGJ/Ud9uRphtmMDMv46G9Fk5sFPVHPHI=;
        b=oyjhrsALmCvpivPXafmQ6o4zAJfoCW13OgDe9Nbw7yLW1skWvnQKC7X766g9pFy1OJ
         SeIEa0GMrbkyLMMpaITcVngch0veyIHq4gQW+kqeSfCOSbys9H+CpS4PYZmmkT3sBZCn
         axr7PwNL4mcY62USy7VSdAWWgzFRTc5EHVCr6kQnuOCtasIFeShAE6KCPB1rmzRlO6Do
         Ivs8Mp8T+rRZtOUWCqVWkleZCTcXymAxcg2c/UuHug+A2j0bDeXHl8WIVC01/2ai5qko
         67NiAFRXo4hZ68XIBvb3nBFq0+xcUNjZL4NSfeSVJieT2eFYw0H1oQXODqB/AfG+XFQy
         OSxQ==
X-Gm-Message-State: AOAM5326f9rp4lEIwMIIf8F1bBPZc2lT3o593umG56ijf1sDpx57Huux
        AzjPSj08nIQMBnl5ADby0c7ixzyyGZUdyQ==
X-Google-Smtp-Source: ABdhPJwwgi0w0zbrlEz/dJPiITbLrrX7zSAva+B6fUPj9kYhtiLc58o5QsWpRzScu6h0uucsk5yx0Q==
X-Received: by 2002:a17:907:77d4:: with SMTP id kz20mr20443992ejc.93.1618064444020;
        Sat, 10 Apr 2021 07:20:44 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id s17sm2712159ejx.10.2021.04.10.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] staging: rtl8723bs: remove all commented out DBG_8192C logs
Date:   Sat, 10 Apr 2021 16:20:15 +0200
Message-Id: <d954fbde0ae689cd053a57f57f954f14b5d013cb.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all commented out DBG_8192C logs.

Macro DBG_8192C belongs to a family of verbose
private tracing macros.

The default behaviour is _do nothing_, to activate
it one should define DEBUG symbol by hand.

So just remove it

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  1 -
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  3 ---
 drivers/staging/rtl8723bs/hal/odm.c           |  1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 12 -----------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 21 -------------------
 .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  3 ---
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  2 --
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  4 ----
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  5 -----
 9 files changed, 52 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 2af66a18200d..3b0148dbf353 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -672,7 +672,6 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 	eid = ie_ptr[0];
 
 	if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&ie_ptr[2], wps_oui, 4))) {
-		/* DBG_8192C("==> found WPS_IE.....\n"); */
 		*wps_ielen = ie_ptr[1]+2;
 		match = true;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 76c4105d1fe8..c1b893451788 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -504,14 +504,11 @@ void read_cam(struct adapter *padapter, u8 entry, u8 *get_key)
 
 	addr = entry << 3;
 
-	/* DBG_8192C("********* DUMP CAM Entry_#%02d***************\n", entry); */
 	for (j = 0; j < 6; j++) {
 		cmd = _ReadCAM(padapter, addr+j);
-		/* DBG_8192C("offset:0x%02x => 0x%08x\n", addr+j, cmd); */
 		if (j > 1) /* get key from cam */
 			memcpy(get_key+(j-2)*4, &cmd, 4);
 	}
-	/* DBG_8192C("*********************************\n"); */
 }
 
 void _write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key)
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index dea4e3679b8e..092b32c41ff3 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -635,7 +635,6 @@ static void FindMinimumRSSI(struct adapter *padapter)
 	} else
 		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
 
-	/* DBG_8192C("%s =>MinUndecoratedPWDBForDM(%d)\n", __func__, pdmpriv->MinUndecoratedPWDBForDM); */
 	/* ODM_RT_TRACE(pDM_Odm, COMP_DIG, DBG_LOUD, ("MinUndecoratedPWDBForDM =%d\n", pHalData->MinUndecoratedPWDBForDM)); */
 }
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index de8717f21e28..2c50ff2d16f6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -24,8 +24,6 @@ static u8 _is_fw_read_cmd_down(struct adapter *padapter, u8 msgbox_num)
 
 	u8 valid;
 
-	/* DBG_8192C(" _is_fw_read_cmd_down , reg_1cc(%x), msg_box(%d)...\n", rtw_read8(padapter, REG_HMETFR), msgbox_num); */
-
 	do {
 		valid = rtw_read8(padapter, REG_HMETFR) & BIT(msgbox_num);
 		if (0 == valid) {
@@ -77,8 +75,6 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 		h2c_box_num = pHalData->LastHMEBoxNum;
 
 		if (!_is_fw_read_cmd_down(padapter, h2c_box_num)) {
-			/* DBG_8192C(" 0x1c0: 0x%8x\n", rtw_read32(padapter, 0x1c0)); */
-			/* DBG_8192C(" 0x1c4: 0x%8x\n", rtw_read32(padapter, 0x1c4)); */
 			goto exit;
 		}
 
@@ -99,9 +95,6 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 		msgbox_addr = REG_HMEBOX_0 + (h2c_box_num*MESSAGE_BOX_SIZE);
 		rtw_write32(padapter, msgbox_addr, h2c_cmd);
 
-		/* DBG_8192C("MSG_BOX:%d, CmdLen(%d), CmdID(0x%x), reg:0x%x =>h2c_cmd:0x%.8x, reg:0x%x =>h2c_cmd_ex:0x%.8x\n" */
-		/* 	, pHalData->LastHMEBoxNum , CmdLen, ElementID, msgbox_addr, h2c_cmd, msgbox_ex_addr, h2c_cmd_ex); */
-
 		pHalData->LastHMEBoxNum = (h2c_box_num+1) % MAX_H2C_BOX_NUMS;
 
 	} while (0);
@@ -852,9 +845,6 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 	u32 TotalPacketLen, MaxRsvdPageBufSize = 0;
 	struct rsvdpage_loc RsvdPageLoc;
 
-
-/* 	DBG_8192C("+" FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(padapter)); */
-
 	pxmitpriv = &padapter->xmitpriv;
 	TxDescLen = TXDESC_SIZE;
 	TxDescOffset = TXDESC_OFFSET;
@@ -918,8 +908,6 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 	pattrib->pktlen = pattrib->last_txcmdsz = TotalPacketLen - TxDescOffset;
 	dump_mgntframe_and_wait(padapter, pcmdframe, 100);
 
-/* 	DBG_8192C(FUNC_ADPT_FMT ": Set RSVD page location to Fw, TotalPacketLen(%d), TotalPageNum(%d)\n", */
-/* 		FUNC_ADPT_ARG(padapter), TotalPacketLen, TotalPageNum); */
 	rtl8723b_set_FwRsvdPage_cmd(padapter, &RsvdPageLoc);
 	rtl8723b_set_FwAoacRsvdPage_cmd(padapter, &RsvdPageLoc);
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index ff05f3bf09b2..30845235c7a4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -777,15 +777,12 @@ if (0) {
 		if (efuseHeader == 0xFF) {
 			break;
 		}
-		/* DBG_8192C("%s: efuse[0x%X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseHeader); */
 
 		/*  Check PG header for section num. */
 		if (EXT_HEADER(efuseHeader)) { /* extended header */
 			offset = GET_HDR_OFFSET_2_0(efuseHeader);
-			/* DBG_8192C("%s: extended header offset = 0x%X\n", __func__, offset); */
 
 			efuse_OneByteRead(padapter, eFuse_Addr++, &efuseExtHdr, bPseudoTest);
-			/* DBG_8192C("%s: efuse[0x%X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseExtHdr); */
 			if (ALL_WORDS_DISABLED(efuseExtHdr))
 				continue;
 
@@ -795,23 +792,19 @@ if (0) {
 			offset = ((efuseHeader >> 4) & 0x0f);
 			wden = (efuseHeader & 0x0f);
 		}
-		/* DBG_8192C("%s: Offset =%d Worden = 0x%X\n", __func__, offset, wden); */
 
 		if (offset < EFUSE_MAX_SECTION_8723B) {
 			u16 addr;
 			/*  Get word enable value from PG header */
-/* 			DBG_8192C("%s: Offset =%d Worden = 0x%X\n", __func__, offset, wden); */
 
 			addr = offset * PGPKT_DATA_SIZE;
 			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 				/*  Check word enable condition in the section */
 				if (!(wden & (0x01<<i))) {
 					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
-/* 					DBG_8192C("%s: efuse[%#X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseData); */
 					efuseTbl[addr] = efuseData;
 
 					efuse_OneByteRead(padapter, eFuse_Addr++, &efuseData, bPseudoTest);
-/* 					DBG_8192C("%s: efuse[%#X]= 0x%02X\n", __func__, eFuse_Addr-1, efuseData); */
 					efuseTbl[addr+1] = efuseData;
 				}
 				addr += 2;
@@ -1225,8 +1218,6 @@ static u8 Hal_EfuseWordEnableDataWrite(
 	u8 badworden = 0x0F;
 	u8 tmpdata[PGPKT_DATA_SIZE];
 
-
-/* 	DBG_8192C("%s: efuse_addr =%#x word_en =%#x\n", __func__, efuse_addr, word_en); */
 	memset(tmpdata, 0xFF, PGPKT_DATA_SIZE);
 
 	if (!(word_en & BIT(0))) {
@@ -1338,11 +1329,9 @@ static s32 Hal_EfusePgPacketRead(
 				/*  Check word enable condition in the section */
 				if (!(hworden & (0x01<<i))) {
 					efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
-/* 					DBG_8192C("%s: efuse[%#X]= 0x%02X\n", __func__, efuse_addr+tmpidx, efuse_data); */
 					data[i*2] = efuse_data;
 
 					efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
-/* 					DBG_8192C("%s: efuse[%#X]= 0x%02X\n", __func__, efuse_addr+tmpidx, efuse_data); */
 					data[(i*2)+1] = efuse_data;
 				}
 			}
@@ -1364,7 +1353,6 @@ static u8 hal_EfusePgCheckAvailableAddr(
 
 
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &max_available, bPseudoTest);
-/* 	DBG_8192C("%s: max_available =%d\n", __func__, max_available); */
 
 	current_size = Efuse_GetCurrentSize(padapter, efuseType, bPseudoTest);
 	if (current_size >= max_available) {
@@ -1441,7 +1429,6 @@ static u8 hal_EfusePartialWriteCheck(
 				startAddr++;
 				efuse_OneByteRead(padapter, startAddr, &efuse_data, bPseudoTest);
 				if (ALL_WORDS_DISABLED(efuse_data)) {
-					DBG_8192C("%s: Error condition, all words disabled!", __func__);
 					bRet = false;
 					break;
 				} else {
@@ -1462,7 +1449,6 @@ static u8 hal_EfusePartialWriteCheck(
 				(hal_EfuseCheckIfDatafollowed(padapter, curPkt.word_cnts, startAddr+1, bPseudoTest) == false) &&
 				wordEnMatched(pTargetPkt, &curPkt, &matched_wden) == true
 			) {
-				DBG_8192C("%s: Need to partial write data by the previous wrote header\n", __func__);
 				/*  Here to write partial data */
 				badworden = Efuse_WordEnableDataWrite(padapter, startAddr+1, matched_wden, pTargetPkt->data, bPseudoTest);
 				if (badworden != 0x0F) {
@@ -1492,7 +1478,6 @@ static u8 hal_EfusePartialWriteCheck(
 		} else {
 			/*  not used header, 0xff */
 			*pAddr = startAddr;
-/* 			DBG_8192C("%s: Started from unused header offset =%d\n", __func__, startAddr)); */
 			bRet = true;
 			break;
 		}
@@ -1554,7 +1539,6 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 	}
 
 	pg_header = ((pTargetPkt->offset & 0x07) << 5) | 0x0F;
-/* 	DBG_8192C("%s: pg_header = 0x%x\n", __func__, pg_header); */
 
 	do {
 		efuse_OneByteWrite(padapter, efuse_addr, pg_header, bPseudoTest);
@@ -1629,7 +1613,6 @@ static u8 hal_EfusePgPacketWriteData(
 		return false;
 	}
 
-/* 	DBG_8192C("%s: ok\n", __func__); */
 	return true;
 }
 
@@ -2683,8 +2666,6 @@ static u8 fill_txdesc_sectype(struct pkt_attrib *pattrib)
 
 static void fill_txdesc_vcs_8723b(struct adapter *padapter, struct pkt_attrib *pattrib, struct txdesc_8723b *ptxdesc)
 {
-	/* DBG_8192C("cvs_mode =%d\n", pattrib->vcs_mode); */
-
 	if (pattrib->vcs_mode) {
 		switch (pattrib->vcs_mode) {
 		case RTS_CTS:
@@ -2716,8 +2697,6 @@ static void fill_txdesc_vcs_8723b(struct adapter *padapter, struct pkt_attrib *p
 
 static void fill_txdesc_phy_8723b(struct adapter *padapter, struct pkt_attrib *pattrib, struct txdesc_8723b *ptxdesc)
 {
-	/* DBG_8192C("bwmode =%d, ch_off =%d\n", pattrib->bwmode, pattrib->ch_offset); */
-
 	if (pattrib->ht_en) {
 		ptxdesc->data_bw = BWMapping_8723B(padapter, pattrib);
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
index 86512264e280..f2f02a69f0af 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
@@ -13,7 +13,6 @@ static void process_rssi(struct adapter *padapter, union recv_frame *prframe)
 	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
 	struct signal_stat *signal_stat = &padapter->recvpriv.signal_strength_data;
 
-	/* DBG_8192C("process_rssi => pattrib->rssil(%d) signal_strength(%d)\n ", pattrib->RecvSignalPower, pattrib->signal_strength); */
 	/* if (pRfd->Status.bPacketToSelf || pRfd->Status.bPacketBeacon) */
 	{
 		if (signal_stat->update_req) {
@@ -40,8 +39,6 @@ static void process_link_qual(struct adapter *padapter, union recv_frame *prfram
 	pattrib = &prframe->u.hdr.attrib;
 	signal_stat = &padapter->recvpriv.signal_qual_data;
 
-	/* DBG_8192C("process_link_qual => pattrib->signal_qual(%d)\n ", pattrib->signal_qual); */
-
 	if (signal_stat->update_req) {
 		signal_stat->total_num = 0;
 		signal_stat->total_val = 0;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 09d53006595d..a69cc24c81c7 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -125,8 +125,6 @@ static void update_recvframe_phyinfo(union recv_frame *precvframe,
 	psta = rtw_get_stainfo(pstapriv, sa);
 	if (psta) {
 		pkt_info.station_id = psta->mac_id;
-		/* DBG_8192C("%s ==> StationID(%d)\n",
-		 * 	  __func__, pkt_info.station_id); */
 	}
 	pkt_info.data_rate = pattrib->data_rate;
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a5d6ff591064..a1ec0bb434fd 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -101,17 +101,14 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
 	/*  Switch the control of EESK, EECS to RFC for DPDT or Antenna switch */
 	value16 |= BIT(11); /*  BIT_EEPRPAD_RFE_CTRL_EN */
 	rtw_write16(padapter, REG_PWR_DATA, value16);
-/* 	DBG_8192C("%s: REG_PWR_DATA(0x%x) = 0x%04X\n", __func__, REG_PWR_DATA, rtw_read16(padapter, REG_PWR_DATA)); */
 
 	value32 = rtw_read32(padapter, REG_LEDCFG0);
 	value32 |= BIT(23); /*  DPDT_SEL_EN, 1 for SW control */
 	rtw_write32(padapter, REG_LEDCFG0, value32);
-/* 	DBG_8192C("%s: REG_LEDCFG0(0x%x) = 0x%08X\n", __func__, REG_LEDCFG0, rtw_read32(padapter, REG_LEDCFG0)); */
 
 	value8 = rtw_read8(padapter, REG_PAD_CTRL1_8723B);
 	value8 &= ~BIT(0); /*  BIT_SW_DPDT_SEL_DATA, DPDT_SEL default configuration */
 	rtw_write8(padapter, REG_PAD_CTRL1_8723B, value8);
-/* 	DBG_8192C("%s: REG_PAD_CTRL1(0x%x) = 0x%02X\n", __func__, REG_PAD_CTRL1_8723B, rtw_read8(padapter, REG_PAD_CTRL1_8723B)); */
 
 	return _SUCCESS;
 }
@@ -1263,7 +1260,6 @@ static void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf
 {
 	switch (variable) {
 	case HW_VAR_C2H_HANDLE:
-		/* DBG_8192C("%s len =%d\n", __func__, len); */
 		C2HPacketHandler_8723B(padapter, pbuf, len);
 		break;
 	default:
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 986b3e2cf263..b7dffdaffda7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -855,8 +855,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 		struct sta_info *psta, *pbcmc_sta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		/* DBG_8192C("%s, : dot11AuthAlgrthm == dot11AuthAlgrthm_8021X\n", __func__); */
-
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_MP_STATE) == true) /* sta mode */
 		{
 			psta = rtw_get_stainfo(pstapriv, get_bssid(pmlmepriv));
@@ -1028,7 +1026,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
         else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true
                 || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)
         {
-                /* DBG_8192C("@@@@@@@@@@ fw_state = 0x%x, iftype =%d\n", pmlmepriv->fw_state, rtw_wdev->iftype); */
                 ret =  rtw_cfg80211_set_encryption(ndev, param, param_len);
         }
 	else
@@ -1785,8 +1782,6 @@ static int cfg80211_rtw_join_ibss(struct wiphy *wiphy, struct net_device *ndev,
 	ndis_ssid.SsidLength = params->ssid_len;
 	memcpy(ndis_ssid.Ssid, (u8 *)params->ssid, params->ssid_len);
 
-	/* DBG_8192C("ssid =%s, len =%zu\n", ndis_ssid.Ssid, params->ssid_len); */
-
 	psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
 	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
 	psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-- 
2.20.1

