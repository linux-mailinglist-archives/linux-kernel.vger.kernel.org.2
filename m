Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA936955E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbhDWPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbhDWO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AE9C06134D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so5956693wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FguT1SZP0JKjZXOwzC5Q0evIdGUpU5e+RgS1n8RdIQY=;
        b=XizceieGr+lZQkiEYSglATxkYs53eqB2jCWNtkqMlpjlIS8nPfXW37qtSyHhD+d07A
         rqRqZfG+/r8lrQE85ZnZn8ABneT4OgZvbfgB/GAz4xXqj4FnQhdc4wfJ0XgPddCfdyGH
         sS1HeA6SNlsUpPp2+09HodHkLxLMGkYwGcSGUfMX2vidtJTvyh3xsmwEFoQYma6iVBwd
         MIan33gkeKTYRd7hPZraUk5ANBfWC6araKuEuL7/IDBjGAMiZrWJOZvSl+YE+8IuRqlA
         6RF/b+R6+ADR1HRaoy4+n8NNwerUKXY3Xz3dSasps6oYFhrIWhJ+wDnEjWXnWeAVWnQl
         5gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FguT1SZP0JKjZXOwzC5Q0evIdGUpU5e+RgS1n8RdIQY=;
        b=QlfB8ti7ItV0HALR2QSyW5lwpu4P7Sgqw87yRmeABJlGbHm+XMFYjMWmWWFd2NcX11
         SJ6g9lhmRxVrBNzD/iu1c7o9cWPOi+EFKrig+I+2uugkaXLUFWaBGkQ4TuB8lGaHDcXr
         BubtmRa1tMe+I7O869GANjuD8opmC38kW9jDMArYKNTrC2bz9xRNDJJW+icw2rwoiiY7
         hGV7B1U5ox1uGbVQMmSaaBaekqlce5tHdbhgqAYndBIAdWvsuCl+eiIAIS29u60Nvagb
         dBacv/sWRyVpSQkQnAIWqpYbRQOzIdiXxyQHCrEYsGExUdCYLsdKYh9xDs4bMyWO85RK
         7Blw==
X-Gm-Message-State: AOAM532Ymwz3PqlvVWU4P/nXIl5f+gEhQ9tdUSoStPmyMZiujPeAa0Ya
        nyRToS5vyYY+ZqJpnoTMNcUxXIEaYPQ=
X-Google-Smtp-Source: ABdhPJy62ra9bW9RWJ2BE97mC9qDg1WxL6Q2xoYDrGEaylCIWFU64Ekk/ixcO8REJTW9IDhGWPgung==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4751244wmj.149.1619189957740;
        Fri, 23 Apr 2021 07:59:17 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id g5sm9629856wrq.30.2021.04.23.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 22/49] staging: rtl8723bs: remove debug macros related to core/rtw_cmd.c tracing
Date:   Fri, 23 Apr 2021 16:58:13 +0200
Message-Id: <66e96cb78538ec9a59cdeb5675f7df97a3ed9471.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_cmd.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index e1a8f8b47edd..75db4272e537 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_CMD_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_btcoex.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 76756f6aac99..bb56d38e6b7a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_cmd_c_			BIT(7)
 #define _module_cmd_osdep_c_		BIT(8)
 #define _module_rtl871x_io_c_				BIT(9)
 #define _module_io_osdep_c_		BIT(10)
@@ -36,9 +35,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_CMD_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_cmd_c_
-#elif defined _CMD_OSDEP_C_
+#if defined _CMD_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
 #elif defined _RTW_IO_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
-- 
2.20.1

