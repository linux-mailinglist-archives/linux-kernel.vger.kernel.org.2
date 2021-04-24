Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1236A05F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhDXJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbhDXJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9FC061344
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n127so15442272wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWR3xIwcvAYs30wacpInm8yfy/J1zl7gAnK+J7z1umw=;
        b=FrLmIko4u/h4XklYmo7GpfDy74QeZ9NMq7ucSWGXFl3yYSqrHO07E2TtxyeLXE372X
         IR9NfU7UeuwQwFHedydEiU/lYW+PsQpJkqjASupjgdyneUJSn4KT/+C+ESJ4UMHe925V
         WGZA5Sq4cUuNcWk0VgcoYzi0D0W52irE3nNHqYVW9EwuLPfoznsTKQSzdbGi0gtTbzXT
         +kIZ1Y69isJ7pRjP0H6fE/1SHo6mEvMEXhAC7anzAvnPCHEcd+2hnn1QrpQQwFxDX/WQ
         GntA5/s8itpk+yvSxi3lNDJrM14bMsVvKOFGN1bVY1tFKZUtWHlegLc1t3xIkc9FP6/c
         B8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWR3xIwcvAYs30wacpInm8yfy/J1zl7gAnK+J7z1umw=;
        b=YL7cBffxjm3hlC8/Ilf7BXDg/uiiRK88H9nt4u8ZMpAl8iQMV+mFzBj+AVprUKAV8s
         lHxdrlqTMManBl29mfcxjE4ItmsSxeVpMfUzW4960poGGrqmKOGLtzXLHZvWx/V2Un42
         plV727c/KZ6mPoElWujLRvtIKRdHlg07OnvgrrrnzYtOMnWUNH9jUdPgZvI4hchISNQU
         iOlYlujfCZquGfjrHUJzNJyWuvF/6I5UPPgBaLtFk0VM+vISGt5U/Zic3xEKAY+euCBg
         UBFqLmTmRciNnPQHAavy8NEsBKyLEzD58usaue8JEoBblS12slgSRgZCEZ+u1HYOSLR/
         n6sA==
X-Gm-Message-State: AOAM530+nXQiTwwY4MvSWO6mi1I/73gBkvY3IbJ+1hkRpZnH1QTy6LuE
        gtfZmEx8huIMfnuOVAZtUcFkvUOUtSYbkw==
X-Google-Smtp-Source: ABdhPJwa3WxpHpOPxjsqiw/ltJ8eaiTjnvTKrQdG4ndsfC2gInsEJfWBlZS5xv4Y0rkQBAOgf+tIQQ==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr8542597wmi.96.1619255007581;
        Sat, 24 Apr 2021 02:03:27 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id s21sm10143173wmc.10.2021.04.24.02.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/50] staging: rtl8723bs: remove debug macros related to hal/sdio_halinit.c tracing
Date:   Sat, 24 Apr 2021 11:02:14 +0200
Message-Id: <0de5a9cd0c70f1a5609320e545206376a7cf4498.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to hal/sdio_halinit.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index abd90026a8c7..7c52c90d1566 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _SDIO_HALINIT_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 4da881e3a0c0..4146acb1cbb2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_hal_init_c_		BIT(15)
 #define _module_rtl871x_ioctl_c_		BIT(16)
 #define _module_rtl871x_ioctl_set_c_		BIT(17)
 #define _module_rtl871x_ioctl_query_c_	BIT(18)
@@ -28,9 +27,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
-	#define	_MODULE_DEFINE_	_module_hci_hal_init_c_
-#elif defined _RTL871X_IOCTL_C_
+#if defined _RTL871X_IOCTL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
 #elif defined _RTL871X_IOCTL_SET_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
-- 
2.20.1

