Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8070536C95A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhD0QZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237537AbhD0QQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Of2/jNcSu5bZyfPgDma9r/3WOH0gTfsq0jzNO09tuew=;
        b=crwZTaPDPii6ekpxnG6/pyoA1pARrvkwErKy9OxMA5NwwF8x106YSAn+Qr0w2+JIzA1q0C
        i/1dyizIGcf661AyrDhyssPLiu0Tohyz+UTE9+oiMyYAt4szkS7iL40knd6FJaU6ymecZk
        RQbXZF43+SLR/mYP8+ZsLMrOaIXbjl4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-6DLF5IFyMBC2CmpYgw0hIg-1; Tue, 27 Apr 2021 12:13:54 -0400
X-MC-Unique: 6DLF5IFyMBC2CmpYgw0hIg-1
Received: by mail-qt1-f199.google.com with SMTP id d10-20020a05622a100ab02901b8224bae03so18230844qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Of2/jNcSu5bZyfPgDma9r/3WOH0gTfsq0jzNO09tuew=;
        b=QQ27rpsmPmBIc8lrIS87ji9sr5bqkql3Eok5R3hHiFdDJqlQJJq+b4umuoYystV1BE
         1zxWkY7aki4ac2JGMkT7M6QxyuMQUJwoo7UpJw5zvZf8L3dx6ExL8GNDuhopi7Sj2uOt
         0oBXx50sT/huOOnbA1XN3BNjdJ5epHXxDz/2Q3QULeEmAG5U6ii4jRfbaABSbsgtkcgt
         8YlyYY6W9V9eH6IcirkdDP+M6v7Afp5r/1QWzV3ut+kYPxQBdDoAh5eB2KDxsD9vMiJd
         Uv/GwfpZ1OI4fz/lujJrIQnVO5Z1k8gayq9D160SvEN5mIUjkC0tQDYeL9hCY0EXWulc
         ECCQ==
X-Gm-Message-State: AOAM531pidh2bRL3Cbb8VAMZwJbKhTq7M/yKj8XyMOLyt0/B5AcvXcEI
        Sr0nizPkV6BJOzrB7X6zRVWMbz/903hFA1wGU61I+P7SuDIErNlW3fJn/xKdNl5LbGCCQBifu3k
        k46EhQyYNIxmYxOshQHTHmWgl
X-Received: by 2002:ac8:7e8a:: with SMTP id w10mr21740784qtj.126.1619540034100;
        Tue, 27 Apr 2021 09:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNseODxdO93YFWKSY+Dyt7Y8fBZc5YflnrNJdlFTqOIRJxaq9cLRBHJ2XKxA4N01e/IDcnqQ==
X-Received: by 2002:ac8:7e8a:: with SMTP id w10mr21740763qtj.126.1619540033840;
        Tue, 27 Apr 2021 09:13:53 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 19/24] mm/hugetlb: Introduce huge version of special swap pte helpers
Date:   Tue, 27 Apr 2021 12:13:12 -0400
Message-Id: <20210427161317.50682-20-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index 3cad5d7726614..071a8429ea190 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,6 +93,26 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
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
@@ -3885,7 +3905,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_migration_entry(swp))
@@ -3898,7 +3918,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_hwpoison_entry(swp))
-- 
2.26.2

