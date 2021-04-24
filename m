Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F2136A05D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhDXJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhDXJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C5C061343
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e7so41703227wrs.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TBgmlQX5j7/Q4T3HKXp2yybKM0tyr8DeALWegqbME4=;
        b=TaUYxEsQ/sfJ/xRQfIc+NpGeUV6i4vRbQ5ssasLvZZZMlo3mHXGj+kkQa8oypVUCuO
         o4+W6rx4wDaaAm2kvE4XL6wTd9JTUkHNEI2qIHTBQ9VCOOGbFI5dnOWY0/QXU37ivDtc
         Z81z8ksgcqfqW0GyvxIxdC8xMNieWxTCFLuYkL+iJ0mRFyN58qsPYnf+e7G05sknPItw
         t8L6Nrqs6kzOkGessDifO0AgRkI0lRUJutMwZyuTNcWG0I1muJ5VbC+i03LLPhaicf5m
         bQYZgRPDepjQf55fnDm+7iYwSKHmi7Qi3qne2eoLmz5rhfmRpKZqYbQUFnlQB4zZI3L+
         cUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TBgmlQX5j7/Q4T3HKXp2yybKM0tyr8DeALWegqbME4=;
        b=PU9MSbPMuOCeJK8t1mXNfKq/SPC/r43+JvHevcFTHQV+YbJfQaAyfYwyvK6XeKsgHc
         exaIveX0sUXw6gtDHAFUNbDdTUPb0y8hwl7LQqkWW6qLrjhlCBi0ysEebEtvaxt/nKWS
         PcXf/GdFQMIZBwGULwVz3WomgRZcly8h4OTRRYsxbBqNMo29DwgTVhs78fKduBL5TOdD
         /QiTCJ/FAh0JJuMdlTcyZjJLObkR5yGG13GicuKZzh+sK7o2kh0lTcm5RCAWax3oeAe0
         oPDc0nWZBXeHcCyoAUgZyvFfuZbpF43TG3vHmWuY4gdvC++61lOF+IYzdml9+5WPSaNV
         pUVw==
X-Gm-Message-State: AOAM53091XuS7tR4X/W9Wc58Gvtz5YPpwpa+yXNIKXVJ4aR1yge1nuH2
        MKU39GLw8eBETqlQ2XKsx8dt81aPqMyY+w==
X-Google-Smtp-Source: ABdhPJwEPEqN9zbkWaBBYfyyw6393SACQcZl7tHABTj7l5sCA1+qkZ+WkpwxN6dXl1EfdLUGr3165w==
X-Received: by 2002:a5d:6ac6:: with SMTP id u6mr9844193wrw.290.1619255005986;
        Sat, 24 Apr 2021 02:03:25 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id r11sm12137861wrx.22.2021.04.24.02.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/50] staging: rtl8723bs: remove debug macros related to hal/hal_intf.c tracing
Date:   Sat, 24 Apr 2021 11:02:13 +0200
Message-Id: <7f64d5d78b42874364f24a2fb11f664ad9988d99.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to hal/hal_intf.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 3 ---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 8dc4dd8c6d4c..4868a69cdb8f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -4,9 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-
-#define _HAL_INTF_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 8a4ee840434e..4da881e3a0c0 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hal_init_c_		BIT(14)
 #define _module_hci_hal_init_c_		BIT(15)
 #define _module_rtl871x_ioctl_c_		BIT(16)
 #define _module_rtl871x_ioctl_set_c_		BIT(17)
@@ -29,9 +28,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HAL_INTF_C_
-	#define	_MODULE_DEFINE_	_module_hal_init_c_
-#elif (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
+#if (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
 	#define	_MODULE_DEFINE_	_module_hci_hal_init_c_
 #elif defined _RTL871X_IOCTL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
-- 
2.20.1

