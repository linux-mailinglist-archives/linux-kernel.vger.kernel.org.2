Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714AE390CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhEYXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhEYXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:37:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D340CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:36:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso14070091pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5JTbQEL2lynAmwWeBjELD+N77e868iFSnWxGmYX1E4=;
        b=hXccSaNZRufDUAI9Qe5ZLoRBItWQs97Owdht8j3LzGGOMOFicTYftIRZZVV1ta7ovH
         uMSTzOS/LVzjuaSsX3hEluA6BhtOwmgPyrQIam69j6+k+CsRKS7ZbpGGjaXpHuDZ0PEi
         EV1n7QGsR8IqmjJNEjlTxWir8Y85HVdVDoWOaMcfUdx3Te35hyo8rFMxuDnjqs05qtT0
         nbiRte74rgldGoiVvls0avhh9x8NquApMrcBkmOrrPVB0Ctiaps6XTXpF6hvxecOJFYF
         MDfy3MIQRNrcWTHoXNw9R+mmrbEJ8PutxLiXvkTjmyRfMwb+9ul8yGpUjo6a4gkwA1OT
         Eb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5JTbQEL2lynAmwWeBjELD+N77e868iFSnWxGmYX1E4=;
        b=bbEwG/P9ekskyKQwPXn0F0TZXZsPWsB+6U9gqDXljfVUx+WNnO6mcsGpDAsib+GTio
         ibMSCiKuBJI/atVQBR2/5Xc84DWcXWp/R4cnHSatn123HgKn6ZbG7aAZuN+jQBfWNlwp
         ZN/3WovYKIv9/rpkmzRD8oaxBGNUbJt3PDeXc3JvE9EKP8IN1jP9SlGxonRTifmIBjjk
         7ssz/4nNPgfO+OJxW/iqMNEOTK2bQSDxLPO9qFOZv4trwIbm0xKjzw0yNDO2Cc/1+ptD
         /kAFMF/THGcuLbNLKzqFDBHjmNHU/4bMr8FbGbUOGO48PSmPeScHK6ZNqWGa7yrxuBum
         nQVg==
X-Gm-Message-State: AOAM530N+TFX6JZCDFlUtEKyXx22HSvtOi7OkiM026G5ySkCY9cV12iK
        GEMHdZN6UQtycrEcOoMfjVpqUOfLjoYdqQ==
X-Google-Smtp-Source: ABdhPJzg13XQhHzYf7P8ugs+X5kRMdlqHNADW9W3PN+DvaW8IDDQpTGFxapTd/ESxdrsV4Ng5469EQ==
X-Received: by 2002:a17:903:187:b029:f1:faff:a111 with SMTP id z7-20020a1709030187b02900f1faffa111mr32881166plg.80.1621985760083;
        Tue, 25 May 2021 16:36:00 -0700 (PDT)
Received: from zen.local (97-113-152-155.tukw.qwest.net. [97.113.152.155])
        by smtp.gmail.com with ESMTPSA id p17sm2971438pjg.54.2021.05.25.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 16:35:59 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andy@kernel.org, akpm@linux-foundation.org, oskar@scara.com,
        Daniel Latypov <dlatypov@google.com>,
        Trent Piepho <tpiepho@gmail.com>
Subject: [PATCH v3 2/2] lib/math/rational: Add Kunit test cases
Date:   Tue, 25 May 2021 16:35:19 -0700
Message-Id: <20210525233519.343068-2-tpiepho@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525233519.343068-1-tpiepho@gmail.com>
References: <20210525233519.343068-1-tpiepho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a number of test cases that cover a range of possible code paths.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
---
Changes from v2:
  Rename file to follow new kunit naming convention
  Fix whitespace issues
  Remove unicode characters
  Add more testcases

 lib/Kconfig.debug         | 12 ++++++++
 lib/math/Makefile         |  1 +
 lib/math/rational_kunit.c | 60 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 lib/math/rational_kunit.c

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
index 7456edb864fc..de7d16ca3cf5 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
 obj-$(CONFIG_RATIONAL)		+= rational.o
 
 obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
+obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational_kunit.o
diff --git a/lib/math/rational_kunit.c b/lib/math/rational_kunit.c
new file mode 100644
index 000000000000..439b06fdfe66
--- /dev/null
+++ b/lib/math/rational_kunit.c
@@ -0,0 +1,60 @@
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
+	{ 1230,	10,	100, 20,	100, 1,    "Exceeds bounds, semi-convergent term > half last term" },
+	{ 34567, 100,	120, 20,	120, 1,    "Exceeds bounds, semi-convergent term < half last term" },
+	{ 1, 30,	100, 10,	0, 1,	   "Closest to zero" },
+	{ 1, 19,	100, 10,	1, 10,     "Closest to smallest non-zero" },
+	{ 1155, 7735,	255, 255,	33, 221,   "Exact answer" },
+	{ 27, 32,	16, 16,		11, 13,    "Convergent" },
+	{ 67, 54,	17, 18,		5, 4,      "Convergent, semiconvergent term half convergent term" },
+	{ 453, 182,	60, 60,		57, 23,	   "Semiconvergent, semiconvergent term half convergent term" },
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
+	const struct rational_test_param *param =
+		(const struct rational_test_param *)test->param_value;
+	unsigned long n = 0, d = 0;
+
+	rational_best_approximation(param->num, param->den, param->max_num, param->max_den, &n, &d);
+	KUNIT_EXPECT_EQ(test, n, param->exp_num);
+	KUNIT_EXPECT_EQ(test, d, param->exp_den);
+}
+
+static struct kunit_case rational_test_cases[] = {
+	KUNIT_CASE_PARAM(rational_test, rational_gen_params),
+	{}
+};
+
+static struct kunit_suite rational_test_suite = {
+	.name = "rational",
+	.test_cases = rational_test_cases,
+};
+
+kunit_test_suites(&rational_test_suite);
+
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

