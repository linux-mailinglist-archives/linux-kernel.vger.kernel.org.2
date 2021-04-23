Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8D369564
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbhDWPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbhDWPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F877C06134E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so48726265wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWbAJszKoLy8l9tAL4imgVyw3i2GGpSRBC2wgrevcm0=;
        b=F2ipSsp3lpDqsgV5x+7AtT8/UDYfTdQDEZaxy+s7yudYw8AHX1lysH2hFS0Jqlo7jM
         FzfxtgmBUWAF2nyEDpzLwsyNHCdW0Bc3mL0VzwkjjtgbczUFVE6lFFcV+F4QRB7iW3sz
         k8Me4OsyUlEQKp4la00Kq59X0dhOhRCiZPCUGG7dGo3bczK+briVyCzChz5XlfVvC6Qp
         JzT7/sEvyXMDbBZeu+6xJzu40p+LyTlXtvG22yvXZa6848MrOmAg0W2Hi3OgU2hwDhgx
         brZwofySIuJi/ORK80GgKYkZVh0g3TMUFWNnXCvLYVPk+gJggB4990YrGAxT+wIn38SE
         izPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWbAJszKoLy8l9tAL4imgVyw3i2GGpSRBC2wgrevcm0=;
        b=OnUmO/T4CX4xx0dGp8iudXG8zdFithQXDerA78CyeHrO6nus0FwKr0TnXRMsMlVQvB
         SOOi+Unj4DXKPvEP8f5E3XvEQgYW7GZA0h3lpB/l9OYm2CThvgqAF+zhcV3OcYIpRumk
         6RVQWgGVyTbOEMalhn5GonBzRDIi/lTajXEySpDsUdZGLSl5z2edFIWkQ+/2+Qs6Hf9X
         p2+aGlxFE+WQKH3P4Vu9hGuUujhTmsSu2uUyhAOy5Mwwdm8P5D+++247P88S5GddJ1aN
         kRC7vx0q4CjEGAWTXx3q5QOVgxYOLRcGiWh56uMGuAsYwSX1xQisidV3+btZfixNQzmL
         3uuw==
X-Gm-Message-State: AOAM532EqqSaNwGG3dLVNYnSv/U4I6UBuzS1/FFSFg/pN8W1iGD18mgr
        oMtPrBZcnqu9qWBi8OlcVP9StVZ05/M=
X-Google-Smtp-Source: ABdhPJzwIpw6EFjOGmu206g9N4dVqBJ8Vv8q8Lrfr4XlfRSJUErGY9KXL70Q2K9yMM/3Hq0g0tXbFg==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr5285075wrx.224.1619189968100;
        Fri, 23 Apr 2021 07:59:28 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id b15sm9520223wrt.57.2021.04.23.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 28/49] staging: rtl8723bs: remove debug macros related to core/rtw_eeprom.c tracing
Date:   Fri, 23 Apr 2021 16:58:19 +0200
Message-Id: <20f87136d548f61c8656f46a4374d48b08d0c482.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
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

