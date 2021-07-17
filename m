Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D443CC199
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 08:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhGQHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 03:02:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7023 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGQHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 03:02:08 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GRf2d1MfhzYcwK;
        Sat, 17 Jul 2021 14:53:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 17
 Jul 2021 14:59:10 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <yuzhao@google.com>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/4] Cleanups for vmscan
Date:   Sat, 17 Jul 2021 14:59:07 +0800
Message-ID: <20210717065911.61497-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unneeded return value, misleading
setting and so on. Also this remove the PageDirty check after MADV_FREE
pages are page_ref_freezed. More details can be found in the respective
changelogs. Thanks!

v1->v2:
  collect Acked-by tag
  remove patch "mm/vmscan: fix misleading comment in isolate_lru_pages()"
  remove PageDirty check instead of setting SwapBacked in shrink_page_list

Miaohe Lin (4):
  mm/vmscan: remove the PageDirty check after MADV_FREE pages are
    page_ref_freezed
  mm/vmscan: remove misleading setting to sc->priority
  mm/vmscan: remove unneeded return value of kswapd_run()
  mm/vmscan: add 'else' to remove check_pending label

 include/linux/swap.h |  2 +-
 mm/vmscan.c          | 36 +++++++++++++++---------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

-- 
2.23.0

