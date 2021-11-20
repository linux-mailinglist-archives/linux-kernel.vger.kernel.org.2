Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CC7457E92
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhKTNEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhKTNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8521AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d5so23229708wrc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CA6CyXkBLPU6iYRNrocFGT3wGo36ndMvHod8bfLmn4=;
        b=heRMhgCL47CWoOYFpKXizCCKw8qgLjB3jbTIjeQVYgOdSkSSohopbZnO+h5FbDvvYK
         1yVjEyiodRrhJaU+9C0+Yn7/HOvuBoI5Pw9l/lSoJv0FKLRH04UsBQqyoXaXPIuKuZDj
         Q9f5E8/6YxTYQbLBlxxn94tbZwK8raBddKO65ejjG1BhlscuMzrGg7QdQ89FhpjtDsnB
         XUefmD0r42LJW9G0mUHZAScTLraR0vtS6grDNaM7krizwqgZBwZTCpZhj20XJEBDw7yY
         nsQSH8is7+RPsbwiFSoz16awDZAoRVJIR2CfqLAIzrXTlVQblyCgLdrNP+nTJNWlX8aQ
         SMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CA6CyXkBLPU6iYRNrocFGT3wGo36ndMvHod8bfLmn4=;
        b=ioOBnmzI9hrRe71uPKTN/qmqRtkdbuHECgOTLMzPjh0Vbse5YilQYQpWVfXmwttYr4
         fXYHAkfnRPIIJ7yYxz9kmKpEzXBnoLqxsUVoEe5zJqgXSckTEBbLH1FWFuJL3mEJN2aN
         sNlJHk1lv8QZEZ24hjFlLBNs8wG6Lts5NolYw18p52+RxqVGNHv3sBLbRbsDYKElwLpN
         D63xaAAIgLUBry7xZ+yXVoNd6PjkEU0uuVD+ds4WSzgcgji32vYZ6dnmTMexCPdTBfAB
         SoDwmz22brgKCQfg24HBBMi42xiAWZz0aEEMymcftLHyq7JkGl6dsT4qIIco4LC1GvCq
         I06w==
X-Gm-Message-State: AOAM531oP1bmAhDVVTmCShJUN7XPbZh3DodjebEU8gbiVoUYZPn8Kh7m
        0b8RtlFBJdOYiMORjTBZTGpABW0Nq6ZXPg==
X-Google-Smtp-Source: ABdhPJwjHZRFPNlqEfCOYN6Tlwvi01ey/FCICFgh4Jg9JVjIH3kQlZ4nBeIao6T7/RbA8uMA3I7vNg==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr17950510wru.363.1637413279205;
        Sat, 20 Nov 2021 05:01:19 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:17 -0800 (PST)
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
Subject: [PATCH v2 01/20] linux/stddef.h, linux/offsetof.h: Split offsetof() into a separate header
Date:   Sat, 20 Nov 2021 14:00:44 +0100
Message-Id: <20211120130104.185699-2-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/offsetof.h> from <linux/stddef.h> for compatibility.

From <linux/offsetof.h>:
	Include the same exact deps that <linux/stddef.h> had.
	Changing that in any way broke my compilation.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>

f
---
 include/linux/offsetof.h | 17 +++++++++++++++++
 include/linux/stddef.h   | 11 ++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/offsetof.h

diff --git a/include/linux/offsetof.h b/include/linux/offsetof.h
new file mode 100644
index 000000000000..3db431197687
--- /dev/null
+++ b/include/linux/offsetof.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OFFSETOF_H
+#define _LINUX_OFFSETOF_H
+
+
+#include <uapi/linux/stddef.h>
+
+
+#undef offsetof
+#ifdef __compiler_offsetof
+#define offsetof(T, m)	__compiler_offsetof(T, m)
+#else
+#define offsetof(T, m)	((size_t)&((T *)0)->m)
+#endif
+
+
+#endif  /* _LINUX_OFFSETOF_H */
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index ca507bd5f808..41217710788e 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -2,8 +2,12 @@
 #ifndef _LINUX_STDDEF_H
 #define _LINUX_STDDEF_H
 
+
 #include <uapi/linux/stddef.h>
 
+#include <linux/offsetof.h>
+
+
 #undef NULL
 #define NULL ((void *)0)
 
@@ -12,13 +16,6 @@ enum {
 	true	= 1
 };
 
-#undef offsetof
-#ifdef __compiler_offsetof
-#define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
-#else
-#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
-#endif
-
 /**
  * sizeof_field() - Report the size of a struct field in bytes
  *
-- 
2.33.1

