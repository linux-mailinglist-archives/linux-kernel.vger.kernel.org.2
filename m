Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5E3E44C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhHIL0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhHIL0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:26:04 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABFC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:25:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id q10-20020a05622a04cab0290267bc0213a9so7484832qtx.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ydXqiAdNSjBzhuq33PSd4SOBXITdQ3zj3AJIcpBrcC0=;
        b=ACFrOCrPC/gWYLJhrHcvZMryCeWRxLmYeAVxd7PxobMhHBsItOpjOhhG0fQ776uxp4
         5kZWjUVhU6EHhuYOYxy4j1JTin04wc8uUJYZu9D3smwb4D3ph5pjLNMMShBRwKVSFmuI
         zvJ919MH+EyPEcv/0tvSJ21+2d8vVh7fWBrpJ439A3tGx4kY7kIJgeNvU66WVWPqApij
         +F6VMymsPOUzQouIuyzd/erwIPVn91HbkRllcDtRCJ511rxvyibrwJ5oV4CbWLhTHG84
         2EYJCU33XE7Y4iuGFe6DWvVtXkucf7dGHdo0fvz8zbX55/5q8LhU0Hm4AllOI13ZGNNF
         ObgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ydXqiAdNSjBzhuq33PSd4SOBXITdQ3zj3AJIcpBrcC0=;
        b=dW1dfz8MA9A2TYChEmB8fZqkA2PN/YnB5cLed7BIJk5jFdOJ/y1ZjKDfxhbR/rXm8Q
         X89+e9ZIUqSxRadpwOyYdFJD4W4/PVjPPNVxreOYL8rV5Ruo84zPk7kWiD0PsSMtddbf
         24/XZlf04lrrS8qP8VQG6sER5Xu6FsKjLtLC0awKaE1ari9z2kH+N22kN6YX9wwKi5X9
         WTGmO5caVTMSFZx0iC9DAJ4TyC2c5ziV4Y9oOwOkwWvaPIhFPFBV9KbgYtZfO3SORtNc
         wB95FGhFjTm2nMxOIrqtVo+TEHzT/FnJMOIIQ/kSUPVFxqpU33aNzeYGYqz+BTWbVJkq
         z4QQ==
X-Gm-Message-State: AOAM533IjQK7KRMJdkdP2dEbyDzCfJGXNtCnTrPiMs9hQn9J8mt0vnye
        wIWvNfKUMpvn6O74FtNSCadYjO4+XQ==
X-Google-Smtp-Source: ABdhPJyZvJyYUss9gXvKdo4+uHXzCR/M1KhHgkwmptf1noIruf11bBtn3hSfG3LUoCI4LjbcG2bWLaJBVA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e5a3:e652:2b8b:ef12])
 (user=elver job=sendgmr) by 2002:a0c:e908:: with SMTP id a8mr23093025qvo.61.1628508343117;
 Mon, 09 Aug 2021 04:25:43 -0700 (PDT)
Date:   Mon,  9 Aug 2021 13:25:11 +0200
In-Reply-To: <20210809112516.682816-1-elver@google.com>
Message-Id: <20210809112516.682816-4-elver@google.com>
Mime-Version: 1.0
References: <20210809112516.682816-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH 3/8] kcsan: test: Fix flaky test case
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        boqun.feng@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, then we may also see data
races between the writers only. If we get unlucky and never capture a
read-write data race, but only the write-write data races, then the
test_no_value_change* test cases may incorrectly fail.

The second problem is that the initial value needs to be reset, as
otherwise we might actually observe a value change at the start.

Fix it by also looking for the write-write data races, and resetting the
value to what will be written.

Signed-off-by: Marco Elver <elver@google.com>
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
2.32.0.605.g8dce9f2422-goog

