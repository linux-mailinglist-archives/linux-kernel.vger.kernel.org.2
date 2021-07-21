Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D433D0FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhGUM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbhGUM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E23C0613E3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bu12so3377267ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sL2olSMTJFzVJiuJQ17ZzQTo2MiVeT3LUtk6TNAxUlk=;
        b=fU5LI4XQ+qWe8BJfHUAnwmx32Siftjh9MqZm2Q6N1Be7szRcJVT3UbQGZn5df3fVAU
         jZCufU/Hc8I2vjiI4RSY4moied5qHZ92moVoEmMGiKT0LnPzkxZo/XHyQHwSJZh9sBxK
         KIPgNSPDipH2747tq2HaAVHBCqwmu3hCFDZMNF5gkmJ+f0QwnGYkShxJC4ciQm/L220K
         4ReiN/Y4m18qDoM9/FqLv/IhJADhqD7eDlAk5XVEjHV4fatGat9NNCCeW1zozT8aS7Op
         MXSqQhqyGP92LmXckYbYaQWbFnvYFf/waFqbjONqSeDoFZWSTV4v5zArjd69iqUq+PfY
         UE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sL2olSMTJFzVJiuJQ17ZzQTo2MiVeT3LUtk6TNAxUlk=;
        b=hPBjoRrrvX8xoj4NrxcQBvRw7Ad5x0WrsMnN2CP9taWpNyMTa33bIESSBsaSg+6nRO
         6r796+dtAuQ6fzDG/kN/mUgxe6dNZjbGW6tvCsKjkuHpMphFIt1ofbT+YbyFUltn8ULY
         2fPiZuMiCjFwzFLORpKyXHukg6Y7lTQwoDC+vsWoEQXlCT6LV9/vjLAbyC8fKIfWEsy9
         K477fi0Udvs+M6DlobkVFJfyEfUrqBNSMdOe/di6FAJdI3S1/RiJ5ssUQCdjIUGjogK2
         DAbRdl3toPzyreVbdQpla4W1ZHX2uPqHftyS4YF8jeLgmlgD24kcWZCFQGxZRlpGz4gw
         1nWg==
X-Gm-Message-State: AOAM532Jg1C9NIwLYGEFRJX8X3y0+/nUBBApmPCegZ2U4QOZlieem2aL
        gIIgQYLufxG5REH7ltXq4Kokm5j/Tyg=
X-Google-Smtp-Source: ABdhPJwvBw1oCqokEK0IIHcLW1inGZ109gt32UVUyWUaZ7vzwk0o3pEfHNUpcliZjBI7VEN039v1TA==
X-Received: by 2002:a17:907:70c6:: with SMTP id yk6mr37553467ejb.42.1626874663082;
        Wed, 21 Jul 2021 06:37:43 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id ba25sm10714239edb.1.2021.07.21.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] staging: rtl8723bs: fix camel case in struct wlan_bcn_info
Date:   Wed, 21 Jul 2021 15:37:19 +0200
Message-Id: <52c74cf0183da44f2ddaac2607e4b7ccaf9abd91.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in struct wlan_bcn_info all over the driver.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 28 +++++++++----------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 16 +++++------
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 57a75e1f9a56..b7ad4a11a7b7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1034,9 +1034,9 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 
 	if (pbuf && (wpa_ielen > 0)) {
 		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
-			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
-			pnetwork->BcnInfo.group_cipher = group_cipher;
-			pnetwork->BcnInfo.is_8021x = is8021x;
+			pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
+			pnetwork->bcn_info.group_cipher = group_cipher;
+			pnetwork->bcn_info.is_8021x = is8021x;
 			ret = _SUCCESS;
 		}
 	} else {
@@ -1044,9 +1044,9 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 
 		if (pbuf && (wpa_ielen > 0)) {
 			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is8021x)) {
-				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
-				pnetwork->BcnInfo.group_cipher = group_cipher;
-				pnetwork->BcnInfo.is_8021x = is8021x;
+				pnetwork->bcn_info.pairwise_cipher = pairwise_cipher;
+				pnetwork->bcn_info.group_cipher = group_cipher;
+				pnetwork->bcn_info.is_8021x = is8021x;
 				ret = _SUCCESS;
 			}
 		}
