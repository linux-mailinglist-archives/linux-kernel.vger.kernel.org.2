Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94F34F253
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhC3Ujh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhC3UjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:39:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE97C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:39:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso57788pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oULrbP4FjkNs256uwHNb2TcGOaX/Icewt8+s6vnPbs0=;
        b=VmLIRhG9Yo8Bz7DBKSnLIY7XdqRlJlnUEhdK5Tl7ArdufNhr8MevNPAqItT/BSeg5k
         9TtEBrFSloigP+swEWB9/e6K8VKbZMCksz2Hg/DkYr1SDuRH9gCHjGYuHeFyiGmjf2/W
         i0IsbASLP69oP6W8E6kWbqcz8neHS8FF04rNSXsClvlOqnwZMIy63NKxExdwp38TIeGE
         oHyQ+85R0anm0uEsMyo0GgDMK+ljITtvnwjeZO/ObxDXhjU6lJJC280l6oL0vgoJIBM2
         pslwzEsWH+WBFGFEvt3/EMrTzeZJZheYEAdPuV6O6YA4Ynr9HjKNJlzPvzDLIkctoNpA
         MBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oULrbP4FjkNs256uwHNb2TcGOaX/Icewt8+s6vnPbs0=;
        b=GOw+BA/8J3KBDX0lzPOf5mPZzM0Ib/ky0EriVYxppEkm6PH7cDanoBkSiH6UYv93zH
         +W4Sd5ESOrvWPtfejITgzAv8CayLwiqC1T7rDf50kzA0nEk5UGMfDFPVmnqQpdHA3LkB
         a7abI3Wf59NoS3ojnnjSBAbKZpQofU6OSye1u1ib1q8SRdpEoVvupQ5HYj5B8U2NjD4f
         Xg72Qn+fzdTzXGt2dm4KNpR/q0yIQNrTluZYV5A+wjqzQDaAt9hXwnekLNLczOBxc5GF
         QuBFD3GlAvSghcIlhQH8MiF9t03Q/kXP9VyhP4s8InPbr6YL7d3gOOuAaTWZMkxmIP5r
         /5WA==
X-Gm-Message-State: AOAM532ax4J+/Dud7DSeXjfQcRnWkJOSfTGyzcszzVPjSAEIPPyJjCn8
        ER6dPdmFmTN642ScmgpjBE8BWcr7gnE=
X-Google-Smtp-Source: ABdhPJxDyrO5CqmvnF5c4G+4akGsOBnpUlKQ4rBDZKu5yugGoY03lh9Ri2hRr51gq3S0AHAnjsGhqg==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr132796pjb.188.1617136743504;
        Tue, 30 Mar 2021 13:39:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c26sm10442321pfo.97.2021.03.30.13.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:39:02 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     jhubbard@nvidia.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: gup: remove FOLL_SPLIT
Date:   Tue, 30 Mar 2021 13:38:59 -0700
Message-Id: <20210330203900.9222-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
and commit ba925fa35057 ("s390/gmap: improve THP splitting") FOLL_SPLIT
has not been used anymore.  Remove the dead code.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v2: Remove the reference in documentation.

 Documentation/vm/transhuge.rst |  5 -----
 include/linux/mm.h             |  1 -
 mm/gup.c                       | 28 ++--------------------------
 3 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/Documentation/vm/transhuge.rst b/Documentation/vm/transhuge.rst
index 0ed23e59abe5..216db1d67d04 100644
--- a/Documentation/vm/transhuge.rst
+++ b/Documentation/vm/transhuge.rst
@@ -53,11 +53,6 @@ prevent the page from being split by anyone.
    of handling GUP on hugetlbfs will also work fine on transparent
    hugepage backed mappings.
 
-In case you can't handle compound pages if they're returned by
-follow_page, the FOLL_SPLIT bit can be specified as a parameter to
-follow_page, so that it will split the hugepages before returning
-them.
-
 Graceful fallback
 =================
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..3568836841f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2780,7 +2780,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
 				 * and return without waiting upon it */
 #define FOLL_POPULATE	0x40	/* fault in page */
-#define FOLL_SPLIT	0x80	/* don't return transhuge pages, split them */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
 #define FOLL_NUMA	0x200	/* force NUMA hinting page fault */
 #define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..f3d45a8f18ae 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -435,18 +435,6 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		}
 	}
 
-	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
-		get_page(page);
-		pte_unmap_unlock(ptep, ptl);
-		lock_page(page);
-		ret = split_huge_page(page);
-		unlock_page(page);
-		put_page(page);
-		if (ret)
-			return ERR_PTR(ret);
-		goto retry;
-	}
-
 	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
 	if (unlikely(!try_grab_page(page, flags))) {
 		page = ERR_PTR(-ENOMEM);
@@ -591,7 +579,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
-	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
+	if (flags & FOLL_SPLIT_PMD) {
 		int ret;
 		page = pmd_page(*pmd);
 		if (is_huge_zero_page(page)) {
@@ -600,19 +588,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			split_huge_pmd(vma, pmd, address);
 			if (pmd_trans_unstable(pmd))
 				ret = -EBUSY;
-		} else if (flags & FOLL_SPLIT) {
-			if (unlikely(!try_get_page(page))) {
-				spin_unlock(ptl);
-				return ERR_PTR(-ENOMEM);
-			}
-			spin_unlock(ptl);
-			lock_page(page);
-			ret = split_huge_page(page);
-			unlock_page(page);
-			put_page(page);
-			if (pmd_none(*pmd))
-				return no_page_table(vma, flags);
-		} else {  /* flags & FOLL_SPLIT_PMD */
+		} else {
 			spin_unlock(ptl);
 			split_huge_pmd(vma, pmd, address);
 			ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
-- 
2.26.2

