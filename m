Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043C390435
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhEYOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhEYOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:44:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E44C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:43:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so1933133pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWiVcBIbAqRZUAmlKaQr51ovgMqAjPQ6/Z+Fj2X1sWM=;
        b=TvbWw7nt1cuIGfkYk+0PbY7pouCv8WJvyx1bnlNr8eO9ju6zSJF9Uck6K4y+ENl3bI
         Jv880lbQy3W7roTO1TNP6Cna4mSzwtYwAOiaDQ76fZYTP442pRfWIAxGa0k0DmKs6cTe
         c8lBRkSixTXO5LE3iziNbaia3SEYgw3WTNDeAMnr3YMh+YvEJvU42WCxJjETS1I6sBtV
         A3/0tvlovVoDpOIpiYIK2KSaTivBR2ED77ByWKAWHir6F+EGP9BYWnONtEZBDRwsaSVJ
         GGBv2jnIK7dPwOgyUiWWn/y9sKcC33PcGQPmW5ngWn1kTx+gwMcCn4zXjPiY002oz/UL
         ncqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWiVcBIbAqRZUAmlKaQr51ovgMqAjPQ6/Z+Fj2X1sWM=;
        b=FGqUr39D9HlxMOErBQKq/3I9G9bAfxqsR7zcGVZ1JcUWOBrt1FuntJ2yNKJCFT0r5T
         uzYMTAu0AZo//OEEDh7kyyCSOSZGx9++0g9sTVI2pE6+HFUK5N17rUJ4u4X/srRAi7Jl
         RcHvvyMCEuvWL0X5cLaI2ITKS9o6MI+pLMkNKG1XEMaowCHONDavE9xChSq7RBRHJK9i
         drTBYWGHzN7wC7RBdsoVOXZ6pHP3e2qC2mttjtl5Ea6cYajvH2F7Q+L2K38aQVHjSnlm
         sQsmTVRZ6AEW4sPNCV1rp/23qlRTbWfFQEvfbPZyze+9Z41XySdisRKy9j0VWh8JAOxb
         9JTg==
X-Gm-Message-State: AOAM532CyghNPpZvqIRTDKnH4QiNDYgFOy8/4+ExH8bYG/AyiPAL3dHH
        Bly0hpoffNjFupn/e2wd8LpMPbWgFZR5LA==
X-Google-Smtp-Source: ABdhPJz1/QSlDUfxUL0h5FOdyEvU97Bh9wt/1lwoB8aq/tMzBzOirMFABgCXzkOXaarGYTntkVXdqQ==
X-Received: by 2002:a17:90a:fc8b:: with SMTP id ci11mr28105008pjb.2.1621953795430;
        Tue, 25 May 2021 07:43:15 -0700 (PDT)
Received: from zen.local (97-113-152-155.tukw.qwest.net. [97.113.152.155])
        by smtp.gmail.com with ESMTPSA id z7sm3359086pgr.28.2021.05.25.07.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:43:15 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andy@kernel.org, akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Trent Piepho <tpiepho@gmail.com>
Subject: [PATCH v2 2/2] lib/math/rational: Add Kunit test cases
Date:   Tue, 25 May 2021 07:42:50 -0700
Message-Id: <20210525144250.214670-2-tpiepho@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525144250.214670-1-tpiepho@gmail.com>
References: <20210525144250.214670-1-tpiepho@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a number of test cases that cover a range of possible code paths.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
---
 lib/Kconfig.debug        | 12 +++++++++
 lib/math/Makefile        |  1 +
 lib/math/rational-test.c | 56 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 lib/math/rational-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..6c0e66a7d416 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2429,6 +2429,18 @@ config BITS_TEST
 
 	  If unsure, say N.
 
+config RATIONAL_KUNIT_TEST
+	tristate "KUnit test for rational.c" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select RATIONAL
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the rational math unit test.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 7456edb864fc..bfac26ddfc22 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
diff --git a/lib/math/rational-test.c b/lib/math/rational-test.c
new file mode 100644
index 000000000000..f64166dbe9ea
--- /dev/null
+++ b/lib/math/rational-test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+
+#include <linux/rational.h>
+
+struct rational_test_param {
+	unsigned long num, den;
+	unsigned long max_num, max_den;
+	unsigned long exp_num, exp_den;
+
+	const char *name;
+};
+
+static const struct rational_test_param test_parameters[] = {
+	{ 1230,	10,	100, 20,	100, 1,    "Exceeds bounds, semi-convergent term > ½ last term" },
+	{ 34567,100, 	120, 20,	120, 1,    "Exceeds bounds, semi-convergent term < ½ last term" },
+	{ 1, 30,	100, 10,	0, 1,	   "Closest to zero" },
+	{ 1, 19,	100, 10,	1, 10,     "Closest to smallest non-zero" },
+	{ 27,32,	16, 16,		11, 13,    "Use convergent" },
+	{ 1155, 7735,	255, 255,	33, 221,   "Exact answer" },
+	{ 87, 32,	70, 32,		68, 25,    "Semiconvergent, numerator limit" },
+	{ 14533, 4626,	15000, 2400,	7433, 2366, "Semiconvergent, demominator limit" },
+};
+
+static void get_desc(const struct rational_test_param *param, char *desc)
+{
+	strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+/* Creates function rational_gen_params */
+KUNIT_ARRAY_PARAM(rational, test_parameters, get_desc);
+
+static void rational_test(struct kunit *test)
+{
+	const struct rational_test_param *param = (const struct rational_test_param *)test->param_value;
+	unsigned long n = 0, d = 0;
+
+	rational_best_approximation(param->num, param->den, param->max_num, param->max_den, &n, &d);
+	KUNIT_EXPECT_EQ(test, n, param->exp_num);
+	KUNIT_EXPECT_EQ(test, d, param->exp_den);
+}
+
+static struct kunit_case rational_test_cases[] = {
+       KUNIT_CASE_PARAM(rational_test, rational_gen_params),
+       {}
+};
+
+static struct kunit_suite rational_test_suite = {
+       .name = "rational",
+       .test_cases = rational_test_cases,
+};
+
+kunit_test_suites(&rational_test_suite);
+
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

