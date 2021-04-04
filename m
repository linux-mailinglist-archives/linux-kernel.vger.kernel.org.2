Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D7353853
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhDDOKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhDDOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D5C0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:09:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f6so2687586wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbmrTz9bp/tbkKwYokvm6zp4pqrZ70s+aNX0na6Y3P4=;
        b=G+dBNhk4Yryn1ot7vJ6+7+1uko2stZY66Rxcz2+tKWFRVTPutkkMlq1/Lw49GCT0i7
         YEqsAGm9gUtgyr1GbkjMxnPzvbUyAhrX5jTcUBmAibtdoYlbtIe5lrx4qTNRK+k8TjcT
         s8K6scHyGYlicqIg+HP84ndFdF0dmUxAwYRBW4uIEdq/jzW/kpNnBmCIAwSAU7JeuOwm
         XV7HoTDDNz/A0dyN8Q0mwISquf25mIPokbBBsRzleSX4JSKRDelf6T/GIR4lPGHMc6Fo
         3VI9m+6LPUU0WyKo9B2u/GOHdNb8BP680E1L9FwXdnG2Q698UnR3JBdamvHRWNq1tIC5
         9nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbmrTz9bp/tbkKwYokvm6zp4pqrZ70s+aNX0na6Y3P4=;
        b=GnB0USBA6H5CsbTZyhgh4UQ2PhKDaSEvW11XISo9W/m9Tb562bx1kIFNUQRmVHt2HY
         WGoK7PFhQRNRqS49a7smFWOzXMfN43SaBoAltesZAOMw22ics7bTLu4NZrS94YYOSqEh
         9awjf5/eci3MSE/x7yzxcJ4vN8cbLeJstaJ5n4l5KGVGQYBld9fleIee+93ftvbW9MPs
         QOYEELRBON161BAEND435AeKwRhysbalgSwMdR7PTYl9K2FIMXTHncTv5aCf/DV1bmsq
         jmvTvxxaj4rvBEAqQmIbkt2i5Cabke7Vssev1TRk22LYD6k1GrwXjIq33QKYLYfrdb4L
         nJ2Q==
X-Gm-Message-State: AOAM530w2/nfyGjCNKvhxyyu4RoEapU7Zi3RLklBw9ykDVxDozffW6Wf
        CmHFVrg8jUSB03KlQwXKIoA=
X-Google-Smtp-Source: ABdhPJwCNYxOx7u0p9p9BEFPX93iOZMJRGXuw/EQl5nw3AhfxTb3BZQYLdZnn7sirD0PKB5sewXWBQ==
X-Received: by 2002:adf:9043:: with SMTP id h61mr24793692wrh.216.1617545392548;
        Sun, 04 Apr 2021 07:09:52 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id q19sm19843719wmc.44.2021.04.04.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:09:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 01/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
Date:   Sun,  4 Apr 2021 16:09:17 +0200
Message-Id: <c7e5ba68189e4e7ca923741d31908dda7850e45e.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_xmit.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 82 ++---------------------
 1 file changed, 7 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 3fc4ea02bf15..beee87db85a5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -69,7 +69,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -105,7 +104,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -155,7 +153,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->xframe_ext_alloc_addr) {
 		pxmitpriv->xframe_ext = NULL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xframe_ext fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -188,7 +185,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(NR_XMIT_EXTBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -481,12 +477,9 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 	pattrib->mac_id = psta->mac_id;
 
 	if (psta->ieee8021x_blocked == true) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\n psta->ieee8021x_blocked == true\n"));
-
 		pattrib->encrypt = 0;
 
 		if ((pattrib->ether_type != 0x888e) && (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\npsta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != 0x888e\n", pattrib->ether_type));
 			#ifdef DBG_TX_DROP_FRAME
 			DBG_871X("DBG_TX_DROP_FRAME %s psta->ieee8021x_blocked == true,  pattrib->ether_type(%04x) != 0x888e\n", __func__, pattrib->ether_type);
 			#endif
@@ -568,20 +561,11 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 	if (pattrib->encrypt > 0)
 		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
 
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-		("update_attrib: encrypt =%d  securitypriv.sw_encrypt =%d\n",
-		pattrib->encrypt, padapter->securitypriv.sw_encrypt));
-
 	if (pattrib->encrypt &&
-		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false))) {
+		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false)))
 		pattrib->bswenc = true;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			("update_attrib: encrypt =%d securitypriv.hw_decrypted =%d bswenc =true\n",
-			pattrib->encrypt, padapter->securitypriv.sw_encrypt));
-	} else {
+	else
 		pattrib->bswenc = false;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("update_attrib: bswenc =false\n"));
