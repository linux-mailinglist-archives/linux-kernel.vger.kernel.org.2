Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0133046069A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357762AbhK1N7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346584AbhK1N5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:57:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94CC06175E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y196so12393617wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Ytho17AJ4uMgaRdXauPbFbIjw+Tbhbf5MABHEUnEio=;
        b=m5m6m9aTEF8hm1j3DjpZ2KSzdLxMn/99YWNmqeEWE5FzSa+IpKtuDscGkb+3X96mYp
         CRGmiwUPzgVbL8PM+aG62bpzH4dUiND7NpDKh6uZsWum4m5CrH4MK8MEw+7dam5b9Flt
         GETSRwnDyCOzv5Q7rkrTEspijeG2IjoiB32NHS+M5Ew1P2SAdCWfOPiXy0Bkr+imb3nO
         xBXEyLnA+2ZXe8DfMbwTbwjl5kyeAiIop+7S0D3QocfTzEbiY4kQ17MhCA/0lmvYlA4J
         z95BD9M+KJlNx0EdgGukV8y5BNJtmyCbnz0dsonDTV1fX+23WTlwB+Ks2H4dRWLdlzty
         ZgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ytho17AJ4uMgaRdXauPbFbIjw+Tbhbf5MABHEUnEio=;
        b=PMn+pLJT/cl093g7xevqBPt3+VgVrJ4xyz+kAbO5aYCqCKMsqT3DNgXZArwQmDpJfX
         DblG4wGq/oobvthjP+2o9JLo6PB89qxfTrhmrZo+/FyJW/Ms3oSMzR5jEZZYvF93jziy
         RP53Xh5vKNiWNqkp32eMnm3JEr6ISTp7Aoy5LHaRvNyXCmD3rpiMon4QRuYU1l7J3mS7
         lMsJTIWEijySI9nfpEmAyzIJ9Sggwu3q/W5q+ppeehM06yCpsi5c+enNBtAywyixrZCr
         1Niar22ap8xDfBn0DRIKSUsCVpOE5EhTeoNJREh/xZam56UZkUoDXd41qcavSYObQarg
         T39Q==
X-Gm-Message-State: AOAM532jI4It+UZup+g2SRjGDMWoeQ1T9pRVWOx7DSK5PWWTsTWciTRP
        Nu25wPhiTcuO2n+i2keNBE1Dz6u5W+g=
X-Google-Smtp-Source: ABdhPJy9nGdoa7qsmYmw0p8rzv2x8gPcPwN6QSCE0I29r4o5s2bmZ8bZOn7izhnXmgEJBZtqojShLw==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr29043128wmj.149.1638107619101;
        Sun, 28 Nov 2021 05:53:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id l26sm13598510wms.15.2021.11.28.05.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:53:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove rf_type from struct hal_data_8188e
Date:   Sun, 28 Nov 2021 14:53:25 +0100
Message-Id: <20211128135326.9838-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128135326.9838-1-straube.linux@gmail.com>
References: <20211128135326.9838-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field rf_type of struct hal_data_8188e is set to RF_1T1R and
never changed. Also it is used only in a call to netdev_dbg() which
is not very useful since RTL8188EU chips are always 1T1R. Remove
the netdev_dbg() and remove rf_type from the hal_data_8188e
structure.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 ----
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 001e4a198630..eeb5f46687e2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -854,10 +854,6 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	dump_chip_info(ChipVersion);
 
 	pHalData->VersionID = ChipVersion;
-
-	pHalData->rf_type = RF_1T1R;
-
-	netdev_dbg(padapter->pnetdev, "RF_Type is %x!!\n", pHalData->rf_type);
 }
 
 void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5848f1d4191a..be8af7497f4b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -168,9 +168,6 @@ struct hal_data_8188e {
 
 	u16	BasicRateSet;
 
-	/* rf_ctrl */
-	u8	rf_type;
-
 	/*  EEPROM setting. */
 	u16	EEPROMSVID;
 	u16	EEPROMSDID;
-- 
2.34.0

