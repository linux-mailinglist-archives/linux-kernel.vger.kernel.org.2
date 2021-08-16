Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8514B3EDA68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhHPQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbhHPQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE2C061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so5394191wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvEpwavelEH+0X7GJw8peYMbMbTp7IBX8yIlQYeJywk=;
        b=MPQIDB+Bac+Z2TUubQp2UsUILFe2ElVCPOnaf5KYyHJOWXjb+X4snwyyBPNL50rf2r
         ce3JRNgZOk/M5QKQDU1jZ0LKsVyANgubDPDv2HTtj41uRYfdMW8oKMEF/9aLRRZG8uZF
         d4lRqrvIdtJ7zRIJtGNErAimNMSrRr5pdxtQYJE0JHjtS9fYWk+5XskVuRw2pcqt9hlQ
         oLWilX3QGetcGhBfZWlCWCY858g3GM3MFLx9jTVOdb4VNr/EBquVznv+h4lZedGUTOWv
         TCsPDuJbLwfp0F1SISYWglckt7G/XPFyH5EHlaQzhR8OuN1zewtltr1mTU+JUG4IKso3
         1xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvEpwavelEH+0X7GJw8peYMbMbTp7IBX8yIlQYeJywk=;
        b=DnI2WgFOgaM4hcMdcZUGvKOmRTwRU8obtHxPM9tTRFwfwqbRfyXs88pTxGfA27tVI2
         4sThoRgc3PTWIuubQ+FNniGqngpagh+LSplLKBg/bKd872ThFe158wMCo8WC59g80jLz
         wvNbO6NSD7mwm0mad5eKkYUGkuYOted8p0KAKBWDqueuDeQV3ZyaxwQ6Po6loaHOo3Ph
         jXbIGIuivgnEaQ66KcRSB45udAbwTG2Ob56RNsBdELjaacv5BQLU/mBfHTas4I8t/a90
         LEvlzz2u+Voan9Akz+g43qR/0MqoLZW5Tl21nY1ILSoooHgeiy8UAAElyghMAnR+wiUK
         +pHg==
X-Gm-Message-State: AOAM531CzLdD3d7pCMR0UG5DrsE4H2oWlw21rtEJM4VGyjfF2xPEVjsW
        5mEtfg1vsO6wAxbop6t+7gU=
X-Google-Smtp-Source: ABdhPJzxDOtnKtiW6fs+ASmBjyyd3tc6BFvMdSerP1nkX0NlioeHMbFPtTKs9AM3GcEXQKU2csrHJA==
X-Received: by 2002:adf:ec81:: with SMTP id z1mr19292438wrn.181.1629129578875;
        Mon, 16 Aug 2021 08:59:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/23] staging: r8188eu: clean up spacing style issues in core/rtw_recv.c
Date:   Mon, 16 Aug 2021 17:58:11 +0200
Message-Id: <20210816155818.24005-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_recv.c reported by checkpatch.

CHECK: spaces preferred around that ...
CHECK: No space is necessary after a cast
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 112 ++++++++++++------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 8df38db9572c..c28e0204d18b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -30,7 +30,7 @@ void rtw_signal_stat_timer_hdl(struct timer_list *);
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
 
-	memset((u8 *)psta_recvpriv, 0, sizeof (struct sta_recv_priv));
+	memset((u8 *)psta_recvpriv, 0, sizeof(struct sta_recv_priv));
 
 	spin_lock_init(&psta_recvpriv->lock);
 
@@ -96,7 +96,7 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	return res;
 }
 
-void _rtw_free_recv_priv (struct recv_priv *precvpriv)
+void _rtw_free_recv_priv(struct recv_priv *precvpriv)
 {
 	struct adapter	*padapter = precvpriv->adapter;
 
@@ -109,7 +109,7 @@ void _rtw_free_recv_priv (struct recv_priv *precvpriv)
 	rtw_hal_free_recv_priv(padapter);
 }
 
-struct recv_frame *_rtw_alloc_recvframe (struct __queue *pfree_recv_queue)
+struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
 {
 	struct recv_frame *hdr;
 	struct list_head *plist, *phead;
@@ -137,7 +137,7 @@ struct recv_frame *_rtw_alloc_recvframe (struct __queue *pfree_recv_queue)
 	return (struct recv_frame *)hdr;
 }
 
-struct recv_frame *rtw_alloc_recvframe (struct __queue *pfree_recv_queue)
+struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
 {
 	struct recv_frame  *precvframe;
 
@@ -285,7 +285,7 @@ int rtw_enqueue_recvbuf(struct recv_buf *precvbuf, struct __queue *queue)
 	return _SUCCESS;
 }
 
