Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B404072BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhIJUwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhIJUwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:52:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D13C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x6so4348850wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFP20JdLWO44Og/uNow71PnOPRiaV70lhBMuJXoTRec=;
        b=LoKTUaI4giA4ss0KYOFiQc32KJcI6yJd1HI2Iveo4EiqbkSgfk4PITSi6YFtdFhsUx
         gtazEO54B4rAMlud//IKHFAMS2jbnYG77SAK+tPOslXDiS0oQkhG/wsEvhGDMVvLBw+g
         NRxTi94fLwEBFL3jeE98NTXlLHfviiwmha25n77ckVejLK8gKb0xFQC8fkhc7ax4grou
         ZlyyYKYPgKTdRAVht/ogrfSwo5mK0VuogOkDi92S1H1/SWWWqrop01MiqHq9K2k52R6F
         w+1Dv3C+3HZgss+ejFdf8ulb8dRsLGuNJnXh4V6303yt7dfEA7w4ivS1+4vYuSXN3Snn
         rtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFP20JdLWO44Og/uNow71PnOPRiaV70lhBMuJXoTRec=;
        b=f0pTQSFj+xnnTYx51zlJ05rjkRlxHK7pqLt2cWsamijCkv7A/9U3SI3zAzNrRl9s8+
         FlqhRN23FkLDEyqCwT/BO0p8epU/+Ka3PpWTxACWEmlC/vfpqgjWWFjN8NusKY+jjy3R
         gR8v6LME2Iy9XayWZ9V2zidPWh4+Yp2mlueuaZzNcP4Ec7Az/J6wskx7RLiPryMEim8u
         M60IS9GYJJTqhYcUlAXBE8L2N+eq0QeopjlkNh7imrLF4eBxWj/7vYV7QOQAZVMY2haP
         psIooA7N9rnASQciwZI9kClIlZEl+TPkiltWmcW5kgt2CjHndO5JAWSrzxyxEyNX3myh
         qo2g==
X-Gm-Message-State: AOAM532IhMUQxUWwIBP7YmPv13or5Vjit4QlToOfc5NlnhHr+rPVLYEy
        CsHCIsJII180g46aWmoB4vLpA7K5Z+lAsg==
X-Google-Smtp-Source: ABdhPJyDH6/NnvBEQjD+DiWZ/4IqsxX6uYqAr1fTReaCT+WQD1b5UKIJtdXSkZ6BeVogDqr386cQOw==
X-Received: by 2002:adf:902b:: with SMTP id h40mr11621131wrh.342.1631307050571;
        Fri, 10 Sep 2021 13:50:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/7] staging: r8188eu: remove rtl8188e_set_hal_ops()
Date:   Fri, 10 Sep 2021 22:50:33 +0200
Message-Id: <20210910205033.3778-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of some pointers from struct hal_ops the function
rtl8188e_set_hal_ops() is empty now. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ---
 drivers/staging/r8188eu/hal/usb_halinit.c       | 2 --
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 0d6c3adff27e..027dcfb95547 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1748,9 +1748,6 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
 	}
 }
-void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
-{
-}
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
 {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index aeaf53c1cfbf..0c317a8723ef 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2227,6 +2227,4 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->GetHwRegHandler = &GetHwReg8188EU;
 	halfunc->GetHalDefVarHandler = &GetHalDefVar8188EUsb;
 	halfunc->SetHalDefVarHandler = &SetHalDefVar8188EUsb;
-
-	rtl8188e_set_hal_ops(halfunc);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index a9ca29b5b9c1..537a8d17642c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -432,8 +432,6 @@ void Hal_ReadPowerSavingMode88E(struct adapter *pAdapter, u8 *hwinfo,
 
 bool HalDetectPwrDownMode88E(struct adapter *Adapter);
 
-void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
-
 void rtl8188e_read_chip_version(struct adapter *padapter);
 
 void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
-- 
2.33.0

