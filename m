Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3724E3CADB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbhGOUTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245151AbhGOUTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/r2tEksA7iAG8svGDApMzfpTe7AXzjcSqF0fovWgO0=;
        b=FqzioBVj2I69DI0VLHSvkrxK0GXahednym7Tc8SDD9X0OEIp9o0KPYBNBOveNNBGXyYPC4
        qwShKMH9uePygiGKvDi3nFc3YZQDKRcB36Gj80DJRQ8FdU5yXQ4LUMWaNwHQYjWeRVh2RH
        KYJAlHOZweT45UYm8/kE1s1YqOCk59U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-HRxVzFKBN6iZmhoz7f8B4A-1; Thu, 15 Jul 2021 16:16:14 -0400
X-MC-Unique: HRxVzFKBN6iZmhoz7f8B4A-1
Received: by mail-qk1-f200.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so4693616qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/r2tEksA7iAG8svGDApMzfpTe7AXzjcSqF0fovWgO0=;
        b=T7h8Edw+MfjXGnXel/n58tHzmycGYXYENDKuoPrWJq8BCfMespvtYTiXhJIOfmu/Iy
         yGKWCTZ6zlwIIBjtOrcBRviIq1coIOqaDtR2x3pMr4M79IpB2M1ONatSOgS3aPdTFcVK
         unAIhFqhnTUhQJ3FWLfWOu+5xIGw6EJShgtI9nwB2oCPbidRkuQj7emKj4OGYs10Kl/H
         AJBRSIjVARkBn06jq0zMTp3SQRxS3BKeECoiSCbaXiM8XlKEwDUs1U8P85v5lcduMxub
         /W821XqcmtHnTBqJynRraT3RGMROfpAocvQwefYd4QeE+kTgQYJaboiEBc1QiyPNu1LH
         KQgA==
X-Gm-Message-State: AOAM531NrndiP/uUzv7ST9ExaPXquVSvskcJSy9hoPQe9n6kzC/e7vDW
        FaUdudqcKEbr2i4hW57aLj3DjW7vKegj4djcphoQfTQ9FQCoEffOXCD+rYJ8GlwJie7cGQrPRNI
        JXnd6Q6uUBYNX0koz7G7n6D9iCs5v358TvB/JhmwStBxV5cj+tgRn0mpJmKfjX+I9hlvJEdaWJg
        ==
X-Received: by 2002:a05:620a:f03:: with SMTP id v3mr5952792qkl.96.1626380173885;
        Thu, 15 Jul 2021 13:16:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAlTDTDWRdLJ3h6dBRK5Qwm2taDlF4dP+ne0nAsiUi62UZRnXM9yTbENjgnGhNk1frpAneVw==
X-Received: by 2002:a05:620a:f03:: with SMTP id v3mr5952756qkl.96.1626380173626;
        Thu, 15 Jul 2021 13:16:13 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id l5sm2958062qkb.62.2021.07.15.13.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:16:13 -0700 (PDT)
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
Subject: [PATCH v5 14/26] shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
Date:   Thu, 15 Jul 2021 16:16:10 -0400
Message-Id: <20210715201610.211610-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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
index 223781f115e9..af91bee934c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -776,8 +776,21 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
 			return -EIO;
-- 
2.31.1

