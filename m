Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439B13FED8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbhIBMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:13:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9396 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbhIBMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:13:22 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H0fnz33K4z8vJ8;
        Thu,  2 Sep 2021 20:08:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 2 Sep
 2021 20:12:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/5] Cleanups and fixup for page_alloc
Date:   Thu, 2 Sep 2021 20:12:37 +0800
Message-ID: <20210902121242.41607-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove meaningless VM_BUG_ON(), use
helpers to simplify the code and remove obsolete comment. Also we avoid
allocating highmem pages via alloc_pages_exact[_nid]. More details can
be found in the respective changelogs. Thanks!

v1->v2:
  collect Reviewed-by and Acked-by tag
  preserve valid comments for free_pcppages_bulk
  send patch "mm/page_alloc.c: avoid accessing uninitialized pcp page
migratetype" separately.
  s/__GFP_COMP/(__GFP_COMP|__GFP_HIGHMEM)/g throughout both
alloc_pages_exact() and alloc_pages_exact_nid()

Miaohe Lin (5):
  mm/page_alloc.c: remove meaningless VM_BUG_ON() in pindex_to_order()
  mm/page_alloc.c: simplify the code by using macro K()
  mm/page_alloc.c: fix obsolete comment in free_pcppages_bulk()
  mm/page_alloc.c: use helper function zone_spans_pfn()
  mm/page_alloc.c: avoid allocating highmem pages via
    alloc_pages_exact[_nid]

 mm/page_alloc.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

-- 
2.23.0

