Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78434FD29
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhCaJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhCaJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so21504272edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHXUWYpzKupYdvcn2nB8AuCEsO03J/qudW7wBLBG2qU=;
        b=qgKRDIBXcBdAIvL21/W/HlBsXJxla7Oi2lIeN4oPuVR2VfH7ZJkK3OUTkGeqg2GpU2
         f0Ebo9TwQ+PI1H2IaYW6Aytwp3uoQoVarvHkepuItPrubS1A9VTy866Y7tt7X8/1qC01
         8raOjFFwGZocKNZua6a8hqCkQcswNnVpS80JBwc6+TprF9qpRiDhol4PqcW87bsY/yzD
         Kr9Vrfza1HXhflt+EfA4J9efVZXvFsb8Z+YsvIDSH6ykDdz159/pK8EWFRA8ru3exwri
         z9DP3VfNgBvCNOqurKplhE/9Q7T7g+czYSgrUao/Ub+ywuUlnmXg4zRFqGesGSCwwAcp
         IOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHXUWYpzKupYdvcn2nB8AuCEsO03J/qudW7wBLBG2qU=;
        b=t8J4oV8oKZiG8f6XgAPsXSeWMZgbFLWnC7so2vCr+me9Hi2ZpQDrP1NH9nlqMmU41R
         UZkMVd8U0LiDPiYGYVdIm9d5kvu3vLX2wsoel/85Et8lpDoXg1s1OCHy6jlucDunxmP5
         1lvX560nqKJdmq+S/KXOAp+/fp0CygUEr4ASEGyxUOvDTyLrEszv4anhTGD9tctstYLD
         stQ/lHuKJUpVLRvDOfj4g6Cdd8GPpUSBQMHagGAWatVfMJYio8yYpoxvOixbW5XuMrZ1
         bqdB+Yf9zXAas7Drq+zEo1/aU/V+xadwXc99PfqDXywQ+CWQJ7jTRjFEhGxI+8RTZicm
         Ks+Q==
X-Gm-Message-State: AOAM530k27GY8r3QLz7lXbZyZpgneJVCyWQVk/O+4fQgByd5T5aoRrXz
        LJ1v5UC2ZyXGjCpCNTAtr0E=
X-Google-Smtp-Source: ABdhPJzto6zVkjrCpGIJhF7vL67g8U/VRSWzpb7gvhYHSBpwwkG2Hi9tqjH5A9Tn91YqZtZgnxPnWQ==
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr2602626edv.336.1617183630745;
        Wed, 31 Mar 2021 02:40:30 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id h22sm824054eji.80.2021.03.31.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_recv.c
Date:   Wed, 31 Mar 2021 11:39:38 +0200
Message-Id: <280f5fcbfb7a90547932bf6dc2570385c6bbaa21.1617183374.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_recv.c | 240 ++++++++++++++--------
 1 file changed, 157 insertions(+), 83 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 189f686a1f29..5b5fca291b99 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -325,9 +325,16 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 	stainfo = rtw_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
 
 	if (prxattrib->encrypt == _TKIP_) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:prxattrib->encrypt == _TKIP_\n"));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic:da = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-			prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2], prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
