Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B161F454E08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhKQTla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhKQTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:41:27 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1664C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:38:28 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w7-20020aa78587000000b004a28bb92381so2179241pfn.22
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vNIuXBteNkTcaESUx4SfgLhD0CMWa6CfwiyimngrrLk=;
        b=g8Rh3vZSu7yMZjhk33znZxzdH2tMXoZy1NbrUfwij3DPN0Du+eI8bHTYWDhkjV/uDn
         CLH/i8hyssGzxyjCiwmAVQWBdSulmf+0WDQhfjpcFhkQ7kHsbE8zCdL514DwjW0GSO1i
         q/XAsldvXRKG0L9d9IhFBFv9xGwCtjGGYX/UdGm9AmTt9T61apSv1K2+EcQ0sHKKnNFm
         GHnp4L7NhsbCXqSO2e2dz5/Szsvv+oNr02RvNCjqH8QRGLvHDBf8n4cCV6nIayg+FD1f
         sX5ZfxHiY+ZJdmOimk+J+yL8d1OR3g8wQTpTTwGemxOg/soCKZcoog3gpzIhgVJ0692J
         MGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vNIuXBteNkTcaESUx4SfgLhD0CMWa6CfwiyimngrrLk=;
        b=8BnzciM/13NHbEo7wOMz67OPwUnLdpf88TAVgNN4vPZNVHHltVvZJojP7odZ6W+hTr
         RxqWX3tKLZ6GgklcUzjuhzvER7n7YWeLP+Bw5p6T1S3Wyc2CLPtYATbSPEI3e9V4oywx
         7nABrTalfUyxM8sfA2drL47CV8RhZ/Bs0FIMwOUTpFtesfZ4yaOlCI6/7JJrL1WAEelE
         +Pdr19jYj17MhbVHKp7YE3v7tF8tzZhV03pSwy0tphaIAt9wNz1Y99w7qdR49UwpgYrF
         Io7axcy82R2ycyxS9ZybWlr4A4vvsuCuUWQcB6IyBUw3l/atW4EBb83jnUx6D7rJitn0
         +39A==
X-Gm-Message-State: AOAM531j7Etl0sn8sgTrLrYwQg0UHJ4FEsXELy6AdtDokMMy6V8CdgHA
        mb4CQFtjWM5tjop93yTxhUNdl/ufOmMJVfmNfQ==
X-Google-Smtp-Source: ABdhPJwKAP41N61uzvfkBbQYTcD4/ulbuSfavUCjZ5PZjL21wsVn8PMCZREVGmc8XeHp9qvTGqBvIb795H6PFrRb8Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:ab13:f492:fd91:a37d])
 (user=almasrymina job=sendgmr) by 2002:a17:902:a9cb:b0:143:d9ad:d154 with
 SMTP id b11-20020a170902a9cb00b00143d9add154mr11356115plr.6.1637177908287;
 Wed, 17 Nov 2021 11:38:28 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:38:24 -0800
Message-Id: <20211117193825.378528-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2] hugetlb, userfaultfd: Fix reservation restore on
 userfaultfd error
From:   Mina Almasry <almasrymina@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>, Wei Xu <weixugc@google.com>,
        stable@vger.kernel.org, James Houghton <jthoughton@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in the is_continue case in hugetlb_mcopy_atomic_pte(), if we
bail out using "goto out_release_unlock;" in the cases where idx >=
size, or !huge_pte_none(), the code will detect that new_pagecache_page
== false, and so call restore_reserve_on_error().
In this case I see restore_reserve_on_error() delete the reservation,
and the following call to remove_inode_hugepages() will increment
h->resv_hugepages causing a 100% reproducible leak.

We should treat the is_continue case similar to adding a page into the
pagecache and set new_pagecache_page to true, to indicate that there is
no reservation to restore on the error path, and we need not call
restore_reserve_on_error().  Rename new_pagecache_page to
page_in_pagecache to make that clear.

Cc: Wei Xu <weixugc@google.com>

Cc: stable@vger.kernel.org

Fixes: c7b1850dfb41 ("hugetlb: don't pass page cache pages to restore_reserve_on_error")
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reported-by: James Houghton <jthoughton@google.com>


---

Changes in v2:
- Renamed new_pagecache_page to page_in_pagecache
- Removed unnecessary comment after the name update.
- Cc: stable
---
 mm/hugetlb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e09159c957e3..e7ebc4b355cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5734,13 +5734,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	int ret = -ENOMEM;
 	struct page *page;
 	int writable;
-	bool new_pagecache_page = false;
+	bool page_in_pagecache = false;

 	if (is_continue) {
 		ret = -EFAULT;
 		page = find_lock_page(mapping, idx);
 		if (!page)
 			goto out;
+		page_in_pagecache = true;
 	} else if (!*pagep) {
 		/* If a page already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
@@ -5828,7 +5829,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		ret = huge_add_to_page_cache(page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
-		new_pagecache_page = true;
+		page_in_pagecache = true;
 	}

 	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
@@ -5892,7 +5893,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (vm_shared || is_continue)
 		unlock_page(page);
 out_release_nounlock:
-	if (!new_pagecache_page)
+	if (!page_in_pagecache)
 		restore_reserve_on_error(h, dst_vma, dst_addr, page);
 	put_page(page);
 	goto out;
--
2.34.0.rc2.393.gf8c9666880-goog
