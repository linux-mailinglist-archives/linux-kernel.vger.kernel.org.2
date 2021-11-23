Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403D645AEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhKWVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbhKWVv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:51:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1EC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:19 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t6so676017qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IVq3xL/pGZ8u0z7x5W1W5jQgsvzAwjupWoCmB038rW4=;
        b=G1yf+kXdQSCQD2XX4vpaXjnLHMUnVSvr8wghraZeZ54IeI3vABq00MYhRLvn7B0BQj
         WFnWrl3P4ameNfuBol/K0SMcyQjGHxvbqMW5sxYkW9pBjZzyGbdX31YKs4VquaKaZ6kE
         atxbCrZJ/yH6iW0bSfSMepvDf2oPgSogWZ437zF6n9hr2miP+UXMJGx5bD3m4tN538Nn
         QMv5b50OrO2q5Cz0el22udQqQwwJ1Jvi3AyycvyRdbeaQ1ZKmrUyYELWFRw4jgKkX/22
         bvihqUrzRtt+eAVAxIQBYxdTmK85MlBLafz7BfQZvqfuWzsb4RdomknG2N4TZOoBxF27
         N7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVq3xL/pGZ8u0z7x5W1W5jQgsvzAwjupWoCmB038rW4=;
        b=XgJFraitZ6XXNFVEB0BXO04oGw4zocF4M5u4185cOcrkxRUxtWGxO/OwFXMErVK/1C
         qzd0/HZ7vUK9zSqo0Klw0hMIfY3Cgru67xXtu0gCjTYqKMI1tT2LykTmj/R328ahHTE4
         IoAtrQen4dsANLMtShWPcNX74kxYWj6rNHgaSpvI8s1F8nunlo28zryYkVA3fP5mFI1C
         psI+bQpdp0ZIiirMg21/aBWCkOGlRpnGb/0MIJt/15CuR4j2HxUH5G3ncN0sRvZQRemm
         W9bmw1auPEJLyRZ1qxz0aVM1pz6tsc/yBvm0UwRfJpGVT5aOaKkQ7fd1GC5bYvCA5dbi
         8Fwg==
X-Gm-Message-State: AOAM531J0rNfrOlRgWNlBONpxrAPiVRJlT2cx3Zzf2Fy4UPm+WUDdNoG
        FkU/fp3rfQ3u9zp0PXRMGr7PcQ==
X-Google-Smtp-Source: ABdhPJxa4rkJ3dDwmQINdVy3b0iHLUCHPrStd8iakB8X+JnpdpcRlZN05HXBIWWcP0xIf6ILqJywfw==
X-Received: by 2002:a37:9f84:: with SMTP id i126mr620199qke.249.1637704098675;
        Tue, 23 Nov 2021 13:48:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i11sm7356912qko.116.2021.11.23.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:48:18 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com
Subject: [PATCH 1/3] mm: ptep_clear() page table helper
Date:   Tue, 23 Nov 2021 21:48:12 +0000
Message-Id: <20211123214814.3756047-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have ptep_get_and_clear() and ptep_get_and_clear_full() helpers to
clear PTE from user page tables, but there is no variant for simple
clear of a present PTE from user page tables without using a low level
pte_clear() which can be either native or para-virtualised.

Add a new ptep_clear() that can be used in common code to clear PTEs
from page table. We will need this call later in order to add a hook
for page table check.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/vm/arch_pgtable_helpers.rst |  6 ++++--
 include/linux/pgtable.h                   |  8 ++++++++
 mm/debug_vm_pgtable.c                     |  2 +-
 mm/khugepaged.c                           | 12 ++----------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index 552567d863b8..fbe06ec75370 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -66,9 +66,11 @@ PTE Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_mknotpresent          | Invalidates a mapped PTE                         |
 +---------------------------+--------------------------------------------------+
-| ptep_get_and_clear        | Clears a PTE                                     |
+| ptep_clear                | Clears a PTE                                     |
 +---------------------------+--------------------------------------------------+
-| ptep_get_and_clear_full   | Clears a PTE                                     |
+| ptep_get_and_clear        | Clears and returns PTE                           |
++---------------------------+--------------------------------------------------+
+| ptep_get_and_clear_full   | Clears and returns PTE (batched PTE unmap)       |
 +---------------------------+--------------------------------------------------+
 | ptep_test_and_clear_young | Clears young from a PTE                          |
 +---------------------------+--------------------------------------------------+
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e24d2c992b11..bc8713a76e03 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,14 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_CLEAR
+static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep)
+{
+	pte_clear(mm, addr, ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 228e3954b90c..cd48a34c87a4 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -652,7 +652,7 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
 	flush_dcache_page(page);
 	barrier();
-	pte_clear(args->mm, args->vaddr, args->ptep);
+	ptep_clear(args->mm, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
 	WARN_ON(!pte_none(pte));
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index dd807261ed9f..c78242d15406 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -756,11 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 				 * ptl mostly unnecessary.
 				 */
 				spin_lock(ptl);
-				/*
-				 * paravirt calls inside pte_clear here are
-				 * superfluous.
-				 */
-				pte_clear(vma->vm_mm, address, _pte);
+				ptep_clear(vma->vm_mm, address, _pte);
 				spin_unlock(ptl);
 			}
 		} else {
@@ -774,11 +770,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			 * inside page_remove_rmap().
 			 */
 			spin_lock(ptl);
-			/*
-			 * paravirt calls inside pte_clear here are
-			 * superfluous.
-			 */
-			pte_clear(vma->vm_mm, address, _pte);
+			ptep_clear(vma->vm_mm, address, _pte);
 			page_remove_rmap(src_page, false);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
-- 
2.34.0.rc2.393.gf8c9666880-goog

