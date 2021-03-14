Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB5033A3B4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhCNJEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhCNJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:03:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136DC061763
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:42 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t18so4434334lfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O46nNUtiNUIxZdLM9H9z/yPTfQyKcBwviQefaI3Bnqg=;
        b=lcwf5AcBcvtor5jwoM/kIFHcDQuX04a6KlamIKYZx8eJOXbqRMbelW3MC50wGSbccU
         1nXoe2KXSbedSfide4ptOu1Q1v8IQlDKxKsAMNkR+yNfcbfcHXRgzu4FDihIzztwgSch
         oEbHmJP+/0R6l8OgPSKAHMFwEQT8XDplNzxvPsOWa5/VSSxHGJinf2sHaZDgqEufR1aV
         y+pnXQLZJf5LIYwfbFys+pQOgvzO3VmmQqV5X015+NuBUNyiQEHYBVFt5TxR6iENtrwL
         eRAQV1TIb9WEpcSEdzZtsBW4skQ8t3Htnbz7BySSIhnHilyRuH6myL/ybI/rv6k+AUz+
         kBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O46nNUtiNUIxZdLM9H9z/yPTfQyKcBwviQefaI3Bnqg=;
        b=niyXnWAdnJsPPJ3PTIbT/7F7PwF1z73z5imrtp+Exkqa1ylnBinIK4tj6SVue8q/Sl
         lTtUS9eD8rUu4AvDi8GqxS/3H2jIVfhyKXCHtPH/H3+vGXip3ZwRN9i0PLn5CCYuM3Oy
         uxKRLL8HC+GsIfpfC6ES0YvMqSGnXL8DvzZ4M7Yxj1UsKUu8gg3JPnLBoGEEmfRBMajs
         XzP6uGyxBKS/Ri2RKs5wTSSTiW6JFk8JKUhEsXGgDM+ihsG1NOus+PboLVcPVJ0rEhSD
         CF/TSCOIecuwI4RrTkhbsdHIwD8NRKlf4fMxTKNuvwzuaKKSilUwRvKz2kveh6zJGaci
         g26Q==
X-Gm-Message-State: AOAM532D+3NXnsY7sTn3fQu959Pq+46UraP8OV61Vd7BV+HMyBfeIyNT
        17T5GnOPl8RVxxAhql3ssXL/oaN3n4E=
X-Google-Smtp-Source: ABdhPJzo/B7XXrDgaLtwfaFnb9b4ym30OGvL/99xAJny9tRckq+jUJAaHfb+97KlA2kH1sVQzGP+iQ==
X-Received: by 2002:a19:4101:: with SMTP id o1mr4755416lfa.16.1615712621285;
        Sun, 14 Mar 2021 01:03:41 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id h10sm2256138lfc.266.2021.03.14.01.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:03:40 -0800 (PST)
Received: (nullmailer pid 21229 invoked by uid 1000);
        Sun, 14 Mar 2021 09:03:26 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mrinal Pandey <mrinalmni@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Simon Fong <simon.fodin@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 1/4] staging:r8188eu: replace get_(d|s)a with ieee80211_get_(D|S)A
Date:   Sun, 14 Mar 2021 12:02:44 +0300
Message-Id: <20210314090247.21181-2-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210314090247.21181-1-insafonov@gmail.com>
References: <20210314090247.21181-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_da()/get_sa() duplicate native ieee80211_get_(D|S)A functions.
Remove get_(d|s)a, use ieee80211_get_(D|S)A instead.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  6 +--
 drivers/staging/rtl8188eu/core/rtw_recv.c     |  4 +-
 .../staging/rtl8188eu/hal/rtl8188e_rxdesc.c   |  4 +-
 drivers/staging/rtl8188eu/include/wifi.h      | 44 -------------------
 4 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index ebd9b96a8211..bee19d5b22c0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2526,7 +2526,7 @@ static unsigned int OnProbeReq(struct adapter *padapter,
 
 		if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 		    pmlmepriv->cur_network.join_res)
