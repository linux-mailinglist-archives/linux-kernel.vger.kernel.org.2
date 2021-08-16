Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B863EDA69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhHPQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbhHPQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k4so11880317wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FzowQDNBEqDTNgMRy31Wg39/cB07ghp3nBtWR+iOij0=;
        b=hHL3vBOxQjJhhAhoR6fg92HvmQuG8tYe4I5P7NcSR8DGoytPMKuLVKhO2Iunv0UrNy
         jEqgG0aLNaA3segsu/xyxSfXJluN1yNG/ojDx7WFDuNIANIz9biSzpvaTNxfS/btdbRQ
         ygq7kaO2ShrhRgZQp01KBVULF/k+aZuhXLbu2tna3YODu96RSZ+y70UaUHZ+zEp+wZ8o
         Fefb4TqAmrAWS/xEscpAhjj4etGdFnJvD9BjJo5//UHPaEf8r9zA1AToNlHpForjMf5L
         0Yn2vSTx3cno1R2/vpTmUZt4xOiCQCJGssEUe6zdKIqg4IOfg6wmFFfcBQ48W0GtEUd+
         T4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzowQDNBEqDTNgMRy31Wg39/cB07ghp3nBtWR+iOij0=;
        b=sDR6RFBBxjYrmhLfYCTOlNcnk5xngWIxoK6KYhbYosn9nAdRd1x/VnRqLg9gZep0mU
         xPL9srgS6zIRDi23GE916utAbd9Tcxv4uNnoB0Z3IfUmEWN2JF9Xwb6OP0JwViTWt6H5
         i2cGkTMk9cyB5fAysS2x0og/AH0U62SLMnurn4vkXxOdSk/bqkPnIjux6/5JJPaFxTMp
         Ese720NRuqAa2aF2RVb+MHlE7I5UQbE8QGMoFS/HQVtSjV8PGpcfvGL9OArz6HM0A7hO
         9hT2VOnYKFWVySGSxF2ONxDCgsW7WYpw3djtJkDWrK7seJnKV+bP1IlCPihuYIoL4e35
         nJrQ==
X-Gm-Message-State: AOAM531f/1MDMX0Csdv7FlTmbB/xaa+ESUPyZvYxAsbY9Y3wHkt8vOrh
        WB7Dn5G7K6sOZr5XDU3QaL8=
X-Google-Smtp-Source: ABdhPJz++MNRusoojWVp3GnX+sAJ2pTiO//uRYh7OZhFI0ljZW4oraouk7/+1bhgCA+RiiJg77qYUw==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr15942195wmi.177.1629129582562;
        Mon, 16 Aug 2021 08:59:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 19/23] staging: r8188eu: clean up spacing style issues in core/rtw_xmit.c
Date:   Mon, 16 Aug 2021 17:58:14 +0200
Message-Id: <20210816155818.24005-20-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_xmit.c reported by checkpatch.

CHECK: spaces preferred around that ...
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 122 ++++++++++++------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f941150e5f94..41723525074d 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -26,7 +26,7 @@ static void _init_txservq(struct tx_servq *ptxservq)
 void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 {
 
-	memset((unsigned char *)psta_xmitpriv, 0, sizeof (struct sta_xmit_priv));
+	memset((unsigned char *)psta_xmitpriv, 0, sizeof(struct sta_xmit_priv));
 	spin_lock_init(&psta_xmitpriv->lock);
 	_init_txservq(&psta_xmitpriv->be_q);
 	_init_txservq(&psta_xmitpriv->bk_q);
@@ -207,11 +207,11 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	return res;
 }
 
-static void  rtw_mfree_xmit_priv_lock (struct xmit_priv *pxmitpriv)
+static void  rtw_mfree_xmit_priv_lock(struct xmit_priv *pxmitpriv)
 {
 }
 
-void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
+void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 {
 	int i;
 	struct adapter *padapter = pxmitpriv->adapter;
@@ -514,7 +514,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	pattrib->subtype = WIFI_DATA_TYPE;
 	pattrib->priority = 0;
 
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE|WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE | WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE)) {
 		if (psta->qos_option)
 			set_qos(&pktfile, pattrib);
 	} else {
@@ -637,15 +637,15 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				rtw_secmicsetkey(&micdata, &stainfo->dot11tkiptxmickey.skey[0]);
 			}
 
