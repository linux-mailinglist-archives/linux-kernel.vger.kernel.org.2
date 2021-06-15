Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86703A72E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhFOATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhFOATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8788C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g19so7531336qkk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZ0xbHVEtqSW+0CGSTg4F5a+cRYZLOCiS0c7IsuJhD4=;
        b=Ku/NL2khnLbfHiRe9+q58C1rgeBug4Oe2LXrNI/M04bsMrABPspznKNlNaybQm3naI
         wPRV9Iu4tm39oeBwNkiGkv07G4JO4UQzTZDzzAs6x+d7djAulXx9Fqbz+bO+3txl/u/1
         H6uazcV0uPMxriJHWCgbp2+FapIapUnbAi2ZOBFEJIk95/xB02Z4uqtqLr7qb5dYyM3y
         KXtZqb+D20GSKfIHvMimIQeyNli20xIbcyi4k/sDkLA1iJTLBDvEs9W46WYdoq0AbGLX
         0wkim0jXWW+r9l/4flPOlxRghdNFGXYxC/ecHrGLnASHR31thy5kMS8dVP27bf7WPUS5
         zNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZ0xbHVEtqSW+0CGSTg4F5a+cRYZLOCiS0c7IsuJhD4=;
        b=oerRKB+ZQkYPBQ2VLIC0e6wPmeNgdVWNxUTTyMf75Il7si7HZlwqy/jJQ9DFeLP5ra
         E5yxC1v5rRjy7zJ0HI0Yqixff8ii2FrU75NDqaaG/4bJLWhmSBLeMvOD7tonp2wxRVsW
         Or11Vk91ZW437ux41ILJDpO2WxoZ/29aacApKkqRUJiCvOhlc2YkJSEPJ1OieXd1Hb74
         Wr4xwZ/bP7jSwRMqUqjSWy0Yog3/JBBj3LvqiwrSZNBIPn4HZmmdGMqvcdPTjCsIVzYm
         sXLgX2hh2Wr6Ipc01Dp8mNqoTpQHZbEEV2qEdxmUyHXuwNR1Jup+JM/uhq+6/qRTquVo
         5KBg==
X-Gm-Message-State: AOAM531n8r90huEqqK4GalIChbcFfCpK+ytfNjirr79TwZE0m4sVQJDy
        XQA148hJtsPi2OegfjyAUqBR8WSb28jAOq6C
X-Google-Smtp-Source: ABdhPJyebbWPKT85rqLPyUO/cVykZaAQb9oYJzcrJXBm2E8V0U07DLppm8xM6Zy6RWL1V65f70MTHw==
X-Received: by 2002:a05:620a:9c3:: with SMTP id y3mr2519652qky.462.1623716227083;
        Mon, 14 Jun 2021 17:17:07 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:17:06 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 25/28] staging: rtl8188eu: remove converted netdev_dbg calls from core/rtw_recv.c
Date:   Tue, 15 Jun 2021 01:15:04 +0100
Message-Id: <20210615001507.1171-26-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all previously converted netdev_dbg calls from core/rtw_recv.c, as
these were originally DBG_88E macro calls, and therefore of dubious
necessity to begin with.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 66 ++++-------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 4c27e1cf003d..fa3ee18a31a1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -189,7 +189,6 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 
 	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
 		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
-		netdev_dbg(adapter->pnetdev, "dequeue uc_swdec_pending_queue\n");
 		cnt++;
 	}
 
@@ -229,7 +228,6 @@ static int recvframe_chkmic(struct adapter *adapter,
 					res = _FAIL;
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
 						 ("\n %s: didn't install group key!!!!!!!!!!\n", __func__));
