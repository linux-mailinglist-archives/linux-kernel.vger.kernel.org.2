Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2640F3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245326AbhIQIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbhIQIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:08:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D973DC061768
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so13728505wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sj0+J/T3kl84+JoLO/Afs8CPsPt/FXlpEUQ3L+i624E=;
        b=bWpYG8eq0TsYLTGXHPNyZFq1fWNKbZU17boDBfCZckglN/71bELYZKaZZJOM375ohV
         AqCGOfDIV8UGOgIeCKUfTcZjSRTw29FHYsX/QOgAAb8a7o2aC6u6TKycUkinEhg+qpQL
         V/cp6mfA3kfVtOHEGmTQ9wKHAacF+PMn19aucgUjAHkIniCA4Rd8kioNUGzvAWxbjRpY
         uUFuLcQekJwm/bTHpI/0AJs+WaVj9UrDki3NMVg71Kb9UjVgUbrw6VXylUhNGlsSHX47
         CvSYu8qrCKiBtjau6YGEmN5CaJgTpdu8fv6XxNwoPK4P/D0f1nvKfRFhAs66h8cD0WaZ
         o/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sj0+J/T3kl84+JoLO/Afs8CPsPt/FXlpEUQ3L+i624E=;
        b=fgICRjGRgUJlzNweFHLgAPozfG2fu/oZuXL0hp3uXMyX3wUHNVsbSnNoOA6794K7Sc
         PFmK4V3OOGAbIYzUJY183GP/Ne94R/Oj+EqZoYzibivyjPt10CLMwgAauRl7WMMtu6qf
         0Jhl+53KK5JJTz0uCoxdJ1CaZS7tTb2fb+C98/ABawPFlA+/AKCjmT9IEOTMkVgz3hTd
         2G++XpL9zPbCHAj4SYIJ4h7GNnvMb0vIk3G1qOXUqfIpjIqgJK8Ap8fyrDPw6qvZ9bDR
         1lRosncSRMId6x4ZHnV+0s9nyWsAAzzosqiiEVwH+VYMiN20njSOuPtVEYL0z70PjCH9
         +E/Q==
X-Gm-Message-State: AOAM530v2VmzktUIrRlPafmUk3eD7tJ1ESIMqkgkRF5NC9T9tOo58yKk
        6hu4R4OA9XaqiWCPxTA9nVE=
X-Google-Smtp-Source: ABdhPJxp3vAhHctL2DBT8VdpfbszmWu+LIseAHbzyowRiOK4gBnn/VwWpUFMyD+Nu2Qp9kJ9JUfNyg==
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr10743194wro.2.1631865992564;
        Fri, 17 Sep 2021 01:06:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id r129sm5690890wmr.7.2021.09.17.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:06:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove IS_1T1R, IS_1T2R, IS_2T2R macros
Date:   Fri, 17 Sep 2021 10:06:12 +0200
Message-Id: <20210917080615.25819-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917080615.25819-1-straube.linux@gmail.com>
References: <20210917080615.25819-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver RFType is RF_TYPE_1T1R, so only the macro IS_1T1R
returns true. Remove the macros and adjust related code accordingly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_com.c           | 10 +---------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 12 ++----------
 drivers/staging/r8188eu/include/HalVerDef.h     |  9 ---------
 3 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index eee57cbd6dd2..6031c25177f9 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -34,15 +34,7 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_",
 			       chip_vers.CUTVersion);
 
-	if (IS_1T1R(chip_vers))
-		cnt += sprintf((buf + cnt), "1T1R_");
-	else if (IS_1T2R(chip_vers))
-		cnt += sprintf((buf + cnt), "1T2R_");
-	else if (IS_2T2R(chip_vers))
-		cnt += sprintf((buf + cnt), "2T2R_");
-	else
-		cnt += sprintf((buf + cnt), "UNKNOWN_RFTYPE(%d)_",
-			       chip_vers.RFType);
+	cnt += sprintf((buf + cnt), "1T1R_");
 
 	cnt += sprintf((buf + cnt), "RomVer(%d)\n", chip_vers.ROMVer);
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5c6c62e3f6ed..6776e1d1c6d4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1690,16 +1690,8 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 
 	pHalData->VersionID = ChipVersion;
 
-	if (IS_1T2R(ChipVersion)) {
-		pHalData->rf_type = RF_1T2R;
-		pHalData->NumTotalRFPath = 2;
-	} else if (IS_2T2R(ChipVersion)) {
-		pHalData->rf_type = RF_2T2R;
-		pHalData->NumTotalRFPath = 2;
-	} else {
-		pHalData->rf_type = RF_1T1R;
-		pHalData->NumTotalRFPath = 1;
-	}
+	pHalData->rf_type = RF_1T1R;
+	pHalData->NumTotalRFPath = 1;
 
 	MSG_88E("RF_Type is %x!!\n", pHalData->rf_type);
 }
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 3a687f7c5b82..796a44a1e697 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -45,7 +45,6 @@ struct HAL_VERSION {
 
 /*  Get element */
 #define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
-#define GET_CVID_RF_TYPE(version)	(((version).RFType))
 #define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
 #define GET_CVID_CUT_VERSION(version)	(((version).CUTVersion))
 #define GET_CVID_ROM_VERSION(version)	(((version).ROMVer) & ROM_VERSION_MASK)
@@ -77,12 +76,4 @@ struct HAL_VERSION {
 #define IS_CHIP_VENDOR_UMC(version)			\
 	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_UMC) ? true : false)
 
-/* HAL_RF_TYPE_E */
-#define IS_1T1R(version)				\
-	((GET_CVID_RF_TYPE(version) == RF_TYPE_1T1R) ? true : false)
-#define IS_1T2R(version)				\
-	((GET_CVID_RF_TYPE(version) == RF_TYPE_1T2R) ? true : false)
-#define IS_2T2R(version)				\
-	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T2R) ? true : false)
-
 #endif
-- 
2.33.0

