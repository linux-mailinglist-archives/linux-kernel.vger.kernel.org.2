Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306693DBFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhG3Umj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhG3Umh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:42:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:42:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cf5so3361625edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bXynGEqOJHkJwCtzi1WEXHAiHDgr9LWPixk6bANtgQ=;
        b=ntSQcXj0R/pRWfvUQF7VmJxGVwwOcpz3FSfcWDmQeCBJW4eIEL2m1FI6mATsBrvqda
         giGkeAyrPsEylKwnPy8HBQchuwpNmCnt8LYrq9Ctn6pZjjqdJ5oIelzK1BT1daWlEu0I
         nQTW59tg4gJ0FGoeck4dvM/C+OdHAi7/OqCVdscgkezkZAaCaogD6E7I35yOzB/2mlwo
         fLOpYLwzFqn0Ev/JtuJKMQiasLjazAfnH/7yMhQzILaJhQJVHa0GJsEOW4nywPEjzIFf
         bwMj07GFclgo8/moaP6giVZC1Q5WwP7RzpHG5rTxia2pnA7Y7cOBT37M8jLQBkQzE2Hw
         oviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bXynGEqOJHkJwCtzi1WEXHAiHDgr9LWPixk6bANtgQ=;
        b=mfILikQXpRw/bnE2RckZ2XHwTxvNA7nG2VMnwrcvwTN6d2I1eKoSKLXdlKtvK1phKI
         +cA3iReyAH6UzMPTsolIrOBRIjBet57UHEYDpJhVUYM8YcBkSVwVWEBSdSjAqSyRwa8c
         8riboG4quC9n6SJN2q6b7dg1zCy9J+h/j/cAhk8oPRWEvxQW99FsBhLnEr4KJs6rlU7T
         BgZ489Pu7RRZH+77tfVdvUAjguyQ1m4T1mkSsL1HBoSsKtmnGRYvOwxbsVmTldkRVJkJ
         J3EadErO+EFdrL48BWhgkpAxdEwObEwVMJo4FZZTE8bEsjv/wJcY6T4tounuqzbHYI8p
         6eZg==
X-Gm-Message-State: AOAM530CEW1QJ3aLy5pCA/OKtCgCjDw0lV2hfH3OP5TbIxbr7IeR2/hZ
        JPdEELOzU0+BKphMohR4QBc=
X-Google-Smtp-Source: ABdhPJx72OkPyhGMXHPHt8UaHo+Xz/szq1fD5ogzCl3878cJccTvGMNBFiu//L/TYEinILiCHRtP1w==
X-Received: by 2002:aa7:cf98:: with SMTP id z24mr5413223edx.136.1627677750424;
        Fri, 30 Jul 2021 13:42:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id dg20sm1139034edb.13.2021.07.30.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 13:42:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove spaces before ',' and ')'
Date:   Fri, 30 Jul 2021 22:41:52 +0200
Message-Id: <20210730204153.27270-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spaces to clear checkpatch errors.

ERROR: space prohibited before that ',' (ctx:WxW)
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  4 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 14 ++---
 drivers/staging/r8188eu/core/rtw_io.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_iol.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 18 +++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 52 +++++++++----------
 drivers/staging/r8188eu/core/rtw_mp.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        | 12 ++---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 14 ++---
 drivers/staging/r8188eu/core/rtw_xmit.c       |  6 +--
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  4 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    | 14 ++---
 drivers/staging/r8188eu/hal/hal_com.c         |  2 +-
 drivers/staging/r8188eu/hal/odm.c             | 10 ++--
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 12 ++---
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 19 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index c7c892ab4ae6..463c9ca40492 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -492,7 +492,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		tx_ra_bitmap |= ((raid<<28)&0xf0000000);
 
 		DBG_88E("%s => mac_id:%d , raid:%d , bitmap = 0x%x, arg = 0x%x\n",
-			__func__ , psta->mac_id, raid , tx_ra_bitmap, arg);
+			__func__, psta->mac_id, raid, tx_ra_bitmap, arg);
 
 		/* bitmap[0:27] = tx_rate_bitmap */
 		/* bitmap[28:31]= Rate Adaptive id */
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 82eb2134c1e4..e84540a7d2c5 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -245,7 +245,7 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 	u32 k = 0;
 	u16 contentLen = 0;
 
