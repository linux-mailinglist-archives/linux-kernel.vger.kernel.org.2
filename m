Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA56A393716
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbhE0UZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235790AbhE0UZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mr9CxfY0aflFHSlW/5vIhFmyytmHYg/MM4gViCf8fs4=;
        b=eYNajRD/P0VT40boUrBtwZnLgwjCaeKD26k4itNZTju6I7hOqMIL9NWkot/g043ZSd3+Xt
        x/VkkDDsjSt1sFmrX9IMeqhdLtESdkvdEg7phpAFQWuL4rwQMlk7T9FnaKuZNDteSEIoU0
        ItPnuJXpmURw4Gao7yRAwplphdbOAFw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-9Z5KkiKsNBWJRHJCpuZmGg-1; Thu, 27 May 2021 16:23:30 -0400
X-MC-Unique: 9Z5KkiKsNBWJRHJCpuZmGg-1
Received: by mail-qk1-f200.google.com with SMTP id a76-20020ae9e84f0000b02903a69ae4796aso1327266qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mr9CxfY0aflFHSlW/5vIhFmyytmHYg/MM4gViCf8fs4=;
        b=M9TilthZLX470QfHBxjL4ykoordryDvv3zlcAuX8aA68ZcJEr0drzf7kXEi5J8URlQ
         23xk+RXAeSUAMC/0qy5bsRPUv4xbcB0hEAbtPlLJCGcUR8dAcgxvvt/clTKKg4czDADa
         Ydlxc++JwQfe3/SDh+v7mh3DS8VfNQ1Rct6p7Cdp+fMAggzQ5vYUUHIj9JSFlqt210/+
         NndVeqe9QG7o6mczMndzPysultYXGkvd1OrhBMEITqvZxo4Acf2B8zPG1lH28lbFwS5q
         YrJ58kTnBsupvxuSpJ7Esq4SocrQx3k7v2gLFDaKxUxdWmapjBo8ZnwfqVj4Bnjk9iz6
         Bnzw==
X-Gm-Message-State: AOAM532H7eNMhLHsKg6PMkZHiNmu26aKPw3Gdfa7fJ4TodCfe8RwwH5K
        79R5KBpIUsH4vfMLUhOqp06f0wBfyBD6eCJbqERjllQdtc8CCVo9b0qKl9UWwFrf7fIpCapt3H1
        QyT5jFEBvPNoici700rxZSnR8RZ81j9KjmEYf8bHMKogDd0Fb/IF55uhPbmnJ8aJ68sOQ4ON5aQ
        ==
X-Received: by 2002:ac8:4a98:: with SMTP id l24mr352243qtq.378.1622147008415;
        Thu, 27 May 2021 13:23:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRAIFI/HJUQmPZpJYQ5Br+Zpl1lpkfA2/NL21zRaxxTI5PdiJKqF+10vpJO8ROFiXz1aAxrA==
X-Received: by 2002:ac8:4a98:: with SMTP id l24mr352203qtq.378.1622147008104;
        Thu, 27 May 2021 13:23:28 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id l197sm2069286qke.121.2021.05.27.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 21/27] mm/hugetlb: Introduce huge version of special swap pte helpers
Date:   Thu, 27 May 2021 16:23:24 -0400
Message-Id: <20210527202324.32104-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to let hugetlbfs be prepared to also recognize swap special ptes just
like uffd-wp special swap ptes.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b101c3af3ab5..c64dfd0a9883 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -133,6 +133,26 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
 	return true;
 }
 
+/*
+ * These are sister versions of is_swap_pte() and pte_has_swap_entry().  We
+ * need standalone ones because huge_pte_none() is handled differently from
+ * pte_none().  For more information, please refer to comments above
+ * is_swap_pte() and pte_has_swap_entry().
+ *
+ * Here we directly reuse the pte level of swap special ptes, for example, the
+ * pte_swp_uffd_wp_special().  It just stands for a huge page rather than a
+ * small page for hugetlbfs pages.
+ */
+static inline bool is_huge_swap_pte(pte_t pte)
+{
+	return !huge_pte_none(pte) && !pte_present(pte);
+}
+
+static inline bool huge_pte_has_swap_entry(pte_t pte)
+{
+	return is_huge_swap_pte(pte) && !is_swap_special_pte(pte);
+}
+
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
 						unsigned long irq_flags)
 {
@@ -4061,7 +4081,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_migration_entry(swp))
@@ -4074,7 +4094,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_hwpoison_entry(swp))
-- 
2.31.1

