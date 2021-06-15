Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2921E3A7D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFOLsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFOLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B7C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gt18so3575191ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRuZDIg2uoOYU/MtepM0z4ZBXdIMOOorbT3kliJwsAM=;
        b=XgP/U8yi63ecYBWNXYonH7yuG1QT3KaLDofZd3F2st9eI+4F9vI6Nfa63bVyx2fsWC
         SNvv2I5K5/JyBQKRTGdhfcHetKGrHZMoxAx9aACF3IG5TMgBlpA/DjEeTz4DTB86bh8I
         BZs14cjZkEfDaYT5KoajJBYvCKaN5MYfp4zdOw+Y5G7jKSkydriTcMQnIg+4DqRLhVG3
         egBkLatzc2XBClHTJv5VTVuclfq/Y0YgPxhH8UXONjMkkIRib2weQdJrEdy53iYXARW3
         /pQtsPeN/+IOdQE8CGa8A1oGFYJKF6fj3eAeQj1J7wMgmurEVQukcgkuFXxqqiYTm6yh
         hwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRuZDIg2uoOYU/MtepM0z4ZBXdIMOOorbT3kliJwsAM=;
        b=j6Ihi8J1K7YM7rexwP+VQDR32MrMJROwCxnlcvsRymcGTH9qHTioLyfBuJXeHVB+R6
         vsNqvVLN9DV6kXYToFKwbcqSEiqSaUE4wgETycp9XiUfXEfFeZnO6sxNz70LSyGLzBzy
         nH3d1Ko/TQ4ux8PmDOsn/nQdR0N1sLIr2ka52PfSCNPK5Txcpf9X1+BYHcq66YDLQRDh
         gfW4AZAXpc5UOFGyNh2KY2CqUbVVz9shp+p5d0yAhzD1rgRB9qV5HkjUkUzk9/tGa03n
         +neYqb6SVnL/gsSSmegKV2mpMS0kTMtw9qhqYmCSmiEP7Baoj/o99blNpkXSGBCGHCf/
         1ATA==
X-Gm-Message-State: AOAM5303UJBrAIlHhlGCeRjRLHhWZxpmGacQ5/2bUNwoqT35P8GS7Vqn
        XLwQFB9wcFVkooWMRLb0+vgk1qswB7/JVQ==
X-Google-Smtp-Source: ABdhPJwPiYq+TTCVtwsKSEwLWN0vBukybPI3Dc0AyxEfcL8F4IRVjiw06jm50MlcbYAn0KGJ+BxtWw==
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr20117647ejc.349.1623757547693;
        Tue, 15 Jun 2021 04:45:47 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id br21sm9766980ejb.124.2021.06.15.04.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8723bs: remove HAL_{BB,MAC,RF,FW}_ENABLE macros
Date:   Tue, 15 Jun 2021 13:45:35 +0200
Message-Id: <04248acbd22f9be30d21891926e134490b34036a.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove HAL_{BB,MAC,RF,FW}_ENABLE macros.
They are used to turn on/off by hand some core
capabilities we want to be always 'on'.

So remove usages and definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ------
 drivers/staging/rtl8723bs/include/autoconf.h | 4 ----
 drivers/staging/rtl8723bs/include/hal_phy.h  | 8 --------
 3 files changed, 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 38acde4be94d..3738727feb60 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -683,29 +683,23 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	/*  <Roger_Notes> Current Channel will be updated again later. */
 	pHalData->CurrentChannel = 6;
 
-#if (HAL_MAC_ENABLE == 1)
 	ret = PHY_MACConfig8723B(padapter);
 	if (ret != _SUCCESS)
 		return ret;
-#endif
 	/*  */
 	/* d. Initialize BB related configurations. */
 	/*  */
-#if (HAL_BB_ENABLE == 1)
 	ret = PHY_BBConfig8723B(padapter);
 	if (ret != _SUCCESS)
 		return ret;
-#endif
 
 	/*  If RF is on, we need to init RF. Otherwise, skip the procedure. */
 	/*  We need to follow SU method to change the RF cfg.txt. Default disable RF TX/RX mode. */
 	/* if (pHalData->eRFPowerState == eRfOn) */
 	{
-#if (HAL_RF_ENABLE == 1)
 		ret = PHY_RFConfig8723B(padapter);
 		if (ret != _SUCCESS)
 			return ret;
-#endif
 	}
 
 	/*  */
diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index d1a97fea8065..8587b746c720 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -12,7 +12,3 @@
  * Auto Config Section
  */
 #define LPS_RPWM_WAIT_MS 300
-
-#define HAL_MAC_ENABLE	1
-#define HAL_BB_ENABLE	1
-#define HAL_RF_ENABLE	1
diff --git a/drivers/staging/rtl8723bs/include/hal_phy.h b/drivers/staging/rtl8723bs/include/hal_phy.h
index e9944ffed100..19221289b8ce 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy.h
@@ -6,14 +6,6 @@
  ******************************************************************************/
 #ifndef __HAL_PHY_H__
 #define __HAL_PHY_H__
-
-
-/*  FPGA_PHY and ASIC */
-#define	HAL_FW_ENABLE	1
-#define	HAL_MAC_ENABLE	1
-#define	HAL_BB_ENABLE	1
-#define	HAL_RF_ENABLE	1
-
 /*  */
 /*  Antenna detection method, i.e., using single tone detection or RSSI reported from each antenna detected. */
 /*  Added by Roger, 2013.05.22. */
-- 
2.20.1

