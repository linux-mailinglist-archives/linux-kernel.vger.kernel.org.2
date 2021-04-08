Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD371358432
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhDHNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:09:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16413 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:09:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGM4L0Jypzkjg5;
        Thu,  8 Apr 2021 21:07:30 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:09:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@suse.com>, <iamjoonsoo.kim@lge.com>,
        <vbabka@suse.cz>, <alex.shi@linux.alibaba.com>,
        <willy@infradead.org>, <minchan@kernel.org>,
        <richard.weiyang@gmail.com>, <ying.huang@intel.com>,
        <hughd@google.com>, <tim.c.chen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] close various race windows for swap
Date:   Thu, 8 Apr 2021 09:08:15 -0400
Message-ID: <20210408130820.48233-1-linmiaohe@huawei.com>
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
support for swap and the rest of the patches use this to close various
race windows. More details can be found in the respective changelogs.
Thanks!

Miaohe Lin (5):
  mm/swapfile: add percpu_ref support for swap
  swap: fix do_swap_page() race with swapoff
  mm/swap_state: fix get_shadow_from_swap_cache() race with swapoff
  mm/swap_state: fix potential faulted in race in swap_ra_info()
  mm/swap_state: fix swap_cluster_readahead() race with swapoff

 include/linux/swap.h |  4 +++-
 mm/memory.c          | 10 +++++++++
 mm/swap_state.c      | 33 +++++++++++++++++++++--------
 mm/swapfile.c        | 50 +++++++++++++++++++++++++++-----------------
 4 files changed, 68 insertions(+), 29 deletions(-)

-- 
2.19.1