-struct recv_buf *rtw_dequeue_recvbuf (struct __queue *queue)
+struct recv_buf *rtw_dequeue_recvbuf(struct __queue *queue)
 {
 	struct recv_buf *precvbuf;
 	struct list_head *plist, *phead;
@@ -342,19 +342,19 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
 			}
 
-			datalen = precvframe->len-prxattrib->hdrlen-prxattrib->iv_len-prxattrib->icv_len-8;/* icv_len included the mic code */
+			datalen = precvframe->len - prxattrib->hdrlen - prxattrib->iv_len - prxattrib->icv_len - 8;/* icv_len included the mic code */
 			pframe = precvframe->rx_data;
-			payload = pframe+prxattrib->hdrlen+prxattrib->iv_len;
+			payload = pframe + prxattrib->hdrlen + prxattrib->iv_len;
 
 			rtw_seccalctkipmic(mickey, pframe, payload, datalen, &miccode[0],
 					   (unsigned char)prxattrib->priority); /* care the length of the data */
 
-			pframemic = payload+datalen;
+			pframemic = payload + datalen;
 
 			bmic_err = false;
 
 			for (i = 0; i < 8; i++) {
-				if (miccode[i] != *(pframemic+i))
+				if (miccode[i] != *(pframemic + i))
 					bmic_err = true;
 			}
 
