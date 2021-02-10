Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2AF315EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhBJFTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhBJFTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:19:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B3CC64E58;
        Wed, 10 Feb 2021 05:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612934311;
        bh=I2BSPPWhLYHIwlo8vH0d0TDjqAzcfQC805BuqNnnmNk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RdnfOXxWqDbptZQoafXn1gqplM/yFJNUoo4mjtLH9hL+/cRMmXFhC86IB3Y0DkRMt
         SJ699QyB7va1oYHlq4T9nHCAQi1QorZ+alGpajITgJI57JlQwkGZuq6aLvDEMd2Xtr
         jdWetB9k66fob1XsAP5K5M4ERb9eLAindsbLJOAhce+Vt4Fi1lFRssv6P2fcmC0r75
         z3ml1YqsSX3c+ghFEAoRyuRVKdFYOvzJsKKlLtKluWFC/n7cVzwSiXJ1LtO4BXzqcg
         3BoiVZ6kV0QpXVD75YxzrglTyOMo3mIVDbk8XoUUuco4jassY5DKk16XGkkpi2aNgw
         hfaws0lzJpzBA==
From:   Timur Tabi <timur@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/3] kselftest: add support for skipped tests
Date:   Tue,  9 Feb 2021 23:18:13 -0600
Message-Id: <20210210051814.845713-3-timur@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210051814.845713-1-timur@kernel.org>
References: <20210210051814.845713-1-timur@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the kselftest framework to all testing clients to
specify that some tests were skipped.

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
---
 tools/testing/selftests/kselftest_module.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index e8eafaf0941a..e2ea41de3f35 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -11,7 +11,8 @@
 
 #define KSTM_MODULE_GLOBALS()			\
 static unsigned int total_tests __initdata;	\
-static unsigned int failed_tests __initdata
+static unsigned int failed_tests __initdata;	\
+static unsigned int skipped_tests __initdata
 
 #define KSTM_CHECK_ZERO(x) do {						\
 	total_tests++;							\
@@ -21,11 +22,16 @@ static unsigned int failed_tests __initdata
 	}								\
 } while (0)
 
-static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests)
+static inline int kstm_report(unsigned int total_tests, unsigned int failed_tests,
+			      unsigned int skipped_tests)
 {
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
+	if (failed_tests == 0) {
+		if (skipped_tests) {
+			pr_info("skipped %u tests\n", skipped_tests);
+			pr_info("remaining %u tests passed\n", total_tests);
+		} else
+			pr_info("all %u tests passed\n", total_tests);
+	} else
 		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
 
 	return failed_tests ? -EINVAL : 0;
@@ -36,7 +42,7 @@ static int __init __module##_init(void)			\
 {							\
 	pr_info("loaded.\n");				\
 	selftest();					\
-	return kstm_report(total_tests, failed_tests);	\
+	return kstm_report(total_tests, failed_tests, skipped_tests);	\
 }							\
 static void __exit __module##_exit(void)		\
 {							\
-- 
2.25.1

