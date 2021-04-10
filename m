Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1935AE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhDJOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhDJOVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BECFC06138F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so4382626ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzrZjPzFiebrAPj0cEetindxrlNaXasA+EFRKeNIYkg=;
        b=cZUwrA9KajofofwWE7mR+rv2v5hj7z+5y0p/wP0qIcy1KWdVw3dKEthiUH2/4Gp7L/
         gUVo4XZV4J9ZgiUv0yu3GpfMbB6UVSNP8fHibP8k66XCavhP4t6QP8RjLKIzNC6evXj7
         Q/PLqa/SB5+IF8KBlvKYNkSjkEf335EMuYfgnpllPdNDjvhtiz8I3PyDcpwoRfKTVnjN
         pnS/ITYUhHFYdWySSk0wq7JqtP3UIpii6ltThoGlTmVPONw9xSKvBZ5hFkUasBrOuxpb
         UCVG3fWvyfZXkcV4XRRvXIbKX/lZ7tKjAU2kBPIa8VcbymTAXZzANgBZgnLz/0wb3anh
         abXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzrZjPzFiebrAPj0cEetindxrlNaXasA+EFRKeNIYkg=;
        b=iq6fXl1S+fX3mcBa8j5nHYMcB1d02iB2pHnenInMcHYlJ/KpHVigZZVIt/Go2vJr5x
         NW6hsUDJFynfEQ+4FcCE+OTBUsthv1n8BRzZRFL+1eYM9bet9wHk8h1jV3peOS5ELLqw
         0PHtRpxPiQeU/sHYQgXM6Z7KflZB00c3R4N1oVOblfjz1jj0Lmz8aec0o0h+ECmsSUT1
         VOBHBk81n6xNOdoKSb0RJfsN9KGZlNvgvhoFZ6B9kR11me2zENtby3uhna0/9A5NM5tu
         yp+4v7U1H3nErCmhpi8/AK28cjSOnDlKFqr2UnQ2kaxcugZvEPf235WXGHhL2Nvw5Bek
         mwWg==
X-Gm-Message-State: AOAM531H3NQKul2GpD/m5fjqSEKiWnnBo9CDghF94Emwnnjvjq6RQMrI
        PDxx+iHu8pI36kFd+eECBQ8ZoZk6Yv0qlQ==
X-Google-Smtp-Source: ABdhPJzarM5Qs+ofXtTkjn9WxLKsx2dEcqKBM0ojPHnOh/JZsSQliDqWFjfxbbLmJGiSogOCaWwaTw==
X-Received: by 2002:a17:906:e251:: with SMTP id gq17mr96546ejb.361.1618064462904;
        Sat, 10 Apr 2021 07:21:02 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id u13sm2747915ejj.16.2021.04.10.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] staging: rtl8723bs: remove unnecessary bracks
Date:   Sat, 10 Apr 2021 16:20:27 +0200
Message-Id: <812e5e0dcb78e49568276237b68dc6f9632c198d.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary bracks in if-else blocks

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  3 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       |  3 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  9 +--
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 63 ++++++++-----------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  4 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  3 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 33 +++-------
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 29 ++++-----
 8 files changed, 52 insertions(+), 95 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index fcb0f04b245d..1ffd2ce68974 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1035,9 +1035,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	s32 bmcst = IS_MCAST(pattrib->ra);
 	s32 res = _SUCCESS;
 
