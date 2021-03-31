Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2978734FD42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhCaJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhCaJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8BC061762
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so29035961ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZHM2fQ+XP83xRvSoPmXP9hdiyeGBnyjPvpRa+V51vc=;
        b=dBvx4l+naelPka6TKeoF17adQIs1I3XZXhythfL2Ik1J4Yt21wYzxjlqjPm+rdyZ+b
         uFvKdJQjV4oc6lyW03idy770ecVeTKvrkV3dUe2q8jBB8MVpLD6utjo2hnPxGDVTrKnn
         vE/2uv4+KKwCQankt/QDDOYgjFt3vf9zuhB7CmoalDvWJpPvnew5HumcN/V2GNkrdB0+
         BWxexXvZ9dKnE/adOyYJjGMV0wFXoAGWVBDvnp070uU0kywWd5qknIo3dfxfALEm6jXi
         5ZFqgivjMx9PqFZr/3OhzsWHe54O5M9VsgXj4t3w5jO165QI0DZePqhxNgweAILbDA7I
         O1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZHM2fQ+XP83xRvSoPmXP9hdiyeGBnyjPvpRa+V51vc=;
        b=Kb/AmsMD6Whx/CxAQxjZGt9LH7veuQ+ESiPzZB0lbGIOBhn+SjIwqhkI1nUhFRcacl
         x27Ahc3ZMAbacQFRXufyTFNxQms2xU67mo1Sk+PZZyLKcquypFLgSrlL96axt4VQlJvU
         2BTHVzWJZ79VtJwMWLiL2sL/RDNOw48ULN6J36RPIDIL/acUv1hHps3IYCy1MuSom2Ig
         QS6PhYqoCo0Gub83AzfD1GHBqy7uS8DUIlti3BIMNlkIHJbxmIa+itbmYn5gFrfmfXV0
         tLrw0oFJ9ZXjIe+uj3arTzOZ7U85E/OjJ+KpbXlWHVDjmGUxUBjmz8lZ1ZI6nYoy791N
         j+7A==
X-Gm-Message-State: AOAM530XNhxb6D62YsXcBadO3euCeWeT1d4fCaJD6TZS1vpXUlN5yKdh
        0cALoYd8vZGgXAWnj5qzQyA=
X-Google-Smtp-Source: ABdhPJyknMqdhFFkT3M2uu6YOImrJf/P14CidZ+yNdi6zw7Jp0udkaO8adOfnzz6gB4bQ90hJ9FPCg==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr2628073ejb.48.1617183661472;
        Wed, 31 Mar 2021 02:41:01 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id p19sm1153664edr.57.2021.03.31.02.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 26/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/sdio_halinit.c
Date:   Wed, 31 Mar 2021 11:39:54 +0200
Message-Id: <d7f85f911d162d5f982ffd7dbb791e5dde7f58cd.1617183374.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 49 ++++++++++----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index b1c4bbf29790..281713b4d5c9 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -57,11 +57,7 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
 	/*  only cmd52 can be used before power on(card enable) */
 	ret = CardEnable(padapter);
 	if (!ret) {
-		RT_TRACE(
-			_module_hci_hal_init_c_,
-			_drv_emerg_,
-			("%s: run power on flow fail\n", __func__)
-		);
+		pr_emerg("%s %s: run power on flow fail\n", DRIVER_PREFIX, __func__);
 		return _FAIL;
 	}
 
@@ -680,7 +676,7 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	ret = _InitPowerOn_8723BS(padapter);
 	if (_FAIL == ret) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init Power On!\n"));
+		pr_err("%s Failed to init Power On!\n", DRIVER_PREFIX);
 		return _FAIL;
 	}
 
@@ -688,12 +684,13 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	ret = rtl8723b_FirmwareDownload(padapter, false);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("%s: Download Firmware failed!!\n", __func__));
+		pr_err("%s %s: Download Firmware failed!!\n", DRIVER_PREFIX, __func__);
 		padapter->bFWReady = false;
 		pHalData->fw_ractrl = false;
 		return ret;
 	} else {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("rtl8723bs_hal_init(): Download Firmware Success!!\n"));
+		pr_notice("%s %s: Download Firmware Success!!\n",
+			  DRIVER_PREFIX, __func__);
 		padapter->bFWReady = true;
 		pHalData->fw_ractrl = true;
 	}
@@ -719,7 +716,8 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_MAC_ENABLE == 1)
 	ret = PHY_MACConfig8723B(padapter);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure MAC!!\n"));
+		pr_info("%s Initializepadapter8192CSdio(): Fail to configure MAC!!\n",
+			DRIVER_PREFIX);
 		return ret;
 	}
 #endif
