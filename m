Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167B736A04B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbhDXJEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbhDXJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DECC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l189-20020a1cbbc60000b0290140319ad207so4961wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XW37ftXCBhVux+kUs7zGKfQgu9LxmVlV8vWsGdLxm3g=;
        b=MoOOkIacu/j/eDBmtRn5ywdRRbYTZYGXIVAFuvBXKx6mJJFfSP9vGhH5FRrx6av68E
         9un+NZ/I3BVKaVF+Zup19qi5o/kCXwY1LKAPPH5/Lq6QyyJ/b8SSKGtgKxOUeiNndazA
         CqgZtYwxg8dVGQFeyv4XgU1LITzpTF8RIWE98fT3HibV2cp7P9+1c7q/GIehuCFh2k6Q
         TSFYWtRYJWfKuTkZkS62FB9/ZnNhHx3faqdTMif5+fus5+u12ygu2mksDY11Sgtg6BmI
         6jrGyu+5sf64M+7Kn9vBOV+OUA8uxiKDURNaRtjYMW9GXts3CPNM64L895K7QiohvYCj
         P8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XW37ftXCBhVux+kUs7zGKfQgu9LxmVlV8vWsGdLxm3g=;
        b=JBMwI5QYYuOCQq0KwAuFdIi3BKmTWyKuGwvbGrXen+IARDHsTIKeO6gir337FVU5IU
         OEhvcIJqkS9dV+4bfDOR5371JSk50DcJIeNwEBmeisszCOwMPoOggFZMkNScx90sEoYC
         8a0Xt9fJVYVCa3XC+74kkG5cjVorZ6d0k3hFND+lJVjOsfNsstYO2AJlMuNnS9pbg7VA
         L+ZETHfQniCFuSbFcmhL5N5V9EUILEpS1dEyykKyNqH6IliLlPtMqwrIMmpH2PC2UEeb
         kogT083zITrEIQ3gAhhDAdnpO1FXnafFY6QQln/XjEpsdtOT5QJ8p8jB4U1eablQGVAh
         0DnQ==
X-Gm-Message-State: AOAM532m+5xMzZmTTB/kv5QrE5rnd1xevA5TevrWwOgkjJjIr0C5K4K3
        wHQhfZITwXzAPqOQdur9slElUlcOODEyJw==
X-Google-Smtp-Source: ABdhPJwCRUNUaClELsAsZq45RpkWXyQZYJkAiqhqhD4nK79QIBZ3FykPBhyF5MPvRNx4+0TcJFTUPQ==
X-Received: by 2002:a1c:196:: with SMTP id 144mr9689613wmb.72.1619254973834;
        Sat, 24 Apr 2021 02:02:53 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id x2sm12777351wrg.31.2021.04.24.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/50] staging: rtl8723bs: remove unused debug variables declarations and initialization
Date:   Sat, 24 Apr 2021 11:01:54 +0200
Message-Id: <d566a6eb49949c1c80df286056b9df6114c8cc97.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug variables extern declarations
and containing #ifndef block.

remove initialization as well.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 642aa556c462..576b039f741c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -10,8 +10,6 @@
 #include <rtw_debug.h>
 #include <hal_btcoex.h>
 
-u32 GlobalDebugLevel = _drv_err_;
-
 #include <rtw_version.h>
 
 static void dump_4_regs(struct adapter *adapter, int offset)
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 2232a1014528..579724e8fc2f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,11 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#ifndef _RTL871X_DEBUG_C_
-	extern u32 GlobalDebugLevel;
-	extern u64 GlobalDebugComponents;
-#endif
-
 #define DRIVER_PREFIX "RTL8723BS: "
 
 void mac_reg_dump(struct adapter *adapter);
-- 
2.20.1

