Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6FA36A04D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhDXJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbhDXJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A2C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n84so62620wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsQ6es43IHoyLDmIOwsDHm5ujGzK3kUKyhDSjmmPsb0=;
        b=Mp8i3P0Sf1co4etxYdreRCLJQqqwnCV/+TnKyGhB9hAbXJZ58JEkWH4qLqpwKcS/YL
         EGK49Gou9IkFa2NXIZoixKXvKvfAuDM6YFO7nnyT4UEOFpwRTNbGeweogEc9uHWQKK46
         LTpmV7424Lk/jQXWroCWBKwQvR8S6UT3mSpmJUp88jL+sWdOV08knsLxhVzwqRwiQmy8
         nR11TDF6/GSfHPKOQkVmNAroizoRF44BUrdAyWkY0r0ef8WnQQx0mjOqzEfnLjVNiSN8
         KJQxoyiJEf+8VbpLRLoawjkBUKqRSuMevYYmQvc9ECjZ2pIsiSVd7jOjj/xC79ZDcJki
         pAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsQ6es43IHoyLDmIOwsDHm5ujGzK3kUKyhDSjmmPsb0=;
        b=lDo2HLRCuyFVaXYFAWyAxgK/8eZ8G2pt7Sy1SlpX988J+uqqHrrjA/L5l72Z+DgheX
         BRf1LFxkHo1+8rUFkoxPIoC9w9PTjbpKP1idMjJ42+duaiNrKMFWYr3qpDhEq2MVRL/F
         2jHt//90ioVtjK8CxpkbAygj7ROm1pT15pBQSKlU6ZlRilwwPDiyRhfBhWwrD8LjGTUw
         ZwV64HXcd9oGDLDnd+UPycUUPVzOG40yThMOjM8/7AbCc2SAEn/ICbsNszRjV14qV5Yj
         4i6diL9DGTPqdGMFuqjtc/K1Xg8OQTF8BA3jJZQQL7HDfW4BJ6hLntzA/+JRU84rkR2o
         8mrQ==
X-Gm-Message-State: AOAM533d24+Y9ht1VT3niTyYBAijFGV2Sp6LWcvt4EjhilyY7QdqOwX0
        ub5YTw3S9rj3gOjbJqjfmBj1zQSWcDRJtg==
X-Google-Smtp-Source: ABdhPJxo5ygUoqnau1EOZRCfQA2ZN3FIOMMdxzh/gpWKlpCZXF5WR0JylhDn3cDgvGSNK50zPJz3gQ==
X-Received: by 2002:a1c:2857:: with SMTP id o84mr9731601wmo.181.1619254977183;
        Sat, 24 Apr 2021 02:02:57 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id w4sm12235750wrp.58.2021.04.24.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/50] staging: rtl8723bs: remove unused debug macro definitions
Date:   Sat, 24 Apr 2021 11:01:56 +0200
Message-Id: <93b7f5af8f5220bd17530f7a907fa4fff4cb87d4.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macro definitions related to
private log level tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index acf4deacd3a7..8f56d1e7e644 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,18 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _drv_always_		1
-#define _drv_emerg_			2
-#define _drv_alert_			3
-#define _drv_crit_			4
-#define _drv_err_			5
-#define	_drv_warning_		6
-#define _drv_notice_		7
-#define _drv_info_			8
-#define _drv_dump_			9
-#define	_drv_debug_			10
-
-
 #define _module_rtl871x_xmit_c_		BIT(0)
 #define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
-- 
2.20.1

