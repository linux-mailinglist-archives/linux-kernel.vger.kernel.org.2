Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6136C70D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbhD0NdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:33:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17403 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbhD0NdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:33:15 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FV2h50Mw2zlZkV;
        Tue, 27 Apr 2021 21:30:29 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 Apr 2021
 21:32:21 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Cleanup and fixup for huge_memory
Date:   Tue, 27 Apr 2021 21:32:09 +0800
Message-ID: <20210427133214.2270207-1-linmiaohe@huawei.com>
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

Miaohe Lin (5):
  mm/huge_memory.c: remove dedicated macro HPAGE_CACHE_INDEX_MASK
  mm/huge_memory.c: use page->deferred_list
  mm/huge_memory.c: add missing read-only THP checking in
    transparent_hugepage_enabled()
  mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge
    zero pmd
  mm/huge_memory.c: don't discard hugepage if other processes are
    mapping it

 include/linux/huge_mm.h |  6 ++----
 mm/huge_memory.c        | 12 ++++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.23.0

