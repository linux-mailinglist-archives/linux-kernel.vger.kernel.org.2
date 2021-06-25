Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE23B39FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhFYALW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhFYAKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:45 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563EC0613A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:25 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u2so4287888qvp.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miWs/bImgUwH5+uw1NVXLVnQf576VT6nywOmtlr2p4k=;
        b=uxBGiimB1t6+u6eQj4EGNVLbSHQrj+4fIkj7RIgimYmRnmLBpck2xhKS666KTUzOEU
         Wze+owOqMyMxGr3B7KCkVcQuU7zBn302vcTHQ2QfuIks6ipAzswW9Lj/DQOB/HjoLHhY
         7zTiiQGOm4s3I2qBPUfPUtBwj7wG65dHixVt/bGnWaNghy6697U/aUQuq+S9/HX0myjn
         dPzdP4KwiAubBnLP7+M27r42SYJ9ADjlO6dm2Hhaj7+UNtVr7yvY+9GS7eRF3O12hQpB
         wpuXXJogX/ZBbp5o9c9oofRNLNXwV0p7IfJHSMCUSQHzoYOpzCiQE5iTYeCVUezwu+IF
         xRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miWs/bImgUwH5+uw1NVXLVnQf576VT6nywOmtlr2p4k=;
        b=PrthCp1IF4n8cIP3rfkurRpNfac9mwK164iFctLenl1MS275enpQg71DrMqt4INW/b
         s1ALXLbxnBgpg3+4djcn3xh22vwHERGZSfiWO1ovQc4j0mN+Ez4EibqFUDdeTQBwdXTz
         BTSq4F13WQF9+PLEucENt25/sbiqZqFuGWTbCH+wKYCFhyAsYI6s7r78b31a6yKGCfDY
         afd9Lo74LBDPKC8dDhOtlinYnBb/34wlrCBivMOOS53+LZy12FOyK5CeApYPgdrVmQ55
         APfoDCY3+A8pHqVTe+8mXGQ4L5RebfC1Fs1mf3IMHv4P6VD9QtSHm9msD8B0zIZ7RCan
         JgCA==
X-Gm-Message-State: AOAM5309RPD0CBjaQuxfeREpPgK1mh7v+WWXDEzn7bBamMTcW6Z1sxJ0
        Vrr+vzREnz4cFnHl3Qo38iiGvg==
X-Google-Smtp-Source: ABdhPJwUhkefiyIAxzHEgmw/agMSjt4wEYB/nPbqYflyhP0FiT4Hqp/4ksTPdkDDBNFIujc89iGfzQ==
X-Received: by 2002:ad4:4768:: with SMTP id d8mr8194088qvx.48.1624579704828;
        Thu, 24 Jun 2021 17:08:24 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:24 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 16/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_xmit.c
Date:   Fri, 25 Jun 2021 01:07:49 +0100
Message-Id: <20210625000756.6313-17-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_xmit.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 101 ++--------------------
 1 file changed, 7 insertions(+), 94 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 2a51ea26e0ff..d5fc59417ec6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -75,7 +75,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -110,7 +109,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -149,7 +147,6 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -442,7 +439,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 				    ((tmp[21] == 67) && (tmp[23] == 68))) {
 					/*  68 : UDP BOOTP client */
 					/*  67 : UDP BOOTP server */
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("====================== %s: get DHCP Packet\n", __func__));
 					/*  Use low rate to send DHCP packet. */
 					pattrib->dhcp_pkt = 1;
 				}
@@ -465,7 +461,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 		if (!psta) { /*  if we cannot get psta => drrp the pkt */
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra: %pM\n", (pattrib->ra)));
 			res = _FAIL;
 			goto exit;
 		} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) &&
@@ -480,7 +475,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		pattrib->psta = psta;
 	} else {
 		/*  if we cannot get psta => drop the pkt */
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra:%pM\n", (pattrib->ra)));
 		res = _FAIL;
 		goto exit;
 	}
@@ -505,12 +499,9 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	}
 
 	if (psta->ieee8021x_blocked) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\n psta->ieee8021x_blocked == true\n"));
