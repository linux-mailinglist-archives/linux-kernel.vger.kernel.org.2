Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9042A3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhJLMEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:04:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:25551 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhJLMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:04:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211012120248euoutp0278d4e4b8c44c433fffbaa942a7b060ee~tRuBFL8En2806628066euoutp02o
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:02:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211012120248euoutp0278d4e4b8c44c433fffbaa942a7b060ee~tRuBFL8En2806628066euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634040168;
        bh=vD1DwHi66vesD8XbwOs/nORqYO5RHC+xzmZvxIEFZpI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cAzr81nT3k/JeFDHvXfoWDvFpRmk5i3APLiuIVdJbfxVF+dcqvLnM/bILmplSQ9F7
         Af3jQMvRgh+NJ9DYMhwjqx5noodxOc0kaGyc+0uFb64MtY7mf42JmLLiR0+PnDC4xC
         oTAWSyFAFPwPGpZ5tBmGhM7BwGoUIqDldkVo1ps8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211012120248eucas1p2b0ffdd19750a6574dcebc5d4a391d163~tRuAiLSub0733207332eucas1p2D;
        Tue, 12 Oct 2021 12:02:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A0.BC.42068.86975616; Tue, 12
        Oct 2021 13:02:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8~tRuAFkaqW1263112631eucas1p1C;
        Tue, 12 Oct 2021 12:02:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211012120247eusmtrp20094289c6c85a4c0c78b6f8f9ca74d35~tRuAD7P_A0452404524eusmtrp2H;
        Tue, 12 Oct 2021 12:02:47 +0000 (GMT)
X-AuditID: cbfec7f4-c89ff7000002a454-af-616579689574
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.9B.31287.76975616; Tue, 12
        Oct 2021 13:02:47 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211012120247eusmtip13f44d1420ed233588ffe3c5d4ff5e752~tRt-ZSLIg0194501945eusmtip1h;
        Tue, 12 Oct 2021 12:02:47 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?=EA=B9=80=EC=84=B1=ED=9B=88?= <sfoon.kim@samsung.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH] mm/thp: decrease nr_thps in file's mapping on THP split
