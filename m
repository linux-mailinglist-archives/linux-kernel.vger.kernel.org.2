Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4C34FD21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhCaJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhCaJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so29110626ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93CYvlFHhLYW1GdBF/FS3Trwwm9IX+zkOhhFsKJZsEk=;
        b=A41lYqnz3CAf7Sevp2hJe3EA7r1XKtgkQn2Hh+mGbtbLy05uZQdApZpNgbohgeuqZi
         JiL8iH47RNcKtj1WQHsvyfdzSmjkMVamj51nhiH+PLdomO5cyeo6SlOMAuxnL1WS7xR7
         NhabBGmHS10e7OFeRSM03XB2p/wTbwseC9vlDi7TYzegX/2KdI03lNinMaCSme8GaGdK
         FDqnQVjaHdm7YBtdCNE4CZo3xmEY+v8kJteY7iTxCcrDFK10S8fmBf1FVFlTW8kqmMUy
         hQnbA08RodUWF3QIO5T+qHHGxuMTERzT5rKiooswPyNaHtWS3ZeLkQersVfKx/d+SUIb
         cZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93CYvlFHhLYW1GdBF/FS3Trwwm9IX+zkOhhFsKJZsEk=;
        b=QHz7LZdh1yzkTL+pWsoNJymZ1kXSYNWz1PSaqm4ce6EWb2WOcvodlAksVngHw4TOBp
         W4+NxGOPpA5NRoEpqjZ+b/+fpopME7/053tmYSpGcWXzSe07DuqYXcBSVfx/rDRh93DZ
         c5IjeA7qLUPFsYBq0HynK+ECLY2/0/QAdoYn03xJ84pwid1SpFjxzf0xslOCJH36F0iq
         8fLUYYeyHEOqLXVdV04LKUoc3wtesn34gh7TPqxUdpOUsNyHqICPs36cLFlpeaOzwFOS
         HVXkQZXI/pd9layBr8MfTY1l0yFTeVNt2X045zDG0xR6cz/Sc5oll+4HkGuoze+sdMFo
         npnw==
X-Gm-Message-State: AOAM5326DcMfUokBwFP9x0PRcOf5EBqn8uDCq5OMKud4i4AmGOOLnOC4
        W3FWuNM+UzJ35WNQZDUlMN8=
X-Google-Smtp-Source: ABdhPJygkgfRdsFAqoqFY8Dpa6ljcGhFKd/6JBaYAjuNMTviqQheYXRzgBoN3J2/v1zXX/AMyuRawQ==
X-Received: by 2002:a17:906:8043:: with SMTP id x3mr2515194ejw.149.1617183614785;
        Wed, 31 Mar 2021 02:40:14 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id r5sm1157737eds.49.2021.03.31.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 01/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_xmit.c
Date:   Wed, 31 Mar 2021 11:39:29 +0200
Message-Id: <75c8a2396a0cae9ad7933577b20dfbf3a7ce6816.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 168 +++++++++++++++-------
 1 file changed, 113 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 2daf5c461a4d..6ea8d4ae90d1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -69,7 +69,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
+		pr_err("%s alloc xmit_frame fail!\n", DRIVER_PREFIX);
 		res = _FAIL;
 		goto exit;
 	}
@@ -105,7 +105,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
+		pr_err("%s alloc xmit_buf fail!\n", DRIVER_PREFIX);
 		res = _FAIL;
 		goto exit;
 	}
@@ -155,7 +155,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->xframe_ext_alloc_addr) {
 		pxmitpriv->xframe_ext = NULL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xframe_ext fail!\n"));
+		pr_err("%s alloc xframe_ext fail!\n", DRIVER_PREFIX);
 		res = _FAIL;
 		goto exit;
 	}
@@ -188,7 +188,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(NR_XMIT_EXTBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
+		pr_err("%s alloc xmit_extbuf fail!\n", DRIVER_PREFIX);
 		res = _FAIL;
 		goto exit;
 	}
