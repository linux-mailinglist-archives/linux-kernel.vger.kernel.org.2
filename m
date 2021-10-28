Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4380B43DD67
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhJ1JJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1JJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:09:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95DD460232;
        Thu, 28 Oct 2021 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635411998;
        bh=8sAgKTwdQzQ8h0WZL0biBhP95bRt2tmfL7nHB6meuR0=;
        h=From:To:Cc:Subject:Date:From;
        b=rfIMSVP8xEIqSvEz+AR5/ZsPBEVBvzLxn5NIlSxmCWz4ErvVEoLeNHAjKGHydq1Vz
         SyteG3ixsKXjr2S6Yh94XROyAVaUwTRNu+I6Waai0pVmRpCgRm7lN8PYxaqkdmJonh
         OrS4gphOu3cvxE2ZsTpaWSQKoOvXe02cVE2fRCAgyMmtynL70npyWbG+z+jeFtJcSw
         B7bPufwyGA5tzr7BgvNXe3xPXzekc2E3NLWC4jCo4KGUS3vzOcwt5OYDU7YVowQqlF
         NJxobGMlDisplb8s7fOHrLn5e8kDTPp4sOruY4FwbyGDrqfVBluQMeV4SNHTKw3I/+
         nEW/dUsWfXn3g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/core-test: Fix wrong expectations for 'damon_split_regions_of()'
Date:   Thu, 28 Oct 2021 09:06:28 +0000
Message-Id: <20211028090628.14948-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunit test cases for 'damon_split_regions_of()' expects the number of
regions after calling the function will be same to their request
('nr_sub').  However, the requested number is just an upper-limit,
because the function randomly decides the size of each sub-region.  This
commit fixes the wrong expectation.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index c938a9c34e6c..7008c3735e99 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -219,14 +219,14 @@ static void damon_test_split_regions_of(struct kunit *test)
 	r = damon_new_region(0, 22);
 	damon_add_region(r, t);
 	damon_split_regions_of(c, t, 2);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2u);
+	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target(42);
 	r = damon_new_region(0, 220);
 	damon_add_region(r, t);
 	damon_split_regions_of(c, t, 4);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 4u);
+	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 	damon_destroy_ctx(c);
 }
-- 
2.17.1

