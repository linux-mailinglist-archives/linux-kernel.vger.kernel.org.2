Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE01B36A04E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhDXJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbhDXJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE48AC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so38681460wrm.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WnmT7CRdJ9xoYI2NiEVYpV5jw3qtqeREXJaneN7WYA=;
        b=KpsHIHX4/w+ZM+DMjOEORZEQyZWl2j+AQ8IqD65PHex2LkWsxK+zrA0bsJEw5Z2BpT
         USot9AZmmVf8KUpceLXfBj06uSh59uN14nhVV/Wmyxmwb7n9vBCmL9j68YNLsaCxn7aC
         /Fup48Jzgt24YyY28lXVTxiOe9sSEk38axExiJeeSV15KxYCcSAE7A3CZAp/fzl87axi
         Pup4cTalI+OMEqxKkq31e93QWefuL6gQ+NiOS+JGu40iVrUByBzvDkKvktvAz7x3P3gD
         eKDfzIXSiy+ntnOpqNqYqT1Cf6Z59e+zhNjxsdNW0oKiN2sgkUPb8XLb5+VUQcUrlcrG
         PzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WnmT7CRdJ9xoYI2NiEVYpV5jw3qtqeREXJaneN7WYA=;
        b=p+Y64P532mcoegwEilZa72Syy9J/vt+DSb69iOMLa3wFmesrGhAVO/PUArsS3lYIz7
         JkWMIBkRm1Fz5YF7CCdG/p0oYPupOAhg6RptdB0W/f4lTiapOgsUp8BtSXG+tCQPubSa
         +wzFU5Bs7uVkahiPwuzqKKSqsad5gdB2/zc/Ojo4Mw9NaWNLe78mWNM6VSi7xfQp7+Xg
         SS4u68/peduTWExv3vFmKdFquG/i28tU064enqBaRWzIsV9hfxU0KjrZZBhXxww685b0
         5nJLFk55AHBC9AgRtC3bXDaI6vPBNy2uu+p9jBXbEJTHANRiQ1djtWMNtR5EVt6LNmxh
         nXoA==
X-Gm-Message-State: AOAM532PGPsPREBgQzD4XKZgwvoKhCFRC2pFzmBinOqk6gyiT0W3eiNH
        N9myvI/npu1V1cmS5AJ8eltbsZo/gzcxgg==
X-Google-Smtp-Source: ABdhPJxB7WEqErTgUegtKyrBW7jW7gUmau0WW1NrARONyi3Puqce1ZxeSkJNaMA8tcXJaFIt4XJapA==
X-Received: by 2002:a5d:5041:: with SMTP id h1mr9882692wrt.100.1619254980484;
        Sat, 24 Apr 2021 02:03:00 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id u14sm11659514wrq.65.2021.04.24.02.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/50] staging: rtl8723bs: remove debug macros related to os_dep/xmit_linux.c tracing
Date:   Sat, 24 Apr 2021 11:01:58 +0200
Message-Id: <ab5984670fac9e534b08ae043ddb7cd63ce60450.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macros definitions related to os_dep/xmit_linux.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index ea4d34678b9c..6403a11d712d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
 #define _module_recv_osdep_c_		BIT(3)
 #define _module_rtl871x_mlme_c_		BIT(4)
@@ -42,9 +41,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _XMIT_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_xmit_osdep_c_
-#elif defined _RTW_RECV_C_
+#if defined _RTW_RECV_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_recv_c_
 #elif defined _RECV_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_recv_osdep_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 639408eaf4df..6b039c1d8d57 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _XMIT_OSDEP_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-- 
2.20.1

