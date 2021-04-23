Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFDD369550
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbhDWPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbhDWO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEA2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w186so21668646wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WnmT7CRdJ9xoYI2NiEVYpV5jw3qtqeREXJaneN7WYA=;
        b=CozGHQQ0pDA4kYsLZpxCzQlUG1i9RqE3x1kZqtSviPqZIKeD2adGBJK228zBcQQli4
         DYVXaEXpaT6yN8yjvJVMR6rQ+mA0x1MYACLEW0nEsMUR1+lHsLKW7id7S1kSfk6nx7D8
         swYuWfFWAsRhzp7u812UzNQamS+4lmET2/HEU4eHP1+L9MWX86vHVZUZeqqiWU03EXQL
         76m7qZy0+sCv70DnbH4or82t420X26rcB7nYgl2T37IHpP8a68gDN9QOop2jy+9PEpJr
         I2kEaLs3evSjcIwmPwjlZzzC+Dk5HJfr0Wkr+kwiWonvosOwiYwz5ztFDJWdFWOo4QvF
         UWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WnmT7CRdJ9xoYI2NiEVYpV5jw3qtqeREXJaneN7WYA=;
        b=mvts+ep34i56Jwo2NxFCGen8vp2Cx6OVtI7101pe50PMsP+3ALdhrvkVOVaVqvm/hv
         KXrNiV2ObQ1uouC6/jxRKfz0EMB+OvjpxhU6tFiW2gCDkcywGUmeMuOkfFxD5RrTdcZw
         vNZXI303VF2iNWO0Pdf1bfJMwijt5Nj7WavxlSyEjE5uIh/o9BBuSTQTqF45R3/K4Jak
         kKhCTGskN066TY99dxnyvWPeNsxmwb7Z/FX3U1FO/Xwc+L2fm7oNVff1TbcfWqJEf4f1
         Z2Baqa8OIRMhofsTLZk8JV37ol5UJ18WDye2BKuMFaL5s0Y/GJaNOFWcFl3LIQiVBisB
         PESA==
X-Gm-Message-State: AOAM531pbTIbGYH3IDLwUnsAQWD3uelzEZwJiEtFJBp3PRuST+X8LPs9
        Ln/8nzqfzwlNl9cVapNIpf0SeEUM7wM=
X-Google-Smtp-Source: ABdhPJz1rE/xcMsV5gDMqx4CjdNJOo/kmmQ9YovszNJWIHZrdvlBRsFlFNFIBDz/TfBE86p17+fDzg==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr4719982wmj.53.1619189945024;
        Fri, 23 Apr 2021 07:59:05 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id y125sm8257692wmc.40.2021.04.23.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/49] staging: rtl8723bs: remove debug macros related to os_dep/xmit_linux.c tracing
Date:   Fri, 23 Apr 2021 16:58:05 +0200
Message-Id: <343f21e1c00590b8f1e17756bd18f1ffe8aaee6e.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macros definitions related to os_dep/xmit_linux.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index ea4d34678b9c..6403a11d712d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
 #define _module_recv_osdep_c_		BIT(3)
 #define _module_rtl871x_mlme_c_		BIT(4)
@@ -42,9 +41,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _XMIT_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_xmit_osdep_c_
-#elif defined _RTW_RECV_C_
+#if defined _RTW_RECV_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_recv_c_
 #elif defined _RECV_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_recv_osdep_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 639408eaf4df..6b039c1d8d57 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _XMIT_OSDEP_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-- 
2.20.1