-	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI , TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
+	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
 
 	if (Address < contentLen) {	/* E-fuse 512Byte */
 		/* Write E-fuse Register address bit0~7 */
@@ -470,7 +470,7 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 u16 efuse_GetMaxSize(struct adapter *padapter)
 {
 	u16 max_size;
-	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI , TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
+	EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
 	return max_size;
 }
 /*  */
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 270a3848c3d6..f5ea93e2fff9 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -772,7 +772,7 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
  *
  * Returns: the address of the specific WPS attribute found, or NULL
  */
-u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id , u8 *buf_attr, u32 *len_attr)
+u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_attr, u32 *len_attr)
 {
 	u8 *attr_ptr = NULL;
 	u8 *target_attr_ptr = NULL;
@@ -782,7 +782,7 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id , u8 *buf_at
 		*len_attr = 0;
 
 	if ((wps_ie[0] != _VENDOR_SPECIFIC_IE_) ||
-	    (memcmp(wps_ie + 2, wps_oui , 4)))
+	    (memcmp(wps_ie + 2, wps_oui, 4)))
 		return attr_ptr;
 
 	/*  6 = 1(Element ID) + 1(Length) + 4(WPS OUI) */
@@ -818,7 +818,7 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id , u8 *buf_at
  *
  * Returns: the address of the specific WPS attribute content found, or NULL
  */
-u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id , u8 *buf_content, uint *len_content)
+u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_content, uint *len_content)
 {
 	u8 *attr_ptr;
 	u32 attr_len;
@@ -1217,7 +1217,7 @@ u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen)
  *
  * Returns: the address of the specific WPS attribute found, or NULL
  */
-u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id , u8 *buf_attr, u32 *len_attr)
+u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id, u8 *buf_attr, u32 *len_attr)
 {
 	u8 *attr_ptr = NULL;
 	u8 *target_attr_ptr = NULL;
@@ -1227,7 +1227,7 @@ u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id , u8 *buf_att
 		*len_attr = 0;
 
 	if (!p2p_ie || (p2p_ie[0] != _VENDOR_SPECIFIC_IE_) ||
-	    memcmp(p2p_ie + 2, p2p_oui , 4))
+	    memcmp(p2p_ie + 2, p2p_oui, 4))
 		return attr_ptr;
 
 	/*  6 = 1(Element ID) + 1(Length) + 3 (OUI) + 1(OUI Type) */
@@ -1264,7 +1264,7 @@ u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id , u8 *buf_att
  *
  * Returns: the address of the specific P2P attribute content found, or NULL
  */
-u8 *rtw_get_p2p_attr_content(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id , u8 *buf_content, uint *len_content)
+u8 *rtw_get_p2p_attr_content(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id, u8 *buf_content, uint *len_content)
 {
 	u8 *attr_ptr;
 	u32 attr_len;
@@ -1452,7 +1452,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	} else {
 		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
-	rtw_get_sec_ie(pnetwork->network.IEs , pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
+	rtw_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength, NULL, &rsn_len, NULL, &wpa_len);
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: ssid =%s\n", pnetwork->network.Ssid.Ssid));
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index e0909d3d6307..2c8e7707c9fa 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -120,7 +120,7 @@ int _rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-int _rtw_writeN(struct adapter *adapter, u32 addr , u32 length , u8 *pdata)
+int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl *pintfhdl = (struct intf_hdl *)(&(pio_priv->intf));
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 12a99588fbe2..778da7c86995 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -1011,7 +1011,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		if (p && ht_ielen > 0) {
 			pht_capie = (struct ieee80211_ht_cap *)(p+2);
 
-			memcpy(&mcs_rate , pht_capie->mcs.rx_mask, 2);
+			memcpy(&mcs_rate, pht_capie->mcs.rx_mask, 2);
 
 			/* cur_bwmod is updated by beacon, pmlmeinfo is updated by association response */
 			bw_40MHz = (pmlmeext->cur_bwmode && (HT_INFO_HT_PARAM_REC_TRANS_CHNL_WIDTH & pmlmeinfo->HT_info.infos[0])) ? 1 : 0;
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 2f38ff8cacef..0382ff524657 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -51,7 +51,7 @@ int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds, u32 cmd_len
 	/* check if the io_buf can accommodate new cmds */
 	if (ori_len + cmd_len + 8 > MAX_XMITBUF_SZ) {
 		DBG_88E("%s %u is large than MAX_XMITBUF_SZ:%u, can't accommodate new cmds\n",
-			__func__ , ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
+			__func__, ori_len + cmd_len + 8, MAX_XMITBUF_SZ);
 		return _FAIL;
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index fe826e5831a3..f07e4e233788 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -190,7 +190,7 @@ struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *f
 	}
 	plist = (&(free_queue->queue))->next;
 
-	pnetwork = container_of(plist , struct wlan_network, list);
+	pnetwork = container_of(plist, struct wlan_network, list);
 
 	list_del_init(&pnetwork->list);
 
@@ -209,7 +209,7 @@ struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *f
 	return pnetwork;
 }
 
-void _rtw_free_network(struct	mlme_priv *pmlmepriv , struct wlan_network *pnetwork, u8 isfreeall)
+void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwork, u8 isfreeall)
 {
 	u32 curr_time, delta_time;
 	u32 lifetime = SCANQUEUE_LIFETIME;
@@ -268,7 +268,7 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 	plist = phead->next;
 
 	while (plist != phead) {
-		pnetwork = container_of(plist, struct wlan_network , list);
+		pnetwork = container_of(plist, struct wlan_network, list);
 		if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
 			break;
 		plist = plist->next;
@@ -700,7 +700,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 }
 
 /* TODO: Perry: For Power Management */
-void rtw_atimdone_event_callback(struct adapter	*adapter , u8 *pbuf)
+void rtw_atimdone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("receive atimdone_evet\n"));
@@ -734,7 +734,7 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 			spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 			ibss_wlan = rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->MacAddress);
 			if (ibss_wlan) {
-				memcpy(ibss_wlan->network.IEs , pnetwork->IEs, 8);
+				memcpy(ibss_wlan->network.IEs, pnetwork->IEs, 8);
 				spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 				goto exit;
 			}
