Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB444402D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKCKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:54:06 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:58353 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhKCKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:54:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uutr4md_1635936686;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uutr4md_1635936686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Nov 2021 18:51:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Improve the migration stats
Date:   Wed,  3 Nov 2021 18:51:13 +0800
Message-Id: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
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

Baolin Wang (3):
  mm: migrate: Fix the return value of migrate_pages()
  mm: migrate: Correct the hugetlb migration stats
  mm: compaction: Fix the migration stats in
    trace_mm_compaction_migratepages()

 include/trace/events/compaction.h | 24 ++++--------------------
 mm/compaction.c                   |  7 ++++---
 mm/migrate.c                      | 25 ++++++++++++++-----------
 3 files changed, 22 insertions(+), 34 deletions(-)

-- 
1.8.3.1