@@ -729,7 +727,8 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_BB_ENABLE == 1)
 	ret = PHY_BBConfig8723B(padapter);
 	if (ret != _SUCCESS) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure BB!!\n"));
+		pr_info("%s Initializepadapter8192CSdio(): Fail to configure BB!!\n",
+			DRIVER_PREFIX);
 		return ret;
 	}
 #endif
@@ -741,7 +740,8 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 #if (HAL_RF_ENABLE == 1)
 		ret = PHY_RFConfig8723B(padapter);
 		if (ret != _SUCCESS) {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializepadapter8192CSdio(): Fail to configure RF!!\n"));
+			pr_info("%s Initializepadapter8192CSdio(): Fail to configure RF!!\n",
+				DRIVER_PREFIX);
 			return ret;
 		}
 #endif
@@ -893,7 +893,7 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	/*  Init BT hw config. */
 	hal_btcoex_InitHwConfig(padapter, false);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-%s\n", __func__));
+	pr_info("%s-%s\n", DRIVER_PREFIX, __func__);
 
 	return _SUCCESS;
 }
@@ -1030,9 +1030,9 @@ static u32 rtl8723bs_inirp_init(struct adapter *padapter)
 
 static u32 rtl8723bs_inirp_deinit(struct adapter *padapter)
 {
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+rtl8723bs_inirp_deinit\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("-rtl8723bs_inirp_deinit\n"));
+	pr_info("%s-%s\n", DRIVER_PREFIX, __func__);
 
 	return _SUCCESS;
 }
@@ -1132,8 +1132,8 @@ static void Hal_EfuseParseMACAddr_8723BS(
 	}
 /* 	NicIFSetMacAddress(padapter, padapter->PermanentAddress); */
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
-		 ("Hal_EfuseParseMACAddr_8723BS: Permanent Address = %pM\n", pEEPROM->mac_addr));
+	pr_notice("%s %s: Permanent Address = %pM\n", DRIVER_PREFIX, __func__,
+		  pEEPROM->mac_addr);
 }
 
 static void Hal_EfuseParseBoardType_8723BS(
@@ -1148,7 +1148,7 @@ static void Hal_EfuseParseBoardType_8723BS(
 			pHalData->BoardType = (EEPROM_DEFAULT_BOARD_OPTION & 0xE0) >> 5;
 	} else
 		pHalData->BoardType = 0;
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Board Type: 0x%2x\n", pHalData->BoardType));
+	pr_info("%s Board Type: 0x%2x\n", DRIVER_PREFIX, pHalData->BoardType);
 }
 
 static void _ReadEfuseInfo8723BS(struct adapter *padapter)
@@ -1156,7 +1156,7 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u8 *hwinfo = NULL;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("====>_ReadEfuseInfo8723BS()\n"));
+	pr_info("%s ====> %s\n", DRIVER_PREFIX, __func__);
 
 	/*  */
 	/*  This part read and parse the eeprom/efuse content */
@@ -1192,7 +1192,7 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 
 	Hal_ReadRFGainOffset(padapter, hwinfo, pEEPROM->bautoload_fail_flag);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<==== _ReadEfuseInfo8723BS()\n"));
+	pr_info("%s <==== %s\n", DRIVER_PREFIX, __func__);
 }
 
 static void _ReadPROMContent(struct adapter *padapter)
@@ -1205,11 +1205,10 @@ static void _ReadPROMContent(struct adapter *padapter)
 	pEEPROM->EepromOrEfuse = (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	pEEPROM->bautoload_fail_flag = (eeValue & EEPROM_EN) ? false : true;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
-		 ("%s: 9346CR = 0x%02X, Boot from %s, Autoload %s\n",
-		  __func__, eeValue,
-		  (pEEPROM->EepromOrEfuse ? "EEPROM" : "EFUSE"),
-		  (pEEPROM->bautoload_fail_flag ? "Fail" : "OK")));
+	pr_info("%s %s: 9346CR = 0x%02X, Boot from %s, Autoload %s\n",
+		DRIVER_PREFIX, __func__, eeValue,
+		(pEEPROM->EepromOrEfuse ? "EEPROM" : "EFUSE"),
+		(pEEPROM->bautoload_fail_flag ? "Fail" : "OK"));
 
 /* 	pHalData->EEType = IS_BOOT_FROM_EEPROM(Adapter) ? EEPROM_93C46 : EEPROM_BOOT_EFUSE; */
 
@@ -1233,7 +1232,7 @@ static s32 _ReadAdapterInfo8723BS(struct adapter *padapter)
 	u8 val8;
 	unsigned long start;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("+_ReadAdapterInfo8723BS\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	/*  before access eFuse, make sure card enable has been called */
 	if (!padapter->hw_init_completed)
-- 
2.20.1