@@ -859,11 +859,11 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 }
 
-void rtw_dummy_event_callback(struct adapter *adapter , u8 *pbuf)
+void rtw_dummy_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 }
 
-void rtw_fwdbg_event_callback(struct adapter *adapter , u8 *pbuf)
+void rtw_fwdbg_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 }
 
@@ -1524,7 +1524,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 				DBG_88E("%s try another roaming\n", __func__);
 				do_join_r = rtw_do_join(adapter);
 				if (_SUCCESS != do_join_r) {
-					DBG_88E("%s roaming do_join return %d\n", __func__ , do_join_r);
+					DBG_88E("%s roaming do_join return %d\n", __func__, do_join_r);
 					continue;
 				}
 				break;
@@ -2169,7 +2169,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		p = rtw_get_ie(in_ie+12, _HT_ADD_INFO_IE_, &ielen, in_len-12);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
-			rtw_set_ie(out_ie+out_len, _HT_ADD_INFO_IE_, ielen, p+2 , pout_len);
+			rtw_set_ie(out_ie+out_len, _HT_ADD_INFO_IE_, ielen, p+2, pout_len);
 		}
 	}
 	return phtpriv->ht_option;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 3fa89ef293d1..1160b7caffdd 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -847,7 +847,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			/* checking for challenging txt... */
 			DBG_88E("checking for challenging txt...\n");
 
