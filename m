Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4683B3A06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhFYALv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhFYAK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3365C0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o6so17426872qkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jF0ciViJNCkqQGUS+jF/CzwjS9y9brbrBnqJsg6Qwl8=;
        b=M6GlVwh2iL73oa3L5IQ60g8l8PdIEFyEDlvxUWEJw6QlM6vDhtug0CbRolSPUlZr0V
         uOYV/4UjvygaPfKWy970JSTv/hjhXSv+L1vZQ6H/8vkOFoet62WIgXAulaKGhkY8PLLY
         BRwa04yGvLa/ng7oCHbi2cnXhUPHcniwsI89m47YJQRKpkHGdv5cuvIQ3zW6lfFC6cgD
         EZHpqzhCuc6dtotSrD1TS4qRdz2ijhdSqKmjX4LpqGEQ0krhgsiCeDOlodVBmqCP+ptk
         DUr80uCBRKRRfrauJn1kvT1vunGNtC74zNTqzP27kkqDpQfq/bKRBhaJhus/xQ0bR4x3
         lFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jF0ciViJNCkqQGUS+jF/CzwjS9y9brbrBnqJsg6Qwl8=;
        b=PmxOfnSuapEH1hkRCZDBUjvpJTcb7mpZVmQSl0EDogWGvHmnNnI+s/I4x6sk5wIM7M
         jHFQWZWis58/p9YPoyvbonmFttzeMPNSFkpzZ//vFH3YMKRuarNcDApDuN7Ei5murQ4R
         u7xAwDWk53GhMNzXSewyaduVLLICjoJ1WgnSiL0VmlFn+qPa9uCG/P9cmKynVORDuaRP
         VD9H0BZTvBxd2Dih3MPHw6K9IZu1Rs5Ra1Lxu64x1pBwevzQAR+Or7iRJhc9eWQyrIu3
         kETOOJaSFccIeGGhvKiiZ3anON6sSEmENsljl6Q9WWYD15YkGhfrgdQ3o5fDH6WiKADp
         b7Yg==
X-Gm-Message-State: AOAM532GAx7FrTpBmmeMhuM58UNNSw6lo7H2nQ3xfi8WSOlW6BDJKblP
        JgAaWaH2c/BVubmPYXk9pfkMYw==
X-Google-Smtp-Source: ABdhPJzbF7295IHgoywGXjBc0ULcBLW2M2Jc6UfjXeo+YL/hEAsyb5g4U5CTHp7SANr0+i+0t9sufQ==
X-Received: by 2002:a05:620a:919:: with SMTP id v25mr8217187qkv.327.1624579715075;
        Thu, 24 Jun 2021 17:08:35 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:34 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 23/23] staging: rtl8188eu: remove include/rtw_debug.h header
Date:   Fri, 25 Jun 2021 01:07:56 +0100
Message-Id: <20210625000756.6313-24-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove include/rtw_debug.h header file, as this isn't used and gets
rid of the various other definitions we don't need. Also move the
DRIVERVERSION constant value directly to os_dep/os_intfs.c as it is
only used there anyway. This results in removal of more unnecessary code.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/include/drv_types.h |  1 -
 drivers/staging/rtl8188eu/include/rtw_debug.h | 57 -------------------
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    |  1 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  2 +-
 .../staging/rtl8188eu/os_dep/rtw_android.c    |  1 -
 5 files changed, 1 insertion(+), 61 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_debug.h

diff --git a/drivers/staging/rtl8188eu/include/drv_types.h b/drivers/staging/rtl8188eu/include/drv_types.h
index 4116051a9a65..3609a44ed078 100644
--- a/drivers/staging/rtl8188eu/include/drv_types.h
+++ b/drivers/staging/rtl8188eu/include/drv_types.h
@@ -34,7 +34,6 @@ struct qos_priv {
 };
 
 #include <rtw_mlme.h>
-#include <rtw_debug.h>
 #include <rtw_rf.h>
 #include <rtw_event.h>
 #include <rtw_led.h>
diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
deleted file mode 100644
index 0de6d7ba5d8b..000000000000
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __RTW_DEBUG_H__
-#define __RTW_DEBUG_H__
-
-#include <osdep_service.h>
-#include <drv_types.h>
-
-#define DRIVERVERSION	"v4.1.4_6773.20130222"
-#define _drv_always_			1
-#define _drv_emerg_			2
-#define _drv_alert_			3
-#define _drv_crit_			4
-#define _drv_err_			5
-#define	_drv_warning_			6
-#define _drv_notice_			7
-#define _drv_info_			8
-#define	_drv_debug_			9
-
-#define _module_rtl871x_xmit_c_		BIT(0)
-#define _module_xmit_osdep_c_		BIT(1)
-#define _module_rtl871x_recv_c_		BIT(2)
-#define _module_recv_osdep_c_		BIT(3)
-#define _module_rtl871x_mlme_c_		BIT(4)
-#define _module_mlme_osdep_c_		BIT(5)
-#define _module_rtl871x_sta_mgt_c_	BIT(6)
-#define _module_rtl871x_cmd_c_		BIT(7)
-#define _module_cmd_osdep_c_		BIT(8)
-#define _module_rtl871x_io_c_		BIT(9)
-#define _module_io_osdep_c_		BIT(10)
-#define _module_os_intfs_c_		BIT(11)
-#define _module_rtl871x_security_c_	BIT(12)
-#define _module_rtl871x_eeprom_c_	BIT(13)
-#define _module_hal_init_c_		BIT(14)
-#define _module_hci_hal_init_c_		BIT(15)
-#define _module_rtl871x_ioctl_c_	BIT(16)
-#define _module_rtl871x_ioctl_set_c_	BIT(17)
-#define _module_rtl871x_ioctl_query_c_	BIT(18)
-#define _module_rtl871x_pwrctrl_c_	BIT(19)
-#define _module_hci_intfs_c_		BIT(20)
-#define _module_hci_ops_c_		BIT(21)
-#define _module_osdep_service_c_	BIT(22)
-#define _module_mp_			BIT(23)
-#define _module_hci_ops_os_c_		BIT(24)
-#define _module_rtl871x_ioctl_os_c	BIT(25)
-#define _module_rtl8712_cmd_c_		BIT(26)
-#define	_module_rtl8192c_xmit_c_	BIT(27)
-#define _module_hal_xmit_c_		BIT(28)
-#define _module_efuse_			BIT(29)
-#define _module_rtl8712_recv_c_		BIT(30)
-#define _module_rtl8712_led_c_		BIT(31)
-
-#endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index c1e2f9829367..b958a8d882b0 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -11,7 +11,6 @@
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <wlan_bssdef.h>
-#include <rtw_debug.h>
 #include <wifi.h>
 #include <rtw_mlme.h>
 #include <rtw_mlme_ext.h>
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index da372936a64c..423c382e3d20 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -18,7 +18,7 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
 MODULE_AUTHOR("Realtek Semiconductor Corp.");
-MODULE_VERSION(DRIVERVERSION);
+MODULE_VERSION("v4.1.4_6773.20130222");
 MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
 
 #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index 298517530ed3..3c5446999686 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -10,7 +10,6 @@
 
 #include <rtw_android.h>
 #include <osdep_service.h>
-#include <rtw_debug.h>
 #include <rtw_ioctl_set.h>
 
 static const char *android_wifi_cmd_str[ANDROID_WIFI_CMD_MAX] = {
-- 
2.31.1

