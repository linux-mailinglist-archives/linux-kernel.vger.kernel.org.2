Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50E03D0FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhGUM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbhGUM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B2C0613E1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x17so2398900edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBWS7aczSFgadHdC3sXEqyKsVkkM+fKmssWVRTKStfU=;
        b=pbNB/dUVH7Eb/7R8D9cZ5EdvCdIKecFxRdCCaCO8VH3zYvF+35tu7YaCZa9qMPdqyp
         WRJloBNCvz8RgTqULCSaOJn5cCM+vuZSNXrYK2u85tjhh6ohLNCPJcqDxQb8c8uKjFMi
         Rg5uEniAPNQ+GdmZFZcAX3d7Gcy9hwcq8flqpzB711xbMYIQTJH9dkKJHv0vYBc7zeZn
         e5rSJCfRwIhr1xmlDSaBD378DIf8Bz87fk6Gcvr/T5ikYMpiT4maVIxEbHQKr5tIQ2oQ
         VziPSyLSBK5lWk+mOJ7vJeGaKoF3/Mr1Vjo/+CvLnyT2Ggqwq3ynnb2MQ1gLTGtYVLml
         Dz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBWS7aczSFgadHdC3sXEqyKsVkkM+fKmssWVRTKStfU=;
        b=V+1p/B6/tV5eBIvrcEUhjpqNTYTQyQP7u/6HA/GUBOSumPTH8Uekk/fz4967FkGv32
         6J8lEhlVXwsmTnuwLd9iavh3WtBzQvcrOlz7ImSBjPN6Fpeu1VzooDPboGDfrg+K6BEm
         nNvpbh+myTqvP0Ng60jHpXjD70gZux4u2SCi0cM2en+kdP0+uwV1yJ5THF9NGVPoSbve
         X1vJ+uYvfbNXQj1sbPSLHBIv6Nc1uChFEcwAbP4OqS6iocuyoaCzZfeg8Z1o2JRhFeD/
         OCKQta65D+rLmn03odp0FTHtL38sGGObwz93POlfRud3YopMGc/Ea7trmOoayqknIMBG
         pwIA==
X-Gm-Message-State: AOAM531nDSwReEaFAvaBobrzgSnUKjQ0Y43W9WP9m5C0sMl8KRvf1bkQ
        Dt0mG2V31AFEP5XhS/H1WzzBrEDHv/4=
X-Google-Smtp-Source: ABdhPJwbyVk+ATDrkvs6a+mrwOdqBl5D1xegrdKj9e2CeLe/lYdSD+nug/10vdBHic9/INYdHc0AMw==
X-Received: by 2002:aa7:dd1a:: with SMTP id i26mr37939043edv.192.1626874660297;
        Wed, 21 Jul 2021 06:37:40 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id p26sm8402853ejd.80.2021.07.21.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] staging: rtl8723bs: fix camel case in struct ndis_802_11_ssid
Date:   Wed, 21 Jul 2021 15:37:17 +0200
Message-Id: <e7c4cc09840e112d59ed7dcf8465f1916f95b819.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in struct ndis_802_11_ssid all over the driver.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  4 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  2 +-
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  2 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  8 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 18 ++++-----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 38 +++++++++----------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 12 +++---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  2 +-
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  4 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 32 ++++++++--------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 38 +++++++++----------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  4 +-
 12 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index f821863c845d..b7e1d7817595 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -867,8 +867,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	);
 	if (p && ie_len > 0) {
 		memset(&pbss_network->ssid, 0, sizeof(struct ndis_802_11_ssid));
-		memcpy(pbss_network->ssid.Ssid, (p + 2), ie_len);
-		pbss_network->ssid.SsidLength = ie_len;
+		memcpy(pbss_network->ssid.ssid, (p + 2), ie_len);
+		pbss_network->ssid.ssid_length = ie_len;
 	}
 
 	/* channel */
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 33d8ca8be08e..d494c06dab96 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -567,7 +567,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 		int i;
 
 		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
-			if (ssid[i].SsidLength) {
+			if (ssid[i].ssid_length) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
 				psurveyPara->ssid_num++;
 			}
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b133c3738dc9..57a75e1f9a56 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -317,7 +317,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	ie += 2;
 
 	/* SSID */
