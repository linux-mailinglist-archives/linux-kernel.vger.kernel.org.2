Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF63A579E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhFMK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhFMK1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 06:27:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7EFC061766
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:25:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c5so11012666wrq.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnAMBNed5UC+wiGF/TyrLIk6k1+y6qS9317P8SE6zBE=;
        b=OfXh/R9jEmeLqYMgJQj22gzazppT511jjzA2rgTfCEe7/59qs310wHDTH19lHCtp1W
         HIA5eP58PNM0k3XEh6lpyQl2NEUcXPtMehkSRboNy87B8DEVSMmdVlKts36OdDR47brS
         829WGSnORx47bgvUSyt2S726po/wK0bbCPcWtjN4I2KtpQGjeBGp10qCxBkK+U/S6AXp
         /Y3X557mDWnt5s7DAnXdvn+UQztTvD48bwfFul6rkmroL/b7R8bdKQ8Uos3c46IZ/5kr
         xIG9IUqAt5UINTe05LEFJQ5VmkZmZM+TZY4yilYZgGn/fSWlmFpc5+BP3A4+BH/Y/lBc
         Utog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YnAMBNed5UC+wiGF/TyrLIk6k1+y6qS9317P8SE6zBE=;
        b=efwR4XCdhIZUXxe620shnPlepNpLRp+MS+17lzv/i+0dyoKUxxaasXqFJk0UNB6c23
         KpTir6Kc/D8LZ2GR5NLM1WkbflL+3BNYbVAM3WvUMJmsb5iLGi5wef6MZTPpUwdBrCz8
         A1RtNqQ3G48bLBdB/B35sWyz10sIpBVlx/q29vHkF2gNtI7BMQKGuXNnpx51FfL4IWxP
         7nMRU6EjKSFNXsiUyudRIMhjeEVh5eC357wxIWmVb3IlgH/12CSEvqFlU9iEvfPMFbLw
         gdIy0tOsfMb3WxVIoljf6KbnFhcyeUGQg7kw3H7N3jKoGgFXpKH3TbssqOFbLRMzA2It
         PnNw==
X-Gm-Message-State: AOAM532vK39RpS/Ouuil9wZPDIhIwHWPzSxSpldJPFZM5cL9PtujSaB3
        TdlUbTnJO5l8ZkuRD1uBBKmerQ==
X-Google-Smtp-Source: ABdhPJzEDWADNYv7VDvzUfVz/1I5/VhZyEJ58T3KP6umFk0urVRNKAP0BeC0aHDBbQP+5/v0t2q+Sw==
X-Received: by 2002:a5d:6109:: with SMTP id v9mr13505392wrt.0.1623579902816;
        Sun, 13 Jun 2021 03:25:02 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id a15sm16026493wrs.63.2021.06.13.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 03:25:02 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx, insafonov@gmail.com,
        simon.fodin@gmail.com, straube.linux@gmail.com,
        mrinalmni@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: [PATCH v2] staging: rtl8188eu: convert DBG_88E calls in core/rtw_recv.c
Date:   Sun, 13 Jun 2021 11:24:59 +0100
Message-Id: <20210613102459.7532-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all calls to the DBG_88E macro in core/rtw_recv.c into
netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
debug messages can be controlled more precisely by just using debugfs.
It is important to keep these messages still, as they are displayable
via a kernel module parameter when using DBG_88E.

One such converted call is after a failed skb allocation, but as it prints
additional information besides just stating failure, I've left it in
despite the checkpatch warning.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V2:
* Incorporated newlines for format strings, as suggested by Joe Perches.

---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 55 ++++++++++++++++-------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 5a8170d4eab6..4c27e1cf003d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -189,7 +189,7 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 
 	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
 		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
-		DBG_88E("%s: dequeue uc_swdec_pending_queue\n", __func__);
+		netdev_dbg(adapter->pnetdev, "dequeue uc_swdec_pending_queue\n");
 		cnt++;
 	}
 
@@ -229,7 +229,7 @@ static int recvframe_chkmic(struct adapter *adapter,
 					res = _FAIL;
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
 						 ("\n %s: didn't install group key!!!!!!!!!!\n", __func__));
