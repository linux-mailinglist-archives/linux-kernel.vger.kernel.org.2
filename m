Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA244D1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKKGKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:10:02 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53049 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhKKGJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:09:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uw.HkwB_1636610826;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uw.HkwB_1636610826)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 14:07:08 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] mm/damon/core: Using function abs() instead of diff_of()
Date:   Thu, 11 Nov 2021 14:07:03 +0800
Message-Id: <2a8343ffce2591717993fa4522ce2dbdae77a71c.1636610337.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1636610337.git.xhao@linux.alibaba.com>
References: <cover.1636610337.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel, we can use abs(a - b) to get the absolute value,
So there is no need to redefine a new one.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f37c17b53814..4d2c3a0c7c8a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -757,8 +757,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 	damon_destroy_region(r, t);
 }

-#define diff_of(a, b) (a > b ? a - b : b - a)
-
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -772,13 +770,13 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;

 	damon_for_each_region_safe(r, next, t) {
-		if (diff_of(r->nr_accesses, r->last_nr_accesses) > thres)
+		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else
 			r->age++;

 		if (prev && prev->ar.end == r->ar.start &&
-		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres &&
+		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
 		    sz_damon_region(prev) + sz_damon_region(r) <= sz_limit)
 			damon_merge_two_regions(t, prev, r);
 		else
--
2.31.0