+		pr_info("%s %s:prxattrib->encrypt == _TKIP_\n", DRIVER_PREFIX,
+			__func__);
+		pr_info("%s %s:da = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
+			DRIVER_PREFIX, __func__,
+			prxattrib->ra[0],
+			prxattrib->ra[1],
+			prxattrib->ra[2],
+			prxattrib->ra[3],
+			prxattrib->ra[4],
+			prxattrib->ra[5]);
 
 		/* calculate mic code */
 		if (stainfo) {
@@ -337,26 +344,28 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				/* rxdata_key_idx =(((iv[3])>>6)&0x3) ; */
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
 
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n recvframe_chkmic: bcmc key\n"));
+				pr_info("%s %s: bcmc key\n", DRIVER_PREFIX, __func__);
 				/* DBG_871X("\n recvframe_chkmic: bcmc key psecuritypriv->dot118021XGrpKeyid(%d), pmlmeinfo->key_index(%d) , recv key_id(%d)\n", */
 				/* psecuritypriv->dot118021XGrpKeyid, pmlmeinfo->key_index, rxdata_key_idx); */
 
 				if (psecuritypriv->binstallGrpkey == false) {
 					res = _FAIL;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n"));
+					pr_err("%s %s:didn't install group key!!!!!!!!!!\n",
+					       DRIVER_PREFIX, __func__);
 					DBG_871X("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 			} else {
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n recvframe_chkmic: unicast key\n"));
+				pr_err("%s %s: unicast key\n", DRIVER_PREFIX, __func__);
 			}
 
 			datalen = precvframe->u.hdr.len-prxattrib->hdrlen-prxattrib->iv_len-prxattrib->icv_len-8;/* icv_len included the mic code */
 			pframe = precvframe->u.hdr.rx_data;
 			payload = pframe+prxattrib->hdrlen+prxattrib->iv_len;
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n prxattrib->iv_len =%d prxattrib->icv_len =%d\n", prxattrib->iv_len, prxattrib->icv_len));
+			pr_info("%s prxattrib->iv_len =%d prxattrib->icv_len =%d\n",
+				DRIVER_PREFIX, prxattrib->iv_len, prxattrib->icv_len);
 
 
 			rtw_seccalctkipmic(mickey, pframe, payload, datalen, &miccode[0], (unsigned char)prxattrib->priority); /* care the length of the data */
@@ -367,7 +376,9 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			for (i = 0; i < 8; i++) {
 				if (miccode[i] != *(pframemic+i)) {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic:miccode[%d](%02x) != *(pframemic+%d)(%02x) ", i, miccode[i], i, *(pframemic+i)));
+					pr_err("%s %s:miccode[%d](%02x) != *(pframemic+%d)(%02x) ",
+					       DRIVER_PREFIX, __func__, i, miccode[i], i,
+					       *(pframemic+i));
 					bmic_err = true;
 				}
 			}
@@ -375,28 +386,58 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			if (bmic_err == true) {
 
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n *(pframemic-8)-*(pframemic-1) = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					*(pframemic-8), *(pframemic-7), *(pframemic-6), *(pframemic-5), *(pframemic-4), *(pframemic-3), *(pframemic-2), *(pframemic-1)));
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n *(pframemic-16)-*(pframemic-9) = 0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
-					*(pframemic-16), *(pframemic-15), *(pframemic-14), *(pframemic-13), *(pframemic-12), *(pframemic-11), *(pframemic-10), *(pframemic-9)));
+				pr_err("%s *(pframemic-8)-*(pframemic-1) = "
+				       "0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
+				       DRIVER_PREFIX,
+				       *(pframemic-8),
+				       *(pframemic-7),
+				       *(pframemic-6),
+				       *(pframemic-5),
+				       *(pframemic-4),
+				       *(pframemic-3),
+				       *(pframemic-2),
+				       *(pframemic-1));
+
+				pr_err("%s *(pframemic-16)-*(pframemic-9) = "
+				       "0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x\n",
+				       DRIVER_PREFIX,
+				       *(pframemic-16),
+				       *(pframemic-15),
+				       *(pframemic-14),
+				       *(pframemic-13),
+				       *(pframemic-12),
+				       *(pframemic-11),
+				       *(pframemic-10),
+				       *(pframemic-9));
 
 				{
 					uint i;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet (len =%d) ======\n", precvframe->u.hdr.len));
+					pr_err("%s ======demp packet (len =%d) ======\n",
+					       DRIVER_PREFIX, precvframe->u.hdr.len);
 					for (i = 0; i < precvframe->u.hdr.len; i = i+8) {
-						RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x",
-							*(precvframe->u.hdr.rx_data+i), *(precvframe->u.hdr.rx_data+i+1),
-							*(precvframe->u.hdr.rx_data+i+2), *(precvframe->u.hdr.rx_data+i+3),
-							*(precvframe->u.hdr.rx_data+i+4), *(precvframe->u.hdr.rx_data+i+5),
-							*(precvframe->u.hdr.rx_data+i+6), *(precvframe->u.hdr.rx_data+i+7)));
+						pr_err("%s 0x%02x:0x%02x:0x%02x:0x%02x:"
+						       "0x%02x:0x%02x:0x%02x:0x%02x",
+						       DRIVER_PREFIX,
+						       *(precvframe->u.hdr.rx_data+i),
+						       *(precvframe->u.hdr.rx_data+i+1),
+						       *(precvframe->u.hdr.rx_data+i+2),
+						       *(precvframe->u.hdr.rx_data+i+3),
+						       *(precvframe->u.hdr.rx_data+i+4),
+						       *(precvframe->u.hdr.rx_data+i+5),
+						       *(precvframe->u.hdr.rx_data+i+6),
+						       *(precvframe->u.hdr.rx_data+i+7));
 					}
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet end [len =%d]======\n", precvframe->u.hdr.len));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n hrdlen =%d,\n", prxattrib->hdrlen));
+					pr_err("%s ======demp packet end [len =%d]======\n",
+					       DRIVER_PREFIX, precvframe->u.hdr.len);
+					pr_err("%s hrdlen =%d,\n",
+					       DRIVER_PREFIX, prxattrib->hdrlen);
 				}
 
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ra = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x psecuritypriv->binstallGrpkey =%d ",
-					prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
-					prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5], psecuritypriv->binstallGrpkey));
+				pr_err("%s ra = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x "
+				       "psecuritypriv->binstallGrpkey =%d ", DRIVER_PREFIX,
+				       prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2],
+				       prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5],
+				       psecuritypriv->binstallGrpkey);
 
 				/*  double check key_index for some timing issue , */
 				/*  cannot compare with psecuritypriv->dot118021XGrpKeyid also cause timing issue */
