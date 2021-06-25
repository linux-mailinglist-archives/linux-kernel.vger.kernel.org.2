Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731883B39FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhFYALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhFYAKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:42 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97346C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e1so5342566qkm.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMDavr/85NrY4OjoGVn9/3qSe5RPSjgBVLzGYRuXc8E=;
        b=A9wf50MMgLL3Rdm1NuoiV6krK2nO5KntgGGwZzFtF+oNAyqw0yM08jZK3VhXW+1Wuv
         5bZrkKBwR2N83lIkvZWjiTbNrMGDXzM6kHozvJoc8lkIULhOl85LOChrhLpclx/Q2mtC
         yIlCnOhFWSOdHYC9XABOodXrEMKevU+rAW2VGWB/qE3N530tqg8G2HcVhssK+MhNXWLB
         FnfBQm9S00TLlCeovw1Qi7n9soIdN/cdoLL2tjXRbaE/zfi7KrLdEee8l7ca3Jq6wpVo
         0nIpIsQ7sSBqjeStmkPzKNkomWYj2CYpQmJZK/HltUvAbU2mxRf5B8xHNglNIferVIl5
         xQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMDavr/85NrY4OjoGVn9/3qSe5RPSjgBVLzGYRuXc8E=;
        b=R2b609/ROLfqI7tUcjjWMCutNbvcpRf4RWNIByVHNKoYDTNfZjxmM9PgqDLC1Fa68V
         ZKFCnmWse/bVWNzIhp5IOPVWHDIw3mlVjgcl85ceBbnwb7i+JOKnLVKBVeOpcvyzZR91
         yJDfBrjoO4pPnRuE0zKJ0iPaS6BDOZ49pMgoPyOW6O/rtJ+2HAu2AOXtp/AMr9ZF7DAK
         n3vbjOxNHzZ97aHSPmCC5/VI6owEqDa5uKibcsJXGbZSPtIn9C/OtBoeQjXAYqMbjgq2
         Dfj4nliq2R4Wf1r0XTO3RXz0CIvLyWsboeTZw5D/D48GQYa+Vb1uy4ZchNZN6BjaF4x5
         SCpw==
X-Gm-Message-State: AOAM530+OOgeO8wYOtdnCNcyrbL+Gr/gpR0mAIQk3ZxybREzn2fQxwo8
        xU0H/1WD92XfiyWtyq7zDw/wD7L7w0Oahw==
X-Google-Smtp-Source: ABdhPJz27lOL49BjZbORd9/lnybhlDu1DWYxBpZukHF3UhaqrIZzpDB+KP2BTRAw69RMwZAsAHfGrA==
X-Received: by 2002:a37:dc04:: with SMTP id v4mr8623550qki.130.1624579701712;
        Thu, 24 Jun 2021 17:08:21 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:21 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 14/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_recv.c
Date:   Fri, 25 Jun 2021 01:07:47 +0100
Message-Id: <20210625000756.6313-15-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_recv.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 192 ++--------------------
 1 file changed, 13 insertions(+), 179 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index fa3ee18a31a1..5941db901dd8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -214,30 +214,16 @@ static int recvframe_chkmic(struct adapter *adapter,
 	stainfo = rtw_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
 
 	if (prxattrib->encrypt == _TKIP_) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-			 ("\n %s: prxattrib->encrypt==_TKIP_\n", __func__));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-			 ("\n %s: da=0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-			  __func__, prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
-			  prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
-
 		/* calculate mic code */
 		if (stainfo) {
 			if (is_multicast_ether_addr(prxattrib->ra)) {
 				if (!psecuritypriv) {
 					res = _FAIL;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-						 ("\n %s: didn't install group key!!!!!!!!!!\n", __func__));
 					goto exit;
 				}
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
-
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-					 ("\n %s: bcmc key\n", __func__));
 			} else {
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("\n %s: unicast key\n", __func__));
 			}
 
 			/* icv_len included the mic code */