-			if (pframe[1]&1) {   /* ToDS == 1 */
+			if (pframe[1] & 1) {   /* ToDS == 1 */
 				rtw_secmicappend(&micdata, &pframe[16], 6);  /* DA */
-				if (pframe[1]&2)  /* From Ds == 1 */
+				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[24], 6);
 				else
 				rtw_secmicappend(&micdata, &pframe[10], 6);
 			} else {	/* ToDS == 0 */
 				rtw_secmicappend(&micdata, &pframe[4], 6);   /* DA */
-				if (pframe[1]&2)  /* From Ds == 1 */
+				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[16], 6);
 				else
 					rtw_secmicappend(&micdata, &pframe[10], 6);
@@ -661,15 +661,15 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
 				payload = (u8 *)RND4((size_t)(payload));
 
-				payload = payload+pattrib->hdrlen+pattrib->iv_len;
-				if ((curfragnum+1) == pattrib->nr_frags) {
-					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
+				payload = payload + pattrib->hdrlen + pattrib->iv_len;
+				if ((curfragnum + 1) == pattrib->nr_frags) {
+					length = pattrib->last_txcmdsz - pattrib->hdrlen - pattrib->iv_len - ((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
-					payload = payload+length;
+					payload = payload + length;
 				} else {
-					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-((pattrib->bswenc) ? pattrib->icv_len : 0);
+					length = pxmitpriv->frag_len - pattrib->hdrlen - pattrib->iv_len - ((pattrib->bswenc) ? pattrib->icv_len : 0);
 					rtw_secmicappend(&micdata, payload, length);
-					payload = payload+length+pattrib->icv_len;
+					payload = payload + length + pattrib->icv_len;
 				}
 			}
 			rtw_secgetmic(&micdata, &mic[0]);
@@ -678,7 +678,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
 
-			payload = payload-pattrib->last_txcmdsz+8;
+			payload = payload - pattrib->last_txcmdsz + 8;
 		}
 	}
 
@@ -709,7 +709,7 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 	return _SUCCESS;
 }
 
-s32 rtw_make_wlanhdr (struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattrib)
+s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattrib)
 {
 	u16 *qc;
 
@@ -816,11 +816,11 @@ s32 rtw_make_wlanhdr (struct adapter *padapter, u8 *hdr, struct pkt_attrib *patt
 				if (SN_LESS(pattrib->seqnum, tx_seq)) {
 					pattrib->ampdu_en = false;/* AGG BK */
 				} else if (SN_EQUAL(pattrib->seqnum, tx_seq)) {
-					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq+1)&0xfff;
+					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (tx_seq + 1) & 0xfff;
 
 					pattrib->ampdu_en = true;/* AGG EN */
 				} else {
-					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum+1)&0xfff;
+					psta->BA_starting_seqctrl[pattrib->priority & 0x0f] = (pattrib->seqnum + 1) & 0xfff;
 					pattrib->ampdu_en = true;/* AGG EN */
 				}
 			}
