Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883B935121F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhDAJXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhDAJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EA2C061794
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jy13so1865474ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whK0jEbKryksV4Tco/q0sErwNXSaatvT6sONXK2sG/Y=;
        b=uIL42zPP52sEEkjGOh3Moj7SXGeTKvJsp8Rd9IqsusYwHR7m+9jW6yd/8iyqKgwhFc
         tHzGsSN92z2DUJbl0G9cFbVjlJj0Ap5Zh4JRjtvGX3QMaOdrTJhHUYtdSzEEQIlkMzFL
         iMEx8RkRwruoSwf+ySLDFEgFzygBSfpnG6PNCttgzfBLq0LpfYTzY+h9h2bka0IttmdO
         Wgg0ewHMmZ93aImU54ShwU7+pswtZfOiUSYIzFt2YGAeDWo4Vum6VTvtmTgTW8pipMeH
         0GkxKsHYPA1eCtnWQEYymh0qw9pLHsV8mWFsg4u7+t9Q5AQRUwZgUwwFwsj3K7TPX5U7
         Qotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whK0jEbKryksV4Tco/q0sErwNXSaatvT6sONXK2sG/Y=;
        b=DEMligFJ6hZdqaoDf6PGS2sFQv9VE7kbcwZFp1j8SMyDql5dpYHH2gvDiP+oX0PEWR
         cEDR4olOVFnbm/i3eRE2YJFpUnAVfL+Xm1cq86gNczIwh2CLvAva5mhktzRk5fERT1uH
         YNPPoETKNi7bd8javnxtEBj5QKxqJarfXSSDK7Nd7s9L5Hw48FbMMqFyVGlMqEkY4K5m
         F64pqMiW9QcybPc+HqrT29QhaRRPfn36FFGSzwbVbZ5dQFN5o2+F9i91K3mWJtSEm1S+
         9IvoVEaTZ+bqzD4zaeQ4mQ3inFoJq9hceyLvKIWlaXzNLjdecwLjDusSoLqEE/ZYWh9e
         tIIA==
X-Gm-Message-State: AOAM531cqMD9n+d0Su8WnlPaqHslVYWXen+U+cdtJO3aGvDg2huCgxNQ
        Rbh+klovPKF+mW3+CrmHVm35/7Ogw4Iyxg==
X-Google-Smtp-Source: ABdhPJwFNrl1XybbUowJTbrAxBWSs23W/D1h0p1F1hffjN/meExjXri4Prsp715srmVLeR79TR+fLg==
X-Received: by 2002:a17:907:10ce:: with SMTP id rv14mr8345846ejb.56.1617268953230;
        Thu, 01 Apr 2021 02:22:33 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id n3sm2434165ejj.113.2021.04.01.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 43/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/ioctl_cfg80211.c
Date:   Thu,  1 Apr 2021 11:21:13 +0200
Message-Id: <3fdf7a35a4991a634cdca30444435abd269b0f1f.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 4f6398f86b75..42c0685e976e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -875,7 +875,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0)
 	{
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
 		DBG_8192C("wpa_set_encryption, crypt.alg = WEP\n");
 
 		wep_key_idx = param->u.crypt.idx;
@@ -1797,7 +1796,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	if (ielen < RSN_HEADER_LEN) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %d\n", ielen));
 		ret  = -1;
 		goto exit;
 	}
@@ -1901,10 +1899,6 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
 		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
-
 exit:
 	kfree(buf);
 	if (ret)
-- 
2.20.1

