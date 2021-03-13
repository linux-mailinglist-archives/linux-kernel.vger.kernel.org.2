Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA17339D91
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhCMKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:33:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:14331 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhCMKdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:33:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DyJr21G1Dz8wmC;
        Sat, 13 Mar 2021 18:31:14 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Sat, 13 Mar 2021
 18:32:55 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <richard.weiyang@linux.alibaba.com>, <peterx@redhat.com>,
        <anshuman.khandual@arm.com>, <thomas_os@shipmail.org>,
        <rcampbell@nvidia.com>, <aneesh.kumar@linux.ibm.com>,
        <yang.shi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/6] Some cleanups for huge_memory
Date:   Sat, 13 Mar 2021 05:32:18 -0500
Message-ID: <20210313103225.16607-1-linmiaohe@huawei.com>
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
This series contains cleanups to rework some function logics to make it
more readable, use helper function and so on. More details can be found
in the respective changelogs. Thanks!

Miaohe Lin (6):
  mm/huge_memory.c: rework the function vma_adjust_trans_huge()
  mm/huge_memory.c: make get_huge_zero_page() return bool
  mm/huge_memory.c: rework the function do_huge_pmd_numa_page() slightly
  mm/huge_memory.c: remove redundant PageCompound() check
  mm/huge_memory.c: remove unused macro
    TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG
  mm/huge_memory.c: use helper function migration_entry_to_page()

 include/linux/huge_mm.h |  3 ---
 mm/huge_memory.c        | 48 ++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

-- 
2.19.1