-			issue_probersp(padapter, get_sa(pframe));
+			issue_probersp(padapter, ieee80211_get_SA((struct ieee80211_hdr *)pframe));
 	}
 	return _SUCCESS;
 }
@@ -2819,7 +2819,7 @@ static unsigned int OnAuthClient(struct adapter *padapter,
 	DBG_88E("%s\n", __func__);
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), ieee80211_get_DA((struct ieee80211_hdr *)pframe), ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & WIFI_FW_AUTH_STATE))
@@ -3332,7 +3332,7 @@ static unsigned int OnAssocRsp(struct adapter *padapter,
 	DBG_88E("%s\n", __func__);
 
 	/* check A1 matches or not */
-	if (memcmp(myid(&padapter->eeprompriv), get_da(pframe), ETH_ALEN))
+	if (memcmp(myid(&padapter->eeprompriv), ieee80211_get_DA((struct ieee80211_hdr *)pframe), ETH_ALEN))
 		return _SUCCESS;
 
 	if (!(pmlmeinfo->state & (WIFI_FW_AUTH_SUCCESS | WIFI_FW_ASSOC_STATE)))
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 36bcbe635cf4..b9b4bc435037 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1029,8 +1029,8 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	int ret = _SUCCESS;
 
 	bretry = GetRetry(ptr);
-	pda = get_da(ptr);
-	psa = get_sa(ptr);
+	pda = ieee80211_get_DA((struct ieee80211_hdr *)ptr);
+	psa = ieee80211_get_SA((struct ieee80211_hdr *)ptr);
 	pbssid = get_hdr_bssid(ptr);
 
 	if (!pbssid) {
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 0d06cb54b1ad..4fae75fc3dd5 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -150,7 +150,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
 
 	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
-				 (!memcmp(get_da(wlanhdr),
+				 (!memcmp(ieee80211_get_DA((struct ieee80211_hdr *)wlanhdr),
 				  myid(&padapter->eeprompriv), ETH_ALEN));
 
 	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
@@ -161,7 +161,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 			sa = padapter->mlmepriv.cur_network.network.MacAddress;
 		/* to do Ad-hoc */
 	} else {
-		sa = get_sa(wlanhdr);
+		sa = ieee80211_get_SA((struct ieee80211_hdr *)wlanhdr);
 	}
 
 	pstapriv = &padapter->stapriv;
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 1b9006879a11..5ee4d02e293c 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -201,50 +201,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline unsigned char *get_da(unsigned char *pframe)
-{
-	unsigned char	*da;
-	unsigned int to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
-
-	switch (to_fr_ds) {
-	case 0x00:	/*  ToDs=0, FromDs=0 */
-		da = GetAddr1Ptr(pframe);
-		break;
-	case 0x01:	/*  ToDs=0, FromDs=1 */
-		da = GetAddr1Ptr(pframe);
-		break;
-	case 0x02:	/*  ToDs=1, FromDs=0 */
-		da = GetAddr3Ptr(pframe);
-		break;
-	default:	/*  ToDs=1, FromDs=1 */
-		da = GetAddr3Ptr(pframe);
-		break;
-	}
-	return da;
-}
-
-static inline unsigned char *get_sa(unsigned char *pframe)
-{
-	unsigned char	*sa;
-	unsigned int	to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
-
-	switch (to_fr_ds) {
-	case 0x00:	/*  ToDs=0, FromDs=0 */
-		sa = GetAddr2Ptr(pframe);
-		break;
-	case 0x01:	/*  ToDs=0, FromDs=1 */
-		sa = GetAddr3Ptr(pframe);
-		break;
-	case 0x02:	/*  ToDs=1, FromDs=0 */
-		sa = GetAddr2Ptr(pframe);
-		break;
-	default:	/*  ToDs=1, FromDs=1 */
-		sa = GetAddr4Ptr(pframe);
-		break;
-	}
-	return sa;
-}
-
 static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 {
 	unsigned char	*sa;
-- 
2.26.2

