Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B59C36A065
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhDXJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbhDXJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B5C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso2405657wmq.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXZjzbZRHK0jBwgvuHcL9uMISPcQ6vFSZC1gma0GKcY=;
        b=m9ejbXoq1pZSwxAy1mGCIAKw+isLFXXWAMLFd7W3QzRjylEdgeST5bhij4N3eKHMQT
         c3thpa0ftjIaDPyOKQZcv+heFI/scMkANkQsNGywWKgerk65Trq0hj5Y3A3dpsmepMJW
         x5VIcJYgtIwaGOeoEDQCqeBSN41sirIfqnTCa8kRk2vHEX1Q/PwdXnHL/0OYMf4yQOdQ
         BH3EWIrTFx3dsMael8kP1K3JKNPHKw3z+IvkxHuiJ3J6JPxnPhcfc0bkx6eZrUIz/ChR
         HtpeQeuNW9xB3xzrsLlv39f4Fq3JYJTGQqnfkQJYFP/3+0IY9hDCR3e9zZsvrwNb3JVo
         KMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXZjzbZRHK0jBwgvuHcL9uMISPcQ6vFSZC1gma0GKcY=;
        b=IhGUVMypH90sL5RtCbAXR05LjAp2hGryI9wRtf++Y6jeyYABU1+OMZUnsbLJMVAkfA
         6hISD9IL65Ol6eVn2q+ov9+oPVJ6RVfYpxRHnGXntUqP3SlXJEvhWtQRZOlLpg6Iz8jq
         yscmKm24HYd/xvCflFs5m2p6k202HXlb9M0NGciB3aK1bH4JViS4XfvqvWp84BDCsyS6
         qNir+B/N4O76MwiOrrHKSYNn7dKMck8wuXrruCqk/K3zd+R3XyS/wHucJ1W3BLXQY/rl
         YbYpcChXOO+/y0WbLGl6cMAVp9e4uROksxlwg1NS2k02YHgt7mQIKqt620L6wUraXmF8
         zGmA==
X-Gm-Message-State: AOAM533C0BGzwZARPMXOLFKJ8ojdWDXeSHhl0iXiCfRnp3KATrY6UYiH
        swn5pYsRL+X5rOmfutlli3rOPG8kMT8hKA==
X-Google-Smtp-Source: ABdhPJzZPR/KeuLiEkeh29Yfx4ZhLnT0exnBNP1+ODn7DzoXlg7AaZEma+1kYJqq9lRljT+aZTw/Uw==
X-Received: by 2002:a05:600c:2141:: with SMTP id v1mr8441341wml.22.1619255017605;
        Sat, 24 Apr 2021 02:03:37 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id 3sm189593wms.30.2021.04.24.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/50] staging: rtl8723bs: remove unused macros tied to os_dep/sdio_intf.c debug
Date:   Sat, 24 Apr 2021 11:02:20 +0200
Message-Id: <c6f3a9d8eb1d868c869b0e37753cf7cfe15bad91.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
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

