Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9E41CCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbhI2T3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346628AbhI2T2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:28:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77043C061764
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r18so12501536edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Qt6dTx72YoldApjhKg3YOFtDaF0Da0+BJSwSbRCXOQ=;
        b=pb8PBVIsZAAZ5yxwTSx3OoOLUcQm+MRkkXLss1YCy+PREwm7eaZpBof1LR8XzepeaW
         8BbQp3gcVmByKbSSIDDPMFfDd0Z2ihGnogd9qmpyqrSTF1CPsLglg8ZN3RPlftiy+530
         YCFNMQpmRw99Ybsp3RAw00l7NPSdjWRsfBG2aVRymPYkgvf/1NueJJBpGcgM60inEBd1
         cgpkbMXOvQrPaD5edvOFvkRycNSDjbTXLN+GSMEKRMkcbs2iQd5fdeY7/VE9sr+4Ea8d
         CZIILaUXdcwZTNkH4014QRN7RmYUxUlHNuQedbqWcGtSS9l7aE4fR6xdNPEmIeEDr1mc
         YNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Qt6dTx72YoldApjhKg3YOFtDaF0Da0+BJSwSbRCXOQ=;
        b=e5HO9TW1NfusYKyVfOdnTk68t6Zug5yn3mWgyRBdcKK/fVYLWLJ2EZ6BGgls53vQbQ
         Y2MfqiG3r6MbuYMQf0Ju9DePHC0z02/jelhxPnwKAIpZ8NJSWClkaoDXIr5o5MiDUgOW
         pQOMEwZk/sipMqEk6JqAEJnYJIzBjPNZmtJH4ceAW+RyALtVD6BKPA4dVrKmvHtiQAqy
         BJP6urf5+LYbEI+WEIoUPjjBbsorFdF1JTmhaSK367LmbOt9yXXEzAHK9fd50bWDjodZ
         KPi1Rryi8rsebh3qo7pDNF7xEaWc/sueFVb7ZF50iKIgCfe+c7IT0k0Up4XYFvkHAPsL
         AIbA==
X-Gm-Message-State: AOAM531ACs+rKjekVzcMHNLux9HVIorqkAvKTGVtRCxuytT9HymKBo92
        hVpBwOwggX1yUl6BHDENmcWqveoMgEk=
X-Google-Smtp-Source: ABdhPJwzKWxOgkTNM8eQTR/N73Jlx5hOiDOKKrIaz75S9w5vK5G9Oo5s3LctZvp+GZAdoRozgodIKw==
X-Received: by 2002:aa7:d7d5:: with SMTP id e21mr2091204eds.27.1632943632154;
        Wed, 29 Sep 2021 12:27:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::bfc8])
        by smtp.gmail.com with ESMTPSA id f10sm449019edu.70.2021.09.29.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:27:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: remove inirp_deinit from struct hal_ops
Date:   Wed, 29 Sep 2021 21:26:57 +0200
Message-Id: <20210929192657.9569-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929192657.9569-1-straube.linux@gmail.com>
References: <20210929192657.9569-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inirp_deinit from struct hal_ops and remove the wrappers
rtw_hal_inirp_deinit() and rtl8188eu_inirp_deinit(). Call
rtw_read_port_cancel() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 8 --------
 drivers/staging/r8188eu/hal/usb_halinit.c  | 9 ---------
 drivers/staging/r8188eu/include/hal_intf.h | 4 ----
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 2 +-
 4 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index ca7f0bcdb4d5..2e72848079e2 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -53,14 +53,6 @@ void rtw_hal_get_hwreg(struct adapter *adapt, u8 variable, u8 *val)
 		adapt->HalFunc.GetHwRegHandler(adapt, variable, val);
 }
 
-u32 rtw_hal_inirp_deinit(struct adapter *adapt)
-{
-	if (adapt->HalFunc.inirp_deinit)
-		return adapt->HalFunc.inirp_deinit(adapt);
-
-	return _FAIL;
-}
-
 void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 621158900918..83813388de24 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1024,13 +1024,6 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	return status;
 }
 
-static unsigned int rtl8188eu_inirp_deinit(struct adapter *Adapter)
-{
-	rtw_read_port_cancel(Adapter);
-
-	return _SUCCESS;
-}
-
 /*  */
 /*  */
 /*	EEPROM/EFUSE Content Parsing */
@@ -2150,8 +2143,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->hal_init = &rtl8188eu_hal_init;
 	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
 
-	halfunc->inirp_deinit = &rtl8188eu_inirp_deinit;
-
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 4eb9fb81f168..29ca90a86844 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -125,8 +125,6 @@ struct hal_ops {
 	u32	(*hal_init)(struct adapter *padapter);
 	u32	(*hal_deinit)(struct adapter *padapter);
 
-	u32	(*inirp_deinit)(struct adapter *padapter);
-
 	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
 				   u8 *val);
 	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
@@ -181,8 +179,6 @@ void rtw_hal_stop(struct adapter *padapter);
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
-u32	rtw_hal_inirp_deinit(struct adapter *padapter);
-
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index a36398774ee5..b5e0c6561108 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -186,7 +186,7 @@ static void usb_intf_start(struct adapter *padapter)
 static void usb_intf_stop(struct adapter *padapter)
 {
 	/* cancel in irp */
-	rtw_hal_inirp_deinit(padapter);
+	rtw_read_port_cancel(padapter);
 
 	/* cancel out irp */
 	rtw_write_port_cancel(padapter);
-- 
2.33.0

