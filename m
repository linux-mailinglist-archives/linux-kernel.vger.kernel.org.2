Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E178B3492EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCYNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:16:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14594 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCYNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:16:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5ltS4Q9Qz19HZk;
        Thu, 25 Mar 2021 21:14:08 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:16:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3 0/5] Cleanup and fixup for mm/migrate.c
Date:   Thu, 25 Mar 2021 09:15:19 -0400
Message-ID: <20210325131524.48181-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unnecessary VM_BUG_ON_PAGE and
rc != MIGRATEPAGE_SUCCESS check. Also use helper function to remove some
duplicated codes. What's more, this fixes potential deadlock in NUMA
balancing shared exec THP case and so on. More details can be found in
the respective changelogs. Thanks!

v2->v3:
Collect Reviewed-by tag
Revert commit c77c5cbafe54 ("mm: migrate: skip shared exec THP for NUMA
balancing") per Yang
Remove all 3 VM_BUG_ON_PAGE and make putback_movable_page static per Yang

v1->v2:
Fix removing the wrong assertion per Rafael.
Use pr_warn_once() instead per David.
Collect Reviewed-by tag.

Miaohe Lin (5):
  mm/migrate.c: make putback_movable_page() static
  mm/migrate.c: remove unnecessary rc != MIGRATEPAGE_SUCCESS check in
    'else' case
  mm/migrate.c: fix potential indeterminate pte entry in
    migrate_vma_insert_page()
  mm/migrate.c: use helper migrate_vma_collect_skip() in
    migrate_vma_collect_hole()
  Revert "mm: migrate: skip shared exec THP for NUMA balancing"

 include/linux/migrate.h |  1 -
 mm/migrate.c            | 62 +++++++++++++++--------------------------
 2 files changed, 22 insertions(+), 41 deletions(-)

-- 
2.19.1

