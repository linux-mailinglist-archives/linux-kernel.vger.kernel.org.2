Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4C315E95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhBJFHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:07:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15211 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhBJFGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:06:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602369b70000>; Tue, 09 Feb 2021 21:05:59 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 05:05:55 +0000
Received: from ubuntu.vdiclient.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 05:05:53 +0000
From:   Timur Tabi <ttabi@nvidia.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <roman.fietze@magna.com>, "Kees Cook" <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        <akinobu.mita@gmail.com>, <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH 2/3] kselftest: add support for skipped tests
Date:   Tue, 9 Feb 2021 23:05:28 -0600
Message-ID: <20210210050529.843005-3-ttabi@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210050529.843005-1-ttabi@nvidia.com>
References: <20210210050529.843005-1-ttabi@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612933559; bh=zziyNFNlmhSW3q56XQBsPtG1JAzI0NtMX6ixBkt95eQ=;
        h=From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=WuvKaTC/TNCklMdz1K6fO9lcupEAM8iorDm0grzyrVo1mbY49/SVyPj5vGk6daZ4J
         rRliDzP37cebsuJALnMxasmn2wBY1WDF1B9amiof1HqKKZ66KFSri+L/lkUHT7P0Rc
         Q8BYd8ockVYDukRfdLgHlgaAZiKDajU9Sl6t3C/4H/gnMnuSxNY9F6L/yvIl2ioc0/
         343SsdMWuSJxoarnaxNMDriDATmjtCIDLX+5/7toogK5q87jCYHW9IbUYV3a7aRMND
         QSdjyudXOnFz0V/hrcO3TbcntXS+iaO5EGmLMSVX+tgdIvKRVro7pvqhtGw6wmZKM4
         pwVlPM7v9v30Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the kselftest framework to all testing clients to
specify that some tests were skipped.

Signed-off-by: Timur Tabi <ttabi@nvidia.com>
---
 tools/testing/selftests/kselftest_module.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/sel=
ftests/kselftest_module.h
index e8eafaf0941a..e2ea41de3f35 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -11,7 +11,8 @@
=20
 #define KSTM_MODULE_GLOBALS()			\
 static unsigned int total_tests __initdata;	\
-static unsigned int failed_tests __initdata
+static unsigned int failed_tests __initdata;	\
+static unsigned int skipped_tests __initdata
=20
 #define KSTM_CHECK_ZERO(x) do {						\
 	total_tests++;							\
@@ -21,11 +22,16 @@ static unsigned int failed_tests __initdata
 	}								\
 } while (0)
=20
-static inline int kstm_report(unsigned int total_tests, unsigned int faile=
d_tests)
+static inline int kstm_report(unsigned int total_tests, unsigned int faile=
d_tests,
+			      unsigned int skipped_tests)
 {
-	if (failed_tests =3D=3D 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
+	if (failed_tests =3D=3D 0) {
+		if (skipped_tests) {
+			pr_info("skipped %u tests\n", skipped_tests);
+			pr_info("remaining %u tests passed\n", total_tests);
+		} else
+			pr_info("all %u tests passed\n", total_tests);
+	} else
 		pr_warn("failed %u out of %u tests\n", failed_tests, total_tests);
=20
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
--=20
2.25.1

