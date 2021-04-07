Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D99356DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352645AbhDGNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbhDGNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C9C0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso1194460wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/M6LnHwQmSY1q1PWNcbNqNUSnkm4n6RSgSWlfjWlj9M=;
        b=NkXCVwkMSo7O1xb5d65EY+thzMgmUnHuK74YEqveieuiSr/EnTk7UCSZJQfJk3LDTo
         bOw7NDsHZJ2FgrLAf2ykf8cILRArFI6KqrtW709ZZgDDZzM7cnlq6MPgWEKcLL98yqKT
         mQR+/4yn2+UH6rVe5H8tUEugq9AReQLXTuQUwsWOxM7ei1t9MR/oOXDhYYFJafNncxan
         moKCRO2Ic5PkYPvrVN4uIg0z1M31PE9ZpcMSZyCOgSk5zidCvdilhWrhSoj+H6DFO8wJ
         55f5yiJeDfescRJ0mEePxi5XCWwKTifqUdmf8h7/4UYTgB7S4K3a6RAHCrZ9tc3gzsZb
         fd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/M6LnHwQmSY1q1PWNcbNqNUSnkm4n6RSgSWlfjWlj9M=;
        b=pDyxv5XJj84fO3z/0AmxAV7JD/vwWskhZ+W4BE2/s3F+Ew9mENkwnsSazO6jPjeZ0k
         aWukpq+Xdp49m4pct+vZ7QGaJ5x5kGWi8co3gYDlDAEdyyG3HIUeu8+C0N3b5nb3nHRB
         JEb1Ud3CCumvu70HfBnFAvo4U6/jrh8e08QFp9KppRk64XGRPFSZtLNx5zIEarbVooX7
         dq12TKBpnqUIq9/Z7yD5nOx8MKywm98XbrbuN9G6dkLLLw9ed65P9O5eurMJ5lZmDIky
         vGc9JAefCjiGeFH8DbED4M26ggO/jQsR86Zbahl7Vqob4Q5U0T9YtshimmXC7dx1STqX
         GoOw==
X-Gm-Message-State: AOAM533bV40JtzuuKEkuqINgxAJkeGJJ1tCLpwK7tCNfusDiWAE+5MeK
        O//npraz9jzqBouOGJNou8Y=
X-Google-Smtp-Source: ABdhPJyHaCCxqx7iqEdZaoE9XVwr+aGIKrsxZDrRqoVYCj4Jch1qYVtN9gfHW3iNVRknNbMQpPY2+Q==
X-Received: by 2002:a05:600c:2f9a:: with SMTP id t26mr3053744wmn.111.1617803413646;
        Wed, 07 Apr 2021 06:50:13 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id r5sm3355488wrx.87.2021.04.07.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/19] staging: rtl8723bs: remove empty #ifdef blocks after DBG_871X removal
Date:   Wed,  7 Apr 2021 15:49:35 +0200
Message-Id: <4e19eb1c71bc1d43d30c1b0a04851ab7ce528f36.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove #ifdef and blocks #if defined() blocks left empty
after DBG_871X removal.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  7 --
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 14 ----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 18 -----
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 76 -------------------
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  2 -
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 20 -----
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  2 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 16 ----
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 18 -----
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  4 -
 10 files changed, 177 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index e7712391a87d..015c1d74a92d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -170,9 +170,6 @@ static void update_BCNTIM(struct adapter *padapter)
 u8 chk_sta_is_alive(struct sta_info *psta);
 u8 chk_sta_is_alive(struct sta_info *psta)
 {
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
-
 	sta_update_last_rx_pkts(psta);
 
 	return true;
@@ -194,8 +191,6 @@ void expire_timeout_chk(struct adapter *padapter)
 	plist = get_next(phead);
 
 	/* check auth_queue */
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
 	while (phead != plist) {
 		psta = container_of(plist, struct sta_info, auth_list);
 
@@ -225,8 +220,6 @@ void expire_timeout_chk(struct adapter *padapter)
 	plist = get_next(phead);
 
 	/* check asoc_queue */
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
 	while (phead != plist) {
 		psta = container_of(plist, struct sta_info, asoc_list);
 		plist = get_next(plist);
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index f5eb13e4c36e..9af75f683a18 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -479,11 +479,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	u8 sq_final;
 	long rssi_final;
 
-	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-	}
-	#endif
-
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&(padapter->mlmepriv.cur_network.network), src, 0)) {
 		/* Take the recvpriv's value for the connected AP*/
@@ -517,9 +512,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	dst->PhyInfo.SignalStrength = ss_final;
 	dst->PhyInfo.SignalQuality = sq_final;
 	dst->Rssi = rssi_final;
-
-	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
-	#endif
 }
 
 static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex *pnetwork)
