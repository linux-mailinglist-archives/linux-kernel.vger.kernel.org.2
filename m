Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC463528D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhDBJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:33:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16334 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:33:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBZYx5N8mz9vtM;
        Fri,  2 Apr 2021 17:31:33 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 17:33:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/4] Cleanup and fixup for hugetlb
Date:   Fri, 2 Apr 2021 05:32:45 -0400
Message-ID: <20210402093249.25137-1-linmiaohe@huawei.com>
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
simplify the return code. Also this fixes potential wrong gbl_reserve
value and handle the error case in hugetlb_fix_reserve_counts(). More
details can be found in the respective changelogs. Thanks!

Miaohe Lin (4):
  mm/hugeltb: remove redundant VM_BUG_ON() in region_add()
  mm/hugeltb: simplify the return code of __vma_reservation_common()
  mm/hugeltb: fix potential wrong gbl_reserve value for
    hugetlb_acct_memory()
  mm/hugeltb: handle the error case in hugetlb_fix_reserve_counts()

 mm/hugetlb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.19.1