@@ -1073,17 +1073,17 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		bencrypt = 1;
 		pnetwork->network.privacy = 1;
 	} else {
-		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
+		pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_OPENSYS;
 	}
 	rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, NULL, &rsn_len, NULL, &wpa_len);
 
 	if (rsn_len > 0) {
-		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
+		pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_WPA2;
 	} else if (wpa_len > 0) {
-		pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WPA;
+		pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_WPA;
 	} else {
 		if (bencrypt)
-			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
+			pnetwork->bcn_info.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
 	rtw_get_cipher_info(pnetwork);
 
@@ -1092,17 +1092,17 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_CAPABILITY, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_cap = (struct ieee80211_ht_cap *)(p + 2);
-			pnetwork->BcnInfo.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
+			pnetwork->bcn_info.ht_cap_info = le16_to_cpu(pht_cap->cap_info);
 	} else {
-			pnetwork->BcnInfo.ht_cap_info = 0;
+			pnetwork->bcn_info.ht_cap_info = 0;
 	}
 	/* parsing HT_INFO_IE */
 	p = rtw_get_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, WLAN_EID_HT_OPERATION, &len, pnetwork->network.ie_length - _FIXED_IE_LENGTH_);
 	if (p && len > 0) {
 			pht_info = (struct HT_info_element *)(p + 2);
-			pnetwork->BcnInfo.ht_info_infos_0 = pht_info->infos[0];
+			pnetwork->bcn_info.ht_info_infos_0 = pht_info->infos[0];
 	} else {
-			pnetwork->BcnInfo.ht_info_infos_0 = 0;
+			pnetwork->bcn_info.ht_info_infos_0 = 0;
 	}
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index f9042f1dadb5..efd0cbbde389 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1248,12 +1248,12 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	} else {
 		ht_info_infos_0 = 0;
 	}
-	if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
-	    ((ht_info_infos_0&0x03) != (cur_network->BcnInfo.ht_info_infos_0&0x03))) {
+	if (ht_cap_info != cur_network->bcn_info.ht_cap_info ||
+	    ((ht_info_infos_0&0x03) != (cur_network->bcn_info.ht_info_infos_0&0x03))) {
 		{
 			/* bcn_info_update */
-			cur_network->BcnInfo.ht_cap_info = ht_cap_info;
-			cur_network->BcnInfo.ht_info_infos_0 = ht_info_infos_0;
+			cur_network->bcn_info.ht_cap_info = ht_cap_info;
+			cur_network->bcn_info.ht_info_infos_0 = ht_info_infos_0;
 			/* to do : need to check that whether modify related register of BB or not */
 		}
 		/* goto _mismatch; */
@@ -1313,7 +1313,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		if (bssid->privacy)
 			encryp_protocol = ENCRYP_PROTOCOL_WEP;
 
-	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol)
+	if (cur_network->bcn_info.encryp_protocol != encryp_protocol)
 		goto _mismatch;
 
 	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
@@ -1329,11 +1329,11 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 						  &pairwise_cipher, &is_8021x);
 		}
 
-		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher ||
-		    group_cipher != cur_network->BcnInfo.group_cipher)
+		if (pairwise_cipher != cur_network->bcn_info.pairwise_cipher ||
+		    group_cipher != cur_network->bcn_info.group_cipher)
 			goto _mismatch;
 
-		if (is_8021x != cur_network->BcnInfo.is_8021x)
+		if (is_8021x != cur_network->bcn_info.is_8021x)
 			goto _mismatch;
 	}
 
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 4e6d0b8e17a6..8c9d78c35650 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -194,7 +194,7 @@ struct	wlan_network {
 	int	aid;			/* will only be valid when a BSS is joinned. */
 	int	join_res;
 	struct wlan_bssid_ex	network; /* must be the last item */
-	struct wlan_bcn_info	BcnInfo;
+	struct wlan_bcn_info	bcn_info;
 };
 
 enum {
-- 
2.20.1

