Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F372438FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhJYGou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhJYGot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:44:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A65603E9;
        Mon, 25 Oct 2021 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635144148;
        bh=OsynxOjzCTEacNWO7nrFI2IM+6xXMAuFFdcmvLCilkk=;
        h=From:To:Cc:Subject:Date:From;
        b=X3kb091lmY9mw6+CNpNKpKllG0NoQGhayCFo3g9iks5stJGwLqzwLtoxdX2uaUFJo
         XQ0yL+Ahsa7+yPvzgFBgqlYwRkYpoHz2OhMKtRfqQTnX4lYgenk09p2QpTDQURxR7S
         JXflPyXjPhAQ4W70eYt5oIzb1PxtorHBW9ruzux2BFsKgjdFcG4gUAHaGcaUxqCZ8K
         yBnu/4dsxLjqAdoxgwiNlBzAByfFvT9KGAyyoXVP/Q0n4xtcWuS/kyuI2YECN7QoU8
         5xmSxdPpnHdX0GxpYuRBsZk205CiBeDFPGI1dipZGdcltBgb7dstVbxpFQ1wRyasPj
         VrRII9/mo0y0g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     lkp@intel.com, hannes@cmpxchg.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon: Fix missing-prototype build warning for 'damon_pa_apply_scheme()'
Date:   Mon, 25 Oct 2021 06:42:20 +0000
Message-Id: <20211025064220.13904-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot found[1] commit ccd554f15bb1 ("mm/damon/paddr: support
the pageout scheme") on the -mm tree[2], which is introduced by the
patch titled 'mm-damon-paddr-support-the-pageout-scheme.patch'[3]
introduces following build warning, and therefore the build fails if
'CONFIG_WERROR=y'.

    linux/mm/damon/paddr.c:216:5: error: no previous prototype for ‘damon_pa_apply_scheme’ [-Werror=missing-prototypes]
     int damon_pa_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
         ^~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    linux/scripts/Makefile.build:277: recipe for target 'mm/damon/paddr.o' failed

This commit fixes the warning by adding the missed prototype in the
header file.

Note: Because the reported '.config' introduces warnings on not only
DAMON but also other subsystems, I tested for only DAMON by adding the
below compiler flag in mm/damon/Makefile.

    ccflags-$(CONFIG_DAMON_PADDR)  += -Werror -Wmissing-prototypes

[1] https://lore.kernel.org/lkml/202110250029.5rftt73s-lkp@intel.com/
[2] https://github.com/hnaz/linux-mm/commit/ccd554f15bb1cd977d740c1ea8241ecf95108c94
[3] https://lore.kernel.org/mm-commits/20211019213137.91_rr1GrX%25akpm@linux-foundation.org/

Fixes: ccd554f15bb1 ("mm/damon/paddr: support the pageout scheme") in -mm tree
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 715dadd21f7c..9a327bc787b5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -357,6 +357,8 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
 void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
 unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
 bool damon_pa_target_valid(void *t);
+int damon_pa_apply_scheme(struct damon_ctx *context, struct damon_target *t,
+		struct damon_region *r, struct damos *scheme);
 void damon_pa_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_PADDR */
-- 
2.17.1

