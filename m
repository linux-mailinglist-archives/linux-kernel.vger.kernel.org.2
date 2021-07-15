Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661173CADBC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhGOUUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245400AbhGOUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VD4G21t0x8zTLpI+2pOXcTB/J7JFAqgi5NG6sl99Wc=;
        b=C7AdbSxY45HuGXzqzVMl9V6Gn1Js7Mne6rfgMYQaS5jn91QX9zf10GJTv3CHkwReprZahY
        2PEqXW7+p/BJFGklUT+HyVUORqzPw0wQfR2kpUdizJK87Ab5+UGh2dsDUIMdJhLM5XJFmJ
        vIV/5mc3TSYRVIPHXkg+um1ZGOlQVZg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-pF7W6filPki-gVogILz-ag-1; Thu, 15 Jul 2021 16:16:39 -0400
X-MC-Unique: pF7W6filPki-gVogILz-ag-1
Received: by mail-qk1-f200.google.com with SMTP id a6-20020a37b1060000b02903b488f9d348so4660987qkf.20
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VD4G21t0x8zTLpI+2pOXcTB/J7JFAqgi5NG6sl99Wc=;
        b=plHhz0k5LFCJWr0sw/wQ99fRHLDOZpK/nCxkDxMn4V+c4sQ5QxLrhEW5hzYGD+jo0W
         tPD1MdNckqvMZ+CaZHhBiklxcEifK4QJZ69XoCb4R0FPoPjUJlZYm6BKGBJh93LeInsa
         ZnqQHTeZlj8nr8L6so5thU2+W3686lu3ejnes/Aggm6tSRi+G0wej03a+dzgZYIsZU3X
         6L8pu0fLOawU1vNNWFonEzT++1bSlRBke/W56Nncs7kNxGJn5zPIr7YoL7LelcpuCKXk
         vGuRSi0/KXp2u4UAskbFq+lA3zGekbuh98gx43ZSprpcP0jLZBG31U1DORYPGY9dKZ4r
         IOJw==
X-Gm-Message-State: AOAM532Ze20YC4h2BfPYevCbiz8DzQc/UBVkzlY/FmOA/WtUPoGu31o8
        z5J/pWG3Vaw6a9981JvRQjP5Ef/hFc+lJVOiRIp8qYrlbUcF9VC8Z+8wWJM/F2V5SRBsptNFRUh
        QHlAwKP5reKNZPEYIjp7+QaRtCJJpCM4yvGiKbctICUjRD0jiYlwWjXKhj+M1VnVCBLeyIWu+ZA
        ==
X-Received: by 2002:ac8:68c:: with SMTP id f12mr5658424qth.334.1626380198925;
        Thu, 15 Jul 2021 13:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9/QQ49YEbpXS61Hdi0+Vq71mN11np+X7q7I05klzm3vL9KzFI1FSPbbE09X1xltDAD7jx1A==
X-Received: by 2002:ac8:68c:: with SMTP id f12mr5658381qth.334.1626380198628;
        Thu, 15 Jul 2021 13:16:38 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id x5sm2946015qke.92.2021.07.15.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 20/26] mm/hugetlb: Introduce huge version of special swap pte helpers
Date:   Thu, 15 Jul 2021 16:16:34 -0400
Message-Id: <20210715201634.211932-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index 4edb3ee885ea..517ee30f272c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -95,6 +95,26 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
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
@@ -4138,7 +4158,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_migration_entry(swp))
@@ -4151,7 +4171,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 {
 	swp_entry_t swp;
 
-	if (huge_pte_none(pte) || pte_present(pte))
+	if (!huge_pte_has_swap_entry(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
 	if (is_hwpoison_entry(swp))
-- 
2.31.1

