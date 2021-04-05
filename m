Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34A9354609
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhDER3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhDER3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:29:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DBC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:29:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i18so8081256wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bKz/zL8aMPqGfUWgzJWrQn+k6sxAWjkqG0TRxYA7Mn0=;
        b=B85pOMrySjt062hHVU3fwo73VQK2XmQB1kkwMdd3bWeMvQ3Oi7KXoTBAwTICQmabm+
         hxUR4qBbq8qDRoB+WFkiD1qIYgvudSlIiKweFFFGu+8gepOZtoMh9wSq/jnExdr7/7G2
         9+cDrpJeHqnIetOIqEeV/xDMpgO1mzvWVeQxVUySt8INYJu3d/Y0aSeDW4Xw+7erTH/m
         ytQu4Ob/qf31ErU2rdhMouE0w681zsPh/RRIcjPAj4vPmUubLTsccXO+D7U1XpCzIDGL
         aDm7GD3txRSU5AQEOnr7RrLB3yEO98NYwd3bSRc8xffZCW5JDYTr+kNOynlom5jKewsi
         lRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKz/zL8aMPqGfUWgzJWrQn+k6sxAWjkqG0TRxYA7Mn0=;
        b=DQqtpEGBNmJZnHEDDsUtq3Qxw0eR4Fqjv1wE4u2NcaXyzTu29Q22hQ2JSEXbBih0jv
         KnBZu4FZgF7OwN+LYYxhjwzEudrH+KQ+VL7h68uwi/TGJRa6O9WdE1k4YglIEox5Aase
         rXSOqVbfIKVJBjWERPKgHFTnhG2FzGojdEtRRwAIulkmalHigigsfTELOI5xmkYhxkwY
         LSoIKmcbNkBnundodZ8iXPUqY/QTGwx4/t9a2U/zRm0ydVClLdy4SJFnhQ+uC3BzSjbn
         V+nPatwG7Lmx0np25Qe88Ee0fPP/xOxB50sc6Rm7c1mSu7nEs7uKM8Z4HvCAbX7kriK9
         Nyxg==
X-Gm-Message-State: AOAM532o9yz18NueyV22CZCy77BBE41iUG5bIEEYQUyGIjorHeOF6UoM
        JtDf0aubviR39uP99nMLASpv/QGweOFUaA==
X-Google-Smtp-Source: ABdhPJw6x7RH7hlzbuhPdmLXxj5PfjAWgxDeFXxLTFl3L6zPrSFc/KEboDEg1q1Y7bbWx5Y+b9ITxQ==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr30087210wrx.96.1617643764323;
        Mon, 05 Apr 2021 10:29:24 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id x1sm17858699wro.66.2021.04.05.10.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:29:24 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 2/4] staging: rtl8723bs: core: Ending line with argument
Date:   Mon,  5 Apr 2021 18:29:18 +0100
Message-Id: <ce400adc5623b3bfbd520da4aa6bcc5867ad4dc8.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Lines should not end with a '('"
with argument present in next line in file rtw_ap.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 98 ++++++++++---------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 81acc6bcb092..4dab4d741675 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -67,11 +67,10 @@ static void update_BCNTIM(struct adapter *padapter)
 
 		tim_bitmap_le = cpu_to_le16(pstapriv->tim_bitmap);
 
