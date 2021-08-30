Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED13FB790
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhH3OLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:11:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9387 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH3OLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:11:17 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GysYX1vDMz8wh8;
        Mon, 30 Aug 2021 22:06:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 30
 Aug 2021 22:10:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 0/6] Cleanups and fixup for page_alloc
Date:   Mon, 30 Aug 2021 22:10:45 +0800
Message-ID: <20210830141051.64090-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove meaningless VM_BUG_ON(), use
helpers to simplify the code and remove obsolete comment. Also we fix
the potential accessing to uninitialized pcp page migratetype and so
on. More details can be found in the respective changelogs. Thanks!

Miaohe Lin (6):
  mm/page_alloc.c: remove meaningless VM_BUG_ON() in pindex_to_order()
  mm/page_alloc.c: simplify the code by using macro K()
  mm/page_alloc.c: remove obsolete comment in free_pcppages_bulk()
  mm/page_alloc.c: use helper function zone_spans_pfn()
  mm/page_alloc.c: avoid accessing uninitialized pcp page migratetype
  mm/page_alloc.c: avoid allocating highmem pages via
    alloc_pages_exact_nid()

 mm/page_alloc.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

-- 
2.23.0

