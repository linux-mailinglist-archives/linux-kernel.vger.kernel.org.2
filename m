Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327BA39370A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhE0UYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235646AbhE0UYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltWxXgdsERQEx3E6ySA6em4pDoRaSyrvcOj0w7z20l8=;
        b=Ls0R+yoZpBqON1bDorRpWubXB/9QSD0LWLW3CgcpoQAW5hw5FZsMvdiHb4av8/I3XMZFad
        4nCDimyA2VSQ+crUGfc9pbtXmiyRvqWXa5J75lVrd7SAU/L7V3Bfd4hXZoz+Bf91u6eON4
        sMqT0iFh+GLIxLhH/JgkA3+JumdEuAs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-tfbcyXBgMm-Avfu6kVqinA-1; Thu, 27 May 2021 16:22:55 -0400
X-MC-Unique: tfbcyXBgMm-Avfu6kVqinA-1
Received: by mail-qk1-f199.google.com with SMTP id c126-20020ae9ed840000b02903a69f28eea6so1368988qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltWxXgdsERQEx3E6ySA6em4pDoRaSyrvcOj0w7z20l8=;
        b=fWAbor2DVavdo261MUcyIt9jV3lCWxowk3jB/IeMqaXSUYWAvtjAEEPZJ0T/p0aHPm
         mchnN8fNSLhp9GxPiY4oMZZA9sw+isKQ8w3wCbuMnLZS7yjzqdi0wu6X2CFLpvGvkB8Z
         WmkYkCYt8QWN+lv5siUgXagOEvs7JjXDAVXYFIsP7aCxkbFgXBxcDCG0kw4VLchatKhY
         hQXMSNd7zEUc+7VckHtjlyyG3+iLg4qlYmdZzF1fJq28YE1EyDoZuMkZ2XI3G0tEnDcJ
         4xsHkpmul2RaoSoZTxJ7NYpSHItrjxAeRNGlUpEPwoUTr/dSX+hh26e6YWkgRER7/obj
         VFWg==
X-Gm-Message-State: AOAM531WsVjSqOgWP+iHZm6hfcZK320fBZsL/G+4F6vjPAqfwZ7Zf2L/
        MZra5JgO26TOKgVW39eIiEti2ZbrVj+FKQaSuA0kV5JRsXNs2IZV4xpiKzqxr4gFpvS40Unb36u
        kNJy7eElLFtsiuMxberMKkUzaGHRlGs8HCyQKKZzddQE8e7pgHeEPyMG8vCEMfD3Nc+/3H9hROQ
        ==
X-Received: by 2002:ac8:5784:: with SMTP id v4mr352670qta.264.1622146974787;
        Thu, 27 May 2021 13:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw13s6ljQoCm32IG4W01f9UJM4WrdJHKw4FnJpF0acfwSUTrTtR0tUbI/5AXylz2fDUX/g5XA==
X-Received: by 2002:ac8:5784:: with SMTP id v4mr352632qta.264.1622146974465;
        Thu, 27 May 2021 13:22:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id j62sm2075122qkf.125.2021.05.27.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:22:53 -0700 (PDT)
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
Subject: [PATCH v3 13/27] shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
Date:   Thu, 27 May 2021 16:22:50 -0400
Message-Id: <20210527202250.31663-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have "huge" version of PTE_SWP_UFFD_WP_SPECIAL, instead when necessary
we split the thp if the huge page is uffd wr-protected previously.

However split the thp is not enough, because file-backed thp is handled totally
differently comparing to anonymous thps - rather than doing a real split, the
thp pmd will simply got dropped in __split_huge_pmd_locked().

That is definitely not enough if e.g. when there is a thp covers range [0, 2M)
but we want to wr-protect small page resides in [4K, 8K) range, because after
__split_huge_pmd() returns, there will be a none pmd.

Here we leverage the previously introduced change_protection_prepare() macro so
that we'll populate the pmd with a pgtable page.  Then change_pte_range() will
do all the rest for us, e.g., install the uffd-wp swap special pte marker at
any pte that we'd like to wr-protect, under the protection of pgtable lock.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8ec85b276975..3fcb87b59696 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -306,8 +306,16 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			if (next - addr != HPAGE_PMD_SIZE ||
+			    /* Uffd wr-protecting a file-backed memory range */
+			    unlikely(!vma_is_anonymous(vma) &&
+				     (cp_flags & MM_CP_UFFD_WP))) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
+				/*
+				 * For file-backed, the pmd could have been
+				 * gone; still provide a pte pgtable if needed.
+				 */
+				change_protection_prepare(vma, pmd, addr, cp_flags);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
-- 
2.31.1

