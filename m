Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCE3EDA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhHPQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbhHPQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72EBC061796
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k4so11879942wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCfuu08NjMYhv5PuIppJ+v+CEj6fiVf/mdmZGX10GxA=;
        b=luL/RkGgFNyn53BCcVkWJUVIBubk8oXNdZbrXhtrD7vq0K14kQHDqhM7OC37WwG2rf
         jaNIDK0PcnO+A5Nrtp0xMORLGAqZAR/TPyaOJmaco8k5e41xOPMoaUpj4rZ6uO9dj3mg
         689mquNpku0gQui+hs1+jdql0Hn+iF4/hfUGhE9dp2dhhWflnPQpDCscrzLjSJzGjrA3
         umu35LwTK2suvs22bbMYXXPWUvFUC2+gDxeYgjc/DNKktPgZ4Sx1rmeLXLSolc22kgeP
         STEdjlk10auQKwFva86KPzClg7AGmYHgBBNP43znrB0Lwt5izTCIhPNPfqjUU6NFxZ/7
         IdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCfuu08NjMYhv5PuIppJ+v+CEj6fiVf/mdmZGX10GxA=;
        b=rfjwGZFvCYg68VdjM3hMLL2iz3H6oE83kYMhSwPnC1ah+l6SC4dVBLv2PWGEMAvp3T
         52ycDr7t9bo8UfhUX4SpceKx0IuVm6NwVEK6uJTtmdvBIF7p+OTl5//PJXLWWEgrK+lQ
         tOD6NmnXAt3di5QkjgaCfkfPk5S7NfHZ79CAISVwJSQhqI1+Xnef9gI9jVghdhTKUaiT
         LdxYRqRiTUbBT8kJflZaBQ6jCsDosStA72+CoKH2GVCcILkACx2Y4dg739klNFwO7kDI
         i2biryu6QsCK1MdhxBAtjpHFhvyezDUDR1zoM5Pn6MJFH3sixF/vSQdjbgWvXomxCh6K
         UtBQ==
X-Gm-Message-State: AOAM5330VyxTaKLqLQQu022GZni3/yieAjpIj8w8Mt7XA0i6MSMAv0Z8
        yBgaxJ5Oaju//vULPGF27WkJbGCv0n0=
X-Google-Smtp-Source: ABdhPJyXhLNCQAkwZ1nPyBu9fyyEmRu1N17Y2I/pX+roEcNrzmynjtU2LRygvlUfmOkOllJJws9snA==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr15538572wmb.112.1629129568552;
        Mon, 16 Aug 2021 08:59:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/23] staging: r8188eu: clean up spacing style issues in core/rtw_ioctl_set.c
Date:   Mon, 16 Aug 2021 17:58:03 +0200
Message-Id: <20210816155818.24005-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up spacing style issues in core/rtw_ioctl_set.c reported by
checkpatch.

CHECK: spaces preferred around that ...
WARNING: space prohibited before semicolon

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index bb6bc6508255..edfea5ad8259 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -154,7 +154,7 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 		goto release_mlme_lock;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid, ETH_ALEN)) {
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)
 				goto release_mlme_lock;/* it means driver is in WIFI_ADHOC_MASTER_STATE, we needn't create bss again. */
@@ -228,7 +228,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 		goto release_mlme_lock;
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid, ssid->SsidLength))) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
@@ -389,7 +389,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 		goto exit;
 	}
 
-	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING)) ||
+	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) ||
 	    (pmlmepriv->LinkDetectInfo.bBusyTraffic)) {
 		/*  Scan or linking is in progress, do nothing. */
 		res = true;
@@ -623,8 +623,8 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		struct ndis_802_11_wep *wep = &padapter->securitypriv.ndiswep;
 
 		wep->Length = len;
-		keyindex = key->KeyIndex&0x7fffffff;
-		wep->KeyIndex = keyindex ;
+		keyindex = key->KeyIndex & 0x7fffffff;
+		wep->KeyIndex = keyindex;
 		wep->KeyLength = key->KeyLength;
 
 		memcpy(wep->KeyMaterial, key->KeyMaterial, key->KeyLength);
@@ -654,7 +654,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 
 		if (bgrouptkey)
 			padapter->securitypriv.dot118021XGrpKeyid = (u8)key->KeyIndex;
-		if ((key->KeyIndex&0x3) == 0) {
+		if ((key->KeyIndex & 0x3) == 0) {
 			ret = _FAIL;
 			goto exit;
 		}
@@ -796,9 +796,9 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		return 0;
 
 	if (pmlmeext->cur_wireless_mode & (WIRELESS_11_24N)) {
-		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength-12);
+		p = rtw_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0) {
-			pht_capie = (struct ieee80211_ht_cap *)(p+2);
+			pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 
 			memcpy(&mcs_rate, pht_capie->mcs.rx_mask, 2);
 
@@ -819,7 +819,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 		}
 	} else {
 		while ((pcur_bss->SupportedRates[i] != 0) && (pcur_bss->SupportedRates[i] != 0xFF)) {
-			rate = pcur_bss->SupportedRates[i]&0x7F;
+			rate = pcur_bss->SupportedRates[i] & 0x7F;
 			if (rate > max_rate)
 				max_rate = rate;
 			i++;
-- 
2.32.0