@@ -405,10 +446,12 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted =%d ", prxattrib->bdecrypted));
+					pr_err("%s mic error :prxattrib->bdecrypted =%d ",
+					       DRIVER_PREFIX, prxattrib->bdecrypted);
 					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
 				} else {
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted =%d ", prxattrib->bdecrypted));
+					pr_err("%s mic error :prxattrib->bdecrypted =%d ",
+					       DRIVER_PREFIX, prxattrib->bdecrypted);
 					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
 				}
 
@@ -418,12 +461,13 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				/* mic checked ok */
 				if ((psecuritypriv->bcheck_grpkey == false) && (IS_MCAST(prxattrib->ra) == true)) {
 					psecuritypriv->bcheck_grpkey = true;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("psecuritypriv->bcheck_grpkey =true"));
+					pr_err("%s psecuritypriv->bcheck_grpkey =true",
+					       DRIVER_PREFIX);
 				}
 			}
 
 		} else
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic: rtw_get_stainfo == NULL!!!\n"));
+			pr_err("%s %s: rtw_get_stainfo == NULL!!!\n", DRIVER_PREFIX, __func__);
 
 		recvframe_pull_tail(precvframe, 8);
 
@@ -443,7 +487,8 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 	union recv_frame *return_packet = precv_frame;
 	u32  res = _SUCCESS;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("prxstat->decrypted =%x prxattrib->encrypt = 0x%03x\n", prxattrib->bdecrypted, prxattrib->encrypt));
