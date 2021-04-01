Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B033511EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhDAJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDAJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D3C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o19so1166183edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26FJ5RkHDxTfsirVLVO1On35Eh4N97e57Vh3YndM+LI=;
        b=nvXbFPI0PtdVgOJhCxyEBJEy56LTz7Z8Loy5YC/kKEbPONEyQY8dRU7QZ7PJSYN6K0
         EKpg9VO72SR+GLaeHG1DtZLcco0ZRIQJOLzCCuub/XLyiCZMvMknIMFQk0o5Rns4d8CS
         bKyRsYWRkNs+aVee+5jzSIdJGVXKrJDYYrtnjw/o8nBAEnIibwx4ql5pGi5Q7vedjf6s
         JKXv8KwrSLhvR77V9r8CG6BkwMxC2JXTA6b2yWgSLaj9PhE28rcJWaZPs/BnX3ZuzoLn
         cAOUmWAlnfotJ0HNnJQSGZt4yk8gQs2bLD0akoEZlvZrtxXZbsHl4ip2puid1gyPACjM
         JHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26FJ5RkHDxTfsirVLVO1On35Eh4N97e57Vh3YndM+LI=;
        b=q9SB+cDRQRStqZsVwTADBri5F3jK717X36WJyaVQiU3k2m6uojrjPdL76i8MEEJt6i
         5AQ4XxkqBzaxE1/53iaYcKjnH98BAjZXHGvMHM0icJ50PpT8SCT9G6iF3nJ+wSDwaV/4
         BciHIazJqKS1igwTwR8bz2nD8eIVNCPlpHFY7amMyvT+4k298bfTH6nbUko2TknLNR+8
         baUffhaDxipK7+nj4TX20yJNNvyF08+zSXbeoRQdtKpsDazXtmLZZKM0IP3HEp/HqWu9
         3JZVBJEQ9KNMwfSzsK/kSkw/1/3mTuo4h8bze3llC0yfrdCloGe9lES5iDL4ER6kwl5N
         7HFA==
X-Gm-Message-State: AOAM533AtD7vMQUBTyFLR9l3NklFT0PlBXJBGQjYirEnOJT1TRN++Op1
        xqHF3hWMKaNk3eP8YQfMP2E=
X-Google-Smtp-Source: ABdhPJxhF8f/CHmJ6mv0Axn14KFkEapw0gmMaDqtPt8Ut1tq44HGIDQIb4TQWX7au4KGTDWkalviXA==
X-Received: by 2002:a05:6402:26ce:: with SMTP id x14mr8593306edd.359.1617268907622;
        Thu, 01 Apr 2021 02:21:47 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id t17sm3205441edr.36.2021.04.01.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 15/49] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_recv.c
Date:   Thu,  1 Apr 2021 11:20:45 +0200
Message-Id: <7f82e266893eff7fa552f5702e4e08c3b92f512f.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 112 +---------------------
 1 file changed, 3 insertions(+), 109 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 189f686a1f29..9bd742e22ed3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -325,10 +325,6 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 	stainfo = rtw_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
 
 	if (prxattrib->encrypt == _TKIP_) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:prxattrib->encrypt == _TKIP_\n"));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:da = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-			prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2], prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
