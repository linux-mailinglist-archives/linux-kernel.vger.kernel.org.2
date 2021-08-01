Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4F3DCACA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhHAIq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhHAIq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 04:46:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0428C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 01:46:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so9125091wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFl/jXbwxlVM1V063kcnOGTDaoGxvWOw+VvjLFatnIk=;
        b=KDwWXQ8hvUPp5BodpKgU2+nVBENVQEoviPAYIlXon1g4snypGbrmjpVCXY+0bJVx/F
         hLbAwNeOVPUDmcWwG2No1R2QlwHZqaVzvWtYRueaJzIXpkmxji2IiFD/L2kETg69fMk2
         Ea+OgzEn/flX0F1s1bSK90f3xMuVygJ//a2em90je9lxw1+uQPrZaRz3/Kxb8Wvvc0BL
         gowHMfLftp/rhjFAkD9rT/xfv0zOo+3zmrsUvbt841DYrYnNROeeciYATpwM3zpsmW/+
         K8amVcogOvMbmjIuDrfTyDgByUsLsxWLoapWVAOQP9diuPVd3/YAvyAjL8oUxL4cuQLx
         fVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFl/jXbwxlVM1V063kcnOGTDaoGxvWOw+VvjLFatnIk=;
        b=EWnAKjW4jlk6NJTGcamj810m3FtzaYnSh133YHUp7qBULPBzmPHI6DGwskwP25E5Qj
         bxVDNp9d6cRejzhb5huwSzhzW9AUcJWnCbNiXQVHY7omS5BLd1TfP4+8W6LsKkgQVdJT
         2Pi9JYIjwzTFARPdnslyX28+GqJ8WG7DsWjenNT6E0KobSMJOT9IYGkg1NjASyuoaKZ0
         EvUjOviytc1suVeselbyiunsHZq12omS+N7Mkz3bGSQZcu8t3RQ87KRTiXam4dFEXw7X
         2HklH/+o+/8eJPbSrM1/Dl1+hSZoh8niHN9jOhP6GNTj31M6trCT4BjKVabS9DIRZXiM
         PS8w==
X-Gm-Message-State: AOAM530yLpwjS2NSzNznslebVbZS3UFbzme+/Pr8XE8u1X4ldldMAmS+
        4Bh23ONMJ2RfmcT6YuT55rE=
X-Google-Smtp-Source: ABdhPJwqETdCqVb70sHmp9RhjV2yzAHadgXzl8/Qt/TOrWMclcrNwSqsx3W41/YZFZpqvtpUTr/KRA==
X-Received: by 2002:a05:600c:49a2:: with SMTP id h34mr134781wmp.124.1627807607531;
        Sun, 01 Aug 2021 01:46:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id p15sm6754975wmi.29.2021.08.01.01.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 01:46:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: clean up comparsions to NULL in hal directory
Date:   Sun,  1 Aug 2021 10:46:13 +0200
Message-Id: <20210801084614.4328-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to NULL in the hal directory reported by
checkpatch.

x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c |  2 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     |  4 ++--
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |  2 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |  2 +-
 drivers/staging/r8188eu/hal/hal_com.c              |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c             |  4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |  4 ++--
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    | 10 +++++-----
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c       |  2 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |  8 ++++----
 drivers/staging/r8188eu/hal/usb_halinit.c          |  4 ++--
 drivers/staging/r8188eu/hal/usb_ops_linux.c        | 12 ++++++------
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index d41bfbe8ec9c..fcfcb0d104d2 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -486,7 +486,7 @@ int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 	struct odm_ra_info *pRaInfo = &dm_odm->RAInfo[macid];
 	u8 WirelessMode = 0xFF; /* invalid value */
 	u8 max_rate_idx = 0x13; /* MCS7 */
