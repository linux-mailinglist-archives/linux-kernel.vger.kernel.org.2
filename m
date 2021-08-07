Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8223E345E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhHGJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:36:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13247 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhHGJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:36:37 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ghcfd6sNTz1CT3G;
        Sat,  7 Aug 2021 17:36:09 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 17:36:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 4/5] mm: gup: fix potential pgmap refcnt leak in __gup_device_huge()
Date:   Sat, 7 Aug 2021 17:36:19 +0800
Message-ID: <20210807093620.21347-5-linmiaohe@huawei.com>
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

When failed to try_grab_page, put_dev_pagemap() is missed. So pgmap
refcnt will leak in this case. Also we remove the check for pgmap
against NULL as it's also checked inside the put_dev_pagemap().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index d7e4507de6b1..8c89e614d4aa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2253,14 +2253,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
+			put_dev_pagemap(pgmap);
 			return 0;
 		}
 		(*nr)++;
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	if (pgmap)
-		put_dev_pagemap(pgmap);
+	put_dev_pagemap(pgmap);
 	return 1;
 }
 
-- 
2.23.0

