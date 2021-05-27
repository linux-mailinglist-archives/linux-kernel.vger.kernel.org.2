Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D539370F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhE0UY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236403AbhE0UYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAmjiglASlkj6C13Cutnvz5k0d0w8IXdZ7Qyh6+DwYY=;
        b=EUWOGYy2w2BCPZ1FacLx/dPJKY7/1J8Y3mM+kfBJ+RkkDEpfQHx44CU2gQxobTovLwN1oQ
        1/6ujPWtINonCjEDkRfkyUpchTrp8V+hb64c4mEYVEX06CdtdCJgb/NmhOeMmJZaQcyOnF
        lVG8FI0+kyVNOSiMIM9z7qL/Eno4luM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-1bLihlyiNeOu6zBwwT6F9g-1; Thu, 27 May 2021 16:23:12 -0400
X-MC-Unique: 1bLihlyiNeOu6zBwwT6F9g-1
Received: by mail-qk1-f199.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso1365939qkd.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAmjiglASlkj6C13Cutnvz5k0d0w8IXdZ7Qyh6+DwYY=;
        b=JZLx2gtLSzHoLGjPb9Ny3pa8bKS5IWfr8ECH/1JqW9PzxnBdSzYMqFg2y29Vn+bkRg
         +3252Jx+6WLvTu7N8iS6DbnKnX507gacmSKXqzgH0eqS0TtcLTSXwGIVmvdqD6HtYGlJ
         SvFo6vJnNi1nbK1IVhGFpgxAIIBk09S9rove1Mx9PXx0CgBvknY1U/mGjryHf36bHX6b
         bZWkWydNtYL2KY/3sq4AASAugDhABRiyvWln5iEDMKWiUn5W6d+zcIYFktOw4fwdUyMx
         kePOFSg2tuVeNHMDxvvh/cKSTwpyovE4Aa96ENWz+2yphnKFtGUNY7OIRl0805+4AExB
         WxHA==
X-Gm-Message-State: AOAM532llZdMwsJFSEY3v0gox/kigX9Pbo6NGnrcWRPgOrnkYPILf7g7
        6N6YDpeW7xOu9WdfQd/1nz87ijWrwEoMB7TP9g2TVy1QlcR5B4fmemLjMvSw7iDMcXFom+aqVJO
        u0xqg3PrHMDqMeTTgWjOzRWYbrth3Zor/aFRrMWdVaeIoidPGSmCjPV9I3C/ZDNl459LOXtAxQA
        ==
X-Received: by 2002:ad4:5227:: with SMTP id r7mr340815qvq.41.1622146991421;
        Thu, 27 May 2021 13:23:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtCJbSTqUjM7suwiR8IhoI+l1zb1zSSJrik2m04Tqem1imNMBVQvJJonjARh3dJDvw2YkfBA==
X-Received: by 2002:ad4:5227:: with SMTP id r7mr340783qvq.41.1622146991171;
        Thu, 27 May 2021 13:23:11 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id c7sm2044392qkc.114.2021.05.27.13.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:10 -0700 (PDT)
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
Subject: [PATCH v3 17/27] mm/hugetlb: Introduce huge pte version of uffd-wp helpers
Date:   Thu, 27 May 2021 16:23:07 -0400
Message-Id: <20210527202307.31882-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be used in the follow up patches to either check/set/clear uffd-wp
bit of a huge pte.

So far it reuses all the small pte helpers.  Archs can overwrite these versions
when necessary (with __HAVE_ARCH_HUGE_PTE_UFFD_WP* macros) in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/asm-generic/hugetlb.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 8e1e6244a89d..c45b9deb41ff 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -32,6 +32,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+	return pte_mkuffd_wp(pte);
+}
+
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+	return pte_clear_uffd_wp(pte);
+}
+
+static inline int huge_pte_uffd_wp(pte_t pte)
+{
+	return pte_uffd_wp(pte);
+}
+
 #ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, unsigned long sz)
-- 
2.31.1

