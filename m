Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2499D36A05B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhDXJFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhDXJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E64C061756
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so2399322wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gr+K/KD3N327fp7eZydf22I4/DF15PNcSVC+sZKAZL8=;
        b=O9klKUKNlRIXZRIZHzMBqxii3KZjwa5mmYjWhvA2ki2mfuH+Faeeexi7aHbJB5VMCj
         C4+PCRJbwcWO6+M+xrQYuFtoQe/vml7f/MsaaHIDo1QSNAkWpLVEB//K6YidB3ci852i
         DachZvJwlHQfmpOmfzHi3tGhNpo51YU03ryw5/OmKtxqyKGfujhePmNSHk2Y+lBQ1yjZ
         Jwjrt3Ss5m0ZCoLs07jAQy1Kwby517efoBiOjozn4GDL24Xnx0PT7BVGQ6Eob9pSoq5X
         aIXGt39lAGf4L/NvPKQ1JXvS/t13772dpGzVMJ95kl9JehxQ3eBm9P9xsyRgmUi4WUI4
         LJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gr+K/KD3N327fp7eZydf22I4/DF15PNcSVC+sZKAZL8=;
        b=NKg09K5d/jmun5N1F6ZtbAtZTZ7yFQYXbtr5LMyzs+m8Oa++hBeBedOY+jVXkbHxvs
         406Gs2knRUhu3bBl/dDBFqQLyFETuU7k/y6yDRC2m6DTUsIyFI8UZG7XP8OtIXAbe8p5
         0o3hrGPJTLUHL89ZWZoCN6w+n+5Kpr8q+1yGVm253Rxqac/HyWXL7ax4VHH9F0tCxFYZ
         +dJ6XZN9f7uhmJroSxYtl2Mr4WtDG2bQDz2yUvzw900XGbD0wwKeFrqlF7m2LMuB+4+y
         gGPyudRNAPR6a0q2zHaFRk+aBESlNZz4jIS7npMmyGP95JsTAhLAO+NQaEBGFV65nbjq
         undw==
X-Gm-Message-State: AOAM532CZcN0xiMuKKFHXbxsWSB5BiBExKCi1xegM5Xv8cpyN/0JsRTp
        n1wm/LWIi8HrbwKQJst/wiOVNZhHHqrImQ==
X-Google-Smtp-Source: ABdhPJxQMtBGDhgEs3OBogZ13RSgKB8bgogBYA2mvgzykBKJV4sfYuygirWv0R1WzBVTRh8kW2w0fw==
X-Received: by 2002:a05:600c:228a:: with SMTP id 10mr8633692wmf.115.1619255000631;
        Sat, 24 Apr 2021 02:03:20 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id l25sm10377238wmi.17.2021.04.24.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/50] staging: rtl8723bs: remove debug macros related to os_dep/os_intfs.c tracing
Date:   Sat, 24 Apr 2021 11:02:10 +0200
Message-Id: <53110c205451e641f8e24c07d36fe6cc5d087e60.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to os_dep/os_intfs.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 470edb0b655b..f7c2d9ac3a61 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_os_intfs_c_			BIT(11)
 #define _module_rtl871x_security_c_		BIT(12)
 #define _module_rtl871x_eeprom_c_			BIT(13)
 #define _module_hal_init_c_		BIT(14)
@@ -32,9 +31,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _OS_INTFS_C_
-	#define	_MODULE_DEFINE_	_module_os_intfs_c_
-#elif defined _RTW_SECURITY_C_
+#if defined _RTW_SECURITY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_security_c_
 #elif defined _RTW_EEPROM_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_eeprom_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 160f624612c7..6ac78a9ae615 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _OS_INTFS_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
-- 
2.20.1

