Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7136C94E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbhD0QYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237577AbhD0QOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXTRKapTK7xkWfcmUhC675oNCWp18cl/MiRtGAKeqgk=;
        b=X6Q84FGVoIVNQ7NBaxrHHTRXfwpHm3g09NDkkKRlOxlb3sWhNfVCqMPQCtXShYIT56BMmF
        BF0e1OR0ZAbj2IdTzO4Otpje6W4H+7sP0hNbgs0xofsttXGOYKcSjpTK7/ZioD3dK6+kmu
        PGQGlMbozEHhHIi+D7I3+kvJ0S6fjeU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-7_1jmiv8Oa-BisvjxeRExw-1; Tue, 27 Apr 2021 12:13:45 -0400
X-MC-Unique: 7_1jmiv8Oa-BisvjxeRExw-1
Received: by mail-qt1-f199.google.com with SMTP id b8-20020a05622a0208b02901b5b18f4f91so20772819qtx.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXTRKapTK7xkWfcmUhC675oNCWp18cl/MiRtGAKeqgk=;
        b=CjetkRmnAaPaw94LTXf9x/GCwFAwTZGZtvajMavOPYYhalJ+s4dHpEbQb0CQsGVibO
         Axq9b2odtL3elXTIslQ2RJpBnStS7+1hh5BFfGMKutTZIMgdTccT5DCGVWjUGUU4pKS8
         f6IUkisvSexwBciURHbxMwMV8ASUCzAKgiVLRfAPOAB1CeLGCYWbgVDlsfqihKPivMEk
         EY1D4vZVhMngwiZw8ezELih/bJXidH91aXEmE+IN3x6/Q8+9umYSqDG3T8GDk5F1BFkq
         fzmU3I+LEys2Jmy/l+wH2x5LtCBkZbAGDSkPe5nrcWZ8dxitmvC+rOwww0U8ENCl6RrV
         FzRQ==
X-Gm-Message-State: AOAM531NJX7cYzh+CAtxett3CM28Jwvlit2rpkJLq74VrGQaoq2WzTzx
        TXTPSjKFmIeWXuKMK9rWeMHLGgsWqzv+0Clb9beayGuT79/FB6o6Z8vyk1CGtTlhRMogmulAx8s
        J+lKj0qeMU9rCXTxT3RsswBEO
X-Received: by 2002:a37:390:: with SMTP id 138mr23732925qkd.136.1619540024996;
        Tue, 27 Apr 2021 09:13:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyrh8sZh+fxfsRGRfMYWR874+IQftCU711ibVBt1LefYgvzxPopd1PBmk0Q9G1Upc1N/6ITQ==
X-Received: by 2002:a37:390:: with SMTP id 138mr23732903qkd.136.1619540024751;
        Tue, 27 Apr 2021 09:13:44 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:44 -0700 (PDT)
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
Subject: [PATCH v2 14/24] shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
Date:   Tue, 27 Apr 2021 12:13:07 -0400
Message-Id: <20210427161317.50682-15-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be handled similarly like other uffd-wp wr-protected ptes: we should
pass it over when the dst_vma has VM_UFFD_WP armed, otherwise drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 872fb59192277..f1cdc613b5887 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -715,8 +715,21 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	swp_entry_t entry;
+
+	if (unlikely(is_swap_special_pte(pte))) {
+		/*
+		 * uffd-wp special swap pte is the only possibility for now.
+		 * If dst vma is registered with uffd-wp, copy it over.
+		 * Otherwise, ignore this pte as if it's a none pte would work.
+		 */
+		WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+		if (userfaultfd_wp(dst_vma))
+			set_pte_at(dst_mm, addr, dst_pte, pte);
+		return 0;
+	}
 
+	entry = pte_to_swp_entry(pte);
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return entry.val;
-- 
2.26.2

