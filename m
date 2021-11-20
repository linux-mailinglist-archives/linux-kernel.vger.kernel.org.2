Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4058457E95
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhKTNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhKTNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7EC061748
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso12647804wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuy1i7ibN5PESbXyU0CRPA5iHJQ6TChkcgihWx0a5mE=;
        b=Tf923O/G83UPwDUP6+HY+1xiblir1iYHYbXqT3oE9MFc/SIkgEdsu0rhxaUHqKTpu4
         lHF+17b0p2rf9WSMMZi50qrtsw/JdZOKMztpULn2xOR08uGnsEebp2ehNRfYjuFtPYMX
         BZqtmP/KOkiP+0XkJuw3wvBz7dhqSRWJikDHdzqbSugZQwqTsqA9JZHwwx5lteWRqo07
         t7lcJU3ERQpWabJTIxYi+7QgQHygu7mesKnZ7NCa4P8A8po4Y46B2vXjZ52W7KXQyBKg
         2XliAoUsfYYX5QIvtaJjB+R6tEm4tf4+atJjjJOhm51Ja0ajkzlm6oUzOuwd7H45+N04
         OHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuy1i7ibN5PESbXyU0CRPA5iHJQ6TChkcgihWx0a5mE=;
        b=6u24qdiom3X5YoMs0E9PdYOn+x4WN3wMu+jduit2Znn8vtx/07tlp2hxuRvPVd4l9u
         FbXSUVcDxVQUs6uv5pH/LB5lzv+TU3Te4fZ2C+HDjqT8ufBznY/pEnwmstCpAMExEF8G
         TZQ57vxwWxQ5gRhOI3VKU7+k5sfn0oGhFgy9w89inUYH95Rb+dH9oUbj0t5KKHP6Xy4D
         /Z8pcNiO8adCJBsvb3q/uBpaHXPpQyL/oM9vtWkPVZ0CFD0N19+fhilbwjv55yrATUom
         PxKdCRyNDeNvFON62MiLVcViVa/DYGJqDdOy4qHkxArBjQTQPr7zT3/+ayA/QOZlPOtg
         GQZA==
X-Gm-Message-State: AOAM530dfnsB2JtRVLHmI8eal1wHGSnVq4DCem3Y2C1eOVd/0nWd2Rty
        cCbBf0keBUnoM4jteFlRPcoctR2ISFHSLw==
X-Google-Smtp-Source: ABdhPJwU0QpCAmSajETQrhC2TVnVkx3+lsD/6xCjPR++6hiN8mriYXvjZaKquyDwwUsbzSpiviZ6iA==
X-Received: by 2002:a05:600c:4f4b:: with SMTP id m11mr9683896wmq.151.1637413283604;
        Sat, 20 Nov 2021 05:01:23 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:23 -0800 (PST)
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
Subject: [PATCH v2 06/20] linux/kernel.h, linux/array_size.h: Split ARRAY_SIZE() into a separate header
Date:   Sat, 20 Nov 2021 14:00:49 +0100
Message-Id: <20211120130104.185699-7-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/array_size.h> from <linux/kernel.h> for compatibility.

Include <linux/compiler.h> for __must_be_array().

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/array_size.h | 15 +++++++++++++++
 include/linux/kernel.h     |  9 +++------
 2 files changed, 18 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/array_size.h

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
new file mode 100644
index 000000000000..cba90f2248ef
--- /dev/null
+++ b/include/linux/array_size.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ARRAY_SIZE_H
+#define _LINUX_ARRAY_SIZE_H
+
+#include <linux/compiler.h>
+
+
+/**
+ * ARRAY_SIZE - get the number of elements in array @a
+ * @a: array to be sized
+ */
+#define ARRAY_SIZE(a)  (sizeof((a)) / sizeof((a)[0]) + __must_be_array(a))
+
+
+#endif  /* _LINUX_ARRAY_SIZE_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 77755ac3e189..db6021ce3e0e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
+
+#include <linux/array_size.h>
 #include <linux/stdarg.h>
 #include <linux/align.h>
 #include <linux/limits.h>
@@ -25,6 +27,7 @@
 
 #include <uapi/linux/kernel.h>
 
+
 #define STACK_MAGIC	0xdeadbeef
 
 /**
@@ -39,12 +42,6 @@
 #define READ			0
 #define WRITE			1
 
-/**
- * ARRAY_SIZE - get the number of elements in array @arr
- * @arr: array to be sized
- */
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
-- 
2.33.1

