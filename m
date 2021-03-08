Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422C330C56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCHL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:28:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13140 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhCHL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:28:49 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvGJj2Grcz17HFn;
        Mon,  8 Mar 2021 19:27:01 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Mon, 8 Mar 2021
 19:28:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Some cleanups for hugetlb
Date:   Mon, 8 Mar 2021 06:28:04 -0500
Message-ID: <20210308112809.26107-1-linmiaohe@huawei.com>
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
This series contains cleanups to remove unnecessary VM_BUG_ON_PAGE, use
helper function and so on. I also collect some previous patches into this
series in case they are forgotten.
More details can be found in the respective changelogs. Thanks!

Miaohe Lin (5):
  mm/hugetlb: use some helper functions to cleanup code
  mm/hugetlb: optimize the surplus state transfer code in
    move_hugetlb_state()
  hugetlb_cgroup: remove unnecessary VM_BUG_ON_PAGE in
    hugetlb_cgroup_migrate()
  mm/hugetlb: simplify the code when alloc_huge_page() failed in
    hugetlb_no_page()
  mm/hugetlb: avoid calculating fault_mutex_hash in truncate_op case

 fs/hugetlbfs/inode.c |  6 +++---
 mm/hugetlb.c         | 21 ++++++++++++---------
 mm/hugetlb_cgroup.c  |  1 -
 3 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.19.1

