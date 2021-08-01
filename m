Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640DC3DCD30
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhHATF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhHATFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:05:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB39C061798
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l18so18789597wrv.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LKvS4q4HTI5wMzebAXEEF35toBQt7KXxYePveJYywM=;
        b=gd6ssKbimkv9spqz8hebjMZsV/a9yvcgmh9O8OAmXjWzQlyYi2PzRgjxZKAKRap+Yk
         Xam9T3ndN9h77kdpmfevQ3s3uskCxRm9XNkXgVlx70glbdFR3DgAljb0uQoMm7KtGk7E
         RjCo4KMZSzP+vHDdk/T/LC2lJDsSLcnJvZ+L0u/6kwp+cYHYMt7vpGfhxfBR0/jk5zOn
         xJ/fR3Kt42qiHV2KTiTAaz17YR+LB1H0pXG4AgfZ6WeNtQhm9ldIL/YwOUd1C0SkNPDZ
         74DppAffNdn6E08RrE0EYnWLVk47Y8BLJv/fJWf/Q7AR2dLfsmq9SxzusLDbR/c9dwnI
         eASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LKvS4q4HTI5wMzebAXEEF35toBQt7KXxYePveJYywM=;
        b=CgiecP2S6zwVOJQnKBFSjC1ZdcWukmt0Py0FG2/32W0n+tR4W6wqZwL0tZYblg4U4p
         I0DgilkCQWJbwOz/RS/DA9rRYiYMKYGTtbG7JyPpgLSnqEhaveQSh+6p3RjUwCofOjOE
         neALe3stXjEVSFXGqmykGkbYIKTGKK946vNb91coYTdCXNxhDnSh9+s9fYW4icIdSOfa
         II+UOIQHHDp1t/a9CyFhm/hyuLS1+x9HOQKsPPQOioaORMYmEexxdukdWLD3wh/FfMPj
         qtn5hAbBCkSCMW9arjZXi+M1ZbFfJVOkXc2yQtAJSw/wFZFm3q+cAj5Q7bXdPcve5/iR
         yTxA==
X-Gm-Message-State: AOAM533c+vh30edYO4hcAraRY8/jU9WMUf3iDWXty4yf5uycnqDmLMuH
        2utHrkWp75kb9eGWkMIS28py0w==
X-Google-Smtp-Source: ABdhPJydwhW7gwQ9aOaQBOEiPHDPOWHzqJaiLMrAYQUcJM53rxmwvipdo9bj4+HtsBOy3sSWPZnRsg==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr13852410wru.271.1627844691344;
        Sun, 01 Aug 2021 12:04:51 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:50 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 15/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c
Date:   Sun,  1 Aug 2021 20:04:37 +0100
Message-Id: <20210801190437.82017-16-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_recv.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 161 ++----------------------
 1 file changed, 11 insertions(+), 150 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 610cc699caf9..d0d433f2fa4e 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -342,33 +342,24 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 	stainfo = rtw_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
 
 	if (prxattrib->encrypt == _TKIP_) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:prxattrib->encrypt==_TKIP_\n"));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:da=0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-			 prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2], prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
-
 		/* calculate mic code */
 		if (stainfo != NULL) {
 			if (IS_MCAST(prxattrib->ra)) {
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
 
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic: bcmc key\n"));
-
 				if (!psecuritypriv) {
 					res = _FAIL;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n"));
 					DBG_88E("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 			} else {
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic: unicast key\n"));
 			}
 
 			datalen = precvframe->len-prxattrib->hdrlen-prxattrib->iv_len-prxattrib->icv_len-8;/* icv_len included the mic code */
 			pframe = precvframe->rx_data;
 			payload = pframe+prxattrib->hdrlen+prxattrib->iv_len;
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n prxattrib->iv_len=%d prxattrib->icv_len=%d\n", prxattrib->iv_len, prxattrib->icv_len));
 			rtw_seccalctkipmic(mickey, pframe, payload, datalen, &miccode[0],
 					   (unsigned char)prxattrib->priority); /* care the length of the data */
 
@@ -377,44 +368,11 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 			bmic_err = false;
 
 			for (i = 0; i < 8; i++) {
-				if (miccode[i] != *(pframemic+i)) {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-						 ("recvframe_chkmic:miccode[%d](%02x)!=*(pframemic+%d)(%02x) ",
-						 i, miccode[i], i, *(pframemic+i)));
+				if (miccode[i] != *(pframemic+i))
 					bmic_err = true;
-				}
 			}
 
 			if (bmic_err) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("\n *(pframemic-8)-*(pframemic-1)=0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					 *(pframemic-8), *(pframemic-7), *(pframemic-6),
-					 *(pframemic-5), *(pframemic-4), *(pframemic-3),
-					 *(pframemic-2), *(pframemic-1)));
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("\n *(pframemic-16)-*(pframemic-9)=0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					 *(pframemic-16), *(pframemic-15), *(pframemic-14),
-					 *(pframemic-13), *(pframemic-12), *(pframemic-11),
-					 *(pframemic-10), *(pframemic-9)));
-				{
-					uint i;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet (len=%d)======\n", precvframe->len));
-					for (i = 0; i < precvframe->len; i = i+8) {
-						RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x",
-							 *(precvframe->rx_data+i), *(precvframe->rx_data+i+1),
-							 *(precvframe->rx_data+i+2), *(precvframe->rx_data+i+3),
-							 *(precvframe->rx_data+i+4), *(precvframe->rx_data+i+5),
-							 *(precvframe->rx_data+i+6), *(precvframe->rx_data+i+7)));
-					}
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ====== demp packet end [len=%d]======\n", precvframe->len));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n hrdlen=%d,\n", prxattrib->hdrlen));
-				}
-
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("ra=0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x psecuritypriv->binstallGrpkey=%d ",
-					 prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
-					 prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5], psecuritypriv->binstallGrpkey));
-
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
 				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