-
 		/* calculate mic code */
 		if (stainfo) {
 			if (IS_MCAST(prxattrib->ra)) {
@@ -337,28 +333,22 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				/* rxdata_key_idx =(((iv[3])>>6)&0x3) ; */
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
 
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic: bcmc key\n"));
 				/* DBG_871X("\n recvframe_chkmic: bcmc key psecuritypriv->dot118021XGrpKeyid(%d), pmlmeinfo->key_index(%d) , recv key_id(%d)\n", */
 				/* psecuritypriv->dot118021XGrpKeyid, pmlmeinfo->key_index, rxdata_key_idx); */
 
 				if (psecuritypriv->binstallGrpkey == false) {
 					res = _FAIL;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n"));
 					DBG_871X("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 			} else {
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic: unicast key\n"));
 			}
 
 			datalen = precvframe->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len-prxattrib->icv_len-8;/* icv_len included the mic code */
 			pframe = precvframe->u.hdr.rx_data;
 			payload = pframe+prxattrib->hdrlen+prxattrib->iv_len;
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n prxattrib->iv_len =%d prxattrib->icv_len =%d\n", prxattrib->iv_len, prxattrib->icv_len));
-
-
 			rtw_seccalctkipmic(mickey, pframe, payload, datalen, &miccode[0], (unsigned char)prxattrib->priority); /* care the length of the data */
 
 			pframemic = payload+datalen;
@@ -367,37 +357,16 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			for (i = 0; i < 8; i++) {
 				if (miccode[i] != *(pframemic+i)) {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic:miccode[%d](%02x) != *(pframemic+%d)(%02x) ", i, miccode[i], i, *(pframemic+i)));
 					bmic_err = true;
 				}
 			}
 
 
 			if (bmic_err == true) {
-
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n *(pframemic-8)-*(pframemic-1) = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					*(pframemic-8), *(pframemic-7), *(pframemic-6), *(pframemic-5), *(pframemic-4), *(pframemic-3), *(pframemic-2), *(pframemic-1)));
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n *(pframemic-16)-*(pframemic-9) = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					*(pframemic-16), *(pframemic-15), *(pframemic-14), *(pframemic-13), *(pframemic-12), *(pframemic-11), *(pframemic-10), *(pframemic-9)));
-
-				{
-					uint i;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet (len =%d) ======\n", precvframe->u.hdr.len));
-					for (i = 0; i < precvframe->u.hdr.len; i = i+8) {
-						RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x",
-							*(precvframe->u.hdr.rx_data+i), *(precvframe->u.hdr.rx_data+i+1),
-							*(precvframe->u.hdr.rx_data+i+2), *(precvframe->u.hdr.rx_data+i+3),
-							*(precvframe->u.hdr.rx_data+i+4), *(precvframe->u.hdr.rx_data+i+5),
-							*(precvframe->u.hdr.rx_data+i+6), *(precvframe->u.hdr.rx_data+i+7)));
-					}
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet end [len =%d]======\n", precvframe->u.hdr.len));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n hrdlen =%d,\n", prxattrib->hdrlen));
+				uint i;
+				for (i = 0; i < precvframe->u.hdr.len; i = i+8) {
 				}
 
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ra = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x psecuritypriv->binstallGrpkey =%d ",
-					prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
-					prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5], psecuritypriv->binstallGrpkey));
-
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
 				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
@@ -405,10 +374,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted =%d ", prxattrib->bdecrypted));
 					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
 				} else {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted =%d ", prxattrib->bdecrypted));
 					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
 				}
 
@@ -418,13 +385,10 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				/* mic checked ok */
 				if ((psecuritypriv->bcheck_grpkey == false) && (IS_MCAST(prxattrib->ra) == true)) {
 					psecuritypriv->bcheck_grpkey = true;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("psecuritypriv->bcheck_grpkey =true"));
 				}
 			}
 
 		} else
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic: rtw_get_stainfo == NULL!!!\n"));
-
 		recvframe_pull_tail(precvframe, 8);
 
 	}
@@ -443,8 +407,6 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 	union recv_frame *return_packet = precv_frame;
 	u32  res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("prxstat->decrypted =%x prxattrib->encrypt = 0x%03x\n", prxattrib->bdecrypted, prxattrib->encrypt));
-
 	if (prxattrib->encrypt > 0) {
 		u8 *iv = precv_frame->u.hdr.rx_data+prxattrib->hdrlen;
 		prxattrib->key_index = (((iv[3])>>6)&0x3);
@@ -552,15 +514,12 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:adapter->securitypriv.dot11AuthAlgrthm =%d\n", adapter->securitypriv.dot11AuthAlgrthm));
-
 	if (auth_alg == 2) {
 		if ((psta) && (psta->ieee8021x_blocked)) {
 			__be16 be_tmp;
 
 			/* blocked */
 			/* only accept EAPOL frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked == 1\n"));
 
 			prtnframe = precv_frame;
 
@@ -579,11 +538,9 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 		} else {
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked == 0\n"));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:precv_frame->hdr.attrib.privacy =%x\n", precv_frame->u.hdr.attrib.privacy));
 
 			if (pattrib->bdecrypted == 0)
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:prxstat->decrypted =%x\n", pattrib->bdecrypted));
+				;
 
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
@@ -609,15 +566,11 @@ static signed int recv_decache(union recv_frame *precv_frame, u8 bretry, struct
 		(precv_frame->u.hdr.attrib.frag_num & 0xf);
 
 	if (tid > 15) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, (tid>15)! seq_ctrl = 0x%x, tid = 0x%x\n", seq_ctrl, tid));
-
 		return _FAIL;
 	}
 
 	if (1) { /* if (bretry) */
 		if (seq_ctrl == prxcache->tid_rxseq[tid]) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, seq_ctrl = 0x%x, tid = 0x%x, tid_rxseq = 0x%x\n", seq_ctrl, tid, prxcache->tid_rxseq[tid]));
-
 			return _FAIL;
 		}
 	}
@@ -766,7 +719,6 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -788,7 +740,6 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 		/*  For Station mode, sa and bssid should always be BSSID, and DA is my mac-address */
 		if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("bssid != TA under STATION_MODE; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -830,7 +781,6 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
 
 	if (!*psta) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under sta2sta_data_frame ; drop pkt\n"));
 		ret = _FAIL;
 		goto exit;
 	}
@@ -858,7 +808,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s SA =%pM, myhwaddr =%pM\n",
 				__func__, MAC_ARG(pattrib->src), MAC_ARG(myhwaddr));