@@ -1119,8 +1111,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
 			preorder_ctrl->enable = false;
 			preorder_ctrl->indicate_seq = 0xffff;
-			#ifdef DBG_RX_SEQ
-			#endif
 			preorder_ctrl->wend_b = 0xffff;
 			preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
 		}
@@ -1132,8 +1122,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 				preorder_ctrl = &bmc_sta->recvreorder_ctrl[i];
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
-				#ifdef DBG_RX_SEQ
-				#endif
 				preorder_ctrl->wend_b = 0xffff;
 				preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
 			}
@@ -1165,8 +1153,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	padapter->recvpriv.signal_qual = ptarget_wlan->network.PhyInfo.SignalQuality;
 	/* the ptarget_wlan->network.Rssi is raw data, we use ptarget_wlan->network.PhyInfo.SignalStrength instead (has scaled) */
 	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.PhyInfo.SignalStrength);
-	#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
-	#endif
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index b889e1214ef2..c353ce2c8e0a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1802,8 +1802,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 				preorder_ctrl =  &psta->recvreorder_ctrl[tid];
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
-				#ifdef DBG_RX_SEQ
-				#endif
 			}
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
@@ -3864,8 +3862,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
-				#ifdef DBG_RX_SEQ
-				#endif
 			}
 		}
 	} else if (initiator == 1) {/*  originator */
@@ -3939,10 +3935,6 @@ void site_survey(struct adapter *padapter)
 		}
 	}
 
-#ifdef DBG_FIXED_CHAN
-	
-#endif
-
 	if (survey_channel != 0) {
 		/* PAUSE 4-AC Queue when site_survey */
 		/* rtw_hal_get_hwreg(padapter, HW_VAR_TXPAUSE, (u8 *)(&val8)); */
@@ -4190,9 +4182,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 			pmlmepriv->num_sta_no_ht++;
 	}
 
-	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
-	#endif
-
 	/*  mark bss info receiving from nearby channel as SignalQuality 101 */
 	if (bssid->Configuration.DSConfig != rtw_get_oper_ch(padapter))
 		bssid->PhyInfo.SignalQuality = 101;
@@ -5203,9 +5192,6 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 ret = false;
 
-	#ifdef DBG_EXPIRATION_CHK
-	#endif
-
 	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta))
 		&& sta_rx_beacon_pkts(psta) == sta_last_rx_beacon_pkts(psta)
 		&& sta_rx_probersp_pkts(psta) == sta_last_rx_probersp_pkts(psta)
@@ -5258,8 +5244,6 @@ void linked_status_chk(struct adapter *padapter)
 			{
 				if (rx_chk != _SUCCESS) {
 					if (pmlmeext->retry == 0) {
-						#ifdef DBG_EXPIRATION_CHK
-						#endif
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
@@ -5267,8 +5251,6 @@ void linked_status_chk(struct adapter *padapter)
 				}
 
 				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit) {
-					#ifdef DBG_EXPIRATION_CHK
-					#endif
 					tx_chk = issue_nulldata_in_interrupt(padapter, NULL);
 				}
 			}
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index cd76fe2afcd0..3980873f3b37 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -416,9 +416,6 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 	if ((prxattrib->encrypt > 0) && ((prxattrib->bdecrypted == 0) || (psecuritypriv->sw_decrypt == true))) {
 		psecuritypriv->hw_decrypted = false;
 
-		#ifdef DBG_RX_DECRYPTOR
-		#endif
-
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
 		case _WEP104_:
@@ -437,12 +434,7 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 		   (psecuritypriv->busetkipkey == 1 || prxattrib->encrypt != _TKIP_)
 		) {
 		psecuritypriv->hw_decrypted = true;
-		#ifdef DBG_RX_DECRYPTOR
-
-		#endif
 	} else {
-		#ifdef DBG_RX_DECRYPTOR
-		#endif
 	}
 
 	if (res == _FAIL) {
@@ -765,16 +757,12 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
 
 		/*  da should be for me */
 		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -784,8 +772,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		if (!memcmp(pattrib->bssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 
 			if (!bmcast) {
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -801,8 +787,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
 		if (!*psta) {
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -828,8 +812,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 		if (!*psta) {
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			ret = _FAIL;
 			goto exit;
 		}
@@ -856,8 +838,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		}
 
 		ret = _FAIL;
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 	}
 
 exit:
@@ -1267,8 +1247,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 	pbssid = get_hdr_bssid(ptr);
 
 	if (!pbssid) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1310,8 +1288,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 	}
 
 	if (ret == _FAIL) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto exit;
 	} else if (ret == RTW_RX_HANDLED) {
 		goto exit;
@@ -1319,8 +1295,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 
 	if (!psta) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1355,8 +1329,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1523,8 +1495,6 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 		}
 		break;
 	default:
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		retval = _FAIL;
 		break;
 	}