-			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_ , _CHLGETXT_IE_, (int *)&ie_len,
+			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if ((p == NULL) || (ie_len <= 0)) {
@@ -889,7 +889,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 auth_fail:
 
 	if (pstat)
-		rtw_free_stainfo(padapter , pstat);
+		rtw_free_stainfo(padapter, pstat);
 
 	pstat = &stat;
 	memset((char *)pstat, '\0', sizeof(stat));
@@ -1096,7 +1096,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		memcpy(supportRate, p+2, ie_len);
 		supportRateNum = ie_len;
 
-		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_ , &ie_len,
+		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_, &ie_len,
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 		if (p !=  NULL) {
 			if (supportRateNum <= sizeof(supportRate)) {
@@ -1195,7 +1195,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 			if (pmlmepriv->wps_beacon_ie) {
 				u8 selected_registrar = 0;
 
-				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR , &selected_registrar, NULL);
+				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
 
 				if (!selected_registrar) {
 					DBG_88E("selected_registrar is false , or AP is not ready to do WPS\n");
@@ -1332,7 +1332,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 #ifdef CONFIG_88EU_P2P
 	pstat->is_p2p_device = false;
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
-		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + ie_offset , pkt_len - WLAN_HDR_A3_LEN - ie_offset , NULL, &p2pielen);
+		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, pkt_len - WLAN_HDR_A3_LEN - ie_offset, NULL, &p2pielen);
 		if (p2pie) {
 			pstat->is_p2p_device = true;
 			p2p_status_code = (u8)process_assoc_req_p2p_ie(pwdinfo, pframe, pkt_len, pstat);
@@ -1593,7 +1593,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		 *	Added the following code to avoid this case.
 		 */
 		if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
-		    (pmlmeinfo->state & WIFI_FW_ASSOC_STATE )) {
+		    (pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
 			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
 				ignore_received_deauth = 1;
 			} else if (WLAN_REASON_PREV_AUTH_NOT_VALID == reason) {
@@ -2118,7 +2118,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	p2pielen += 2;
 
 	/*	Value: */
-	memcpy(p2pie + p2pielen, pwdinfo->device_name , pwdinfo->device_name_len);
+	memcpy(p2pie + p2pielen, pwdinfo->device_name, pwdinfo->device_name_len);
 	p2pielen += pwdinfo->device_name_len;
 
 	/*	Operating Channel */
@@ -2487,7 +2487,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	p2pielen += 2;
 
 	/*	Value: */
-	memcpy(p2pie + p2pielen, pwdinfo->device_name , pwdinfo->device_name_len);
+	memcpy(p2pie + p2pielen, pwdinfo->device_name, pwdinfo->device_name_len);
 	p2pielen += pwdinfo->device_name_len;
 
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
@@ -2501,7 +2501,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 
 		/*	Value: */
 		/*	p2P Device Address */
-		memcpy(p2pie + p2pielen , pwdinfo->device_addr, ETH_ALEN);
+		memcpy(p2pie + p2pielen, pwdinfo->device_addr, ETH_ALEN);
 		p2pielen += ETH_ALEN;
 
 		/*	SSID */
@@ -2667,7 +2667,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 
 		/*	Value: */
 		/*	p2P Device Address */
-		memcpy(p2pie + p2pielen , pwdinfo->device_addr, ETH_ALEN);
+		memcpy(p2pie + p2pielen, pwdinfo->device_addr, ETH_ALEN);
 		p2pielen += ETH_ALEN;
 
 		/*	SSID */
@@ -3418,7 +3418,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	wpsielen += 2;
 
 	/*	Value: */
-	memcpy(wpsie + wpsielen, "123456" , ETH_ALEN);
+	memcpy(wpsie + wpsielen, "123456", ETH_ALEN);
 	wpsielen += ETH_ALEN;
 
 	/*	Primary Device Type */
@@ -4042,7 +4042,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 							/*	The peer device address should be the destination address for the provisioning discovery request. */
 							/*	Then, this Wi-Fi device should use the iwpriv command to get the peer interface address. */
 							/*	The peer interface address should be the address for WPS mac address */
-							memcpy(pwdinfo->p2p_peer_device_addr, group_id.go_device_addr , ETH_ALEN);
+							memcpy(pwdinfo->p2p_peer_device_addr, group_id.go_device_addr, ETH_ALEN);
 							rtw_p2p_set_role(pwdinfo, P2P_ROLE_CLIENT);
 							rtw_p2p_set_state(pwdinfo, P2P_STATE_RECV_INVITE_REQ_JOIN);
 							status_code = P2P_STATUS_SUCCESS;
@@ -4880,10 +4880,10 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	get_rate_set(padapter, bssrate, &bssrate_len);
 
 	if (bssrate_len > 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_ , 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_ , (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_ , bssrate_len , bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
 	}
 
 	/* add wps_ie for wps2.0 */
@@ -5144,13 +5144,13 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	/* capability */
 	val = *(unsigned short *)rtw_get_capability_from_ie(ie);
 
-	pframe = rtw_set_fixed_ie(pframe, _CAPABILITY_ , (unsigned char *)&val, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _CAPABILITY_, (unsigned char *)&val, &(pattrib->pktlen));
 
 	lestatus = cpu_to_le16(status);
-	pframe = rtw_set_fixed_ie(pframe , _STATUS_CODE_ , (unsigned char *)&lestatus, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _STATUS_CODE_, (unsigned char *)&lestatus, &(pattrib->pktlen));
 
 	leval = cpu_to_le16(pstat->aid | BIT(14) | BIT(15));
-	pframe = rtw_set_fixed_ie(pframe, _ASOC_ID_ , (unsigned char *)&leval, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _ASOC_ID_, (unsigned char *)&leval, &(pattrib->pktlen));
 
 	if (pstat->bssratelen <= 8) {
 		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, pstat->bssratelen, pstat->bssrateset, &(pattrib->pktlen));
@@ -5199,7 +5199,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
-		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6 , REALTEK_96B_IE, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
 
 	/* add WPS IE ie for wps 2.0 */
 	if (pmlmepriv->wps_assoc_resp_ie && pmlmepriv->wps_assoc_resp_ie_len > 0) {
@@ -5283,7 +5283,7 @@ void issue_assocreq(struct adapter *padapter)
 	/* listen interval */
 	/* todo: listen interval for power saving */
 	le_tmp = cpu_to_le16(3);
-	memcpy(pframe , (unsigned char *)&le_tmp, 2);
+	memcpy(pframe, (unsigned char *)&le_tmp, 2);
 	pframe += 2;
 	pattrib->pktlen += 2;
 
@@ -5335,10 +5335,10 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	if (bssrate_len > 8) {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_ , 8, bssrate, &(pattrib->pktlen));
-		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_ , (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, 8, bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (bssrate_len - 8), (bssrate + 8), &(pattrib->pktlen));
 	} else {
-		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_ , bssrate_len , bssrate, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, bssrate_len, bssrate, &(pattrib->pktlen));
 	}
 
 	/* RSN */
@@ -5380,7 +5380,7 @@ void issue_assocreq(struct adapter *padapter)
 				memcpy(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_rate_2R, 16);
 				break;
 			}
-			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len , (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+			pframe = rtw_set_ie(pframe, _HT_CAPABILITY_IE_, ie_len, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
 		}
 	}
 
@@ -5410,7 +5410,7 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
-		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6 , REALTEK_96B_IE, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &(pattrib->pktlen));
 
 #ifdef CONFIG_88EU_P2P
 
@@ -5849,7 +5849,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	le_tmp = cpu_to_le16(reason);
-	pframe = rtw_set_fixed_ie(pframe, _RSON_CODE_ , (unsigned char *)&le_tmp, &(pattrib->pktlen));
+	pframe = rtw_set_fixed_ie(pframe, _RSON_CODE_, (unsigned char *)&le_tmp, &(pattrib->pktlen));
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index c300af4eee8d..1b4e9bbc394b 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -488,7 +488,7 @@ void SetDataRate(struct adapter *pAdapter)
 	Hal_SetDataRate(pAdapter);
 }
 
-void MP_PHY_SetRFPathSwitch(struct adapter *pAdapter , bool bMain)
+void MP_PHY_SetRFPathSwitch(struct adapter *pAdapter, bool bMain)
 {
 	PHY_SetRFPathSwitch(pAdapter, bMain);
 }
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index f94fc7ba9a01..30823bfdd1b5 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -790,9 +790,9 @@ u32 process_probe_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 
 	ssid_len &= 0xff;	/*	Just last 1 byte is valid for ssid len of the probe request */
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_DEVICE) || rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
-		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_ , len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_ , NULL, &p2pielen);
+		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_, NULL, &p2pielen);
 		if (p2pie) {
-			if ((p != NULL) && !memcmp((void *)(p+2), (void *)pwdinfo->p2p_wildcard_ssid , 7)) {
+			if ((p != NULL) && !memcmp((void *)(p+2), (void *)pwdinfo->p2p_wildcard_ssid, 7)) {
 				/* todo: */
 				/* Check Requested Device Type attributes in WSC IE. */
 				/* Check Device ID attribute in P2P IE */
@@ -835,7 +835,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 	ies = pframe + WLAN_HDR_A3_LEN + ie_offset;
 	ies_len = len - WLAN_HDR_A3_LEN - ie_offset;
 
-	p2p_ie = rtw_get_p2p_ie(ies , ies_len , NULL, &p2p_ielen);
+	p2p_ie = rtw_get_p2p_ie(ies, ies_len, NULL, &p2p_ielen);
 
 	if (!p2p_ie) {
 		DBG_88E("[%s] P2P IE not Found!!\n", __func__);
@@ -863,7 +863,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 				u8 num_of_secdev_type;
 				u16 dev_name_len;
 
-				rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_DEVICE_INFO , pattr_content, (uint *)&attr_contentlen);
+				rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_DEVICE_INFO, pattr_content, (uint *)&attr_contentlen);
 
 				memcpy(psta->dev_addr,	pattr_content, ETH_ALEN);/* P2P Device Address */
 
@@ -1129,7 +1129,7 @@ u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo, u8 *pframe,
 
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_ING);
 
-			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT , &attr_content, &attr_contentlen)) {
+			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
 			DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 			pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
@@ -1269,7 +1269,7 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 			/*	Try to get the peer's intent and tie breaker value. */
 			attr_content = 0x00;
 			attr_contentlen = 0;
-			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT , &attr_content, &attr_contentlen)) {
+			if (rtw_get_p2p_attr_content(p2p_ie, p2p_ielen, P2P_ATTR_GO_INTENT, &attr_content, &attr_contentlen)) {
 				DBG_88E("[%s] GO Intent = %d, tie = %d\n", __func__, attr_content >> 1, attr_content & 0x01);
 				pwdinfo->peer_intent = attr_content;	/*	include both intent and tie breaker values. */
 
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index dc72b78877b0..feaf39fddf7c 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -174,7 +174,7 @@ void rtw_mfree_all_stainfo(struct sta_priv *pstapriv)
 	plist = phead->next;
 
 	while (phead != plist) {
-		psta = container_of(plist, struct sta_info , list);
+		psta = container_of(plist, struct sta_info, list);
 		plist = plist->next;
 	}
 
@@ -218,7 +218,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 
 			while (phead != plist) {
 				int i;
-				psta = container_of(plist, struct sta_info , hash_list);
+				psta = container_of(plist, struct sta_info, hash_list);
 				plist = plist->next;
 
 				for (i = 0; i < 16; i++) {
@@ -289,7 +289,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 
 		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
 			 ("alloc number_%d stainfo  with hwaddr = %pM\n",
-			 pstapriv->asoc_sta_count , hwaddr));
+			 pstapriv->asoc_sta_count, hwaddr));
 
 		init_addba_retry_timer(pstapriv->padapter, psta);
 
@@ -324,7 +324,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 }
 
 /*  using pstapriv->sta_hash_lock to protect */
