Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B8C456E68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhKSLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhKSLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:27 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31553C06175D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso10229492wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3+BYXEru2uo1rC4aem2o0zlJvYEZVWQOyC0T+bh26M=;
        b=AVI2FQew7ysWZ2gON6FwhHJAqPymMK049a0/tLrMH9SQp9aT+ZPZyhWSg8+QNLH1cS
         fQHSP4oWveLdKl+aLAgaqApJjp66aPhoaJu25aXinvWHoCc6nGKl86RrbKwHCOy9y9Lt
         bk9fHMNw2c4Au9ohqtBrSuDU1j2IrIb7qF6GPfDwjmKcTD/8cPNnpDmUTCvPAuRUfhE2
         wq2y3EYS1QEcG3mhgGPFNHxVnY7V2PiNSHwQMw3C8MngvmjR0F9YQqJuN3TPoj9p9b6j
         TJyYx17ZptA45kszqch4TJJE0zqf28BQQGslasNjc2tZxjWNMBb/fMWJgDuUmH9AGg0W
         ndYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3+BYXEru2uo1rC4aem2o0zlJvYEZVWQOyC0T+bh26M=;
        b=yw5/wtEUoLRz4RQhfazrTFVopk7+/DBJSFpWHBkWYEUtBXWizk7EZSJrmSnZ5aeoD+
         e9HtGrDH/FGnJ4uEUn9Ck9W7dYvLX/klmPfYrr5TJxp+f/ofyMITfX/UtWuP9FWK/7zA
         ukmKGI5bypUfvxxPzVDEWYI1Gkcc/Aqoef/6Jqhg6nkiADZ8c9cbXcENLWh1l0zc1Zig
         FV0/JoN0vjlS9bOEUwpK+CJOFzNq5P8el4FEVa5RbE5eOXj0Luj+tzN0jTu+mAGkkaMJ
         DRMZaYYsVHfp6fhvLnLTTvQykk5B+8fGqJ4HbhNOA2GszpMME8UBtdVqcmEHv4fUgOwu
         wsSA==
X-Gm-Message-State: AOAM530nLrb3MY6du7dWrJ1PRvWenuEk13FVZ9UXr6b1L/Iu0U3ZPOEm
        AG8W1U+QHKpM42G0Ll2aEF32d6tMBkmPsQ==
X-Google-Smtp-Source: ABdhPJzuCYwTZ1spsflc+ZetWYCQNjEf8qMWXZMqELjwO8m1/vwhTjwKDnjysShuL71JBzaU+lcc2A==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr5875876wmq.33.1637321842723;
        Fri, 19 Nov 2021 03:37:22 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:22 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 15/17] linux/offsetofend.h: Move offsetofend(T, m) to a separate header
Date:   Fri, 19 Nov 2021 12:36:43 +0100
Message-Id: <20211119113644.1600-16-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching files so used for the kernel,
forces 'make' to recompile most of the kernel.

Having those definitions in more granular files
helps avoid recompiling so much of the kernel.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/filter.h      |  1 +
 include/linux/offsetofend.h | 19 +++++++++++++++++++
 include/linux/skmsg.h       |  1 +
 include/linux/stddef.h      | 10 +---------
 include/linux/string.h      |  1 +
 5 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/offsetofend.h

diff --git a/include/linux/filter.h b/include/linux/filter.h
index ebb0ae480533..5593d0365694 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -18,6 +18,7 @@
 #include <linux/kallsyms.h>
 #include <linux/if_vlan.h>
 #include <linux/offsetof.h>
+#include <linux/offsetofend.h>
 #include <linux/sizeof_field.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
diff --git a/include/linux/offsetofend.h b/include/linux/offsetofend.h
new file mode 100644
index 000000000000..4f4d0e1b667a
--- /dev/null
+++ b/include/linux/offsetofend.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OFFSETOFEND_H
+#define _LINUX_OFFSETOFEND_H
+
+#include <linux/offsetof.h>
+#include <linux/sizeof_field.h>
+
+
+/**
+ * offsetofend() - Report the offset of a struct field within the struct
+ *
+ * @TYPE: The type of the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+
+
+#endif  /* _LINUX_OFFSETOFEND_H */
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 584d94be9c8b..46e76f4ff0de 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -6,6 +6,7 @@
 
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/offsetofend.h>
 #include <linux/scatterlist.h>
 #include <linux/skbuff.h>
 
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 5c9aedb5e6ad..da50edf4b28d 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/stddef.h>
 #include <linux/NULL.h>
 #include <linux/offsetof.h>
+#include <linux/offsetofend.h>
 #include <linux/sizeof_field.h>
 
 
@@ -13,15 +14,6 @@ enum {
 	true	= 1
 };
 
-/**
- * offsetofend() - Report the offset of a struct field within the struct
- *
- * @TYPE: The type of the structure
- * @MEMBER: The member within the structure to get the end offset of
- */
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
-
 /**
  * struct_group() - Wrap a set of declarations in a mirrored struct
  *
diff --git a/include/linux/string.h b/include/linux/string.h
index 5a22a93c53f5..555b6f00c73d 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/errno.h>	/* for E2BIG */
 #include <linux/offsetof.h>
+#include <linux/offsetofend.h>
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
-- 
2.33.1

