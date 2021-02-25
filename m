Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D209324B58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhBYHhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhBYHel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D5C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id ba1so2741226plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZI/Cbjn5yPQpxTbGPsLZp1NA7npdB4OJJowknZTVUs=;
        b=KjOOgxtrhZlH8VdO3dMyYpui8dLLX2TbOkHXP4hItYpluXhWbReLIAH0zLujUrAQYz
         S++VpRkVYfNGYMBON/Dw1siXsLXFn4MI1tQemzVZk+AyG0gxQUPCF4runK17YMZSDOst
         eMyTv7Se9QIfpWVUZSC2e4TW9RwMQswLSUob3trfEHFrCu/pujybAS+bt8jx8D5JSRko
         7j4ksmuDorNaeM77FX36QzIyIh536zFzd0euF5EenlcEt3J92kCkxmxBz03xfM+jDFJ8
         H682Owwk4peOC4ffUSJHOD5832Lwf7Jun5us4rT8vDmv2reNWUUbF5R+IzmPq3HTNCz+
         tB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZI/Cbjn5yPQpxTbGPsLZp1NA7npdB4OJJowknZTVUs=;
        b=cW0bqJokYk8pPOELr7Tzcv9YoXPOliLGEznCH9Jk9watRkHUHEEUfAQdgMB5M7Roo+
         SXkNStYRdkEYEkr1ZiTwifrzth37+oZbNC6PKy8g1IaXaUbykqP0seiOVQwKvqdyXbuY
         mirKHHGie7w5+JtVMdIVaier9y9H4hB6FRHBpJS9XpgW4cZ5G5rEl6XMyGWWRMYAHy8s
         x3Jrun8QwVxsOAdhSJkiEwYz3N8KR9D8AItNZnYdwIQKefj2+RKZxqY3HYZwEgSAsrQB
         FOILFlYE19+6gdxjyd5jXSN7WAozTHnkry7q8w/clBgrJ4ugOMPP7VzkhYUY8WJrW50g
         ZQCA==
X-Gm-Message-State: AOAM532J3dccfCvpU8JQIXXQOCUMMe9RdSU/gnHulNy6xkaXSMWhtqpI
        akpl7QHexX8zv+4QzBy0x2U=
X-Google-Smtp-Source: ABdhPJyr/UlzcZf2ldqJ+gitmpfnxmmzEHvMiLhJ+XDQ8mDA7ozvSlKj+GAJbrvNdJPIN+HxPqRCGg==
X-Received: by 2002:a17:90a:9c7:: with SMTP id 65mr2033257pjo.24.1614238435483;
        Wed, 24 Feb 2021 23:33:55 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:55 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [RFC 5/6] mm: use lightweight reclaim on FAULT_FLAG_RETRY_NOWAIT
Date:   Wed, 24 Feb 2021 23:29:09 -0800
Message-Id: <20210225072910.2811795-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

When FAULT_FLAG_RETRY_NOWAIT is set, the caller arguably wants only a
lightweight reclaim to avoid a long reclamation, which would not respect
the "NOWAIT" semantic. Regard the request in swap and file-backed
page-faults accordingly during the first try.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/memory.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 13b9cf36268f..70899c92a9e6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2679,18 +2679,31 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	return ret;
 }
 
-static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
+static gfp_t massage_page_gfp_mask(gfp_t gfp_mask, unsigned long vmf_flags)
 {
-	struct file *vm_file = vma->vm_file;
+	if (fault_flag_allow_retry_first(vmf_flags) &&
+	    (vmf_flags & FAULT_FLAG_RETRY_NOWAIT))
+		gfp_mask |= __GFP_NORETRY | __GFP_NOWARN;
 
-	if (vm_file)
-		return mapping_gfp_mask(vm_file->f_mapping) | __GFP_FS | __GFP_IO;
+	return gfp_mask;
+}
+
+static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma,
+				  unsigned long flags)
+{
+	struct file *vm_file = vma->vm_file;
+	gfp_t gfp_mask;
 
 	/*
 	 * Special mappings (e.g. VDSO) do not have any file so fake
 	 * a default GFP_KERNEL for them.
 	 */
-	return GFP_KERNEL;
+	if (!vm_file)
+		return GFP_KERNEL;
+
+	gfp_mask = mapping_gfp_mask(vm_file->f_mapping) | __GFP_FS | __GFP_IO;
+
+	return massage_page_gfp_mask(gfp_mask, flags);
 }
 
 /*
@@ -3253,6 +3266,7 @@ EXPORT_SYMBOL(unmap_mapping_range);
  */
 vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
+	gfp_t gfp_mask = massage_page_gfp_mask(GFP_HIGHUSER_MOVABLE, vmf->flags);
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL, *swapcache;
 	swp_entry_t entry;
@@ -3293,8 +3307,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
-			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
-							vmf->address);
+			page = alloc_page_vma(gfp_mask, vma, vmf->address);
 			if (page) {
 				int err;
 
@@ -3320,8 +3333,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				swap_readpage(page, true);
 			}
 		} else {
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
+			page = swapin_readahead(entry, gfp_mask, vmf);
 			swapcache = page;
 		}
 
@@ -4452,7 +4464,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.address = address & PAGE_MASK,
 		.flags = flags,
 		.pgoff = linear_page_index(vma, address),
-		.gfp_mask = __get_fault_gfp_mask(vma),
+		.gfp_mask = __get_fault_gfp_mask(vma, flags),
 	};
 	unsigned int dirty = flags & FAULT_FLAG_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
-- 
2.25.1

