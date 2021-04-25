Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B7D36A662
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhDYJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 05:55:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3531 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhDYJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 05:55:07 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FSjx721DgzRgwp;
        Sun, 25 Apr 2021 17:52:11 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 25
 Apr 2021 17:54:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <shy828301@gmail.com>,
        <david@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v5 0/4] close various race windows for swap
Date:   Sun, 25 Apr 2021 17:54:15 +0800
Message-ID: <20210425095419.3830298-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
When I was investigating the swap code, I found some possible race
windows. This series aims to fix all these races. But using current
get/put_swap_device() to guard against concurrent swapoff for
swap_readpage() looks terrible because swap_readpage() may take really
long time. And to reduce the performance overhead on the hot-path as
much as possible, it appears we can use the percpu_ref to close this
race window(as suggested by Huang, Ying). The patch 1 adds percpu_ref
support for swap and most of the remaining patches try to use this to
close various race windows. More details can be found in the respective
changelogs. Thanks!

v4->v5:
  collect Reviewed-by tag
  do put_swap_device() before returning from the function per Huang, Ying

v3->v4:
  some commit log and comment enhance per Huang, Ying
  put get/put_swap_device() in shmem_swapin_page() per Huang, Ying
  collect Reviewed-by tag

v2->v3:
  some commit log and comment enhance per Huang, Ying
  remove ref_initialized field
  squash PATCH 1-2

v1->v2:
  reorganize the patch-2/5
  various enhance and fixup per Huang, Ying
  Many thanks for the comments of Huang, Ying, Dennis Zhou and Tim Chen.

Miaohe Lin (4):
  mm/swapfile: use percpu_ref to serialize against concurrent swapoff
  swap: fix do_swap_page() race with swapoff
  mm/swap: remove confusing checking for non_swap_entry() in
    swap_ra_info()
  mm/shmem: fix shmem_swapin() race with swapoff

 include/linux/swap.h | 14 ++++++--
 mm/memory.c          | 11 ++++--
 mm/shmem.c           | 12 +++++++
 mm/swap_state.c      |  6 ----
 mm/swapfile.c        | 79 +++++++++++++++++++++++++++-----------------
 5 files changed, 82 insertions(+), 40 deletions(-)

-- 
2.23.0