-u32	rtw_free_stainfo(struct adapter *padapter , struct sta_info *psta)
+u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 {
 	int i;
 	struct __queue *pfree_sta_queue;
@@ -364,7 +364,7 @@ u32	rtw_free_stainfo(struct adapter *padapter , struct sta_info *psta)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	list_del_init(&psta->hash_list);
-	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("\n free number_%d stainfo  with hwaddr=0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", pstapriv->asoc_sta_count , psta->hwaddr[0], psta->hwaddr[1], psta->hwaddr[2], psta->hwaddr[3], psta->hwaddr[4], psta->hwaddr[5]));
+	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("\n free number_%d stainfo  with hwaddr=0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", pstapriv->asoc_sta_count, psta->hwaddr[0], psta->hwaddr[1], psta->hwaddr[2], psta->hwaddr[3], psta->hwaddr[4], psta->hwaddr[5]));
 	pstapriv->asoc_sta_count--;
 
 	/*  re-init sta_info; 20061114 */
@@ -468,12 +468,12 @@ void rtw_free_all_stainfo(struct adapter *padapter)
 		plist = phead->next;
 
 		while (phead != plist) {
-			psta = container_of(plist, struct sta_info , hash_list);
+			psta = container_of(plist, struct sta_info, hash_list);
 
 			plist = plist->next;
 
 			if (pbcmc_stainfo != psta)
-				rtw_free_stainfo(padapter , psta);
+				rtw_free_stainfo(padapter, psta);
 		}
 	}
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 7ecffadcb61f..5a45df5531ef 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -650,7 +650,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	if (pattrib->psta)
 		stainfo = pattrib->psta;
 	else
