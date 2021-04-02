Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC16F352936
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhDBKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBKBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:01:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065DC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:01:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b16so4943278eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGe+YMiPs0n4Kx3d8JM92LIt/HuzsVkJDs9Lp/ZDjRU=;
        b=NTRbU412UvtgiC7ANxUt1cv1Ms29UHUDOMo52NNTwzwzetcr0411YLcH+/6/VTNK9Q
         4qtaSFYbUZHiwTnkWPGucCE2pkY3OVTzzEmXDVmWltZlu2C4U0KfjDNXtGQichDPgXQp
         wHb94kj/AIE68pXdArSxAKhfxqpjLxyWSyQZ65CQQlDI2T6b0MSRsPFKV3TwhtfiyGz7
         WQYAhXrnphSX145mpd1KtMl7MuCuALGqeZsEfmP087yYnIzPAdcqyK75sxErlCVeVpLS
         VxRkw9CLTCsKMXEpTpZRBT2OpCpbmCANChQF0FJ3d1D3ZsHxxUp1MW5MYVes8F1HHCnV
         ShYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGe+YMiPs0n4Kx3d8JM92LIt/HuzsVkJDs9Lp/ZDjRU=;
        b=CvTohpqj1/egInO9R30M9i0ExyrHQEyByfjcLl6fHUjBzLXNNqf5phZDzwlWnf0JmJ
         9rc97YSG711OQOxUH2SOqWMfjfOno4RHCq2+O/j5SLD/8Qls309NorPEwF5oA2v3jLPs
         BzEkqJYKHd5FjC6Ok0NHBwarlBdw25W7P/oU28n8oZopw+BdxecNBUZfyXEpWqk9ayFo
         JcYD20fjyhgybBVBsEFMkzv9hxEs5F+ATcPzIZPjPz3gyYnkvSiTblvefn9lhbXOXs0z
         SyI2UaHvfs7hM3Ljkewo4UK0i74a/gtAoLpvXyE6Br31uOVmEVcC2HKEpN/fuoTObjBY
         hMEg==
X-Gm-Message-State: AOAM530bJf49w6klwi+uQQWhBuLw2uoqfE8y4CnSZ0BIopPasfiEOCeM
        oqBdZjvE/ySdIii2H3NqCVo=
X-Google-Smtp-Source: ABdhPJxAIV9+6Ua/yuMsVAb7u9foh3T352FstRkMIU7bC7RzfXgoTxe4srqOZ0CJ9veQw2V4uUZ2yw==
X-Received: by 2002:a05:6402:4405:: with SMTP id y5mr14991745eda.32.1617357707921;
        Fri, 02 Apr 2021 03:01:47 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id bt14sm5260625edb.92.2021.04.02.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:01:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 01/16] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
Date:   Fri,  2 Apr 2021 12:01:21 +0200
Message-Id: <72ab5222629f912ca2dbe825d194108992d321e7.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

fix patch-related checkpatch warning

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 82 ++---------------------
 1 file changed, 7 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 2daf5c461a4d..6891fe6563f6 100644
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
+		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))
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
 /*
 */
@@ -887,7 +852,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### xmitframe_swencrypt\n"));
 		switch (pattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -902,8 +866,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 				break;
 		}
-	} else {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
 	}
 
 	return _SUCCESS;
@@ -957,7 +919,6 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			if (pattrib->qos_en)
 				qos_option = true;
 		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
 			res = _FAIL;
 			goto exit;
 		}
@@ -1111,7 +1072,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n"));
 		DBG_8192C("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
@@ -1139,10 +1099,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		if (pattrib->iv_len) {
 			memcpy(pframe, pattrib->iv, pattrib->iv_len);
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
-				 ("rtw_xmitframe_coalesce: keyid =%d pattrib->iv[3]=%.2x pframe =%.2x %.2x %.2x %.2x\n",
-				  padapter->securitypriv.dot11PrivacyKeyIndex, pattrib->iv[3], *pframe, *(pframe+1), *(pframe+2), *(pframe+3)));
-
 			pframe += pattrib->iv_len;
 
 			mpdu_len -= pattrib->iv_len;
@@ -1182,8 +1138,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			ClearMFrag(mem_start);
 
 			break;
-		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
 		}
 
 		addr = (SIZE_PTR)(pframe);
@@ -1193,7 +1147,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
 		DBG_8192C("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
@@ -1718,7 +1671,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
 	if (list_empty(&pfree_xmit_queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe:%d\n", pxmitpriv->free_xmitframe_cnt));
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(pfree_xmit_queue);
@@ -1729,7 +1681,6 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 
 		list_del_init(&pxframe->list);
 		pxmitpriv->free_xmitframe_cnt--;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
 	}
 
 	spin_unlock_bh(&pfree_xmit_queue->lock);
@@ -1747,7 +1698,6 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
 	spin_lock_bh(&queue->lock);
 
 	if (list_empty(&queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext:%d\n", pxmitpriv->free_xframe_ext_cnt));
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(queue);
@@ -1756,7 +1706,6 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
 
 		list_del_init(&pxframe->list);
 		pxmitpriv->free_xframe_ext_cnt--;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext():free_xmitframe_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
 	}
 
 	spin_unlock_bh(&queue->lock);
@@ -1801,10 +1750,8 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	struct adapter *padapter = pxmitpriv->adapter;
 	struct sk_buff *pndis_pkt = NULL;
 
-	if (!pxmitframe) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======rtw_free_xmitframe():pxmitframe == NULL!!!!!!!!!!\n"));
+	if (!pxmitframe)
 		goto exit;
-	}
 
 	if (pxmitframe->pkt) {
 		pndis_pkt = pxmitframe->pkt;
@@ -1828,14 +1775,10 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 
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
 
@@ -1870,11 +1813,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 
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
@@ -1888,21 +1828,18 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
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
@@ -1910,7 +1847,6 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	default:
 		ptxservq = &psta->sta_xmitpriv.be_q;
 		*(ac) = 2;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BE\n"));
 	break;
 	}
 
@@ -1939,7 +1875,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	if (!psta) {
 		res = _FAIL;
 		DBG_8192C("rtw_xmit_classifier: psta == NULL\n");
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmit_classifier: psta == NULL\n"));
 		goto exit;
 	}
 
@@ -2059,7 +1994,6 @@ static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib
 	u8 qsel;
 
 	qsel = pattrib->priority;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority =%d , qsel = %d\n", pattrib->priority, qsel));
 
 	pattrib->qsel = qsel;
 }
@@ -2096,14 +2030,12 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
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

