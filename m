Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601D73E345B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhHGJgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:36:38 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13246 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhHGJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:36:37 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ghcfd3Mg3z1CT0k;
        Sat,  7 Aug 2021 17:36:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 17:36:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm: gup: remove useless BUG_ON in __get_user_pages()
Date:   Sat, 7 Aug 2021 17:36:18 +0800
Message-ID: <20210807093620.21347-4-linmiaohe@huawei.com>
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

Indeed, this BUG_ON couldn't catch anything useful. We are sure ret == 0
here because we would already bail out if ret != 0 and ret is untouched
till here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/gup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index d6056dcab02c..d7e4507de6b1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1149,7 +1149,6 @@ static long __get_user_pages(struct mm_struct *mm,
 					 * We must stop here.
 					 */
 					BUG_ON(gup_flags & FOLL_NOWAIT);
-					BUG_ON(ret != 0);
 					goto out;
 				}
 				continue;
-- 
2.23.0