-		stainfo = rtw_get_stainfo(&padapter->stapriv , &pattrib->ra[0]);
+		stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
 	hw_hdr_offset = TXDESC_SIZE + (pxmitframe->pkt_offset * PACKET_OFFSET_SZ);;
 
@@ -778,7 +778,7 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	return _SUCCESS;
 }
 
-s32 rtw_make_wlanhdr (struct adapter *padapter , u8 *hdr, struct pkt_attrib *pattrib)
+s32 rtw_make_wlanhdr (struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattrib)
 {
 	u16 *qc;
 
@@ -1826,7 +1826,7 @@ static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib
 	u8 qsel;
 
 	qsel = pattrib->priority;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority=%d , qsel = %d\n", pattrib->priority , qsel));
+	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority=%d , qsel = %d\n", pattrib->priority, qsel));
 
 	pattrib->qsel = qsel;
 }
diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 2baea6141fe2..436cf866012a 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -86,7 +86,7 @@ static u8 DROPING_NECESSARY[RATESIZE] = {
 
 static u8 PendingForRateUpFail[5] = {2, 10, 24, 40, 60};
 static u16 DynamicTxRPTTiming[6] = {
-	0x186a, 0x30d4, 0x493e, 0x61a8, 0x7a12 , 0x927c}; /*  200ms-1200ms */
+	0x186a, 0x30d4, 0x493e, 0x61a8, 0x7a12, 0x927c}; /*  200ms-1200ms */
 
 /*  End Rate adaptive parameters */
 
