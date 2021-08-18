Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8629C3EF80B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhHRCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:24:22 -0400
Received: from mx21.baidu.com ([220.181.3.85]:41580 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233380AbhHRCYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:24:20 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id 52F56337AEB4FC5E2F52;
        Wed, 18 Aug 2021 10:23:29 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 18 Aug 2021 10:23:28 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 18 Aug 2021 10:23:28 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <straube.linux@gmail.com>, <dan.carpenter@oracle.com>,
        <greg@kroah.com>, <yangyingliang@huawei.com>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] staging: r8188eu: Remove unused including <linux/version.h>
Date:   Wed, 18 Aug 2021 10:23:21 +0800
Message-ID: <20210818022321.2395-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove including <linux/version.h> that don't need it
based on staging-next

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 1 -
 drivers/staging/r8188eu/os_dep/rtw_android.c | 1 -
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d5ef5783f4ad..82b74ebdaabd 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -3,7 +3,6 @@
 
 #define _RTW_MLME_C_
 
-#include <linux/version.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index f4bf4732578a..aef978eef4d7 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -12,7 +12,6 @@
 
 #include "../include/usb_osintf.h"
 #include "../include/rtw_br_ext.h"
-#include <linux/version.h>
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index bdd381606ba6..af0072e2cb5f 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -3,7 +3,6 @@
 
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/version.h>
 #include "../include/rtw_android.h"
 #include "../include/osdep_service.h"
 #include "../include/rtw_debug.h"
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 4f1ce346b3a5..69966c696130 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -3,7 +3,6 @@
 
 #define _XMIT_OSDEP_C_
 
-#include <linux/version.h>
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/if_ether.h"
-- 
2.22.0

