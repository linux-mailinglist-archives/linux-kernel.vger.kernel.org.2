Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B463A72E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFOATL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:11 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:42638 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhFOATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:07 -0400
Received: by mail-qv1-f54.google.com with SMTP id c10so18698144qvo.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51/w84YNyV+6khlU2yCBT70ZQw1Og3zW89GxaBrA4oM=;
        b=jdb47LSRTwbc5APi6PTnon0s/fQKkmkUIPWRtDcjEEpw5xc7aMu9pE072bbCAY7eQf
         F9IjgyjwpbvMkOgH8TO4sydnK+hV3hdRCfkMyidCSf2nZoW2XcaWwSoBUh1296Hp3Q4K
         kkc6DtfJYsM3Yqxd1I5ZiBtExKwN59NNgrVQuwvq3MFtQUUXkRDJipwJDKbKGOXiHjDN
         Ht284F4TIqOUUpLN2yIvqzVt9HPwR/i8OdQODUycWM2H2LvxYG3QZIZ++IuCnWEoqwJC
         taQfUtcbsOal+ldeY1kUZooQdQObUukBk7C7lpXC4gkxPkQN3cyw+2Owwi6Whjd+UPor
         cubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51/w84YNyV+6khlU2yCBT70ZQw1Og3zW89GxaBrA4oM=;
        b=irBrnUpJrq7GA/RXEXKYqAKyAe+CD3VPGPPiMeNa5yvVoRrJB0GWbgyAXl3vmMJHXo
         Bp9wTJZ1o1Hyb+xUbqUQ1RqugAQkxMVq+4aYaC1/ZG+V19QdpplBrxHplkKdAgUv6Q/v
         42o8g1VEMborVZphH8glbwJ61YHzxQfo/ZKwMNZyCfp6HEItY/CnuRa1SmFTY52kTg/I
         79e5gdu/WluCSYoAFqGwXyESn1/t8vggJXSl6Kxh1ZEx8Z8j/pZQkCfEuUaW4Lw9utG1
         PG0ZT55TTo7WPMFudU3mxm0xF60S/Fmt/7h8y5wO8YRM2lUkP2Nbc/mFv2YZrWtUKoj/
         vWIg==
X-Gm-Message-State: AOAM533hUmYUgHIHyqtS9wI9cwjoT0du0ZQXAvgG7HjvsfwjT+LCiYGM
        O4nQWTWAhr94Y9eB1xuM1iFoRQ8KOLXGcWwb
X-Google-Smtp-Source: ABdhPJx3//SQ1Xdz5GPIZO+BoS1IIFuc1JnPnuTSEusiZmmHdIJqJfR2o+uPDQPRSoaQ3o4izGXrqw==
X-Received: by 2002:ad4:4c51:: with SMTP id cs17mr1575961qvb.57.1623716152393;
        Mon, 14 Jun 2021 17:15:52 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:51 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 10/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_mlme.c
Date:   Tue, 15 Jun 2021 01:14:49 +0100
Message-Id: <20210615001507.1171-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_mlme.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 54 +----------------------
 1 file changed, 2 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 01bbfd29488f..9ab3c6fbf268 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -506,10 +506,8 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 			bselected = false;
 	}
 
-	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
-		DBG_88E("desired_encmode: %d, privacy: %d\n", desired_encmode, privacy);
+	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0))
 		bselected = false;