-	}
 
 exit:
 
@@ -685,7 +669,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 					((tmp[21] == 67) && (tmp[23] == 68))) {
 					/*  68 : UDP BOOTP client */
 					/*  67 : UDP BOOTP server */
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======================update_attrib: get DHCP Packet\n"));
 					pattrib->dhcp_pkt = 1;
 				}
 			}
@@ -720,7 +703,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 		if (!psta)	{ /*  if we cannot get psta => drop the pkt */
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", MAC_ARG(pattrib->ra)));
 			#ifdef DBG_TX_DROP_FRAME
 			DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
 			#endif
@@ -734,7 +716,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (!psta) {
 		/*  if we cannot get psta => drop the pkt */
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", MAC_ARG(pattrib->ra)));
 		#ifdef DBG_TX_DROP_FRAME
 		DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
 		#endif
@@ -842,11 +823,8 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
 				payload = (u8 *)round_up((SIZE_PTR)(payload), 4);
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("===curfragnum =%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
-					curfragnum, *payload, *(payload+1), *(payload+2), *(payload+3), *(payload+4), *(payload+5), *(payload+6), *(payload+7)));
-
 				payload = payload+pattrib->hdrlen+pattrib->iv_len;
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum =%d pattrib->hdrlen =%d pattrib->iv_len =%d", curfragnum, pattrib->hdrlen, pattrib->iv_len));
+
 				if ((curfragnum+1) == pattrib->nr_frags) {
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
@@ -855,26 +833,13 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
 					payload = payload+length+pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum =%d length =%d pattrib->icv_len =%d", curfragnum, length, pattrib->icv_len));
 				}
 			}
 			rtw_secgetmic(&micdata, &mic[0]);
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: before add mic code!!!\n"));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: pattrib->last_txcmdsz =%d!!!\n", pattrib->last_txcmdsz));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: mic[0]= 0x%.2x , mic[1]= 0x%.2x , mic[2]= 0x%.2x , mic[3]= 0x%.2x\n\
-  mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
-				mic[0], mic[1], mic[2], mic[3], mic[4], mic[5], mic[6], mic[7]));
 			/* add mic code  and add the mic code length in last_txcmdsz */
 
 			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
-
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("\n ========last pkt ========\n"));
-			payload = payload-pattrib->last_txcmdsz+8;
-			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum = curfragnum+8)
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, (" %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
-					*(payload+curfragnum), *(payload+curfragnum+1), *(payload+curfragnum+2), *(payload+curfragnum+3),
-					*(payload+curfragnum+4), *(payload+curfragnum+5), *(payload+curfragnum+6), *(payload+curfragnum+7)));
 			}
 	}
 	return _SUCCESS;
@@ -885,7 +850,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### xmitframe_swencrypt\n"));
 		switch (pattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -900,8 +864,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 				break;
 		}
-	} else {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
 	}
 
 	return _SUCCESS;
@@ -955,7 +917,6 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			if (pattrib->qos_en)
 				qos_option = true;
 		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
 			res = _FAIL;
 			goto exit;
 		}
@@ -1106,7 +1067,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n"));
 		DBG_8192C("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
@@ -1134,10 +1094,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		if (pattrib->iv_len) {
 			memcpy(pframe, pattrib->iv, pattrib->iv_len);
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
-				 ("rtw_xmitframe_coalesce: keyid =%d pattrib->iv[3]=%.2x pframe =%.2x %.2x %.2x %.2x\n",
-				  padapter->securitypriv.dot11PrivacyKeyIndex, pattrib->iv[3], *pframe, *(pframe+1), *(pframe+2), *(pframe+3)));
-
 			pframe += pattrib->iv_len;
 
 			mpdu_len -= pattrib->iv_len;
@@ -1177,8 +1133,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			ClearMFrag(mem_start);
 
 			break;
-		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
 		}
 
 		addr = (SIZE_PTR)(pframe);
