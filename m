Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40C36956D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbhDWPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243244AbhDWPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95BBC061345
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n4-20020a05600c4f84b029013151278decso1399469wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXZjzbZRHK0jBwgvuHcL9uMISPcQ6vFSZC1gma0GKcY=;
        b=rOBdAoE3zso+Tc92VqoqOnE7f9NdI+SCp31UCmeWL5KyTdG2VOwcoBPT7dvolJTN9h
         0o6HTRIPUIc4JXJK3U+ovZpO5UbpOqTMxZF8gCAzTKZd69VormYa3tix67/k4Pi1EHko
         /B202K+cQjNWB/VLIieBz3mWazDCbiO3j6DpTbE52ITVnOGAGhZTaZ7pNRayiDx93RXU
         BZ0Z6v6dtinDIjaYrRSEUNyY8fhjpUsKZs3ioAE3/9uo/DdwlqjOmJYH+u+nB7ef6wxU
         6ty10kdfS46CRcFe6pgvNlCFaYPj1gtoDTcKQFsw38fMXQSMEmAXlTdjWJbMX/uFh/N2
         ZA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXZjzbZRHK0jBwgvuHcL9uMISPcQ6vFSZC1gma0GKcY=;
        b=QZAJFThZU8avzAO0kfioPWTKH77xZMA2AIPUV41/4EobwLmd/WrsWlWbIi5JoHV13t
         1XBB+Y7eQJ3J+CgKjiK3+BfzOIZs19CVWjZscx9nSNI59j6Sbuxz031txrVKAd7/o8Jz
         GY2yDbUor18PJMI/7kU3KYtNAPaajrTWIrQZ3gRO2ogpMcclHp20arj3FHBi0MxGXFPu
         P0l+IFUzbooHo72Y6tMiNrnnL3a0EblOi9XMvQtv9/wO6Bo7O26ly+aBQ95pilO3lDpe
         9WVmJF7SfVrpcbVoZFfy6O/KoTGMn6bGN2DmWHRgGe9xa4LE5NZ0u2UcuOdIF7vyHthv
         8vSw==
X-Gm-Message-State: AOAM531GOSDBgGB8QcZ9hdlXdrEPWLabfzV+KlcZ5ayG/j3kXXy0LwCw
        OWj69V9v5tBkgfSH8kpWPFVDTIvdVEM=
X-Google-Smtp-Source: ABdhPJwgg8zwbBNKGLU8zdTwt1S/UQPkwMZAUlC2/2Qkz0ZhTfTeO5IhAjJsQFm4yT9Moqzx90Hhdw==
X-Received: by 2002:a05:600c:4fd4:: with SMTP id o20mr6203003wmq.166.1619189981258;
        Fri, 23 Apr 2021 07:59:41 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id 200sm8469131wmb.1.2021.04.23.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 36/49] staging: rtl8723bs: remove unused macros tied to os_dep/sdio_intf.c debug
Date:   Fri, 23 Apr 2021 16:58:27 +0200
Message-Id: <5129ca34b24f01f93f1e8315aba65eabfda628a6.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro definitions tied to
os_dep/sdio_intf.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 7 +------
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 2 --
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index a7f6827c282f..130cfe3d2032 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hci_intfs_c_			BIT(20)
 #define _module_hci_ops_c_			BIT(21)
 #define _module_osdep_service_c_			BIT(22)
 #define _module_mp_			BIT(23)
@@ -23,14 +22,10 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HCI_INTF_C_
-	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
-#elif defined _HCI_OPS_C_
+#if defined _HCI_OPS_C_
 	#define	_MODULE_DEFINE_	_module_hci_ops_c_
 #elif defined _SDIO_OPS_C_
 	#define	_MODULE_DEFINE_ 1
-#elif defined _OSDEP_HCI_INTF_C_
-	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
 #elif defined _OSDEP_SERVICE_C_
 	#define	_MODULE_DEFINE_	_module_osdep_service_c_
 #elif defined _HCI_OPS_OS_C_
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index d2bf444117b8..5e484344e172 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _HCI_INTF_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_btcoex.h>
-- 
2.20.1