@@ -712,7 +712,7 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 					     pRAInfo->RTY[0], pRAInfo->RTY[1],
 					     pRAInfo->RTY[2], pRAInfo->RTY[3],
 					     pRAInfo->RTY[4], pRAInfo->DROP,
-					     macid_entry0 , macid_entry1));
+					     macid_entry0, macid_entry1));
 				if (pRAInfo->PTActive) {
 					if (pRAInfo->RAstage < 5)
 						odm_RateDecision_8188E(dm_odm, pRAInfo);
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index c31f01c0fdd2..e1059c5dd711 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -39,7 +39,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
 
-		RT_TRACE(_module_hal_init_c_ , _drv_info_,
+		RT_TRACE(_module_hal_init_c_, _drv_info_,
 			 ("HalPwrSeqCmdParsing: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
 			 GET_PWR_CFG_OFFSET(pwrcfgcmd),
 			 GET_PWR_CFG_CUT_MASK(pwrcfgcmd),
@@ -56,10 +56,10 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 		    (GET_PWR_CFG_INTF_MASK(pwrcfgcmd) & ifacetype)) {
 			switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
 			case PWR_CMD_READ:
-				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_READ\n"));
+				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_READ\n"));
 				break;
 			case PWR_CMD_WRITE:
-				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n"));
+				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n"));
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 
 				/*  Read the value from system register */
@@ -72,7 +72,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				rtw_write8(padapter, offset, value);
 				break;
 			case PWR_CMD_POLLING:
-				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n"));
+				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n"));
 
 				poll_bit = false;
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
@@ -92,7 +92,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				} while (!poll_bit);
 				break;
 			case PWR_CMD_DELAY:
-				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n"));
+				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n"));
 				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
 					rtw_udelay_os(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 				else
@@ -100,11 +100,11 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				break;
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
-				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_END\n"));
+				RT_TRACE(_module_hal_init_c_, _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_END\n"));
 				return true;
 				break;
 			default:
-				RT_TRACE(_module_hal_init_c_ , _drv_err_, ("HalPwrSeqCmdParsing: Unknown CMD!!\n"));
+				RT_TRACE(_module_hal_init_c_, _drv_err_, ("HalPwrSeqCmdParsing: Unknown CMD!!\n"));
 				break;
 			}
 		}
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index ca50c3c85578..66a2f3d6d9e7 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -340,7 +340,7 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 	*(buf+1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
 
 	RT_PRINT_DATA(_module_hal_init_c_, _drv_info_, "c2h_evt_read(): ",
-		      &c2h_evt , sizeof(c2h_evt));
+		      &c2h_evt, sizeof(c2h_evt));
 
 	/* Read the content */
 	for (i = 0; i < c2h_evt->plen; i++)
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index c6c184d95fee..49e4c8bfc6ef 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1153,8 +1153,8 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 			/*  <tynli_note> 8723 RSSI report will be wrong. Set 0x874[5]=1 when enter BB power saving mode. */
 			/*  Suggested by SD3 Yu-Nan. 2011.01.20. */
 			if (pDM_Odm->SupportICType == ODM_RTL8723A)
-				ODM_SetBBReg(pDM_Odm, 0x874  , BIT5, 0x1); /* Reg874[5]=1b'1 */
-			ODM_SetBBReg(pDM_Odm, 0x874  , 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
+				ODM_SetBBReg(pDM_Odm, 0x874, BIT5, 0x1); /* Reg874[5]=1b'1 */
+			ODM_SetBBReg(pDM_Odm, 0x874, 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
 			ODM_SetBBReg(pDM_Odm, 0xc70, BIT3, 0); /* RegC70[3]=1'b0 */
 			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, 0x63); /* Reg85C[31:24]=0x63 */
 			ODM_SetBBReg(pDM_Odm, 0x874, 0xC000, 0x2); /* Reg874[15:14]=2'b10 */
@@ -1162,7 +1162,7 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x0); /* Reg818[28]=1'b0 */
 			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x1); /* Reg818[28]=1'b1 */
 		} else {
-			ODM_SetBBReg(pDM_Odm, 0x874  , 0x1CC000, pDM_PSTable->Reg874);
+			ODM_SetBBReg(pDM_Odm, 0x874, 0x1CC000, pDM_PSTable->Reg874);
 			ODM_SetBBReg(pDM_Odm, 0xc70, BIT3, pDM_PSTable->RegC70);
 			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->Reg85C);
 			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->RegA74);