@@ -246,7 +232,6 @@ static int recvframe_chkmic(struct adapter *adapter,
 			pframe = precvframe->pkt->data;
 			payload = pframe + prxattrib->hdrlen + prxattrib->iv_len;
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n prxattrib->iv_len=%d prxattrib->icv_len=%d\n", prxattrib->iv_len, prxattrib->icv_len));
 			rtw_seccalctkipmic(mickey, pframe, payload, datalen, &miccode[0],
 					   (unsigned char)prxattrib->priority); /* care the length of the data */
 
@@ -255,81 +240,25 @@ static int recvframe_chkmic(struct adapter *adapter,
 			bmic_err = false;
 
 			for (i = 0; i < 8; i++) {
-				if (miccode[i] != *(pframemic + i)) {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-						 ("%s: miccode[%d](%02x)!=*(pframemic+%d)(%02x) ",
-						  __func__, i, miccode[i], i, *(pframemic + i)));
+				if (miccode[i] != *(pframemic + i))
 					bmic_err = true;
-				}
 			}
 
 			if (bmic_err) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("\n *(pframemic-8)-*(pframemic-1)=0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					 *(pframemic - 8), *(pframemic - 7), *(pframemic - 6),
-					 *(pframemic - 5), *(pframemic - 4), *(pframemic - 3),
-					 *(pframemic - 2), *(pframemic - 1)));
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("\n *(pframemic-16)-*(pframemic-9)=0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					 *(pframemic - 16), *(pframemic - 15), *(pframemic - 14),
-					 *(pframemic - 13), *(pframemic - 12), *(pframemic - 11),
-					 *(pframemic - 10), *(pframemic - 9)));
-				{
-					uint i;
-
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-						 ("\n ======demp packet (len=%d)======\n",
-						 precvframe->pkt->len));
-					for (i = 0; i < precvframe->pkt->len; i += 8) {
-						RT_TRACE(_module_rtl871x_recv_c_,
-							 _drv_err_,
-							 ("0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x",
-							 *(precvframe->pkt->data + i),
-							 *(precvframe->pkt->data + i + 1),
-							 *(precvframe->pkt->data + i + 2),
-							 *(precvframe->pkt->data + i + 3),
-							 *(precvframe->pkt->data + i + 4),
-							 *(precvframe->pkt->data + i + 5),
-							 *(precvframe->pkt->data + i + 6),
-							 *(precvframe->pkt->data + i + 7)));
-					}
-					RT_TRACE(_module_rtl871x_recv_c_,
-						 _drv_err_,
-						 ("\n ====== demp packet end [len=%d]======\n",
-						 precvframe->pkt->len));
-					RT_TRACE(_module_rtl871x_recv_c_,
-						 _drv_err_,
-						 ("\n hrdlen=%d,\n",
-						 prxattrib->hdrlen));
-				}
-
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					 ("ra=0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x psecuritypriv->binstallGrpkey=%d ",
-					 prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
-					 prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5], psecuritypriv->binstallGrpkey));
-
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
 				if (is_multicast_ether_addr(prxattrib->ra) && prxattrib->key_index != pmlmeinfo->key_index)
 					brpt_micerror = false;
 
-				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
+				if ((prxattrib->bdecrypted) && (brpt_micerror))
 					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
-				} else {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
-				}
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
-				if (!psecuritypriv->bcheck_grpkey && is_multicast_ether_addr(prxattrib->ra)) {
+				if (!psecuritypriv->bcheck_grpkey &&
+				    is_multicast_ether_addr(prxattrib->ra))
 					psecuritypriv->bcheck_grpkey = true;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("psecuritypriv->bcheck_grpkey = true"));
-				}
 			}
-		} else {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-				 ("%s: rtw_get_stainfo==NULL!!!\n", __func__));
 		}
 
 		skb_trim(precvframe->pkt, precvframe->pkt->len - 8);
@@ -349,8 +278,6 @@ static struct recv_frame *decryptor(struct adapter *padapter,
 	struct recv_frame *return_packet = precv_frame;
 	u32	 res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("prxstat->decrypted=%x prxattrib->encrypt=0x%03x\n", prxattrib->bdecrypted, prxattrib->encrypt));
