Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B397435AE28
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhDJOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhDJOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3402FC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so13073042eju.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zjin5DeeTJdUOIT6m3UarBtO8Sf0Y8qVFDvfTkcozeU=;
        b=n5WhYBhZ5CHPTDYrq14Fa8nJA3e6yObID5CStjBHPPTlCUtPjsJo9L+bTFrBAtHw8Q
         hnvmDvp9rnTm1ZDi1tDewDFtkpAItArqhxqP059Idx0E6e//DK1ankLayXW9q9vGSg85
         zbFSltBtHUobsXNs/whkGxAGWwLyE3MtB3m4rrpt2MK8uv7bMBIxgsMfb5TT9AdLfoEn
         yQhIUl9ighk4AXo7dq/cLTUazisjQuLhZKsu6M8CMgWYx7x3neWm3FuqzH8M8vRiC9fE
         lxjyxufrQxpURpg4skFtBEM80dgkU1rjhqoSrMx6pSvJnoREfMC9gtT3YJyWRWBaNpSh
         3wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zjin5DeeTJdUOIT6m3UarBtO8Sf0Y8qVFDvfTkcozeU=;
        b=cyI9s9C7MsIJMSLQQ4I/QeI5ZzHSWy11zHCQiAP+V2qKj7w0WBpHsd6MgZxgnDnX6V
         mQr2tCuc4N5BLoyNaocTl9JMNn5E9FSqvsHHbAGHu0NcVA5VKw7DRquZlMHZNb1Gi7o6
         FJgAFNqGvFKt4BtbbZvW4Ur+InBvmb8O4Fd+U0kjtbazIZUVSkVc1KRXV5JZjCs1E9Qy
         2ZNxefS2BMttOO0306VaOUoHHUusurJCIoAUp7AL3Qlp9aApalfpr4pbUxn4qjGEyQYL
         9qYt5ZaFFPs9zGsD0m2XSn58r3HbP8iFfk2YHpYSWDNVNMLtf801HBejTC80OYcN2ISi
         2lsA==
X-Gm-Message-State: AOAM530R5yOeGLNhOE1aWammq+39Nfrld67s1BloZM47ymD1fVM7bvTf
        qKrgZ8HxEx0sKQV6m2JCbu17NMenOl2CQw==
X-Google-Smtp-Source: ABdhPJzRxtkF8kN5uvL1xmY63Sca/J0O1TFoj3OdB8xBPVtTHVQGcQPaqRSuoFW0791aUMrpdCk3tA==
X-Received: by 2002:a17:906:2a50:: with SMTP id k16mr19704095eje.537.1618064459780;
        Sat, 10 Apr 2021 07:20:59 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id y16sm3124824edc.62.2021.04.10.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/25] staging: rtl8723bs: remove empty ifdef blocks conditioned to DEBUG_CFG80211 definition
Date:   Sat, 10 Apr 2021 16:20:25 +0200
Message-Id: <7c4485a9d02e8c553c1d81f8b98c8479f481e54c.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty ifdef blocks conditioned to DEBUG_CFG80211
definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 80d9805eaa38..a8697ae5b066 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1310,17 +1310,11 @@ static int rtw_cfg80211_set_probe_req_wpsp2pie(struct adapter *padapter, char *b
 	u8 *wps_ie;
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
-#ifdef DEBUG_CFG80211
-#endif
-
 	if (len > 0)
 	{
 		wps_ie = rtw_get_wps_ie(buf, len, NULL, &wps_ielen);
 		if (wps_ie)
 		{
-			#ifdef DEBUG_CFG80211
-			#endif
-
 			if (pmlmepriv->wps_probe_req_ie)
 			{
 				pmlmepriv->wps_probe_req_ie_len = 0;
@@ -1435,8 +1429,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 
 	/* parsing request ssids, n_ssids */
 	for (i = 0; i < request->n_ssids && i < RTW_SSID_SCAN_AMOUNT; i++) {
-		#ifdef DEBUG_CFG80211
-		#endif
 		memcpy(ssid[i].Ssid, ssids[i].ssid, ssids[i].ssid_len);
 		ssid[i].SsidLength = ssids[i].ssid_len;
 	}
@@ -2681,21 +2673,14 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 		ack = false;
 		ret = _FAIL;
 
-		#ifdef DEBUG_CFG80211
-		#endif
 	} else {
 		msleep(50);
 
-		#ifdef DEBUG_CFG80211
-		#endif
 		ret = _SUCCESS;
 	}
 
 exit:
 
-	#ifdef DEBUG_CFG80211
-	#endif
-
 	return ret;
 
 }
-- 
2.20.1

