Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9D3E345D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhHGJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:36:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:13295 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhHGJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:36:37 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GhcY83Xztz828g;
        Sat,  7 Aug 2021 17:31:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 17:36:18 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 2/5] mm: gup: remove unneed local variable orig_refs
Date:   Sat, 7 Aug 2021 17:36:17 +0800
Message-ID: <20210807093620.21347-3-linmiaohe@huawei.com>
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

Remove unneed local variable orig_refs since refs is unchanged now.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/gup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 430495cb1b91..d6056dcab02c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -117,8 +117,6 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
 	else if (flags & FOLL_PIN) {
-		int orig_refs = refs;
-
 		/*
 		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 		 * right zone, so fail and let the caller fall back to the slow
@@ -150,7 +148,7 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
 
 		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
-				    orig_refs);
+				    refs);
 
 		return page;
 	}
-- 
2.23.0