+	pr_info("%s prxstat->decrypted =%x prxattrib->encrypt = 0x%03x\n",
+		DRIVER_PREFIX, prxattrib->bdecrypted, prxattrib->encrypt);
 
 	if (prxattrib->encrypt > 0) {
 		u8 *iv = precv_frame->u.hdr.rx_data+prxattrib->hdrlen;
@@ -552,7 +597,8 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:adapter->securitypriv.dot11AuthAlgrthm =%d\n", adapter->securitypriv.dot11AuthAlgrthm));
+	pr_info("%s ########%s: adapter->securitypriv.dot11AuthAlgrthm =%d\n",
+		DRIVER_PREFIX, __func__, adapter->securitypriv.dot11AuthAlgrthm);
 
 	if (auth_alg == 2) {
 		if ((psta) && (psta->ieee8021x_blocked)) {
@@ -560,7 +606,8 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 			/* blocked */
 			/* only accept EAPOL frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked == 1\n"));
+			pr_info("%s ########%s: psta->ieee8021x_blocked == 1\n",
+				DRIVER_PREFIX, __func__);
 
 			prtnframe = precv_frame;
 
@@ -579,11 +626,14 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 		} else {
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked == 0\n"));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:precv_frame->hdr.attrib.privacy =%x\n", precv_frame->u.hdr.attrib.privacy));
+			pr_info("%s ########%s: psta->ieee8021x_blocked == 0\n",
+				DRIVER_PREFIX, __func__);
+			pr_info("%s %s: precv_frame->hdr.attrib.privacy =%x\n",
+				DRIVER_PREFIX, __func__, precv_frame->u.hdr.attrib.privacy);
 
 			if (pattrib->bdecrypted == 0)
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("portctrl:prxstat->decrypted =%x\n", pattrib->bdecrypted));
+				pr_info("%s %s:prxstat->decrypted =%x\n",
+					DRIVER_PREFIX, __func__, pattrib->bdecrypted);
 
 			prtnframe = precv_frame;
 			/* check is the EAPOL frame or not (Rekey) */
@@ -609,14 +659,16 @@ static signed int recv_decache(union recv_frame *precv_frame, u8 bretry, struct
 		(precv_frame->u.hdr.attrib.frag_num & 0xf);
 
 	if (tid > 15) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, (tid>15)! seq_ctrl = 0x%x, tid = 0x%x\n", seq_ctrl, tid));
+		pr_notice("%s %s, (tid>15)! seq_ctrl = 0x%x, tid = 0x%x\n",
+			  DRIVER_PREFIX, __func__, seq_ctrl, tid);
 
 		return _FAIL;
 	}
 
 	if (1) { /* if (bretry) */
 		if (seq_ctrl == prxcache->tid_rxseq[tid]) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_decache, seq_ctrl = 0x%x, tid = 0x%x, tid_rxseq = 0x%x\n", seq_ctrl, tid, prxcache->tid_rxseq[tid]));
+			pr_notice("%s %s, seq_ctrl = 0x%x, tid = 0x%x, tid_rxseq = 0x%x\n",
+				  DRIVER_PREFIX, __func__, seq_ctrl, tid, prxcache->tid_rxseq[tid]);
 
 			return _FAIL;
 		}
@@ -766,7 +818,7 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
+			pr_err("%s SA ==myself\n", DRIVER_PREFIX);
 			ret = _FAIL;
 			goto exit;
 		}
@@ -788,7 +840,8 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 		/*  For Station mode, sa and bssid should always be BSSID, and DA is my mac-address */
 		if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("bssid != TA under STATION_MODE; drop pkt\n"));
+			pr_err("%s bssid != TA under STATION_MODE; drop pkt\n",
+			       DRIVER_PREFIX);
 			ret = _FAIL;
 			goto exit;
 		}
@@ -830,7 +883,8 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
 
 	if (!*psta) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under sta2sta_data_frame ; drop pkt\n"));
+		pr_err("%s can't get psta under %s; drop pkt\n",
+		       DRIVER_PREFIX, __func__);
 		ret = _FAIL;
 		goto exit;
 	}
@@ -858,7 +912,7 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" SA ==myself\n"));
+			pr_err("%s SA ==myself\n", DRIVER_PREFIX);
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s SA =%pM, myhwaddr =%pM\n",
 				__func__, MAC_ARG(pattrib->src), MAC_ARG(myhwaddr));
@@ -869,8 +923,8 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		/*  da should be for me */
 		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				(" ap2sta_data_frame:  compare DA fail; DA =%pM\n", MAC_ARG(pattrib->dst)));
+			pr_info("%s %s:  compare DA fail; DA =%pM\n",
+				DRIVER_PREFIX, __func__, MAC_ARG(pattrib->dst));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s DA =%pM\n", __func__, MAC_ARG(pattrib->dst));
 			#endif
@@ -883,9 +937,9 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-				(" ap2sta_data_frame:  compare BSSID fail ; BSSID =%pM\n", MAC_ARG(pattrib->bssid)));
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("mybssid =%pM\n", MAC_ARG(mybssid)));
+			pr_info("%s %s:  compare BSSID fail ; BSSID =%pM\n",
+				DRIVER_PREFIX, __func__, MAC_ARG(pattrib->bssid));
+			pr_info("%s mybssid =%pM\n",DRIVER_PREFIX, MAC_ARG(mybssid));
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s BSSID =%pM, mybssid =%pM\n",
 				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
@@ -907,7 +961,8 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
+			pr_err("%s %s: can't get psta under STATION_MODE ; drop pkt\n",
+			       DRIVER_PREFIX, __func__);
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under STATION_MODE ; drop pkt\n", __func__);
 			#endif
