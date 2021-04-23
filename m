Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E81369573
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbhDWPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbhDWPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA937C061346
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p10-20020a1c544a0000b02901387e17700fso1398829wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s3aOjnaH0Ilrmmwqcay2E1u5CZjfj+ZVEQps+YLx+tc=;
        b=AQYqASXOLdUk14/Ym3YL9Gi66w1svfIt+913AKyxEZOUziuFxKLTg0NRCrq1LRV8pn
         rNWzNuV1hssvTOexOADvFWnBBc4+eay6is7YacCU+Bd3+moFUdL5fjl5/6nOW03BEgYO
         UFnLv+MY6Xl8Avaga33Zh509BAGfJ6FuA0LXFuzacx2xbbtYHqNJSlN5+Td2oNez4sBj
         RrtXQncwYAIMMG15BSpIJpl9AT/u1T7QLlUGn7YjZ0VxUEQ4nMCgdZ6Pi3HAXERz/W3c
         vPPH1g4ByZT0qCOiyH3zNrbyw1PxuMOfEk081+Cff2KOKfR0RTWEOEnMkaDm7M73pDF2
         SURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3aOjnaH0Ilrmmwqcay2E1u5CZjfj+ZVEQps+YLx+tc=;
        b=Z82xaIdpQ3nbqMsh5ycOPP6eLOtLbHXTYRkB52NmsqjrpuiEftMC/bVCcCB6mrIEZp
         DdV2AxmQyQl4P6r5JUkoNTtggOk/TZjBlxyUBGX9djBEcVGfbGQMlsORpsPNrhP2cEoc
         1Las/piW764YUxUKLtPfPDkd+Kh6Sq70ZC0u4oD7FTCNe6i08zfUypHKnsHMlbLLRJZI
         9ez7WHTodUqh+KyAXNx7DDEFfwpEy4HlVMZs1/4tRWagz7Wa+PSuHGpUMttnVjERLF3U
         nYKzmkKQFCmGK3PtuzKfDhqmVpxugNbUt7hyLph3QKU1XCIPOlfRJgG+OF5PTK0m2ZJg
         JUMg==
X-Gm-Message-State: AOAM532WFqT8hg0GFYXdrxOMwwbpqvgcSkIn4CUGGJgppTYkOcHRWu87
        uX9Wn0v192klc3eGHInrQVchb8TKbyU=
X-Google-Smtp-Source: ABdhPJxUmXAPOTNkCFPDE3q+IM1Xe/qQQbyN2pCxmh/3D12oocB1VnS6shyrd308VW4Ql3XvEKPjpQ==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr6195750wmc.61.1619189986373;
        Fri, 23 Apr 2021 07:59:46 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id f24sm10996312wmb.32.2021.04.23.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 39/49] staging: rtl8723bs: remove unused debug macros tied to os_dep/osdep_service.c debug
Date:   Fri, 23 Apr 2021 16:58:30 +0200
Message-Id: <d65e708935a08e37c6001a90c108f8234aa28e54.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macros tied to
os_dep/osdep_service.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h    | 5 +----
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index c061d874f4e6..3e391a23ac8f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_osdep_service_c_			BIT(22)
 #define _module_mp_			BIT(23)
 #define _module_hci_ops_os_c_			BIT(24)
 #define _module_rtl871x_ioctl_os_c		BIT(25)
@@ -21,9 +20,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _OSDEP_SERVICE_C_
-	#define	_MODULE_DEFINE_	_module_osdep_service_c_
-#elif defined _HCI_OPS_OS_C_
+#if defined _HCI_OPS_OS_C_
 	#define	_MODULE_DEFINE_	_module_hci_ops_os_c_
 #elif defined _RTL871X_IOCTL_LINUX_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_os_c
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 9c6b1666df13..c58555a4012f 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -4,10 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-
-
-#define _OSDEP_SERVICE_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-- 
2.20.1