@@ -1125,7 +1125,7 @@ void rtw_count_tx_stats(struct adapter *padapter, struct xmit_frame *pxmitframe,
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
-	if ((pxmitframe->frame_tag&0x0f) == DATA_FRAMETAG) {
+	if ((pxmitframe->frame_tag & 0x0f) == DATA_FRAMETAG) {
 		pxmitpriv->tx_bytes += sz;
 		pmlmepriv->LinkDetectInfo.NumTxOkInPeriod += pxmitframe->agg_num;
 
@@ -1584,32 +1584,32 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	rcu_read_unlock();
 	spin_lock_bh(&padapter->br_ext_lock);
 	if (!(skb->data[0] & 1) && br_port &&
-	    memcmp(skb->data+MACADDRLEN, padapter->br_mac, MACADDRLEN) &&
-	    *((__be16 *)(skb->data+MACADDRLEN*2)) != __constant_htons(ETH_P_8021Q) &&
-	    *((__be16 *)(skb->data+MACADDRLEN*2)) == __constant_htons(ETH_P_IP) &&
-	    !memcmp(padapter->scdb_mac, skb->data+MACADDRLEN, MACADDRLEN) && padapter->scdb_entry) {
-		memcpy(skb->data+MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN);
+	    memcmp(skb->data + MACADDRLEN, padapter->br_mac, MACADDRLEN) &&
+	    *((__be16 *)(skb->data + MACADDRLEN * 2)) != __constant_htons(ETH_P_8021Q) &&
+	    *((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP) &&
+	    !memcmp(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN) && padapter->scdb_entry) {
+		memcpy(skb->data + MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN);
 		padapter->scdb_entry->ageing_timer = jiffies;
 		spin_unlock_bh(&padapter->br_ext_lock);
 	} else {
-		if (*((__be16 *)(skb->data+MACADDRLEN*2)) == __constant_htons(ETH_P_8021Q)) {
+		if (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_8021Q)) {
 			is_vlan_tag = 1;
-			vlan_hdr = *((unsigned short *)(skb->data+MACADDRLEN*2+2));
+			vlan_hdr = *((unsigned short *)(skb->data + MACADDRLEN * 2 + 2));
 			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data+MACADDRLEN*2+2-i*2)) = *((unsigned short *)(skb->data+MACADDRLEN*2-2-i*2));
+				*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + MACADDRLEN * 2 - 2 - i * 2));
 			skb_pull(skb, 4);
 		}
-		if (!memcmp(skb->data+MACADDRLEN, padapter->br_mac, MACADDRLEN) &&
-		    (*((__be16 *)(skb->data+MACADDRLEN*2)) == __constant_htons(ETH_P_IP)))
-			memcpy(padapter->br_ip, skb->data+WLAN_ETHHDR_LEN+12, 4);
+		if (!memcmp(skb->data + MACADDRLEN, padapter->br_mac, MACADDRLEN) &&
+		    (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP)))
+			memcpy(padapter->br_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);
 
-		if (*((__be16 *)(skb->data+MACADDRLEN*2)) == __constant_htons(ETH_P_IP)) {
-			if (memcmp(padapter->scdb_mac, skb->data+MACADDRLEN, MACADDRLEN)) {
+		if (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP)) {
+			if (memcmp(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN)) {
 				padapter->scdb_entry = (struct nat25_network_db_entry *)scdb_findEntry(padapter,
-							skb->data+MACADDRLEN, skb->data+WLAN_ETHHDR_LEN+12);
+							skb->data + MACADDRLEN, skb->data + WLAN_ETHHDR_LEN + 12);
 				if (padapter->scdb_entry) {
-					memcpy(padapter->scdb_mac, skb->data+MACADDRLEN, MACADDRLEN);
-					memcpy(padapter->scdb_ip, skb->data+WLAN_ETHHDR_LEN+12, 4);
+					memcpy(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN);
+					memcpy(padapter->scdb_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);
 					padapter->scdb_entry->ageing_timer = jiffies;
 					do_nat25 = 0;
 				}
@@ -1631,9 +1631,9 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 				if (is_vlan_tag) {
 					skb_push(skb, 4);
 					for (i = 0; i < 6; i++)
-						*((unsigned short *)(skb->data+i*2)) = *((unsigned short *)(skb->data+4+i*2));
-					*((__be16 *)(skb->data+MACADDRLEN*2)) = __constant_htons(ETH_P_8021Q);
-					*((unsigned short *)(skb->data+MACADDRLEN*2+2)) = vlan_hdr;
+						*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
+					*((__be16 *)(skb->data + MACADDRLEN * 2)) = __constant_htons(ETH_P_8021Q);
+					*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2)) = vlan_hdr;
 				}
 
 				newskb = skb_copy(skb, GFP_ATOMIC);
@@ -1645,9 +1645,9 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 
 				*pskb = skb = newskb;
 				if (is_vlan_tag) {
-					vlan_hdr = *((unsigned short *)(skb->data+MACADDRLEN*2+2));
+					vlan_hdr = *((unsigned short *)(skb->data + MACADDRLEN * 2 + 2));
 					for (i = 0; i < 6; i++)
-						*((unsigned short *)(skb->data+MACADDRLEN*2+2-i*2)) = *((unsigned short *)(skb->data+MACADDRLEN*2-2-i*2));
+						*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2 - i * 2)) = *((unsigned short *)(skb->data + MACADDRLEN * 2 - 2 - i * 2));
 					skb_pull(skb, 4);
 				}
 			}