@@ -936,7 +991,8 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
+			pr_err("%s can't get psta under MP_MODE ; drop pkt\n",
+			       DRIVER_PREFIX);
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under WIFI_MP_STATE ; drop pkt\n", __func__);
 			#endif
@@ -998,7 +1054,8 @@ static signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *p
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
+			pr_err("%s can't get psta under AP_MODE; drop pkt\n",
+			       DRIVER_PREFIX);
 			DBG_871X("issue_deauth to sta =%pM for the reason(7)\n", MAC_ARG(pattrib->src));
 
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -1245,7 +1302,7 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
 	/* free the defrag_q queue and return the prframe */
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Performance defrag!!!!!\n"));
+	pr_info("%s Performance defrag!!!!!\n", DRIVER_PREFIX);
 
 	return prframe;
 }
@@ -1306,7 +1363,8 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			list_add_tail(&pfhdr->list, phead);
 			/* spin_unlock(&pdefrag_q->lock); */
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueuq: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
+			pr_info("%s Enqueuq: ismfrag = %d, fragnum = %d\n",
+				DRIVER_PREFIX, ismfrag, fragnum);
 
 			prtnframe = NULL;
 
@@ -1314,7 +1372,8 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
+			pr_err("%s Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n",
+			       DRIVER_PREFIX, ismfrag, fragnum);
 		}
 
 	}
@@ -1329,7 +1388,8 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			/* spin_unlock(&pdefrag_q->lock); */
 
 			/* call recvframe_defrag to defrag */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("defrag: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
+			pr_info("%s defrag: ismfrag = %d, fragnum = %d\n",
+				DRIVER_PREFIX, ismfrag, fragnum);
 			precv_frame = recvframe_defrag(padapter, pdefrag_q);
 			prtnframe = precv_frame;
 
@@ -1337,7 +1397,8 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 			/* can't find this ta's defrag_queue, so free this recv_frame */
 			rtw_free_recvframe(precv_frame, pfree_recv_queue);
 			prtnframe = NULL;
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n", ismfrag, fragnum));
+			pr_err("%s Free because pdefrag_q == NULL: ismfrag = %d, fragnum = %d\n",
+			       DRIVER_PREFIX, ismfrag, fragnum);
 		}
 
 	}
@@ -1346,7 +1407,8 @@ static union recv_frame *recvframe_chk_defrag(struct adapter *padapter, union re
 	if ((prtnframe) && (prtnframe->u.hdr.attrib.privacy)) {
 		/* after defrag we must check tkip mic code */
 		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe) == _FAIL\n"));
+			pr_err("%s recvframe_chkmic(padapter,  prtnframe) == _FAIL\n",
+			       DRIVER_PREFIX);
 			rtw_free_recvframe(prtnframe, pfree_recv_queue);
 			prtnframe = NULL;
 		}
@@ -1358,11 +1420,12 @@ static signed int validate_recv_mgnt_frame(struct adapter *padapter, union recv_
 {
 	/* struct mlme_priv *pmlmepriv = &adapter->mlmepriv; */
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+validate_recv_mgnt_frame\n"));
+	pr_info("%s +%s\n", DRIVER_PREFIX, __func__);
 
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
 	if (!precv_frame) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s: fragment packet\n", __func__));
+		pr_notice("%s %s: fragment packet\n",
+			  DRIVER_PREFIX, __func__);
 		return _SUCCESS;
 	}
 
@@ -1444,7 +1507,7 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 		memcpy(pattrib->ra, GetAddr1Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
 		ret = _FAIL;
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" case 3\n"));
+		pr_err("%s case 3\n", DRIVER_PREFIX);
 		break;
 
 	default:
@@ -1464,7 +1527,7 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 
 	if (!psta) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta == NULL\n"));
+		pr_err("%s after to_fr_ds_chk; psta == NULL\n", DRIVER_PREFIX);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s psta == NULL\n", __func__);
 		#endif
@@ -1502,7 +1565,7 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decache : drop pkt\n"));
+		pr_err("%s decache : drop pkt\n", DRIVER_PREFIX);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s recv_decache return _FAIL\n", __func__);
 		#endif
