Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2BC3A72D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFOARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFOARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:17:41 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D5C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c5so3124354qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIJ1eqhDdC4jg+M3SYwwoFPfAsCSNEutnuADy5OsLho=;
        b=d7YlFj3FT/NxWjBovWsVkRiZjSCd3fVla0SuVhYYocFkWI1Msb7LJt4hSDuNz3QMaO
         5KPCWXc1jzYRSFzMpPHxohKlt3MehfZkY3ADfsfkAmlJ2dUj/LCGdfJTZ17AggtfIO6A
         c6akGWPAY1oADypb2vtyWGiV9CNR/i8uLroenE3kbUthBDN2350s8QkQ5QI4wnbmnR+f
         Wem06E+MYTE1eTPYM9A9f2vAqkXYv3TYCl0HQJ4CLyqibVt7kCjVGFWcHI/jA/C2kGIf
         bG+r6Z6EKE1rLVCpC7mYI6PFjq1pq4NGeU56v6S5NzWlaCy8A+JrroFoskvqJerrtWHh
         Mlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIJ1eqhDdC4jg+M3SYwwoFPfAsCSNEutnuADy5OsLho=;
        b=htiMTgWoOpuIYDsFdLNBSUOdywQaEdQSfoaFSR2/7a5VLebnocRjOCcM2Xhmjno+Ge
         rWZaphUvIiyCoTcIW4GvCgCQHYEtCCho5xYZ64402Lcwud+ZmZZ6jWCS5XnmfpP8yOuh
         pLUWfconMAUNMkZ8Ww26/Ylx5MR38iQKkkDdl/tw5E/IQxn0SImRSBBmYrEZPd6ASk0W
         qcWngJWILW8ztidNYzZGFMDISeHMnvCkJhCdM+5uUGShQmi3ZFQJuwmZbtlVGJ54Vy3j
         fg4IbvK7e3FNu0aWfC31I9XptY0k25DlwLOGKllj00h0BSFbVYyGzTtcq5Q7v+N1wwM7
         gylg==
X-Gm-Message-State: AOAM532JJ88wciNWkzha/lNl0vmYvBEEQqO+8GZ665axrgOTtGZzriXp
        qZfiaZlxcev4UHPcBr5CNiR/tg==
X-Google-Smtp-Source: ABdhPJyUQi5Hbozf+Sqh4tJDlOpNHmwspsYu/0rH1WbRR2cuqZHHNd5FjB3MUaGJOjORVBtdmbJB9A==
X-Received: by 2002:a37:b8f:: with SMTP id 137mr19258971qkl.488.1623716133379;
        Mon, 14 Jun 2021 17:15:33 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:33 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 03/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_mlme_ext.c
Date:   Tue, 15 Jun 2021 01:14:42 +0100
Message-Id: <20210615001507.1171-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_mlme_ext.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself. Also remove variable declarations for variables which now go
unused as a result of this change with core/rtw_mlme_ext.c

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 262 ++----------------
 1 file changed, 20 insertions(+), 242 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 507672120cbc..6107257900c2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -149,14 +149,11 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 	struct xmit_buf *pxmitbuf;
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (!pmgntframe) {
-		DBG_88E("%s, alloc xmitframe fail\n", __func__);
+	if (!pmgntframe)
 		return NULL;
-	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (!pxmitbuf) {
-		DBG_88E("%s, alloc xmitbuf fail\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		return NULL;
 	}
@@ -178,7 +175,6 @@ void update_mgnt_tx_rate(struct adapter *padapter, u8 rate)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	pmlmeext->tx_rate = rate;
-	DBG_88E("%s(): rate = %x\n", __func__, rate);
 }
 
 void update_mgntframe_attrib(struct adapter *padapter, struct pkt_attrib *pattrib)
@@ -317,10 +313,8 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
-		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
+	if (!pmgntframe)
 		return;
-	}
 #if defined(CONFIG_88EU_AP_MODE)
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
 #endif
@@ -428,14 +422,11 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 #endif
 
