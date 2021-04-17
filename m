Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A07362EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhDQJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:42:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17369 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhDQJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:42:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FMp2b4JhZzlYjX;
        Sat, 17 Apr 2021 17:39:51 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 17 Apr 2021
 17:41:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <dennis@kernel.org>,
        <tim.c.chen@linux.intel.com>, <hughd@google.com>,
        <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <david@redhat.com>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/5] close various race windows for swap
Date:   Sat, 17 Apr 2021 05:40:34 -0400
Message-ID: <20210417094039.51711-1-linmiaohe@huawei.com>
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

v1->v2:
  reorganize the patch-2/5
  various enhance and fixup per Huang, Ying
  Many thanks for the comments of Huang, Ying, Dennis Zhou and Tim Chen.

Miaohe Lin (5):
  mm/swapfile: add percpu_ref support for swap
  mm/swapfile: use percpu_ref to serialize against concurrent swapoff
  swap: fix do_swap_page() race with swapoff
  mm/swap: remove confusing checking for non_swap_entry() in
    swap_ra_info()
  mm/shmem: fix shmem_swapin() race with swapoff

 include/linux/swap.h | 15 +++++++--
 mm/memory.c          |  9 ++++++
 mm/shmem.c           |  6 ++++
 mm/swap_state.c      |  6 ----
 mm/swapfile.c        | 74 +++++++++++++++++++++++++++-----------------
 5 files changed, 73 insertions(+), 37 deletions(-)

-- 
2.19.1

