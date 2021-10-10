Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1E427FD6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 09:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhJJHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJJHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 03:35:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 00:33:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk10so10802547pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ykKHrA/r2EJEyEbkVUzjv11eom1VFrBiZ2DCTiavQzo=;
        b=Hb/Ifoo2P85nAkYyM1k9huuKSfcZ5dXqO0RwtNc4j0IL05RnvQoitTnjX4nVoYPH28
         UG3GWkEZSra0ygkWG7XZdtWayY2qEPBDGGsYb1+olWIz2q8DkLotxcwCPLGBQAor3cQ2
         BvVBqZV7yBvojMEhrBTMTshx69f1SseJxynNMyYfKUnXrc1WQehZLQXd0e5a0tqcgZNK
         apb1Z2mMN3V5MazcRP/A6/PU+4/preXy/k644n7BO52PDc3hXPNt9BIjLvMQ65FrPBW6
         f+09qr8V03hTdVyI9PTZdWiWov9VwQgCk2BBn5ouqAUxTwhvG+T7UW+kSscqrS25BTJS
         hMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ykKHrA/r2EJEyEbkVUzjv11eom1VFrBiZ2DCTiavQzo=;
        b=gBxOvsShks02vGTTnJgtx7pCaSEsXzBN4GUwYrJHQGEn3+pQOIMrtJcibQODaI8paQ
         l4NkE2yEfwZuxWzyJRr9XkSIsTkrCxaduwSKQPVi9dA9Z+ECvDQr1E0oOqWsyVztzI5r
         YEEUCPtZygfvBKk+to26gUqrsJA7NUJu7a44q9L+4/LvbqTEOsoy3n4WTgl7brniroJm
         tjjwXHM5tZmC4y0euTgUxAysoxZpvYzrWqVg8wKb5xl5tYOMjmfw4kDNMplKAA5njfp8
         4se3kRVPjW/f10pArt4r3HLs239CIyO3k7ufWgkW0NuhDKNF7QjI8tsAZ67SEyp6HVqe
         vi+Q==
X-Gm-Message-State: AOAM531DBYAzSE7H/zZ6GjqGIP/siWVRTljul3+QBkojjCxPJVak4kkd
        hyxBB6SO9okW1f7RJvqzHg8=
X-Google-Smtp-Source: ABdhPJyaBp/q4QLGz16KTew7U5mk6UQ/Tzhv3gHfJhX+TdLkxX9fWtvzGMYTlmsaua+7XZ3VtmslyQ==
X-Received: by 2002:a17:902:e544:b0:13e:e863:6cd2 with SMTP id n4-20020a170902e54400b0013ee8636cd2mr17885504plf.41.1633851182186;
        Sun, 10 Oct 2021 00:33:02 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id 184sm3981317pfw.49.2021.10.10.00.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 00:33:01 -0700 (PDT)
Date:   Sun, 10 Oct 2021 13:02:56 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        lee.jones@linaro.org, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: hal: remove if condition which is always
 false
Message-ID: <YWKXKGuA/Io9sEjf@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the if condition which is always false. The last update on
variable max_rf_path is value 1. It's value is not changing after that.
So if condition check for value 2 will be always false only.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index 392cc8a398f5..612575ba961a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -106,12 +106,10 @@ static s16 odm_InbandNoise_Monitor_NSeries(
 	pDM_Odm->noise_level.noise[RF_PATH_A] = -110 + reg_c50 + noise_data.sum[RF_PATH_A];
 	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_A];

-	if (max_rf_path == 2) {
-		reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
-		reg_c58 &= ~BIT7;
-		pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
-		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
-	}
+	reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
+	reg_c58 &= ~BIT7;
+	pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
+	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
 	pDM_Odm->noise_level.noise_all /= max_rf_path;

 	/*  */
--
2.32.0

