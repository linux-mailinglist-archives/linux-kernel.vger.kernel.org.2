Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D285E40D0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhIPAdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233510AbhIPAdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE4F5610A6;
        Thu, 16 Sep 2021 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752307;
        bh=IhIcfM2+glDkaLURJcccmy8ABiyEps+6A8wecz7pdJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPxKcZ1J0JbEAs/MQVy3CuRQoIUAHaCtc72pEt2IqT3XvNIn3mMQDWLe2B1OoJr3r
         IqZWZ64XCluglsIUlGx+wVSGIIchv3ewtUiyM6ZhoKDdnQ/LYqL8iJ8y2AzDzEwlsF
         UvmYsX/K6R0//+ohVw5LnTbKpaC39oSd+vvsaUXAnWNOcbe0O+ZJp2ZtRd3Jg29RV/
         rkR6TAr4gA2AHTALnxRuWd13b4M4tmzXOhz6uFBa2P68r6kksQeQP2+tWJVbK8l4zm
         EPG5xB5eaPPA+82todpRm43+64W/TEm4bnuSndM3qjlnx95wZ69eGbrXBOkBKAouFi
         0cjFhMWBufiQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AFFB15C08DB; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/9] kcsan: test: Fix flaky test case
Date:   Wed, 15 Sep 2021 17:31:40 -0700
Message-Id: <20210916003146.3910358-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

If CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, then we may also see data
races between the writers only. If we get unlucky and never capture a
read-write data race, but only the write-write data races, then the
test_no_value_change* test cases may incorrectly fail.

The second problem is that the initial value needs to be reset, as
otherwise we might actually observe a value change at the start.

Fix it by also looking for the write-write data races, and resetting the
value to what will be written.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index d93f226327af..e282c1166373 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -493,17 +493,24 @@ static void test_concurrent_races(struct kunit *test)
 __no_kcsan
 static void test_novalue_change(struct kunit *test)
 {
-	const struct expect_report expect = {
+	const struct expect_report expect_rw = {
 		.access = {
 			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 		},
 	};
+	const struct expect_report expect_ww = {
+		.access = {
+			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
+			{ test_kernel_write_nochange, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
+		},
+	};
 	bool match_expect = false;
 
+	test_kernel_write_nochange(); /* Reset value. */
 	begin_test_checks(test_kernel_write_nochange, test_kernel_read);
 	do {
-		match_expect = report_matches(&expect);
+		match_expect = report_matches(&expect_rw) || report_matches(&expect_ww);
 	} while (!end_test_checks(match_expect));
 	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY))
 		KUNIT_EXPECT_FALSE(test, match_expect);
@@ -518,17 +525,24 @@ static void test_novalue_change(struct kunit *test)
 __no_kcsan
 static void test_novalue_change_exception(struct kunit *test)
 {
-	const struct expect_report expect = {
+	const struct expect_report expect_rw = {
 		.access = {
 			{ test_kernel_write_nochange_rcu, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
 			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
 		},
 	};
+	const struct expect_report expect_ww = {
+		.access = {
+			{ test_kernel_write_nochange_rcu, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
+			{ test_kernel_write_nochange_rcu, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE },
+		},
+	};
 	bool match_expect = false;
 
+	test_kernel_write_nochange_rcu(); /* Reset value. */
 	begin_test_checks(test_kernel_write_nochange_rcu, test_kernel_read);
 	do {
-		match_expect = report_matches(&expect);
+		match_expect = report_matches(&expect_rw) || report_matches(&expect_ww);
 	} while (!end_test_checks(match_expect));
 	KUNIT_EXPECT_TRUE(test, match_expect);
 }
-- 
2.31.1.189.g2e36527f23

