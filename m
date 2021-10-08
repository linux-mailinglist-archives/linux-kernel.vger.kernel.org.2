Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D201E426711
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhJHJrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhJHJrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:47:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A403E61027;
        Fri,  8 Oct 2021 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633686320;
        bh=PPuno9RwwKhrsxW1OCwnBrO3F3JbkyV/+tb99kiysMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIdrN/uowGfC64APYFC65W+kS1MtrWFzA+q7e/i7dySTX3mtccLcjWBwfxBfeoM/U
         tzjRK272HiuDexC/Mh6qDFk1QUTPtL1YHolYRF6QZyePQJRef963BAWPPVSRQWmnyn
         LZB9hh4A+TZsWdy1TWdAqiPP20WL4GglJn3rrGhmjs00WhcNdKTX+ApuRJ8jgX82Lj
         atBEdDEG6E4/m2V68bwWFWCepnZovoN45DA0aA4rlHltwJRDsJm1y0XCbed2pxZI9f
         vio7w3Pd8D+oPK3GUJ70JVhQ3JX4lX+TT0ltZXNUYNRhiGX6b1c0z/BfiLywlRZv6Q
         8dUlraEISTXxw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm/damon/dbgfs-test: Implement kunit tests for the record feature
Date:   Fri,  8 Oct 2021 09:45:07 +0000
Message-Id: <20211008094509.16179-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008094509.16179-1-sj@kernel.org>
References: <20211008094509.16179-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements kunit tests for the monitoring results record
feture.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/damon/dbgfs-test.h | 88 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 4eddcfa73996..23573ade7ac2 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -109,9 +109,97 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	dbgfs_destroy_ctx(ctx);
 }
 
+static void damon_dbgfs_test_set_recording(struct kunit *test)
+{
+	struct damon_ctx *ctx = dbgfs_new_ctx();
+	struct dbgfs_recorder *rec = ctx->callback.private;
+	int err;
+
+	err = dbgfs_set_recording(ctx, 42, "foo");
+	KUNIT_EXPECT_EQ(test, err, -EINVAL);
+	dbgfs_set_recording(ctx, 4242, "foo.bar");
+	KUNIT_EXPECT_EQ(test, rec->rbuf_len, 4242u);
+	KUNIT_EXPECT_STREQ(test, rec->rfile_path, "foo.bar");
+	dbgfs_set_recording(ctx, 424242, "foo");
+	KUNIT_EXPECT_EQ(test, rec->rbuf_len, 424242u);
+	KUNIT_EXPECT_STREQ(test, rec->rfile_path, "foo");
+
+	dbgfs_destroy_ctx(ctx);
+}
+
+static void damon_dbgfs_test_write_rbuf(struct kunit *test)
+{
+	struct damon_ctx *ctx = dbgfs_new_ctx();
+	struct dbgfs_recorder *rec = ctx->callback.private;
+	char *data;
+
+	dbgfs_set_recording(ctx, 4242, "damon.data");
+
+	data = "hello";
+	dbgfs_write_rbuf(ctx, data, strnlen(data, 256));
+	KUNIT_EXPECT_EQ(test, rec->rbuf_offset, 5u);
+
+	dbgfs_write_rbuf(ctx, data, 0);
+	KUNIT_EXPECT_EQ(test, rec->rbuf_offset, 5u);
+
+	KUNIT_EXPECT_STREQ(test, (char *)rec->rbuf, data);
+
+	dbgfs_destroy_ctx(ctx);
+}
+
+/*
+ * Test dbgfs_after_aggregation()
+ *
+ * dbgfs sets dbgfs_after_aggregation() as aggregate callback.  It stores the
+ * aggregated monitoring information ('->nr_accesses' of each regions) to the
+ * result buffer.
+ */
+static void damon_dbgfs_test_aggregate(struct kunit *test)
+{
+	struct damon_ctx *ctx = dbgfs_new_ctx();
+	struct dbgfs_recorder *rec = ctx->callback.private;
+	unsigned long target_ids[] = {1, 2, 3};
+	unsigned long saddr[][3] = {{10, 20, 30}, {5, 42, 49}, {13, 33, 55} };
+	unsigned long eaddr[][3] = {{15, 27, 40}, {31, 45, 55}, {23, 44, 66} };
+	unsigned long accesses[][3] = {{42, 95, 84}, {10, 20, 30}, {0, 1, 2} };
+	struct damon_target *t;
+	struct damon_region *r;
+	int it, ir;
+	ssize_t sz, sr, sp;
+
+	/* Make DAMON consider target id as plain number */
+	ctx->primitive.target_valid = NULL;
+	ctx->primitive.cleanup = NULL;
+
+	dbgfs_set_recording(ctx, 4242, "damon.data");
+	damon_set_targets(ctx, target_ids, 3);
+
+	it = 0;
+	damon_for_each_target(t, ctx) {
+		for (ir = 0; ir < 3; ir++) {
+			r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
+			r->nr_accesses = accesses[it][ir];
+			damon_add_region(r, t);
+		}
+		it++;
+	}
+	dbgfs_after_aggregation(ctx);
+
+	/* The aggregated information should be written in the buffer */
+	sr = sizeof(r->ar.start) + sizeof(r->ar.end) + sizeof(r->nr_accesses);
+	sp = sizeof(t->id) + sizeof(unsigned int) + 3 * sr;
+	sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
+	KUNIT_EXPECT_EQ(test, (unsigned int)sz, rec->rbuf_offset);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_dbgfs_test_str_to_target_ids),
 	KUNIT_CASE(damon_dbgfs_test_set_targets),
+	KUNIT_CASE(damon_dbgfs_test_set_recording),
+	KUNIT_CASE(damon_dbgfs_test_write_rbuf),
+	KUNIT_CASE(damon_dbgfs_test_aggregate),
 	{},
 };
 
-- 
2.17.1

