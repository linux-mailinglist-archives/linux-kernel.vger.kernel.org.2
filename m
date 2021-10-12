Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA742AE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhJLU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhJLU7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEA6160E90;
        Tue, 12 Oct 2021 20:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072250;
        bh=dIzGTs3S2h6xBXJp02bhYZBaLj6puUdqW2ci75lTKtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/U1Y17qQpNwwjr1HMIYe7G1DbWCJ9YwRkRRmsltZJBjEhUtnPbBbAObVtySV5wCD
         DhvZmq8yyqwDpb8vb6PYd4KbizkrQSfx5Gu/UaDOelpzevkHi1enqPZsxPWS5XvK6b
         Bobjfix9DYgn5v1axsBUTmZX6mb6PFw4LOKUuq4KT//ZrOxYok7y4f1m24zUZhU5oh
         k+fY9RpR8h5v0lDizkoPk0Hk5c7N2X5zRHEa/3R5oUrNuIps94jH+yo9IvzptcY9tL
         Ky9lGQ4TpvwaWw3qBas2dpRZ5pkkJripbf6cWXXvd7lTNWhLK/b8096F143mEKyZQN
         VTk7INaXTZy8Q==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] mm/damon/dbgfs-test: Add a unit test case for 'init_regions'
Date:   Tue, 12 Oct 2021 20:57:06 +0000
Message-Id: <20211012205711.29216-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds another test case for the new feature, 'init_regions'.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/damon/dbgfs-test.h | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 4eddcfa73996..104b22957616 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -109,9 +109,63 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	dbgfs_destroy_ctx(ctx);
 }
 
+static void damon_dbgfs_test_set_init_regions(struct kunit *test)
+{
+	struct damon_ctx *ctx = damon_new_ctx();
+	unsigned long ids[] = {1, 2, 3};
+	/* Each line represents one region in ``<target id> <start> <end>`` */
+	char * const valid_inputs[] = {"2 10 20\n 2   20 30\n2 35 45",
+		"2 10 20\n",
+		"2 10 20\n1 39 59\n1 70 134\n  2  20 25\n",
+		""};
+	/* Reading the file again will show sorted, clean output */
+	char * const valid_expects[] = {"2 10 20\n2 20 30\n2 35 45\n",
+		"2 10 20\n",
+		"1 39 59\n1 70 134\n2 10 20\n2 20 25\n",
+		""};
+	char * const invalid_inputs[] = {"4 10 20\n",	/* target not exists */
+		"2 10 20\n 2 14 26\n",		/* regions overlap */
+		"1 10 20\n2 30 40\n 1 5 8"};	/* not sorted by address */
+	char *input, *expect;
+	int i, rc;
+	char buf[256];
+
+	damon_set_targets(ctx, ids, 3);
+
+	/* Put valid inputs and check the results */
+	for (i = 0; i < ARRAY_SIZE(valid_inputs); i++) {
+		input = valid_inputs[i];
+		expect = valid_expects[i];
+
+		rc = set_init_regions(ctx, input, strnlen(input, 256));
+		KUNIT_EXPECT_EQ(test, rc, 0);
+
+		memset(buf, 0, 256);
+		sprint_init_regions(ctx, buf, 256);
+
+		KUNIT_EXPECT_STREQ(test, (char *)buf, expect);
+	}
+	/* Put invlid inputs and check the return error code */
+	for (i = 0; i < ARRAY_SIZE(invalid_inputs); i++) {
+		input = invalid_inputs[i];
+		pr_info("input: %s\n", input);
+		rc = set_init_regions(ctx, input, strnlen(input, 256));
+		KUNIT_EXPECT_EQ(test, rc, -EINVAL);
+
+		memset(buf, 0, 256);
+		sprint_init_regions(ctx, buf, 256);
+
+		KUNIT_EXPECT_STREQ(test, (char *)buf, "");
+	}
+
+	damon_set_targets(ctx, NULL, 0);
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_dbgfs_test_str_to_target_ids),
 	KUNIT_CASE(damon_dbgfs_test_set_targets),
+	KUNIT_CASE(damon_dbgfs_test_set_init_regions),
 	{},
 };
 
-- 
2.17.1