@@ -869,8 +818,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		/*  da should be for me */
 		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				(" ap2sta_data_frame:  compare DA fail; DA =%pM\n", MAC_ARG(pattrib->dst)));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s DA =%pM\n", __func__, MAC_ARG(pattrib->dst));
 			#endif
@@ -883,9 +830,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				(" ap2sta_data_frame:  compare BSSID fail ; BSSID =%pM\n", MAC_ARG(pattrib->bssid)));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid =%pM\n", MAC_ARG(mybssid)));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s BSSID =%pM, mybssid =%pM\n",
 				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
@@ -907,7 +851,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under STATION_MODE ; drop pkt\n", __func__);
 			#endif
@@ -936,7 +879,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under WIFI_MP_STATE ; drop pkt\n", __func__);
 			#endif
@@ -998,7 +940,6 @@ static signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *p
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
 			DBG_871X("issue_deauth to sta =%pM for the reason(7)\n", MAC_ARG(pattrib->src));
 
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -1245,8 +1186,6 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 	/* free the defrag_q queue and return the prframe */
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Performance defrag!!!!!\n"));
-
 	return prframe;
 }
 
@@ -1306,15 +1245,12 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			list_add_tail(&pfhdr->list, phead);
 			/* spin_unlock(&pdefrag_q->lock); */
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueuq: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
-
 			prtnframe = NULL;
 
 		} else {
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
 		}
 
 	}
@@ -1329,7 +1265,6 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			/* spin_unlock(&pdefrag_q->lock); */
 
 			/* call recvframe_defrag to defrag */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("defrag: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
 			precv_frame = recvframe_defrag(padapter, pdefrag_q);
 			prtnframe = precv_frame;
 
@@ -1337,7 +1272,6 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
 		}
 
 	}
@@ -1346,7 +1280,6 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 	if ((prtnframe) && (prtnframe->u.hdr.attrib.privacy)) {
 		/* after defrag we must check tkip mic code */
 		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe) == _FAIL\n"));
 			rtw_free_recvframe(prtnframe, pfree_recv_queue);
 			prtnframe = NULL;
 		}
@@ -1358,11 +1291,8 @@ static signed int validate_recv_mgnt_frame(struct adapter *padapter, union recv_
 {
 	/* struct mlme_priv *pmlmepriv = &adapter->mlmepriv; */
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+validate_recv_mgnt_frame\n"));
-
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
 	if (!precv_frame) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s: fragment packet\n", __func__));
 		return _SUCCESS;
 	}
 
@@ -1444,7 +1374,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 		memcpy(pattrib->ra, GetAddr1Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
 		ret = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" case 3\n"));
 		break;
 
 	default:
@@ -1464,7 +1393,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 
 	if (!psta) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta == NULL\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s psta == NULL\n", __func__);
 		#endif
@@ -1502,7 +1430,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decache : drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s recv_decache return _FAIL\n", __func__);
 		#endif
@@ -1511,14 +1438,8 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 	}
 
 	if (pattrib->privacy) {
-
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("validate_recv_data_frame:pattrib->privacy =%x\n", pattrib->privacy));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^IS_MCAST(pattrib->ra(0x%02x)) =%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], IS_MCAST(pattrib->ra)));
-
 		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, IS_MCAST(pattrib->ra));
 
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n pattrib->encrypt =%d\n", pattrib->encrypt));
-
 		SET_ICE_IV_LEN(pattrib->iv_len, pattrib->icv_len, pattrib->encrypt);
 	} else {
 		pattrib->encrypt = 0;
@@ -1642,7 +1563,6 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 
 	/* add version chk */
 	if (ver != 0) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! (ver!= 0)\n"));
 		retval = _FAIL;
 		goto exit;
 	}
