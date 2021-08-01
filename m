Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05B3DCD2D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhHATFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhHATE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A36C0613D5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h14so18752289wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=83HC7JvFVW2sV07in/PmMdubKKXvYlyr0pMfQCZB81c=;
        b=WDQFnlnfgGs5XtiqdX8NGdsLTgzMW2UB9G0XfNprMQXG6cVI7ADsjp3XK5h1+yRkex
         zrfkbvVNBjGTcWh1sM9PsE7hfGdk2U3OIgg28+UNdKWXKvPLqbjA/XbQorraH5I6khnJ
         hCC2gpsMmyH7MSsG2E5VLDHwtN6o5u/fvL6fzgKUVUnyBzydc/zgAZltul/uy8j+mCud
         b/FxL8fsLTOAiS3yw6hRzSSilRbJp5vPkxdFRg2wdj3DFQnqgIX5QlU41K5u2sOqi7Mi
         rtdeePG9OoXpIES2P9BH2Bho1jUdH2Z0e7brcR3FTZuEd+dBynzDynEJzkHkwR3mA9Ld
         Q+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=83HC7JvFVW2sV07in/PmMdubKKXvYlyr0pMfQCZB81c=;
        b=BLRb+UbXVdwn9IROQUlL1PH0P3/nDdrgV9eurQbWtKClIr16ZPUePtRXdEf2T2qm3/
         93PEs1Z3Xfmj5Hk5FUWXaQjivoTeLK7ZhnwJnDJRjNjQPg2zcn4eRYAqOW/UFke1eLoP
         Xs4eUFCxNjJfRzeiz8rw8nlWDCjV9fDLteZT3ogW78N45Ua5uhn+RHLYiSaoRm8ZGx38
         jH2VenvKZkpvAfd2/5tZGuIN2YDqHHbn0cVBtFacJQksywpgf3IxA2HS9gIPvkgDxMa9
         pHMF1/JcZK6xUw98t1qjXgrYsR+7kM3RjYgJxMkn0i7sZlbrhU0D5kbeDsPT3V5xwC7P
         VZxg==
X-Gm-Message-State: AOAM53104xTeS8iOWw7F79acz47+PqG/T82Ol639E9zFZDKlvQLTWcjh
        /DDwTrNqYnTeOoVApwCRFNDcsg==
X-Google-Smtp-Source: ABdhPJz85FBTzmumwSAruHV+QOCBcg/tJbgHuQhAdiWAvN60ID7trGSoGFE2DLZUo6C/9ukcTgpIoQ==
X-Received: by 2002:a5d:6904:: with SMTP id t4mr13616906wru.187.1627844689060;
        Sun, 01 Aug 2021 12:04:49 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:48 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 12/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
Date:   Sun,  1 Aug 2021 20:04:34 +0100
Message-Id: <20210801190437.82017-13-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_xmit.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 92 ++-----------------------
 1 file changed, 7 insertions(+), 85 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4a5393184737..9518ff6f457d 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -76,7 +76,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (pxmitpriv->pallocated_frame_buf  == NULL) {
 		pxmitpriv->pxmit_frame_buf = NULL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -113,7 +112,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmitbuf = rtw_zvmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (pxmitpriv->pallocated_xmitbuf  == NULL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -155,7 +153,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
 	if (pxmitpriv->pallocated_xmit_extbuf  == NULL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -482,13 +479,11 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		if (pktfile.pkt_len > 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
 			if (ETH_P_IP == pattrib->ether_type) {/*  IP header */
 				if (((tmp[21] == 68) && (tmp[23] == 67)) ||
-				    ((tmp[21] == 67) && (tmp[23] == 68))) {
+				    ((tmp[21] == 67) && (tmp[23] == 68)))
 					/*  68 : UDP BOOTP client */
 					/*  67 : UDP BOOTP server */
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("====================== update_attrib: get DHCP Packet\n"));
 					/*  Use low rate to send DHCP packet. */
 					pattrib->dhcp_pkt = 1;
-				}
 			}
 		}
 	} else if (0x888e == pattrib->ether_type) {
@@ -510,7 +505,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 		if (psta == NULL) { /*  if we cannot get psta => drrp the pkt */
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra: %pM\n", (pattrib->ra)));
 			res = _FAIL;
 			goto exit;
 		} else if ((check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) && (!(psta->state & _FW_LINKED))) {
@@ -525,7 +519,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		pattrib->psta = psta;
 	} else {
 		/*  if we cannot get psta => drop the pkt */
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", (pattrib->ra)));
 		res = _FAIL;
 		goto exit;
 	}
@@ -551,12 +544,9 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	}
 
 	if (psta->ieee8021x_blocked) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\n psta->ieee8021x_blocked == true\n"));
