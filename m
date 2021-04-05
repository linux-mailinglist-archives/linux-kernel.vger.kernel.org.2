Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40C35460A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhDER3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbhDER3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:29:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700FDC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:29:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f6so5451001wrv.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YfIIHnV0A9du9ORGwoOsInV843q39HnrSsHUhvGVWnc=;
        b=LKLZaJMdbTLWBZcTbbPQK4lBcGeN6boliJnrSn+vv0siO3oWjizfBhcsBHe3/UD0kS
         s/cvopt2lCV35yVYbPvfv6daJE/PtEsAlG/OOrdEfXZAXYVFhcm70feIhmAjfsEJmTm0
         3C9alVqtEqcOf3eWkYxL3FvHy/5WtbaeloNKo69Cwwf2lxim6WbdSef0hxcMC6tV/ISV
         5XHJdyS+dcdg8/zSsZEA+3oISNcRuk9MD24+4tLHi2hoTQ4ip31oLKMqAmfMqAq0SEx/
         XMXV33B+ivxgiI9CcvcEMpD4e0Bj0AACcNdbrnIVAAOAv/pEhBNeBTFwl19ePO3TMnem
         4nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfIIHnV0A9du9ORGwoOsInV843q39HnrSsHUhvGVWnc=;
        b=fTUF7ZWRKavcCL8HSyBBzt+3g4B4V0uQ4cY6hcP6K2de6dOcLOAs+TQHuM1aZndPmO
         rmDfduD9N5F1slgP3qlnc6O3tauvqrVNrZRIMx1VA++j05dYwOBbL3MfLG2ybUN6bA+s
         Kw/J1oKXcooh8J+UX1L85W8ZrtNm3x8yd+nUm72d4gaxdnTrBFX5IaDnhWBOFX26ugXc
         vIdTpIY3Nc3LErObbOVs2GsovaKfpVfq0c6jqbtDcrHLl4Hz/bKX1W2/rB6Q31Ho7e8G
         itkYy4MOVvKSF09rExh+5uM3Z7ctvqF7Zg6hXMg5WsWosrDelpiJdvnpV1quH/qIZ+sV
         2XAA==
X-Gm-Message-State: AOAM532kFMIOCFdRYk76IfKVcIMp2zwKqmB9upRs53EnnvvasmsF+LqI
        AHMj20u0gESTue8Fx4FUYOA=
X-Google-Smtp-Source: ABdhPJzp9kXYeJCL511uqQsVUlYTR/QWqXI9QFE4xftYXspIxxShaEwjoe0FJ9Fi8CJo+woSvtFUow==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr29754671wrp.231.1617643765186;
        Mon, 05 Apr 2021 10:29:25 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id x1sm17858699wro.66.2021.04.05.10.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:29:24 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 3/4] staging: rtl8723bs: core: reorganize characters so the lines are under 100 ch
Date:   Mon,  5 Apr 2021 18:29:19 +0100
Message-Id: <6ce5f20399f2bea9f08bb37150fc67fe3c2b2a55.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up warnings of "line over 100 characters" but avoinding
more than 90 characters in file rtw_ap.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 4dab4d741675..ca6fec52d213 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -278,11 +278,13 @@ void expire_timeout_chk(struct adapter *padapter)
 
 			if (psta->state & WIFI_SLEEP_STATE) {
 				if (!(psta->state & WIFI_STA_ALIVE_CHK_STATE)) {
-					/* to check if alive by another methods if station is at ps mode. */
+					/* to check if alive by another methods */
+					/* if station is at ps mode. */
 					psta->expire_to = pstapriv->expire_to;
 					psta->state |= WIFI_STA_ALIVE_CHK_STATE;
 
-					/* DBG_871X("alive chk, sta:%pM is at ps mode!\n", MAC_ARG(psta->hwaddr)); */
+					/* DBG_871X("alive chk, sta:%pM is at ps */
+					/* mode!\n", MAC_ARG(psta->hwaddr)); */
 
 					/* to update bcn with tim_bitmap for this station */
 					pstapriv->tim_bitmap |= BIT(psta->aid);
@@ -309,7 +311,8 @@ void expire_timeout_chk(struct adapter *padapter)
 			);
 			updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
-			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
+			/* TODO: Aging mechanism to digest frames in sleep_q to */
+			/* avoid running out of xmitframe */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
 				&& padapter->xmitpriv.free_xmitframe_cnt < ((
 					NR_XMITFRAME / pstapriv->asoc_list_cnt
@@ -375,7 +378,8 @@ void expire_timeout_chk(struct adapter *padapter)
 			if (list_empty(&psta->asoc_list) == false) {
 				list_del_init(&psta->asoc_list);
 				pstapriv->asoc_list_cnt--;
-				updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
+				updated = ap_free_sta(padapter, psta, false,
+						      WLAN_REASON_DEAUTH_LEAVING);
 			}
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
 		}
@@ -469,7 +473,8 @@ void update_bmc_sta(struct adapter *padapter)
 
 		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
 
-		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
+		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, */
+		/* because it has been set before this. */
 
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
@@ -748,8 +753,8 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	/* check if there is wps ie, */
-	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
-	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
+	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating */
+	/* hostapd, and at first time the security ie (RSN/WPA IE) will not include in beacon. */
 	if (!rtw_get_wps_ie(pnetwork->IEs + _FIXED_IE_LENGTH_,
 			    pnetwork->IELength - _FIXED_IE_LENGTH_, NULL, NULL))
 		pmlmeext->bstart_bss = true;
@@ -1117,7 +1122,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 				*(p + 8) |= BIT(7);/* QoS Info, support U-APSD */
 
-				/* disable all ACM bits since the WMM admission control is not supported */
+				/* disable all ACM bits since the WMM admission */
+				/* control is not supported */
 				*(p + 10) &= ~BIT(4); /* BE */
 				*(p + 14) &= ~BIT(4); /* BK */
 				*(p + 18) &= ~BIT(4); /* VI */
-- 
2.25.1