@@ -481,12 +481,13 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 	pattrib->mac_id = psta->mac_id;
 
 	if (psta->ieee8021x_blocked == true) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\n psta->ieee8021x_blocked == true\n"));
+		pr_err("%s psta->ieee8021x_blocked == true\n", DRIVER_PREFIX);
 
 		pattrib->encrypt = 0;
 
 		if ((pattrib->ether_type != 0x888e) && (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\npsta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != 0x888e\n", pattrib->ether_type));
+			pr_err("%s psta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != 0x888e\n",
+			       DRIVER_PREFIX, pattrib->ether_type);
 			#ifdef DBG_TX_DROP_FRAME
 			DBG_871X("DBG_TX_DROP_FRAME %s psta->ieee8021x_blocked == true,  pattrib->ether_type(%04x) != 0x888e\n", __func__, pattrib->ether_type);
 			#endif
@@ -568,19 +569,17 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 	if (pattrib->encrypt > 0)
 		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
 
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-		("update_attrib: encrypt =%d  securitypriv.sw_encrypt =%d\n",
-		pattrib->encrypt, padapter->securitypriv.sw_encrypt));
+	pr_info("%s update_attrib: encrypt =%d  securitypriv.sw_encrypt =%d\n", DRIVER_PREFIX,
+		pattrib->encrypt, padapter->securitypriv.sw_encrypt);
 
 	if (pattrib->encrypt &&
 		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false))) {
 		pattrib->bswenc = true;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			("update_attrib: encrypt =%d securitypriv.hw_decrypted =%d bswenc =true\n",
-			pattrib->encrypt, padapter->securitypriv.sw_encrypt));
+		pr_err("%s update_attrib: encrypt =%d securitypriv.hw_decrypted =%d bswenc =true\n",
+		       DRIVER_PREFIX, pattrib->encrypt, padapter->securitypriv.sw_encrypt);
 	} else {
 		pattrib->bswenc = false;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("update_attrib: bswenc =false\n"));
+		pr_info("%s update_attrib: bswenc =false\n", DRIVER_PREFIX);
 	}
 
 exit:
@@ -685,7 +684,8 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 					((tmp[21] == 67) && (tmp[23] == 68))) {
 					/*  68 : UDP BOOTP client */
 					/*  67 : UDP BOOTP server */
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======================update_attrib: get DHCP Packet\n"));
+					pr_err("%s ======================%s: get DHCP Packet\n",
+					       DRIVER_PREFIX, __func__);
 					pattrib->dhcp_pkt = 1;
 				}
 			}
