Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF113FB314
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhH3JXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhH3JXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:23:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A623C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso8923063wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1K2L0rfQcMA4bHPO7PeyHVg9f7MV/63zN9Cyy+Mz/1I=;
        b=MwvbTUoXPFfHYJWBysVve6D22DaqF7WouBzXZ5uV6PcPKYzj7ouBPtBD0l9iJlMNCL
         2B/EBUs4Yjv3lEFfV97CWZ7Tk+NCrg2tRxXEBMXU7z5FTBpEZnZcDp5ZZmWbDcL97Fkf
         lE8Qj2Cjc4QAdUJE1BuP98eUMelnDo+5nT+cpggD9D3Y6sB6icNSaWOmkGcbUlClAWfj
         j9heZk8m6n7UTEjI+1OBS2ObhkZi7PNjPG9b3prUfnii+oM7x6NvB4AeHRDJ2ith1jTm
         jozWfr6ZT8g/ukJGIdSbdLNOS6gyYoJESB7rYBTPAanfTIfMjOGaTHUQE75k2VImnrFl
         2rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1K2L0rfQcMA4bHPO7PeyHVg9f7MV/63zN9Cyy+Mz/1I=;
        b=uRJ5XiEKDDOAKsHIlOMRL3rFi1xWoegFZqyPLfN9jatQ45BWJ8WxHHvCZiAh+FhMdq
         V59f0YORkRhcPiyy0/oo9u1BFUZjl0F37kzgXmJIV4HQU6IWNwVtERMjpMW3zb0UmPt7
         K7JGtxfoyz3Fnjrh0x0hVSsqTQ23sTqsgb5z2KrQImXRnLNS2Wngsd8MiagGYK8W5xjk
         /8ZyN1Qzps9ZU9d/d1yiXx02svgchUx1sioligyPlbGiHvGiv4NJi7mdZ5lza5YB16ZH
         ysR49atxX0cRvXRo8ihWpz6C6rQJo/XKW9UXNCVcPZ8UkDhdX3jYmPXqIXSEK0jnaF/f
         U6Zw==
X-Gm-Message-State: AOAM533xTEImNnG7L3+/zwpM2ZOcUCgLr2FU882/rAYrIyZV+5UtgPYo
        Q5M78rSO4qNKA9+ppdXyZv8=
X-Google-Smtp-Source: ABdhPJyg6F3CiC0oxDopjeuy116vYb8nYwo4z6r6St1P2iAILpwRb2/X03HxTdzGuOC9lHcBvksIng==
X-Received: by 2002:a05:600c:8a4:: with SMTP id l36mr20861074wmp.128.1630315324621;
        Mon, 30 Aug 2021 02:22:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id j1sm18378248wrd.50.2021.08.30.02.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:22:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: remove unused function SetBcnCtrlReg()
Date:   Mon, 30 Aug 2021 11:21:53 +0200
Message-Id: <20210830092153.9283-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830092153.9283-1-straube.linux@gmail.com>
References: <20210830092153.9283-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function SetBcnCtrlReg().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c    | 18 ------------------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 3da5c27b6805..1adaf472a116 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2283,21 +2283,3 @@ bool HalDetectPwrDownMode88E(struct adapter *Adapter)
 
 	return pHalData->pwrdown;
 }	/*  HalDetectPwrDownMode */
-
-/*  This function is used only for 92C to set REG_BCN_CTRL(0x550) register. */
-/*  We just reserve the value of the register in variable pHalData->RegBcnCtrlVal and then operate */
-/*  the value of the register via atomic operation. */
-/*  This prevents from race condition when setting this register. */
-/*  The value of pHalData->RegBcnCtrlVal is initialized in HwConfigureRTL8192CE() function. */
-
-void SetBcnCtrlReg(struct adapter *padapter, u8 SetBits, u8 ClearBits)
-{
-	struct hal_data_8188e *pHalData;
-
-	pHalData = GET_HAL_DATA(padapter);
-
-	pHalData->RegBcnCtrlVal |= SetBits;
-	pHalData->RegBcnCtrlVal &= ~ClearBits;
-
-	rtw_write8(padapter, REG_BCN_CTRL, (u8)pHalData->RegBcnCtrlVal);
-}
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 3939bf053de1..103991b6ec82 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -437,9 +437,6 @@ bool HalDetectPwrDownMode88E(struct adapter *Adapter);
 void Hal_InitChannelPlan(struct adapter *padapter);
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
 
-/*  register */
-void SetBcnCtrlReg(struct adapter *padapter, u8 SetBits, u8 ClearBits);
-
 void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
 void rtl8188e_start_thread(struct adapter *padapter);
 void rtl8188e_stop_thread(struct adapter *padapter);
-- 
2.33.0

