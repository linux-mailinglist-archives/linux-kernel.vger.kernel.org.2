Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC5394BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE2LIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 07:08:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2102 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhE2LIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 07:08:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fsdsn1xSPzWpxt;
        Sat, 29 May 2021 19:01:49 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 19:06:27 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 19:06:26 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] uprobes: Use better bitmap_zalloc()
Date:   Sat, 29 May 2021 19:15:53 +0800
Message-ID: <20210529111553.186630-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use better bitmap_zalloc() to allocate bitmap.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/events/uprobes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 907d4ee00cb2..8160d2e53219 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1487,8 +1487,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (unlikely(!area))
 		goto out;
 
-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
+	area->bitmap = bitmap_kzalloc(UINSNS_PER_PAGE, GFP_KERNEL);
 	if (!area->bitmap)
 		goto free_area;
 
@@ -1512,7 +1511,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	__free_page(area->pages[0]);
  free_bitmap:
-	kfree(area->bitmap);
+	bitmap_kfree(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1553,7 +1552,7 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->pages[0]);
-	kfree(area->bitmap);
+	bitmap_kfree(area->bitmap);
 	kfree(area);
 }
 
-- 
2.26.2