@@ -720,7 +720,8 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 		if (!psta)	{ /*  if we cannot get psta => drop the pkt */
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", MAC_ARG(pattrib->ra)));
+			pr_alert("%s %s => get sta_info fail, ra:%pM\n",
+				 DRIVER_PREFIX, __func__, MAC_ARG(pattrib->ra));
 			#ifdef DBG_TX_DROP_FRAME
 			DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
 			#endif
@@ -734,7 +735,8 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (!psta) {
 		/*  if we cannot get psta => drop the pkt */
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", MAC_ARG(pattrib->ra)));
+		pr_alert("%s %s => get sta_info fail, ra:%pM\n",
+			 DRIVER_PREFIX, __func__, MAC_ARG(pattrib->ra));
 		#ifdef DBG_TX_DROP_FRAME
 		DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
 		#endif
@@ -842,11 +844,25 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
 				payload = (u8 *)round_up((SIZE_PTR)(payload), 4);
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("===curfragnum =%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
-					curfragnum, *payload, *(payload+1), *(payload+2), *(payload+3), *(payload+4), *(payload+5), *(payload+6), *(payload+7)));
+				pr_err("%s ===curfragnum =%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
+				       DRIVER_PREFIX,
+				       curfragnum,
+				       *payload,
+				       *(payload+1),
+				       *(payload+2),
+				       *(payload+3),
+				       *(payload+4),
+				       *(payload+5),
+				       *(payload+6),
+				       *(payload+7));
 
 				payload = payload+pattrib->hdrlen+pattrib->iv_len;
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum =%d pattrib->hdrlen =%d pattrib->iv_len =%d", curfragnum, pattrib->hdrlen, pattrib->iv_len));
+				pr_err("%s curfragnum =%d pattrib->hdrlen =%d pattrib->iv_len =%d",
+				       DRIVER_PREFIX,
+				       curfragnum,
+				       pattrib->hdrlen,
+				       pattrib->iv_len);
+
 				if ((curfragnum+1) == pattrib->nr_frags) {
 					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
@@ -855,26 +871,53 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
 					payload = payload+length+pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum =%d length =%d pattrib->icv_len =%d", curfragnum, length, pattrib->icv_len));
+					pr_err("%s curfragnum =%d length =%d pattrib->icv_len =%d",
+					       DRIVER_PREFIX,
+					       curfragnum,
+					       length,
+					       pattrib->icv_len);
 				}
 			}
 			rtw_secgetmic(&micdata, &mic[0]);
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: before add mic code!!!\n"));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: pattrib->last_txcmdsz =%d!!!\n", pattrib->last_txcmdsz));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic: mic[0]= 0x%.2x , mic[1]= 0x%.2x , mic[2]= 0x%.2x , mic[3]= 0x%.2x\n\
-  mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
-				mic[0], mic[1], mic[2], mic[3], mic[4], mic[5], mic[6], mic[7]));
+			pr_err("%s %s: before add mic code!!!\n", DRIVER_PREFIX, __func__);
+			pr_err("%s %s: pattrib->last_txcmdsz =%d!!!\n",
+			       DRIVER_PREFIX, __func__, pattrib->last_txcmdsz);
+			pr_err("%s %s:"
+			       " mic[0]= 0x%.2x , "
+			       " mic[1]= 0x%.2x , "
+			       " mic[2]= 0x%.2x , "
+			       " mic[3]= 0x%.2x\n "
+			       " mic[4]= 0x%.2x , "
+			       " mic[5]= 0x%.2x , "
+			       " mic[6]= 0x%.2x , "
+			       " mic[7]= 0x%.2x !!!!\n",
+			       DRIVER_PREFIX, __func__,
+			       mic[0],
+			       mic[1],
+			       mic[2],
+			       mic[3],
+			       mic[4],
+			       mic[5],
+			       mic[6],
+			       mic[7]);
 			/* add mic code  and add the mic code length in last_txcmdsz */
 
 			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("\n ========last pkt ========\n"));
+			pr_info("%s ========last pkt ========\n", DRIVER_PREFIX);
 			payload = payload-pattrib->last_txcmdsz+8;
 			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum = curfragnum+8)
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, (" %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
-					*(payload+curfragnum), *(payload+curfragnum+1), *(payload+curfragnum+2), *(payload+curfragnum+3),
-					*(payload+curfragnum+4), *(payload+curfragnum+5), *(payload+curfragnum+6), *(payload+curfragnum+7)));
+					pr_info("%s %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
+						DRIVER_PREFIX,
+						*(payload+curfragnum),
+						*(payload+curfragnum+1),
+						*(payload+curfragnum+2),
+						*(payload+curfragnum+3),
+						*(payload+curfragnum+4),
+						*(payload+curfragnum+5),
+						*(payload+curfragnum+6),
+						*(payload+curfragnum+7));
 			}
 /*
 */
@@ -887,7 +930,7 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### xmitframe_swencrypt\n"));
+		pr_alert("%s ### %s\n", DRIVER_PREFIX, __func__);
 		switch (pattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -903,7 +946,7 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 				break;
 		}
 	} else {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
+		pr_notice("%s ### xmitframe_hwencrypt\n", DRIVER_PREFIX);
 	}
 
 	return _SUCCESS;