-
 	if (prxattrib->encrypt > 0) {
 		u8 *iv = precv_frame->pkt->data + prxattrib->hdrlen;
 
@@ -427,8 +354,6 @@ static struct recv_frame *portctrl(struct adapter *adapter,
 
 	prtnframe = NULL;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########%s:adapter->securitypriv.dot11AuthAlgrthm=%d\n", __func__, adapter->securitypriv.dot11AuthAlgrthm));
-
 	if (auth_alg == 2) {
 		/* get ether_type */
 		ptr = ptr + pfhdr->attrib.hdrlen + LLC_HEADER_SIZE + pfhdr->attrib.iv_len;
@@ -438,8 +363,6 @@ static struct recv_frame *portctrl(struct adapter *adapter,
 		if (psta && (psta->ieee8021x_blocked)) {
 			/* blocked */
 			/* only accept EAPOL frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########%s:psta->ieee8021x_blocked==1\n", __func__));
-
 			if (ether_type == eapol_type) {
 				prtnframe = precv_frame;
 			} else {
@@ -450,24 +373,11 @@ static struct recv_frame *portctrl(struct adapter *adapter,
 		} else {
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########%s:psta->ieee8021x_blocked==0\n", __func__));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				 ("%s:precv_frame->hdr.attrib.privacy=%x\n",
-				  __func__, precv_frame->attrib.privacy));
-
-			if (pattrib->bdecrypted == 0)
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("%s:prxstat->decrypted=%x\n", __func__, pattrib->bdecrypted));
-
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
-			if (ether_type == eapol_type) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("########%s:ether_type==0x888e\n", __func__));
+			if (ether_type == eapol_type)
 				/* check Rekey */
-
 				prtnframe = precv_frame;
-			} else {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########%s:ether_type=0x%04x\n", __func__, ether_type));
-			}
 		}
 	} else {
 		prtnframe = precv_frame;
@@ -484,19 +394,11 @@ static int recv_decache(struct recv_frame *precv_frame, u8 bretry,
 	u16 seq_ctrl = ((precv_frame->attrib.seq_num & 0xffff) << 4) |
 		(precv_frame->attrib.frag_num & 0xf);
 
-	if (tid > 15) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s, (tid>15)! seq_ctrl=0x%x, tid=0x%x\n", __func__, seq_ctrl, tid));
-
+	if (tid > 15)
 		return _FAIL;
-	}
-
-	if (1) {/* if (bretry) */
-		if (seq_ctrl == prxcache->tid_rxseq[tid]) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s, seq_ctrl=0x%x, tid=0x%x, tid_rxseq=0x%x\n", __func__, seq_ctrl, tid, prxcache->tid_rxseq[tid]));
 
-			return _FAIL;
-		}
-	}
+	if (seq_ctrl == prxcache->tid_rxseq[tid])
+		return _FAIL;
 
 	prxcache->tid_rxseq[tid] = seq_ctrl;
 
@@ -634,7 +536,6 @@ static int sta2sta_data_frame(struct adapter *adapter,
 	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA==myself\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -655,7 +556,6 @@ static int sta2sta_data_frame(struct adapter *adapter,
 	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		/*  For Station mode, sa and bssid should always be BSSID, and DA is my mac-address */
 		if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("bssid!=TA under STATION_MODE; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -686,7 +586,6 @@ static int sta2sta_data_frame(struct adapter *adapter,
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
 
 	if (!*psta) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under %s ; drop pkt\n", __func__));
 		ret = _FAIL;
 		goto exit;
 	}
@@ -713,15 +612,12 @@ static int ap2sta_data_frame(struct adapter *adapter,
 	     check_fwstate(pmlmepriv, _FW_UNDER_LINKING))) {
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA==myself\n"));
 			ret = _FAIL;
 			goto exit;
 		}
 
 		/*  da should be for me */
 		if (memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !mcast) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				 (" %s:  compare DA fail; DA=%pM\n", __func__, (pattrib->dst)));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -730,10 +626,6 @@ static int ap2sta_data_frame(struct adapter *adapter,
 		if (is_zero_ether_addr(pattrib->bssid) ||
 		    is_zero_ether_addr(mybssid) ||
 		    (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				 (" %s:  compare BSSID fail ; BSSID=%pM\n", __func__, (pattrib->bssid)));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid=%pM\n", (mybssid)));
-
 			if (!mcast)
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
@@ -747,7 +639,6 @@ static int ap2sta_data_frame(struct adapter *adapter,
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
 		}
@@ -800,8 +691,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
-
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
 			ret = RTW_RX_HANDLED;
@@ -964,14 +853,9 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 {
 	struct sta_info *psta;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+%s\n", __func__));
-
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
-	if (!precv_frame) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-			 ("%s: fragment packet\n", __func__));
+	if (!precv_frame)
 		return _SUCCESS;
-	}
 
 	/* for rx pkt statistics */
 	psta = rtw_get_stainfo(&padapter->stapriv,
@@ -1044,7 +928,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		memcpy(pattrib->ra, GetAddr1Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
 		ret = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" case 3\n"));
 		break;
 	default:
 		ret = _FAIL;
@@ -1057,7 +940,6 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		goto exit;
 
 	if (!psta) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta==NULL\n"));
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1089,19 +971,12 @@ static int validate_recv_data_frame(struct adapter *adapter,
 
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decache : drop pkt\n"));
 		ret = _FAIL;
 		goto exit;
 	}
 
 	if (pattrib->privacy) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("%s:pattrib->privacy=%x\n", __func__, pattrib->privacy));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^is_multicast_ether_addr(pattrib->ra(0x%02x))=%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], is_multicast_ether_addr(pattrib->ra)));