-	if (!pxmitframe->buf_addr) {
+	if (!pxmitframe->buf_addr)
 		return _FAIL;
-	}
 
 	pbuf_start = pxmitframe->buf_addr;
 
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index e526102bc50f..4cceb3a969a8 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -18,9 +18,8 @@ u8 rtw_hal_data_init(struct adapter *padapter)
 	if (is_primary_adapter(padapter)) {	/* if (padapter->isprimary) */
 		padapter->hal_data_sz = sizeof(struct hal_com_data);
 		padapter->HalData = vzalloc(padapter->hal_data_sz);
-		if (!padapter->HalData) {
+		if (!padapter->HalData)
 			return _FAIL;
-		}
 	}
 	return _SUCCESS;
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 9876de3a3360..f5aa9a680446 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -74,9 +74,8 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
 	do {
 		h2c_box_num = pHalData->LastHMEBoxNum;
 
-		if (!_is_fw_read_cmd_down(padapter, h2c_box_num)) {
+		if (!_is_fw_read_cmd_down(padapter, h2c_box_num))
 			goto exit;
-		}
 
 		if (CmdLen <= 3)
 			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, CmdLen);
@@ -854,9 +853,8 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 	MaxRsvdPageBufSize = RsvdPageNum*PageSize;
 
 	pcmdframe = rtw_alloc_cmdxmitframe(pxmitpriv);
-	if (!pcmdframe) {
+	if (!pcmdframe)
 		return;
-	}
 
 	ReservedPagePacket = pcmdframe->buf_addr;
 	memset(&RsvdPageLoc, 0, sizeof(struct rsvdpage_loc));
@@ -897,9 +895,8 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 	TotalPageNum += CurtPktPageNum;
 
 	TotalPacketLen = BufIndex + BTQosNullLength;
-	if (TotalPacketLen > MaxRsvdPageBufSize) {
+	if (TotalPacketLen > MaxRsvdPageBufSize)
 		goto error;
-	}
 
 	/*  update attribute */
 	pattrib = &pcmdframe->attrib;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index dc03a128d439..44cb4c5be501 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -743,14 +743,13 @@ static void hal_ReadEFuse_WiFi(
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
-	if ((_offset+_size_byte) > EFUSE_MAX_MAP_LEN) {
+	if ((_offset+_size_byte) > EFUSE_MAX_MAP_LEN)
 		return;
-	}
 
 	efuseTbl = rtw_malloc(EFUSE_MAX_MAP_LEN);
-	if (!efuseTbl) {
+	if (!efuseTbl)
 		return;
-	}
+
 	/*  0xff will be efuse default value instead of 0x00. */
 	memset(efuseTbl, 0xFF, EFUSE_MAX_MAP_LEN);
 
@@ -845,23 +844,21 @@ static void hal_ReadEFuse_BT(
 	/*  */
 	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
 	/*  */
-	if ((_offset+_size_byte) > EFUSE_BT_MAP_LEN) {
+	if ((_offset+_size_byte) > EFUSE_BT_MAP_LEN)
 		return;
-	}
 
 	efuseTbl = rtw_malloc(EFUSE_BT_MAP_LEN);
-	if (!efuseTbl) {
+	if (!efuseTbl)
 		return;
-	}
+
 	/*  0xff will be efuse default value instead of 0x00. */
 	memset(efuseTbl, 0xFF, EFUSE_BT_MAP_LEN);
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &total, bPseudoTest);
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
-		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false) {
+		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false)
 			goto exit;
-		}
 
 		eFuse_Addr = 0;
 
@@ -906,9 +903,9 @@ static void hal_ReadEFuse_BT(
 			}
 		}
 
-		if ((eFuse_Addr-1) < total) {
+		if ((eFuse_Addr-1) < total)
 			break;
-		}
+
 	}
 
 	/*  switch bank back to bank 0 for later BT and wifi use. */
@@ -985,9 +982,8 @@ static u16 hal_EfuseGetCurrentSize_WiFi(
 
 	count = 0;
 	while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-		if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false) {
+		if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false)
 			goto error;
-		}
 
 		if (efuse_data == 0xFF)
 			break;
@@ -1077,10 +1073,9 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_BT, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &retU2, bPseudoTest);
 
 	for (bank = startBank; bank < 3; bank++) {
-		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false) {
+		if (hal_EfuseSwitchToBank(padapter, bank, bPseudoTest) == false)
 			/* bank = EFUSE_MAX_BANK; */
 			break;
-		}
 
 		/*  only when bank is switched we have to reset the efuse_addr. */
 		if (bank != startBank)
