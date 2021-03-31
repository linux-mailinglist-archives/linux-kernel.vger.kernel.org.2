Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD234FD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbhCaJm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhCaJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71BC061761
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt15so29045056ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELwmxXeBIsDchhOORDJRl9CMop2vhKZZT8xFyRFrBms=;
        b=WUZl67xYh2YUhRgwuoHgfgl5nZ/gKDg1KPJjzwjiO1Z46+CcBhg7wuQZ7KK8D73CuD
         XDqvdwSqDTjSZo4yeTpxlmcnfq5tDeO/+NjvOlcx4bzXRZHw3kJgFYvspJPy6WCDIdEi
         beFjnSO9xtcLD7zMkcoJqKSLZ2wCtf9TvXhqPsEllvzQzLU8lEiUUpgRlfcjmx7DmGft
         aCNL44mjR0DFJvbIz5i+tyh0OB+s+MJnEobpynfJA2AdNY3uQZGyzKYxV0+4T0i/liFP
         tAt50wmrl63j61VoyTA1nNL5NS7+77zEpn+J7tTR+6StSNiXYfpo2DPhZo/5c5tEvlb+
         mQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELwmxXeBIsDchhOORDJRl9CMop2vhKZZT8xFyRFrBms=;
        b=OVWjdDPqo2zqJBPjUei9q/S5xOC+WxySkujB2J0cp7ldLepjM/h1DMQj/fND1q6ssD
         2+EgMVlq3AVmhq+obP/7bsLaZiQfPUYCBNquYxkl+dWggn8AO4IOaOxkj+hDeaCRupB4
         cQQHzVZODkFUD/LtaDldybolC86girWdTZJBVDWxPp35Vol+FDh0890/aXTQNE18sYG5
         QfZfpRx6teZ8+kV9ksBVrqw3JacVjWJeY/4zhfu82p8HM1DQ259J0SuLgsm5tK82gTrW
         pP0M1hIK5I88vGM7V0cOV12BoTf6IWFWZoVXJiU8CbdZIHQUEcm+l5Rv8xKRSu4sAkSI
         xdKA==
X-Gm-Message-State: AOAM531rUJ5jl3eZxbn2iC3BjW9RhKQCMFQBJ/y0fblGwnoJIaAhn5jD
        aYHuUVmjSBfnsZWmdRK4Ung=
X-Google-Smtp-Source: ABdhPJzrViTY5hqbNwoP531uofoZoKT6yO7sBxY4tEqg2tn0JyR+CW3IiZ5RL1HmzJfobhcdzUOTvw==
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr2579929ejg.330.1617183675868;
        Wed, 31 Mar 2021 02:41:15 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id pg2sm818663ejb.49.2021.03.31.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 34/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/ioctl_cfg80211.c
Date:   Wed, 31 Mar 2021 11:40:02 +0200
Message-Id: <6d3a356fdfd988e575ad03e8469b171471a6a366.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 260d9fa739ef..6df2f1e12bd3 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -875,7 +875,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0)
 	{
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("wpa_set_encryption, crypt.alg = WEP\n"));
+		pr_err("%s wpa_set_encryption, crypt.alg = WEP\n", DRIVER_PREFIX);
 		DBG_8192C("wpa_set_encryption, crypt.alg = WEP\n");
 
 		wep_key_idx = param->u.crypt.idx;
@@ -1797,7 +1797,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 	}
 
 	if (ielen < RSN_HEADER_LEN) {
-		RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, ("Ie len too short %ld\n", ielen));
+		pr_err("%s Ie len too short %ld\n", DRIVER_PREFIX, ielen);
 		ret  = -1;
 		goto exit;
 	}
@@ -1901,9 +1901,13 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 		/*  check_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS) == true) */
 		rtw_hal_set_hwreg(padapter, HW_VAR_OFF_RCR_AM, null_addr);
 
-	RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_info_,
-		("rtw_set_wpa_ie: pairwise_cipher = 0x%08x padapter->securitypriv.ndisencryptstatus =%d padapter->securitypriv.ndisauthtype =%d\n",
-		pairwise_cipher, padapter->securitypriv.ndisencryptstatus, padapter->securitypriv.ndisauthtype));
+	pr_info("%s rtw_set_wpa_ie: pairwise_cipher = 0x%08x "
+		"padapter->securitypriv.ndisencryptstatus =%d "
+		"padapter->securitypriv.ndisauthtype =%d\n",
+		DRIVER_PREFIX,
+		pairwise_cipher,
+		padapter->securitypriv.ndisencryptstatus,
+		padapter->securitypriv.ndisauthtype);
 
 exit:
 	kfree(buf);
-- 
2.20.1

