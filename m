Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A9401F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbhIFS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbhIFS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51EEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bt14so14997092ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXVzeoyjMV+agTPaWJLE9UNLbNfSwKQpfreP1FngznE=;
        b=iLVUmjwbuS8oAZZ7VbzwuKStVt8xXSgXQEdDVbOuasR34srTMPeQWQQScxCuOZys+M
         1rijm9/utaRLBMzHvIjTA91c0mycKSghFWdhBxgg9Ik9LIUNBRR1t5i1SRj91AjYATSL
         S+a++XgRoEXfN8yOE4X3rkqC9T3rGjNr+0uwuVz0Vt3/kBuR/brP8OM2E5ivEwEXJQBE
         dOi6H9hP9iQv5DuRKgIak3gzBCnrjYTtB3snyFsTYNJqdE8ThwIU4Z17I/3Zgk3kn6DP
         pUH5MyXbwmpxc9EXYFafl5OafTk4pEGAjPbbEeK6bDXbzs6z2gdGDKh0DAxoto02fTye
         0m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXVzeoyjMV+agTPaWJLE9UNLbNfSwKQpfreP1FngznE=;
        b=T6hNICiQMd5zhN1vy7GQ3xg/d4WrJ7Upye75+e+1i1kn4WfvEQoz3KjpfrWr2+Wt6F
         +jwHq1mHXZ32dYuC+a1YjBkLm0RKH2dsEXcsDXn3nrJsEm6fbTdIGArDGW1qMQham6S6
         F9rySP6BrXNWe3m91KUPTgWi3NZDXBdPnkSWtpn5SkrcKHcLktZ1m0laq5OoO3M1ec4b
         IspNTMNtQQxIAPebWtxjpAUzwg/iH0mkqek3IC6nMsPR2xMK8QMBUnh9OboKM2wFt/+f
         95BDi94K9PCWy/Cch9/3siQQFLmSbZuXtzFohYmGCxgx9hGGHrxrzJvguAoMJ09CK8BO
         9x5A==
X-Gm-Message-State: AOAM530TNcsYQlNHPmr9WnhRaZipBtqkoH9Tn6VINoc/fB8MN6/eGevs
        TbVKWQC+lZvaHJEL33SX9Q4=
X-Google-Smtp-Source: ABdhPJwXQqOcvfXSz8smRmHNfjJ9DuZNhgMqwD1kBXRqSRhyRIUyd+kDoV+IMmJtHY1bCw2S/aDAVg==
X-Received: by 2002:a17:906:26c4:: with SMTP id u4mr14526413ejc.511.1630952705973;
        Mon, 06 Sep 2021 11:25:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/40] staging: r8188eu: remove empty functions
Date:   Mon,  6 Sep 2021 20:24:04 +0200
Message-Id: <20210906182438.5417-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
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