@@ -395,8 +395,8 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 	u32	 res = _SUCCESS;
 
 	if (prxattrib->encrypt > 0) {
-		u8 *iv = precv_frame->rx_data+prxattrib->hdrlen;
-		prxattrib->key_index = (((iv[3])>>6)&0x3);
+		u8 *iv = precv_frame->rx_data + prxattrib->hdrlen;
+		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
 			DBG_88E("prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
@@ -480,7 +480,7 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 			prtnframe = precv_frame;
 
 			/* get ether_type */
-			ptr = ptr+pfhdr->attrib.hdrlen+pfhdr->attrib.iv_len+LLC_HEADER_SIZE;
+			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_SIZE;
 			memcpy(&be_tmp, ptr, 2);
 			ether_type = ntohs(be_tmp);
 
@@ -507,7 +507,7 @@ static int recv_decache(struct recv_frame *precv_frame, u8 bretry, struct stainf
 {
 	int tid = precv_frame->attrib.priority;
 
-	u16 seq_ctrl = ((precv_frame->attrib.seq_num&0xffff) << 4) |
+	u16 seq_ctrl = ((precv_frame->attrib.seq_num & 0xffff) << 4) |
 		(precv_frame->attrib.frag_num & 0xf);
 
 	if (tid > 15)
@@ -565,29 +565,29 @@ static void process_wmmps_data(struct adapter *padapter, struct recv_frame *prec
 	if (!psta->qos_option)
 		return;
 
-	if (!(psta->qos_info&0xf))
+	if (!(psta->qos_info & 0xf))
 		return;
 
-	if (psta->state&WIFI_SLEEP_STATE) {
+	if (psta->state & WIFI_SLEEP_STATE) {
 		u8 wmmps_ac = 0;
 
 		switch (pattrib->priority) {
 		case 1:
 		case 2:
-			wmmps_ac = psta->uapsd_bk&BIT(1);
+			wmmps_ac = psta->uapsd_bk & BIT(1);
 			break;
 		case 4:
 		case 5:
-			wmmps_ac = psta->uapsd_vi&BIT(1);
+			wmmps_ac = psta->uapsd_vi & BIT(1);
 			break;
 		case 6:
 		case 7:
-			wmmps_ac = psta->uapsd_vo&BIT(1);
+			wmmps_ac = psta->uapsd_vo & BIT(1);
 			break;
 		case 0:
 		case 3:
 		default:
-			wmmps_ac = psta->uapsd_be&BIT(1);
+			wmmps_ac = psta->uapsd_be & BIT(1);
 			break;
 		}
 
@@ -727,7 +727,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	return ret;
 }
 
-static int ap2sta_data_frame (
+static int ap2sta_data_frame(
 	struct adapter *adapter,
 	struct recv_frame *precv_frame,
 	struct sta_info **psta)
@@ -917,20 +917,20 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		switch (pattrib->priority) {
 		case 1:
 		case 2:
-			wmmps_ac = psta->uapsd_bk&BIT(0);
+			wmmps_ac = psta->uapsd_bk & BIT(0);
 			break;
 		case 4:
 		case 5:
-			wmmps_ac = psta->uapsd_vi&BIT(0);
+			wmmps_ac = psta->uapsd_vi & BIT(0);
 			break;
 		case 6:
 		case 7:
-			wmmps_ac = psta->uapsd_vo&BIT(0);
+			wmmps_ac = psta->uapsd_vo & BIT(0);
 			break;
 		case 0:
 		case 3:
 		default:
-			wmmps_ac = psta->uapsd_be&BIT(0);
+			wmmps_ac = psta->uapsd_be & BIT(0);
 			break;
 		}
 
@@ -943,7 +943,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
 
-		if ((psta->state&WIFI_SLEEP_STATE) && (pstapriv->sta_dz_bitmap&BIT(psta->aid))) {
+		if ((psta->state & WIFI_SLEEP_STATE) && (pstapriv->sta_dz_bitmap & BIT(psta->aid))) {
 			struct list_head *xmitframe_plist, *xmitframe_phead;
 			struct xmit_frame *pxmitframe = NULL;
 			struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -979,7 +979,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 					update_beacon(padapter, _TIM_IE_, NULL, false);
 				}
 			} else {
-				if (pstapriv->tim_bitmap&BIT(psta->aid)) {
+				if (pstapriv->tim_bitmap & BIT(psta->aid)) {
 					if (psta->sleepq_len == 0) {
 						DBG_88E("no buffered packets to xmit\n");
 
@@ -1162,7 +1162,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	u8 bDumpRxPkt;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	u8 *ptr = precv_frame->rx_data;
-	u8  ver = (unsigned char) (*ptr)&0x3;
+	u8  ver = (unsigned char)(*ptr) & 0x3;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
@@ -1197,18 +1197,18 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 		int i;
 		DBG_88E("#############################\n");
 
-		for (i = 0; i < 64; i = i+8)
-			DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr+i),
-				*(ptr+i+1), *(ptr+i+2), *(ptr+i+3), *(ptr+i+4), *(ptr+i+5), *(ptr+i+6), *(ptr+i+7));
+		for (i = 0; i < 64; i = i + 8)
+			DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
+				*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
 		DBG_88E("#############################\n");
 	} else if (bDumpRxPkt == 2) {
 		if (type == WIFI_MGT_TYPE) {
 			int i;
 			DBG_88E("#############################\n");
 
-			for (i = 0; i < 64; i = i+8)
-				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr+i),
-					*(ptr+i+1), *(ptr+i+2), *(ptr+i+3), *(ptr+i+4), *(ptr+i+5), *(ptr+i+6), *(ptr+i+7));
+			for (i = 0; i < 64; i = i + 8)
+				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
+					*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
 			DBG_88E("#############################\n");
 		}
 	} else if (bDumpRxPkt == 3) {
@@ -1216,9 +1216,9 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 			int i;
 			DBG_88E("#############################\n");
 
-			for (i = 0; i < 64; i = i+8)
-				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr+i),
-					*(ptr+i+1), *(ptr+i+2), *(ptr+i+3), *(ptr+i+4), *(ptr+i+5), *(ptr+i+6), *(ptr+i+7));
+			for (i = 0; i < 64; i = i + 8)
+				DBG_88E("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr + i),
+					*(ptr + i + 1), *(ptr + i + 2), *(ptr + i + 3), *(ptr + i + 4), *(ptr + i + 5), *(ptr + i + 6), *(ptr + i + 7));
 			DBG_88E("#############################\n");
 		}
 	}
@@ -1252,7 +1252,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 
 /* remove the wlanhdr and add the eth_hdr */
 
-static int wlanhdr_to_ethhdr (struct recv_frame *precvframe)
+static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 {
 	int	rmv_len;
 	u16	eth_type, len;
@@ -1271,8 +1271,8 @@ static int wlanhdr_to_ethhdr (struct recv_frame *precvframe)
 	if (pattrib->encrypt)
 		recvframe_pull_tail(precvframe, pattrib->icv_len);
 
-	psnap = (struct ieee80211_snap_hdr *)(ptr+pattrib->hdrlen + pattrib->iv_len);
-	psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
+	psnap = (struct ieee80211_snap_hdr *)(ptr + pattrib->hdrlen + pattrib->iv_len);
+	psnap_type = ptr + pattrib->hdrlen + pattrib->iv_len + SNAP_SIZE;
 	/* convert hdr + possible LLC headers into Ethernet header */
 	if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
 	     memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
@@ -1288,30 +1288,30 @@ static int wlanhdr_to_ethhdr (struct recv_frame *precvframe)
 	rmv_len = pattrib->hdrlen + pattrib->iv_len + (bsnaphdr ? SNAP_SIZE : 0);
 	len = precvframe->len - rmv_len;
 
-	memcpy(&be_tmp, ptr+rmv_len, 2);
+	memcpy(&be_tmp, ptr + rmv_len, 2);
 	eth_type = ntohs(be_tmp); /* pattrib->ether_type */
 	pattrib->eth_type = eth_type;
 
 	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE))) {
 		ptr += rmv_len;
 		*ptr = 0x87;
-		*(ptr+1) = 0x12;
+		*(ptr + 1) = 0x12;
 
 		eth_type = 0x8712;
 		/*  append rx status for mp test packets */
-		ptr = recvframe_pull(precvframe, (rmv_len-sizeof(struct ethhdr)+2)-24);
+		ptr = recvframe_pull(precvframe, (rmv_len - sizeof(struct ethhdr) + 2) - 24);
 		memcpy(ptr, get_rxmem(precvframe), 24);
 		ptr += 24;
 	} else {
-		ptr = recvframe_pull(precvframe, (rmv_len-sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
+		ptr = recvframe_pull(precvframe, (rmv_len - sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
 	}
 
 	memcpy(ptr, pattrib->dst, ETH_ALEN);
-	memcpy(ptr+ETH_ALEN, pattrib->src, ETH_ALEN);
+	memcpy(ptr + ETH_ALEN, pattrib->src, ETH_ALEN);
 
 	if (!bsnaphdr) {
 		be_tmp = htons(len);
-		memcpy(ptr+12, &be_tmp, 2);
+		memcpy(ptr + 12, &be_tmp, 2);
 	}
 
 	return ret;
@@ -1558,7 +1558,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		pdata += nSubframe_Length;
 		a_len -= nSubframe_Length;
 		if (a_len != 0) {
-			padding_len = 4 - ((nSubframe_Length + ETH_HLEN) & (4-1));
+			padding_len = 4 - ((nSubframe_Length + ETH_HLEN) & (4 - 1));
 			if (padding_len == 4) {
 				padding_len = 0;
 			}
@@ -1755,7 +1755,7 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
 			rtw_recv_indicatepkt(padapter, prframe);
 
-			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
+			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) % 4096;
 			return _SUCCESS;
 		}
 	} else if (pattrib->amsdu == 1) { /* temp filter -> means didn't support A-MSDUs in a A-MPDU */
@@ -1763,7 +1763,7 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, struct recv_frame
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
 			retval = amsdu_to_msdu(padapter, prframe);
 
-			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
+			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) % 4096;
 			return retval;
 		}
 	}
@@ -1843,7 +1843,7 @@ static int process_recv_indicatepkts(struct adapter *padapter, struct recv_frame
 			}
 		}
 	} else { /* B/G mode */
-		retval = wlanhdr_to_ethhdr (prframe);
+		retval = wlanhdr_to_ethhdr(prframe);
 		if (retval != _SUCCESS)
 			return retval;
 
@@ -1963,7 +1963,7 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 		     !psecuritypriv->busetkipkey) {
 			rtw_enqueue_recvframe(rframe, &padapter->recvpriv.uc_swdec_pending_queue);
 			DBG_88E("%s: no key, enqueue uc_swdec_pending_queue\n", __func__);
-			if (recvpriv->free_recvframe_cnt < NR_RECVFRAME/4) {
+			if (recvpriv->free_recvframe_cnt < NR_RECVFRAME / 4) {
 				/* to prevent from recvframe starvation,
 				 * get recvframe from uc_swdec_pending_queue to
 				 * free_recvframe_cnt  */
@@ -2036,19 +2036,19 @@ void rtw_signal_stat_timer_hdl(struct timer_list *t)
 
 		/* update value of signal_strength, rssi, signal_qual */
 		if (check_fwstate(&adapter->mlmepriv, _FW_UNDER_SURVEY) == false) {
-			tmp_s = (avg_signal_strength+(_alpha-1)*recvpriv->signal_strength);
+			tmp_s = (avg_signal_strength + (_alpha - 1) * recvpriv->signal_strength);
 			if (tmp_s % _alpha)
-				tmp_s = tmp_s/_alpha + 1;
+				tmp_s = tmp_s / _alpha + 1;
 			else
-				tmp_s = tmp_s/_alpha;
+				tmp_s = tmp_s / _alpha;
 			if (tmp_s > 100)
 				tmp_s = 100;
 
-			tmp_q = (avg_signal_qual+(_alpha-1)*recvpriv->signal_qual);
+			tmp_q = (avg_signal_qual + (_alpha - 1) * recvpriv->signal_qual);
 			if (tmp_q % _alpha)
-				tmp_q = tmp_q/_alpha + 1;
+				tmp_q = tmp_q / _alpha + 1;
 			else
-				tmp_q = tmp_q/_alpha;
+				tmp_q = tmp_q / _alpha;
 			if (tmp_q > 100)
 				tmp_q = 100;
 
-- 
2.32.0

