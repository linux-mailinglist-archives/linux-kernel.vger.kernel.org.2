Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72B3342C76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCTLp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:45:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14040 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhCTLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:45:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F2bGW4VrpzPkfN;
        Sat, 20 Mar 2021 17:35:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Mar 2021
 17:37:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <shy828301@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Cleanup and fixup for mm/migrate.c
Date:   Sat, 20 Mar 2021 05:36:56 -0400
Message-ID: <20210320093701.12829-1-linmiaohe@huawei.com>
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

