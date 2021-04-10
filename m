Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7583035AB9E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhDJHZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:25:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17303 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhDJHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:24:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FHRKK0dClz9xDT;
        Sat, 10 Apr 2021 15:22:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Sat, 10 Apr 2021
 15:24:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH v2 0/5] Cleanup and fixup for hugetlb
Date:   Sat, 10 Apr 2021 03:23:43 -0400
Message-ID: <20210410072348.20437-1-linmiaohe@huawei.com>
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
This series contains cleanups to remove redundant VM_BUG_ON() and
simplify the return code. Also this handles the error case in
hugetlb_fix_reserve_counts() correctly. More details can be found
in the respective changelogs. Thanks!

v1->v2:
  collect Reviewed-by tag
  remove the HPAGE_RESV_OWNER check per Mike
  add a comment to hugetlb_unreserve_pages per Mike
  expand warning message a bit for hugetlb_fix_reserve_counts
  Add a new patch to remove unused variable
  Many thanks for Mike's review and suggestion!

Miaohe Lin (5):
  mm/hugeltb: remove redundant VM_BUG_ON() in region_add()
  mm/hugeltb: simplify the return code of __vma_reservation_common()
  mm/hugeltb: clarify (chg - freed) won't go negative in
    hugetlb_unreserve_pages()
  mm/hugeltb: handle the error case in hugetlb_fix_reserve_counts()
  mm/hugetlb: remove unused variable pseudo_vma in
    remove_inode_hugepages()

 fs/hugetlbfs/inode.c |  3 ---
 mm/hugetlb.c         | 57 +++++++++++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.19.1