-	ie = rtw_set_ie(ie, WLAN_EID_SSID, pdev_network->ssid.SsidLength, pdev_network->ssid.Ssid, &sz);
+	ie = rtw_set_ie(ie, WLAN_EID_SSID, pdev_network->ssid.ssid_length, pdev_network->ssid.ssid, &sz);
 
 	/* supported rates */
 	wireless_mode = pregistrypriv->wireless_mode;
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 662e63f764cd..03a7da84bf23 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -27,7 +27,7 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 {
 	u8 ret = true;
 
-	if (ssid->SsidLength > 32) {
+	if (ssid->ssid_length > 32) {
 		ret = false;
 		goto exit;
 	}
@@ -207,7 +207,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	struct wlan_network *pnetwork = &pmlmepriv->cur_network;
 
 	netdev_dbg(padapter->pnetdev, "set ssid [%s] fw_state = 0x%08x\n",
-		   ssid->Ssid, get_fwstate(pmlmepriv));
+		   ssid->ssid, get_fwstate(pmlmepriv));
 
 	if (padapter->hw_init_completed == false) {
 		status = _FAIL;
@@ -222,8 +222,8 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		goto release_mlme_lock;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
-		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
-		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
+		if ((pmlmepriv->assoc_ssid.ssid_length == ssid->ssid_length) &&
+		    (!memcmp(&pmlmepriv->assoc_ssid.ssid, ssid->ssid, ssid->ssid_length))) {
 			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
 				if (rtw_is_same_ibss(padapter, pnetwork) == false) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 624bafd44ceb..f9c3525ffb57 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -377,8 +377,8 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	return (a->ssid.SsidLength == b->ssid.SsidLength)
-		&&  !memcmp(a->ssid.Ssid, b->ssid.Ssid, a->ssid.SsidLength);
+	return (a->ssid.ssid_length == b->ssid.ssid_length)
+		&&  !memcmp(a->ssid.ssid, b->ssid.ssid, a->ssid.ssid_length);
 }
 
 int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 feature)
@@ -395,10 +395,10 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
 	s_cap = le16_to_cpu(tmps);
 	d_cap = le16_to_cpu(tmpd);
 
-	return (src->ssid.SsidLength == dst->ssid.SsidLength) &&
+	return (src->ssid.ssid_length == dst->ssid.ssid_length) &&
 		/* 	(src->configuration.ds_config == dst->configuration.ds_config) && */
 			((!memcmp(src->mac_address, dst->mac_address, ETH_ALEN))) &&
-			((!memcmp(src->ssid.Ssid, dst->ssid.Ssid, src->ssid.SsidLength))) &&
+			((!memcmp(src->ssid.ssid, dst->ssid.ssid, src->ssid.ssid_length))) &&
 			((s_cap & WLAN_CAPABILITY_IBSS) ==
 			(d_cap & WLAN_CAPABILITY_IBSS)) &&
 			((s_cap & WLAN_CAPABILITY_ESS) ==
@@ -728,8 +728,8 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  lock pmlmepriv->lock when you accessing network_q */
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) == false) {
-		if (pnetwork->ssid.Ssid[0] == 0)
-			pnetwork->ssid.SsidLength = 0;
+		if (pnetwork->ssid.ssid[0] == 0)
+			pnetwork->ssid.ssid_length = 0;
 		rtw_add_network(adapter, pnetwork);
 	}
 
@@ -1804,9 +1804,9 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 	}
 
 	/* check ssid, if needed */
