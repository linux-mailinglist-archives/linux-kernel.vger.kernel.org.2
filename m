Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0672C3C340A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhGJKGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:06:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6908 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhGJKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:06:04 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GMQVr2Fvbz6v0H;
        Sat, 10 Jul 2021 17:59:48 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 10
 Jul 2021 18:03:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>, <alexs@kernel.org>,
        <apopple@nvidia.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Cleanup and fixup for vmscan
Date:   Sat, 10 Jul 2021 18:03:24 +0800
Message-ID: <20210710100329.49174-1-linmiaohe@huawei.com>
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
This series contains cleanups to remove unneeded return value, misleading
comment and so on. Also this puts the redirtied MADV_FREE pages back to
anonymous LRU list. More details can be found in the respective changelogs.
Thanks!

Miaohe Lin (5):
  mm/vmscan: put the redirtied MADV_FREE pages back to anonymous LRU
    list
  mm/vmscan: remove misleading setting to sc->priority
  mm/vmscan: remove unneeded return value of kswapd_run()
  mm/vmscan: add 'else' to remove check_pending label
  mm/vmscan: fix misleading comment in isolate_lru_pages()

 include/linux/swap.h |  2 +-
 mm/vmscan.c          | 26 +++++++++-----------------
 2 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.23.0

