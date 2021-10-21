Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C698436B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJUTzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhJUTzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:55:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F6BC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t11so1141343plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppGy6AQbHnjCFGSfBBiNfJAwHFBC18I3Nums49Qp4rg=;
        b=U0hlQgwsREzwNIA20fgl1YsScyiSJXb4rLjRg1wz3mBQYgMNQ+IjpEK7387xyH7JkV
         qmVnulwbVyxw3rmj8vPQhyvOn/OqV4yJx4dK8k0Aako34Bs0jAtDvRxf10N9qF3mx0Rn
         f0vS0Tg97kF6Lzv+2QVRKcL6JvSnckS2f5E/vsZiseRS0EKWEeF1NOmgwBtVe+6D3P6q
         epYHqYopt5aj27JW2trNi91Und57gdcPk36/6uMqwJjCLK+5G5KcRPDfAiJB3ELOP20B
         DRGcxiyIrfopGeWhsl8OcHAkpqOqLd5f4eoo/dlv87ItbXi0AOZbyOKwsFqwfH05Im7p
         1b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppGy6AQbHnjCFGSfBBiNfJAwHFBC18I3Nums49Qp4rg=;
        b=QWH/BbV0Fxic6/EeXVmcHKDpHVYWIczVMQK+aJ1boWPjkFsQTJILHkEuTayt0BxqTD
         u2dETZU9w6V7g9rdXLyOcAhbiOOpOJ3kyUyzsi1sCG5oceNUdBjb0odpj6yF3c7PxsOs
         0o3Wo26Shr/SA+zr9rSQMLDNP2nWgY7Z55NiLqRN2VPmKPdvLOjlvmo1zVz5PwD0DSfH
         n/ni3mseGKQlAGBhc2Orbg3mxO8qs1JtudZ3BDcRUNrk1anpaoaaysNnE+WSOaV5cWPS
         Dp/A2LaC+PwmkHFBJS4HaBoQM4vBjnNDjzrCLAQZC2QiKH/F/Tw2DoS5DKCrxCtOnEwe
         5FxQ==
X-Gm-Message-State: AOAM531agNSeq16jf7nTuxBDS2sJoBdKqsSlj7Los9IeR/CE7iHjN/7a
        0Cwzxi8vSp0R+rAw41hGjb4=
X-Google-Smtp-Source: ABdhPJy7zcJn3qNfuZ+x0jgYPf1goT6pv5RF7V4ijPVQm6pq9YaVEd3bqwUA39f2Bi9H+10rQIqXeA==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr9087894pjb.14.1634845969760;
        Thu, 21 Oct 2021 12:52:49 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n202sm7098078pfd.160.2021.10.21.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:52:49 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
Date:   Thu, 21 Oct 2021 05:21:09 -0700
Message-Id: <20211021122112.592634-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021122112.592634-1-namit@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Calls to change_protection_range() on THP can trigger, at least on x86,
two TLB flushes for one page: one immediately, when pmdp_invalidate() is
called by change_huge_pmd(), and then another one later (that can be
batched) when change_protection_range() finishes.

The first TLB flush is only necessary to prevent the dirty bit (and with
a lesser importance the access bit) from changing while the PTE is
modified. However, this is not necessary as the x86 CPUs set the
dirty-bit atomically with an additional check that the PTE is (still)
present. One caveat is Intel's Knights Landing that has a bug and does
not do so.

Leverage this behavior to eliminate the unnecessary TLB flush in
change_huge_pmd(). Introduce a new arch specific pmdp_invalidate_ad()
that only invalidates the access and dirty bit from further changes.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pgtable.h | 8 ++++++++
 include/linux/pgtable.h        | 5 +++++
 mm/huge_memory.c               | 7 ++++---
 mm/pgtable-generic.c           | 8 ++++++++
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..18c3366f8f4d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1146,6 +1146,14 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	}
 }
 #endif
+
+#define __HAVE_ARCH_PMDP_INVALIDATE_AD
+static inline pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
+				       unsigned long address, pmd_t *pmdp)
+{
+	return pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
+}
+
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..622efe0a9ef0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -561,6 +561,11 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD
+extern pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma,
+				unsigned long address, pmd_t *pmdp);
+#endif
+
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5ea5f775d5c..435da011b1a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1795,10 +1795,11 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	 * The race makes MADV_DONTNEED miss the huge pmd and don't clear it
 	 * which may break userspace.
 	 *
-	 * pmdp_invalidate() is required to make sure we don't miss
-	 * dirty/young flags set by hardware.
+	 * pmdp_invalidate_ad() is required to make sure we don't miss
+	 * dirty/young flags (which are also known as access/dirty) cannot be
+	 * further modifeid by the hardware.
 	 */
-	entry = pmdp_invalidate(vma, addr, pmd);
+	entry = pmdp_invalidate_ad(vma, addr, pmd);
 
 	entry = pmd_modify(entry, newprot);
 	if (preserve_write)
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4e640baf9794..b0ce6c7391bf 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -200,6 +200,14 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 }
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_INVALIDATE_AD
+pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
+			 pmd_t *pmdp)
+{
+	return pmdp_invalidate(vma, address, pmdp);
+}
+#endif
+
 #ifndef pmdp_collapse_flush
 pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp)
-- 
2.25.1

