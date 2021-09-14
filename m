Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE30640AD40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhINMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhINMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:15:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F3C061760
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u15so13785269wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VnZsNnr3VQCrEo0PDtrkdRH8QBVvc3Duoao6HuugeY=;
        b=TMTSsiFAB7lLVqx8XmDAGMzNBuNhOmKmNRLiBWV71JBy0EvCEF0+CSY7sqdoS90LFk
         qJ7Sl6HclkhZf4hohaZARDtA22KVSsbBfZYGJoVjaJMuUnkcs18bGYasGkMn2ftJPKkq
         JQ8dWhSVElVZIEHwypEJGbTMuuIHR3VgrjQhKYVca5MezXvSNuckPz2uv6xUw92eVKpL
         AYK4ydjz3Maz7q78+MFsDIskRUUjSCumOVHEMTUYO/4pzut3PKLOA0g+F6jpqLrkVgqj
         xAWS66uHU9+zJ8FJCTCVAnkrYc1UJpUoqCtbIGKeEX2PNZvV1wS32lbH0SDr5eZ4plaz
         MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VnZsNnr3VQCrEo0PDtrkdRH8QBVvc3Duoao6HuugeY=;
        b=Bb5N9T8rhvtYFMXrHi2o4jlL/IV+Gl8sC4LE+RkTPxBMpjKFkQdpz6Vo9hSwa1a3Ls
         q+uAX7pSn/japEyEPzX9BOg4h55v1YZrA4lWtw9x+ReWIXCrP+WbIU6Bk+1K2CoixQGP
         lxe9C77dopuAh/Do7UFkfQX5/RxbiOTT++lHBOhh0MxK2DXcZwhHzyWeuIP9wNyJXY8i
         BSLLB83c3KLVz1lQkJS1j6hay7ZHB7zPCi2TU0aD/i0tunrKN11Sd1jsCtUqlnSVDLZu
         WodrizlmSRye71FJvGhbqEvw0PL6CoZEGKl8tWXAap2818gttMegtPDzQoZtE+qWroNW
         AI6w==
X-Gm-Message-State: AOAM530K7WIJWmqdLmSQ0VogCF5CkvGCT6Ul27JvixtWec6AMkOQCvHa
        rO8Hx61TemmGXk6sndmquBg=
X-Google-Smtp-Source: ABdhPJxzmvTChsPMPjCRecPc0KsX4ffk2jz57QgSfIhca/hl/sHWn+AhMpTk8Vjb/Tf2ZZhKh1tIUQ==
X-Received: by 2002:adf:e643:: with SMTP id b3mr18850508wrn.67.1631621644255;
        Tue, 14 Sep 2021 05:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id j19sm10028100wra.92.2021.09.14.05.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:14:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: remove write-only fields from struct hal_data_8188e
Date:   Tue, 14 Sep 2021 14:13:50 +0200
Message-Id: <20210914121352.26052-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914121352.26052-1-straube.linux@gmail.com>
References: <20210914121352.26052-1-straube.linux@gmail.com>
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