-	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
-		DBG_88E("beacon frame too large\n");
+	if ((pattrib->pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	/* DBG_88E("issue bcn_sz=%d\n", pattrib->last_txcmdsz); */
 	if (timeout_ms > 0)
 		dump_mgntframe_and_wait(padapter, pmgntframe, timeout_ms);
 	else
@@ -462,10 +453,8 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 	unsigned int rate_len;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (!pmgntframe) {
-		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
+	if (!pmgntframe)
 		return;
-	}
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -687,7 +676,6 @@ static int issue_probereq_ex(struct adapter *padapter,
 {
 	int ret;
 	int i = 0;
-	unsigned long start = jiffies;
 
 	do {
 		ret = issue_probereq(padapter, pssid, da, wait_ms > 0);
@@ -706,19 +694,6 @@ static int issue_probereq_ex(struct adapter *padapter,
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-	}
 exit:
 	return ret;
 }
@@ -864,7 +839,6 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	rtw_wep_encrypt(padapter, pmgntframe);
-	DBG_88E("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
 }
 
@@ -886,8 +860,6 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 	u8 *ie = pnetwork->ies;
 	__le16 lestatus, leval;
 
-	DBG_88E("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -1065,7 +1037,6 @@ static void issue_assocreq(struct adapter *padapter)
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
 		if (pmlmeinfo->network.SupportedRates[i] == 0)
 			break;
-		DBG_88E("network.SupportedRates[%d]=%02X\n", i, pmlmeinfo->network.SupportedRates[i]);
 	}
 
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
@@ -1080,17 +1051,12 @@ static void issue_assocreq(struct adapter *padapter)
 				break;
 		}
 
-		if (j == sta_bssrate_len) {
-			/*  the rate is not supported by STA */
-			DBG_88E("%s(): the rate[%d]=%02X is not supported by STA!\n", __func__, i, pmlmeinfo->network.SupportedRates[i]);
-		} else {
+		if (j != sta_bssrate_len)
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
-		}
 	}
 
 	bssrate_len = index;
-	DBG_88E("bssrate_len=%d\n", bssrate_len);
 
 	if (bssrate_len == 0) {
 		rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
@@ -1250,7 +1216,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da,
 {
 	int ret;
 	int i = 0;
-	unsigned long start = jiffies;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
@@ -1275,19 +1240,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da,
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-	}
 exit:
 	return ret;
 }
@@ -1308,8 +1260,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
-	DBG_88E("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		goto exit;
@@ -1379,7 +1329,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 {
 	int ret;
 	int i = 0;
-	unsigned long start = jiffies;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
@@ -1404,19 +1353,6 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-	}
 exit:
 	return ret;
 }
@@ -1484,7 +1420,6 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 int issue_deauth(struct adapter *padapter, unsigned char *da,
 		 unsigned short reason)
 {
-	DBG_88E("%s to %pM\n", __func__, da);
 	return _issue_deauth(padapter, da, reason, false);
 }
 
@@ -1494,7 +1429,6 @@ static int issue_deauth_ex(struct adapter *padapter, u8 *da,
 {
 	int ret;
 	int i = 0;
-	unsigned long start = jiffies;
 
 	do {
 		ret = _issue_deauth(padapter, da, reason, wait_ms > 0);
@@ -1512,19 +1446,6 @@ static int issue_deauth_ex(struct adapter *padapter, u8 *da,
 		ret = _SUCCESS;
 		goto exit;
 	}
-
-	if (try_cnt && wait_ms) {
-		if (da)
-			DBG_88E(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), da, rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-		else
-			DBG_88E(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS ? ", acked" : "", i, try_cnt,
-				jiffies_to_msecs(jiffies - start));
-	}
 exit:
 	return ret;
 }
@@ -1553,8 +1474,6 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 	struct registry_priv *pregpriv = &padapter->registrypriv;
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 
-	DBG_88E("%s, category=%d, action=%d, status=%d\n", __func__, category, action, status);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -1607,8 +1526,6 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07] & 0xfff) + 1;
 
-				DBG_88E("BA_starting_seqctrl=%d for TID=%d\n", start_seq, status & 0x07);
-
 				psta->BA_starting_seqctrl[status & 0x07] = start_seq;
 
 				BA_starting_seqctrl = start_seq << 4;
@@ -1707,8 +1624,6 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	if (pmlmeinfo->bwmode_updated)
 		return;
 
-	DBG_88E("%s\n", __func__);
-
 	category = RTW_WLAN_CATEGORY_PUBLIC;
 	action = ACT_PUBLIC_BSSCOEXIST;
 
@@ -1829,7 +1744,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				DBG_88E("rx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
@@ -1838,7 +1752,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				DBG_88E("tx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
@@ -1870,17 +1783,10 @@ unsigned int send_beacon(struct adapter *padapter)
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return _FAIL;
-	if (!bxmitok) {
-		DBG_88E("%s fail! %u ms\n", __func__,
-			jiffies_to_msecs(jiffies - start));
+	if (!bxmitok)
 		return _FAIL;
-	}
 	passing_time = jiffies_to_msecs(jiffies - start);
 
-	if (passing_time > 100 || issue > 3)
-		DBG_88E("%s success, issue:%d, poll:%d, %u ms\n",
-			__func__, issue, poll,
-			jiffies_to_msecs(jiffies - start));
 	return _SUCCESS;
 }
 
@@ -2051,16 +1957,12 @@ static u8 collect_bss_info(struct adapter *padapter,
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_SSID, &len, bssid->ie_length - ie_offset);
-	if (!p) {
-		DBG_88E("marc: cannot find SSID for survey event\n");
+	if (!p)
 		return _FAIL;
-	}
 
 	if (len) {
-		if (len > NDIS_802_11_LENGTH_SSID) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
-		}
 		memcpy(bssid->ssid.ssid, (p + 2), len);
 		bssid->ssid.ssid_length = len;
 	} else {
@@ -2073,20 +1975,16 @@ static u8 collect_bss_info(struct adapter *padapter,
 	i = 0;
 	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_SUPP_RATES, &len, bssid->ie_length - ie_offset);
 	if (p) {
-		if (len > NDIS_802_11_LENGTH_RATES_EX) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+		if (len > NDIS_802_11_LENGTH_RATES_EX)
 			return _FAIL;
-		}
 		memcpy(bssid->SupportedRates, (p + 2), len);
 		i = len;
 	}
 
 	p = rtw_get_ie(bssid->ies + ie_offset, WLAN_EID_EXT_SUPP_RATES, &len, bssid->ie_length - ie_offset);
 	if (p) {
-		if (len > (NDIS_802_11_LENGTH_RATES_EX - i)) {
-			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
+		if (len > (NDIS_802_11_LENGTH_RATES_EX - i))
 			return _FAIL;
-		}
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
 	}
 
@@ -2213,7 +2111,6 @@ static void start_create_ibss(struct adapter *padapter)
 			pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
 		}
 	} else {
-		DBG_88E("%s, invalid cap:%x\n", __func__, caps);
 		return;
 	}
 }
