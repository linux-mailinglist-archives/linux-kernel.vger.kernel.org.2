Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2D400B5F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhIDMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhIDMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953BC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso1376390wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFOg8bqZyRLA4mRQrxSLmG6Io/0U0jui7FnvueE0nGg=;
        b=atn2Km+ysspAX3kg8P23bi4eQJ+Bi0fvQ8zdDv4dzmsD8pDEHahEilNjg+lJHTOLTB
         VG9oK8DVzSE8E2KuKxamaAtnssD8W1FDilTt21wEGy+f4mDual4tJpEMtVOuIaSCIvWI
         N7Ipu/CbFe3RrsYitz3lQa3f6mNhTzndyELVwnvpUlhDfQTriQ3O2HabWxqGrERyJyW2
         2J034zi8n27zpIU9QbeecZfyRfuEOTA9H0FPMdtIamgt85SwITKnvVwTzdORChQnipju
         PUcqw4Jnjnkv3XNnfKvyaeozjcwX2ZTvtu8IJD4uFQ3Q9VMZxJYI2Olq2fv4f53mP6wY
         93Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFOg8bqZyRLA4mRQrxSLmG6Io/0U0jui7FnvueE0nGg=;
        b=ll3Sc629z4DxanGgAOnBsD3V6vdyopnhNtxAkZ1dzLtt4stXOG62AH3ylLSXHzZjCk
         5+v+wo8ShYwXZ6CxMrDe3n3VbRgBWeX363AKjAMAYZo7rsQbnCWdKI1C8iPs4w/vxq1D
         ZV7fxx1JwNBytRdZkWqYNexIeZd+n2yhdZQv4PBMjAiG/mvm0khVb2b7mZfDeo3dvk9u
         861SXjzqOGEO1y5jdj0g4CTSyTyjfcHq3ngkM4kKJFGlSXrJSyU7fexhTVomi1n/UNaU
         /XbnWjpic+qfa2uRGTpZr6QYRDzCTFTYyp6DPmTnavkGkiQRpo8k/JiwcIUbuwbudCQa
         OTCg==
X-Gm-Message-State: AOAM533tiLy5feDwkn0ALm5RuNdsy0NKc5lHeY7iSy6NSl6fGO1FV8P/
        fVPexnGZ7GxsSMeoyefJ5sE=
X-Google-Smtp-Source: ABdhPJysSfhayVZobpyRzLRCPp2GZkBDh/8tCFBhc5VJOwtqWBeTlDI5Hxl0bCwn5VKsk106zWhmHg==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr3204791wms.138.1630759252945;
        Sat, 04 Sep 2021 05:40:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: remove read_adapter_info from hal_ops
Date:   Sat,  4 Sep 2021 14:40:29 +0200
Message-Id: <20210904124033.14244-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904124033.14244-1-straube.linux@gmail.com>
References: <20210904124033.14244-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove read_adapter_info from hal_ops and remove its wrapper
rtw_hal_read_chip_info(). Call ReadAdapterInfo8188EU() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 6 ------
 drivers/staging/r8188eu/hal/usb_halinit.c  | 3 +--
 drivers/staging/r8188eu/include/hal_intf.h | 4 +---
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index f52c77279f3d..f58dd3da6c13 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -6,12 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/hal_intf.h"
 
-void rtw_hal_read_chip_info(struct adapter *adapt)
-{
-	if (adapt->HalFunc.read_adapter_info)
-		adapt->HalFunc.read_adapter_info(adapt);
-}
-
 void rtw_hal_read_chip_version(struct adapter *adapt)
 {
 	if (adapt->HalFunc.read_chip_version)
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index df1887bf29eb..d34d26de69d9 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1215,7 +1215,7 @@ static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
 	return _SUCCESS;
 }
 
-static void ReadAdapterInfo8188EU(struct adapter *Adapter)
+void ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	/*  Read EEPROM size before call any EEPROM function */
 	Adapter->EepromAddressSize = GetEEPROMSize8188E(Adapter);
@@ -2250,7 +2250,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->DeInitSwLeds = &rtl8188eu_DeInitSwLeds;
 
 	halfunc->init_default_value = &rtl8188eu_init_default_value;
-	halfunc->read_adapter_info = &ReadAdapterInfo8188EU;
 
 	halfunc->SetHwRegHandler = &SetHwReg8188EU;
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 6740a6570e6a..9845b6f7378e 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -152,8 +152,6 @@ struct hal_ops {
 
 	void	(*init_default_value)(struct adapter *padapter);
 
-	void	(*read_adapter_info)(struct adapter *padapter);
-
 	void	(*enable_interrupt)(struct adapter *padapter);
 	void	(*disable_interrupt)(struct adapter *padapter);
 	s32	(*interrupt_handler)(struct adapter *padapter);
@@ -267,6 +265,7 @@ struct hal_ops {
 void rtl8188eu_set_hal_ops(struct adapter *padapter);
 
 void rtl8188eu_interface_configure(struct adapter *adapt);
+void ReadAdapterInfo8188EU(struct adapter *Adapter);
 
 void rtw_hal_def_value_init(struct adapter *padapter);
 
@@ -284,7 +283,6 @@ void rtw_hal_stop(struct adapter *padapter);
 void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
 
-void rtw_hal_read_chip_info(struct adapter *padapter);
 void rtw_hal_read_chip_version(struct adapter *padapter);
 
 u8 rtw_hal_set_def_var(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index d4765205ae26..bf7ef56d12e3 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -605,7 +605,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtl8188eu_interface_configure(padapter);
 
 	/* step read efuse/eeprom data and get mac_addr */
-	rtw_hal_read_chip_info(padapter);
+	ReadAdapterInfo8188EU(padapter);
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL)
-- 
2.33.0

