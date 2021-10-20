Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0C43478F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhJTJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:05:30 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40997 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhJTJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:05:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut1iyHi_1634720585;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut1iyHi_1634720585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 17:03:11 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] mm/damon: Remove unnecessary variable initialization
Date:   Wed, 20 Oct 2021 17:03:00 +0800
Message-Id: <b7df8d3dad0943a37e01f60c441b1968b2b20354.1634720326.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1634720326.git.xhao@linux.alibaba.com>
References: <cover.1634720326.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'damon_va_apply_three_regions', There is no
need to set variable 'i' as 0

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b8ba44f69db6..90be463efff7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -305,7 +305,7 @@ static void damon_va_apply_three_regions(struct damon_target *t,
 		struct damon_addr_range bregions[3])
 {
 	struct damon_region *r, *next;
-	unsigned int i = 0;
+	unsigned int i;

 	/* Remove regions which are not in the three big regions now */
 	damon_for_each_region_safe(r, next, t) {
--
2.31.0
