Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF443BF16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhJ0Bji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhJ0Bjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:39:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A8C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:37:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e16-20020a256910000000b005c1cc2b24ccso675375ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O4M/tQHIU9ygzYdcq00Cuq5xDfJVENaFvMJsaxgv1Uk=;
        b=ipgwRjf4MbnXNFmRgqWaZKZYpqsFrVjjUM5IUmIj48IJ+uXEjqX3lIvgCj//ujftMU
         8lyuEx0+D6Xnz/iTY0d240W6dovoQflTqdnpDdWe8YLh89Rrv+ShMxUyOtljaa8WlHbb
         5wiweMoy+DXW/36/PwubPsKHEAAaKv7YfU9R3XQT2rFU3D7L7qM3MjTowcXDnBrmNtYs
         9qZFHqe/wWRR7hcYWECszq6Wsg+RbqFeCKfw5Q2rMjbzDWIZcVicwmbUqY3ELtPXBYwS
         defaJGwEvYHDpPJaAo6mdglkpkARGqBiyHDoDflmT8FbFRtiQ0CJq9mNvcfztI1WilzM
         aIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O4M/tQHIU9ygzYdcq00Cuq5xDfJVENaFvMJsaxgv1Uk=;
        b=2wHYilA7SKsyTT/9D8ckWT5bN9RuxG0WNjWgI7etxShk12B7sBlzQexLeqU/j4EE2N
         rl2Lk4dZPJVEzSeiQnqETJ0o8mcTJtUFf3eRPt+squ5rs5VV8/gRE48wpwfuW/Bo43Oi
         E9DGUkQOdvQmyukhGtNCnUqpEAW8ebIt9PEYV654CSj/kcsOxFejG0nJRUUI3WkTMtTM
         GNrCDd4r+MMEV0gJF4wgVmQG5zZLBIHDPispSkqqpCCLlUkI7GT/MScwvL/mA+WU2TXs
         Qsqx6JSuvpmA/gunq+KMTN+7WwT4e2OdCt2UinBCLq4xiwj25dDZUb4SU//LrViToRez
         oPrw==
X-Gm-Message-State: AOAM533iPce9P8BoKvkQa69GXi5y4Y3dPZ+KWeadJj4XevW7v1y1HOjl
        8tP22N8oFT3kbwX/Uuhtd5OgFYV6mb2eoQ==
X-Google-Smtp-Source: ABdhPJy5wGr37Q6+nC4gTXNyECv/6SgaiCo2x/x0NDGAyWhwPAakrLy53+OSWUWSYjsn7ctqK1CdS15Bb/BFbg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:c628:e925:d58d:6232])
 (user=davidgow job=sendgmr) by 2002:a25:3622:: with SMTP id
 d34mr1601396yba.325.1635298630761; Tue, 26 Oct 2021 18:37:10 -0700 (PDT)
Date:   Tue, 26 Oct 2021 18:36:59 -0700
Message-Id: <20211027013702.2039566-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 1/4] kunit: tool: Do not error on tests without test plans
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

The (K)TAP spec encourages test output to begin with a 'test plan': a
count of the number of tests being run of the form:
1..n

However, some test suites might not know the number of subtests in
advance (for example, KUnit's parameterised tests use a generator
function). In this case, it's not possible to print the test plan in
advance.

kunit_tool already parses test output which doesn't contain a plan, but
reports an error. Since we want to use nested subtests with KUnit
paramterised tests, remove this error.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 5 ++---
 tools/testing/kunit/kunit_tool_test.py | 5 ++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 3355196d0515..50ded55c168c 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -340,8 +340,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	"""
 	Parses test plan line and stores the expected number of subtests in
 	test object. Reports an error if expected count is 0.
-	Returns False and reports missing test plan error if fails to parse
-	test plan.
+	Returns False and sets expected_count to None if there is no valid test
+	plan.
 
 	Accepted format:
 	- '1..[number of subtests]'
@@ -356,7 +356,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	match = TEST_PLAN.match(lines.peek())
 	if not match:
 		test.expected_count = None
-		test.add_error('missing plan line!')
 		return False
 	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9c4126731457..bc8793145713 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -191,7 +191,10 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
-		self.assertEqual(2, result.test.counts.errors)
+		# A missing test plan is not an error.
+		self.assertEqual(0, result.test.counts.errors)
+		# All tests should be accounted for.
+		self.assertEqual(10, result.test.counts.total())
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
-- 
2.33.0.1079.g6e70778dc9-goog

