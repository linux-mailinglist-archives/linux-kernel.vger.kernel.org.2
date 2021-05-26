Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B043921F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhEZVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbhEZVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:25:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:24:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v184-20020a257ac10000b02904f84a5c5297so3193120ybc.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BnSBPASpXbMUsi6dYdcVuYj86wGktPt+/5Fr2suKtX4=;
        b=ZLlfkd3PlPZm43rCF5dln1j3CS4E8WM77zesvGsoX7fNaOIi33HTXwnH8xe6YOb8nm
         eIS+1i5HxdXlKOp3xfgYbh6GGXN9w/0xASWGH6MC6QlK84T3MAvXgtwWHD8ijD58V22B
         w0I7nLjcewBxyz/LJ5u2dAFN43kSb+LHgmgseZR8VClCnay+2CIJW9PtMg7UC88mKppM
         anyoKX2NSiB9xePlwvxKfZHVnOXubeD2InPdzPtbzh01/6NNVAJfVxobw8vEANPbNJKt
         tHxrVsv610sdiSh/Ifw0zWtOCzxRvHHrRCeZB+VumEVgYqZCOHMX0setw6KRa5yGeryY
         T+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BnSBPASpXbMUsi6dYdcVuYj86wGktPt+/5Fr2suKtX4=;
        b=rC1PMV2m4M9PMuoFO69Ask24PLjIpDZRSTsO9Y8sNHP+sRR+pCZ1fC/VB7ebE63RGc
         A46PJ7bGqWTibsvKaTvIaxbqXX700id8BoH1RD3Q8VLZ+W8y5mip2cMydIs7BQo3yVPG
         DUv8q+VKZp3UAAlBXT8vOzBlybJnnkoOAWmzc+fthg4li5Wt800Byli2VG0g/Fzl7PXh
         7e/7t4s0d4mX3GSkH7t0CBHadgstzB6/aL2E/nAMeOuBjtx4KXwBkujJld7sZOUFzAvy
         /LSoqFd1uMwLQO7sPk0vlZx0RXSfqHFs7QoggL6p3zI9QG67/SgOkY0yCKr12214+T7h
         9O9g==
X-Gm-Message-State: AOAM533sQ/y7KbDDRL2g4S+I6TjFXomA31tdQHk2fP75woXuvm9oiG+9
        c6IAwa7l3yRV8UQEOoWK6MhMbG598uFPBh59sKFBLA==
X-Google-Smtp-Source: ABdhPJwdy6EHVdzUDkwhF3500rGaa+JaSroU3zFjlT02pBCvAjFS6dOoqVIwGy2nwczRUohZVx8k7OCmqOAVsnrKOK2Qfw==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:2a22:5aa3:3643:4ddb])
 (user=brendanhiggins job=sendgmr) by 2002:a25:ea06:: with SMTP id
 p6mr35651ybd.37.1622064255753; Wed, 26 May 2021 14:24:15 -0700 (PDT)
Date:   Wed, 26 May 2021 14:24:04 -0700
In-Reply-To: <20210526212407.2753879-1-brendanhiggins@google.com>
Message-Id: <20210526212407.2753879-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210526212407.2753879-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2 1/4] kunit: Add 'kunit_shutdown' option
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
index 89a7d4024e878..dbbceaee12305 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -208,7 +208,7 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty'])
+		args.extend(['mem=1G', 'console=tty', 'kunit_shutdown=halt'])
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
2.31.1.818.g46aad6cb9e-goog