@@ -1671,21 +1671,21 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 			}
 		}
 
-		memcpy(skb->data+MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN);
+		memcpy(skb->data + MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN);
 
 		dhcp_flag_bcast(padapter, skb);
 
 		if (is_vlan_tag) {
 			skb_push(skb, 4);
 			for (i = 0; i < 6; i++)
-				*((unsigned short *)(skb->data+i*2)) = *((unsigned short *)(skb->data+4+i*2));
-			*((__be16 *)(skb->data+MACADDRLEN*2)) = __constant_htons(ETH_P_8021Q);
-			*((unsigned short *)(skb->data+MACADDRLEN*2+2)) = vlan_hdr;
+				*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
+			*((__be16 *)(skb->data + MACADDRLEN * 2)) = __constant_htons(ETH_P_8021Q);
+			*((unsigned short *)(skb->data + MACADDRLEN * 2 + 2)) = vlan_hdr;
 		}
 	}
 
 	/*  check if SA is equal to our MAC */
-	if (memcmp(skb->data+MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN)) {
+	if (memcmp(skb->data + MACADDRLEN, GET_MY_HWADDR(padapter), MACADDRLEN)) {
 		DEBUG_ERR("TX DROP: untransformed frame SA:%02X%02X%02X%02X%02X%02X!\n",
 			  skb->data[6], skb->data[7], skb->data[8], skb->data[9], skb->data[10], skb->data[11]);
 		return -1;
@@ -1765,7 +1765,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	br_port = rcu_dereference(padapter->pnetdev->rx_handler_data);
 	rcu_read_unlock();
 
-	if (br_port && check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE)) {
+	if (br_port && check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE)) {
 		res = rtw_br_client_tx(padapter, ppkt);
 		if (res == -1) {
 			rtw_free_xmitframe(pxmitpriv, pxmitframe);
@@ -1853,10 +1853,10 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 
 	spin_lock_bh(&psta->sleep_q.lock);
 
-	if (psta->state&WIFI_SLEEP_STATE) {
+	if (psta->state & WIFI_SLEEP_STATE) {
 		u8 wmmps_ac = 0;
 
-		if (pstapriv->sta_dz_bitmap&BIT(psta->aid)) {
+		if (pstapriv->sta_dz_bitmap & BIT(psta->aid)) {
 			list_del_init(&pxmitframe->list);
 
 			list_add_tail(&pxmitframe->list, get_list_head(&psta->sleep_q));
@@ -1866,20 +1866,20 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 			switch (pattrib->priority) {
 			case 1:
 			case 2:
-				wmmps_ac = psta->uapsd_bk&BIT(0);
+				wmmps_ac = psta->uapsd_bk & BIT(0);
 				break;
 			case 4:
 			case 5:
-				wmmps_ac = psta->uapsd_vi&BIT(0);
+				wmmps_ac = psta->uapsd_vi & BIT(0);
 				break;
 			case 6:
 			case 7:
-				wmmps_ac = psta->uapsd_vo&BIT(0);
+				wmmps_ac = psta->uapsd_vo & BIT(0);
 				break;
 			case 0:
 			case 3:
 			default:
-				wmmps_ac = psta->uapsd_be&BIT(0);
+				wmmps_ac = psta->uapsd_be & BIT(0);
 				break;
 			}
 
@@ -1993,20 +1993,20 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 		switch (pxmitframe->attrib.priority) {
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
 
@@ -2040,7 +2040,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 		update_mask = BIT(0);
 
-		if (psta->state&WIFI_SLEEP_STATE)
+		if (psta->state & WIFI_SLEEP_STATE)
 			psta->state ^= WIFI_SLEEP_STATE;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
@@ -2058,7 +2058,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	if (!psta_bmc)
 		return;
 
-	if ((pstapriv->sta_dz_bitmap&0xfffe) == 0x0) { /* no any sta in ps mode */
+	if ((pstapriv->sta_dz_bitmap & 0xfffe) == 0x0) { /* no any sta in ps mode */
 		spin_lock_bh(&psta_bmc->sleep_q.lock);
 
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
@@ -2119,20 +2119,20 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		switch (pxmitframe->attrib.priority) {
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
 
-- 
2.32.0

