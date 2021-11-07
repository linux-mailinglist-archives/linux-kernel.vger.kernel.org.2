Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAF44723D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhKGJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 04:00:23 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58230 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235249AbhKGJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 04:00:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UvOAAGr_1636275456;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UvOAAGr_1636275456)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Nov 2021 16:57:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Improve the migration stats
Date:   Sun,  7 Nov 2021 16:57:24 +0800
Message-Id: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

According to talk with Zi Yan [1], this patch set changes the return
value of migrate_pages() to avoid returning a number which is larger
than the number of pages the users tried to migrate by move_pages() syscall.
Also fix the hugetlb migration stats and migration stats in
trace_mm_compaction_migratepages(). Please help to review. Thanks.

[1] https://lore.kernel.org/linux-mm/7E44019D-2A5D-4BA7-B4D5-00D4712F1687@nvidia.com/

Changes from RFC:
 - Increase nr_thp_failed when THP is split, no matter how many subpages are
 migrated successfully.
 - Add reviewed-by tags.

Baolin Wang (3):
  mm: migrate: Fix the return value of migrate_pages()
  mm: migrate: Correct the hugetlb migration stats
  mm: compaction: Fix the migration stats in
    trace_mm_compaction_migratepages()

 include/trace/events/compaction.h | 24 +++-----------
 mm/compaction.c                   |  7 ++--
 mm/migrate.c                      | 68 ++++++++++++++++++++++++++++-----------
 3 files changed, 57 insertions(+), 42 deletions(-)

-- 
1.8.3.1

