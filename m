Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A803BBBF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGELKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:10:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9360 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhGELKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:10:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GJN8F4p9Kz70PR;
        Mon,  5 Jul 2021 19:03:09 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 19:07:28 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 19:07:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 1/3] vmalloc: Choose a better start address in vm_area_register_early()
Date:   Mon, 5 Jul 2021 19:14:51 +0800
Message-ID: <20210705111453.164230-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
References: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
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
 mm/vmalloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d5cd52805149..a98cf97f032f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2238,12 +2238,14 @@ void __init vm_area_add_early(struct vm_struct *vm)
  */
 void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 {
-	static size_t vm_init_off __initdata;
+	unsigned long vm_start = VMALLOC_START;
+	struct vm_struct *tmp;
 	unsigned long addr;
 
-	addr = ALIGN(VMALLOC_START + vm_init_off, align);
-	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
+	for (tmp = vmlist; tmp; tmp = tmp->next)
+		vm_start = (unsigned long)tmp->addr + tmp->size;
 
+	addr = ALIGN(vm_start, align);
 	vm->addr = (void *)addr;
 
 	vm_area_add_early(vm);
-- 
2.26.2