-					DBG_88E("\n %s: didn't install group key!!!!!!!!!!\n", __func__);
+					netdev_dbg(adapter->pnetdev, "didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
@@ -318,10 +318,14 @@ static int recvframe_chkmic(struct adapter *adapter,
 				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
-					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
+					netdev_dbg(adapter->pnetdev,
+						   "mic error :prxattrib->bdecrypted=%d\n",
+						   prxattrib->bdecrypted);
 				} else {
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
-					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
+					netdev_dbg(adapter->pnetdev,
+						   "mic error :prxattrib->bdecrypted=%d\n",
+						   prxattrib->bdecrypted);
 				}
 				res = _FAIL;
 			} else {
@@ -361,7 +365,8 @@ static struct recv_frame *decryptor(struct adapter *padapter,
 		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
-			DBG_88E("prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
+			netdev_dbg(padapter->pnetdev,
+				   "prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
 
 			switch (prxattrib->encrypt) {
 			case _WEP40_:
@@ -741,7 +746,9 @@ static int ap2sta_data_frame(struct adapter *adapter,
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid=%pM\n", (mybssid)));
 
 			if (!mcast) {
-				DBG_88E("issue_deauth to the nonassociated ap=%pM for the reason(7)\n", (pattrib->bssid));
+				netdev_dbg(adapter->pnetdev,
+					   "issue_deauth to the nonassociated ap=%pM for the reason(7)\n",
+					   (pattrib->bssid));
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 			}
 
@@ -777,7 +784,9 @@ static int ap2sta_data_frame(struct adapter *adapter,
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !mcast) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 			if (!*psta) {
-				DBG_88E("issue_deauth to the ap =%pM for the reason(7)\n", (pattrib->bssid));
+				netdev_dbg(adapter->pnetdev,
+					   "issue_deauth to the ap =%pM for the reason(7)\n",
+					   (pattrib->bssid));
 
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 			}
@@ -812,7 +821,8 @@ static int sta2ap_data_frame(struct adapter *adapter,
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
-			DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
+			netdev_dbg(adapter->pnetdev,
+				   "issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
@@ -838,7 +848,8 @@ static int sta2ap_data_frame(struct adapter *adapter,
 			ret = RTW_RX_HANDLED;
 			goto exit;
 		}
-		DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
+		netdev_dbg(adapter->pnetdev,
+			   "issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 		issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 		ret = RTW_RX_HANDLED;
 		goto exit;
@@ -903,7 +914,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			return _FAIL;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			DBG_88E("%s alive check-rx ps-poll\n", __func__);
+			netdev_dbg(padapter->pnetdev, "alive check-rx ps-poll\n");
 			psta->expire_to = pstapriv->expire_to;
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
@@ -948,12 +959,15 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			} else {
 				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
 					if (psta->sleepq_len == 0) {
-						DBG_88E("no buffered packets to xmit\n");
+						netdev_dbg(padapter->pnetdev,
+							   "no buffered packets to xmit\n");
 
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
 						issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
 					} else {
-						DBG_88E("error!psta->sleepq_len=%d\n", psta->sleepq_len);
+						netdev_dbg(padapter->pnetdev,
+							   "error!psta->sleepq_len=%d\n",
+							   psta->sleepq_len);
 						psta->sleepq_len = 0;
 					}
 
@@ -1505,7 +1519,9 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
 		if (a_len < (ETH_HLEN + nSubframe_Length)) {
-			DBG_88E("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
+			netdev_dbg(padapter->pnetdev,
+				   "nRemain_Length is %d and nSubframe_Length is : %d\n",
+				   a_len, nSubframe_Length);
 			goto exit;
 		}
 
@@ -1516,7 +1532,9 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* Allocate new skb for releasing to upper layer */
 		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
 		if (!sub_skb) {
-			DBG_88E("dev_alloc_skb() Fail!!! , nr_subframes=%d\n", nr_subframes);
+			netdev_dbg(padapter->pnetdev,
+				   "dev_alloc_skb() Fail!!! , nr_subframes=%d\n",
+				   nr_subframes);
 			break;
 		}
 
@@ -1526,7 +1544,8 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		subframes[nr_subframes++] = sub_skb;
 
 		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-			DBG_88E("ParseSubframe(): Too many Subframes! Packets dropped!\n");
+			netdev_dbg(padapter->pnetdev,
+				   "ParseSubframe(): Too many Subframes! Packets dropped!\n");
 			break;
 		}
 
@@ -1935,7 +1954,8 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 
 		while ((pending_frame = rtw_alloc_recvframe(&padapter->recvpriv.uc_swdec_pending_queue))) {
 			if (recv_func_posthandle(padapter, pending_frame) == _SUCCESS)
-				DBG_88E("%s: dequeue uc_swdec_pending_queue\n", __func__);
+				netdev_dbg(padapter->pnetdev,
+					   "dequeue uc_swdec_pending_queue\n");
 		}
 	}
 
@@ -1950,7 +1970,8 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		    !is_wep_enc(psecuritypriv->dot11PrivacyAlgrthm) &&
 		    !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
-			DBG_88E("%s: no key, enqueue uc_swdec_pending_queue\n", __func__);
+			netdev_dbg(padapter->pnetdev,
+				   "no key, enqueue uc_swdec_pending_queue\n");
 			goto exit;
 		}
 
-- 
2.30.2