@@ -1512,12 +1575,15 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	if (pattrib->privacy) {
 
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("validate_recv_data_frame:pattrib->privacy =%x\n", pattrib->privacy));
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ^^^^^^^^^^^IS_MCAST(pattrib->ra(0x%02x)) =%d^^^^^^^^^^^^^^^6\n", pattrib->ra[0], IS_MCAST(pattrib->ra)));
+		pr_info("%s %s:pattrib->privacy =%x\n",
+			DRIVER_PREFIX, __func__, pattrib->privacy);
+		pr_info("%s ^^^^^^^^^^^IS_MCAST(pattrib->ra(0x%02x)) "
+			"=%d^^^^^^^^^^^^^^^6\n",
+			DRIVER_PREFIX, pattrib->ra[0], IS_MCAST(pattrib->ra));
 
 		GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, IS_MCAST(pattrib->ra));
 
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n pattrib->encrypt =%d\n", pattrib->encrypt));
+		pr_info("%s pattrib->encrypt =%d\n", DRIVER_PREFIX, pattrib->encrypt);
 
 		SET_ICE_IV_LEN(pattrib->iv_len, pattrib->icv_len, pattrib->encrypt);
 	} else {
@@ -1642,7 +1708,7 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 
 	/* add version chk */
 	if (ver != 0) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! (ver!= 0)\n"));
+		pr_err("%s %s fail! (ver!= 0)\n", DRIVER_PREFIX, __func__);
 		retval = _FAIL;
 		goto exit;
 	}
@@ -1677,13 +1743,13 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 
 		retval = validate_recv_mgnt_frame(adapter, precv_frame);
 		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_mgnt_frame fail\n"));
+			pr_err("%s validate_recv_mgnt_frame fail\n", DRIVER_PREFIX);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_CTRL_TYPE: /* ctrl */
 		retval = validate_recv_ctrl_frame(adapter, precv_frame);
 		if (retval == _FAIL)
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_ctrl_frame fail\n"));
+			pr_err("%s validate_recv_ctrl_frame fail\n", DRIVER_PREFIX);
 		retval = _FAIL; /*  only data frame return _SUCCESS */
 		break;
 	case WIFI_DATA_TYPE: /* data */
@@ -1708,7 +1774,8 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 		}
 		break;
 	default:
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("validate_recv_data_frame fail! type = 0x%x\n", type));
+		pr_err("%s validate_recv_data_frame fail! type = 0x%x\n",
+		       DRIVER_PREFIX, type);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME validate_recv_data_frame fail! type = 0x%x\n", type);
 		#endif
@@ -1755,7 +1822,8 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	rmv_len = pattrib->hdrlen + pattrib->iv_len + (bsnaphdr?SNAP_SIZE:0);
 	len = precvframe->u.hdr.len - rmv_len;
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("\n ===pattrib->hdrlen: %x,  pattrib->iv_len:%x ===\n\n", pattrib->hdrlen,  pattrib->iv_len));
+	pr_info("%s ===pattrib->hdrlen: %x,  pattrib->iv_len:%x ===\n",
+		DRIVER_PREFIX, pattrib->hdrlen, pattrib->iv_len);
 
 	memcpy(&be_tmp, ptr+rmv_len, 2);
 	eth_type = ntohs(be_tmp); /* pattrib->ether_type */
@@ -2036,9 +2104,9 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 		pattrib = &prframe->u.hdr.attrib;
 
 		if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-				 ("recv_indicatepkts_in_order: indicate =%d seq =%d amsdu =%d\n",
-				  preorder_ctrl->indicate_seq, pattrib->seq_num, pattrib->amsdu));
+			pr_notice("%s %s: indicate =%d seq =%d amsdu =%d\n",
+				  DRIVER_PREFIX, __func__, preorder_ctrl->indicate_seq,
+				  pattrib->seq_num, pattrib->amsdu);
 
 			plist = get_next(plist);
 			list_del_init(&(prframe->u.hdr.list));
