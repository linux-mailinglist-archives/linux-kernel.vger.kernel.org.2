Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFE36A059
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhDXJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbhDXJD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD58C06138E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x5so383775wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Juwe0Gjnc+rMihuOPa254C+qnQsP361xtVqHu6bwkD0=;
        b=etqSR8xsPbaAO7cj2WM7YWDt+IibXYSlQpIz9tDY1JB/CDd5trta7h1nblTH+lIAnh
         dZTKzS+2wEuOatZNzoK8mN6ZeuJNh4Ui+XXJYh/3Qno5jVyI3Y35IfVySIxU4T9SkfVp
         MNXAwr5V30TnEXcE1dfFnGy6jMiZzIFA0lIRmIjKHqrgTTqENHtGnqKDABOs4WqShKIY
         2nFGk5C+fxm/I0PJs6nm5jphbSIY6bfSec5ojuA0KXWFBJVxw8iowX9D55CYLsipKH9i
         3dRtls2LoJmLQ3SObhCwLoIHnjZVy063NUtdm5/9sKvsdoe7n7UYvpsWV+jskwDpCJbA
         nk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Juwe0Gjnc+rMihuOPa254C+qnQsP361xtVqHu6bwkD0=;
        b=ADK8KAtGbocuZxRM5twE6X4ht6ixI8c2pv1mKhmw8D6AnufzfjFcy/wjLiNEVtPW/h
         OzBQsRqRFQHTKCODNfegJW4RUoraT3GfTo87KWnIyGX+Lcc3kwQaDwxjtdm+GejnfKQA
         qoFwCK1voHXQF6MrbJk7hpnZEwapL3lOAyPwE1Dz5FOFfF3zwZmH8T3OOcSWGntr9tPM
         RVnt71I3HcuZFklRu+Sef3bSzjpth79VWztu4pP8TXFSoLAg+v1VwdsIn98/9IFnUtVn
         78TgtezayJOmbp9/V7nOaqbbIx/4j6v44bMYcvJgOUabsEABGHVWWGDPEN+K1q/5oqud
         p0CQ==
X-Gm-Message-State: AOAM5327ksMw8WR5PwrAEiDrCksLpJsfTDeCmTozizuOhZGlshx2aYU6
        AgPSGV3Np9Hxz/Koi9O17xDw9OoFpebjNg==
X-Google-Smtp-Source: ABdhPJw8zo9DJRp+m3+lf9JLPdz1v4+1a/TM/kF4KNsdXU3Zc9iNmQ00ilzVik6GNJQabcgClZ2o8A==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr9729025wrx.281.1619254997263;
        Sat, 24 Apr 2021 02:03:17 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id m11sm12125977wri.44.2021.04.24.02.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/50] staging: rtl8723bs: remove debug macros related to core/rtw_io.c tracing
Date:   Sat, 24 Apr 2021 11:02:08 +0200
Message-Id: <2c97fc0121e3dfbc97bbc1ce5bb9d4a05e5c88d4.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_io.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c       | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index c860ab7d618c..ecbb679fbc16 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -25,8 +25,6 @@ jackson@realtek.com.tw
 
 */
 
-#define _RTW_IO_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6e6dea4779d9..7206fdfbe12d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_io_c_				BIT(9)
 #define _module_io_osdep_c_		BIT(10)
 #define _module_os_intfs_c_			BIT(11)
 #define _module_rtl871x_security_c_		BIT(12)
@@ -34,9 +33,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_IO_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
-#elif defined _IO_OSDEP_C_
+#if defined _IO_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_io_osdep_c_
 #elif defined _OS_INTFS_C_
 	#define	_MODULE_DEFINE_	_module_os_intfs_c_
-- 
2.20.1

