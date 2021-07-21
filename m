Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7C3D0FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhGUM5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbhGUM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54773C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dt7so3254722ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Bi9DwmNWWWg3asORS1IMubF6JoFpH2zkAxIka24O8c=;
        b=gaagWJxSOfTULyUGxXZU1ytIx1Irjg9JkZblJdqUOolOKZN+2z3caDItaVNOi62fQE
         /3qTmm7YegmDFfhscsvIT9CHtHNUMzD8ve45BwQT2nvkzJMf6Z0XfG+GtqGSTm2fqoOg
         O/dZaANMv9iVams16mVki0w6WnWkkBSW9ABUN4u+sQpKgtlasdXim/23jxLU70dSld14
         csZaIfScCCTYnChsXWnAbtiXgt2LIg78orfdZH7Yb1Mv0wIjsP7/z9jPfjGYiw242kvs
         60wEAI2Q/C/HpTwE4eBE5vSnSzXIDj5wSnhWXIJdAgY8v1StyXOzftocYTFIgxTTbdUA
         5zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Bi9DwmNWWWg3asORS1IMubF6JoFpH2zkAxIka24O8c=;
        b=awQhSWgaPtmGkCh4dhG+/+lXR6dBVt8bdCGjGaje2l4/9WaMpEQmBg2/GbXpN+F6Y1
         5tWY85fFYwtwfVEC1GUXIAUnD2zXci2vaz2Dm6ZvqJa1UJDG06tAxxTOrHIsvy8hrLUs
         qrAPszLdYK0jXw+OTCVvLU1OEmyd+B6aTpWkay8NjZ4KrnhdXwARquezZQ6JbTr+IM2M
         4COva7ivQvr9ZJFbrS5ukWcQOkIplEU7lihHY5kMdqF5cV83OVCZjCcRfBzWF8I1JL5N
         c5bRc6kykt5vcAkc1WfPYg/VYMYFtUV8SNLC8LoiW+i4PYAh7MQK9vaHPWJixVyDPZ62
         hdPA==
X-Gm-Message-State: AOAM533tNqVN8omOgvnZDPF2yFsbJVXer1X+hhuQj12NnK5aEdjNqzu9
        SOQWDygR0ieCdLGczuSh3woc6KsS3NE=
X-Google-Smtp-Source: ABdhPJyIDUMlZ2jQtawlmKJ5NSP33eva3l85l9Roo9ZB8KweQAdWSRtinScHIAPMuxoqsSwcRsDYMg==
X-Received: by 2002:a17:907:2717:: with SMTP id w23mr24597386ejk.377.1626874668801;
        Wed, 21 Jul 2021 06:37:48 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id b19sm3111699edt.53.2021.07.21.06.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] staging: rtl8723bs: fix camel case in struct ndis_802_11_wep
Date:   Wed, 21 Jul 2021 15:37:23 +0200
Message-Id: <d3a1407e1bcb07d423dfa0c9bd33021a59bc0b61.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in struct ndis_802_11_wep all over the driver.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  8 +--
 .../staging/rtl8723bs/include/wlan_bssdef.h   |  8 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 12 ++---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 54 +++++++++----------
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 03a7da84bf23..8914ef3d33c8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -494,14 +494,14 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	struct security_priv *psecuritypriv = &(padapter->securitypriv);
 	u8 ret = _SUCCESS;
 
-	keyid = wep->KeyIndex & 0x3fffffff;
+	keyid = wep->key_index & 0x3fffffff;
 
 	if (keyid >= 4) {
 		ret = false;
 		goto exit;
 	}
 
-	switch (wep->KeyLength) {
+	switch (wep->key_length) {
 	case 5:
 		psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 		break;
@@ -513,9 +513,9 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		break;
 	}
 
-	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
+	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->key_material), wep->key_length);
 
