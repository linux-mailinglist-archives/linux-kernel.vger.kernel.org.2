Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7A43DB61
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhJ1Goh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ1Gof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 02:44:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC5FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:42:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v18-20020a25fc12000000b005c1f3933580so650157ybd.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eDps66GpWebAOFJkT/oYyV6A6q385IvZARapZ9ebx50=;
        b=FQhRUBLQrCs4CqOs8Xt1ZZKlqIqHPdRhavV4Y867bpsKQourynNGm2mekZyr0GDtA3
         zuHWcqSyM1gNnsz0tarhBMoaMaRPu/g0Up8ACt2DDTHv4AFZ0NX2CIFRqUwREfhdbBIS
         n7cpkSin6fo3nh7DCj8YLX0C0FgQvstIA/R8AJbsZjskIMSOkvVCowcW3ngxYvjDRjwo
         lkeBEByi1Zzf8bhE4wDsLf+97kEU3VtpXx9SFhA58i1OmqOIrfJdCj7ISYcuHcR2ba+p
         UcfTa6GDOwk/m6efQ/fdyqBg5wM8BJcFO5xk1V58n5ArP/cH0B66BnWUUeYaCFrUWVeB
         thlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eDps66GpWebAOFJkT/oYyV6A6q385IvZARapZ9ebx50=;
        b=O7SKuyWKtajRgIrurCDy5/4TgA1gwGZhk1aB78xWYQbDDI0u9pHhaOsAzbZp+ebGBs
         fWpVjnmuUnQCLo7kJh49WN/Sy0PL3HuUtMiKaFYJCYneJxCsNuN4mCSYXrqipynGgpCw
         L6EnJZcP+qakyVQ+4UiFCSTniOJBz4mN0AyPp5tgWCT8Oy3JqS8gtZiPBxfnwc++qRPw
         nZs4QterhJg11tla1/aORJgddZoe+2UpYKpatVOKc8Eu5tWJZKDj2QTpozIdKfMcKUOC
         Oq8PJN8qP3PUHnMDmQj4GrcULeAONvrQ3JIQHnbQh8PnJfmcVse+DjjJlQR6t2PI3u2D
         v9Yg==
X-Gm-Message-State: AOAM530RdA8vpS3xSBCYtG6wEJF7MyFIcXLSKQjhfEDKObtBCB2mnj0S
        d3TYQqVqCsM1k2zkHWNqqlmjdBexoVPjhg==
X-Google-Smtp-Source: ABdhPJxMQm+ThJkQ0X/ukFChGQV4SQd/ZCG7bPIDy7HQPMM9yQXixzVML/g/S2OTgb+VP+/c7Z1zF7HTeP/IVA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:d8b1:a4bf:2b6f:92f9])
 (user=davidgow job=sendgmr) by 2002:a5b:402:: with SMTP id
 m2mr2540256ybp.422.1635403328629; Wed, 27 Oct 2021 23:42:08 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:41:52 -0700
In-Reply-To: <20211028064154.2301049-1-davidgow@google.com>
Message-Id: <20211028064154.2301049-2-davidgow@google.com>
Mime-Version: 1.0
References: <20211028064154.2301049-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 2/4] kunit: tool: Report an error if any test has no subtests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for a test to have a subtest header, but zero valid
subtests. We used to error on this if the test plan had no subtests
listed, but it's possible to have subtests without a test plan (indeed,
this is how parameterised tests work).

Tests with 0 subtests now have the result NO_TESTS, and will report an
error (which does not halt test execution, but is printed in a scary red
colour and is noted in the results summary).

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-2-davidgow@google.com/
- Report NO_TESTS as '[NO TESTS RUN]' in yellow, instead of '[FAILED]'
  in red, particularly since it doesn't get counted as a failure.

 tools/testing/kunit/kunit_parser.py              | 16 +++++++++++-----
 tools/testing/kunit/kunit_tool_test.py           |  9 +++++++++
 .../test_is_test_passed-no_tests_no_plan.log     |  7 +++++++
 3 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 50ded55c168c..68c847e8ca58 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -360,9 +360,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
 	test.expected_count = expected_count
-	if expected_count == 0:
-		test.status = TestStatus.NO_TESTS
-		test.add_error('0 tests run!')
 	return True
 
 TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
@@ -589,6 +586,8 @@ def format_test_result(test: Test) -> str:
 		return (green('[PASSED] ') + test.name)
 	elif test.status == TestStatus.SKIPPED:
 		return (yellow('[SKIPPED] ') + test.name)
+	elif test.status == TestStatus.NO_TESTS:
+		return (yellow('[NO TESTS RUN] ') + test.name)
 	elif test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
 		return (red('[CRASHED] ') + test.name)
@@ -731,6 +730,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		# test plan
 		test.name = "main"
 		parse_test_plan(lines, test)
+		parent_test = True
 	else:
 		# If KTAP/TAP header is not found, test must be subtest
 		# header or test result line so parse attempt to parser
@@ -744,7 +744,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
-	while expected_count is None or test_num <= expected_count:
+	while parent_test and (expected_count is None or test_num <= expected_count):
 		# Loop to parse any subtests.
 		# Break after parsing expected number of tests or
 		# if expected number of tests is unknown break when test
@@ -779,9 +779,15 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 			parse_test_result(lines, test, expected_num)
 		else:
 			test.add_error('missing subtest result line!')
+
+	# Check for there being no tests
+	if parent_test and len(subtests) == 0:
+		test.status = TestStatus.NO_TESTS
+		test.add_error('0 tests run!')
+
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
-	if parent_test:
+	if parent_test and not main:
 		# If test has subtests and is not the main test object, print
 		# footer.
 		print_test_footer(test)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bc8793145713..c59fe0777387 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -208,6 +208,15 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
+		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
+		with open(no_plan_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(file.readlines()))
+		self.assertEqual(0, len(result.test.subtests[0].subtests[0].subtests))
+		self.assertEqual(
+			kunit_parser.TestStatus.NO_TESTS,
+			result.test.subtests[0].subtests[0].status)
+
 
 	def test_no_kunit_output(self):
 		crash_log = test_data_path('test_insufficient_memory.log')
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
new file mode 100644
index 000000000000..dd873c981108
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
@@ -0,0 +1,7 @@
+TAP version 14
+1..1
+  # Subtest: suite
+  1..1
+    # Subtest: case
+  ok 1 - case # SKIP
+ok 1 - suite
-- 
2.33.0.1079.g6e70778dc9-goog