-	}
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode != pmlmepriv->cur_network.network.InfrastructureMode)
@@ -637,7 +635,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
 			} else {
-				DBG_88E("try_to_join, but select scanning queue fail, to_roaming:%d\n", pmlmepriv->to_roaming);
 				if (pmlmepriv->to_roaming != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
 					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0) != _SUCCESS) {
@@ -823,7 +820,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
 
 	if (psta) { /* update ptarget_sta */
-		DBG_88E("%s\n", __func__);
 		psta->aid  = pnetwork->join_res;
 		psta->mac_id = 0;
 		/* sta mode */
@@ -886,8 +882,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 
-	DBG_88E("%s\n", __func__);
-
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 		 ("\nfw_state:%x, BSSID:%pM\n",
 		 get_fwstate(pmlmepriv), pnetwork->network.MacAddress));
@@ -1152,7 +1146,6 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	/* to do: init sta_info variable */
 	psta->qos_option = 0;
 	psta->mac_id = (uint)pstassoc->cam_id;
-	DBG_88E("%s\n", __func__);
 	/* for ad-hoc mode */
 	rtw_hal_set_odm_var(adapter, HAL_ODM_STA_INFO, psta, true);
 	rtw_stassoc_hw_rpt(adapter, psta);
@@ -1194,8 +1187,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	else
 		mac_id = pstadel->mac_id;
 
-	DBG_88E("%s(mac_id=%d)=%pM\n", __func__, mac_id, pstadel->macaddr);
-
 	if (mac_id >= 0) {
 		u16 media_status;
 
@@ -1288,8 +1279,6 @@ void _rtw_join_timeout_handler (struct timer_list *t)
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 	int do_join_r;
 
-	DBG_88E("%s, fw_state=%x\n", __func__, get_fwstate(pmlmepriv));
-
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
@@ -1299,15 +1288,11 @@ void _rtw_join_timeout_handler (struct timer_list *t)
 		while (1) {
 			pmlmepriv->to_roaming--;
 			if (pmlmepriv->to_roaming != 0) { /* try another , */
-				DBG_88E("%s try another roaming\n", __func__);
 				do_join_r = rtw_do_join(adapter);
-				if (do_join_r != _SUCCESS) {
-					DBG_88E("%s roaming do_join return %d\n", __func__, do_join_r);
+				if (do_join_r != _SUCCESS)
 					continue;
-				}
 				break;
 			}
-			DBG_88E("%s We've try roaming but fail\n", __func__);
 			rtw_indicate_disconnect(adapter);
 			break;
 		}
@@ -1328,7 +1313,6 @@ void rtw_scan_timeout_handler (struct timer_list *t)
 					     mlmepriv.scan_to_timer);
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	DBG_88E(FUNC_ADPT_FMT" fw_state=%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
 	spin_lock_bh(&pmlmepriv->lock);
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -1343,7 +1327,6 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 	if (pmlmepriv->scan_interval > 0) {
 		pmlmepriv->scan_interval--;
 		if (pmlmepriv->scan_interval == 0) {
-			DBG_88E("%s\n", __func__);
 			rtw_set_802_11_bssid_list_scan(padapter, NULL, 0);
 			pmlmepriv->scan_interval = SCAN_INTERVAL;/*  30*2 sec = 60sec */
 		}
@@ -1417,15 +1400,6 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 		*candidate = competitor;
 		updated = true;
 	}
-	if (updated) {
-		DBG_88E("[by_bssid:%u][assoc_ssid:%s]new candidate: %s(%pM rssi:%d\n",
-			pmlmepriv->assoc_by_bssid,
-			pmlmepriv->assoc_ssid.ssid,
-			(*candidate)->network.ssid.ssid,
-			(*candidate)->network.MacAddress,
-			(int)(*candidate)->network.Rssi);
-		DBG_88E("[to_roaming:%u]\n", pmlmepriv->to_roaming);
-	}
 
 exit:
 	return updated;
@@ -1456,19 +1430,12 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
 	if (!candidate) {
-		DBG_88E("%s: return _FAIL(candidate==NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
-	} else {
-		DBG_88E("%s: candidate: %s(%pM ch:%u)\n", __func__,
-			candidate->network.ssid.ssid, candidate->network.MacAddress,
-			candidate->network.Configuration.DSConfig);
 	}
 
 	/*  check for situation of  _FW_LINKED */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-		DBG_88E("%s: _FW_LINKED while ask_for_joinbss!!!\n", __func__);
-
 		rtw_disassoc_cmd(adapter, 0, true);
 		rtw_indicate_disconnect(adapter);
 		rtw_free_assoc_resources_locked(adapter);
@@ -1479,10 +1446,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		u8 cur_ant;
 
 		rtw_hal_get_def_var(adapter, HAL_DEF_CURRENT_ANTENNA, &(cur_ant));
-		DBG_88E("#### Opt_Ant_(%s), cur_Ant(%s)\n",
-			(candidate->network.PhyInfo.Optimum_antenna == 2) ? "A" : "B",
-			(cur_ant == 2) ? "A" : "B"
-		);
 	}
 
 	ret = rtw_joinbss_cmd(adapter, candidate);
@@ -1559,9 +1522,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	psetkeyparm->keyid = (u8)keyid;/* 0~3 */
 	psetkeyparm->set_tx = set_tx;
 	pmlmepriv->key_mask |= BIT(psetkeyparm->keyid);
-	DBG_88E("==> %s algorithm(%x), keyid(%x), key_mask(%x)\n",
-		__func__, psetkeyparm->algorithm, psetkeyparm->keyid,
-		pmlmepriv->key_mask);
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
 		 ("\n %s: psetkeyparm->algorithm=%d psetkeyparm->keyid=(u8)keyid=%d\n",
 		  __func__, psetkeyparm->algorithm, keyid));
@@ -1915,8 +1875,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 	if ((!pmlmeinfo->HT_info_enable) || (!pmlmeinfo->HT_caps_enable))
 		return;
 
-	DBG_88E("+%s()\n", __func__);
-
 	/* maybe needs check if ap supports rx ampdu. */
 	if ((!phtpriv->ampdu_enable) && (pregistrypriv->ampdu_enable == 1)) {
 		if (pregistrypriv->wifi_spec == 1)
@@ -1953,8 +1911,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
 
 	/*  Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.cap_info) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
 
 	/*  Config current HT Protection mode. */
 	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
@@ -1989,7 +1945,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
 		if (issued == 0) {
-			DBG_88E("%s, p=%d\n", __func__, priority);
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -2017,9 +1972,6 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 		pnetwork = &pmlmepriv->cur_network;
 
 	if (pmlmepriv->to_roaming > 0) {
-		DBG_88E("roaming from %s(%pM length:%d\n",
-			pnetwork->network.ssid.ssid, pnetwork->network.MacAddress,
-			pnetwork->network.ssid.ssid_length);
 		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
@@ -2029,13 +1981,11 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 			if (do_join_r == _SUCCESS)
 				break;
 
-			DBG_88E("roaming do_join return %d\n", do_join_r);
 			pmlmepriv->to_roaming--;
 
 			if (pmlmepriv->to_roaming > 0) {
 				continue;
 			} else {
-				DBG_88E("%s(%d) -to roaming fail, indicate_disconnect\n", __func__, __LINE__);
 				rtw_indicate_disconnect(padapter);
 				break;
 			}
-- 
2.30.2

