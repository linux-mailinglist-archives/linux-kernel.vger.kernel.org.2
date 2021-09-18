Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7492F4105D4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhIRJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbhIRJ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:59:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61461C061757
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso11760684wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzHnNkAh1DHRmaLR4iPYetckB/XzF4D+KKJY3oJx0yk=;
        b=CzQQhAEVoUKzXELc1NOL6Swp4HnNMU92pZSechY8fZvJlPhPqohDKeo/1gQig7eQAP
         GCUoAt425TDqys33IzcIVerqrt6b1sZCBLFaySfx85vrRjsUi2lbSX8kX8IQkPQx8QNE
         CHY+3e3SdC17KmBfbRD24RCJVZYL8TZkovz6U/ue7ByTiv41i6CO8UETcradqqTnv02F
         D+TxfUqKU9/TG/nTDI5m8NJuy1EMfRBq+p6R0b9Opu0+OLUYb0YOtgrI+hFteJooSdj2
         jCVJtwjXTXVW8xoiH9WXNhdLqykUDClzABGlHGZLz7mD+vLN3jCDZoxiLpE3hGMutzzJ
         Mk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzHnNkAh1DHRmaLR4iPYetckB/XzF4D+KKJY3oJx0yk=;
        b=5rIxTSIeWxzKzsvv2O1GWslI+WVQiq9YyyX4vTFvyHYN8/SIx1kCwyq/REQ8zQeY8e
         Gz9/NypcIASBBEaMWfUI81STbEASQG/v9oRzMUTmXotu7SM4H8NPuX2awFHI0ISBbOj2
         w1B8qQdKADVqt67ubdHkPWId4dhSZgs8H3QyyUVg/4lVafM3jgBajVbM9JaMOqoUj3k9
         qeQ+aq4N9NF33BTPQYrq1tJIbEo6SKqY4IfcjDDPLYVKIY4oJ/7frJx781BBEtX7CKY4
         MDnfDm8cqQ0B3NzeSEU2VqLmtQ+LDJcI4qIV+5T/tRF8x8Wb40twaC8NHJuYrJyoCb2T
         K1Ug==
X-Gm-Message-State: AOAM532nSK7B2qUwKWeoo0J0jpQgH73MwhPxLOhzqmYnz+4dJu0y+muJ
        zsGH4SmeKsB9Px4kZp0pUak=
X-Google-Smtp-Source: ABdhPJwcdzBdyo6ce5Nixl2yUU0CSnvXsH9Rap/wg0J1H3/KLAKhDNdOL0wjpPyD6QTVQSyc5mRwRg==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196mr14199664wmd.9.1631959080062;
        Sat, 18 Sep 2021 02:58:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id o26sm13013287wmc.17.2021.09.18.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:57:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: r8188eu: remove HalDetectPwrDownMode88E()
Date:   Sat, 18 Sep 2021 11:57:24 +0200
Message-Id: <20210918095727.13591-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918095727.13591-1-straube.linux@gmail.com>
References: <20210918095727.13591-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function HalDetectPwrDownMode88E() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 19 -------------------
 .../staging/r8188eu/include/rtl8188e_hal.h    |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 179dc209a68f..b271b2e54d0f 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2154,22 +2154,3 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 	}
 	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
 }
-
-bool HalDetectPwrDownMode88E(struct adapter *Adapter)
-{
-	u8 tmpvalue = 0;
-	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
-	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
-
-	EFUSE_ShadowRead(Adapter, 1, EEPROM_RF_FEATURE_OPTION_88E, (u32 *)&tmpvalue);
-
-	/*  2010/08/25 MH INF priority > PDN Efuse value. */
-	if (tmpvalue & BIT(4) && pwrctrlpriv->reg_pdnmode)
-		pHalData->pwrdown = true;
-	else
-		pHalData->pwrdown = false;
-
-	DBG_88E("HalDetectPwrDownMode(): PDN =%d\n", pHalData->pwrdown);
-
-	return pHalData->pwrdown;
-}	/*  HalDetectPwrDownMode */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 94d5992cca19..24f21b1ed396 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -407,8 +407,6 @@ void Hal_EfuseParseBoardType88E(struct adapter *pAdapter, u8 *hwinfo,
 void Hal_ReadPowerSavingMode88E(struct adapter *pAdapter, u8 *hwinfo,
 				bool AutoLoadFail);
 
-bool HalDetectPwrDownMode88E(struct adapter *Adapter);
-
 void rtl8188e_read_chip_version(struct adapter *padapter);
 
 void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
-- 
2.33.0