Date:   Tue, 12 Oct 2021 14:02:37 +0200
Message-Id: <20211012120237.2600-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87oZlamJBiu3cFjMWb+GzWL1Jl+L
        Az+fs1g8/dTHYnHz+RwWi8u75rBZ3Fvzn9Vi7ZG77BZb97cyWlzbtJXVonHacnaLn4fPMFts
        XtzFZPGx6R6bA5/H4TfvmT0mNr9j91iwqdRj06dJ7B4nZvxm8dj50NJj3slAj49Pb7F4vN93
        lc2jb8sqRo9JL9w99qy6yujxeZNcAG8Ul01Kak5mWWqRvl0CV8aPk/eZCq5wVmz6l9jA+IG9
        i5GTQ0LARKKzew9rFyMXh5DACkaJC80/2CCcL4wS7WfPskA4nxkl9i69wwTTcmb5XiaIxHJG
        iSMP3jLBtTx/0AFWxSZgKNH1tosNxBYB6tjdPJcRpIhZoJ1F4sS+zcwgCWEBD4mXiz+ygtgs
        AqoS+1/1AjVwcPAK2EicXwB1oLzE6g0HmEF6JQSecEjcn3qECaRGQsBFYuO1JIgaYYlXx7dA
        1ctI/N85nwmivplR4uG5tewQTg+jxOWmGYwQVdYSd879AlvGLKApsX6XPkTYUaL13iZmiPl8
        EjfeCoKEmYHMSdumQ4V5JTrahCCq1SRmHV8Ht/bghUvMELaHRNuquywgtpBArMSboytYJjDK
        zULYtYCRcRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZgWjr97/iXHYzLX33UO8TIxMF4
        iFGCg1lJhNcwIzVRiDclsbIqtSg/vqg0J7X4EKM0B4uSOG/SljXxQgLpiSWp2ampBalFMFkm
        Dk6pBqZwyYebmI5xa221rrpdwLL/caRt/W1Jy19PZjzY5uSbvWTdFwHb2EvT50aJia5R51lh
        4BDP+YUlRkHr0K64Q1u25kV/mPTh9er1Et8bt7uUGuc1qz498/hlaHPQh272azNXxYXoFiy6
        eyKs5sDiL2cqGf4wcm3XXjh//dLEMgHxWT7Twr816M1X0vt4tUJAUZ5FR9RYq397psAmOVmL
        xfrKte8vG0a2f8p8IanTzHn6rLrZlC/n/8xmY4xImmyZNWvtuuobfH9zC86I6F2sfLF8v2Z8
        aOGhG/++H9Fos5hiIDDrwZX9c8RvZS0/e9M5hktJJuOAUuoc/403Tso9CH819bjuojz7be3/
        AhWt9+1UYinOSDTUYi4qTgQAOKuBF7oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xu7rplamJBr+bVSzmrF/DZrF6k6/F
        gZ/PWSyefupjsbj5fA6LxeVdc9gs7q35z2qx9shddout+1sZLa5t2spq0ThtObvFz8NnmC02
        L+5isvjYdI/Ngc/j8Jv3zB4Tm9+xeyzYVOqx6dMkdo8TM36zeOx8aOkx72Sgx8ent1g83u+7
        yubRt2UVo8ekF+4ee1ZdZfT4vEkugDdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+PHyftMBVc4Kzb9S2xg/MDexcjJISFgInFm+V6mLkYuDiGB
        pYwSi5e/YoJIyEicnNbACmELS/y51sUGUfSJUaKlvw8swSZgKNH1FiTBySEiYCYxccVcsEnM
        Av0sEt9a34GtEBbwkHi5+CNYA4uAqsT+V71ADRwcvAI2EucXQF0hL7F6wwHmCYw8CxgZVjGK
        pJYW56bnFhvqFSfmFpfmpesl5+duYgTGw7ZjPzfvYJz36qPeIUYmDsZDjBIczEoivIYZqYlC
        vCmJlVWpRfnxRaU5qcWHGE2B1k1klhJNzgdGZF5JvKGZgamhiZmlgamlmbGSOO/WuWvihQTS
        E0tSs1NTC1KLYPqYODilGph0Z+bPFaq89Dzg/rafAa8vna59Kr9mjuqHOSpmu/08E+75nJKd
        MPvqjDtXNmj+Kc8tXjf1fnj343ksm2c0LNczYoqdMaGvIrHFTXFmAmuBZtnEgtDGiBOHQ+8F
        dpyurvsS8WCHxM3o6d86NFl6J+U/ydZ+cfGrXu0rda+G+5NOOVyoMmhM2mn+gG+jT3rFtkvT
        5l/hWmqqnrNXRCombP/XfS8uPvmm/D3s5NO/yn0OIZO/rH+1PC8uubJl4aQJhRM0Zyor8tzP
        UFpz5jXj3aQDPxubnFdbz0g9afAoOMW4v+ee4r/wFzIaq8WMavavNj20dfdTr9ICsXsXVF2V
        X25yuid++e57rZoNBVoTlLk0lViKMxINtZiLihMBaNBWoRADAAA=
X-CMS-MailID: 20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8
References: <CGME20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrease nr_thps counter in file's mapping to ensure that the page cache
won't be dropped excessively on file write access if page has been
already splitted.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 09d91cda0e82 ("mm,thp: avoid writes to file with THP in pagecache")
Fixes: 06d3eff62d9d ("mm/thp: fix node page state in split_huge_page_to_list()")
---
I've analyzed the code a few times but either I missed something or the
nr_thps counter is not decremented during the THP split on non-shmem file
pages.
---
 mm/huge_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec2bb93f7431..a6c2ba59abcd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2709,10 +2709,12 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
-			if (PageSwapBacked(head))
+			if (PageSwapBacked(head)) {
 				__dec_node_page_state(head, NR_SHMEM_THPS);
-			else
+			} else {
 				__dec_node_page_state(head, NR_FILE_THPS);
+				filemap_nr_thps_dec(mapping);
+			}
 		}
 
 		__split_huge_page(page, list, end, flags);
-- 
2.17.1

