Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD73236A05E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhDXJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhDXJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A620C061342
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e7so41703167wrs.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWbAJszKoLy8l9tAL4imgVyw3i2GGpSRBC2wgrevcm0=;
        b=cY5w0nII7OZZH+6EfBm4RhqYdQMMIufgCanME1upICTTbdm92/jkcL1TyyxzX7k+WU
         0XDOIOoXUWOjNuk7s7veDoQ0+HKlYp91n8ELgK9jaaxpnteMEzgileEYy/ZVYBPIjOkQ
         MVuowDHFvWG+7pdqtNyyQ2epDTbhcTXGwrQCtgXaUClCGsC/F030d0uxx28gdlaj7y5k
         8Z7bkgKdY3Ux3bl2Ed8vSl6wNqr3Ib87r3T6KYaxgArZ/LNYWgj/EOlnRevqtABjMWCF
         PSSb0u/XaM6uz5Tc8qB9ki88m1f8PsazfNpFmhLivuENgMJiECjviwHV+H9kCHRIi2am
         D2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWbAJszKoLy8l9tAL4imgVyw3i2GGpSRBC2wgrevcm0=;
        b=Cpq2cikBGYng5urG5iRY1+PqidCWu/CpJj66tUM7PsGNzBwGkf2qDBX6TdgM1o50hm
         eZTMV5bETQITLJKCkBY2kM3nY2okNQ6Bd0RSZQXmrWBK2soLSj6FOSXxWVBD+Soolzb8
         kJ0uWATCqmxj7HVse1AXjDAp+4i3uKgfwrRQta+90YP+MFCJGCaW01et5WJCv20oZ71o
         MGNniAEE5Hw/HEmKCxB1n3j8RyOHUJHtxGYuK5OhAEoUqqf8yaexefe60owduL51RNck
         8vRpskn+MI8wuasuUHhwPVIcRp4njrBm6JYXud8v0sl+yvNdA26uk4VR53dj07xZq3X/
         M8DA==
X-Gm-Message-State: AOAM531WQk2vhfHD+PnYfuAtVBMl7b3/Vjm+ZtgFEX31rh7LM1YNfjjw
        zTzMuPKDiiLBujtBRc20pRmVhymE6q1fhw==
X-Google-Smtp-Source: ABdhPJwO+9v5u8Jc5wlgqMjWOkNXmDTE5iBHQt2okYI++VCUXZJXRR6Kgv2DHxTEtIZ6U4Vj5aQK2A==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr9864459wru.163.1619255004251;
        Sat, 24 Apr 2021 02:03:24 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id t63sm10090413wma.20.2021.04.24.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/50] staging: rtl8723bs: remove debug macros related to core/rtw_eeprom.c tracing
Date:   Sat, 24 Apr 2021 11:02:12 +0200
Message-Id: <d11884043d17db211793e35e9d07a570951110e8.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_eeprom.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_eeprom.c   | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
index be0eda1604d0..4dcee4d2e513 100644
--- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
+++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_EEPROM_C_
-
 #include <drv_conf.h>
 #include <osdep_service.h>
 #include <drv_types.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 70bfe24d9e0c..8a4ee840434e 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_eeprom_c_			BIT(13)
 #define _module_hal_init_c_		BIT(14)
 #define _module_hci_hal_init_c_		BIT(15)
 #define _module_rtl871x_ioctl_c_		BIT(16)
@@ -30,9 +29,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_EEPROM_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_eeprom_c_
-#elif defined _HAL_INTF_C_
+#if defined _HAL_INTF_C_
 	#define	_MODULE_DEFINE_	_module_hal_init_c_
 #elif (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
 	#define	_MODULE_DEFINE_	_module_hci_hal_init_c_
-- 
2.20.1