@@ -1677,13 +1597,11 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 
 		retval = validate_recv_mgnt_frame(adapter, precv_frame);
 		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_mgnt_frame fail\n"));
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_CTRL_TYPE: /* ctrl */
 		retval = validate_recv_ctrl_frame(adapter, precv_frame);
 		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_ctrl_frame fail\n"));
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_DATA_TYPE: /* data */
@@ -1708,7 +1626,6 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 		}
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! type = 0x%x\n", type));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME validate_recv_data_frame fail! type = 0x%x\n", type);
 		#endif
@@ -1755,8 +1672,6 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	rmv_len = pattrib->hdrlen + pattrib->iv_len + (bsnaphdr?SNAP_SIZE:0);
 	len = precvframe->u.hdr.len - rmv_len;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ===pattrib->hdrlen: %x,  pattrib->iv_len:%x ===\n\n", pattrib->hdrlen,  pattrib->iv_len));
-
 	memcpy(&be_tmp, ptr+rmv_len, 2);
 	eth_type = ntohs(be_tmp); /* pattrib->ether_type */
 	pattrib->eth_type = eth_type;
@@ -2036,10 +1951,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 		pattrib = &prframe->u.hdr.attrib;
 
 		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-				 ("recv_indicatepkts_in_order: indicate =%d seq =%d amsdu =%d\n",
-				  preorder_ctrl->indicate_seq, pattrib->seq_num, pattrib->amsdu));
-
 			plist = get_next(plist);
 			list_del_init(&(prframe->u.hdr.list));
 
@@ -2110,8 +2021,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		if (pattrib->qos != 1) {
 			if ((padapter->bDriverStopped == false) &&
 			    (padapter->bSurpriseRemoved == false)) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@  recv_indicatepkt_reorder -recv_func recv_indicatepkt\n"));
-
 				rtw_recv_indicatepkt(padapter, prframe);
 				return _SUCCESS;
 
@@ -2171,10 +2080,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-		 ("recv_indicatepkt_reorder: indicate =%d seq =%d\n",
-		  preorder_ctrl->indicate_seq, pattrib->seq_num));
-
 	/* s2. check if winstart_b(indicate_seq) needs to been updated */
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
 		pdbgpriv->dbg_rx_ampdu_drop_count++;
@@ -2272,7 +2177,6 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 	} else { /* B/G mode */
 		retval = wlanhdr_to_ethhdr(prframe);
 		if (retval != _SUCCESS) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("wlanhdr_to_ethhdr: drop pkt\n"));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s wlanhdr_to_ethhdr error!\n", __func__);
 			#endif
@@ -2281,14 +2185,10 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 
 		if ((padapter->bDriverStopped == false) && (padapter->bSurpriseRemoved == false)) {
 			/* indicate this recv_frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ process_recv_indicatepkts- recv_func recv_indicatepkt\n"));
 			rtw_recv_indicatepkt(padapter, prframe);
 
 
 		} else {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ process_recv_indicatepkts- recv_func free_indicatepkt\n"));
-
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_func:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
 			retval = _FAIL;
 			return retval;
 		}
@@ -2307,7 +2207,6 @@ static int recv_func_prehandle(struct adapter *padapter, union recv_frame *rfram
 	/* check the frame crtl field and decache */
 	ret = validate_recv_frame(padapter, rframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recv_func: validate_recv_frame fail! drop pkt\n"));
 		rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
 		goto exit;
 	}
@@ -2325,7 +2224,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s decryptor: drop pkt\n", __func__);
 		#endif
@@ -2335,7 +2233,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
 	if (!prframe)	{
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s recvframe_chk_defrag: drop pkt\n", __func__);
 		#endif
@@ -2344,7 +2241,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s portctrl: drop pkt\n", __func__);
 		#endif
@@ -2356,7 +2252,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recv_func: process_recv_indicatepkts fail!\n"));
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s process_recv_indicatepkts fail!\n", __func__);
 		#endif
@@ -2435,7 +2330,6 @@ s32 rtw_recv_entry(union recv_frame *precvframe)
 
 	ret = recv_func(padapter, precvframe);
 	if (ret == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("rtw_recv_entry: recv_func return fail!!!\n"));
 		goto _recv_entry_drop;
 	}
 
-- 
2.20.1

