Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC624607E7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358910AbhK1RPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358587AbhK1RNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DE7C06175E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso14922949wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Ytho17AJ4uMgaRdXauPbFbIjw+Tbhbf5MABHEUnEio=;
        b=S2n9rH5XqMeOZSojmjg1+nvP40ECA1wvMIB0cXhsDFTkNWXDNHM0HfEJ/x1/wynatv
         CbNHwJMbITWfrfEB0+heUp6b8unN/7HS6Jmz+7lJLvZ0nqTzFFCPLhEE7brWK+/4lCnf
         eSEO15CGmld83lZIhEkxiUbqgjIlvmW8MBFuBSDh6+x/o7ecc/cAJoL0AKWi0ry0r7VK
         PCCEn44viBYhZaOKoVvaPaNCErWhcKfoAwlDdqa+F8cDqSyHQOvXWMTuu08HL2tRE7nn
         CadPhDpauL5/6/bjL7RP2LHcxQthPQp64T+BS3ycgIqHQ/SA7SB9IJNCRE/XIRoxmDD/
         Adbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Ytho17AJ4uMgaRdXauPbFbIjw+Tbhbf5MABHEUnEio=;
        b=a27MNP7TOQNy/346eieBOIL9bXUpXI92Q9PxU61y4imceP2eSgUAW8gTTr6TpddCIg
         unU5O5hMMr5K29ZDtc84RG2CJA6Abab2V4BMwgRocFj5J2YXFfgy19/6S4qcRuATKYLE
         g6Tov8Q9r7boqBSSWBG1tfhs6Hz9MIP9hYkKa+UuA/QaboOE1Hmf6VDQemhGwcCQpktV
         EG8ScZQvUAdVHdoM9nKyrYRrExQDrG5sblQO1dPsNBffhdLbZpLGmYfhrWnnF8ljK4VU
         1LRT6f54ynj4JFHJGrzW2384DBxl8hlnulxvxbF2co7XDXv/fR8Gjn0msMcSM53U4/Yb
         2KKw==
X-Gm-Message-State: AOAM533rM5SSU2wUXpGv76AHFd0fEl56aMszQA8g1yNVHff7XMrhQ3kN
        vVGoeLlz2FUrbCcnhI+YFWW94oowX7s=
X-Google-Smtp-Source: ABdhPJzus2gUg/hBhfM+ogKF/EBfuXDSOjaJUGaYCnxO6hZHgqildW1ALIsObSUgUEDFN5rcURPmJg==
X-Received: by 2002:a7b:c1cb:: with SMTP id a11mr31181690wmj.30.1638119394500;
        Sun, 28 Nov 2021 09:09:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:54 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 09/10] staging: r8188eu: remove rf_type from struct hal_data_8188e
Date:   Sun, 28 Nov 2021 18:09:23 +0100
Message-Id: <20211128170924.5874-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
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