@@ -1681,8 +1651,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 	/*  Rx Reorder initialize condition. */
 	if (preorder_ctrl->indicate_seq == 0xFFFF) {
 		preorder_ctrl->indicate_seq = seq_num;
-		#ifdef DBG_RX_SEQ
-		#endif
 
 		/* DbgPrint("check_indicate_seq, 1st->indicate_seq =%d\n", precvpriv->indicate_seq); */
 	}
@@ -1693,10 +1661,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 	if (SN_LESS(seq_num, preorder_ctrl->indicate_seq)) {
 		/* DbgPrint("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
 
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
-
-
 		return false;
 	}
 
@@ -1708,8 +1672,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 	if (SN_EQUAL(seq_num, preorder_ctrl->indicate_seq)) {
 		preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
 
-		#ifdef DBG_RX_SEQ
-		#endif
 	} else if (SN_LESS(wend, seq_num)) {
 		/* DbgPrint("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
 
@@ -1719,8 +1681,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 		else
 			preorder_ctrl->indicate_seq = 0xFFF - (wsize - (seq_num + 1)) + 1;
 		pdbgpriv->dbg_rx_ampdu_window_shift_cnt++;
-		#ifdef DBG_RX_SEQ
-		#endif
 	}
 
 	/* DbgPrint("exit->check_indicate_seq(): IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
@@ -1818,8 +1778,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 		prframe = (union recv_frame *)plist;
 		pattrib = &prframe->u.hdr.attrib;
 
-		#ifdef DBG_RX_SEQ
-		#endif
 		recv_indicatepkts_pkt_loss_cnt(pdbgpriv, preorder_ctrl->indicate_seq, pattrib->seq_num);
 		preorder_ctrl->indicate_seq = pattrib->seq_num;
 
@@ -1838,8 +1796,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 
 			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
 				preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
-				#ifdef DBG_RX_SEQ
-				#endif
 			}
 
 			/* Set this as a lock to make sure that only one thread is indicating packet. */
@@ -1904,9 +1860,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 
 			}
 
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
-
 			return _FAIL;
 
 		}
@@ -1914,32 +1867,22 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		if (preorder_ctrl->enable == false) {
 			/* indicate this recv_frame */
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			rtw_recv_indicatepkt(padapter, prframe);
 
 			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			return _SUCCESS;
 		}
 	} else if (pattrib->amsdu == 1) { /* temp filter -> means didn't support A-MSDUs in a A-MPDU */
 		if (preorder_ctrl->enable == false) {
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			retval = amsdu_to_msdu(padapter, prframe);
 
 			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
-			#ifdef DBG_RX_SEQ
-			#endif
 
 			if (retval != _SUCCESS) {
-				#ifdef DBG_RX_DROP_FRAME
-				#endif
 			}
 
 			return retval;
@@ -1951,8 +1894,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 	/* s2. check if winstart_b(indicate_seq) needs to been updated */
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
 		pdbgpriv->dbg_rx_ampdu_drop_count++;
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto _err_exit;
 	}
 
@@ -1962,8 +1903,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		/* DbgPrint("recv_indicatepkt_reorder, enqueue_reorder_recvframe fail!\n"); */
 		/* spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql); */
 		/* return _FAIL; */
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto _err_exit;
 	}
 