@@ -422,22 +380,16 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 
 				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
 					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
 				} else {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
 					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
 				}
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
-				if ((!psecuritypriv->bcheck_grpkey) && (IS_MCAST(prxattrib->ra))) {
+				if ((!psecuritypriv->bcheck_grpkey) && (IS_MCAST(prxattrib->ra)))
 					psecuritypriv->bcheck_grpkey = true;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("psecuritypriv->bcheck_grpkey = true"));
-				}
 			}
-		} else {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic: rtw_get_stainfo==NULL!!!\n"));
 		}
 
 		recvframe_pull_tail(precvframe, 8);
@@ -456,8 +408,6 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 	struct recv_frame *return_packet = precv_frame;
 	u32	 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("prxstat->decrypted=%x prxattrib->encrypt=0x%03x\n", prxattrib->bdecrypted, prxattrib->encrypt));
-
 	if (prxattrib->encrypt > 0) {
 		u8 *iv = precv_frame->rx_data+prxattrib->hdrlen;
 		prxattrib->key_index = (((iv[3])>>6)&0x3);
@@ -536,16 +486,11 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 	prtnframe = NULL;
 
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-		 ("########portctrl:adapter->securitypriv.dot11AuthAlgrthm=%d\n",
-		 adapter->securitypriv.dot11AuthAlgrthm));
 
 	if (auth_alg == 2) {
 		if ((psta != NULL) && (psta->ieee8021x_blocked)) {
 			/* blocked */
 			/* only accept EAPOL frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked==1\n"));
-
 			prtnframe = precv_frame;
 
 			/* get ether_type */
@@ -563,22 +508,11 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 		} else {
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked==0\n"));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:precv_frame->hdr.attrib.privacy=%x\n", precv_frame->attrib.privacy));
-
-			if (pattrib->bdecrypted == 0)
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:prxstat->decrypted=%x\n", pattrib->bdecrypted));
-
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
-			if (ether_type == eapol_type) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("########portctrl:ether_type==0x888e\n"));
+			if (ether_type == eapol_type)
 				/* check Rekey */
-
 				prtnframe = precv_frame;
-			} else {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:ether_type=0x%04x\n", ether_type));
-			}
 		}
 	} else {
 		prtnframe = precv_frame;
@@ -594,18 +528,12 @@ static int recv_decache(struct recv_frame *precv_frame, u8 bretry, struct stainf
 	u16 seq_ctrl = ((precv_frame->attrib.seq_num&0xffff) << 4) |
 		(precv_frame->attrib.frag_num & 0xf);
 
-	if (tid > 15) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, (tid>15)! seq_ctrl=0x%x, tid=0x%x\n", seq_ctrl, tid));
-
+	if (tid > 15)
 		return _FAIL;
-	}
 
 	if (1) {/* if (bretry) */
-		if (seq_ctrl == prxcache->tid_rxseq[tid]) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, seq_ctrl=0x%x, tid=0x%x, tid_rxseq=0x%x\n", seq_ctrl, tid, prxcache->tid_rxseq[tid]));
-
+		if (seq_ctrl == prxcache->tid_rxseq[tid])
 			return _FAIL;
-		}
 	}
 
 	prxcache->tid_rxseq[tid] = seq_ctrl;
