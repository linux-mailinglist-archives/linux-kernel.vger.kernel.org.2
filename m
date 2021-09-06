Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F81401FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbhIFSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244515AbhIFSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D47C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q3so10612836edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAvqQpKCWyLVtqR0Pixbdc0rZlX3SIjqbixAcUQtRok=;
        b=kbkMJgjhMaaqp6Idaht/L+LdRygcYhL0s0GUSOQTgZTwfbILrc7I1crJJAR9gLels4
         5dl7rKpmNrdkI8V42rsMWn6PDi1pizL5uBCD/VfkagPHBWKJBe/vXi49MNy0lJJwehVg
         7PHQiFTZx9PEKXGijF4p4IWBZ9+U9/Paw4HXlMGT2gU6dtdvTrQPEg1bMXDtrkQzfIBt
         jIQcok4nPyNZ55AnLDesZd7mdr5Q2DtE3RPscOOMyRNbu4M5hAWgzUrRnD8MrlultlA1
         LtPj3+Z/JwmKxWsbSITDe3Uyzob5731QUvVb04pPD8rRHtErrwMl25oHAzIOR59ycwte
         UD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAvqQpKCWyLVtqR0Pixbdc0rZlX3SIjqbixAcUQtRok=;
        b=rfyPNxF63Vx5Hs7O1cvR4sLIascrTyY3hsZBpV/AImzgO1TiO4b3L9YnQydDGnZaTp
         4MCmt/nQWCs6AQFkYu1OGIk7Xf0akuH0erCtVy2VtshiF2Pr0tyO83c2/CFptK70q1p0
         yOvuRqFt2cSmdJG1etc9z/Va+1rOJT3pEAvxScYOk2h42YLOuXEZ+HEt77nT0GSgRBHC
         XEwcaiCssLtL3GRQ6xVEo+qemzoHEZrvUsAHTbzJI4C2dYx6M4UYZxfqg+Jiox6XIfQu
         zBF4Cd/KDcoBksWVMfxH1hLTD9ybWcp0Z3X8Y/Ae9pA9vU1UTXwQ5mjJHYaXyGtBsPeA
         KDqQ==
X-Gm-Message-State: AOAM533z6QGA9CA04L1tI1WnUt0/MECX0sUm6uQzd3Fnu2oX6WBr5Gwk
        Kv5DhHvfV9MWjQ41J7x64NI=
X-Google-Smtp-Source: ABdhPJyMzPgr3T5KsSVgXkAZAbp+ZFcacb3BpGr1zXvlzjyxqqmaP8WP0u3V+vmEFKd0G0h8oCVRTg==
X-Received: by 2002:a05:6402:401:: with SMTP id q1mr4050017edv.154.1630954443167;
        Mon, 06 Sep 2021 11:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 01/40] staging: r8188eu: remove InitSwLeds from hal_ops
Date:   Mon,  6 Sep 2021 20:52:48 +0200
Message-Id: <20210906185327.10326-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove InitSwLeds from hal_ops and remove its wrapper
rtw_hal_sw_led_init(). Call rtl8188eu_InitSwLeds() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c       | 6 ------
 drivers/staging/r8188eu/hal/usb_halinit.c    | 1 -
 drivers/staging/r8188eu/include/hal_intf.h   | 2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 ++-
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 4 ++--
 5 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index e91db4f5886b..1848a7246d6d 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -25,12 +25,6 @@ void rtw_hal_dm_deinit(struct adapter *adapt)
 		adapt->HalFunc.dm_deinit(adapt);
 }
 
-void rtw_hal_sw_led_init(struct adapter *adapt)
-{
-	if (adapt->HalFunc.InitSwLeds)
-		adapt->HalFunc.InitSwLeds(adapt);
-}
-
 void rtw_hal_sw_led_deinit(struct adapter *adapt)
 {
 	if (adapt->HalFunc.DeInitSwLeds)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 679f9f6e6dbe..86080d502636 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2246,7 +2246,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 
 	halfunc->init_recv_priv = &rtl8188eu_init_recv_priv;
 	halfunc->free_recv_priv = &rtl8188eu_free_recv_priv;
-	halfunc->InitSwLeds = &rtl8188eu_InitSwLeds;
 	halfunc->DeInitSwLeds = &rtl8188eu_DeInitSwLeds;
 
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 16d59d24d1b8..e240d5b2406f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -143,7 +143,6 @@ struct hal_ops {
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
 
-	void	(*InitSwLeds)(struct adapter *padapter);
 	void	(*DeInitSwLeds)(struct adapter *padapter);
 
 	void	(*dm_init)(struct adapter *padapter);
@@ -256,7 +255,6 @@ void	rtw_hal_free_data(struct adapter *padapter);
 
 void rtw_hal_dm_init(struct adapter *padapter);
 void rtw_hal_dm_deinit(struct adapter *padapter);
-void rtw_hal_sw_led_init(struct adapter *padapter);
 void rtw_hal_sw_led_deinit(struct adapter *padapter);
 
 u32 rtw_hal_power_on(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index bd637a667299..7c18b0adf740 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -15,6 +15,7 @@
 #include "../include/rtw_mp_ioctl.h"
 #include "../include/usb_ops.h"
 #include "../include/rtl8188e_hal.h"
+#include "../include/rtl8188e_led.h"
 
 #include "../include/rtw_mp.h"
 #include "../include/rtw_iol.h"
@@ -3845,7 +3846,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 
 	if (!memcmp(rereg_priv->old_ifname, "disable%d", 9)) {
 		padapter->ledpriv.bRegUseLed = rereg_priv->old_bRegUseLed;
-		rtw_hal_sw_led_init(padapter);
+		rtl8188eu_InitSwLeds(padapter);
 		rtw_ips_mode_req(&padapter->pwrctrlpriv, rereg_priv->old_ips_mode);
 	}
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 49ccdde1b0bb..7e0eaa3f7db6 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -9,9 +9,9 @@
 #include "../include/recv_osdep.h"
 #include "../include/hal_intf.h"
 #include "../include/rtw_ioctl.h"
-
 #include "../include/usb_osintf.h"
 #include "../include/rtw_br_ext.h"
+#include "../include/rtl8188e_led.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
@@ -887,7 +887,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	ret8 = rtw_init_default_value(padapter);
 
 	rtw_hal_dm_init(padapter);
-	rtw_hal_sw_led_init(padapter);
+	rtl8188eu_InitSwLeds(padapter);
 
 	rtw_hal_sreset_init(padapter);
 
-- 
2.33.0