-
 		pattrib->encrypt = 0;
 
 		if (pattrib->ether_type != ETH_P_PAE) {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\npsta->ieee8021x_blocked == true,  pattrib->ether_type(%.4x) != ETH_P_PAE\n", pattrib->ether_type));
 			res = _FAIL;
 			goto exit;
 		}
@@ -546,15 +537,11 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
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
@@ -564,18 +551,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		break;
 	}
 
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-		 ("%s: encrypt=%d\n", __func__, pattrib->encrypt));
-
-	if (pattrib->encrypt && !psecuritypriv->hw_decrypted) {
+	if (pattrib->encrypt && !psecuritypriv->hw_decrypted)
 		pattrib->bswenc = true;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			 ("%s: encrypt=%d bswenc = true\n", __func__,
-			  pattrib->encrypt));
-	} else {
+	else
 		pattrib->bswenc = false;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("%s: bswenc = false\n", __func__));
-	}
 
 	update_attrib_phy_info(pattrib, psta);
 
@@ -644,17 +623,8 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
 				payload = (u8 *)round_up((size_t)(payload), 4);
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-					 ("=== curfragnum=%d, pframe = 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x, 0x%.2x,!!!\n",
-					 curfragnum, *payload, *(payload + 1),
-					 *(payload + 2), *(payload + 3),
-					 *(payload + 4), *(payload + 5),
-					 *(payload + 6), *(payload + 7)));
 
 				payload += pattrib->hdrlen + pattrib->iv_len;
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-					 ("curfragnum=%d pattrib->hdrlen=%d pattrib->iv_len=%d",
-					 curfragnum, pattrib->hdrlen, pattrib->iv_len));
 				if (curfragnum + 1 == pattrib->nr_frags) {
 					length = pattrib->last_txcmdsz -
 						 pattrib->hdrlen -
@@ -671,32 +641,16 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 						  pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
 					payload += length + pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("curfragnum=%d length=%d pattrib->icv_len=%d", curfragnum, length, pattrib->icv_len));
 				}
 			}
 			rtw_secgetmic(&micdata, &mic[0]);
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: before add mic code!!!\n", __func__));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: pattrib->last_txcmdsz=%d!!!\n", __func__, pattrib->last_txcmdsz));
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: mic[0]=0x%.2x , mic[1]=0x%.2x , mic[2]= 0x%.2x, mic[3]=0x%.2x\n\
-  mic[4]= 0x%.2x , mic[5]= 0x%.2x , mic[6]= 0x%.2x , mic[7]= 0x%.2x !!!!\n",
-				__func__, mic[0], mic[1], mic[2], mic[3], mic[4], mic[5], mic[6], mic[7]));
 			/* add mic code  and add the mic code length in last_txcmdsz */
 
 			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("\n ======== last pkt ========\n"));
 			payload -= pattrib->last_txcmdsz + 8;
-			for (curfragnum = 0; curfragnum < pattrib->last_txcmdsz; curfragnum += 8)
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-					 (" %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x,  %.2x ",
-					 *(payload + curfragnum), *(payload + curfragnum + 1),
-					 *(payload + curfragnum + 2), *(payload + curfragnum + 3),
-					 *(payload + curfragnum + 4), *(payload + curfragnum + 5),
-					 *(payload + curfragnum + 6), *(payload + curfragnum + 7)));
-			} else {
-				RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: rtw_get_stainfo==NULL!!!\n", __func__));
-			}
+		}
 	}
 
 	return _SUCCESS;
@@ -707,7 +661,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("### %s\n", __func__));
 		switch (pattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -722,8 +675,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 			break;
 		}
-	} else {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_, ("### xmitframe_hwencrypt\n"));
 	}
 
 	return _SUCCESS;
@@ -785,7 +736,6 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 			if (psta && psta->qos_option)
 				qos_option = true;
 		} else {
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("fw_state:%x is not allowed to xmit frame\n", get_fwstate(pmlmepriv)));
 			res = _FAIL;
 			goto exit;
 		}
@@ -931,7 +881,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: rtw_make_wlanhdr fail; drop pkt\n", __func__));
 		res = _FAIL;
 		goto exit;
 	}
@@ -974,13 +923,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 			memcpy(pframe, pattrib->iv, pattrib->iv_len);
 
