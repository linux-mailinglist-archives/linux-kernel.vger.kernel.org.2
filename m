Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AD3408DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhCRP1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhCRP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so5979626wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJMPan11ZIOIXvaaG6IEq1o1wjOUodcSegXfGrSmKoM=;
        b=D+w0K5Tvw0NTYtuvB/PqEJn8jrtdAPvRW5C3f9fiUPeoOXX3paUgmBMlBlV91sbitw
         +seK2jliK2Ae4R2DFrF0f8GI721RS6smrJ9HQYAaNNbZvmcIezjXW3IXi1/nMtJEQACs
         CqZtIk7w+fCYIdWkPcwekIxeiCjaRLn3l1cP40m5/ZyQi3GT/qrkezwJ46nfQTX1Js03
         j6/Tgj+ffAHrL1zWBPTHJSWatZLmfONojm+A3WjA+ZBT3xyA5WsErXr2Pho7Qeq7q/QW
         Ud1q0WjFfbkm9Gp6+pwLwlq427xlMYcuNVv4nExIimc4xQS7HlRqgIKk9IqJAmCGSk0r
         96zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJMPan11ZIOIXvaaG6IEq1o1wjOUodcSegXfGrSmKoM=;
        b=htkUbkJgwbUHuzsRPXG3Tl+qYJC716zBRl8RZ8gLdU5HpYyC0C/cQJ02eRhMEC41Sz
         KySJ1sQPKIBCNcHPc1ZUjqW76sCwtVagO1wy7qi1CygL9GF2woqrc4K0M6TcBOsadlXe
         KQYUFgSP+5zxAFcaqxk3bCDxJSayJene1KUk64EzGXAOThk8BV4v7NvsCt+gEb/CTFY0
         EXmMaOLtpH3pJDuDBNmfOZCi9tiaTBNUDPiWdbYuOrZIRWGApNmOHRX59LmCWazRtax7
         ALdJ3U8RI13UYCByBlWABYKDcGZ1QB3X3IetIQY3xOx0PMTnUA87MDNNGk96/aXxmfLX
         DMeA==
X-Gm-Message-State: AOAM530jhPqKIxr4yDXgkRP52xzsmx5SXZPfgtT334JsZLUUIeNJeUyc
        Ff3sQt1FRX39XCzeuoYXf7c=
X-Google-Smtp-Source: ABdhPJy0hMUIQi3Le3rBxr5SqfixuSvCAKXFLNbN7WOUUHJdHrGm0T3i8niXrErdLBBpsb58jS2y0g==
X-Received: by 2002:a5d:4587:: with SMTP id p7mr10337196wrq.205.1616081233415;
        Thu, 18 Mar 2021 08:27:13 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id e1sm3603317wrd.44.2021.03.18.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 12/15] staging: rtl8723bs: remove unnecessary logging in os_dep/ioctl_cfg80211.c
Date:   Thu, 18 Mar 2021 16:26:07 +0100
Message-Id: <20210318152610.16758-13-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
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

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2ff71d001c07..08fbbf05a8c7 100644
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
 
@@ -1405,7 +1398,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
 	struct	wlan_network	*pnetwork = NULL;
 
 #ifdef DEBUG_CFG80211
-	DBG_8192C("%s\n", __func__);
 #endif
 
 	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
@@ -1642,12 +1634,9 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
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
@@ -2219,7 +2208,6 @@ static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
 	struct wireless_dev *wdev,
 	enum nl80211_tx_power_setting type, int mbm)
 {
-	DBG_8192C("%s\n", __func__);
 	return 0;
 }
 
@@ -2227,8 +2215,6 @@ static int cfg80211_rtw_get_txpower(struct wiphy *wiphy,
 	struct wireless_dev *wdev,
 	int *dbm)
 {
-	DBG_8192C("%s\n", __func__);
-
 	*dbm = (12);
 
 	return 0;
-- 
2.20.1

