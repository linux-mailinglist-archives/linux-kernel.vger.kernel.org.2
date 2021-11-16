Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB26B453CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhKQAAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhKQAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:00:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E312C061767
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:57:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso1012760ybe.17
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8bO0KCHRSML2A1UfF7jI1msTxa4rXNv8MPzTspo5eQc=;
        b=qgSUqqjNfpooMKYy+ZO5eI4Dxo+MU4PIfe6TYCXqjMtDe/tGQ2dHeZy875qGRcQgnE
         4mwRmpPqEUcQxNorS1J1W6Pt78XG0ylUViPD5F7S1Co8fEXh2UKKx5G+QGS+4NIY47+9
         fPZ9seGU+F1/5kt0M6DpaR8m7RNxOu9hr3LIy25IEbZu0RUUbPIKyTj4L+bPsQohAP+R
         fHtIQ0HtpalpJCTSo6CX3znp7T4bAspoM7CVFTEuqLjxO+fCsfp51ikMOf4c5eIxc2Tl
         rUkWON9gojSl/uZ9dMLGP7mRrWPh/N+N+pKmzMhq9WJdLOu1FtZuG7XMr05NXn7zDUFS
         Ms0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8bO0KCHRSML2A1UfF7jI1msTxa4rXNv8MPzTspo5eQc=;
        b=Z5Xbf9VCb+T9jWU2c6YaeNEK/n6eN+2vfP9156Wg8JhrhOtGOkA8/8xIE1vd8pw1mr
         gQAfbZd+vu/P+ZBtF16E770XXR3Z28QV7+9igVQMg4oVn4lyUKifgR6/8ankmy4OBP98
         NWu6wRJVM7qOTLsf9+sQaML903Y8OeqNvGr51F2Squ48/uOrPAjLHUio+NJywtmXI5iz
         HgA2Bz5pSX4Pr6rO4zKAqEZ/ZSYam6E16EM/OqYKw1NK4JTdobZWdwH3dS9E+M/RRJvx
         3aEnbiS9+U2ipd2YY2VnIUdmiA2OKgYnjEM0rms3Mh29GBZsvQ6JZZKgiR+mX6HKETdD
         0jtw==
X-Gm-Message-State: AOAM533Gt/xzDjTAkUSwwnX1alJHAY9PUHn4PgkdNbmsr6h6q7gZhAOu
        W/nvM4C/+dwCDAHfLvyQFF+Gvp9Nq83QzMO9qA==
X-Google-Smtp-Source: ABdhPJy0FOjjb3Wfu3wrPIV5N5uIgLuURT5zkD72spCH1d2hwxgWUdx3XO7e6HYZvNWC65HMXULRPVrRJfPbMs6sJw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:e2dc:cbcc:c7b9:5537])
 (user=almasrymina job=sendgmr) by 2002:a25:1c5:: with SMTP id
 188mr12542328ybb.292.1637107069314; Tue, 16 Nov 2021 15:57:49 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:57:32 -0800
Message-Id: <20211116235733.3774702-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v1] hugetlb, userfaultfd: Fix reservation restore on
 userfaultfd error
From:   Mina Almasry <almasrymina@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>, Wei Xu <weixugc@google.com>,
        James Houghton <jthoughton@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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
restore_reserve_on_error().

Cc: Wei Xu <weixugc@google.com>

Fixes: c7b1850dfb41 ("hugetlb: don't pass page cache pages to restore_reserve_on_error")
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reported-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e09159c957e3..25a7a3d84607 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5741,6 +5741,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page = find_lock_page(mapping, idx);
 		if (!page)
 			goto out;
+		/*
+		 * Set new_pagecache_page to true, as we've added a page to the
+		 * pagecache, but userfaultfd hasn't set up a mapping for this
+		 * page yet. If we bail out before setting up the mapping, we
+		 * want to indicate to restore_reserve_on_error() that we've
+		 * added the page to the page cache.
+		 */
+		new_pagecache_page = true;
 	} else if (!*pagep) {
 		/* If a page already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
--
2.34.0.rc1.387.gb447b232ab-goog