-
 		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, is_multicast_ether_addr(pattrib->ra));
-
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n pattrib->encrypt=%d\n", pattrib->encrypt));
-
 		SET_ICE_IV_LEN(pattrib->iv_len, pattrib->icv_len, pattrib->encrypt);
 	} else {
 		pattrib->encrypt = 0;
@@ -1139,7 +1014,6 @@ static int validate_recv_frame(struct adapter *adapter,
 
 	/* add version chk */
 	if (ver != 0) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! (ver!=0)\n"));
 		retval = _FAIL;
 		goto exit;
 	}
@@ -1185,14 +1059,10 @@ static int validate_recv_frame(struct adapter *adapter,
 	switch (type) {
 	case WIFI_MGT_TYPE: /* mgnt */
 		retval = validate_recv_mgnt_frame(adapter, precv_frame);
-		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_mgnt_frame fail\n"));
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_CTRL_TYPE: /* ctrl */
 		retval = validate_recv_ctrl_frame(adapter, precv_frame);
-		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_ctrl_frame fail\n"));
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_DATA_TYPE: /* data */
@@ -1206,7 +1076,6 @@ static int validate_recv_frame(struct adapter *adapter,
 		}
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! type= 0x%x\n", type));
 		retval = _FAIL;
 		break;
 	}
@@ -1263,9 +1132,6 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 	rmv_len = pattrib->hdrlen + pattrib->iv_len + (bsnaphdr ? SNAP_SIZE : 0);
 	len = precvframe->pkt->len - rmv_len;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-		 ("\n===pattrib->hdrlen: %x,  pattrib->iv_len:%x===\n\n", pattrib->hdrlen,  pattrib->iv_len));
-
 	memcpy(&be_tmp, ptr + rmv_len, 2);
 	eth_type = ntohs(be_tmp); /* pattrib->ether_type */
 	pattrib->eth_type = eth_type;
@@ -1354,8 +1220,6 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
 	/* free the defrag_q queue and return the prframe */
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Performance defrag!!!!!\n"));
-
 	return prframe;
 }
 