@@ -2329,8 +2226,6 @@ static unsigned int receive_disconnect(struct adapter *padapter,
 	if (memcmp(MacAddr, pnetwork->MacAddress, ETH_ALEN))
 		return _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
@@ -2652,25 +2547,18 @@ static unsigned int OnAuth(struct adapter *padapter,
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
-	DBG_88E("+%s\n", __func__);
-
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
 	seq = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + 2));
 	algorithm = le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("auth alg=%x, seq=%X\n", algorithm, seq);
-
 	if (auth_mode == 2 && psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
 	    psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
 		auth_mode = 0;
 
 	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
 	    (algorithm == 0 && auth_mode == 1)) {	/*  rx a open-system auth but shared-key is enabled */
-		DBG_88E("auth rejected due to bad alg [alg=%d, auth_mib=%d] %02X%02X%02X%02X%02X%02X\n",
-			algorithm, auth_mode, sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);
-
 		status = WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG;
 
 		goto auth_fail;
@@ -2684,10 +2572,8 @@ static unsigned int OnAuth(struct adapter *padapter,
 	pstat = rtw_get_stainfo(pstapriv, sa);
 	if (!pstat) {
 		/*  allocate a new one */
-		DBG_88E("going to alloc stainfo for sa=%pM\n", sa);
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
 		if (!pstat) {
-			DBG_88E(" Exceed the upper limit of supported clients...\n");
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 			goto auth_fail;
 		}
@@ -2718,8 +2604,6 @@ static unsigned int OnAuth(struct adapter *padapter,
 		pstat->expire_to = pstapriv->auth_to;
 
 	if ((pstat->auth_seq + 1) != seq) {
-		DBG_88E("(1)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-			seq, pstat->auth_seq + 1);
 		status = WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION;
 		goto auth_fail;
 	}
@@ -2731,8 +2615,6 @@ static unsigned int OnAuth(struct adapter *padapter,
 			pstat->expire_to = pstapriv->assoc_to;
 			pstat->authalg = algorithm;
 		} else {
-			DBG_88E("(2)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq + 1);
 			status = WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION;
 			goto auth_fail;
 		}
@@ -2746,13 +2628,10 @@ static unsigned int OnAuth(struct adapter *padapter,
 			pstat->auth_seq = 2;
 		} else if (seq == 3) {
 			/* checking for challenging txt... */
-			DBG_88E("checking for challenging txt...\n");
-
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, &ie_len,
 				       len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if (!p || ie_len <= 0) {
-				DBG_88E("auth rejected because challenge failure!(1)\n");
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
@@ -2763,13 +2642,10 @@ static unsigned int OnAuth(struct adapter *padapter,
 				/*  challenging txt is correct... */
 				pstat->expire_to =  pstapriv->assoc_to;
 			} else {
-				DBG_88E("auth rejected because challenge failure!\n");
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
 		} else {
-			DBG_88E("(3)auth rejected because out of seq [rx_seq=%d, exp_seq=%d]!\n",
-				seq, pstat->auth_seq + 1);
 			status = WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION;
 			goto auth_fail;
 		}
@@ -2812,8 +2688,6 @@ static unsigned int OnAuthClient(struct adapter *padapter,
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), ieee80211_get_DA((struct ieee80211_hdr *)pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -2827,7 +2701,6 @@ static unsigned int OnAuthClient(struct adapter *padapter,
 	status	= le16_to_cpu(*(__le16 *)((size_t)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
 	if (status != 0) {
-		DBG_88E("clnt auth fail, status: %d\n", status);
 		if (status == 13) { /*  pmlmeinfo->auth_algo == dot11AuthAlgrthm_Auto) */
 			if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 				pmlmeinfo->auth_algo = dot11AuthAlgrthm_Open;
@@ -2911,11 +2784,8 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		ie_offset = _REASOCREQ_IE_OFFSET_;
 	}
 
-	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset) {
-		DBG_88E("handle_assoc(reassoc=%d) - too short payload (len=%lu)"
-		       "\n", reassoc, (unsigned long)pkt_len);
+	if (pkt_len < IEEE80211_3ADDR_LEN + ie_offset)
 		return _FAIL;
-	}
 
 	pstat = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 	if (!pstat) {
@@ -2928,8 +2798,6 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	left = pkt_len - (IEEE80211_3ADDR_LEN + ie_offset);
 	pos = pframe + (IEEE80211_3ADDR_LEN + ie_offset);
 
-	DBG_88E("%s\n", __func__);
-
 	/*  check if this stat has been successfully authenticated/assocated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
@@ -2947,8 +2815,6 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	/* now parse all ieee802_11 ie to point to elems */
 	if (rtw_ieee802_11_parse_elems(pos, left, &elems, 1) == ParseFailed ||
 	    !elems.ssid) {
-		DBG_88E("STA %pM sent invalid association request\n",
-			pstat->hwaddr);
 		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
 		goto OnAssocReqFail;
 	}
@@ -2977,7 +2843,6 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, WLAN_EID_SUPP_RATES, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 	if (!p) {
-		DBG_88E("Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
 		/* supportRateNum = AP_BSSRATE_LEN; */
@@ -3068,17 +2933,11 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
 	if (!wpa_ie) {
 		if (elems.wps_ie) {
-			DBG_88E("STA included WPS IE in "
-				   "(Re)Association Request - assume WPS is "
-				   "used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			/* wpabuf_free(sta->wps_ie); */
 			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
 			/*				elems.wps_ie_len - 4); */
 		} else {
-			DBG_88E("STA did not include WPA/RSN IE "
-				   "in (Re)Association Request - possible WPS "
-				   "use\n");
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
 		}
 
@@ -3091,8 +2950,6 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
 
 				if (!selected_registrar) {
-					DBG_88E("selected_registrar is false , or AP is not ready to do WPS\n");
-
 					status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 					goto OnAssocReqFail;
@@ -3103,18 +2960,12 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		int copy_len;
 
 		if (psecuritypriv->wpa_psk == 0) {
-			DBG_88E("STA %pM: WPA/RSN IE in association "
-			"request, but AP don't support WPA/RSN\n", pstat->hwaddr);
-
 			status = WLAN_STATUS_INVALID_IE;
 
 			goto OnAssocReqFail;
 		}
 
 		if (elems.wps_ie) {
-			DBG_88E("STA included WPS IE in "
-				   "(Re)Association Request - WPS is "
-				   "used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			copy_len = 0;
 		} else {
@@ -3198,16 +3049,6 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		goto OnAssocReqFail;
 	}
 
-	if ((pstat->flags & WLAN_STA_HT) &&
-	    ((pstat->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
-	    (pstat->wpa_pairwise_cipher & WPA_CIPHER_TKIP))) {
-		DBG_88E("HT: %pM tried to "
-			"use TKIP with HT association\n", pstat->hwaddr);
-
-		/* status = WLAN_STATUS_CIPHER_REJECTED_PER_POLICY; */
-		/* goto OnAssocReqFail; */
-	}
-
 	pstat->flags |= WLAN_STA_NONERP;
 	for (i = 0; i < pstat->bssratelen; i++) {
 		if ((pstat->bssrateset[i] & 0x7f) > 22) {
@@ -3231,9 +3072,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 	/*  Customer proprietary IE */
 
 	/* get a unique AID */
-	if (pstat->aid > 0) {
-		DBG_88E("  old AID %d\n", pstat->aid);
-	} else {
+	if (pstat->aid <= 0) {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (!pstapriv->sta_aid[pstat->aid - 1])
 				break;
@@ -3242,14 +3081,11 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		if (pstat->aid > pstapriv->max_num_sta) {
 			pstat->aid = 0;
 
-			DBG_88E("  no room for more AIDs\n");
-
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 			goto OnAssocReqFail;
 		} else {
 			pstapriv->sta_aid[pstat->aid - 1] = pstat;
-			DBG_88E("allocate new AID=(%d)\n", pstat->aid);
 		}
 	}
 
@@ -3284,7 +3120,6 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 			issue_asocrsp(padapter, status, pstat, IEEE80211_STYPE_REASSOC_RESP);
 
 		/* 2 - report to upper layer */
-		DBG_88E("indicate_sta_join_event to upper layer - hostapd\n");
 		rtw_indicate_sta_assoc_event(padapter, pstat);
 
 		/* 3-(1) report sta add event */
@@ -3325,8 +3160,6 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 	u8 *pframe = precv_frame->pkt->data;
 	uint pkt_len = precv_frame->pkt->len;
 
-	DBG_88E("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), ieee80211_get_DA((struct ieee80211_hdr *)pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -3342,7 +3175,6 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
 	if (status > 0) {
-		DBG_88E("assoc reject, status code: %d\n", status);
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		res = -4;
 		goto report_assoc_result;
@@ -3417,8 +3249,6 @@ static unsigned int OnDeAuth(struct adapter *padapter,
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("%s Reason code(%d)\n", __func__, reason);
-
 #ifdef CONFIG_88EU_AP_MODE
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
@@ -3470,8 +3300,6 @@ static unsigned int OnDisassoc(struct adapter *padapter,
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_88E("%s Reason code(%d)\n", __func__, reason);
-
 #ifdef CONFIG_88EU_AP_MODE
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
@@ -3510,7 +3338,6 @@ static unsigned int OnDisassoc(struct adapter *padapter,
 static unsigned int OnAtim(struct adapter *padapter,
 			   struct recv_frame *precv_frame)
 {
-	DBG_88E("%s\n", __func__);
 	return _SUCCESS;
 }
 
@@ -3524,8 +3351,6 @@ static unsigned int on_action_spct(struct adapter *padapter,
 	u8 category;
 	u8 action;
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
 	if (!psta)
@@ -3583,8 +3408,6 @@ static unsigned int OnAction_back(struct adapter *padapter,
 		   ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		if (!(pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS))
 			return _SUCCESS;
@@ -3602,7 +3425,6 @@ static unsigned int OnAction_back(struct adapter *padapter,
 		if (!pmlmeinfo->HT_enable)
 			return _SUCCESS;
 		action = frame_body[1];
-		DBG_88E("%s, action=%d\n", __func__, action);
 		switch (action) {
 		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
 			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
@@ -3617,7 +3439,6 @@ static unsigned int OnAction_back(struct adapter *padapter,
 			status = get_unaligned_le16(&frame_body[3]);
 			tid = (frame_body[5] >> 2) & 0x7;
 			if (status == 0) {	/* successful */
-				DBG_88E("agg_enable for TID=%d\n", tid);
 				psta->htpriv.agg_enable_bitmap |= 1 << tid;
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			} else {
@@ -3635,7 +3456,6 @@ static unsigned int OnAction_back(struct adapter *padapter,
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 			}
-			DBG_88E("%s(): DELBA: %x(%x)\n", __func__, pmlmeinfo->agg_enable_bitmap, reason_code);
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
 		default:
@@ -3655,17 +3475,11 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 
 	if (GetRetry(frame)) {
 		if (token >= 0) {
-			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token)) {
-				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq, token);
+			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token))
 				return _FAIL;
-			}
 		} else {
-			if (seq_ctrl == mlmeext->action_public_rxseq) {
-				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq);
+			if (seq_ctrl == mlmeext->action_public_rxseq)
 				return _FAIL;
-			}
 		}
 	}
 
@@ -3968,10 +3782,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan,
 
 	memset(channel_set, 0, sizeof(struct rt_channel_info) * MAX_CHANNEL_NUM);
 
-	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
-		DBG_88E("ChannelPlan ID %x error !!!!!\n", ChannelPlan);
+	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 		return chanset_size;
-	}
 
 	if (padapter->registrypriv.wireless_mode & WIRELESS_11G) {
 		b2_4GBand = true;
@@ -4099,12 +3911,9 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	if (psta) {
 		if (GetRetry(pframe)) {
 			if (precv_frame->attrib.seq_num ==
-			    psta->RxMgmtFrameSeqNum) {
+			    psta->RxMgmtFrameSeqNum)
 				/* drop the duplicate management frame */
-				DBG_88E("Drop duplicate management frame with seq_num=%d.\n",
-					precv_frame->attrib.seq_num);
 				return;
-			}
 		}
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
@@ -4234,8 +4043,6 @@ void report_surveydone_event(struct adapter *padapter)
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
 
-	DBG_88E("survey done event(%x)\n", psurveydone_evt->bss_cnt);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -4280,8 +4087,6 @@ void report_join_res(struct adapter *padapter, int res)
 	pjoinbss_evt->network.join_res	= res;
 	pjoinbss_evt->network.aid = res;
 
-	DBG_88E("%s(%d)\n", __func__, res);
-
 	rtw_joinbss_event_prehandle(padapter, (u8 *)&pjoinbss_evt->network);
 
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
@@ -4337,8 +4142,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 
 	pdel_sta_evt->mac_id = mac_id;
 
-	DBG_88E("%s: delete STA, mac_id =%d\n", __func__, mac_id);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -4382,8 +4185,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	ether_addr_copy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr);
 	padd_sta_evt->cam_id = cam_idx;
 
-	DBG_88E("%s: add STA\n", __func__);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -4510,8 +4311,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
 
 exit_mlmeext_joinbss_event_callback:
-
-	DBG_88E("=>%s\n", __func__);
+	return;
 }
 
 void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
@@ -4520,8 +4320,6 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 join_type;
 
-	DBG_88E("%s\n", __func__);
-
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {/* adhoc master or sta_count>1 */
 			/* nothing to do */
@@ -4734,8 +4532,6 @@ void survey_timer_hdl(struct timer_list *t)
 
 		if (pmlmeext->scan_abort) {
 			pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-			DBG_88E("%s idx:%d\n", __func__
-				, pmlmeext->sitesurvey_res.channel_idx);
 
 			pmlmeext->scan_abort = false;/* reset */
 		}
@@ -4766,7 +4562,6 @@ void link_timer_hdl(struct timer_list *t)
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
-		DBG_88E("%s:no beacon while connecting\n", __func__);
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		report_join_res(padapter, -3);
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
@@ -4777,7 +4572,6 @@ void link_timer_hdl(struct timer_list *t)
 			return;
 		}
 
-		DBG_88E("%s: auth timeout and try again\n", __func__);
 		pmlmeinfo->auth_seq = 1;
 		issue_auth(padapter, NULL, 0);
 		set_link_timer(pmlmeext, REAUTH_TO);
@@ -4789,7 +4583,6 @@ void link_timer_hdl(struct timer_list *t)
 			return;
 		}
 
-		DBG_88E("%s: assoc timeout and try again\n", __func__);
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
@@ -4981,9 +4774,8 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 					default:
 						pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 						break;
-				}
+					}
 
-					DBG_88E("set ch/bw before connected\n");
 				}
 			}
 			break;
@@ -5239,24 +5031,16 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 		if (psta) {
 			ctrl = BIT(15) | ((pparm->algorithm) << 2);
 
-			DBG_88E("r871x_set_stakey_hdl(): enc_algorithm=%d\n", pparm->algorithm);
-
-			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4))) {
-				DBG_88E("r871x_set_stakey_hdl():set_stakey failed, mac_id(aid)=%d\n", psta->mac_id);
+			if ((psta->mac_id < 1) || (psta->mac_id > (NUM_STA - 4)))
 				return H2C_REJECTED;
-			}
 
 			cam_id = psta->mac_id + 3;/* 0~3 for default key, cmd_id = macid + 3, macid = aid+1; */
 
-			DBG_88E("Write CAM, mac_addr =%pM, cam_entry=%d\n",
-				pparm->addr, cam_id);
-
 			write_cam(padapter, cam_id, ctrl, pparm->addr, pparm->key);
 
 			return H2C_SUCCESS_RSP;
 		}
 
-		DBG_88E("r871x_set_stakey_hdl(): sta has been free\n");
 		return H2C_REJECTED;
 	}
 
@@ -5369,10 +5153,8 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	if (send_beacon(padapter) == _FAIL) {
-		DBG_88E("issue_beacon, fail!\n");
+	if (send_beacon(padapter) == _FAIL)
 		return H2C_PARAMETERS_ERROR;
-	}
 #ifdef CONFIG_88EU_AP_MODE
 	else { /* tx bc/mc frames after update TIM */
 		struct sta_info *psta_bmc;
@@ -5426,10 +5208,6 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 
 	set_ch_parm = (struct set_ch_parm *)pbuf;
 
-	DBG_88E(FUNC_NDEV_FMT" ch:%u, bw:%u, ch_offset:%u\n",
-		FUNC_NDEV_ARG(padapter->pnetdev),
-		set_ch_parm->ch, set_ch_parm->bw, set_ch_parm->ch_offset);
-
 	pmlmeext->cur_channel = set_ch_parm->ch;
 	pmlmeext->cur_ch_offset = set_ch_parm->ch_offset;
 	pmlmeext->cur_bwmode = set_ch_parm->bw;
-- 
2.30.2

