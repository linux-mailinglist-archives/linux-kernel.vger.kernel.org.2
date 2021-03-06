Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2532F819
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCFDan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:30:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13477 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCFDaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:30:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dsqnc42dbzjWRg;
        Sat,  6 Mar 2021 11:28:36 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 6 Mar 2021
 11:30:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>
CC:     <riel@redhat.com>, <ebru.akagunduz@gmail.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/4] Cleanup and fixup for khugepaged
Date:   Fri, 5 Mar 2021 22:29:43 -0500
Message-ID: <20210306032947.35921-1-linmiaohe@huawei.com>
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
This series contains cleanups to remove unneeded return value, use
helper function and so on. And there is one fix to correct the wrong
result value for trace_mm_collapse_huge_page_isolate().

More details can be found in the respective changelogs. Thanks!

v1->v2:
    drop patch "khugepaged: remove unnecessary mem_cgroup_uncharge() in
collapse_[file|huge_page]"
    collect Acked-by

Miaohe Lin (4):
  khugepaged: remove unneeded return value of
    khugepaged_collapse_pte_mapped_thps()
  khugepaged: reuse the smp_wmb() inside __SetPageUptodate()
  khugepaged: use helper khugepaged_test_exit() in __khugepaged_enter()
  khugepaged: fix wrong result value for
    trace_mm_collapse_huge_page_isolate()

 mm/khugepaged.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

-- 
2.19.1

