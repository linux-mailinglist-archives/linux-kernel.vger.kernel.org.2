Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C823CADB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbhGOUTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245176AbhGOUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAmjiglASlkj6C13Cutnvz5k0d0w8IXdZ7Qyh6+DwYY=;
        b=hQL3LSR0e37OwLjv7oocHd4vHLgFB3zYEXDkbzU7fbCfFlVtHc/p+1iyKguXMGkD6myjIs
        fstWcH3do+Z3zXzgvh9doxF+jQg8qLJCWeH+NpdbwnZj4EYwKklDI4/y/qeJwUHXhsCI40
        /f/5a07hopVaq7DckrfgFgtGdA3TRvk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-jDSupMwZMyur6X1TLAsrXQ-1; Thu, 15 Jul 2021 16:16:22 -0400
X-MC-Unique: jDSupMwZMyur6X1TLAsrXQ-1
Received: by mail-qk1-f198.google.com with SMTP id q6-20020a05620a05a6b02903b8bd8b612eso4092393qkq.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAmjiglASlkj6C13Cutnvz5k0d0w8IXdZ7Qyh6+DwYY=;
        b=r/y4Lf2EefwwEcl0kYnEI8QN932Amv79EaQeQbSwqDKDJC+emW9LdBEhhrZBe6k2SU
         +/Xlh+fgP0H6JhLSyYfm9+QzPfgdbHGRjeSd4SXV53YIXRlfBCr3W1SFdfkHSqmvRfr6
         jgQYSY+eorjQaebtuELp4HQaDHB+i8kipWlBasnr9VY4zboHDrQSmRt3rdzpjSjjkPzQ
         rFVqvNrG3ZuWsR0EIxwBNuQWkUxl71qAFH+X0yxaJSp17pklx66/ICduRQeOakhioswc
         podeLqoOXOsjYbr2EMDQVUNcuOTXl8USNkRou608fg+TwUWw6/KXcGKzQrc40GZsx26e
         UpYw==
X-Gm-Message-State: AOAM533uGpHdJ7y/RmT5S+KB6nOiQUgndcccZFzgpy0+bgT4UrzOHdya
        1ofKTJE58lmRXnnko8QpBo6WZtGB3WFJ2SHn2qS+Or/asNDIy6HAVYv1huLFReIC6ls84gtkkl/
        aJaeQ1Z8GaI11HjnxcTYu+xAboouHBSi9iS6XCRr3LxqnsplDziL7qEhxGmfFeq/Ra5uQiHWD4g
        ==
X-Received: by 2002:a05:620a:1581:: with SMTP id d1mr5621672qkk.327.1626380182088;
        Thu, 15 Jul 2021 13:16:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+STah4KcKuvlzg9i197/e/L8C5x8jj3hDXyaJxIMFWefnLu+xgSMUTIS74eTgb1IlTUGlEQ==
X-Received: by 2002:a05:620a:1581:: with SMTP id d1mr5621633qkk.327.1626380181806;
        Thu, 15 Jul 2021 13:16:21 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id 2sm1473664qka.68.2021.07.15.13.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:21 -0700 (PDT)
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
Subject: [PATCH v5 16/26] mm/hugetlb: Introduce huge pte version of uffd-wp helpers
Date:   Thu, 15 Jul 2021 16:16:18 -0400
Message-Id: <20210715201618.211711-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

