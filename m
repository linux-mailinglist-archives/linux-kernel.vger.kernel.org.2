Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C933402023
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbhIFTEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbhIFTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:03:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71EC061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jg16so15154693ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXVzeoyjMV+agTPaWJLE9UNLbNfSwKQpfreP1FngznE=;
        b=PEbyDXY2DtAu1nRY+1avGz/GYGQX5M2JVO+FcYJWK8IRVANqx8mcL057KyrmjSisx6
         GRanIOyIkZ71sB7iiMyeLRv01nwGjcSOFib8vU/+7sFKXzpAlaD5GkhU49INzdW7gdm4
         9SfiFxLj8WsLPS4WeYLaeE6jiTyBjXANVxODHjJqwKRZ2s//T42SE2YlN665l91uqd5U
         iUe0f31uYTOwYVYVtiGAnJVOeTWwa+96nYDwC+guOoYMDVSVTts3vnld27e4s7B5X9+J
         LdEM/HWYPC3sAQU/UIjSL+D1Opmv5GuFcNeWiymd9+xY83/ERcLq4x7SoB48vOautdWQ
         l34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXVzeoyjMV+agTPaWJLE9UNLbNfSwKQpfreP1FngznE=;
        b=uK4WugIADvipyq74kYdMKNSB3XbajyHiSHC7gEWvIyj9rx+F783s7oXCF9d1wEpUDZ
         0OK/wF6h9DLJ3mCSVUtH9MODiE68fq1GbGCOGLt4V/AFiOqjG/CuiAls5kEziKXAzkPe
         mHsG26PZj7DJS+wBcDEdkxVFP4ozyT5qJnTF3cZmhqSbHXX7C0jruvwF/asRoZR1L4xr
         aJv1axMjyaIKJMYXD7tF1KS5HtU2R44pYtho/sNKVBEhwrPoz03eEhc+JYhDKE5v5Yu5
         k8JdKviiJlfacNHtd+uap2FQHihXGmdRq9cyWLKlKgp7wDCjxjJFGtX3uVWWdx+fYkNY
         YloQ==
X-Gm-Message-State: AOAM531C5ErilGMoUllY6wNMe38un+0MO7CO5OZt5u5rqdbrcA2FZq+k
        O4FQWHUmN8V81ymZFy7ALhk=
X-Google-Smtp-Source: ABdhPJwncC7uOzqacRMcQlwegc9inFgktIbIMRT37aocEkGsb4nZVUvRbkPX0sqsxvu0tNraiEdLow==
X-Received: by 2002:a17:906:700f:: with SMTP id n15mr15028338ejj.319.1630954969956;
        Mon, 06 Sep 2021 12:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 06/40] staging: r8188eu: remove empty functions
Date:   Mon,  6 Sep 2021 21:01:49 +0200
Message-Id: <20210906190223.11396-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following empty functions.

Hal_InitChannelPlan()
Hal_CustomizeByCustomerID_8188EU()
_InitBeaconMaxError()

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  4 ----
 drivers/staging/r8188eu/hal/usb_halinit.c       | 15 ---------------
 drivers/staging/r8188eu/include/rtl8188e_hal.h  |  1 -
 3 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index bed89a1234bd..ca020f2ed7a2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2242,10 +2242,6 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
 
-void Hal_InitChannelPlan(struct adapter *padapter)
-{
-}
-
 bool HalDetectPwrDownMode88E(struct adapter *Adapter)
 {
 	u8 tmpvalue = 0;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 87aa12a6b5ba..65f68f35b611 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -403,10 +403,6 @@ static void _InitEDCA(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
 }
 
-static void _InitBeaconMaxError(struct adapter *Adapter, bool		InfraMode)
-{
-}
-
 static void _InitHWLed(struct adapter *Adapter)
 {
 	struct led_priv *pledpriv = &Adapter->ledpriv;
@@ -819,7 +815,6 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	InitUsbAggregationSetting(Adapter);
 	_InitOperationMode(Adapter);/* todo */
 	_InitBeaconParameters(Adapter);
-	_InitBeaconMaxError(Adapter, true);
 
 	/*  */
 	/*  Init CR MACTXEN, MACRXEN after setting RxFF boundary REG_TRXFF_BNDY to patch */
@@ -1140,10 +1135,6 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 	}
 }
 
-static void Hal_CustomizeByCustomerID_8188EU(struct adapter *adapt)
-{
-}
-
 static void
 readAdapterInfo_8188EU(
 		struct adapter *adapt
@@ -1166,12 +1157,6 @@ readAdapterInfo_8188EU(
 	Hal_EfuseParseBoardType88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_ReadThermalMeter_88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 
-	/*  */
-	/*  The following part initialize some vars by PG info. */
-	/*  */
-	Hal_InitChannelPlan(adapt);
-	Hal_CustomizeByCustomerID_8188EU(adapt);
-
 	_ReadLEDSetting(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 }
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5cd441e8e16b..bb5620a9b17b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -434,7 +434,6 @@ void Hal_ReadPowerSavingMode88E(struct adapter *pAdapter, u8 *hwinfo,
 
 bool HalDetectPwrDownMode88E(struct adapter *Adapter);
 
-void Hal_InitChannelPlan(struct adapter *padapter);
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 
 void rtl8188e_read_chip_version(struct adapter *padapter);
-- 
2.33.0

