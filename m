Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114D9337710
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhCKPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhCKPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:23:23 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76450C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:23:23 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id n1so15374623qvi.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 07:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Uo+jdzDkstwte4rd5KP1ZCWjSQcfZaf7ZJhZWXy2RKs=;
        b=oU2FmmZy1hcNiNWsHS5LxlTOzAWKO8wzT9oIwklSSFU8vic4F9LLZemwiu5iaPJ7kb
         0r5jphxrIlJMeTC9Q4pBCp0fvcx87DYKidbdpH/6FWR7AjA4wefUB7SG5d+iWlyj8KqP
         vxD2QcLXsAjKKQy7xzfraTFyWvRpk5FfsdJnWZEaXqATSC9zORoiaJM6aRlr4jUqFPng
         ziaGRRqHDdgUSCfoQVaL1guOfsuy0CpchIqafwrjcXghFqfTWMaOzLo0CXWAc6pIMLKo
         dtG9x5xh86R0tUGmwFhGedtf/RUzFWLAe3jXDiF/rMBAYgzKZJAdTNRPbfd8IeeLQRrT
         Jjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Uo+jdzDkstwte4rd5KP1ZCWjSQcfZaf7ZJhZWXy2RKs=;
        b=L/eSBrdZsMHbYobbZO5SxB1mgof1aCCN57tsWBKn9Ni0/bX5efwBoEdQpliTtiSnjI
         PnhHdhgluYKqOSQI5X9goXcOAPgUeyl8t3WjzpUn1QjC3ErdoJUPqGiEyxTq2SYH3cky
         GZt9YFyelC065UENcasXN6KGbdbfROEBhYZvoPfBxxzwsaQoMt/p4xJWzCvFdb5j71Wa
         jYIMR5zZB39ed4SjKwFDhSKZakeYh75SakC/0gtBTRCJvosJTu3G4Id1M37JYrSKQVAi
         TPH9R75w6OaphW5XIZxuXmULe4w6ywxnag1aiF+h/eaJ/Xq7N6zpt0rSDuNRcTiwCs/L
         pTOw==
X-Gm-Message-State: AOAM530YSaXZP/KckPYjrbHOzBKZndz3vp3Ma8YVNRLzhBWaJHMstWtF
        j3ZU+xdIRASU1BkmML0HJr8blrT7CjKWyw==
X-Google-Smtp-Source: ABdhPJy1zi+D10F+EaOLwJkcGaJWbsWc2A4cgtaoxCxs+Xt42a/9UWmbeAIBXnObyqjj6bb+TiMDj9xPxP6ZNQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d84c:1a92:8f6c:2d41])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:242f:: with SMTP id
 gy15mr8169011qvb.17.1615476202686; Thu, 11 Mar 2021 07:23:22 -0800 (PST)
Date:   Thu, 11 Mar 2021 07:23:13 -0800
In-Reply-To: <20210311152314.3814916-1-dlatypov@google.com>
Message-Id: <20210311152314.3814916-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210311152314.3814916-1-dlatypov@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v4 1/2] kunit: support failure from dynamic analysis tools
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Uriel Guajardo <urielguajardo@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Add a kunit_fail_current_test() function to fail the currently running
test, if any, with an error message.

This is largely intended for dynamic analysis tools like UBSAN and for
fakes.
E.g. say I had a fake ops struct for testing and I wanted my `free`
function to complain if it was called with an invalid argument, or
caught a double-free. Most return void and have no normal means of
signalling failure (e.g. super_operations, iommu_ops, etc.).

Key points:
* Always update current->kunit_test so anyone can use it.
  * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
  CONFIG_KASAN=y

* Create a new header <kunit/test-bug.h> so non-test code doesn't have
to include all of <kunit/test.h> (e.g. lib/ubsan.c)

* Forward the file and line number to make it easier to track down
failures

* Declare the helper function for nice __printf() warnings about mismatched
format strings even when KUnit is not enabled.

Example output from kunit_fail_current_test("message"):
[15:19:34] [FAILED] example_simple_test
[15:19:34]     # example_simple_test: initializing
[15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
[15:19:34]     not ok 1 - example_simple_test

Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
 lib/kunit/test.c         | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 4 deletions(-)
 create mode 100644 include/kunit/test-bug.h

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..e88b74a4fd85
--- /dev/null
+++ b/include/kunit/test-bug.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API allowing dynamic analysis tools to interact with KUnit tests
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+
+#ifndef _KUNIT_TEST_BUG_H
+#define _KUNIT_TEST_BUG_H
+
+#define kunit_fail_current_test(fmt, ...) \
+	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+#if IS_BUILTIN(CONFIG_KUNIT)
+
+extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...);
+
+#else
+
+static __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...)
+{
+}
+
+#endif
+
+
+#endif /* _KUNIT_TEST_BUG_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..2f6cc0123232 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
@@ -16,6 +17,40 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+/*
+ * Fail the current test and print an error message to the log.
+ */
+void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+	char *buffer;
+
+	if (!current->kunit_test)
+		return;
+
+	kunit_set_failure(current->kunit_test);
+
+	/* kunit_err() only accepts literals, so evaluate the args first. */
+	va_start(args, fmt);
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);
+	if (!buffer)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(buffer, len, fmt, args);
+	va_end(args);
+
+	kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
+	kunit_kfree(current->kunit_test, buffer);
+}
+EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
+#endif
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -273,9 +308,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
 
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -624,9 +657,7 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
-- 
2.31.0.rc2.261.g7f71774620-goog

