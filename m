Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312F34607E9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358815AbhK1RPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358599AbhK1RNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04BBC06175F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so10673525wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDR+IVxxeeTY3pueMAGZ7jxJmYafV0PT+lGE6gPzU/g=;
        b=S5upfRz9lN77QH3G8CFZjUiEavx1EituaAIIS0ZVDRdzwB7zjfd2vl6ZO+Jj6uXKd5
         wGtfpVXYru01kEk/OC8uYWcTifWWRVffUV61HVY4J+voUE+543QU1xrtcTwpTGX1Nak0
         RvNN4ltyJysLXL/m1QXNqY0WG7yMqvneFcMWheKYFmZ8YaVVJBsYA7mBvYtWXptX3C71
         U2emytwQQoTmzr4/JB1x2e/i0BZ3+svXvTXHxsH7Wl+mKibWo2p4EqO3dPjlw0iqT382
         n5wn+xtQ2eB3BaP2M/g4mfzRh5hpXXUFphBZ5L9gq9ikiBwyf00Df5P903/zY/ZDQSU5
         KhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDR+IVxxeeTY3pueMAGZ7jxJmYafV0PT+lGE6gPzU/g=;
        b=kUvAMzFnQBJQDfOhouJ9VcgI1ZxNBPrzmhBqpn02Uzgx59XDoe8TJJcVK/taHkJcDo
         PmwPCbPFQxxEEIynB2c8AHfc2gMDkaQXFDM1O6InyfDQ9LA0HsJc7Toj4Sou7zgqZGHV
         Uf7NvdKDugRhjy7dCILeoq3nGyMaV0N46M5fR5A94BALFVBkDVdg1VuoGrWsjJr75vZ/
         JnZneHOw5oAenat7V+4SsgcLhmLW+M6hgrO0VOb0Z0h9AlhobFABE0MSrPy2Plhx4fZB
         TwoiOtex0fDoO/NijCWHPoG3vgEEOu9FZbfdKhrdSdjqw07CqJP0moiKx1owYGRz9PHg
         6uRQ==
X-Gm-Message-State: AOAM532Gk4CbcMYAP5B9vL2aSr0yfFJ0VEK9g4ObsQSPn227fKY8hQFV
        J1GhDPTp8HzXrGOlhTP9iK4=
X-Google-Smtp-Source: ABdhPJymkgns9D9qgHJXuC1+m/H1yB/tlovzTOzwy3lgONbZuLc8hCIfufDa5HYB5cY5wtyoCz9CSw==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr30923511wmg.17.1638119397390;
        Sun, 28 Nov 2021 09:09:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:57 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 10/10] staging: r8188eu: remove module parameter rtw_rf_config
Date:   Sun, 28 Nov 2021 18:09:24 +0100
Message-Id: <20211128170924.5874-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
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