-	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
+	psecuritypriv->dot11DefKeylen[keyid] = wep->key_length;
 
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index b101a3ac40ff..530c95275c1e 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -110,10 +110,10 @@ enum {
 /*  Key mapping keys require a BSSID */
 
 struct ndis_802_11_wep {
-	u32 Length;        /*  Length of this structure */
-	u32 KeyIndex;      /*  0 is the per-client key, 1-N are the global keys */
-	u32 KeyLength;     /*  length of key in bytes */
-	u8 KeyMaterial[16];/*  variable length depending on above field */
+	u32 length;        /*  Length of this structure */
+	u32 key_index;      /*  0 is the per-client key, 1-N are the global keys */
+	u32 key_length;     /*  length of key in bytes */
+	u8 key_material[16];/*  variable length depending on above field */
 };
 
 /*  mask for authentication/integrity fields */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index bcd8d03a35a0..dc23470fcdef 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1874,7 +1874,7 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
+			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
 			pwep = rtw_malloc(wep_total_len);
 			if (pwep == NULL) {
 				ret = -ENOMEM;
@@ -1883,8 +1883,8 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 
 			memset(pwep, 0, wep_total_len);
 
-			pwep->KeyLength = wep_key_len;
-			pwep->Length = wep_total_len;
+			pwep->key_length = wep_key_len;
+			pwep->length = wep_total_len;
 
 			if (wep_key_len == 13) {
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
@@ -1895,10 +1895,10 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 			goto exit;
 		}
 
-		pwep->KeyIndex = wep_key_idx;
-		pwep->KeyIndex |= 0x80000000;
+		pwep->key_index = wep_key_idx;
+		pwep->key_index |= 0x80000000;
 
-		memcpy(pwep->KeyMaterial,  (void *)sme->key, pwep->KeyLength);
+		memcpy(pwep->key_material,  (void *)sme->key, pwep->key_length);
 
 		if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
 			ret = -EOPNOTSUPP;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 8c44db696b52..1383f84a4425 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -411,15 +411,15 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
+			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep) {
 				ret = -ENOMEM;
 				goto exit;
 			}
 
-			pwep->KeyLength = wep_key_len;
-			pwep->Length = wep_total_len;
+			pwep->key_length = wep_key_len;
+			pwep->length = wep_total_len;
 
 			if (wep_key_len == 13) {
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP104_;
@@ -430,10 +430,10 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			goto exit;
 		}
 
-		pwep->KeyIndex = wep_key_idx;
-		pwep->KeyIndex |= 0x80000000;
+		pwep->key_index = wep_key_idx;
+		pwep->key_index |= 0x80000000;
 
-		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
+		memcpy(pwep->key_material,  param->u.crypt.key, pwep->key_length);
 
 		if (param->u.crypt.set_tx) {
 			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
@@ -447,8 +447,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 				goto exit;
 			}
 
-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->KeyMaterial, pwep->KeyLength);
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
+			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
+			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
 			rtw_set_key(padapter, psecuritypriv, wep_key_idx, 0, true);
 		}
 
@@ -1667,15 +1667,15 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		padapter->securitypriv.ndisauthtype = authmode;
 	}
 
-	wep.KeyIndex = key;
+	wep.key_index = key;
 	if (erq->length > 0) {
-		wep.KeyLength = erq->length <= 5 ? 5 : 13;
+		wep.key_length = erq->length <= 5 ? 5 : 13;
 
-		wep.Length = wep.KeyLength + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
+		wep.length = wep.key_length + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
 	} else {
-		wep.KeyLength = 0;
+		wep.key_length = 0;
 
-		if (keyindex_provided == 1) { /*  set key_id only, no given KeyMaterial(erq->length == 0). */
+		if (keyindex_provided == 1) { /*  set key_id only, no given key_material(erq->length == 0). */
 			padapter->securitypriv.dot11PrivacyKeyIndex = key;
 
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
@@ -1696,9 +1696,9 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 	}
 
-	wep.KeyIndex |= 0x80000000;
+	wep.key_index |= 0x80000000;
 
-	memcpy(wep.KeyMaterial, keybuf, wep.KeyLength);
+	memcpy(wep.key_material, keybuf, wep.key_length);
 
 	if (rtw_set_802_11_add_wep(padapter, &wep) == false) {
 		if (rf_on == pwrpriv->rf_pwrstate)
@@ -2974,19 +2974,19 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
+			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, key_material);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep)
 				goto exit;
 
-			pwep->KeyLength = wep_key_len;
-			pwep->Length = wep_total_len;
+			pwep->key_length = wep_key_len;
+			pwep->length = wep_total_len;
 
 		}
 
-		pwep->KeyIndex = wep_key_idx;
+		pwep->key_index = wep_key_idx;
 
-		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
+		memcpy(pwep->key_material,  param->u.crypt.key, pwep->key_length);
 
 		if (param->u.crypt.set_tx) {
 			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
@@ -2994,7 +2994,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
 			psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 
-			if (pwep->KeyLength == 13) {
+			if (pwep->key_length == 13) {
 				psecuritypriv->dot11PrivacyAlgrthm = _WEP104_;
 				psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			}
@@ -3002,20 +3002,20 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;
 
-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->KeyMaterial, pwep->KeyLength);
+			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
 
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
+			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
 
-			rtw_ap_set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx, 1);
+			rtw_ap_set_wep_key(padapter, pwep->key_material, pwep->key_length, wep_key_idx, 1);
 		} else {
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to cam */
 
-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->KeyMaterial, pwep->KeyLength);
+			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->key_material, pwep->key_length);
 
-			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
+			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->key_length;
 
-			rtw_ap_set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx, 0);
+			rtw_ap_set_wep_key(padapter, pwep->key_material, pwep->key_length, wep_key_idx, 0);
 		}
 
 		goto exit;
-- 
2.20.1

