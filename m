Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4063A2492
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhFJGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhFJGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:38:35 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:36:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g12so14132728qvx.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rZYXw6BRbvhvPhfR4jmUYFMFeMI725FP/8d3gS3xgfI=;
        b=kGmVYq1KCmC0sxjG2bvNJSAIEma0Txe8awTrb1MSDSPgZXAAmX8mMA0PtfBAImtoHM
         qSauEy6+Am03n80BYZHU9UEOnC2BoINeerjMvYrYgNX2nJmjsXTUU4yOttfanzIg+Z10
         izk8JK2zBz9zFSIg9mOdz5EjjvZqKvGsMJ2MYUoyP9qIW+de6rkSxrrXHnHWJpVZ227k
         ZQI3LJfwaow8uofHvJ1hY/m61JlpqgX2ZoIuxharrtNEirkWgwqNsyj0XBAo7zg440KQ
         9WVwWWwLzPdV8d5xIKtSgzFL13Gb62Cqh6fMFffXHRj3u48MRMr2E6Qh0/lUPxEltrlo
         EjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rZYXw6BRbvhvPhfR4jmUYFMFeMI725FP/8d3gS3xgfI=;
        b=bcb55ipT083c3F5+3g/VzsUSL+dOaSBkAGLsOLVKdEYqN61HZHRKSeHkEUwK/YSq60
         pDFNx4VbXzoZbubDfnzroaF33FEDX4+jR2RGdtSiA2GcqAoeEnnyQvo+4t72sG8jzdHW
         4QIixPi3KFQu5OoUXAolFINmdDwwwzzFZtSIm2gTnOeWlbL0GMyGRyeEweWT0sbxCt1L
         jaaPqp0HhFjypvP5A+yMRwDuZhHStSznLWsovssmDu7mFcap5cgGkZE+dJi7k0U1zQVK
         t0ujOZZTY2p/FcAksWdFrigsmgKlHQXQ+QgMc5uCmOGsSUweTFrhZTIQ5g3agqG90OuS
         SJ7A==
X-Gm-Message-State: AOAM532jiJTDUn4qboNAQKnHSu9+1q/zSGCHii5hj5YxSi4sZRNAxdju
        OzffHLM1hE99mcJzNgCznFX3aQ==
X-Google-Smtp-Source: ABdhPJyLamliZT4RHXjzNV5dKT4qjdHxdf/Mhbgo2rrm2QWLrwhPqsgsN3rbxP0uPfGa3iMSDtfciA==
X-Received: by 2002:a05:6214:162a:: with SMTP id e10mr3723237qvw.49.1623306998481;
        Wed, 09 Jun 2021 23:36:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q2sm1635598qkc.77.2021.06.09.23.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:36:38 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:36:36 -0700 (PDT)
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
Subject: [PATCH 02/11] mm: page_vma_mapped_walk(): settle PageHuge on entry
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <e31a483c-6d73-a6bb-26c5-43c3b880a2@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: get the hugetlbfs PageHuge case
out of the way at the start, so no need to worry about it later.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a6dbf714ca15..7c0504641fb8 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -153,10 +153,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
 
-	if (pvmw->pte)
-		goto next_pte;
-
 	if (unlikely(PageHuge(page))) {
+		/* The only possible mapping was handled on last iteration */
+		if (pvmw->pte)
+			return not_found(pvmw);
+
 		/* when pud is not present, pte will be NULL */
 		pvmw->pte = huge_pte_offset(mm, pvmw->address, page_size(page));
 		if (!pvmw->pte)
@@ -168,6 +169,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return not_found(pvmw);
 		return true;
 	}
+
+	if (pvmw->pte)
+		goto next_pte;
 restart:
 	pgd = pgd_offset(mm, pvmw->address);
 	if (!pgd_present(*pgd))
@@ -233,7 +237,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			return true;
 next_pte:
 		/* Seek to next pte only makes sense for THP */
-		if (!PageTransHuge(page) || PageHuge(page))
+		if (!PageTransHuge(page))
 			return not_found(pvmw);
 		end = vma_address_end(page, pvmw->vma);
 		do {
-- 
2.26.2