@@ -2028,8 +1967,6 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 		/* prframe->u.hdr.preorder_ctrl = &precvpriv->recvreorder_ctrl[pattrib->priority]; */
 
 		if (recv_indicatepkt_reorder(padapter, prframe) != _SUCCESS) { /*  including perform A-MPDU Rx Ordering Buffer Control */
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 
 			if ((padapter->bDriverStopped == false) &&
 			    (padapter->bSurpriseRemoved == false)) {
@@ -2040,8 +1977,6 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 	} else { /* B/G mode */
 		retval = wlanhdr_to_ethhdr(prframe);
 		if (retval != _SUCCESS) {
-			#ifdef DBG_RX_DROP_FRAME
-			#endif
 			return retval;
 		}
 
@@ -2084,23 +2019,17 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
 	if (!prframe)	{
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		goto _recv_data_drop;
 	}
 
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
@@ -2109,8 +2038,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
-		#ifdef DBG_RX_DROP_FRAME
-		#endif
 		rtw_free_recvframe(orig_prframe, pfree_recv_queue);/* free this recv_frame */
 		goto _recv_data_drop;
 	}
@@ -2261,9 +2188,6 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 		recvpriv->signal_strength = tmp_s;
 		recvpriv->rssi = (s8)translate_percentage_to_dbm(tmp_s);
 		recvpriv->signal_qual = tmp_q;
-
-		#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
-		#endif
 	}
 
 set_timer:
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 6e5a0841950c..85663182b388 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -244,8 +244,6 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 			preorder_ctrl->enable = false;
 
 			preorder_ctrl->indicate_seq = 0xffff;
-			#ifdef DBG_RX_SEQ
-			#endif
 			preorder_ctrl->wend_b = 0xffff;
 			/* preorder_ctrl->wsize_b = (NR_RECVBUFF-2); */
 			preorder_ctrl->wsize_b = 64;/* 64; */
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 1af4aad59b8f..be65d550d6a0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -480,8 +480,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		pattrib->encrypt = 0;
 
 		if ((pattrib->ether_type != 0x888e) && (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)) {
-			#ifdef DBG_TX_DROP_FRAME
-			#endif
 			res = _FAIL;
 			goto exit;
 		}
@@ -523,8 +521,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		pattrib->icv_len = 4;
 
 		if (psecuritypriv->busetkipkey == _FAIL) {
-			#ifdef DBG_TX_DROP_FRAME
-			#endif
 			res = _FAIL;
 			goto exit;
 		}
