Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F226333D418
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhCPMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:42:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13944 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhCPMlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:41:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0CXT3QS6zkb01;
        Tue, 16 Mar 2021 20:39:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 20:40:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <willy@infradead.org>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <peterx@redhat.com>, <yulei.kernel@gmail.com>, <walken@google.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <thomas_os@shipmail.org>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/6] Some cleanups for huge_memory
Date:   Tue, 16 Mar 2021 08:40:01 -0400
Message-ID: <20210316124007.20474-1-linmiaohe@huawei.com>
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

v1->v2:
rename try_to_split_huge_pmd_address and move up comments.

Miaohe Lin (6):
  mm/huge_memory.c: rework the function vma_adjust_trans_huge()
  mm/huge_memory.c: make get_huge_zero_page() return bool
  mm/huge_memory.c: rework the function do_huge_pmd_numa_page() slightly
  mm/huge_memory.c: remove redundant PageCompound() check
  mm/huge_memory.c: remove unused macro
    TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG
  mm/huge_memory.c: use helper function migration_entry_to_page()

 include/linux/huge_mm.h |  3 --
 mm/huge_memory.c        | 69 ++++++++++++++++++-----------------------
 2 files changed, 31 insertions(+), 41 deletions(-)

-- 
2.19.1