-
 		pattrib->encrypt = 0;
 
 		if ((pattrib->ether_type != 0x888e) && !check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\npsta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != 0x888e\n", pattrib->ether_type));
 			res = _FAIL;
 			goto exit;
 		}
@@ -592,15 +582,11 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		pattrib->icv_len = 4;
 
 		if (padapter->securitypriv.busetkipkey == _FAIL) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-				 ("\npadapter->securitypriv.busetkipkey(%d) == _FAIL drop packet\n",
-				 padapter->securitypriv.busetkipkey));
 			res = _FAIL;
 			goto exit;
 		}
 		break;
 	case _AES_:
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("pattrib->encrypt=%d (_AES_)\n", pattrib->encrypt));
 		pattrib->iv_len = 8;
 		pattrib->icv_len = 8;
 		break;
@@ -610,20 +596,11 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		break;
 	}
 
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-		 ("update_attrib: encrypt=%d  securitypriv.sw_encrypt=%d\n",
-		  pattrib->encrypt, padapter->securitypriv.sw_encrypt));
-
 	if (pattrib->encrypt &&
-	    (padapter->securitypriv.sw_encrypt || !psecuritypriv->hw_decrypted)) {
+	    (padapter->securitypriv.sw_encrypt || !psecuritypriv->hw_decrypted))
 		pattrib->bswenc = true;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			 ("update_attrib: encrypt=%d securitypriv.hw_decrypted=%d bswenc = true\n",
-			  pattrib->encrypt, padapter->securitypriv.sw_encrypt));
-	} else {
+	else
 		pattrib->bswenc = false;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("update_attrib: bswenc = false\n"));
-	}
 
 	rtw_set_tx_chksum_offload(pkt, pattrib);
 
@@ -700,17 +677,8 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
 				payload = (u8 *)RND4((size_t)(payload));
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-					 ("=== curfragnum=%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
-					 curfragnum, *payload, *(payload+1),
-					 *(payload+2), *(payload+3),
-					 *(payload+4), *(payload+5),
-					 *(payload+6), *(payload+7)));
 
 				payload = payload+pattrib->hdrlen+pattrib->iv_len;
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-					 ("curfragnum=%d pattrib->hdrlen=%d pattrib->iv_len=%d",
-					 curfragnum, pattrib->hdrlen, pattrib->iv_len));
 				if ((curfragnum+1) == pattrib->nr_frags) {
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
@@ -719,32 +687,16 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
 					payload = payload+length+pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum=%d length=%d pattrib->icv_len=%d", curfragnum, length, pattrib->icv_len));
 				}
 			}
 			rtw_secgetmic(&micdata, &(mic[0]));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: before add mic code!!!\n"));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: pattrib->last_txcmdsz=%d!!!\n", pattrib->last_txcmdsz));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: mic[0]=0x%.2x , mic[1]=0x%.2x , mic[2]= 0x%.2x, mic[3]=0x%.2x\n\
-  mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
-				mic[0], mic[1], mic[2], mic[3], mic[4], mic[5], mic[6], mic[7]));
 			/* add mic code  and add the mic code length in last_txcmdsz */
 
 			memcpy(payload, &(mic[0]), 8);
 			pattrib->last_txcmdsz += 8;
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("\n ======== last pkt ========\n"));
 			payload = payload-pattrib->last_txcmdsz+8;
-			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum = curfragnum+8)
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-						 (" %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
-						 *(payload+curfragnum), *(payload+curfragnum+1),
-						 *(payload+curfragnum+2), *(payload+curfragnum+3),
-						 *(payload+curfragnum+4), *(payload+curfragnum+5),
-						 *(payload+curfragnum+6), *(payload+curfragnum+7)));
-			} else {
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: rtw_get_stainfo==NULL!!!\n"));
-			}
+		}
 	}
 
 	return _SUCCESS;
@@ -755,7 +707,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### xmitframe_swencrypt\n"));
 		switch (pattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -770,8 +721,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 			break;
 		}
-	} else {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
 	}
 
 	return _SUCCESS;
