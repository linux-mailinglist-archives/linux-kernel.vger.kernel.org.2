Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48479369567
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbhDWPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbhDWPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79BC061357
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so36708392wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3UavRC9eYgkj+4cOfjLIrmnA6AzYdpwCwf/ShfW9hQ=;
        b=kTOsVHOq1s5zMJFF4mVaYw8YWClsd1EVdE2bXGU1IcITD4jLQd1mTvndPJIFMHLNGz
         TRBRZHYvPL5jgl6ED3bjqIH/4PhZWTBY0VRDFg7WKzBFRKb4Xe/Zeqx27e4nAv6m4BMR
         24u4VAt0wGonPjGjacH7UAnvaD3or3dWX61spM6ws2fERW+zZ03C+p6FU/6sC0olwPKi
         S3QJ/AdvX16fh3Y9U27EVB5/IPzxkn3K4NI23EF+iWoOg2LfK+QpU1w8IntobW0QOyhq
         IAL8NZlXxEMVgGElLyUWvftmt9VRvkAOptx/57r1elnvBh38A7mciQnu9A6iVat0FXn3
         kYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3UavRC9eYgkj+4cOfjLIrmnA6AzYdpwCwf/ShfW9hQ=;
        b=r66u6QTJauOcUIfcIlwwx68STK7/SLepS7X/ghkWkPJnu4GvBQoON3c1jt40yP77QC
         lrCGdk8qQY6e/A+wGhj1UwPgtz5EuivXx6Y8aZDFUUlep+/NRTEdCSwxPcdO4wemA++X
         vVnJF09Hrr0Zh3Fbu318LdSYhJqxNXY03Fu5dOB82rOX4Fui/5AlvSVX0RS1FIFcQ1Or
         WyuVBorPr7gf07MN6xR1JdIlYKw5cmfRAXkUtxnws4W+Dm00OMmgqXQB5WBkjiyy9z8X
         9tKdYKgYmlrC6RrxWAhr8ir47hAgcwGWe6rPG+v3WFfX+sGkEI6jo/pKg3Sj0PiG9DKz
         oCsA==
X-Gm-Message-State: AOAM530nGFagBajepZLL46/TUpI1uvHRnsZCG+lMPUAxQaRsKjMLFWUr
        /vydZFpfscnPgwgYBqbSplxlSjzj6Gw=
X-Google-Smtp-Source: ABdhPJzXdI+q3OKBxStBphCjYlWUJ0mG15YP3Ll/nzYNCy/kg1r7dCEVh+jW4a9KqbSTBAueNvLyuQ==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr5361300wrb.234.1619189972838;
        Fri, 23 Apr 2021 07:59:32 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id 3sm13304464wma.45.2021.04.23.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 31/49] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_C_ definition
Date:   Fri, 23 Apr 2021 16:58:22 +0200
Message-Id: <ad84cfbc3722fd2124c4a610b3bc7c7113b8b60d.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused private debug macros tied to
_RTL871X_IOCTL_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 4146acb1cbb2..501155c8c9cf 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_c_		BIT(16)
 #define _module_rtl871x_ioctl_set_c_		BIT(17)
 #define _module_rtl871x_ioctl_query_c_	BIT(18)
 #define _module_rtl871x_pwrctrl_c_			BIT(19)
@@ -27,9 +26,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
-#elif defined _RTL871X_IOCTL_SET_C_
+#if defined _RTL871X_IOCTL_SET_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
 #elif defined _RTL871X_IOCTL_QUERY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_query_c_
-- 
2.20.1

