Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E6309954
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhAaARr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhAaAQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E198C061786
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id my11so7957776pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWAT5LTYdh0RU/BQ9SE2YshZULg3KZXfLmEPedqIyqE=;
        b=UuM/YrXEkvYOegT3ZR4hSe5siUCIuNlpxDunWSaWN3A6lStfUT0VCrnTWP0ywlm2ak
         3SOPc+b2jJ4nnbxG3nLmr5B4H/UHzjArVF/yNXzV2nFHH9FCFuyOTZbXtDCnOX4OV8Ad
         OpW5avMfxmalWCBjgBnVTTQ/x4A5rLgf26xV14RNvci96a0oxUuZ3iO+86TuSYDMC6I8
         s6my2/kIyDXGPxQYFP2bGWiTO30o/+oLvqVoID/I1NVJu7IJYQhoO/JreQ1yIl4aOOJA
         VV54+EiaeqX9kD033IWxjZYoTTCxMfwObVX6zvpwN1Jl8jiqDDTd0JlKSL9F0qMX8ubg
         NqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWAT5LTYdh0RU/BQ9SE2YshZULg3KZXfLmEPedqIyqE=;
        b=SPDRkH9u42dBDqIdr+M7epKNfw4pZITgJ4bzNGTEbk8ckC9ZNQhuebiE/srz+HVaQ9
         VjAOykrGqBz+8EbdvThsBTgBb8M0Zcz9kT/5sUPDNfbVbQ5pMt/1P0vLWPH/2N+gKLLD
         e/v0DNIbP25Vc+08mmaPqJ/Gul+dRCML48RPh2D5PlFAZElRzxenPBzOR23fKz7oMGuc
         VikEYkVTXIcRJsenw7FZ0URiRDwbUDgo72bWEK9/uVx2A+3V89q/em7F/1r+6FDV5dvk
         zln2UQOn8TL630qGLk6icM/WSueRQn8Zi6YLxTdzjqwDLcwIysB7jHQaKG85TF9Xw4Mh
         jDsg==
X-Gm-Message-State: AOAM531TEqZiQOvqFcDNHfUmp+3+KBDX//RA/c2MqYToY2waCTnHbgIm
        1pccYIhIABcF7XGQyqphaa8=
X-Google-Smtp-Source: ABdhPJyAOtaB18E0ZUfJhrWQrqey7BWu2lxfepi790EgHIvhgRAbOLPI5LnhO91qOv9N9CzgTqL6ww==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr10424487pjo.189.1612052169930;
        Sat, 30 Jan 2021 16:16:09 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:09 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC 06/20] fs/task_mmu: use mmu_gather interface of clear-soft-dirty
Date:   Sat, 30 Jan 2021 16:11:18 -0800
Message-Id: <20210131001132.3368247-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Use mmu_gather interface in task_mmu instead of
{inc|dec}_tlb_flush_pending(). This would allow to consolidate the code
and to avoid potential bugs.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 fs/proc/task_mmu.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cec6fbef725..4cd048ffa0f6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1032,8 +1032,25 @@ enum clear_refs_types {
 
 struct clear_refs_private {
 	enum clear_refs_types type;
+	struct mmu_gather tlb;
 };
 
+static int tlb_pre_vma(unsigned long start, unsigned long end,
+		       struct mm_walk *walk)
+{
+	struct clear_refs_private *cp = walk->private;
+
+	tlb_start_vma(&cp->tlb, walk->vma);
+	return 0;
+}
+
+static void tlb_post_vma(struct mm_walk *walk)
+{
+	struct clear_refs_private *cp = walk->private;
+
+	tlb_end_vma(&cp->tlb, walk->vma);
+}
+
 #ifdef CONFIG_MEM_SOFT_DIRTY
 
 #define is_cow_mapping(flags) (((flags) & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE)
@@ -1140,6 +1157,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		/* Clear accessed and referenced bits. */
 		pmdp_test_and_clear_young(vma, addr, pmd);
 		test_and_clear_page_young(page);
+		tlb_flush_pmd_range(&cp->tlb, addr, HPAGE_PMD_SIZE);
 		ClearPageReferenced(page);
 out:
 		spin_unlock(ptl);
@@ -1155,6 +1173,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
 			clear_soft_dirty(vma, addr, pte);
+			tlb_flush_pte_range(&cp->tlb, addr, PAGE_SIZE);
 			continue;
 		}
 
@@ -1168,6 +1187,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		/* Clear accessed and referenced bits. */
 		ptep_test_and_clear_young(vma, addr, pte);
 		test_and_clear_page_young(page);
+		tlb_flush_pte_range(&cp->tlb, addr, PAGE_SIZE);
 		ClearPageReferenced(page);
 	}
 	pte_unmap_unlock(pte - 1, ptl);
@@ -1198,6 +1218,8 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 }
 
 static const struct mm_walk_ops clear_refs_walk_ops = {
+	.pre_vma		= tlb_pre_vma,
+	.post_vma		= tlb_post_vma,
 	.pmd_entry		= clear_refs_pte_range,
 	.test_walk		= clear_refs_test_walk,
 };
@@ -1248,6 +1270,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			goto out_unlock;
 		}
 
+		tlb_gather_mmu(&cp.tlb, mm);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
@@ -1256,7 +1279,6 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				vma_set_page_prot(vma);
 			}
 
-			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
@@ -1265,10 +1287,9 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				&cp);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
-			flush_tlb_mm(mm);
-			dec_tlb_flush_pending(mm);
 		}
 out_unlock:
+		tlb_finish_mmu(&cp.tlb);
 		mmap_write_unlock(mm);
 out_mm:
 		mmput(mm);
-- 
2.25.1