@@ -836,7 +785,6 @@ s32 rtw_make_wlanhdr (struct adapter *padapter, u8 *hdr, struct pkt_attrib *patt
 			if (psta->qos_option)
 				qos_option = true;
 		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
 			res = _FAIL;
 			goto exit;
 		}
@@ -1007,7 +955,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n"));
 		DBG_88E("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
@@ -1056,10 +1003,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 			memcpy(pframe, pattrib->iv, pattrib->iv_len);
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
-				 ("rtw_xmitframe_coalesce: keyid=%d pattrib->iv[3]=%.2x pframe=%.2x %.2x %.2x %.2x\n",
-				  padapter->securitypriv.dot11PrivacyKeyIndex, pattrib->iv[3], *pframe, *(pframe+1), *(pframe+2), *(pframe+3)));
-
 			pframe += pattrib->iv_len;
 
 			mpdu_len -= pattrib->iv_len;
@@ -1100,8 +1043,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			ClearMFrag(mem_start);
 
 			break;
-		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
 		}
 
 		addr = (size_t)(pframe);
@@ -1111,7 +1052,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
 		DBG_88E("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
@@ -1365,7 +1305,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
 	if (list_empty(&pfree_xmit_queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe:%d\n", pxmitpriv->free_xmitframe_cnt));
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(pfree_xmit_queue);
@@ -1380,8 +1319,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 	if (pxframe !=  NULL) { /* default value setting */
 		pxmitpriv->free_xmitframe_cnt--;
 
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe():free_xmitframe_cnt=%d\n", pxmitpriv->free_xmitframe_cnt));
-
 		pxframe->buf_addr = NULL;
 		pxframe->pxmitbuf = NULL;
 
@@ -1408,10 +1345,8 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	struct adapter *padapter = pxmitpriv->adapter;
 	struct sk_buff *pndis_pkt = NULL;
 
-	if (pxmitframe == NULL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("====== rtw_free_xmitframe():pxmitframe == NULL!!!!!!!!!!\n"));
+	if (pxmitframe == NULL)
 		goto exit;
-	}
 
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
@@ -1425,7 +1360,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	list_add_tail(&pxmitframe->list, get_list_head(pfree_xmit_queue));
 
 	pxmitpriv->free_xmitframe_cnt++;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xmitframe_cnt=%d\n", pxmitpriv->free_xmitframe_cnt));
 
 	spin_unlock_bh(&pfree_xmit_queue->lock);
 
@@ -1460,12 +1394,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			 ("rtw_xmitframe_enqueue: drop xmit pkt for classifier fail\n"));
-/* 		pxmitframe->pkt = NULL; */
+	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL)
 		return _FAIL;
-	}
 
 	return _SUCCESS;
 }
@@ -1552,27 +1482,23 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	case 2:
 		ptxservq = &(psta->sta_xmitpriv.bk_q);
 		*(ac) = 3;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BK\n"));
 		break;
 	case 4:
 	case 5:
 		ptxservq = &(psta->sta_xmitpriv.vi_q);
 		*(ac) = 1;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VI\n"));
 		break;
 	case 6:
 	case 7:
 		ptxservq = &(psta->sta_xmitpriv.vo_q);
 		*(ac) = 0;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VO\n"));
 		break;
 	case 0:
 	case 3:
 	default:
 		ptxservq = &(psta->sta_xmitpriv.be_q);
 		*(ac) = 2;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BE\n"));
-	break;
+		break;
 	}
 
 	return ptxservq;
@@ -1601,7 +1527,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	if (psta == NULL) {
 		res = _FAIL;
 		DBG_88E("rtw_xmit_classifier: psta == NULL\n");
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmit_classifier: psta == NULL\n"));
 		goto exit;
 	}
 
@@ -1825,7 +1750,6 @@ static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib
 	u8 qsel;
 
 	qsel = pattrib->priority;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority=%d , qsel = %d\n", pattrib->priority, qsel));
 
 	pattrib->qsel = qsel;
 }
@@ -1848,7 +1772,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (pxmitframe == NULL) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit: no more pxmitframe\n"));
 		DBG_88E("DBG_TX_DROP_FRAME %s no more pxmitframe\n", __func__);
 		return -1;
 	}
@@ -1868,7 +1791,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	res = update_attrib(padapter, *ppkt, &pxmitframe->attrib);
 
 	if (res == _FAIL) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit: update attrib fail\n"));
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 		return -1;
 	}
-- 
2.31.1

