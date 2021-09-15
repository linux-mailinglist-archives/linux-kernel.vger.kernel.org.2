Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDE40C24E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhIOJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhIOJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63772C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g128so1525295wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VnZsNnr3VQCrEo0PDtrkdRH8QBVvc3Duoao6HuugeY=;
        b=NWzsPad815e1GzeGDK59hcThhwAB7sAqjtowyaZVqmczNGWPUE774DPGB48q6x8K4x
         dOcWamPLrwdatk++BfoTSBBZGOSmz56XYz4NXB1nRfG9FuqRVk+3YTt+M26zh9x8R4rb
         Co8mezTCG7M0IchtulLZnb5LsluXlrV4O8Frp0rVU7RSZZF3qOs7U40H0K/cE6acYXGZ
         rN4kloQRJp6Zt4Efvx7JQ6n2lcTqPBiGWaW6L3TWCyCpMkPepQUCvnt07ZnFFr2HTGxM
         Zra0ZnsCXiER4IIeBpfU9XEWww2wLsVINrcdFPmufylqpzJA9MFB51Qtpu0dqeYQa+va
         jE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VnZsNnr3VQCrEo0PDtrkdRH8QBVvc3Duoao6HuugeY=;
        b=crRA3A8h8jMOc1ZqUDL0Pe2RsUTYSyNgYrHQ8VP9038Gvag0gx40wDCqKJPNCizYab
         pQfiHoBRA1DgQoyoJuyM4AOdPELc+a7BtMqlUzB1/0oOv7bBRqZzl+X+UmrfEiD5BSza
         BDmHgv3WD8UUFSIxc3vBRte++DMNy4aJqHNW7hoD3/lLo/iZOkZTJjFMVbEMFO0YSQRX
         5iDPiW/BEllHgHgSOaRTO45bdC0K3s1YBkS3XYn8KeZAZImE6Xtg+07Z2zO5hsBlUeYT
         2rpTBduVmHyZ0Ln2Z+zW98viXloPvIFB6aGaGvyd2DGIMZuJ6LGNmWU+pr4TZhDoPTs7
         RImA==
X-Gm-Message-State: AOAM533NahZYUuLYEqaZNeBeS+vDCzm1tB8lPtToKH1ZvF5jbS/LOQMK
        8J7XvhtbigX1fenxg7LO6qM=
X-Google-Smtp-Source: ABdhPJzI6dyVYdtAfU6tcQBI3+W/mKCuZlcuySXKnTE3xg+8aM7uB2F8xbDjCVxpShCVB6ilFZjofA==
X-Received: by 2002:a7b:c4c2:: with SMTP id g2mr3251137wmk.134.1631696539038;
        Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n186sm3565530wme.31.2021.09.15.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:02:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/4] staging: r8188eu: remove write-only fields from struct hal_data_8188e
Date:   Wed, 15 Sep 2021 11:01:54 +0200
Message-Id: <20210915090156.4169-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915090156.4169-1-straube.linux@gmail.com>
References: <20210915090156.4169-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields MultiFunc and RegulatorMode of struct hal_data_8188e are
set but never used, remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index c1188117a5cc..5c6c62e3f6ed 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1684,12 +1684,7 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	ChipVersion.RFType = RF_TYPE_1T1R;
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
 	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK) >> CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
-
-	/*  For regulator mode. by tynli. 2011.01.14 */
-	pHalData->RegulatorMode = ((value32 & TRP_BT_EN) ? RT_LDO_REGULATOR : RT_SWITCHING_REGULATOR);
-
 	ChipVersion.ROMVer = 0;	/*  ROM code version. */
-	pHalData->MultiFunc = RT_MULTI_FUNC_NONE;
 
 	dump_chip_info(ChipVersion);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index f16ffd952215..7e2feb390416 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -223,8 +223,6 @@ enum rt_regulator_mode {
 
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
-	enum rt_multi_func MultiFunc; /*  For multi-function consideration. */
-	enum rt_regulator_mode RegulatorMode; /*  switching regulator or LDO */
 	u16	CustomerID;
 
 	u16	FirmwareVersion;
-- 
2.33.0