-	if (mlme->assoc_ssid.Ssid[0] && mlme->assoc_ssid.SsidLength) {
-		if (competitor->network.ssid.SsidLength != mlme->assoc_ssid.SsidLength
-			|| memcmp(competitor->network.ssid.Ssid, mlme->assoc_ssid.Ssid, mlme->assoc_ssid.SsidLength)
+	if (mlme->assoc_ssid.ssid[0] && mlme->assoc_ssid.ssid_length) {
+		if (competitor->network.ssid.ssid_length != mlme->assoc_ssid.ssid_length
+			|| memcmp(competitor->network.ssid.ssid, mlme->assoc_ssid.ssid, mlme->assoc_ssid.ssid_length)
 		)
 			goto exit;
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 537b60f7b7db..97d4c425b29b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -538,7 +538,7 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 		if (is_valid_p2p_probereq)
 			goto _issue_probersp;
 
-		if ((ielen != 0 && false == !memcmp((void *)(p+2), (void *)cur->ssid.Ssid, cur->ssid.SsidLength))
+		if ((ielen != 0 && false == !memcmp((void *)(p+2), (void *)cur->ssid.ssid, cur->ssid.ssid_length))
 			|| (ielen == 0 && pmlmeinfo->hidden_ssid_mode)
 		)
 			return _SUCCESS;
@@ -1022,10 +1022,10 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		goto OnAssocReqFail;
 	} else {
 		/*  check if ssid match */
-		if (memcmp((void *)(p+2), cur->ssid.Ssid, cur->ssid.SsidLength))
+		if (memcmp((void *)(p+2), cur->ssid.ssid, cur->ssid.ssid_length))
 			status = WLAN_STATUS_CHALLENGE_FAIL;
 
-		if (ie_len != cur->ssid.SsidLength)
+		if (ie_len != cur->ssid.ssid_length)
 			status = WLAN_STATUS_CHALLENGE_FAIL;
 	}
 
@@ -2230,7 +2230,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pattrib->pktlen += 2;
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pattrib->pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.ssid_length, cur_network->ssid.ssid, &pattrib->pktlen);
 
 	/*  supported rates... */
 	rate_len = rtw_get_rateset_len(cur_network->supported_rates);
@@ -2385,9 +2385,9 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			ssid_ie = rtw_get_ie(ies+_FIXED_IE_LENGTH_, WLAN_EID_SSID, &ssid_ielen,
 				(pframe-ies)-_FIXED_IE_LENGTH_);
 
-			ssid_ielen_diff = cur_network->ssid.SsidLength - ssid_ielen;
+			ssid_ielen_diff = cur_network->ssid.ssid_length - ssid_ielen;
 
-			if (ssid_ie &&  cur_network->ssid.SsidLength) {
+			if (ssid_ie &&  cur_network->ssid.ssid_length) {
 				uint remainder_ielen;
 				u8 *remainder_ie;
 
@@ -2403,8 +2403,8 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 				memcpy(buf, remainder_ie, remainder_ielen);
 				memcpy(remainder_ie+ssid_ielen_diff, buf, remainder_ielen);
-				*(ssid_ie+1) = cur_network->ssid.SsidLength;
-				memcpy(ssid_ie+2, cur_network->ssid.Ssid, cur_network->ssid.SsidLength);
+				*(ssid_ie+1) = cur_network->ssid.ssid_length;
+				memcpy(ssid_ie+2, cur_network->ssid.ssid, cur_network->ssid.ssid_length);
 
 				pframe += ssid_ielen_diff;
 				pattrib->pktlen += ssid_ielen_diff;
@@ -2433,7 +2433,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		/* below for ad-hoc mode */
 
 		/*  SSID */
-		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pattrib->pktlen);
+		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.ssid_length, cur_network->ssid.ssid, &pattrib->pktlen);
 
 		/*  supported rates... */
 		rate_len = rtw_get_rateset_len(cur_network->supported_rates);
@@ -2530,7 +2530,7 @@ static int _issue_probereq(struct adapter *padapter,
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
 
 	if (pssid)
-		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, pssid->SsidLength, pssid->Ssid, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, pssid->ssid_length, pssid->ssid, &(pattrib->pktlen));
 	else
 		pframe = rtw_set_ie(pframe, WLAN_EID_SSID, 0, NULL, &(pattrib->pktlen));
 
@@ -2923,7 +2923,7 @@ void issue_assocreq(struct adapter *padapter)
 	pattrib->pktlen += 2;
 
 	/* SSID */
-	pframe = rtw_set_ie(pframe, WLAN_EID_SSID,  pmlmeinfo->network.ssid.SsidLength, pmlmeinfo->network.ssid.Ssid, &(pattrib->pktlen));
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID,  pmlmeinfo->network.ssid.ssid_length, pmlmeinfo->network.ssid.ssid, &(pattrib->pktlen));
 
 	/* supported rate & extended supported rate */
 
@@ -3876,7 +3876,7 @@ void site_survey(struct adapter *padapter)
 				int i;
 
 				for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
-					if (pmlmeext->sitesurvey_res.ssid[i].SsidLength) {
+					if (pmlmeext->sitesurvey_res.ssid[i].ssid_length) {
 						/* IOT issue, When wifi_spec is not set, send one probe req without WPS IE. */
 						if (padapter->registrypriv.wifi_spec)
 							issue_probereq(padapter, &(pmlmeext->sitesurvey_res.ssid[i]), NULL);
@@ -4007,10 +4007,10 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 		if (len > NDIS_802_11_LENGTH_SSID)
 			return _FAIL;
 
-		memcpy(bssid->ssid.Ssid, (p + 2), *(p + 1));
-		bssid->ssid.SsidLength = *(p + 1);
+		memcpy(bssid->ssid.ssid, (p + 2), *(p + 1));
+		bssid->ssid.ssid_length = *(p + 1);
 	} else
-		bssid->ssid.SsidLength = 0;
+		bssid->ssid.ssid_length = 0;
 
 	memset(bssid->supported_rates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
@@ -5589,11 +5589,11 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		pmlmeext->sitesurvey_res.channel_idx = 0;
 
 		for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
-			if (pparm->ssid[i].SsidLength) {
-				memcpy(pmlmeext->sitesurvey_res.ssid[i].Ssid, pparm->ssid[i].Ssid, IW_ESSID_MAX_SIZE);
-				pmlmeext->sitesurvey_res.ssid[i].SsidLength = pparm->ssid[i].SsidLength;
+			if (pparm->ssid[i].ssid_length) {
+				memcpy(pmlmeext->sitesurvey_res.ssid[i].ssid, pparm->ssid[i].ssid, IW_ESSID_MAX_SIZE);
+				pmlmeext->sitesurvey_res.ssid[i].ssid_length = pparm->ssid[i].ssid_length;
 			} else {
-				pmlmeext->sitesurvey_res.ssid[i].SsidLength = 0;
+				pmlmeext->sitesurvey_res.ssid[i].ssid_length = 0;
 			}
 		}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index dfdeec2d0763..f9042f1dadb5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1283,13 +1283,13 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		if (ssid_len > NDIS_802_11_LENGTH_SSID)
 			ssid_len = 0;
 	}
-	memcpy(bssid->ssid.Ssid, (p + 2), ssid_len);
-	bssid->ssid.SsidLength = ssid_len;
+	memcpy(bssid->ssid.ssid, (p + 2), ssid_len);
+	bssid->ssid.ssid_length = ssid_len;
 
-	if (memcmp(bssid->ssid.Ssid, cur_network->network.ssid.Ssid, 32) ||
-			bssid->ssid.SsidLength != cur_network->network.ssid.SsidLength)
-		if (bssid->ssid.Ssid[0] != '\0' &&
-		    bssid->ssid.SsidLength != 0) /* not hidden ssid */
+	if (memcmp(bssid->ssid.ssid, cur_network->network.ssid.ssid, 32) ||
+			bssid->ssid.ssid_length != cur_network->network.ssid.ssid_length)
+		if (bssid->ssid.ssid[0] != '\0' &&
+		    bssid->ssid.ssid_length != 0) /* not hidden ssid */
 			goto _mismatch;
 
 	/* check encryption info */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 2e68ed841f6d..853fe758c4a9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -157,7 +157,7 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 	/* below for ad-hoc mode */
 
 	/*  SSID */
-	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.SsidLength, cur_network->ssid.Ssid, &pktlen);
+	pframe = rtw_set_ie(pframe, WLAN_EID_SSID, cur_network->ssid.ssid_length, cur_network->ssid.ssid, &pktlen);
 
 	/*  supported rates... */
 	rate_len = rtw_get_rateset_len(cur_network->supported_rates);
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index e5ab3cacfa91..331578129644 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -20,8 +20,8 @@ typedef unsigned char   NDIS_802_11_RATES[NDIS_802_11_LENGTH_RATES];        /*
 typedef unsigned char   NDIS_802_11_RATES_EX[NDIS_802_11_LENGTH_RATES_EX];  /*  Set of 16 data rates */
 
 struct ndis_802_11_ssid {
-	u32  SsidLength;
-	u8  Ssid[32];
+	u32  ssid_length;
+	u8  ssid[32];
 };
 
 enum ndis_802_11_network_type {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4e6eba240161..17628704d428 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -266,8 +266,8 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 			if (request->n_ssids == 1 && request->n_channels == 1) /*  it means under processing WPS */
 			{
 				if (ssids[0].ssid_len != 0 &&
-				    (pssid->SsidLength != ssids[0].ssid_len ||
-				     memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len)))
+				    (pssid->ssid_length != ssids[0].ssid_len ||
+				     memcmp(pssid->ssid, ssids[0].ssid, ssids[0].ssid_len)))
 				{
 					if (psr)
 						*psr = 0; /* clear sr */
@@ -359,8 +359,8 @@ int rtw_cfg80211_check_bss(struct adapter *padapter)
 
 	notify_channel = ieee80211_get_channel(padapter->rtw_wdev->wiphy, freq);
 	bss = cfg80211_get_bss(padapter->rtw_wdev->wiphy, notify_channel,
-			pnetwork->mac_address, pnetwork->ssid.Ssid,
-			pnetwork->ssid.SsidLength,
+			pnetwork->mac_address, pnetwork->ssid.ssid,
+			pnetwork->ssid.ssid_length,
 			WLAN_CAPABILITY_ESS, WLAN_CAPABILITY_ESS);
 
 	cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
@@ -1241,8 +1241,8 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 	struct wlan_bssid_ex *select_network = &pnetwork->network;
 
 	bss = cfg80211_get_bss(wiphy, NULL/*notify_channel*/,
-		select_network->mac_address, select_network->ssid.Ssid,
-		select_network->ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
+		select_network->mac_address, select_network->ssid.ssid,
+		select_network->ssid.ssid_length, 0/*WLAN_CAPABILITY_ESS*/,
 		0/*WLAN_CAPABILITY_ESS*/);
 
 	if (bss) {
@@ -1398,8 +1398,8 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 	/* parsing request ssids, n_ssids */
 	for (i = 0; i < request->n_ssids && i < RTW_SSID_SCAN_AMOUNT; i++) {
-		memcpy(ssid[i].Ssid, ssids[i].ssid, ssids[i].ssid_len);
-		ssid[i].SsidLength = ssids[i].ssid_len;
+		memcpy(ssid[i].ssid, ssids[i].ssid, ssids[i].ssid_len);
+		ssid[i].ssid_length = ssids[i].ssid_len;
 	}
 
 	/* parsing channels, n_channels */
@@ -1730,8 +1730,8 @@ static int cfg80211_rtw_join_ibss(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
-	ndis_ssid.SsidLength = params->ssid_len;
-	memcpy(ndis_ssid.Ssid, (u8 *)params->ssid, params->ssid_len);
+	ndis_ssid.ssid_length = params->ssid_len;
+	memcpy(ndis_ssid.ssid, (u8 *)params->ssid, params->ssid_len);
 
 	psecuritypriv->ndisencryptstatus = Ndis802_11EncryptionDisabled;
 	psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1822,8 +1822,8 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
-	ndis_ssid.SsidLength = sme->ssid_len;
-	memcpy(ndis_ssid.Ssid, (u8 *)sme->ssid, sme->ssid_len);
+	ndis_ssid.ssid_length = sme->ssid_len;
+	memcpy(ndis_ssid.ssid, (u8 *)sme->ssid, sme->ssid_len);
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true) {
 		ret = -EBUSY;
@@ -2466,10 +2466,10 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 		struct wlan_bssid_ex *pbss_network = &adapter->mlmepriv.cur_network.network;
 		struct wlan_bssid_ex *pbss_network_ext = &adapter->mlmeextpriv.mlmext_info.network;
 
-		memcpy(pbss_network->ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
-		pbss_network->ssid.SsidLength = settings->ssid_len;
-		memcpy(pbss_network_ext->ssid.Ssid, (void *)settings->ssid, settings->ssid_len);
-		pbss_network_ext->ssid.SsidLength = settings->ssid_len;
+		memcpy(pbss_network->ssid.ssid, (void *)settings->ssid, settings->ssid_len);
+		pbss_network->ssid.ssid_length = settings->ssid_len;
+		memcpy(pbss_network_ext->ssid.ssid, (void *)settings->ssid, settings->ssid_len);
+		pbss_network_ext->ssid.ssid_length = settings->ssid_len;
 	}
 
 	return ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index f3e447023a2d..95aef62ecfb8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -98,8 +98,8 @@ static char *translate_scan(struct adapter *padapter,
 	/* Add the ESSID */
 	iwe.cmd = SIOCGIWESSID;
 	iwe.u.data.flags = 1;
-	iwe.u.data.length = min((u16)pnetwork->network.ssid.SsidLength, (u16)32);
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.Ssid);
+	iwe.u.data.length = min((u16)pnetwork->network.ssid.ssid_length, (u16)32);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.ssid);
 
 	/* parsing HT_CAP_IE */
 	if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
@@ -176,7 +176,7 @@ static char *translate_scan(struct adapter *padapter,
 	else
 		iwe.u.data.flags = IW_ENCODE_DISABLED;
 	iwe.u.data.length = 0;
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.Ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.ssid);
 
 	/*Add basic and extended rates */
 	max_rate = 0;
@@ -1177,8 +1177,8 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 		if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
 			int len = min((int)req->essid_len, IW_ESSID_MAX_SIZE);
 
-			memcpy(ssid[0].Ssid, req->essid, len);
-			ssid[0].SsidLength = len;
+			memcpy(ssid[0].ssid, req->essid, len);
+			ssid[0].ssid_length = len;
 
 			spin_lock_bh(&pmlmepriv->lock);
 
@@ -1209,8 +1209,8 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 				sec_len = *(pos++); len -= 1;
 
 				if (sec_len > 0 && sec_len <= len) {
-					ssid[ssid_index].SsidLength = sec_len;
-					memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
+					ssid[ssid_index].ssid_length = sec_len;
+					memcpy(ssid[ssid_index].ssid, pos, ssid[ssid_index].ssid_length);
 					ssid_index++;
 				}
 
@@ -1355,9 +1355,9 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
-		ndis_ssid.SsidLength = len;
-		memcpy(ndis_ssid.Ssid, extra, len);
-		src_ssid = ndis_ssid.Ssid;
+		ndis_ssid.ssid_length = len;
+		memcpy(ndis_ssid.ssid, extra, len);
+		src_ssid = ndis_ssid.ssid;
 
 		spin_lock_bh(&queue->lock);
 		phead = get_list_head(queue);
@@ -1365,10 +1365,10 @@ static int rtw_wx_set_essid(struct net_device *dev,
 			pnetwork = list_entry(pmlmepriv->pscanned,
 					      struct wlan_network, list);
 
-			dst_ssid = pnetwork->network.ssid.Ssid;
+			dst_ssid = pnetwork->network.ssid.ssid;
 
-			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength)) &&
-				(pnetwork->network.ssid.SsidLength == ndis_ssid.SsidLength)) {
+			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.ssid_length)) &&
+				(pnetwork->network.ssid.ssid_length == ndis_ssid.ssid_length)) {
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true) {
 					if (pnetwork->network.infrastructure_mode != pmlmepriv->cur_network.network.infrastructure_mode)
 						continue;
@@ -1410,11 +1410,11 @@ static int rtw_wx_get_essid(struct net_device *dev,
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) ||
 	      (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true)) {
-		len = pcur_bss->ssid.SsidLength;
+		len = pcur_bss->ssid.ssid_length;
 
 		wrqu->essid.length = len;
 
-		memcpy(extra, pcur_bss->ssid.Ssid, len);
+		memcpy(extra, pcur_bss->ssid.ssid, len);
 
 		wrqu->essid.flags = 1;
 	} else {
@@ -3530,10 +3530,10 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		memcpy(ssid, ssid_ie+2, ssid_len);
 		ssid[ssid_len] = 0x0;
 
-		memcpy(pbss_network->ssid.Ssid, (void *)ssid, ssid_len);
-		pbss_network->ssid.SsidLength = ssid_len;
-		memcpy(pbss_network_ext->ssid.Ssid, (void *)ssid, ssid_len);
-		pbss_network_ext->ssid.SsidLength = ssid_len;
+		memcpy(pbss_network->ssid.ssid, (void *)ssid, ssid_len);
+		pbss_network->ssid.ssid_length = ssid_len;
+		memcpy(pbss_network_ext->ssid.ssid, (void *)ssid, ssid_len);
+		pbss_network_ext->ssid.ssid_length = ssid_len;
 	}
 
 	return ret;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 648456b992bb..b042df319c98 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -205,8 +205,8 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 	/* registry_par->hci = (u8)hci; */
 	registry_par->network_mode  = (u8)rtw_network_mode;
 
-	memcpy(registry_par->ssid.Ssid, "ANY", 3);
-	registry_par->ssid.SsidLength = 3;
+	memcpy(registry_par->ssid.ssid, "ANY", 3);
+	registry_par->ssid.ssid_length = 3;
 
 	registry_par->channel = (u8)rtw_channel;
 	registry_par->wireless_mode = (u8)rtw_wireless_mode;
-- 
2.20.1

