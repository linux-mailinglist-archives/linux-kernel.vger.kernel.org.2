Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05B2369563
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhDWPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhDWPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F0EC06138B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1398278wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBXgom8pS+5mm5WMa0UlEBGsguBg4pdjqj4B4/2efgY=;
        b=o1ELdjLkxB0K+1MEa5ylb/8OmIKzDiujaVFlDr0VWM5o7BKeJZmqmrMacQm+f/6IMU
         a5f3O/MYf6MlmzKcKV2KbILfBjDjzl68m0Ih9TUt77a/ACSLlY/pxyW+MS4MnyoUI3L2
         usQ/riggv0CPr/rUKf29zlQX8NJSPztqqdsEzwxAa17EhBCoiisrwy4bn77Jh+dxfhp8
         HVMsVyGzCKrUfWXDO/kdmCGay69G+gQTNopekqxkjJdkNRLxGulDcyO1Z+HpP9Ns6aOk
         J8zB/P8ehtw5oNGucfX/0hBoZKYfI5VMw6hvOrftZqcuy+IDfmqmQdOn+HG4k0X4lnvl
         zCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBXgom8pS+5mm5WMa0UlEBGsguBg4pdjqj4B4/2efgY=;
        b=NeE9b/OfSJFsuvvau51pYPMZOpMcGpHk2y3zkIrGT+Ov7/bkr7BGsOkoqBjS07i512
         HUVjcJelkRa3yD5gsGjoQItBMVg/rWceY5Xc2hclLeOR2Ik+VB1xvuKZVV/nc9nh14TT
         NOetzG4lC/sDguKxXpavr/r34moFY91N9pGjFoxGTld6BIPR+4t7MXtprqvDssXtpa4L
         6KAVx/pof31GLmX+uhegswuCYuzE5huXoFJksCq+apJC/2uLpEmDCnFVVE7DOuN60Q+m
         uCWQFVr8bqyf0D7to2vvRTr8qqhk6THEr9SjOYYEIGOzbwunsqATamjG53W0DZEeoVs4
         emgg==
X-Gm-Message-State: AOAM5300oL+LYUnkEOpybwpH4i8GSLR9lz8VPS4ycfb5qyF5GgDc64bM
        wfC+90+joe+e8Gr4cnpBN/+/AcvVzNk=
X-Google-Smtp-Source: ABdhPJypgvPAgl87/yKUbKzFDh17oBiT8a2mmYa1S796aH8FOq8t1yz87D2lyAwDh9m7SDg472PAew==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr6110033wmk.118.1619189966405;
        Fri, 23 Apr 2021 07:59:26 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id h63sm8275068wmh.13.2021.04.23.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 27/49] staging: rtl8723bs: remove debug macros related to core/rtw_security.c tracing
Date:   Fri, 23 Apr 2021 16:58:18 +0200
Message-Id: <519837f8c81715e28cfb5e82981fa069dae4b10a.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_security.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 7823055ed32d..43422e8ad578 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define  _RTW_SECURITY_C_
-
 #include <linux/crc32poly.h>
 #include <drv_types.h>
 #include <rtw_debug.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index f7c2d9ac3a61..70bfe24d9e0c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_security_c_		BIT(12)
 #define _module_rtl871x_eeprom_c_			BIT(13)
 #define _module_hal_init_c_		BIT(14)
 #define _module_hci_hal_init_c_		BIT(15)
@@ -31,9 +30,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_SECURITY_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_security_c_
-#elif defined _RTW_EEPROM_C_
+#if defined _RTW_EEPROM_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_eeprom_c_
 #elif defined _HAL_INTF_C_
 	#define	_MODULE_DEFINE_	_module_hal_init_c_
-- 
2.20.1

