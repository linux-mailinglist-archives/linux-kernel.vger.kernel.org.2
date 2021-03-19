Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A653420ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCSPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCSPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:25:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:25:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so6895435pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubcs0Ulnb7+ecMoLP+SH+vifS5g0Za2K8fsbw01RIbE=;
        b=lfjE6Uzj9X3CSX3vYcKPg2zZhqx2FrfiJ3g/E1GFg76kpcTLxUrn2CYmEbQPhyA6KK
         n6+ZQ8w97auqeQ7Hzkz087b9+Tbyzvs6TLjUxWnsAufiErWR1a9D5Q9+SkGz1hdVcyMq
         K7LAxWmTvacNYbT510h/T4dFpnClN/WapVbpZwzOgjqOS2qEWMl1d6w+Ij4MdWC7XLgl
         AZndUZAwylRFXNSL+ZTgf+CW9tUMaSJFt7PhULR+VHC1qavk3TMPo5uNxtlKKFGZ2HXH
         XkswqecIoVF5LbLR74N66TDIkJtYYy/C1QoB+2SQ3owFzfMuIRNPytt6JxSwpQIOopu+
         KfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubcs0Ulnb7+ecMoLP+SH+vifS5g0Za2K8fsbw01RIbE=;
        b=gVCe55B3RhxYk9+TGB1sVYAI/R4rOVGW9XdH3fClJNE6unP8utxTzWibylz1Zh5ntr
         hs506ZK1bHsV1DcyNX5XiRA3u/9A56aRHEWORYPcTxIr4npbE6z6goVlEYtzwY4LPJMJ
         QS2a9myHyQdIJxZ/X2qJRPTS06Zjp1R+ulJF1Z+zBULHggNOJQSWsRKt8yE0kh2c+n9b
         +Po2uY8aY2w2FrJ6sENTJc1QDMIs/iqEdn0Ea0O9cBH1T25TGCjbplEfiPK9a7ABAxqb
         Xm1royfmUs6If6avlkiyPbkk3pL1GMKrKu1K7/IUtl4tz3MiaQdwX01r1bKZyKrlymgw
         eEkQ==
X-Gm-Message-State: AOAM530Bszt986BeRz2LgkvYN0yH5uTduaAM4BHd/sWuOsg1eym7nPZ8
        iNFe31/cEXIq8C8/FyVGUPwMGLuNd3on4Q==
X-Google-Smtp-Source: ABdhPJyQEWmhY5pMFSpEq1J36JDEAIhHWB0wsE3Fw2vI2noMagO1WK4XLoCG88mg7descMf1BnVgGg==
X-Received: by 2002:a17:90a:f403:: with SMTP id ch3mr10315211pjb.126.1616167510934;
        Fri, 19 Mar 2021 08:25:10 -0700 (PDT)
Received: from localhost.localdomain ([113.172.181.219])
        by smtp.gmail.com with ESMTPSA id d138sm336346pfd.55.2021.03.19.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:25:10 -0700 (PDT)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minhquangbui99@gmail.com
Subject: [PATCH] userfaultfd: Write protect when virtual memory range has no page table entry
Date:   Fri, 19 Mar 2021 22:24:28 +0700
Message-Id: <20210319152428.52683-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userfaultfd_writeprotect() use change_protection() to clear write bit in
page table entries (pte/pmd). So, later write to this virtual address
range causes a page fault, which is then handled by userspace program.
However, change_protection() has no effect when there is no page table
entries associated with that virtual memory range (a newly mapped memory
range). As a result, later access to that memory range causes allocating a
page table entry with write bit still set (due to VM_WRITE flag in
vma->vm_flags).

Add checks for VM_UFFD_WP in vma->vm_flags when allocating new page table
entry in missing page table entry page fault path.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 mm/huge_memory.c | 12 ++++++++++++
 mm/memory.c      | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ae907a9c2050..9bb16a55a48c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -636,6 +636,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 		entry = mk_huge_pmd(page, vma->vm_page_prot);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+		if (userfaultfd_wp(vma)) {
+			entry = pmd_wrprotect(entry);
+			entry = pmd_mkuffd_wp(entry);
+		}
+
 		page_add_new_anon_rmap(page, vma, haddr, true);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
@@ -643,6 +648,13 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(vma->vm_mm);
+
+		if (userfaultfd_huge_pmd_wp(vma, *vmf->pmd)) {
+			spin_unlock(vmf->ptl);
+			count_vm_event(THP_FAULT_ALLOC);
+			count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
+			return handle_userfault(vmf, VM_UFFD_WP);
+		}
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
 		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
diff --git a/mm/memory.c b/mm/memory.c
index 5efa07fb6cdc..b835746545bf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3564,6 +3564,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
+	if (userfaultfd_wp(vma)) {
+		entry = pte_wrprotect(entry);
+		entry = pte_mkuffd_wp(entry);
+	}
+
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
@@ -3590,6 +3595,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
+
+	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return handle_userfault(vmf, VM_UFFD_WP);
+	}
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
-- 
2.25.1

