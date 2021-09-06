Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742E2401F86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbhIFS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbhIFS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e21so14895238ejz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4xkTtQ3wuvhdh3g04JX3HPGsYGJOr6tST/yQR3N1No=;
        b=afWwh8SlpRQgFxdu6p52VMMT0pIdFap/oBBvT6vT3Gu6nPVbxVfc1yrfvJZBb/tOmN
         jk/sAnIN4IWnRGaJdJl7+TzW6/IMNC3lX3U7cGw2m9zNDHIPnC2JwnrB0QTBnGrIoR10
         lsn0hdtp0PjA1mzNqUKLTg3rFucjadWN/Gyw+bzfcTiFMtFshAWyNmxGCotFdUiD3wyu
         0kJu8rKgKO3aZfEnhfcCOamQY+hJf/rVddo0wbJaVEZp42e5dZ/+dij5P9WhSvaoT6FG
         HQEkbznmubMpjRihu0ZcB0hh3raYLrNxHqNLPYN1uqNGrc84KZoI3Uld2u7e8QRrvTel
         KWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4xkTtQ3wuvhdh3g04JX3HPGsYGJOr6tST/yQR3N1No=;
        b=rEmsR/sP1EVctRjQvDsYfbnixuatn8IduiLIB8ReBi2wc6iyEcmeR98LV24sVD72U6
         iI/rb2qdM5wFlOP/cBoZ64TKuww/gYYDK0XYLekBBP7nyJQ1ofl1E4hXS1SZbUbWC0ed
         urKGt7TCfEPD1FjX3hWvZU/D3zoTPrv56pt8uNSDBV/JLxalaWe9QyyoSBY5VmJ9wHAj
         t6/jMU2rf7D3nGvyB29S7CYhY351Ex1KoP1ZokENp7YAgmeAQkWfkxv7mB7iEg0wk926
         sg8r/9Rcv1b2lgtZnlOaZzbv4Q+OcRvCXGtRWg7T5WlmqMqgspasFJJ8Cu4BjUp4kVPd
         Wwhw==
X-Gm-Message-State: AOAM5311NbZs/OOwdq2IvPJNNR/sOQDt1zYMK2ftEFHzocrMpD1DfsWO
        FSYs4m1lmTwfuT8gqKHPrDk=
X-Google-Smtp-Source: ABdhPJwvJB7if0txSW/sHXRhHpBExx6IyOYQ7pmuj6aep+IgNaEX1SHcdyim90Y8gTQOv5tPEiramQ==
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr14733640ejk.147.1630952702282;
        Mon, 06 Sep 2021 11:25:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/40] staging: r8188eu: remove DeInitSwLeds from hal_ops
Date:   Mon,  6 Sep 2021 20:24:00 +0200
Message-Id: <20210906182438.5417-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DeInitSwLeds from hal_ops and remove its wrapper
rtw_hal_sw_led_deinit(). Call rtl8188eu_DeInitSwLeds() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c       | 6 ------
 drivers/staging/r8188eu/hal/usb_halinit.c    | 1 -
 drivers/staging/r8188eu/include/hal_intf.h   | 3 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 2 +-
 5 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 1848a7246d6d..3c4c719fe9bc 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -25,12 +25,6 @@ void rtw_hal_dm_deinit(struct adapter *adapt)
 		adapt->HalFunc.dm_deinit(adapt);
 }
 
-void rtw_hal_sw_led_deinit(struct adapter *adapt)
-{
-	if (adapt->HalFunc.DeInitSwLeds)
-		adapt->HalFunc.DeInitSwLeds(adapt);
-}
-
 u32 rtw_hal_power_on(struct adapter *adapt)
 {
 	if (adapt->HalFunc.hal_power_on)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 86080d502636..87aa12a6b5ba 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2246,7 +2246,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 
 	halfunc->init_recv_priv = &rtl8188eu_init_recv_priv;
 	halfunc->free_recv_priv = &rtl8188eu_free_recv_priv;
-	halfunc->DeInitSwLeds = &rtl8188eu_DeInitSwLeds;
 
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e240d5b2406f..a3da6e04d481 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -143,8 +143,6 @@ struct hal_ops {
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
 
-	void	(*DeInitSwLeds)(struct adapter *padapter);
-
 	void	(*dm_init)(struct adapter *padapter);
 	void	(*dm_deinit)(struct adapter *padapter);
 
@@ -255,7 +253,6 @@ void	rtw_hal_free_data(struct adapter *padapter);
 
 void rtw_hal_dm_init(struct adapter *padapter);
 void rtw_hal_dm_deinit(struct adapter *padapter);
-void rtw_hal_sw_led_deinit(struct adapter *padapter);
 
 u32 rtw_hal_power_on(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7c18b0adf740..c7229878ee53 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3862,7 +3862,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 		rtw_led_control(padapter, LED_CTL_POWER_OFF);
 		rereg_priv->old_bRegUseLed = padapter->ledpriv.bRegUseLed;
 		padapter->ledpriv.bRegUseLed = false;
-		rtw_hal_sw_led_deinit(padapter);
+		rtl8188eu_DeInitSwLeds(padapter);
 
 		/*  the interface is being "disabled", we can do deeper IPS */
 		rereg_priv->old_ips_mode = rtw_get_ips_mode_req(&padapter->pwrctrlpriv);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 7e0eaa3f7db6..43deffc29833 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -906,7 +906,7 @@ void rtw_cancel_all_timer(struct adapter *padapter)
 	_cancel_timer_ex(&padapter->mlmepriv.dynamic_chk_timer);
 
 	/*  cancel sw led timer */
-	rtw_hal_sw_led_deinit(padapter);
+	rtl8188eu_DeInitSwLeds(padapter);
 
 	_cancel_timer_ex(&padapter->pwrctrlpriv.pwr_state_check_timer);
 
-- 
2.33.0

