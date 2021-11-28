Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE50460699
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357736AbhK1N7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbhK1N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:57:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B7C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so10413481wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDR+IVxxeeTY3pueMAGZ7jxJmYafV0PT+lGE6gPzU/g=;
        b=e0YUHokLR/ZLj7+ok8hihW2xB254hZu3XGxrOslzatqizRd1qpoZ4jagZMeAMiCTHV
         3ffScUUm7oVHZ+1SdZ6WDAP1ZtSzYDlDNo1T4Wn9e9Ux6K+27Oz8MxSu2K6nRdn57qgb
         v9r+B8Cm0aLUkJsOPAqDaXgp/3O5TZPz6qTRV7lEXtEUApt7R181fTkIW9flk2hB/T27
         9xEYFjDvYXgOwAY8y3fhi8ScrUL5xSh55uIgExi/Jpzg0/eFBXggYxBzTDmHN5vtY4qb
         2obzlcKmc98stA1MHfoYL9CkPmuSssrPD27jnHov3JqYTqlFAkFm0/VYeCzdaDEmXNJp
         Yx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDR+IVxxeeTY3pueMAGZ7jxJmYafV0PT+lGE6gPzU/g=;
        b=oBHRKaRz37KRuiO2jZzjm0COw6JT23N5Pk9m7a3h+ic/DxU3ub58HAgb787WlF6mqJ
         0U2WDPTI1oUaxyZLhyc0XDGsnjv+mpL7sjPyFopuVx+oMu87s/pohBegVi85/FGjpQoS
         kI1NrMwRhrl9yEiz4AfU6aG3TCKTAnSH0NWd32Z1ZCn40dvabXJlaVg/Q4pUwcL8+jmP
         94wf6KLdkUjC3Nsgk8urJtvml+tXKoal+7D3NnQBde9Ire9z8hP+0EQb9/YRqj8HE2Wf
         9ONMbGCNsQesIO6T3eFqhHgnR/95Y+kFExyNj8uCEUBPmxZuOnm/uUj8pQKe88UKfriL
         av/A==
X-Gm-Message-State: AOAM531J7y4khG6TyVReiiCoCxRbqPFkQd2XzaHjHwDdpkpaAfXXHJhB
        XNu1shsiJTQZtanuan21rPY=
X-Google-Smtp-Source: ABdhPJwJF17HSv10OSA4m6s/NbRd6+B4Z2lwkVoQs/7hXZWDcni1eA9wG0s1riIWXO1cePZAn32jmw==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr28559309wmh.60.1638107619775;
        Sun, 28 Nov 2021 05:53:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id l26sm13598510wms.15.2021.11.28.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:53:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: remove module parameter rtw_rf_config
Date:   Sun, 28 Nov 2021 14:53:26 +0100
Message-Id: <20211128135326.9838-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128135326.9838-1-straube.linux@gmail.com>
References: <20211128135326.9838-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module parameter rtw_rf_config is not used in the driver.
Remove it and remove the now unused enum rt_rf_type_def.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/drv_types.h |  1 -
 drivers/staging/r8188eu/include/rtw_rf.h    | 10 ----------
 drivers/staging/r8188eu/os_dep/os_intfs.c   |  3 ---
 3 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 3e4928320f17..edcdbd646eaa 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -85,7 +85,6 @@ struct registry_priv {
 	u8	ampdu_amsdu;/* A-MPDU Supports A-MSDU is permitted */
 	u8	lowrate_two_xmit;
 
-	u8	rf_config;
 	u8	low_power;
 
 	u8	wifi_spec;/*  !turbo_mode */
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index 7ec252fec054..d0a408b903dc 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -99,16 +99,6 @@ enum ht_extchnl_offset {
 	HT_EXTCHNL_OFFSET_LOWER = 3,
 };
 
-/* 2007/11/15 MH Define different RF type. */
-enum rt_rf_type_def {
-	RF_1T2R = 0,
-	RF_2T4R = 1,
-	RF_2T2R = 2,
-	RF_1T1R = 3,
-	RF_2T2R_GREEN = 4,
-	RF_819X_MAX_TYPE = 5,
-};
-
 u32 rtw_ch2freq(u32 ch);
 
 #endif /* _RTL8711_RF_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5a5f182d30c9..0021ca578949 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -75,7 +75,6 @@ static int rtw_ampdu_amsdu;/*  0: disabled, 1:enabled, 2:auto */
 
 static int rtw_lowrate_two_xmit = 1;/* Use 2 path Tx to transmit MCS0~7 and legacy mode */
 
-static int rtw_rf_config = RF_819X_MAX_TYPE;  /* auto */
 static int rtw_low_power;
 static int rtw_wifi_spec;
 static int rtw_channel_plan = RT_CHANNEL_DOMAIN_MAX;
@@ -123,7 +122,6 @@ module_param(rtw_ampdu_enable, int, 0644);
 module_param(rtw_rx_stbc, int, 0644);
 module_param(rtw_ampdu_amsdu, int, 0644);
 module_param(rtw_lowrate_two_xmit, int, 0644);
-module_param(rtw_rf_config, int, 0644);
 module_param(rtw_power_mgnt, int, 0644);
 module_param(rtw_smart_ps, int, 0644);
 module_param(rtw_low_power, int, 0644);
@@ -205,7 +203,6 @@ static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
 	registry_par->rx_stbc = (u8)rtw_rx_stbc;
 	registry_par->ampdu_amsdu = (u8)rtw_ampdu_amsdu;
 	registry_par->lowrate_two_xmit = (u8)rtw_lowrate_two_xmit;
-	registry_par->rf_config = (u8)rtw_rf_config;
 	registry_par->low_power = (u8)rtw_low_power;
 	registry_par->wifi_spec = (u8)rtw_wifi_spec;
 	registry_par->channel_plan = (u8)rtw_channel_plan;
-- 
2.34.0

