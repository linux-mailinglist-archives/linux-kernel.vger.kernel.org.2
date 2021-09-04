Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2FB400B63
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhIDMmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbhIDMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC4EC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so1392843wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHjSk62j+qI4w6bSE0d8VL7TUL5bahpwJrBiVcsBvxc=;
        b=k+pRs3/jpxoYPdAxFh6OvtDgIYLAhVfH6sPgm1OgXu55cGcNOAD0PKPq81MlqlXRYC
         4KoDJx0Zq3TSinh5mc5XMqZUP+6LPG6NruK+kksGkyScjvd21Kn5sLH93Mkxc3dL7Uoj
         ttWUUFTUbW0zF9Fjbv55C7h1GzT9z364D5tduCkdUkXbpidUdpgDE6Uh8JTFewjATAP2
         FAdrng7BtXOPJhwJlkEGnCADQ0hKy1RT33y1X2vY83nfUznoM3pk18JS0qTZS6QwMtTy
         VcFAS/3+y2hcR0PnyYlNHqoHlAfGCNr86sQDeejR0qzzgFsuowRzEm3Og8UBaOqycZw0
         LRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHjSk62j+qI4w6bSE0d8VL7TUL5bahpwJrBiVcsBvxc=;
        b=ZgIqmsaN6fzweoc2EZCvYyLXeQjVfGvdrTfjmzslVOC6Wo/O7KkSfHTGMiAj25O3ry
         4VO9tXjb5Unm56hGkCDgLaLM597DTkoiW7QN8k0u+MSlg+O2YelRJ1el0pcZUIcWO2LM
         YY6hfpRPb1d7YJVzxOzyrFOTXhzysIq0L/O24qB6B1InnJ5+asu7i8DgruiqmSlUrBBC
         GopAENWlUpADcRhoNTC81uZWvjtjsNF96W10duZSOHj6D81pyfqJdUzSpsecGLoA/h1j
         iR3JLp7IeYQM4IcnbkFDs2g87kohEID+Ps29aLDi9S/GIUMHT5xcPcUtFnNcM64YoZni
         dFDw==
X-Gm-Message-State: AOAM533LEIpKo+ovC9ZGK0tbWC2cnSpyJzWVsi1fGzLkCwXWuMuMmnK4
        lxtLbj6tTA7/a08HIFZhYBY=
X-Google-Smtp-Source: ABdhPJyGX6K2pxuTTFVqEoai7onLpprgo/IhwVmFo1QWBprCQrpY1umJhdcE+gpfrSS/qaQKB/+30g==
X-Received: by 2002:a1c:3103:: with SMTP id x3mr3087096wmx.190.1630759256129;
        Sat, 04 Sep 2021 05:40:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: remove init_default_value from hal_ops
Date:   Sat,  4 Sep 2021 14:40:33 +0200
Message-Id: <20210904124033.14244-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904124033.14244-1-straube.linux@gmail.com>
References: <20210904124033.14244-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove init_default_value from hal_ops and remove its wrapper
rtw_hal_def_value_init(). Call rtl8188eu_init_default_value()
directly instead

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 6 ------
 drivers/staging/r8188eu/hal/usb_halinit.c  | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h | 5 +----
 drivers/staging/r8188eu/os_dep/os_intfs.c  | 4 ++--
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 9069b52f83ff..c06b299cf266 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -6,12 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/hal_intf.h"
 
-void rtw_hal_def_value_init(struct adapter *adapt)
-{
-	if (adapt->HalFunc.init_default_value)
-		adapt->HalFunc.init_default_value(adapt);
-}
-
 void rtw_hal_free_data(struct adapter *adapt)
 {
 	if (adapt->HalFunc.free_hal_data)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d34d26de69d9..679f9f6e6dbe 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2196,7 +2196,7 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 	rtw_write8(adapt, bcn_ctrl_reg, rtw_read8(adapt, bcn_ctrl_reg) | BIT(1));
 }
 
-static void rtl8188eu_init_default_value(struct adapter *adapt)
+void rtl8188eu_init_default_value(struct adapter *adapt)
 {
 	struct hal_data_8188e *haldata;
 	struct pwrctrl_priv *pwrctrlpriv;
@@ -2249,8 +2249,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->InitSwLeds = &rtl8188eu_InitSwLeds;
 	halfunc->DeInitSwLeds = &rtl8188eu_DeInitSwLeds;
 
-	halfunc->init_default_value = &rtl8188eu_init_default_value;
-
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
 	halfunc->GetHalDefVarHandler = &GetHalDefVar8188EUsb;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index d5cf9b0d9a77..b3ea9fc041c6 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -149,8 +149,6 @@ struct hal_ops {
 	void	(*dm_init)(struct adapter *padapter);
 	void	(*dm_deinit)(struct adapter *padapter);
 
-	void	(*init_default_value)(struct adapter *padapter);
-
 	void	(*enable_interrupt)(struct adapter *padapter);
 	void	(*disable_interrupt)(struct adapter *padapter);
 	s32	(*interrupt_handler)(struct adapter *padapter);
@@ -262,8 +260,7 @@ void rtl8188eu_set_hal_ops(struct adapter *padapter);
 
 void rtl8188eu_interface_configure(struct adapter *adapt);
 void ReadAdapterInfo8188EU(struct adapter *Adapter);
-
-void rtw_hal_def_value_init(struct adapter *padapter);
+void rtl8188eu_init_default_value(struct adapter *adapt);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index c3ac0ae153f8..49ccdde1b0bb 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -782,7 +782,7 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 	rtw_update_registrypriv_dev_network(padapter);
 
 	/* hal_priv */
-	rtw_hal_def_value_init(padapter);
+	rtl8188eu_init_default_value(padapter);
 
 	/* misc. */
 	padapter->bReadPortCancel = false;
@@ -801,7 +801,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
 
 	/* hal_priv */
-	rtw_hal_def_value_init(padapter);
+	rtl8188eu_init_default_value(padapter);
 	padapter->bReadPortCancel = false;
 	padapter->bWritePortCancel = false;
 	padapter->bRxRSSIDisplay = 0;
-- 
2.33.0

