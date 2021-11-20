Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AAB457E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhKTNEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbhKTNEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9737C061756
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay10-20020a05600c1e0a00b0033aa12cdd33so433968wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrCIXvkrCgUlDLh5t+bxMCjdZGEEPhtV3+LhI9xMxMQ=;
        b=IDepEsj11C+glc6KazX6LuQ1julm5i6GFLDKnEaMNa0irEGMlKiBD3a5VA8NC28W+q
         oFjhY3aKpe/7DjxeHll0C7XIj4BLOqJU8grfJBIi+jGWDE4fDG316A1LhVfQ+OGhdhdH
         G2nzvBGGr0Q3hn0QIVQKeBt0y6PJm1PlXnbHA7mBFRpq6yjRDpSCY7UxCbmX+JFJCAfV
         /awXz7NMbfsdZccv7eEkTXKbSxhMi6RaqUp7ZNVGmS9LAMqThwGzid4wkJznT6Z7EoHV
         aVoDpS9JO0ETS3qyA5p8jolhuCGPK/L+baS78wJwYHGybx3UKJRS+IqSUuA9F7G5FxnL
         sK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrCIXvkrCgUlDLh5t+bxMCjdZGEEPhtV3+LhI9xMxMQ=;
        b=14YPmE58V6EO0WlcW2WpdycIsIPXwiTpDTSwKvkc4ib9ogWcBRHsJjEjEGpb4gCk4C
         iyrcQe5lUksNJZdZWov+Nw9F2ue2x7xq4IqersUQVpJjjlhlGp9HcXwfs7QGmBP9Kk8b
         lU1yvn63AuRYxWy9VJQY1Ic509PzwOsCk/uD4r5/Pm1DtiTd53QMTlpPSveAVbL8yOxZ
         CZg1/Gwd8aPBm856cidvR+YA+q9CtQyknY4JNOS6jrTG/Voy91ELy/a7ysIMO6sF+fV/
         DTiq2XSM77oXXDXehqZ1X2GgIAuY/h6KdGGTiErmUz/0RYB/1RqqR/MyUyK5oAN5C26R
         J12A==
X-Gm-Message-State: AOAM533Y492OjbT9j4azqR0I9axV0KT7o6hAGb3uyEFrYtwlhB3baAy3
        g1cSAUHIufVw13imZvNkOJQgbufcyIaSbg==
X-Google-Smtp-Source: ABdhPJzF4J0P9X0W71vahgI5Xw07LIZyVTtrSCBxtEcOZEegtR2ewXnVOb4mbkqaz5ZdtY9vHtokGw==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr9736538wmj.179.1637413291450;
        Sat, 20 Nov 2021 05:01:31 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:31 -0800 (PST)
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
Subject: [PATCH v2 13/20] linux/build_bug.h, linux/must_be.h: Move BUILD_BUG_ON_ZERO to <linux/must_be.h>
Date:   Sat, 20 Nov 2021 14:00:57 +0100
Message-Id: <20211120130104.185699-15-alx.manpages@gmail.com>
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

