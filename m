Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0035FAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353014AbhDNSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352637AbhDNSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5BC06138F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d21so4718267edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jmlhXWCJ2XtgAisEDgZm+I/z8Zj5LaHUfk+sYMxcX0w=;
        b=bOAvcIZAx8MOa6fUzYOC2qnQqsEY/wNrNKN0j9q60ttjRFNTKqOtTPBFvFLk5jMegz
         I3SBkmJJHF++9ARM3n/hh5FxIiZEtOTb26ZpaL0i37wJvQyzRMM+0UFCtTb5EmabDo6P
         OaD+/5jPY+KBtLE+9dMZOJJz3c8/XhHnGoBJdXVzScs5hEiPd6OknaLf3uqBW6y4tL9o
         8CTx+TTOlzGscPKFlBrBmvfoBz91Dt1+x6dyUBbJFEqcE3q0bcTj6X1dlQF0Q+vGZDFz
         v/BtzKMbVpyCtTgWbrB/CUTI6MzGw5fsiZbwA+0BvFxxjSE1W5Y/2Pbr7vNetMK7oRVs
         mGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jmlhXWCJ2XtgAisEDgZm+I/z8Zj5LaHUfk+sYMxcX0w=;
        b=U9xep45ZOao0ZXakLSisKMG9yRWyVubrUUuspFkH6vV3A2Erj9BP3um1UfIFYV+5Bq
         aXl2qCpcNZQXdU2MoCJlRNTWKNcX10DuPzIJ9659iL5+G9JtXKJ4/02iItv6MGOoJZLI
         liUXcFv5G15vhz01bS1AsuNzpKgk7E8GNCWcuQZ5RGbIMgLXgmtbWcWNeNQdSwa3UJR5
         Fzu6SbgbvGwUCGYARa62XUaWA4INli4RTQOm1nHmHcUiJjrNIQ7OFaAieMGfUSXxqJDB
         etKpDbJnEJr56a4qLekSLvDD0X6IVM++ut1zMRetkRaFQhoNObjvnPkMUIFEYcZxsVPS
         9GnQ==
X-Gm-Message-State: AOAM531ffz8XY/E/FBdbdrQV32CaUHogoHWLXqPmXqUCnb/pt96DADqE
        membwjMoMWQX6bu7nI9FmnAHguKGM/05/w==
X-Google-Smtp-Source: ABdhPJyu1Xkaqc4ETAAc2G9Mc6AemDVEQqBB8EZH2Dy2YGiwN5k0QZNSXO5TO34emzUN45TL+VNl8A==
X-Received: by 2002:aa7:c247:: with SMTP id y7mr156227edo.305.1618423954858;
        Wed, 14 Apr 2021 11:12:34 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>, Stanley@BB.SD3,
        linux-staging@lists.linux.dev
Subject: [PATCH 57/57] staging: rtl8723bs: hal: sdio_halinit: Remove unused variable 'ret'
Date:   Wed, 14 Apr 2021 19:11:29 +0100
Message-Id: <20210414181129.1628598-58-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
 drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
 drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
 drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
 drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/hal/sdio_halinit.c: In function ‘CardDisableRTL8723BSdio’:
 drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Cc: Stanley@BB.SD3
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index f6d734dd1a24f..60d3d6d1ba678 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -878,10 +878,9 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 {
 	u8 u1bTmp;
 	u8 bMacPwrCtrlOn;
-	u8 ret = _FAIL;
 
 	/*  Run LPS WL RFOFF flow */
-	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
 
 	/* 	==== Reset digital sequence   ====== */
 
@@ -909,9 +908,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
 	/* 	==== Reset digital sequence end ====== */
 
 	bMacPwrCtrlOn = false;	/*  Disable CMD53 R/W */
-	ret = false;
 	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
-	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
+	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
 }
 
 static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
-- 
2.27.0