@@ -1417,14 +1281,11 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter,
 			phead = get_list_head(pdefrag_q);
 			list_add_tail(&pfhdr->list, phead);
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueuq: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
-
 			prtnframe = NULL;
 		} else {
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q==NULL: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 		}
 	}
 
@@ -1436,21 +1297,18 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter,
 			list_add_tail(&pfhdr->list, phead);
 
 			/* call recvframe_defrag to defrag */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("defrag: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 			precv_frame = recvframe_defrag(padapter, pdefrag_q);
 			prtnframe = precv_frame;
 		} else {
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q==NULL: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 		}
 	}
 
 	if (prtnframe && (prtnframe->attrib.privacy)) {
 		/* after defrag we must check tkip mic code */
 		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe)==_FAIL\n"));
 			rtw_free_recvframe(prtnframe, pfree_recv_queue);
 			prtnframe = NULL;
 		}
@@ -1649,9 +1507,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 		pattrib = &prframe->attrib;
 
 		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-				 ("%s: indicate=%d seq=%d amsdu=%d\n",
-				  __func__, preorder_ctrl->indicate_seq, pattrib->seq_num, pattrib->amsdu));
 			plist = plist->next;
 			list_del_init(&prframe->list);
 
@@ -1698,8 +1553,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter,
 		    (pattrib->ack_policy != 0)) {
 			if ((!padapter->bDriverStopped) &&
 			    (!padapter->bSurpriseRemoved)) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@  %s -recv_func recv_indicatepkt\n", __func__));
-
 				rtw_recv_indicatepkt(padapter, prframe);
 				return _SUCCESS;
 			}
@@ -1729,10 +1582,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter,
 
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-		 ("%s: indicate=%d seq=%d\n", __func__,
-		  preorder_ctrl->indicate_seq, pattrib->seq_num));
-
 	/* s2. check if winstart_b(indicate_seq) needs to been updated */
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
 		rtw_recv_indicatepkt(padapter, prframe);
@@ -1813,22 +1662,15 @@ static int process_recv_indicatepkts(struct adapter *padapter,
 		}
 	} else { /* B/G mode */
 		retval = wlanhdr_to_ethhdr(prframe);
-		if (retval != _SUCCESS) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("wlanhdr_to_ethhdr: drop pkt\n"));
+		if (retval != _SUCCESS)
 			return retval;
-		}
 
 		if ((!padapter->bDriverStopped) &&
-		    (!padapter->bSurpriseRemoved)) {
+		    (!padapter->bSurpriseRemoved))
 			/* indicate this recv_frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ %s- recv_func recv_indicatepkt\n", __func__));
 			rtw_recv_indicatepkt(padapter, prframe);
-		} else {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ %s- recv_func free_indicatepkt\n", __func__));
-
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_func:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
+		else
 			return _FAIL;
-		}
 	}
 
 	return retval;
@@ -1843,7 +1685,6 @@ static int recv_func_prehandle(struct adapter *padapter,
 	/* check the frame crtl field and decache */
 	ret = validate_recv_frame(padapter, rframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recv_func: validate_recv_frame fail! drop pkt\n"));
 		rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
 		goto exit;
 	}
@@ -1865,20 +1706,16 @@ static int recv_func_posthandle(struct adapter *padapter,
 
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
-	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
+	if (!prframe)
 		goto _recv_data_drop;
-	}
 
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
@@ -1887,7 +1724,6 @@ static int recv_func_posthandle(struct adapter *padapter,
 
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recv_func: process_recv_indicatepkts fail!\n"));
 		rtw_free_recvframe(orig_prframe, pfree_recv_queue);/* free this recv_frame */
 		goto _recv_data_drop;
 	}
@@ -1943,8 +1779,6 @@ int rtw_recv_entry(struct recv_frame *precvframe)
 	ret = recv_func(padapter, precvframe);
 	if (ret == _SUCCESS)
 		precvpriv->rx_pkts++;
-	else
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("%s: recv_func return fail!!!\n", __func__));
 
 	return ret;
 }
-- 
2.31.1