-		p = rtw_get_ie(
-			pie + _FIXED_IE_LENGTH_,
-			WLAN_EID_TIM,
-			&tim_ielen,
-			pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
+		p = rtw_get_ie(pie + _FIXED_IE_LENGTH_,
+			       WLAN_EID_TIM,
+			       &tim_ielen,
+			       pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
 		);
 		if (p && tim_ielen > 0) {
 			tim_ielen += 2;
@@ -91,20 +90,18 @@ static void update_BCNTIM(struct adapter *padapter)
 			offset = _FIXED_IE_LENGTH_;
 
 			/* get ssid_ie len */
-			p = rtw_get_ie(
-				pie + _BEACON_IE_OFFSET_,
-				WLAN_EID_SSID,
-				&tmp_len,
-				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+			p = rtw_get_ie(pie + _BEACON_IE_OFFSET_,
+				       WLAN_EID_SSID,
+				       &tmp_len,
+				       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
 			);
 			if (p)
 				offset += tmp_len + 2;
 
 			/*  get supported rates len */
-			p = rtw_get_ie(
-				pie + _BEACON_IE_OFFSET_,
-				WLAN_EID_SUPP_RATES, &tmp_len,
-				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
+			p = rtw_get_ie(pie + _BEACON_IE_OFFSET_,
+				       WLAN_EID_SUPP_RATES, &tmp_len,
+				       (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
 			);
 			if (p)
 				offset += tmp_len + 2;
@@ -226,14 +223,13 @@ void expire_timeout_chk(struct adapter *padapter)
 				list_del_init(&psta->auth_list);
 				pstapriv->auth_list_cnt--;
 
-				DBG_871X(
-					"auth expire %02X%02X%02X%02X%02X%02X\n",
-					psta->hwaddr[0],
-					psta->hwaddr[1],
-					psta->hwaddr[2],
-					psta->hwaddr[3],
-					psta->hwaddr[4],
-					psta->hwaddr[5]
+				DBG_871X("auth expire %02X%02X%02X%02X%02X%02X\n",
+					 psta->hwaddr[0],
+					 psta->hwaddr[1],
+					 psta->hwaddr[2],
+					 psta->hwaddr[3],
+					 psta->hwaddr[4],
+					 psta->hwaddr[5]
 				);
 
 				spin_unlock_bh(&pstapriv->auth_list_lock);
@@ -307,10 +303,9 @@ void expire_timeout_chk(struct adapter *padapter)
 			}
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
-			DBG_871X(
-				"asoc expire %pM, state = 0x%x\n",
-				MAC_ARG(psta->hwaddr),
-				psta->state
+			DBG_871X("asoc expire %pM, state = 0x%x\n",
+				 MAC_ARG(psta->hwaddr),
+				 psta->state
 			);
 			updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
@@ -360,17 +355,15 @@ void expire_timeout_chk(struct adapter *padapter)
 
 			psta->keep_alive_trycnt++;
 			if (ret == _SUCCESS) {
-				DBG_871X(
-					"asoc check, sta(%pM) is alive\n",
-					MAC_ARG(psta->hwaddr)
+				DBG_871X("asoc check, sta(%pM) is alive\n",
+					 MAC_ARG(psta->hwaddr)
 					);
 				psta->expire_to = pstapriv->expire_to;
 				psta->keep_alive_trycnt = 0;
 				continue;
 			} else if (psta->keep_alive_trycnt <= 3) {
-				DBG_871X(
-					"ack check for asoc expire, keep_alive_trycnt =%d\n",
-					psta->keep_alive_trycnt);
+				DBG_871X("ack check for asoc expire, keep_alive_trycnt =%d\n",
+					 psta->keep_alive_trycnt);
 				psta->expire_to = 1;
 				continue;
 			}
@@ -480,10 +473,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
-		network_type = rtw_check_network_type(
-			(u8 *)&pcur_network->SupportedRates,
-			supportRateNum,
-			pcur_network->Configuration.DSConfig
+		network_type = rtw_check_network_type((u8 *)&pcur_network->SupportedRates,
+						      supportRateNum,
+						      pcur_network->Configuration.DSConfig
 		);
 		if (IsSupportedTxCCK(network_type)) {
 			network_type = WIRELESS_11B;
@@ -711,15 +703,9 @@ static void update_hw_ht_param(struct adapter *padapter)
 	 */
 	max_AMPDU_len = pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x03;
 
-	min_MPDU_spacing = (
-		pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c
-	) >> 2;
+	min_MPDU_spacing = (pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c) >> 2;
 
-	rtw_hal_set_hwreg(
-		padapter,
-		HW_VAR_AMPDU_MIN_SPACE,
-		(u8 *)(&min_MPDU_spacing)
-	);
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, (u8 *)(&min_MPDU_spacing));
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, (u8 *)(&max_AMPDU_len));
 
@@ -785,10 +771,8 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	if (!pmlmepriv->cur_network.join_res) { /* setting only at  first time */
 
 		/* WEP Key will be set before this function, do not clear CAM. */
-		if (
-			(psecuritypriv->dot11PrivacyAlgrthm != _WEP40_) &&
-			(psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
-		)
+		if ((psecuritypriv->dot11PrivacyAlgrthm != _WEP40_) &&
+		    (psecuritypriv->dot11PrivacyAlgrthm != _WEP104_))
 			flush_all_cam_entry(padapter);	/* clear CAM */
 	}
 
@@ -836,11 +820,10 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	}
 
 	/* set channel, bwmode */
-	p = rtw_get_ie(
-		(pnetwork->IEs + sizeof(struct ndis_802_11_fix_ie)),
-		WLAN_EID_HT_OPERATION,
-		&ie_len,
-		(pnetwork->IELength - sizeof(struct ndis_802_11_fix_ie))
+	p = rtw_get_ie((pnetwork->IEs + sizeof(struct ndis_802_11_fix_ie)),
+		       WLAN_EID_HT_OPERATION,
+		       &ie_len,
+		       (pnetwork->IELength - sizeof(struct ndis_802_11_fix_ie))
 	);
 	if (p && ie_len) {
 		pht_info = (struct HT_info_element *)(p + 2);
@@ -877,11 +860,10 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	}
 
 	set_channel_bwmode(padapter, cur_channel, cur_ch_offset, cur_bwmode);
-	DBG_871X(
-		"CH =%d, BW =%d, offset =%d\n",
-		cur_channel,
-		cur_bwmode,
-		cur_ch_offset
+	DBG_871X("CH =%d, BW =%d, offset =%d\n",
+		 cur_channel,
+		 cur_bwmode,
+		 cur_ch_offset
 	);
 	pmlmeext->cur_channel = cur_channel;
 	pmlmeext->cur_bwmode = cur_bwmode;
-- 
2.25.1

