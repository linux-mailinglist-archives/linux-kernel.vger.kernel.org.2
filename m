Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB834D866
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhC2Tij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhC2Tib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:38:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:38:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id m7so10071006pgj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXavjCp5f5S1D/8sxQU3rBvbwYs1dXET9+zoeDr0T5g=;
        b=HWRCseaPveOFsAf0pEO2427aSZwjep2nSfkPLTbwrLXjYC2a8S4BMrUYyZf8fohx+/
         RZ/wCUFs7b83gaGcJ9l+hbJVt0n/chZ1hRERGjFi7oDO8CjHkVgJIh6SnMpUj5mf8dRO
         0SXYielq/7TH77F0dYcg01PV+Hxk0K+CIu4gYOeEXc8ADRAgQVeMNgGoYWremkn+tg9q
         a0qRThDdtD5WFiIVYAiXohizskcZC8pu92DuSbf6snPBmo6iNTFCs0bnKO+sTJ/mY4Al
         ABdY+rhvryMtjFWsipSd1DaMdXEbsvHtGo8i6mbfR+yOtJfagHGuyVaD7uL2LJ9DTvOt
         vktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXavjCp5f5S1D/8sxQU3rBvbwYs1dXET9+zoeDr0T5g=;
        b=MGWmubIwR1wZhSvDqiRslftm+qmDrFlI1dK+M58ILv2ytWUXZCDsDYTmThgOifKVCh
         +UdHFIh9Fx/UTS+WY7WHTdfzS0ZOOfKCJ3Q4lSzjvBCsfm5CyunC7eaWpyqMfp6yBKuX
         PThHlp0YpO6FHNLFJhr2kPetQno13YdoYw5vJwx5QGvsYoh2zLFyUPD50v79lu3LwLka
         gNcCbbQ05PdxVJYWy5QGbFrCye7xJeTu0A4XgNC1f3eTnAA70o5LH1QJ7WVBJNo2jQ9o
         4UPFvh3lMM/nxXv/nYh3t/0X/xPamKlIwYhNLaycgI6xjVilA5gHev14AqWDgCRT91f5
         w0yQ==
X-Gm-Message-State: AOAM5313AIXZ5Rqj7JzPjGuurq0UMl3tGFVQU3EZuRWxyveMAEJflRUm
        Irml+qekggiTkU3EFxPjuyL/rt76IzM=
X-Google-Smtp-Source: ABdhPJz4uRJqp5XuS8BfxQJxe9UeJgdgf/c8QCW04sR2N1rf8gJ+iixITr3T+Epd2w9Wu4j/CjtZLg==
X-Received: by 2002:a63:d904:: with SMTP id r4mr9691006pgg.321.1617046710451;
        Mon, 29 Mar 2021 12:38:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id n38sm10155222pgb.2.2021.03.29.12.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 12:38:29 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: gup: remove FOLL_SPLIT
Date:   Mon, 29 Mar 2021 12:38:28 -0700
Message-Id: <20210329193828.179993-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
and commit ba925fa35057 ("s390/gmap: improve THP splitting") FOLL_SPLIT
has not been used anymore.  Remove the dead code.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/mm.h |  1 -
 mm/gup.c           | 28 ++--------------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

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