@@ -957,7 +1000,8 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			if (pattrib->qos_en)
 				qos_option = true;
 		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
+			pr_err("%s fw_state:%x is not allowed to xmit frame\n", DRIVER_PREFIX,
+			       get_fwstate(pmlmepriv));
 			res = _FAIL;
 			goto exit;
 		}
@@ -1111,7 +1155,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n"));
+		pr_err("%s %s: rtw_make_wlanhdr fail; drop pkt\n", DRIVER_PREFIX, __func__);
 		DBG_8192C("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
@@ -1139,9 +1183,14 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		if (pattrib->iv_len) {
 			memcpy(pframe, pattrib->iv, pattrib->iv_len);
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
-				 ("rtw_xmitframe_coalesce: keyid =%d pattrib->iv[3]=%.2x pframe =%.2x %.2x %.2x %.2x\n",
-				  padapter->securitypriv.dot11PrivacyKeyIndex, pattrib->iv[3], *pframe, *(pframe+1), *(pframe+2), *(pframe+3)));
+			pr_notice("%s %s: keyid =%d pattrib->iv[3]=%.2x pframe =%.2x %.2x %.2x %.2x\n",
+				  DRIVER_PREFIX, __func__,
+				  padapter->securitypriv.dot11PrivacyKeyIndex,
+				  pattrib->iv[3],
+				  *pframe,
+				  *(pframe+1),
+				  *(pframe+2),
+				  *(pframe+3));
 
 			pframe += pattrib->iv_len;
 
@@ -1183,7 +1232,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 			break;
 		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
+			pr_err("%s - %s: There're still something in packet!\n",
+			       DRIVER_PREFIX, __func__);
 		}
 
 		addr = (SIZE_PTR)(pframe);
@@ -1193,7 +1243,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
+		pr_err("%s xmitframe_addmic(padapter, pxmitframe) == _FAIL\n", DRIVER_PREFIX);
 		DBG_8192C("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
@@ -1718,7 +1768,8 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
 	if (list_empty(&pfree_xmit_queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe:%d\n", pxmitpriv->free_xmitframe_cnt));
+		pr_info("%s %s:%d\n", DRIVER_PREFIX, __func__,
+			pxmitpriv->free_xmitframe_cnt);
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(pfree_xmit_queue);
@@ -1729,7 +1780,8 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 
 		list_del_init(&pxframe->list);
 		pxmitpriv->free_xmitframe_cnt--;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
+		pr_info("%s %s: free_xmitframe_cnt =%d\n", DRIVER_PREFIX, __func__,
+			pxmitpriv->free_xmitframe_cnt);
 	}
 
 	spin_unlock_bh(&pfree_xmit_queue->lock);
@@ -1747,7 +1799,8 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
 	spin_lock_bh(&queue->lock);
 
 	if (list_empty(&queue->queue)) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext:%d\n", pxmitpriv->free_xframe_ext_cnt));
+		pr_info("%s %s:%d\n", DRIVER_PREFIX, __func__,
+			pxmitpriv->free_xframe_ext_cnt);
 		pxframe =  NULL;
 	} else {
 		phead = get_list_head(queue);
@@ -1756,7 +1809,8 @@ struct xmit_frame *rtw_alloc_xmitframe_ext(struct xmit_priv *pxmitpriv)
 
 		list_del_init(&pxframe->list);
 		pxmitpriv->free_xframe_ext_cnt--;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe_ext():free_xmitframe_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
+		pr_info("%s %s:free_xmitframe_cnt =%d\n", DRIVER_PREFIX,
+			__func__, pxmitpriv->free_xframe_ext_cnt);
 	}
 
 	spin_unlock_bh(&queue->lock);
@@ -1802,7 +1856,8 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	struct sk_buff *pndis_pkt = NULL;
 
 	if (!pxmitframe) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("======rtw_free_xmitframe():pxmitframe == NULL!!!!!!!!!!\n"));