@@ -1088,10 +1083,9 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 #if 1
 
 		while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-			if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false) {
+			if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false)
 				/* bank = EFUSE_MAX_BANK; */
 				break;
-			}
 
 			if (efuse_data == 0xFF)
 				break;
@@ -1264,9 +1258,8 @@ static s32 Hal_EfusePgPacketRead(
 		return false;
 
 	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, &max_section, bPseudoTest);
-	if (offset > max_section) {
+	if (offset > max_section)
 		return false;
-	}
 
 	memset(data, 0xFF, PGPKT_DATA_SIZE);
 	ret = true;
@@ -1288,9 +1281,8 @@ static s32 Hal_EfusePgPacketRead(
 		if (EXT_HEADER(efuse_data)) {
 			hoffset = GET_HDR_OFFSET_2_0(efuse_data);
 			efuse_OneByteRead(padapter, efuse_addr++, &efuse_data, bPseudoTest);
-			if (ALL_WORDS_DISABLED(efuse_data)) {
+			if (ALL_WORDS_DISABLED(efuse_data))
 				continue;
-			}
 
 			hoffset |= ((efuse_data & 0xF0) >> 1);
 			hworden = efuse_data & 0x0F;
@@ -1520,14 +1512,13 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 		efuse_OneByteRead(padapter, efuse_addr, &tmp_header, bPseudoTest);
 		if (tmp_header != 0xFF)
 			break;
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
+		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
 			return false;
-		}
+
 	} while (1);
 
-	if (tmp_header != pg_header) {
+	if (tmp_header != pg_header)
 		return false;
-	}
 
 	/*  to write ext_header */
 	efuse_addr++;
@@ -1538,14 +1529,13 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 		efuse_OneByteRead(padapter, efuse_addr, &tmp_header, bPseudoTest);
 		if (tmp_header != 0xFF)
 			break;
-		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
+		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
 			return false;
-		}
+
 	} while (1);
 
-	if (tmp_header != pg_header) { /* offset PG fail */
+	if (tmp_header != pg_header) /* offset PG fail */
 		return false;
-	}
 
 	*pAddr = efuse_addr;
 
@@ -1584,9 +1574,8 @@ static u8 hal_EfusePgPacketWriteData(
 
 	efuse_addr = *pAddr;
 	badworden = Efuse_WordEnableDataWrite(padapter, efuse_addr+1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
-	if (badworden != 0x0F) {
+	if (badworden != 0x0F)
 		return false;
-	}
 
 	return true;
 }
@@ -2070,9 +2059,8 @@ s32 rtl8723b_InitLLTTable(struct adapter *padapter)
 		}
 
 		passing_time = jiffies_to_msecs(jiffies - start);
-		if (passing_time > 1000) {
+		if (passing_time > 1000)
 			break;
-		}
 
 		msleep(1);
 	} while (1);
