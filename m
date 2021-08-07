Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C33E345C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhHGJgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:36:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13294 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhHGJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:36:37 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GhcY804dXz7yVn;
        Sat,  7 Aug 2021 17:31:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 17:36:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm: gup: remove set but unused local variable major
Date:   Sat, 7 Aug 2021 17:36:16 +0800
Message-ID: <20210807093620.21347-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210807093620.21347-1-linmiaohe@huawei.com>
References: <20210807093620.21347-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a2beb5f1efed ("mm: clean up the last pieces of page fault
accountings"), the local variable major is unused. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/gup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 77150624f77a..430495cb1b91 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1276,7 +1276,7 @@ int fixup_user_fault(struct mm_struct *mm,
 		     bool *unlocked)
 {
 	struct vm_area_struct *vma;
-	vm_fault_t ret, major = 0;
+	vm_fault_t ret;
 
 	address = untagged_addr(address);
 
@@ -1296,7 +1296,6 @@ int fixup_user_fault(struct mm_struct *mm,
 		return -EINTR;
 
 	ret = handle_mm_fault(vma, address, fault_flags, NULL);
-	major |= ret & VM_FAULT_MAJOR;
 	if (ret & VM_FAULT_ERROR) {
 		int err = vm_fault_to_errno(ret, 0);
 
-- 
2.23.0