@@ -746,7 +674,6 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA==myself\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -767,7 +694,6 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		/*  For Station mode, sa and bssid should always be BSSID, and DA is my mac-address */
 		if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("bssid!=TA under STATION_MODE; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -806,7 +732,6 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
 
 	if (*psta == NULL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under sta2sta_data_frame ; drop pkt\n"));
 		if (adapter->registrypriv.mp_mode == 1) {
 			if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == true)
 			adapter->mppriv.rx_pktloss++;
@@ -839,15 +764,12 @@ static int ap2sta_data_frame (
 	    check_fwstate(pmlmepriv, _FW_UNDER_LINKING))) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA==myself\n"));
 			ret = _FAIL;
 			goto exit;
 		}
 
 		/*  da should be for me */
 		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				 (" ap2sta_data_frame:  compare DA fail; DA=%pM\n", (pattrib->dst)));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -856,10 +778,6 @@ static int ap2sta_data_frame (
 		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		    !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				 (" ap2sta_data_frame:  compare BSSID fail ; BSSID=%pM\n", (pattrib->bssid)));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid=%pM\n", (mybssid)));
-
 			if (!bmcast) {
 				DBG_88E("issue_deauth to the nonassociated ap=%pM for the reason(7)\n", (pattrib->bssid));
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -875,7 +793,6 @@ static int ap2sta_data_frame (
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
 		if (*psta == NULL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -902,7 +819,6 @@ static int ap2sta_data_frame (
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 		if (*psta == NULL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -948,7 +864,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (*psta == NULL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
 			DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -1116,13 +1031,9 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 {
 	struct sta_info *psta;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+validate_recv_mgnt_frame\n"));
-
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
-	if (precv_frame == NULL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s: fragment packet\n", __func__));
+	if (precv_frame == NULL)
 		return _SUCCESS;
-	}
 
 	/* for rx pkt statistics */
 	psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(precv_frame->rx_data));
@@ -1194,7 +1105,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		memcpy(pattrib->ra, GetAddr1Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
 		ret = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" case 3\n"));
 		break;
 	default:
 		ret = _FAIL;
@@ -1208,7 +1118,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	}
 
 	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta==NULL\n"));
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1240,19 +1149,13 @@ static int validate_recv_data_frame(struct adapter *adapter,
 
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decache : drop pkt\n"));
 		ret = _FAIL;
 		goto exit;
 	}
 
 	if (pattrib->privacy) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("validate_recv_data_frame:pattrib->privacy=%x\n", pattrib->privacy));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^IS_MCAST(pattrib->ra(0x%02x))=%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], IS_MCAST(pattrib->ra)));
-
 		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, IS_MCAST(pattrib->ra));
 
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n pattrib->encrypt=%d\n", pattrib->encrypt));
-
 		SET_ICE_IV_LEN(pattrib->iv_len, pattrib->icv_len, pattrib->encrypt);
 	} else {
 		pattrib->encrypt = 0;
@@ -1288,7 +1191,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 	/* add version chk */
 	if (ver != 0) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! (ver!=0)\n"));
 		retval = _FAIL;
 		goto exit;
 	}
@@ -1340,15 +1242,11 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	}
 	switch (type) {
 	case WIFI_MGT_TYPE: /* mgnt */
-		retval = validate_recv_mgnt_frame(adapter, precv_frame);
-		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_mgnt_frame fail\n"));
+		validate_recv_mgnt_frame(adapter, precv_frame);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_CTRL_TYPE: /* ctrl */
-		retval = validate_recv_ctrl_frame(adapter, precv_frame);
-		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_ctrl_frame fail\n"));
+		validate_recv_ctrl_frame(adapter, precv_frame);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_DATA_TYPE: /* data */
@@ -1361,7 +1259,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 		}
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! type= 0x%x\n", type));
 		retval = _FAIL;
 		break;
 	}
@@ -1409,9 +1306,6 @@ static int wlanhdr_to_ethhdr (struct recv_frame *precvframe)
 	rmv_len = pattrib->hdrlen + pattrib->iv_len + (bsnaphdr ? SNAP_SIZE : 0);
 	len = precvframe->len - rmv_len;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-		 ("\n===pattrib->hdrlen: %x,  pattrib->iv_len:%x===\n\n", pattrib->hdrlen,  pattrib->iv_len));
-
 	memcpy(&be_tmp, ptr+rmv_len, 2);
 	eth_type = ntohs(be_tmp); /* pattrib->ether_type */
 	pattrib->eth_type = eth_type;
@@ -1517,8 +1411,6 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter, struct __que
 	/* free the defrag_q queue and return the prframe */
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Performance defrag!!!!!\n"));
-
 	return prframe;
 }
 