@@ -3294,9 +3282,8 @@ s32 c2h_handler_8723b(struct adapter *padapter, u8 *buf)
 
 static void process_c2h_event(struct adapter *padapter, struct c2h_evt_hdr_t *pC2hEvent, u8 *c2hBuf)
 {
-	if (!c2hBuf) {
+	if (!c2hBuf)
 		return;
-	}
 
 	switch (pC2hEvent->CmdID) {
 	case C2H_AP_RPT_RSP:
@@ -3768,9 +3755,9 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 	case HW_VAR_MACID_WAKEUP:
 		/*  Input is MACID */
 		val32 = *(u32 *)val;
-		if (val32 > 31) {
+		if (val32 > 31)
 			break;
-		}
+
 		val8 = (u8)val32; /*  macid is between 0~31 */
 
 		val32 = rtw_read32(padapter, REG_MACID_SLEEP);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index a1ec0bb434fd..d0606267d947 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -735,9 +735,9 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	/*  init LLT after tx buffer boundary is defined */
 	ret = rtl8723b_InitLLTTable(padapter);
-	if (_SUCCESS != ret) {
+	if (_SUCCESS != ret)
 		return _FAIL;
-	}
+
 	/*  */
 	_InitQueuePriority(padapter);
 	_InitPageBoundary(padapter);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a8d8fe54fea8..98a74f6c6876 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -184,9 +184,8 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 		u8 *tmpbuf;
 
 		tmpbuf = rtw_malloc(8);
-		if (!tmpbuf) {
+		if (!tmpbuf)
 			return SDIO_ERR_VAL32;
-		}
 
 		ftaddr &= ~(u16)0x3;
 		sd_read(intfhdl, ftaddr, 8, tmpbuf);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index a8697ae5b066..c85fd9e9e394 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -332,9 +332,8 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	bss = cfg80211_inform_bss_frame(wiphy, notify_channel, (struct ieee80211_mgmt *)buf,
 		len, notify_signal, GFP_ATOMIC);
 
-	if (unlikely(!bss)) {
+	if (unlikely(!bss))
 		goto exit;
-	}
 
 	cfg80211_put_bss(wiphy, bss);
 	kfree(buf);
@@ -548,18 +547,12 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 	{
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
 		if (!psta)
-		{
 			/* ret = -EINVAL; */
 			goto exit;
-		}
 	}
 
 	if (strcmp(param->u.crypt.alg, "none") == 0 && (psta == NULL))
-	{
-
 		goto exit;
-	}
-
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL))
 	{
@@ -1323,10 +1316,9 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 			}
 
 			pmlmepriv->wps_probe_req_ie = rtw_malloc(wps_ielen);
-			if (pmlmepriv->wps_probe_req_ie == NULL) {
+			if (pmlmepriv->wps_probe_req_ie == NULL)
 				return -EINVAL;
 
-			}
 			memcpy(pmlmepriv->wps_probe_req_ie, wps_ie, wps_ielen);
 			pmlmepriv->wps_probe_req_ie_len = wps_ielen;
 		}
@@ -1389,9 +1381,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 
 	if (request->ie && request->ie_len > 0)
