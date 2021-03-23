Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89B3345436
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhCWAuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhCWAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwDOET0+t9FVkgq293BQMlQJW4s7rxaX3ykZpO1NCQ8=;
        b=Q6TokDISAZV4g+j4bdnhqnPrX/O+SzXieW6S4Kkios7eKMFqSwrigCngVxqTSrwFXLeYUN
        j3HpdSDjdrmyNBmigdqeCHCYrmpt5igSmeqa2RCpsh0iMIre8TjKTf/gLj3Own65w8yE+g
        m9BOsYcPjnfZVc+uaPx+40fFlmvDyJk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-RbVlHmeCPiuTgz1d8KfdJw-1; Mon, 22 Mar 2021 20:49:41 -0400
X-MC-Unique: RbVlHmeCPiuTgz1d8KfdJw-1
Received: by mail-qk1-f197.google.com with SMTP id h134so835499qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwDOET0+t9FVkgq293BQMlQJW4s7rxaX3ykZpO1NCQ8=;
        b=Pa9+IEBzeJ6Eo7yNWk8Sbm0B3veOX9xDsfXlhQ7hVn8Mv/MHW1DVzYqz01J7Kxp+EA
         NhOHduYgXddlJCyPTHlqrC0jPu009rAJm3id/k9I3OgSIBnP+T4Bs7NuBP1VRzMQBvyi
         8U/Jl+KMqWPArBFcfJc2g3q6sLrLfi1DCAu0Dp9A39N3e8LqgqFJGFwETrD2lhJ2CHye
         Du9kqVkd1x8PnKCYevQ8/hAp+RiLc+4vRxxO/C5NTnS3GdCRwMTg9SL9oAujgQc4pen6
         COmveso07AZO3UJeotHDTtSpjjipTbselmwNeaYoQGhaXT2EzDGku/5RsHBTI/Tw/Es6
         V8RA==
X-Gm-Message-State: AOAM531bEMsBW/eV/cmmjrz44VbhzUws7LH91+Ts0KpgWzC6Ye4X6yuK
        omzRgt4jA6aSYSFWe/rczsWwjs7ALOnnShDQCvUpQ1dLsS9cuSIK8KD0pCB6tkbZI8C66R9s88/
        KKqbZYe+LqFnRi/0WKaeJFYTs1mrzxknoLtqr57PSLGAlacMcM+Afi/Noh8jD9NW+jQcQVBls2Q
        ==
X-Received: by 2002:a37:e315:: with SMTP id y21mr2972113qki.418.1616460580545;
        Mon, 22 Mar 2021 17:49:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGhlvWbuuhEk+ZKMiW+MQgkfAcTKCZx9vxyblCGaELts7EA6fuF6kIJ/7TdB+zCUR+L3XDeA==
X-Received: by 2002:a37:e315:: with SMTP id y21mr2972089qki.418.1616460580286;
        Mon, 22 Mar 2021 17:49:40 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 15/23] hugetlb/userfaultfd: Hook page faults for uffd write protection
Date:   Mon, 22 Mar 2021 20:49:04 -0400
Message-Id: <20210323004912.35132-16-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up hugetlbfs_fault() with the capability to handle userfaultfd-wp faults.

We do this slightly earlier than hugetlb_cow() so that we can avoid taking some
extra locks that we definitely don't need.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 56b78a206913..def2c7ddf3ae 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4643,6 +4643,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
 		goto out_ptl;
 
+	/* Handle userfault-wp first, before trying to lock more pages */
+	if (userfaultfd_pte_wp(vma, huge_ptep_get(ptep)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = haddr,
+			.flags = flags,
+		};
+
+		spin_unlock(ptl);
+		if (pagecache_page) {
+			unlock_page(pagecache_page);
+			put_page(pagecache_page);
+		}
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		i_mmap_unlock_read(mapping);
+		return handle_userfault(&vmf, VM_UFFD_WP);
+	}
+
 	/*
 	 * hugetlb_cow() requires page locks of pte_page(entry) and
 	 * pagecache_page, so here we need take the former one
-- 
2.26.2

