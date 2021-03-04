Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C924232D310
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhCDMbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:31:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12688 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbhCDMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:31:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Drqsh6Mb3zlShP;
        Thu,  4 Mar 2021 20:28:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Mar 2021
 20:30:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <riel@redhat.com>, <kirill.shutemov@linux.intel.com>,
        <ebru.akagunduz@gmail.com>, <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Cleanup and fixup for khugepaged
Date:   Thu, 4 Mar 2021 07:30:08 -0500
Message-ID: <20210304123013.23560-1-linmiaohe@huawei.com>
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

Miaohe Lin (5):
  khugepaged: remove unneeded return value of
    khugepaged_collapse_pte_mapped_thps()
  khugepaged: reuse the smp_wmb() inside __SetPageUptodate()
  khugepaged: use helper khugepaged_test_exit() in __khugepaged_enter()
  khugepaged: remove unnecessary mem_cgroup_uncharge() in
    collapse_[file|huge_page]
  khugepaged: fix wrong result value for
    trace_mm_collapse_huge_page_isolate()

 mm/khugepaged.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

-- 
2.19.1