-	{
 		rtw_cfg80211_set_probe_req_wpsp2pie(padapter, (u8 *)request->ie, request->ie_len);
-	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
 		need_indicate_scan_done = true;
@@ -2164,9 +2154,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 	if (unlikely(skb->len < rtap_len))
 		goto fail;
 
-	if (rtap_len != 14) {
+	if (rtap_len != 14)
 		goto fail;
-	}
 
 	/* Skip the ratio tap header */
 	skb_pull(skb, rtap_len);
@@ -2212,9 +2201,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		u32 len = skb->len;
 		u8 category, action;
 
-		if (rtw_action_frame_parse(buf, len, &category, &action) == false) {
+		if (rtw_action_frame_parse(buf, len, &category, &action) == false)
 			goto fail;
-		}
 
 		/* starting alloc mgmt frame to dump it */
 		pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -2494,10 +2482,8 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	const u8 *mac = params->mac;
 
-	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true) {
+	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
-	}
-
 
 	if (!mac) {
 		flush_all_cam_entry(padapter);	/* clear CAM */
@@ -2719,9 +2705,8 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	/* indicate ack before issue frame to avoid racing with rsp frame */
 	rtw_cfg80211_mgmt_tx_status(padapter, *cookie, buf, len, ack, GFP_KERNEL);
 
-	if (rtw_action_frame_parse(buf, len, &category, &action) == false) {
+	if (rtw_action_frame_parse(buf, len, &category, &action) == false)
 		goto exit;
-	}
 
 	rtw_ps_deny(padapter, PS_DENY_MGNT_TX);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
@@ -2925,9 +2910,8 @@ int rtw_wdev_alloc(struct adapter *padapter, struct device *dev)
 	rtw_regd_init(wiphy, rtw_reg_notifier);
 
 	ret = wiphy_register(wiphy);
-	if (ret < 0) {
+	if (ret < 0)
 		goto free_wiphy;
-	}
 
 	/*  wdev */
 	wdev = rtw_zmalloc(sizeof(struct wireless_dev));
@@ -3005,9 +2989,8 @@ void rtw_wdev_unregister(struct wireless_dev *wdev)
 
 	rtw_cfg80211_indicate_scan_done(adapter, true);
 
-	if (pwdev_priv->pmon_ndev) {
+	if (pwdev_priv->pmon_ndev)
 		unregister_netdev(pwdev_priv->pmon_ndev);
-	}
 
 	wiphy_unregister(wdev->wiphy);
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 61b36955efc8..34c5eff02b2f 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -160,15 +160,14 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 	if (func) {
 		sdio_claim_host(func);
 		err = sdio_disable_func(func);
-		if (err) {
+		if (err)
 			dvobj->drv_dbg.dbg_sdio_deinit_error_cnt++;
-		}
 
 		if (dvobj->irq_alloc) {
 			err = sdio_release_irq(func);
-			if (err) {
+			if (err)
 				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
-			} else
+			else
 				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
 		}
 
@@ -182,9 +181,8 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 	struct sdio_data *psdio;
 
 	dvobj = devobj_init();
-	if (dvobj == NULL) {
+	if (dvobj == NULL)
 		goto exit;
-	}
 
 	sdio_set_drvdata(func, dvobj);
 
@@ -230,9 +228,8 @@ void rtw_set_hal_ops(struct adapter *padapter)
 
 static void sd_intf_start(struct adapter *padapter)
 {
-	if (padapter == NULL) {
+	if (padapter == NULL)
 		return;
-	}
 
 	/*  hal dep */
 	rtw_hal_enable_interrupt(padapter);
@@ -240,9 +237,8 @@ static void sd_intf_start(struct adapter *padapter)
 
 static void sd_intf_stop(struct adapter *padapter)
 {
-	if (padapter == NULL) {
+	if (padapter == NULL)
 		return;
-	}
 
 	/*  hal dep */
 	rtw_hal_disable_interrupt(padapter);
@@ -257,9 +253,8 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	struct sdio_data *psdio = &dvobj->intf_data;
 
 	padapter = vzalloc(sizeof(*padapter));
-	if (padapter == NULL) {
+	if (padapter == NULL)
 		goto exit;
-	}
 
 	padapter->dvobj = dvobj;
 	dvobj->if1 = padapter;
@@ -354,9 +349,8 @@ static void rtw_sdio_if1_deinit(struct adapter *if1)
 
 	rtw_dev_unload(if1);
 
-	if (if1->rtw_wdev) {
+	if (if1->rtw_wdev)
 		rtw_wdev_free(if1->rtw_wdev);
-	}
 
 	rtw_free_drv_sw(if1);
 
@@ -400,9 +394,9 @@ static int rtw_drv_init(
 free_if2:
 	if (status != _SUCCESS && if2) {
 	}
-	if (status != _SUCCESS && if1) {
+	if (status != _SUCCESS && if1)
 		rtw_sdio_if1_deinit(if1);
-	}
+
 free_dvobj:
 	if (status != _SUCCESS)
 		sdio_dvobj_deinit(func);
@@ -426,9 +420,8 @@ static void rtw_dev_remove(struct sdio_func *func)
 		sdio_claim_host(func);
 		sdio_readb(func, 0, &err);
 		sdio_release_host(func);
-		if (err == -ENOMEDIUM) {
+		if (err == -ENOMEDIUM)
 			padapter->bSurpriseRemoved = true;
-		}
 	}
 
 	rtw_ps_deny(padapter, PS_DENY_DRV_REMOVE);
-- 
2.20.1

