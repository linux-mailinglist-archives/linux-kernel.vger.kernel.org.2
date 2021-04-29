Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDB736EB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhD2N1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:27:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17069 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhD2N1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:27:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FWGSK74B4z16Mv0;
        Thu, 29 Apr 2021 21:24:33 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Apr 2021
 21:26:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/5] Cleanup and fixup for huge_memory
Date:   Thu, 29 Apr 2021 21:26:43 +0800
Message-ID: <20210429132648.305447-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove dedicated macro and remove
unnecessary tlb_remove_page_size() for huge zero pmd. Also this adds
missing read-only THP checking for transparent_hugepage_enabled() and
avoids discarding hugepage if other processes are mapping it. More
details can be found in the respective changelogs. Thanks!

v1->v2:
  collect Reviewed-by tag
  add missing check for read-only THP per Yang Shi

Miaohe Lin (5):
  mm/huge_memory.c: remove dedicated macro HPAGE_CACHE_INDEX_MASK
  mm/huge_memory.c: use page->deferred_list
  mm/huge_memory.c: add missing read-only THP checking in
    transparent_hugepage_enabled()
  mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge
    zero pmd
  mm/huge_memory.c: don't discard hugepage if other processes are
    mapping it

 include/linux/huge_mm.h | 27 +++++++++++++++++++--------
 mm/huge_memory.c        | 15 +++++++++------
 mm/khugepaged.c         |  4 +---
 mm/shmem.c              |  3 +--
 4 files changed, 30 insertions(+), 19 deletions(-)

-- 
2.23.0

