Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303724066BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 07:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhIJFba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 01:31:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16247 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhIJFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 01:31:24 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H5PZW36g6z8t09;
        Fri, 10 Sep 2021 13:29:39 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:11 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>
CC:     <kasan-dev@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 1/3] vmalloc: Choose a better start address in vm_area_register_early()
Date:   Fri, 10 Sep 2021 13:33:52 +0800
Message-ID: <20210910053354.26721-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Let's choose a suit start address by traversing the vmlist.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/vmalloc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..5ee3cbeffa26 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2272,15 +2272,21 @@ void __init vm_area_add_early(struct vm_struct *vm)
  */
 void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 {
-	static size_t vm_init_off __initdata;
-	unsigned long addr;
+	unsigned long addr = ALIGN(VMALLOC_START, align);
+	struct vm_struct *cur, **p;
 
-	addr = ALIGN(VMALLOC_START + vm_init_off, align);
-	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
+	BUG_ON(vmap_initialized);
 
-	vm->addr = (void *)addr;
+	for (p = &vmlist; (cur = *p) != NULL; p = &cur->next) {
+		if ((unsigned long)cur->addr - addr >= vm->size)
+			break;
+		addr = ALIGN((unsigned long)cur->addr + cur->size, align);
+	}
 
-	vm_area_add_early(vm);
+	BUG_ON(addr > VMALLOC_END - vm->size);
+	vm->addr = (void *)addr;
+	vm->next = *p;
+	*p = vm;
 }
 
 static void vmap_init_free_space(void)
-- 
2.26.2