@@ -2110,7 +2178,8 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		if (pattrib->qos != 1) {
 			if ((padapter->bDriverStopped == false) &&
 			    (padapter->bSurpriseRemoved == false)) {
-				RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@  recv_indicatepkt_reorder -recv_func recv_indicatepkt\n"));
+				pr_notice("%s @@@@ %s -recv_func recv_indicatepkt\n",
+					  DRIVER_PREFIX, __func__);
 
 				rtw_recv_indicatepkt(padapter, prframe);
 				return _SUCCESS;
@@ -2171,9 +2240,9 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 
 	spin_lock_bh(&ppending_recvframe_queue->lock);
 
-	RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_,
-		 ("recv_indicatepkt_reorder: indicate =%d seq =%d\n",
-		  preorder_ctrl->indicate_seq, pattrib->seq_num));
+	pr_notice("%s %s: indicate =%d seq =%d\n",
+		  DRIVER_PREFIX, __func__, preorder_ctrl->indicate_seq,
+		  pattrib->seq_num);
 
 	/* s2. check if winstart_b(indicate_seq) needs to been updated */
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
@@ -2272,7 +2341,7 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 	} else { /* B/G mode */
 		retval = wlanhdr_to_ethhdr(prframe);
 		if (retval != _SUCCESS) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("wlanhdr_to_ethhdr: drop pkt\n"));
+			pr_err("%s wlanhdr_to_ethhdr: drop pkt\n", DRIVER_PREFIX);
 			#ifdef DBG_RX_DROP_FRAME
 			DBG_871X("DBG_RX_DROP_FRAME %s wlanhdr_to_ethhdr error!\n", __func__);
 			#endif
@@ -2281,14 +2350,18 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 
 		if ((padapter->bDriverStopped == false) && (padapter->bSurpriseRemoved == false)) {
 			/* indicate this recv_frame */
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ process_recv_indicatepkts- recv_func recv_indicatepkt\n"));
+			pr_notice("%s @@@@ %s- recv_func recv_indicatepkt\n",
+				  DRIVER_PREFIX, __func__);
 			rtw_recv_indicatepkt(padapter, prframe);
 
 
 		} else {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("@@@@ process_recv_indicatepkts- recv_func free_indicatepkt\n"));
+			pr_notice("%s @@@@ %s- recv_func free_indicatepkt\n",
+				  DRIVER_PREFIX, __func__);
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("recv_func:bDriverStopped(%d) OR bSurpriseRemoved(%d)", padapter->bDriverStopped, padapter->bSurpriseRemoved));
+			pr_notice("%s recv_func:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
+				  DRIVER_PREFIX, padapter->bDriverStopped,
+				  padapter->bSurpriseRemoved);
 			retval = _FAIL;
 			return retval;
 		}
@@ -2307,7 +2380,7 @@ static int recv_func_prehandle(struct adapter *padapter, union recv_frame *rfram
 	/* check the frame crtl field and decache */
 	ret = validate_recv_frame(padapter, rframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recv_func: validate_recv_frame fail! drop pkt\n"));
+		pr_info("%s recv_func: validate_recv_frame fail! drop pkt\n", DRIVER_PREFIX);
 		rtw_free_recvframe(rframe, pfree_recv_queue);/* free this recv_frame */
 		goto exit;
 	}
@@ -2325,7 +2398,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
+		pr_err("%s decryptor: drop pkt\n", DRIVER_PREFIX);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s decryptor: drop pkt\n", __func__);
 		#endif
@@ -2335,7 +2408,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
 	if (!prframe)	{
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
+		pr_err("%s recvframe_chk_defrag: drop pkt\n", DRIVER_PREFIX);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s recvframe_chk_defrag: drop pkt\n", __func__);
 		#endif
@@ -2344,7 +2417,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
+		pr_err("%s portctrl: drop pkt\n", DRIVER_PREFIX);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s portctrl: drop pkt\n", __func__);
 		#endif
@@ -2356,7 +2429,7 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recv_func: process_recv_indicatepkts fail!\n"));
+		pr_err("%s recv_func: process_recv_indicatepkts fail!\n", DRIVER_PREFIX);
 		#ifdef DBG_RX_DROP_FRAME
 		DBG_871X("DBG_RX_DROP_FRAME %s process_recv_indicatepkts fail!\n", __func__);
 		#endif
@@ -2435,7 +2508,8 @@ s32 rtw_recv_entry(union recv_frame *precvframe)
 
 	ret = recv_func(padapter, precvframe);
 	if (ret == _FAIL) {
-		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("rtw_recv_entry: recv_func return fail!!!\n"));
+		pr_info("%s %s: recv_func return fail!!!\n",
+			DRIVER_PREFIX, __func__);
 		goto _recv_entry_drop;
 	}
 
-- 
2.20.1