-					netdev_dbg(adapter->pnetdev, "didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
@@ -318,14 +316,8 @@ static int recvframe_chkmic(struct adapter *adapter,
 				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
-					netdev_dbg(adapter->pnetdev,
-						   "mic error :prxattrib->bdecrypted=%d\n",
-						   prxattrib->bdecrypted);
 				} else {
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
-					netdev_dbg(adapter->pnetdev,
-						   "mic error :prxattrib->bdecrypted=%d\n",
-						   prxattrib->bdecrypted);
 				}
 				res = _FAIL;
 			} else {
@@ -365,9 +357,6 @@ static struct recv_frame *decryptor(struct adapter *padapter,
 		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
-			netdev_dbg(padapter->pnetdev,
-				   "prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
-
 			switch (prxattrib->encrypt) {
 			case _WEP40_:
 			case _WEP104_:
@@ -745,12 +734,8 @@ static int ap2sta_data_frame(struct adapter *adapter,
 				 (" %s:  compare BSSID fail ; BSSID=%pM\n", __func__, (pattrib->bssid)));
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid=%pM\n", (mybssid)));
 
-			if (!mcast) {
-				netdev_dbg(adapter->pnetdev,
-					   "issue_deauth to the nonassociated ap=%pM for the reason(7)\n",
-					   (pattrib->bssid));
+			if (!mcast)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 
 			ret = _FAIL;
 			goto exit;
@@ -783,13 +768,8 @@ static int ap2sta_data_frame(struct adapter *adapter,
 	} else {
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !mcast) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-			if (!*psta) {
-				netdev_dbg(adapter->pnetdev,
-					   "issue_deauth to the ap =%pM for the reason(7)\n",
-					   (pattrib->bssid));
-
+			if (!*psta)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
-			}
 		}
 
 		ret = _FAIL;
@@ -821,8 +801,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
-			netdev_dbg(adapter->pnetdev,
-				   "issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
@@ -848,8 +826,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 			ret = RTW_RX_HANDLED;
 			goto exit;
 		}
-		netdev_dbg(adapter->pnetdev,
-			   "issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 		issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 		ret = RTW_RX_HANDLED;
 		goto exit;
@@ -914,7 +890,6 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			return _FAIL;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			netdev_dbg(padapter->pnetdev, "alive check-rx ps-poll\n");
 			psta->expire_to = pstapriv->expire_to;
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
@@ -958,18 +933,11 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 				}
 			} else {
 				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
-					if (psta->sleepq_len == 0) {
-						netdev_dbg(padapter->pnetdev,
-							   "no buffered packets to xmit\n");
-
+					if (psta->sleepq_len == 0)
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
 						issue_nulldata(padapter, psta->hwaddr, 0, 0, 0);
-					} else {
-						netdev_dbg(padapter->pnetdev,
-							   "error!psta->sleepq_len=%d\n",
-							   psta->sleepq_len);
+					else
 						psta->sleepq_len = 0;
-					}
 
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
@@ -1518,12 +1486,8 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
-		if (a_len < (ETH_HLEN + nSubframe_Length)) {
-			netdev_dbg(padapter->pnetdev,
-				   "nRemain_Length is %d and nSubframe_Length is : %d\n",
-				   a_len, nSubframe_Length);
+		if (a_len < (ETH_HLEN + nSubframe_Length))
 			goto exit;
-		}
 
 		/* move the data point to data content */
 		pdata += ETH_HLEN;
@@ -1531,23 +1495,16 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 		/* Allocate new skb for releasing to upper layer */
 		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
-		if (!sub_skb) {
-			netdev_dbg(padapter->pnetdev,
-				   "dev_alloc_skb() Fail!!! , nr_subframes=%d\n",
-				   nr_subframes);
+		if (!sub_skb)
 			break;
-		}
 
 		skb_reserve(sub_skb, 12);
 		skb_put_data(sub_skb, pdata, nSubframe_Length);
 
 		subframes[nr_subframes++] = sub_skb;
 
-		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-			netdev_dbg(padapter->pnetdev,
-				   "ParseSubframe(): Too many Subframes! Packets dropped!\n");
+		if (nr_subframes >= MAX_SUBFRAME_COUNT)
 			break;
-		}
 
 		pdata += nSubframe_Length;
 		a_len -= nSubframe_Length;
@@ -1952,11 +1909,8 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 	if (check_fwstate(mlmepriv, WIFI_STATION_STATE) && psecuritypriv->busetkipkey) {
 		struct recv_frame *pending_frame;
 
-		while ((pending_frame = rtw_alloc_recvframe(&padapter->recvpriv.uc_swdec_pending_queue))) {
-			if (recv_func_posthandle(padapter, pending_frame) == _SUCCESS)
-				netdev_dbg(padapter->pnetdev,
-					   "dequeue uc_swdec_pending_queue\n");
-		}
+		while ((pending_frame = rtw_alloc_recvframe(&padapter->recvpriv.uc_swdec_pending_queue)))
+			recv_func_posthandle(padapter, pending_frame);
 	}
 
 	ret = recv_func_prehandle(padapter, rframe);
@@ -1970,8 +1924,6 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		    !is_wep_enc(psecuritypriv->dot11PrivacyAlgrthm) &&
 		    !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
-			netdev_dbg(padapter->pnetdev,
-				   "no key, enqueue uc_swdec_pending_queue\n");
 			goto exit;
 		}
 
-- 
2.30.2

