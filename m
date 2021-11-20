Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6869457E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhKTNEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhKTNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BEC061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so23200855wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrCIXvkrCgUlDLh5t+bxMCjdZGEEPhtV3+LhI9xMxMQ=;
        b=PuWHJait3+uZe9Nio1huMr87qqq4ZE9CCecCGRe47T+rIHMUeXRYCMYhng609x6h+W
         WuEPDfYVhJIHvhzTzSxMqGjxLFaRyiXpJ2DbRQJPENE1bao8z/NHeT5rC3AJOEhGWdQC
         Myxeug0CFES9jL3vJoF7G5sVdQvPvN1st2UO2ZHMkUBI9MGMed2bXYEw2KHAEylqaWLv
         3G963jK0dATIiAX1exQ3rGMGq5449MLJIPN5cw8Lx+dNj/Kc9UoZ9likii8wCkOUr29g
         v4f5x/mimlWmDdeCgVa8fjzGRjrzSIav27H0KZvOGEBELxCMw2nDOGNP+MYFigKvnQ9/
         VdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrCIXvkrCgUlDLh5t+bxMCjdZGEEPhtV3+LhI9xMxMQ=;
        b=EZyEfvYHPwd7Qm1vKy5MsVjqfjnG66pYeWczTu4nGYD8nXy9Kio4W3CPhPIW9a7QV+
         7O2lHRwYIfmoqzoIvBccR9v1JDZCnHHXGPD20yX9xxwHxPQQ4zLTugLFyC4GwpwRhs2n
         nkTDPxq5NVzkRq8nXplgdWegrsEbg/9+o7RCKBzOUaQsZ9y9EZepCMrB9KjmwQXGEhso
         KBiZ23nTwsI/PacKVbgxFSflW1r+y0F5ytM00Wmj58ZffgGk7qyIv0CDu6JYt6FTE1w6
         DDCsGGj4ZDog2JiNhwbAkfNSVqm3Y70gHPIXcL/+z0SBTwDyqYYtIKFFrkyTI2wTMPnl
         LIUQ==
X-Gm-Message-State: AOAM531P9r1fIoBcHaij7XQmBZNjDpvniXYOPDK83Xx18dMG3YVo/dIJ
        KfieO+VhnNoZQ7BLCswDitPKsyWJlzLpPw==
X-Google-Smtp-Source: ABdhPJxxjq74+SBrpK3rCEasEwzQOSL+V90kqB0EuVSwi0z6Eoq/tObuQDfQIrL/gKgOSDSdWc0YRA==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr18167955wrt.22.1637413290610;
        Sat, 20 Nov 2021 05:01:30 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:30 -0800 (PST)
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
Subject: [PATCH v2 13/20] Move BUILD_BUG_ON_ZERO to <linux/must_be.h>
Date:   Sat, 20 Nov 2021 14:00:56 +0100
Message-Id: <20211120130104.185699-14-alx.manpages@gmail.com>
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
 include/linux/build_bug.h | 13 ++-----------
 include/linux/must_be.h   | 12 ++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index e3a0be2c90ad..539e3d5df027 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -2,19 +2,10 @@
 #ifndef _LINUX_BUILD_BUG_H
 #define _LINUX_BUILD_BUG_H
 
+
 #include <linux/compiler.h>
+#include <linux/must_be.h>
 
-#ifdef __CHECKER__
-#define BUILD_BUG_ON_ZERO(e) (0)
-#else /* __CHECKER__ */
-/*
- * Force a compilation error if condition is true, but also produce a
- * result (of value 0 and type int), so the expression can be used
- * e.g. in a structure initializer (or where-ever else comma expressions
- * aren't permitted).
- */
-#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
-#endif /* __CHECKER__ */
 
 /* Force a compilation error if a constant expression is not a power of 2 */
 #define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
diff --git a/include/linux/must_be.h b/include/linux/must_be.h
index a2e0b0c890a6..d1ebeaca9cf8 100644
--- a/include/linux/must_be.h
+++ b/include/linux/must_be.h
@@ -3,6 +3,18 @@
 #define _LINUX_MUST_BE_H
 
 
+#ifdef __CHECKER__
+#define BUILD_BUG_ON_ZERO(e) (0)
+#else  /* __CHECKER__ */
+/*
+ * Force a compilation error if condition is true, but also produce a
+ * result (of value 0 and type int), so the expression can be used
+ * e.g. in a structure initializer (or where-ever else comma expressions
+ * aren't permitted).
+ */
+#define BUILD_BUG_ON_ZERO(e)  ((int)(sizeof(struct { int:(-!!(e)); })))
+#endif  /* __CHECKER__ */
+
 #define __must_be(e)  BUILD_BUG_ON_ZERO(!(e))
 
 
-- 
2.33.1