@@ -1334,7 +1334,7 @@ void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm)
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pstat)) {
-			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false , &pstat->rssi_level)) {
+			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level)) {
 				ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
 					     ("RSSI:%d, RSSI_LEVEL:%d\n",
 					     pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level));
@@ -1554,7 +1554,7 @@ void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
 		pdmpriv->EntryMinUndecoratedSmoothedPWDB = 0;
 
 	FindMinimumRSSI(Adapter);
-	ODM_CmnInfoUpdate(&pHalData->odmpriv , ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
+	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
 }
 
 void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 27bc1db07f55..fa6c092e714d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -431,7 +431,7 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 		if (blockCount_p2) {
 				RT_TRACE(_module_hal_init_c_, _drv_notice_,
 					 ("_BlockWrite: [P2] buffSize_p2(%d) blockSize_p2(%d) blockCount_p2(%d) remainSize_p2(%d)\n",
-					 (buffSize-offset), blockSize_p2 , blockCount_p2, remainSize_p2));
+					 (buffSize-offset), blockSize_p2, blockCount_p2, remainSize_p2));
 		}
 
 		for (i = 0; i < blockCount_p2; i++) {
@@ -702,7 +702,7 @@ static void rtl8188e_free_hal_data(struct adapter *padapter)
 /*  */
 enum{
 		VOLTAGE_V25						= 0x03,
-		LDOE25_SHIFT						= 28 ,
+		LDOE25_SHIFT						= 28,
 	};
 
 static bool
@@ -1112,7 +1112,7 @@ static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr,
 		efuse_OneByteWrite(pAdapter, start_addr++, data[2], bPseudoTest);
 		efuse_OneByteWrite(pAdapter, start_addr++, data[3], bPseudoTest);
 
-		efuse_OneByteRead(pAdapter, tmpaddr    , &tmpdata[2], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[2], bPseudoTest);
 		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[3], bPseudoTest);
 		if ((data[2] != tmpdata[2]) || (data[3] != tmpdata[3]))
 			badworden &= (~BIT1);
@@ -2152,7 +2152,7 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT1) ? true : false;
 
 		DBG_88E("%s...bHWPwrPindetect(%x)-bHWPowerdown(%x) , bSupportRemoteWakeup(%x)\n", __func__,
-		padapter->pwrctrlpriv.bHWPwrPindetect, padapter->pwrctrlpriv.bHWPowerdown , padapter->pwrctrlpriv.bSupportRemoteWakeup);
+		padapter->pwrctrlpriv.bHWPwrPindetect, padapter->pwrctrlpriv.bHWPowerdown, padapter->pwrctrlpriv.bSupportRemoteWakeup);
 
 		DBG_88E("### PS params =>  power_mgnt(%x), usbss_enable(%x) ###\n", padapter->registrypriv.power_mgnt, padapter->registrypriv.usbss_enable);
 	}
@@ -2182,8 +2182,8 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 			}
 			if (bIn24G) {
 				DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
-				DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch , pHalData->Index24G_CCK_Base[rfPath][ch]);
-				DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch , pHalData->Index24G_BW40_Base[rfPath][ch]);
+				DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_CCK_Base[rfPath][ch]);
+				DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch, pHalData->Index24G_BW40_Base[rfPath][ch]);
 			}
 		}
 		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
index 626741087391..510906cc6007 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_mp.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -545,7 +545,7 @@ s32 Hal_SetThermalMeter(struct adapter *pAdapter, u8 target_ther)
 
 void Hal_TriggerRFThermalMeter(struct adapter *pAdapter)
 {
-	_write_rfreg(pAdapter, RF_PATH_A , RF_T_METER_88E , BIT17 | BIT16 , 0x03);
+	_write_rfreg(pAdapter, RF_PATH_A, RF_T_METER_88E, BIT17 | BIT16, 0x03);
 }
 
 u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d50a887ad7ea..c90a7574b1cf 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1886,7 +1886,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		}
 		break;
 	case HW_VAR_H2C_MEDIA_STATUS_RPT:
-		rtl8188e_set_FwMediaStatus_cmd(Adapter , (*(__le16 *)val));
+		rtl8188e_set_FwMediaStatus_cmd(Adapter, (*(__le16 *)val));
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-- 
2.32.0

