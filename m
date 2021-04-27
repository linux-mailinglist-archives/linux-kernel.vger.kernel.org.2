Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92E936C958
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbhD0QZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237459AbhD0QQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1z1o5mbCVa78Hzla2EzzKhxkMDgZgiPiKG4mm1uLIY=;
        b=WEWIAYeNYs3WtK2dM6DjC0kvM9bmP7f8otW/T7SNXPxui18YVudy8nk5Y6PXmYPf+fsJjM
        qqsJy544774zJb0aFvT0GjIaFfT1C1mtvom7iMwnC5YRt4eCcN7VoLs/PZm9d0lZkbdKL3
        o52az9gf3NGgPfO4uKhpW2AZGIVUlTQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-Ulv9VXvnNc29x5z8IRGOKA-1; Tue, 27 Apr 2021 12:13:57 -0400
X-MC-Unique: Ulv9VXvnNc29x5z8IRGOKA-1
Received: by mail-qk1-f197.google.com with SMTP id s143-20020a3745950000b029028274263008so23356790qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1z1o5mbCVa78Hzla2EzzKhxkMDgZgiPiKG4mm1uLIY=;
        b=CS18JiLmLuEQWkakAcTHRZKXBXgcpGraCYW4iZpS3dTnY6FWYfECUW7VFFIhPISwSk
         mOnJHAfes95Gyto4R0tgIQD5Dit31NbwywOS6PH6+7HThi5TJ5ffjDjY9ipRHaJQ9VJg
         9AlUEFxxWSMeayhlwV2qKp0c5z4YcO1J/5P0Bp3q+gF6mpHqGVzf8nfF4pBxCfSlMuId
         8yMaIl/ahPo9rwOkS60k0B9LIB2Ww+ZltmtWDzR5D9+cckjw4nzryj3j15Tb2Q0WbgfS
         qwqTA2/llKe9uW3Ym4nUho83QGk7fgQ5FSWjXdGsnoz8WCPU68Anr1ZZ3wzuP6smBTzF
         nj+A==
X-Gm-Message-State: AOAM530HcHuvuaf7hFAaDa5++gyNF0H6MiSvg7cfwtuQaR4ZTw978pak
        CTICDl2V7GBnedhwEp2tzxeFZrucX7/dgp5k6KD+v1XF6tCbw4ZERq1lfM6JkwewtleW0Y+8wxz
        Gxe4nAtSh1Kol2ky9fzNhq8T6
X-Received: by 2002:a05:620a:133c:: with SMTP id p28mr11069458qkj.3.1619540036830;
        Tue, 27 Apr 2021 09:13:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBwc48GEDC8J2KNhfxo5GVkwB09tGhSlMBTREmsPdAdSwfXDt4d9f/uX9TJoG1RIhmgJavrQ==
X-Received: by 2002:a05:620a:133c:: with SMTP id p28mr11069428qkj.3.1619540036590;
        Tue, 27 Apr 2021 09:13:56 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:55 -0700 (PDT)
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
Subject: [PATCH v2 21/24] hugetlb/userfaultfd: Allow wr-protect none ptes
Date:   Tue, 27 Apr 2021 12:13:14 -0400
Message-Id: <20210427161317.50682-22-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index d9ff7db14175d..fa9af9c893512 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5264,7 +5264,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -5284,13 +5284,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
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
@@ -5314,12 +5320,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
 
@@ -5332,6 +5347,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
2.26.2

