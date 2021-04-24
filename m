Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E136A067
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhDXJG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbhDXJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A1C061343
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y204so25850034wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+j7lRegxzNVtgM/b7Sy9jh8N/GGtG6h5FSr8oPr7oJ4=;
        b=AmegM7WpdiB9uQXPyuLESgLq0eoi5QDNqnrY0RgFXEh/ixUvrl4DALVg1Xv8uZnwiG
         xdEg7IBQowIKtXxmD05k2OmvFttjQxyyjH/5eTXd0UlIB4Q/ROMBtNUsUZe6HlLWCKKZ
         BZfbUZGvHGEwyp6jnrbdy3W7zSBkrlrJa9lOcoZwIfg6Pjr8d1PYkzZiLH76pggQxG6W
         qbpORSMlhNyFvTVKVVWh1aI6bRAfyvAUYh8zJOcnkdQ5TlxbZK74ijx7Wh8bX6PitcQv
         LjzJajy3RmVDgRVbAk/yL9lLJ+t6mds4TkI2JT4rPippbeOUYma8jlj78TkJ8NnA/6Lo
         BDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+j7lRegxzNVtgM/b7Sy9jh8N/GGtG6h5FSr8oPr7oJ4=;
        b=CslOT5P4+hdgU67InQz+O4GAQqeNpKmaaAg0gWkDPYJR9aNxkqCTFMLELuit4QNPQD
         WYdNF61V4dbcpqOncpT8gSdweGIeguCbIiFRs5NQ2gAx+iBHQPjsAm/5jmdQ5Dbmk8zM
         DKhTNJQr4keUKqZIRvK3+tuAV6JO1V+W61lRCwLavSHeCcGbyNyNpgoU2YbYA6eWT9Jc
         CT/QsTxOlS5DC/KeyD+2Dz2UXRVMdhQ+zn9x6ypQRf4N8vVIUAbN+gpLL2A7+k7Z9NZS
         RuG+kyYCSbGqnmgAOBClH1L7C8fXWuub+QeGJD7QDKL90ACkFTECeF/TOn6xidtWCTdE
         BQLQ==
X-Gm-Message-State: AOAM533vNsKlr9XcGW8C2/tYLctQoLQcHJDEfU1mEHsfN8IIs4evAXwR
        PG4himeQsG1eOLlgbl/FayzH9wCgyvyIyw==
X-Google-Smtp-Source: ABdhPJyCf7mfk7ZULqJXL41/SE7O6+bx1p/RmaVb773sZ8angkD0NChFVkDRjS9zNfz6rAg9IlsBYQ==
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr9599610wmk.55.1619255020961;
        Sat, 24 Apr 2021 02:03:40 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id o4sm13855637wrn.81.2021.04.24.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/50] staging: rtl8723bs: remove unused debug macros tied to hal/sdio_ops.c debug
Date:   Sat, 24 Apr 2021 11:02:22 +0200
Message-Id: <8f3acec03ecd9ece6d60404520a9ac188f718a55.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
hal/sdio_ops.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a31694525bc1..b5434ab71578 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  *******************************************************************************/
-#define _SDIO_OPS_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 3becb1b8d15e..c061d874f4e6 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -21,9 +21,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _SDIO_OPS_C_
-	#define	_MODULE_DEFINE_ 1
-#elif defined _OSDEP_SERVICE_C_
+#if defined _OSDEP_SERVICE_C_
 	#define	_MODULE_DEFINE_	_module_osdep_service_c_
 #elif defined _HCI_OPS_OS_C_
 	#define	_MODULE_DEFINE_	_module_hci_ops_os_c_
-- 
2.20.1