@@ -700,8 +696,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 		if (!psta)	{ /*  if we cannot get psta => drop the pkt */
-			#ifdef DBG_TX_DROP_FRAME
-			#endif
 			res = _FAIL;
 			goto exit;
 		} else if ((check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) && (!(psta->state & _FW_LINKED))) {
@@ -712,8 +706,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (!psta) {
 		/*  if we cannot get psta => drop the pkt */
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		res = _FAIL;
 		goto exit;
 	}
@@ -1481,8 +1473,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 
 	if (pxmitbuf) {
 		pxmitpriv->free_xmit_extbuf_cnt--;
-		#ifdef DBG_XMIT_BUF_EXT
-		#endif
 
 		pxmitbuf->priv_data = NULL;
 
@@ -1514,8 +1504,6 @@ s32 rtw_free_xmitbuf_ext(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 
 	list_add_tail(&pxmitbuf->list, get_list_head(pfree_queue));
 	pxmitpriv->free_xmit_extbuf_cnt++;
-	#ifdef DBG_XMIT_BUF_EXT
-	#endif
 
 	spin_unlock_irqrestore(&pfree_queue->lock, irqL);
 
@@ -1545,8 +1533,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 
 	if (pxmitbuf) {
 		pxmitpriv->free_xmitbuf_cnt--;
-		#ifdef DBG_XMIT_BUF
-		#endif
 
 		pxmitbuf->priv_data = NULL;
 
@@ -1559,8 +1545,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
-	#ifdef DBG_XMIT_BUF
-	#endif
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 
@@ -1591,8 +1575,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 			      get_list_head(pfree_xmitbuf_queue));
 
 		pxmitpriv->free_xmitbuf_cnt++;
-		#ifdef DBG_XMIT_BUF
-		#endif
 		spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 	}
 	return _SUCCESS;
@@ -1997,8 +1979,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	res = update_attrib(padapter, *ppkt, &pxmitframe->attrib);
 
 	if (res == _FAIL) {
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 		return -1;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index b18d20242d6d..247cf095d0e1 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -230,8 +230,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 			ptxservq = container_of(sta_plist, struct tx_servq, tx_pending);
 			sta_plist = get_next(sta_plist);
 
-#ifdef DBG_XMIT_BUF
-#endif
 			pframe_queue = &ptxservq->sta_pending;
 
 			frame_phead = get_list_head(pframe_queue);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4506ddf19d17..3514a74068c3 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1162,9 +1162,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 		goto exit;
 	}
 
-#ifdef DEBUG_CFG80211
-#endif
-
 	/* for infra./P2PClient mode */
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 		&& check_fwstate(pmlmepriv, _FW_LINKED)
@@ -1283,9 +1280,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 
 	spin_lock_bh(&pwdev_priv->scan_req_lock);
 	if (pwdev_priv->scan_request) {
-		#ifdef DEBUG_CFG80211
-		#endif
-
 		/* avoid WARN_ON(request != wiphy_to_dev(request->wiphy)->scan_req); */
 		if (pwdev_priv->scan_request->wiphy != pwdev_priv->rtw_wdev->wiphy)
 		{
@@ -1298,8 +1292,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 
 		pwdev_priv->scan_request = NULL;
 	} else {
-		#ifdef DEBUG_CFG80211
-		#endif
 	}
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);
 }
@@ -1437,9 +1429,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 	{
-#ifdef DEBUG_CFG80211
-#endif
-
 		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
 		{
 			DBG_8192C("%s, fwstate = 0x%x\n", __func__, pmlmepriv->fw_state);
@@ -1513,8 +1502,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	/* parsing channels, n_channels */
 	memset(ch, 0, sizeof(struct rtw_ieee80211_channel)*RTW_CHANNEL_SCAN_AMOUNT);
 	for (i = 0; i < request->n_channels && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
-		#ifdef DEBUG_CFG80211
-		#endif
 		ch[i].hw_value = request->channels[i]->hw_value;
 		ch[i].flags = request->channels[i]->flags;
 	}
@@ -2869,9 +2856,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	/* cookie generation */
 	*cookie = (unsigned long) buf;
 
-#ifdef DEBUG_CFG80211
-#endif /* DEBUG_CFG80211 */
-
 	/* indicate ack before issue frame to avoid racing with rsp frame */
 	rtw_cfg80211_mgmt_tx_status(padapter, *cookie, buf, len, ack, GFP_KERNEL);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 5d103d33a128..730c4728ae92 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1161,9 +1161,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	rtw_ps_deny(padapter, PS_DENY_SCAN);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
@@ -1281,9 +1278,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_SCAN);
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	return ret;
 }
 
@@ -1300,9 +1294,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	u32 ret = 0;
 	signed int wait_status;
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	if (adapter_to_pwrctl(padapter)->brfoffbyhw && padapter->bDriverStopped) {
 		ret = -EINVAL;
 		goto exit;
@@ -1348,9 +1339,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 
 exit:
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	return ret;
 
 }
@@ -1375,9 +1363,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	uint ret = 0, len;
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	rtw_ps_deny(padapter, PS_DENY_JOIN);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
 		ret = -1;
@@ -1451,9 +1436,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_JOIN);
 
-	#ifdef DBG_IOCTL
-	#endif
-
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 0c9dfbaafcfd..5e33b6c16157 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -194,8 +194,6 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	s32 res = 0;
 
 	if (rtw_if_up(padapter) == false) {
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		goto drop_packet;
 	}
 
@@ -216,8 +214,6 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 
 	res = rtw_xmit(padapter, &pkt);
 	if (res < 0) {
-		#ifdef DBG_TX_DROP_FRAME
-		#endif
 		goto drop_packet;
 	}
 
-- 
2.20.1

