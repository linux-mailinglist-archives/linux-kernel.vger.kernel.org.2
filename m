Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652841EDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhJAM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhJAM6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:58:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BAB161A8E;
        Fri,  1 Oct 2021 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092977;
        bh=OCYsuTxAX9XCeJG6jmvCduDTUJshbOFoeOK6I+5rb4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJJ9+qhO0H/ejsPIcPfwLqhD16oy2FXrOSVax6qKxpKR27f+2tRoznc/n/+iVp69y
         k/PC+7ZPNBYnwrsZxizs2QsZ7GRwMVQooc8RNEd8bL3fS+hXAiDUzh76HkCTvQDgDF
         qf4BXvCa7H8nE+fjUfN61MQYyOgQcERGYyW1AcyZE5ngwxQAeag1Z9j1rLWrK9B13M
         d7I7vHHKN+bPeUc5GjEkzusCijasKmw0xIZJHO4jjl+LNNA9zPgEqrjNcPESOV6dzY
         Y/XqVj0YJ9b91y8sJZ5qV4ttqAPu1x8y4oVNDSARXUm1p0Ppy+V41Qi/r/AAQOhPfH
         9ap9SyN7PkReg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mm/damon/core: Account age of target regions
Date:   Fri,  1 Oct 2021 12:55:58 +0000
Message-Id: <20211001125604.29660-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001125604.29660-1-sj@kernel.org>
References: <20211001125604.29660-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON can be used for data access pattern aware memory management
optimizations.  For that, users should run DAMON, read the monitoring
results, analyze it, plan a new memory management scheme, and apply the
new scheme by themselves.  It would not be too hard, but still require
some level of effort.  For complicated cases, this effort is inevitable.

That said, in many cases, users would simply want to apply an actions to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

For such optimizations, users will need to first account the age of each
region themselves.  To reduce such efforts, this commit implements a
simple age account of each region in DAMON.  For each aggregation step,
DAMON compares the access frequency with that from last aggregation and
reset the age of the region if the change is significant.  Else, the age
is incremented.  Also, in case of the merge of regions, the region
size-weighted average of the ages is set as the age of merged new
region.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ++++++++++
 mm/damon/core.c       | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 755d70804705..3e8215debbd4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -31,12 +31,22 @@ struct damon_addr_range {
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
+ * @age:		Age of this region.
+ *
+ * @age is initially zero, increased for each aggregation interval, and reset
+ * to zero again if the access frequency is significantly changed.  If two
+ * regions are merged into a new region, both @nr_accesses and @age of the new
+ * region are set as region size-weighted average of those of the two regions.
  */
 struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
+
+	unsigned int age;
+/* private: Internal value for age calculation. */
+	unsigned int last_nr_accesses;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d993db50280c..3efbe80779db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -45,6 +45,9 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
+	region->age = 0;
+	region->last_nr_accesses = 0;
+
 	return region;
 }
 
@@ -444,6 +447,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 
 		damon_for_each_region(r, t) {
 			trace_damon_aggregated(t, r, damon_nr_regions(t));
+			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
 	}
@@ -461,6 +465,7 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
+	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 	damon_destroy_region(r, t);
 }
@@ -480,6 +485,11 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
+		if (diff_of(r->nr_accesses, r->last_nr_accesses) > thres)
+			r->age = 0;
+		else
+			r->age++;
+
 		if (prev && prev->ar.end == r->ar.start &&
 		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
 		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
@@ -527,6 +537,9 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 
 	r->ar.end = new->ar.start;
 
+	new->age = r->age;
+	new->last_nr_accesses = r->last_nr_accesses;
+
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
 
-- 
2.17.1

