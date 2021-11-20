Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97483457EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhKTNFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhKTNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A66C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so23212990wrb.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b80jX0Vl1q87yfWiCpVWIRnierRjUnN6pZ/LFim83Eg=;
        b=CwzG1ROtWWKhQ8MSdBLIZsSVXBIrJykheG+uNsNdQWC1iqcDYF4Nzq4KmIGaY3Vvqu
         nK3mMipVvsXwPghG2/z16YuEuXX8wWDjXNKJdG1798W+6UJlgJyxffaUhPtUm2H3yV4P
         YjDiPbmOShnY4xklQmFYR0Nhim4kKJ9aHLRMbbf4pCSyB22Fa8R1YENZE+j7kpTjLaZy
         /X8XAOiS6wYisf9s3mDPkyAnghaIHA9o2IfNKrOd88ef19D7QWIpt9rv3qGojZ6y9Put
         TCYSh4bP/YK68tEC3bF2pktNKcr4dsiqIYTCm/xiO1naWS5x33rlBQ6CwGpTOXJTrECF
         x/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b80jX0Vl1q87yfWiCpVWIRnierRjUnN6pZ/LFim83Eg=;
        b=nezne7tmSukiIEVjbTIVtHeDCFNlVkOZNA7qk5nYdHWdSlVo7i44/7QGzMYfIc0BJR
         G2AoipnbFCE++JKs12E+QvadODKsRdv1tgYH5uIYmW8/+jVNhafy+uXN/0U9rgKWhtz0
         K6xUVxZXhUVdPaJYI90aBdiCxvAwTblLL1HncWB2JHoy9ShtzFT9U+qQdXEnitBzMIJW
         2Y4CUk8GM3tD9wa+Vg5+y+N6bBWXuTblJ3/nMTxHD71UBQJX0FTR9qURwEO3VV2LEV4J
         tVxoGsaphvPqd6M4F623DoS6KjiBKsQtT+NfZbMfZqTX4i1OseDilIizyIPWgtjnPd62
         12hA==
X-Gm-Message-State: AOAM530l7Cop9bxGISmAWrXoNxCURXuYhZOlfA+UJI2l/VLikvbqon50
        k6hkD+DMqUuNe0Kkjqn/cO6tmtaCgNv+kw==
X-Google-Smtp-Source: ABdhPJxd6gozTDjnXFyUHDXIr/+hNuH5aYMGuQtP9LtENeD1oipwCQuXoYX6lx2AfuYOLiSmGmiwVg==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr18293946wrz.127.1637413296889;
        Sat, 20 Nov 2021 05:01:36 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:36 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 19/20] linux/build_bug.h, linux/power_of_2.h: Move [__]BUILD_BUG_ON_NOT_POWER_OF_2() to <linux/power_of_2.h>
Date:   Sat, 20 Nov 2021 14:01:03 +0100
Message-Id: <20211120130104.185699-21-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/build_bug.h  | 7 +------
 include/linux/power_of_2.h | 9 +++++++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 539e3d5df027..65f64cd399be 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -5,14 +5,9 @@
 
 #include <linux/compiler.h>
 #include <linux/must_be.h>
+#include <linux/power_of_2.h>
 
 
-/* Force a compilation error if a constant expression is not a power of 2 */
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
-	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
-	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
-
 /*
  * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
  * expression but avoids the generation of any code, even if that expression
diff --git a/include/linux/power_of_2.h b/include/linux/power_of_2.h
index 812fe86eefcd..132592f0b718 100644
--- a/include/linux/power_of_2.h
+++ b/include/linux/power_of_2.h
@@ -3,8 +3,17 @@
 #define _LINUX_POWER_OF_2_H
 
 
+#include <linux/build_bug.h>
+
+
 #define __IS_POWER_OF_2_OR_0(n)  (((n) & ((n) - 1)) == 0)
 #define __IS_POWER_OF_2(n)       (__IS_POWER_OF_2_OR_0(n) && ((n) != 0))
 
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+
 
 #endif	/* _LINUX_POWER_OF_2_H */
-- 
2.33.1

