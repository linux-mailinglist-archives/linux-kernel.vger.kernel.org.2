Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D8346063
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhCWNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:55:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14131 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhCWNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:54:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4Xr525Kmz19HXN;
        Tue, 23 Mar 2021 21:52:53 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 21:54:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>, <aquini@redhat.com>,
        <david@redhat.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/5] Cleanup and fixup for mm/migrate.c
Date:   Tue, 23 Mar 2021 09:54:00 -0400
Message-ID: <20210323135405.65059-1-linmiaohe@huawei.com>
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

v1->v2:
Fix removing the wrong assertion per Rafael.
Use pr_warn_once() instead per David.
Collect Reviewed-by tag.

Miaohe Lin (5):
  mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on
    putback_movable_page()
  mm/migrate.c: remove unnecessary rc != MIGRATEPAGE_SUCCESS check in
    'else' case
  mm/migrate.c: fix potential indeterminate pte entry in
    migrate_vma_insert_page()
  mm/migrate.c: use helper migrate_vma_collect_skip() in
    migrate_vma_collect_hole()
  mm/migrate.c: fix potential deadlock in NUMA balancing shared exec THP
    case

 mm/migrate.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.19.1

