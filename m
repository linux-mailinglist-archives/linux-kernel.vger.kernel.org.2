Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB923A24CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhFJGzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFJGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:54:52 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:52:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j189so26364350qkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wPomTLe6CFftHojVSA5u1wexcpwAxzEQRGtDVYSW6+s=;
        b=iI++N3FVNIIBdaZPkAyQ282hUtC9qN+UvCMayG6voYHqIBNoZg9iTLOV8/yobWd0qD
         t5j/wpMpnNQpZX0fvnA0I7clVpIc0Z/D/eOqSRq2x5fAOxilbxDRaH47SQra+Jtl95gG
         6rjZt9jmANiCu553oPYamuydpCiIBfDeCuo8I07jAOxVEpXLoQZkqbpatpVGTDDzKNwR
         NuozFU/z4okvWcVDq4DIwr2iTzt13KJqKW8qwosEz7s8Tvlf4bzBblR5CtO3Z3JEY8X9
         ppgPbqauTyQUhoJ5eMr1mU226mQPTSf9ZJuVDwcpm2dS8Nwas4iL01nwwfDDfihW8bmm
         UFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wPomTLe6CFftHojVSA5u1wexcpwAxzEQRGtDVYSW6+s=;
        b=NyrcPSGFfOugXWfoPj8YqTnAS4Fw33l8e8TILk4zbEu+nrod0i1C4ZQBeXSgecCOsG
         jCfb1+If6N7uDrKReK57Hq3vO06NGC5/SFRuG4dBlnM6uyjXgMqbyNZToIAra3Br7i8d
         622PwV50aL9oRHO9wdFU/+nKcsKPs7yL4NXo/GwKa9X0zTNQjdZ/TcxFTRuORFGZ5uWz
         fJUBrHE3y6cmqTM0bs0B0BcZebYoxJHH6iYGKSOwoQ9MgzbrFu80BxQzY92NQe9XdJft
         SZbceNIjt72ZQ7BcTKl/gyuTnfXfxTWrkFD19f2N6HyLSisp+dK/u/C28TzsXxz1ycTg
         /M3g==
X-Gm-Message-State: AOAM5305fa3YZWL4G0jWaa1Axzf5bQrU6BNgzxbKwpyi4ymWfnGY2q1W
        v5mhXhBU77sLlKxtpi8ePUu4Yg==
X-Google-Smtp-Source: ABdhPJyQI0UMif8PlESv2eTJgfLB9PUenRlpUP2M0SClQAZIdQdIkhs67p1JmPDKCwhCQr3B8G8OiQ==
X-Received: by 2002:a05:620a:e89:: with SMTP id w9mr3215130qkm.256.1623307959660;
        Wed, 09 Jun 2021 23:52:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o16sm1635297qtw.10.2021.06.09.23.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:52:39 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:52:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] mm/thp: fix page_vma_mapped_walk() if THP mapped by
 ptes
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <fedb8632-1798-de42-f39e-873551d5bc81@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running certain tests with a DEBUG_VM kernel would crash within hours,
on the total_mapcount BUG() in split_huge_page_to_list(), while trying
to free up some memory by punching a hole in a shmem huge page: split's
try_to_unmap() was unable to find all the mappings of the page (which,
on a !DEBUG_VM kernel, would then keep the huge page pinned in memory).

Crash dumps showed two tail pages of a shmem huge page remained mapped
by pte: ptes in a non-huge-aligned vma of a gVisor process, at the end
of a long unmapped range; and no page table had yet been allocated for
the head of the huge page to be mapped into.

Although designed to handle these odd misaligned huge-page-mapped-by-pte
cases, page_vma_mapped_walk() falls short by returning false prematurely
when !pmd_present or !pud_present or !p4d_present or !pgd_present: there
are cases when a huge page may span the boundary, with ptes present in
the next.

Restructure page_vma_mapped_walk() as a loop to continue in these cases,
while keeping its layout much as before. Add a step_forward() helper to
advance pvmw->address across those boundaries: originally I tried to use
mm's standard p?d_addr_end() macros, but hit the same crash 512 times
less often: because of the way redundant levels are folded together,
but folded differently in different configurations, it was just too
difficult to use them correctly; and step_forward() is simpler anyway.

Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f6839f536645..6eb2f1863506 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -116,6 +116,13 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 	return pfn_is_match(pvmw->page, pfn);
 }
 
+static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
+{
+	pvmw->address = (pvmw->address + size) & ~(size - 1);
+	if (!pvmw->address)
+		pvmw->address = ULONG_MAX;
+}
+
 /**
  * page_vma_mapped_walk - check if @pvmw->page is mapped in @pvmw->vma at
  * @pvmw->address
@@ -183,16 +190,22 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pte)
 		goto next_pte;
 restart:
-	{
+	do {
 		pgd = pgd_offset(mm, pvmw->address);
-		if (!pgd_present(*pgd))
-			return false;
+		if (!pgd_present(*pgd)) {
+			step_forward(pvmw, PGDIR_SIZE);
+			continue;
+		}
 		p4d = p4d_offset(pgd, pvmw->address);
-		if (!p4d_present(*p4d))
-			return false;
+		if (!p4d_present(*p4d)) {
+			step_forward(pvmw, P4D_SIZE);
+			continue;
+		}
 		pud = pud_offset(p4d, pvmw->address);
-		if (!pud_present(*pud))
-			return false;
+		if (!pud_present(*pud)) {
+			step_forward(pvmw, PUD_SIZE);
+			continue;
+		}
 
 		pvmw->pmd = pmd_offset(pud, pvmw->address);
 		/*
@@ -240,7 +253,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 				spin_unlock(ptl);
 			}
-			return false;
+			step_forward(pvmw, PMD_SIZE);
+			continue;
 		}
 		if (!map_pte(pvmw))
 			goto next_pte;
@@ -270,7 +284,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			spin_lock(pvmw->ptl);
 		}
 		goto this_pte;
-	}
+	} while (pvmw->address < end);
+
+	return false;
 }
 
 /**
-- 
2.26.2

