Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021F9376BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhEGVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhEGVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:32:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B06C061763
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:31:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so11624465ybp.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q9JAdXGPAhVpqUnwr15HezJPXiuHwPXVEpD6IHtNK7o=;
        b=p+vonGD5w287Almlow2qsnFECBBoGlx1BAXbBxOjWLpxV4S/dblMls/04CcLevu4Z5
         kh0cpLx997ohwM/Nqkk47f9jf0Fr3eebt9BYilBBviKDWzcIXYD+G4gIjPox267WIQNJ
         YWYvDnn+JsreY03J2NYU4gGmKzlefrMvbkLLY3orCu5A5M2A5KMSqAmQUXz6UkiGgM9A
         Cde6qPZ8X2zdk0BeZL+kdkJg/THNW8Es40Csj41q032pqXRyqOiEWYPZ49WCtUyZCjUh
         k7/MNIf/W10VHi427dCJD9J9+EurvDJ7WnyBM6xd5iS9S2jcmlyPtMXfWmBTU1lWry9g
         V3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q9JAdXGPAhVpqUnwr15HezJPXiuHwPXVEpD6IHtNK7o=;
        b=j/H/JFEUsM0kTVCcIHtTDZX7ZyxP8mfba+70XSTa8vClqngenhN6LCn7xi7dax556o
         JwL6dUhwbNbJyBlq2J2bA1Vw2kYdDT+1FIh7nxqrfd2ivazl8QzZ9EB/XlhQbY9XnIkh
         tPIV92brIZnQRHzi9boY7DPO+SlK/fHu3WFpPnisSCkLcVyknyi0jXsj10HpxDIDDm5p
         eN5EewGF6VBJNY8DcEjG5/bQ3CgMBJ1pbpVVvP1dFKJlGjN8IzMvK5TQoOcke2f4fHcs
         u0LHILKtcEzTe3HLeigSNkMngarWgWa4DBaQwOHi90Iu9ShNgI+1ieOkpAbDKlK79w6C
         tCRA==
X-Gm-Message-State: AOAM532RQVsonCRk716KEOBHMh8h1jxIMKq7soorh04n9M21aTX5JZAX
        ojH8YtgUdhx+yAQvVwBhNEJ8hHtbaMBfFnVjtJlwKA==
X-Google-Smtp-Source: ABdhPJzlXTcmhyGQa6Zcw24qR8nT404M1B9U8nwTw1K6jbANFWVMOToyrl/Rjdsdd26GC5hWCyiXJlhRAwROUB6riTQF7w==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:8b7:10d:a11b:ba0c])
 (user=brendanhiggins job=sendgmr) by 2002:a25:f50b:: with SMTP id
 a11mr16621155ybe.181.1620423092005; Fri, 07 May 2021 14:31:32 -0700 (PDT)
Date:   Fri,  7 May 2021 14:31:07 -0700
In-Reply-To: <20210507213110.155492-1-brendanhiggins@google.com>
Message-Id: <20210507213110.155492-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210507213110.155492-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH v1 1/4] kunit: Add 'kunit_shutdown' option
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gow <davidgow@google.com>

Add a new kernel command-line option, 'kunit_shutdown', which allows the
user to specify that the kernel poweroff, halt, or reboot after
completing all KUnit tests; this is very handy for running KUnit tests
on UML or a VM so that the UML/VM process exits cleanly immediately
after running all tests without needing a special initramfs.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-By: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/executor.c                | 20 ++++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 tools/testing/kunit/kunit_parser.py |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 15832ed446685..7db619624437c 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/reboot.h>
 #include <kunit/test.h>
 #include <linux/glob.h>
 #include <linux/moduleparam.h>
@@ -18,6 +19,9 @@ module_param(filter_glob, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites run at boot-time, e.g. list*");
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
 static struct kunit_suite * const *
 kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
 {
@@ -82,6 +86,20 @@ static struct suite_set kunit_filter_suites(void)
 	return filtered;
 }
 
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff"))
+		kernel_power_off();
+	else if (!strcmp(kunit_shutdown, "halt"))
+		kernel_halt();
+	else if (!strcmp(kunit_shutdown, "reboot"))
+		kernel_restart(NULL);
+
+}
+
 static void kunit_print_tap_header(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
@@ -112,6 +130,8 @@ int kunit_run_all_tests(void)
 		kfree(suite_set.start);
 	}
 
+	kunit_handle_shutdown();
+
 	return 0;
 }
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 89a7d4024e878..e22ade9d91ad5 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -208,7 +208,7 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty'])
+		args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
 		self._ops.linux_bin(args, timeout, build_dir)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index e8bcc139702e2..8d8d4d70b39dd 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -49,7 +49,7 @@ class TestStatus(Enum):
 
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:)')
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def isolate_kunit_output(kernel_output) -> Iterator[str]:
 	started = False
-- 
2.31.1.607.g51e8a6a459-goog