-			RT_TRACE(_module_rtl871x_xmit_c_, _drv_notice_,
-				 ("%s: keyid=%d pattrib->iv[3]=%.2x pframe=%.2x %.2x %.2x %.2x\n",
-				  __func__,
-				  padapter->securitypriv.dot11PrivacyKeyIndex,
-				  pattrib->iv[3], *pframe, *(pframe + 1),
-				  *(pframe + 2), *(pframe + 3)));
-
 			pframe += pattrib->iv_len;
 
 			mpdu_len -= pattrib->iv_len;
@@ -1019,8 +961,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			break;
 		}
 
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: There're still something in packet!\n", __func__));
-
 		addr = (size_t)(pframe);
 
 		mem_start = (unsigned char *)round_up(addr, 4) + hw_hdr_offset;
@@ -1031,7 +971,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	rtl88eu_mon_xmit_hook(padapter->pmondev, pxmitframe, frg_len);
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
 		res = _FAIL;
 		goto exit;
 	}
@@ -1247,20 +1186,12 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)
 	spin_lock_bh(&pfree_xmit_queue->lock);
 	pxframe = list_first_entry_or_null(&pfree_xmit_queue->queue,
 					   struct xmit_frame, list);
-	if (!pxframe) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-			 ("rtw_alloc_xmitframe:%d\n",
-			 pxmitpriv->free_xmitframe_cnt));
-	} else {
+	if (pxframe) {
 		list_del_init(&pxframe->list);
 
 		/* default value setting */
 		pxmitpriv->free_xmitframe_cnt--;
 
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-			 ("rtw_alloc_xmitframe():free_xmitframe_cnt=%d\n",
-			 pxmitpriv->free_xmitframe_cnt));
-
 		pxframe->buf_addr = NULL;
 		pxframe->pxmitbuf = NULL;
 
@@ -1285,10 +1216,8 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	struct adapter *padapter = pxmitpriv->adapter;
 	struct sk_buff *pndis_pkt = NULL;
 
-	if (!pxmitframe) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("====== %s:pxmitframe == NULL!!!!!!!!!!\n", __func__));
+	if (!pxmitframe)
 		goto exit;
-	}
 
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
@@ -1302,7 +1231,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	list_add_tail(&pxmitframe->list, get_list_head(pfree_xmit_queue));
 
 	pxmitpriv->free_xmitframe_cnt++;
-	RT_TRACE(_module_rtl871x_xmit_c_, _drv_debug_, ("%s:free_xmitframe_cnt=%d\n", __func__, pxmitpriv->free_xmitframe_cnt));
 
 	spin_unlock_bh(&pfree_xmit_queue->lock);
 
@@ -1329,11 +1257,8 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
-	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL) {
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_,
-			 ("%s: drop xmit pkt for classifier fail\n", __func__));
+	if (rtw_xmit_classifier(padapter, pxmitframe) == _FAIL)
 		return _FAIL;
-	}
 
 	return _SUCCESS;
 }
@@ -1417,30 +1342,22 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter,
 	case 2:
 		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*(ac) = 3;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-			 ("%s : BK\n", __func__));
 		break;
 	case 4:
 	case 5:
 		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*(ac) = 1;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-			 ("%s : VI\n", __func__));
 		break;
 	case 6:
 	case 7:
 		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*(ac) = 0;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-			 ("%s : VO\n", __func__));
 		break;
 	case 0:
 	case 3:
 	default:
 		ptxservq = &psta->sta_xmitpriv.be_q;
 		*(ac) = 2;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
-			 ("%s : BE\n", __func__));
 	break;
 	}
 
@@ -1468,7 +1385,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: psta == NULL\n", __func__));
 		goto exit;
 	}
 
@@ -1574,15 +1490,12 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	s32 res;
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pxmitframe) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: no more pxmitframe\n", __func__));
+	if (!pxmitframe)
 		return -1;
-	}
 
 	res = update_attrib(padapter, *ppkt, &pxmitframe->attrib);
 
 	if (res == _FAIL) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: update attrib fail\n", __func__));
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 		return -1;
 	}
-- 
2.31.1

