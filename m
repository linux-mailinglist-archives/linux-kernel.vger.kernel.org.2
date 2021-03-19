Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A84341998
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCSKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCSKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:09:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:09:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r12so8746655ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKRJI3Gl9mfhIYwGZ/LQlbVdVzEyCD4Zbdi95T0hnK4=;
        b=BHKkdM9GakYEIIwoKk0MTOIM3AVoz+iF/J+SNXuMhba3Bs82TGGw4RQbUDixSlTqey
         vi6zR+sQxWDw7QjxpTSqG5Xao4JPUU2tjaTf+Dx8CUN/pwrivqeyOZFbRaKmPz4Yri8a
         7uSs5DFXxqov3M/EpCd7pd+McvxU/t/zCER0mxsCeUm1XlLYuRM+TQr+ZGtWbbJqGM7B
         9qPPYxGeDPC1ZHfuAY2CcBCZyVk0iodEOzZQxFfw0RNSmhYZ0M+bzmr2i/+giDJ+upUm
         EOvRpI04IKpK0CA+XrJi3VyCKT4x38oP/muAfxFD1m/PJ8Z8XDKZ9CYqKsIrV3fYKmel
         mARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKRJI3Gl9mfhIYwGZ/LQlbVdVzEyCD4Zbdi95T0hnK4=;
        b=j4n4EYA6yrBlirn4bGqh0AFlmJdyHy3HYCYTJZeSbyBVvUktZIKWIvSN0Mq3e7bZgC
         vqw7xqa/IoqatDBlodEtV6xtR3aID/+ZbdbktTLJ4DEawYnw2NUDFzXRtPOAYg3wdIYV
         tCXvCU5Y75IFFcbYClrW2fSA+pLYxzjF69VyVydyxFAmLuueCxdFl04whDkhsA/KtadR
         ASDHN/B5dud24j50rSG6aubtc6F1kK3buz57QbawU5214QeITL1bcn3vy+zz3wfeHzRL
         aVRxnlPMpxTXYX/ye6m4lAkSGfK8EtBfYvdWwxgv/XES/qMworbzpmP4KcSiWOpGeqwE
         YsPQ==
X-Gm-Message-State: AOAM5338QZOp6tAoLAW1yHLJ8dy8tTxGpOpu2/DMYqUicANUq6qJVwNp
        gGJ6+W0mbpb7n5L1uK7eaak=
X-Google-Smtp-Source: ABdhPJyqkUWVRA5pO8yyaNf/wnPKJzEm+FtFT2ui/eSzhsAz/E8apxWpHjPXjJ0EIzLw1cNZpDmsQA==
X-Received: by 2002:a17:906:40c7:: with SMTP id a7mr3389413ejk.109.1616148597037;
        Fri, 19 Mar 2021 03:09:57 -0700 (PDT)
Received: from agape (fi-19-219-204.service.infuturo.it. [151.19.219.204])
        by smtp.gmail.com with ESMTPSA id h8sm3782323ede.25.2021.03.19.03.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:09:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: remove unnecessary logging in os_dep/ioctl_cfg80211.c
Date:   Fri, 19 Mar 2021 11:09:23 +0100
Message-Id: <20210319100923.4314-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319092122.GF2087@kadam>
References: <20210319092122.GF2087@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
239: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:239:
+	/* DBG_8192C("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
569: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:569:
+	DBG_8192C("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
854: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:854:
+	DBG_8192C("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1408: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:1408:
+	DBG_8192C("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1645: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:1645:
+	DBG_8192C("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
2222: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2222:
+	DBG_8192C("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
2230: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2230:
+	DBG_8192C("%s\n", __func__);

Changes in v2:
	removed empty #ifdef block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c   | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index e70bb7f1ca3a..a577ddcce8cd 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -235,9 +235,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	struct wiphy *wiphy = wdev->wiphy;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-
-	/* DBG_8192C("%s\n", __func__); */
-
 	bssinf_len = pnetwork->network.IELength + sizeof(struct ieee80211_hdr_3addr);
 	if (bssinf_len > MAX_BSSINFO_LEN) {
 		DBG_871X("%s IE Length too long > %d byte\n", __func__, MAX_BSSINFO_LEN);
@@ -566,8 +563,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
 	struct security_priv *psecuritypriv =  &(padapter->securitypriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_8192C("%s\n", __func__);
-
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
@@ -851,8 +846,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	DBG_8192C("%s\n", __func__);
-
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
@@ -1404,10 +1397,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 	struct __queue *queue	= &(pmlmepriv->scanned_queue);
 	struct	wlan_network	*pnetwork = NULL;
 
-#ifdef DEBUG_CFG80211
-	DBG_8192C("%s\n", __func__);
-#endif
-
 	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 
 	phead = get_list_head(queue);
@@ -1642,12 +1631,9 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 static int cfg80211_rtw_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 {
-	DBG_8192C("%s\n", __func__);
 	return 0;
 }
 
-
-
 static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32 wpa_version)
 {
 	DBG_8192C("%s, wpa_version =%d\n", __func__, wpa_version);
@@ -2219,7 +2205,6 @@ static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
 	struct wireless_dev *wdev,
 	enum nl80211_tx_power_setting type, int mbm)
 {
-	DBG_8192C("%s\n", __func__);
 	return 0;
 }
 
@@ -2227,8 +2212,6 @@ static int cfg80211_rtw_get_txpower(struct wiphy *wiphy,
 	struct wireless_dev *wdev,
 	int *dbm)
 {
-	DBG_8192C("%s\n", __func__);
-
 	*dbm = (12);
 
 	return 0;
-- 
2.20.1

