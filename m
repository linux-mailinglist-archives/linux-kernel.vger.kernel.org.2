Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8041351218
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhDAJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhDAJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE16C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o19so1167891edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGhEGWInUsXSqDlvWslem4HSRe4n5xdbdM62/pWaaMk=;
        b=H+Kqiuuqol0efhKDxjK4kTMA4uIFcZK2Zl0ohDcNrODqu4NtRYs7ysW1SL1CNm2f1M
         K5DICut4Uot2tlU2r1bPSUCJ5Cg38zUu9xrnoNaAZ1QpZ0NrTx/61k3GVuviq7HEzw8+
         6pWBRKOCNVZMnNW5tJcCQkYiM/IZjw7CvS/YSqqH0vHLcf5sYmiEN8rtjnQ4yTUxm/pw
         0E7Ds2ZjAvTBYK4Rny3W0rfq9kU5VJ/R+ofCAZ5+5AVUJu21vp0HVXB3tZSyQIgztIKX
         gz6YOXMbrIZ40uWGGBNBORaERz9Fo/xrBgwAXwhqec/TzOtGh12/toKP3n2k2sEIMnY0
         pgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGhEGWInUsXSqDlvWslem4HSRe4n5xdbdM62/pWaaMk=;
        b=Zx3DJgBAETpGMMdUNmXTcnOWKkIgTLLgTCk+rU1GIkGULX3lsi1DBTS4jrUWszJsFa
         aT3FuvGN8BpNkAtVzPQab/501ieJ0o9GTrpqI0MAEGPGEMC827E1qJGpRsyHKjY/8f3E
         P3GPlL0pr3Ldi9QBGFFXWOxKqz9wYIc8HAQaLAp+v/Ur1kDQQw+18xcs3aJdePsoXqBR
         9EiU95hCYAB4mUvjZQ2o4ypi6dSoa1DYthblJE1vg/4E7PAyODE7ZDYBQw+AmiiVSKom
         nMAgT21pLKQwtidVaF6tbWQLhD/HYf5Bvg02onHXu0mgHajL7G8yzLAhj9CeSfnszmHW
         Hi2g==
X-Gm-Message-State: AOAM531rrEApncsViqVdPTr5KrLl+Ho2bV4nVKj4G16ZI6zozlsZ+kCC
        QWp9Pw1X+Gue084eSvQJlBg=
X-Google-Smtp-Source: ABdhPJzYRPU2b4eGy/5KPeI4yRj6f8sG/ku0vm9PZVQ3/uVzvEahhesSYOxACUyXucG2kEmxFkXSLA==
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr8637236edd.361.1617268942253;
        Thu, 01 Apr 2021 02:22:22 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id yk8sm2552378ejb.123.2021.04.01.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:21 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 36/49] staging: rtl8723bs: remove RT_TRACE logs in hal/sdio_halinit.c
Date:   Thu,  1 Apr 2021 11:21:06 +0200
Message-Id: <eeb98371a5a6feea56882218405723adbcde3209.1617268327.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 30 --------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index b1c4bbf29790..8bfe807d89f1 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -57,11 +57,6 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
 	/*  only cmd52 can be used before power on(card enable) */
 	ret = CardEnable(padapter);
 	if (!ret) {
-		RT_TRACE(
-			_module_hci_hal_init_c_,
-			_drv_emerg_,
-			("%s: run power on flow fail\n", __func__)
-		);
 		return _FAIL;
 	}
 
@@ -680,7 +675,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	ret = _InitPowerOn_8723BS(padapter);
 	if (_FAIL == ret) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init Power On!\n"));
 		return _FAIL;
 	}
 
@@ -688,12 +682,10 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	ret = rtl8723b_FirmwareDownload(padapter, false);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("%s: Download Firmware failed!!\n", __func__));
 		padapter->bFWReady = false;
 		pHalData->fw_ractrl = false;
 		return ret;
 	} else {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("rtl8723bs_hal_init(): Download Firmware Success!!\n"));
 		padapter->bFWReady = true;
 		pHalData->fw_ractrl = true;
 	}
@@ -719,7 +711,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_MAC_ENABLE == 1)
 	ret = PHY_MACConfig8723B(padapter);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure MAC!!\n"));
 		return ret;
 	}
 #endif
@@ -729,7 +720,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_BB_ENABLE == 1)
 	ret = PHY_BBConfig8723B(padapter);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure BB!!\n"));
 		return ret;
 	}
 #endif
@@ -741,7 +731,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_RF_ENABLE == 1)
 		ret = PHY_RFConfig8723B(padapter);
 		if (ret != _SUCCESS) {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure RF!!\n"));
 			return ret;
 		}
 #endif
@@ -893,8 +882,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	/*  Init BT hw config. */
 	hal_btcoex_InitHwConfig(padapter, false);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-%s\n", __func__));
-
 	return _SUCCESS;
 }
 
@@ -1030,10 +1017,6 @@ static u32 rtl8723bs_inirp_init(struct adapter *padapter)
 
 static u32 rtl8723bs_inirp_deinit(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+rtl8723bs_inirp_deinit\n"));
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-rtl8723bs_inirp_deinit\n"));
-
 	return _SUCCESS;
 }
 
@@ -1132,8 +1115,6 @@ static void Hal_EfuseParseMACAddr_8723BS(
 	}
 /* 	NicIFSetMacAddress(padapter, padapter->PermanentAddress); */
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
-		 ("Hal_EfuseParseMACAddr_8723BS: Permanent Address = %pM\n", pEEPROM->mac_addr));
 }
 
 static void Hal_EfuseParseBoardType_8723BS(
@@ -1148,7 +1129,6 @@ static void Hal_EfuseParseBoardType_8723BS(
 			pHalData->BoardType = (EEPROM_DEFAULT_BOARD_OPTION & 0xE0) >> 5;
 	} else
 		pHalData->BoardType = 0;
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Board Type: 0x%2x\n", pHalData->BoardType));
 }
 
 static void _ReadEfuseInfo8723BS(struct adapter *padapter)
@@ -1156,7 +1136,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u8 *hwinfo = NULL;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("====>_ReadEfuseInfo8723BS()\n"));
 
 	/*  */
 	/*  This part read and parse the eeprom/efuse content */
@@ -1192,7 +1171,6 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 
 	Hal_ReadRFGainOffset(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<==== _ReadEfuseInfo8723BS()\n"));
 }
 
 static void _ReadPROMContent(struct adapter *padapter)
@@ -1205,12 +1183,6 @@ static void _ReadPROMContent(struct adapter *padapter)
 	pEEPROM->EepromOrEfuse = (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	pEEPROM->bautoload_fail_flag = (eeValue & EEPROM_EN) ? false : true;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
-		 ("%s: 9346CR = 0x%02X, Boot from %s, Autoload %s\n",
-		  __func__, eeValue,
-		  (pEEPROM->EepromOrEfuse ? "EEPROM" : "EFUSE"),
-		  (pEEPROM->bautoload_fail_flag ? "Fail" : "OK")));
-
 /* 	pHalData->EEType = IS_BOOT_FROM_EEPROM(Adapter) ? EEPROM_93C46 : EEPROM_BOOT_EFUSE; */
 
 	_ReadEfuseInfo8723BS(padapter);
@@ -1233,8 +1205,6 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 	u8 val8;
 	unsigned long start;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+_ReadAdapterInfo8723BS\n"));
-
 	/*  before access eFuse, make sure card enable has been called */
 	if (!padapter->hw_init_completed)
 		_InitPowerOn_8723BS(padapter);
-- 
2.20.1