@@ -1188,7 +1142,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
 		DBG_8192C("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
@@ -1712,7 +1665,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
 	if (list_empty(&pfree_xmit_queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe:%d\n", pxmitpriv->free_xmitframe_cnt));
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(pfree_xmit_queue);
@@ -1723,7 +1675,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 
 		list_del_init(&pxframe->list);
 		pxmitpriv->free_xmitframe_cnt--;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
 	}
 
 	spin_unlock_bh(&pfree_xmit_queue->lock);
@@ -1741,7 +1692,6 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
 	spin_lock_bh(&queue->lock);
 
 	if (list_empty(&queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext:%d\n", pxmitpriv->free_xframe_ext_cnt));
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(queue);
@@ -1750,7 +1700,6 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
 
 		list_del_init(&pxframe->list);
 		pxmitpriv->free_xframe_ext_cnt--;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext():free_xmitframe_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
 	}
 
 	spin_unlock_bh(&queue->lock);
@@ -1795,10 +1744,8 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	struct adapter *padapter = pxmitpriv->adapter;
 	struct sk_buff *pndis_pkt = NULL;
 
-	if (!pxmitframe) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======rtw_free_xmitframe():pxmitframe == NULL!!!!!!!!!!\n"));
+	if (!pxmitframe)
 		goto exit;
-	}
 
 	if (pxmitframe->pkt) {
 		pndis_pkt = pxmitframe->pkt;
@@ -1822,14 +1769,10 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 
 	list_del_init(&pxmitframe->list);
 	list_add_tail(&pxmitframe->list, get_list_head(queue));
-	if (pxmitframe->ext_tag == 0) {
+	if (pxmitframe->ext_tag == 0)
 		pxmitpriv->free_xmitframe_cnt++;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
-	} else if (pxmitframe->ext_tag == 1) {
+	else if (pxmitframe->ext_tag == 1)
 		pxmitpriv->free_xframe_ext_cnt++;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xframe_ext_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
-	} else {
-	}
 
 	spin_unlock_bh(&queue->lock);
 
@@ -1864,11 +1807,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			 ("rtw_xmitframe_enqueue: drop xmit pkt for classifier fail\n"));
+	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL)
 		return _FAIL;
-	}
 
 	return _SUCCESS;
 }
@@ -1882,21 +1822,18 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	case 2:
 		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*(ac) = 3;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BK\n"));
 		break;
 
 	case 4:
 	case 5:
 		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*(ac) = 1;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VI\n"));
 		break;
 
 	case 6:
 	case 7:
 		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*(ac) = 0;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VO\n"));
 		break;
 
 	case 0:
@@ -1904,7 +1841,6 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	default:
 		ptxservq = &psta->sta_xmitpriv.be_q;
 		*(ac) = 2;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BE\n"));
 	break;
 	}
 
@@ -1933,7 +1869,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	if (!psta) {
 		res = _FAIL;
 		DBG_8192C("rtw_xmit_classifier: psta == NULL\n");
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmit_classifier: psta == NULL\n"));
 		goto exit;
 	}
 
@@ -2053,7 +1988,6 @@ static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib
 	u8 qsel;
 
 	qsel = pattrib->priority;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority =%d , qsel = %d\n", pattrib->priority, qsel));
 
 	pattrib->qsel = qsel;
 }
@@ -2090,14 +2024,12 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	if (!pxmitframe) {
 		drop_cnt++;
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: no more pxmitframe\n", __func__));
 		return -1;
 	}
 
 	res = update_attrib(padapter, *ppkt, &pxmitframe->attrib);
 
 	if (res == _FAIL) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: update attrib fail\n", __func__));
 		#ifdef DBG_TX_DROP_FRAME
 		DBG_871X("DBG_TX_DROP_FRAME %s update attrib fail\n", __func__);
 		#endif
-- 
2.20.1