@@ -1579,15 +1471,12 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 			phead = get_list_head(pdefrag_q);
 			list_add_tail(&pfhdr->list, phead);
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueuq: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
-
 			prtnframe = NULL;
 		} else {
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			if (precv_frame && pfree_recv_queue)
 				rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q==NULL: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 		}
 	}
 
@@ -1599,7 +1488,6 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 			list_add_tail(&pfhdr->list, phead);
 
 			/* call recvframe_defrag to defrag */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("defrag: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 			precv_frame = recvframe_defrag(padapter, pdefrag_q);
 			prtnframe = precv_frame;
 		} else {
@@ -1607,14 +1495,12 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 			if (precv_frame && pfree_recv_queue)
 				rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q==NULL: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 		}
 	}
 
 	if ((prtnframe != NULL) && (prtnframe->attrib.privacy)) {
 		/* after defrag we must check tkip mic code */
 		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe)==_FAIL\n"));
 			if (precv_frame && pfree_recv_queue)
 				rtw_free_recvframe(prtnframe, pfree_recv_queue);
 			prtnframe = NULL;
@@ -1831,9 +1717,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 		pattrib = &prframe->attrib;
 
 		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-				 ("recv_indicatepkts_in_order: indicate=%d seq=%d amsdu=%d\n",
-				  preorder_ctrl->indicate_seq, pattrib->seq_num, pattrib->amsdu));
 			plist = plist->next;
 			list_del_init(&(prframe->list));
 
@@ -1878,9 +1761,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 		if (pattrib->qos != 1) {
 			if (!padapter->bDriverStopped &&
 			    !padapter->bSurpriseRemoved) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-					 ("@@@@  recv_indicatepkt_reorder -recv_func recv_indicatepkt\n"));
-
 				rtw_recv_indicatepkt(padapter, prframe);
 				return _SUCCESS;
 			}
@@ -1908,10 +1788,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-		 ("recv_indicatepkt_reorder: indicate=%d seq=%d\n",
-		  preorder_ctrl->indicate_seq, pattrib->seq_num));
-
 	/* s2. check if winstart_b(indicate_seq) needs to been updated */
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num))
 		goto _err_exit;
@@ -1988,20 +1864,14 @@ static int process_recv_indicatepkts(struct adapter *padapter, struct recv_frame
 		}
 	} else { /* B/G mode */
 		retval = wlanhdr_to_ethhdr (prframe);
-		if (retval != _SUCCESS) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("wlanhdr_to_ethhdr: drop pkt\n"));
+		if (retval != _SUCCESS)
 			return retval;
-		}
 
 		if ((!padapter->bDriverStopped) &&
 		    (!padapter->bSurpriseRemoved)) {
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
@@ -2024,7 +1894,6 @@ static int recv_func_prehandle(struct adapter *padapter, struct recv_frame *rfra
 			padapter->mppriv.rx_pktcount++;
 
 		if (check_fwstate(pmlmepriv, WIFI_MP_LPBK_STATE) == false) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_alert_, ("MP - Not in loopback mode , drop pkt\n"));
 			ret = _FAIL;
 			rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
 			goto exit;
@@ -2034,7 +1903,6 @@ static int recv_func_prehandle(struct adapter *padapter, struct recv_frame *rfra
 	/* check the frame crtl field and decache */
 	ret = validate_recv_frame(padapter, rframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recv_func: validate_recv_frame fail! drop pkt\n"));
 		rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
 		goto exit;
 	}
@@ -2055,20 +1923,16 @@ static int recv_func_posthandle(struct adapter *padapter, struct recv_frame *prf
 
 	prframe = decryptor(padapter, prframe);
 	if (prframe == NULL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
-	if (prframe == NULL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
+	if (prframe == NULL)
 		goto _recv_data_drop;
-	}
 
 	prframe = portctrl(padapter, prframe);
 	if (prframe == NULL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
@@ -2077,7 +1941,6 @@ static int recv_func_posthandle(struct adapter *padapter, struct recv_frame *prf
 
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recv_func: process_recv_indicatepkts fail!\n"));
 		rtw_free_recvframe(orig_prframe, pfree_recv_queue);/* free this recv_frame */
 		goto _recv_data_drop;
 	}
@@ -2149,10 +2012,8 @@ s32 rtw_recv_entry(struct recv_frame *precvframe)
 	precvpriv = &padapter->recvpriv;
 
 	ret = recv_func(padapter, precvframe);
-	if (ret == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("rtw_recv_entry: recv_func return fail!!!\n"));
+	if (ret == _FAIL)
 		goto _recv_entry_drop;
-	}
 
 	precvpriv->rx_pkts++;
 
-- 
2.31.1