-	if (dm_odm->pWirelessMode != NULL)
+	if (dm_odm->pWirelessMode)
 		WirelessMode = *(dm_odm->pWirelessMode);
 
 	if (WirelessMode != 0xFF) {
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index f90827577059..2fbac01dd969 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -195,7 +195,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 
 	if (biol) {
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
-		if (pxmit_frame == NULL) {
+		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
@@ -474,7 +474,7 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 
 	if (biol) {
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
-		if (pxmit_frame == NULL) {
+		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 06ef2c04cebf..56b5d7c0bb9c 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -153,7 +153,7 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 
 	if (biol) {
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapt);
-		if (pxmit_frame == NULL) {
+		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 7659b0953100..fa51023cd48e 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -163,7 +163,7 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 
 	if (biol) {
 		pxmit_frame = rtw_IOL_accquire_xmit_frame(Adapter);
-		if (pxmit_frame == NULL) {
+		if (!pxmit_frame) {
 			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 91d5182f9bb1..c3c76a37e52f 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -322,7 +322,7 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 	int i;
 	u8 trigger;
 
-	if (buf == NULL)
+	if (!buf)
 		goto exit;
 
 	trigger = rtw_read8(adapter, REG_C2HEVT_CLEAR);
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 1d813b6c3678..5c4e19b1e60f 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -224,14 +224,14 @@ s32 rtw_hal_mgnt_xmit(struct adapter *adapt, struct xmit_frame *pmgntframe)
 
 s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
 {
-	if (adapt->HalFunc.init_xmit_priv != NULL)
+	if (adapt->HalFunc.init_xmit_priv)
 		return adapt->HalFunc.init_xmit_priv(adapt);
 	return _FAIL;
 }
 
 void rtw_hal_free_xmit_priv(struct adapter *adapt)
 {
-	if (adapt->HalFunc.free_xmit_priv != NULL)
+	if (adapt->HalFunc.free_xmit_priv)
 		adapt->HalFunc.free_xmit_priv(adapt);
 }
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 4bd471873531..a6bb4ecadc49 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -490,7 +490,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 
 	DBG_88E("%s\n", __func__);
 	ReservedPagePacket = (u8 *)rtw_zmalloc(1000);
-	if (ReservedPagePacket == NULL) {
+	if (!ReservedPagePacket) {
 		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
 		return;
 	}
@@ -559,7 +559,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 
 	TotalPacketLen = BufIndex + QosNullLength;
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/*  update attribute */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1a7a62dd8504..cf19ffb1bed5 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -77,13 +77,13 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 	u8 u1temp = 0;
 
 	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
-	if (efuseTbl == NULL) {
+	if (!efuseTbl) {
 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
 		goto exit;
 	}
 
 	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (eFuseWord == NULL) {
+	if (!eFuseWord) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto exit;
 	}
@@ -811,13 +811,13 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	}
 
 	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
-	if (efuseTbl == NULL) {
+	if (!efuseTbl) {
 		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
 		goto exit;
 	}
 
 	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
-	if (eFuseWord == NULL) {
+	if (!eFuseWord) {
 		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
 		goto exit;
 	}
@@ -1240,7 +1240,7 @@ static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *
 
 	EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
 
-	if (data == NULL)
+	if (!data)
 		return false;
 	if (offset > max_section)
 		return false;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 20f7f449b106..8a668e96b764 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -28,7 +28,7 @@ static void process_link_qual(struct adapter *padapter, struct recv_frame *prfra
 	struct rx_pkt_attrib *pattrib;
 	struct signal_stat *signal_stat;
 
-	if (prframe == NULL || padapter == NULL)
+	if (!prframe || !padapter)
 		return;
 
 	pattrib = &prframe->attrib;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 2e3f624d0f22..d4dd0b7376ad 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -45,7 +45,7 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 	_rtw_init_queue(&precvpriv->free_recv_buf_queue);
 
 	precvpriv->pallocated_recv_buf = rtw_zmalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4);
-	if (precvpriv->pallocated_recv_buf == NULL) {
+	if (!precvpriv->pallocated_recv_buf) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
 		goto exit;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index e44a01af7f5c..47890fb5fd8a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -444,9 +444,9 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 	RT_TRACE(_module_rtl8192c_xmit_c_, _drv_info_, ("+xmitframe_complete\n"));
 
 	/*  check xmitbuffer is ok */
-	if (pxmitbuf == NULL) {
+	if (!pxmitbuf) {
 		pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-		if (pxmitbuf == NULL)
+		if (!pxmitbuf)
 			return false;
 	}
 
@@ -455,7 +455,7 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitp
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
 		pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
-		if (pxmitframe == NULL) {
+		if (!pxmitframe) {
 			/*  no more xmit frame, release xmit buffer */
 			rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
 			return false;
@@ -638,7 +638,7 @@ static s32 pre_xmitframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 		goto enqueue;
 
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-	if (pxmitbuf == NULL)
+	if (!pxmitbuf)
 		goto enqueue;
 
 	spin_unlock_bh(&pxmitpriv->lock);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d985894c0f30..788ebb378879 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2117,7 +2117,7 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 	if (mac_id >= NUM_STA) /* CAM_SIZE */
 		return;
 	psta = pmlmeinfo->FW_sta_info[mac_id].psta;
-	if (psta == NULL)
+	if (!psta)
 		return;
 	switch (mac_id) {
 	case 0:/*  for infra mode */
@@ -2253,7 +2253,7 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	struct hal_ops	*halfunc = &adapt->HalFunc;
 
 	adapt->HalData = rtw_zmalloc(sizeof(struct hal_data_8188e));
-	if (adapt->HalData == NULL)
+	if (!adapt->HalData)
 		DBG_88E("cant not alloc memory for HAL DATA\n");
 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 577090db84be..a2df752e5aac 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -38,7 +38,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
 	/*  Acquire IO memory for vendorreq */
 	pIo_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (pIo_buf == NULL) {
+	if (!pIo_buf) {
 		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
 		status = -ENOMEM;
 		goto release_mutex;
@@ -318,7 +318,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
-		if (precvframe == NULL) {
+		if (!precvframe) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvbuf2recvframe: precvframe==NULL\n"));
 			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
 			goto _exit_recvbuf2recvframe;
@@ -587,18 +587,18 @@ static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 		return _FAIL;
 	}
 
-	if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
+	if (!precvbuf->reuse || !precvbuf->pskb) {
 		precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
-		if (NULL != precvbuf->pskb)
+		if (precvbuf->pskb)
 			precvbuf->reuse = true;
 	}
 
 		rtl8188eu_init_recvbuf(adapter, precvbuf);
 
 		/* re-assign for linux based on skb */
-		if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
+		if (!precvbuf->reuse || !precvbuf->pskb) {
 			precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
-			if (precvbuf->pskb == NULL) {
+			if (!precvbuf->pskb) {
 				RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
 				DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
 				return _FAIL;
-- 
2.32.0

