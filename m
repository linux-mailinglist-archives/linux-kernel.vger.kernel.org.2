Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2347E3C93CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhGNW2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237035AbhGNW2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EzkVzkNiBeZzaTPMlb/0FnWgb1POP033DBuy6Id530=;
        b=fUTAvnRg+yXrRxLOZZetPCGou0yfMCoDNMmutrgxd+nv4n9wZ7TaU2y+bh2KrdSREJH8fo
        XRhrEwnsB/NadWPakPOe+KvMGPOJLzJapaG5JkkKUBZ68uKmrMNT+6908iKChwWygZP7Yx
        uwyGIVKK/LjmCt+X7zVwfq28jRH6xvE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-jI_bKcs_OSqZkNj1SwBIDw-1; Wed, 14 Jul 2021 18:25:24 -0400
X-MC-Unique: jI_bKcs_OSqZkNj1SwBIDw-1
Received: by mail-qk1-f200.google.com with SMTP id j9-20020a05620a0009b02903b770762a3cso2280596qki.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EzkVzkNiBeZzaTPMlb/0FnWgb1POP033DBuy6Id530=;
        b=jwdi8obVP6iKSSmkVkyqWDS0FAtlUQNkSpE8+NCK3xSIdNGVaeJ3zIQw60NTawydt9
         +dTVbKwdH0I8+TvZ1d4ZoWzo/PVdSfojOZldV0xycOULDG4Dpoq8aJs8t0R/RZkDI9UO
         5rQgF8S+5CxsQoWG79K2Qm3oiK16n6QTS1kfalpv+0NOMxIH8d4VjHzxNNHFKjRjlCea
         tfwoJwkN1E/DxVFEbu8B7nh8icvL6pfXmoXQ1KDj16P4sSvH3cEu6dQTqA03mPo6F/io
         wBV4mEBa3pwQHn3Jzffyi4icG7YkaOEv9nfQ0DuuM4Ku6RtXm7W/0V0nR8p++uXbMHYg
         nvOQ==
X-Gm-Message-State: AOAM531SomdUzjjzNlCXeQlzh0SFh7rZy5B6Dc2M8AWLsT2DL90O88DJ
        vEw3vV6nUO7o2TTeW6TGiAJJkQOSJxYlqOA7bzctsbi9OLXkWNch7MTuWjIdImAo7x2bReIaBkx
        4Y9yQO2A6za1ArVZV5HXOxMgT
X-Received: by 2002:ac8:7d90:: with SMTP id c16mr305197qtd.337.1626301523537;
        Wed, 14 Jul 2021 15:25:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhP5fg1wkNrQQCAKpXp/mImlAGeXr4rNaibuFCbezexu1TgG1nGIouuRpG9MYniJZSSS7zdQ==
X-Received: by 2002:ac8:7d90:: with SMTP id c16mr305170qtd.337.1626301523315;
        Wed, 14 Jul 2021 15:25:23 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b3sm1299441qto.49.2021.07.14.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 22/26] hugetlb/userfaultfd: Allow wr-protect none ptes
Date:   Wed, 14 Jul 2021 18:25:19 -0400
Message-Id: <20210714222519.49194-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach hugetlbfs code to wr-protect none ptes just in case the page cache
existed for that pte.  Meanwhile we also need to be able to recognize a uffd-wp
marker pte and remove it for uffd_wp_resolve.

Since at it, introduce a variable "psize" to replace all references to the huge
page size fetcher.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 15e5de480cf0..6ae911185554 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5561,7 +5561,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -5581,13 +5581,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
-	for (; address < end; address += huge_page_size(h)) {
+	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, huge_page_size(h));
+		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+			/*
+			 * When uffd-wp is enabled on the vma, unshare
+			 * shouldn't happen at all.  Warn about it if it
+			 * happened due to some reason.
+			 */
+			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -5612,12 +5618,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, huge_page_size(h));
+						     newpte, psize);
 				pages++;
 			}
 			spin_unlock(ptl);
 			continue;
 		}
+		if (unlikely(is_swap_special_pte(pte))) {
+			WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+			/*
+			 * This is changing a non-present pte into a none pte,
+			 * no need for huge_ptep_modify_prot_start/commit().
+			 */
+			if (uffd_wp_resolve)
+				huge_pte_clear(mm, address, ptep, psize);
+		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
@@ -5631,6 +5646,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+		} else {
+			/* None pte */
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						pte_swp_mkuffd_wp_special(vma));
 		}
 		spin_unlock(ptl);
 	}
-- 
2.31.1

