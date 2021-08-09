Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62043E42C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhHIJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:32:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8384 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhHIJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:32:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GjrNv5rTZz85Yj;
        Mon,  9 Aug 2021 17:28:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:32:27 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:32:26 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <elver@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 1/3] vmalloc: Choose a better start address in vm_area_register_early()
Date:   Mon, 9 Aug 2021 17:37:48 +0800
Message-ID: <20210809093750.131091-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some fixed locations in the vmalloc area be reserved
in ARM(see iotable_init()) and ARM64(see map_kernel()), but for
pcpu_page_first_chunk(), it calls vm_area_register_early() and
choose VMALLOC_START as the start address of vmap area which
could be conflicted with above address, then could trigger a
BUG_ON in vm_area_add_early().

Let's choose the end of existing address range in vmlist as the
start address instead of VMALLOC_START to avoid the BUG_ON.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/vmalloc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5cd52805149..1e8fe08725b8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2238,11 +2238,17 @@ void __init vm_area_add_early(struct vm_struct *vm)
  */
 void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 {
-	static size_t vm_init_off __initdata;
-	unsigned long addr;
-
-	addr = ALIGN(VMALLOC_START + vm_init_off, align);
-	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
+	struct vm_struct *head = vmlist, *curr, *next;
+	unsigned long addr = ALIGN(VMALLOC_START, align);
+
+	while (head != NULL) {
+		next = head->next;
+		curr = head;
+		head = next;
+		addr = ALIGN((unsigned long)curr->addr + curr->size, align);
+		if (next && (unsigned long)next->addr - addr > vm->size)
+			break;
+	}
 
 	vm->addr = (void *)addr;
 
-- 
2.26.2