+		pr_err("%s ======%s:pxmitframe == NULL!!!!!!!!!!\n",
+		       DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 
@@ -1830,10 +1885,12 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	list_add_tail(&pxmitframe->list, get_list_head(queue));
 	if (pxmitframe->ext_tag == 0) {
 		pxmitpriv->free_xmitframe_cnt++;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xmitframe_cnt =%d\n", pxmitpriv->free_xmitframe_cnt));
+		pr_debug("%s %s:free_xmitframe_cnt =%d\n",
+			 DRIVER_PREFIX, __func__, pxmitpriv->free_xmitframe_cnt);
 	} else if (pxmitframe->ext_tag == 1) {
 		pxmitpriv->free_xframe_ext_cnt++;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("rtw_free_xmitframe():free_xframe_ext_cnt =%d\n", pxmitpriv->free_xframe_ext_cnt));
+		pr_debug("%s %s:free_xframe_ext_cnt =%d\n",
+			 DRIVER_PREFIX, __func__, pxmitpriv->free_xframe_ext_cnt);
 	} else {
 	}
 
@@ -1871,8 +1928,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			 ("rtw_xmitframe_enqueue: drop xmit pkt for classifier fail\n"));
+		pr_err("%s %s: drop xmit pkt for classifier fail\n", DRIVER_PREFIX,
+		       __func__);
 		return _FAIL;
 	}
 
@@ -1888,21 +1945,21 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	case 2:
 		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*(ac) = 3;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BK\n"));
+		pr_info("%s %s : BK\n", DRIVER_PREFIX, __func__);
 		break;
 
 	case 4:
 	case 5:
 		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*(ac) = 1;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VI\n"));
+		pr_info("%s %s : VI\n", DRIVER_PREFIX, __func__);
 		break;
 
 	case 6:
 	case 7:
 		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*(ac) = 0;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : VO\n"));
+		pr_info("%s %s : VO\n", DRIVER_PREFIX, __func__);
 		break;
 
 	case 0:
@@ -1910,7 +1967,7 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter, struct sta_info *
 	default:
 		ptxservq = &psta->sta_xmitpriv.be_q;
 		*(ac) = 2;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_get_sta_pending : BE\n"));
+		pr_info("%s %s : BE\n", DRIVER_PREFIX, __func__);
 	break;
 	}
 
@@ -1939,7 +1996,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	if (!psta) {
 		res = _FAIL;
 		DBG_8192C("rtw_xmit_classifier: psta == NULL\n");
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmit_classifier: psta == NULL\n"));
+		pr_err("%s %s: psta == NULL\n", DRIVER_PREFIX, __func__);
 		goto exit;
 	}
 
@@ -2059,7 +2116,8 @@ static void do_queue_select(struct adapter	*padapter, struct pkt_attrib *pattrib
 	u8 qsel;
 
 	qsel = pattrib->priority;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("### do_queue_select priority =%d , qsel = %d\n", pattrib->priority, qsel));
+	pr_info("%s ### %s priority =%d , qsel = %d\n",
+		DRIVER_PREFIX, __func__, pattrib->priority, qsel);
 
 	pattrib->qsel = qsel;
 }
@@ -2096,14 +2154,14 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	if (!pxmitframe) {
 		drop_cnt++;
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: no more pxmitframe\n", __func__));
+		pr_err("%s %s: no more pxmitframe\n", DRIVER_PREFIX, __func__);
 		return -1;
 	}
 
 	res = update_attrib(padapter, *ppkt, &pxmitframe->attrib);
 
 	if (res == _FAIL) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: update attrib fail\n", __func__));
+		pr_err("%s %s: update attrib fail\n", DRIVER_PREFIX, __func__);
 		#ifdef DBG_TX_DROP_FRAME
 		DBG_871X("DBG_TX_DROP_FRAME %s update attrib fail\n", __func__);
 		#endif
-- 
2.20.1

