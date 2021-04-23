Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF802369541
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhDWO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbhDWO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B203C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so44985438wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuLarW/DVl6DwK0Y58hVKAVu2th5zfZnIaCNSJUZPc0=;
        b=WSIFdjcpcTC5uXwaIzV/hAdZmJCGigXNV0Qyo1mLXvgQDRx0cz1hQ5wUcCpgef6mvu
         EF0h1F+MLOfH2y9/+8Opo1O4BN78stJU6ATMyXR150Z/8O1tPKyuK5Hm9pvZPg86HR2N
         QC6iTeCNewWthvuVwW27FrurxLJ//M9jSpy0FPraGTR4TES0+KrtCz5Q31CUoWKL+3LA
         rluMM98T597E66O84L+CHwuG4o75zMTYidOHb0/tZH/eEFp1dTchBLNKJTdzsTEeLQI/
         vHQaamyiClM8J4bmoeb6n4dMSbJd9pM4lZ2xsOFkeW/R5ikJLGzuq13CssD9futfhq7a
         EX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuLarW/DVl6DwK0Y58hVKAVu2th5zfZnIaCNSJUZPc0=;
        b=Urof7pNLMBgKN+IB8sEBNJM/otsXntQG67bbjKGDLik4RYJYk/LpLkdytSv2YhSWU2
         WwS1OxV/GirIv5dlCloqfNbGMlu0pNZzf6Z1lI/TgwKYAEsZUrN5gDypFUSMU5OgL/1Z
         uhniEsFXmvluIg11nviuKydmP19mtGVwqifd51EMNHbLhPxWx9F+XUOkLYWZR4JUsitJ
         ku4W+rOKhBEsgQHFUlq6bm6hp6ZEAC1FEnCRiHfQBi/IIGHU8uoGo2khw7Urk8m1dTc0
         X3uNA59gv69y/QS9dkj5lgMF05cj0OLsJRAYIPldCgfcLv8X+Z9E2MVtzx5KD4Tt3eaI
         G7Vw==
X-Gm-Message-State: AOAM531uG8FDBVl7gI0H4bEgPMrslolmBWdCiPRXKorXTPs3R1StIzQd
        PHg/iVfo80Mrnl24yDWV5EENg/HQu9c=
X-Google-Smtp-Source: ABdhPJwULsfljnk+PkDpEXfvvZJ7PyihSMatlJGM5U51itZGZ3ubZHS8VzSwcssbs1bFgaq7v36/0A==
X-Received: by 2002:a05:6000:22d:: with SMTP id l13mr5350233wrz.26.1619189923865;
        Fri, 23 Apr 2021 07:58:43 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id f6sm8014024wmf.28.2021.04.23.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/49] staging: rtl8723bs: remove unused log function
Date:   Fri, 23 Apr 2021 16:57:52 +0200
Message-Id: <397a4082fa2a49c67ac7d6869284334d3fa7bea6.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused sd_f0_reg_dump() function.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 17 -----------------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 79fd968bb147..0ee0190c09d7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -14,23 +14,6 @@ u32 GlobalDebugLevel = _drv_err_;
 
 #include <rtw_version.h>
 
-void sd_f0_reg_dump(void *sel, struct adapter *adapter)
-{
-	int i;
-
-	for (i = 0x0; i <= 0xff; i++) {
-		if (i%16 == 0)
-			netdev_dbg(adapter->pnetdev, "0x%02x ", i);
-
-		DBG_871X_SEL(sel, "%02x ", rtw_sd_f0_read8(adapter, i));
-
-		if (i%16 == 15)
-			DBG_871X_SEL(sel, "\n");
-		else if (i%8 == 7)
-			DBG_871X_SEL(sel, "\t");
-	}
-}
-
 void mac_reg_dump(void *sel, struct adapter *adapter)
 {
 	int i, j = 1;
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 23f4cb4711d4..ed75db1b16f8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -169,8 +169,6 @@
 
 #endif /* defined(_dbgdump) */
 
-void sd_f0_reg_dump(void *sel, struct adapter *adapter);
-
 void mac_reg_dump(void *sel, struct adapter *adapter);
 void bb_reg_dump(void *sel, struct adapter *adapter);
 void rf_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

