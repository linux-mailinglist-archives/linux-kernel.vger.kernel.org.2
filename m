Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F91357ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhDHDgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:36:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17C3C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 20:36:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c4so904117qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AEhzM8H87TLEc6j+l2DwTwvWX989gq+ctRvsxTktPlE=;
        b=iPCemFQxN2pjdzvxvUmYLnZawwXoWupp+3MYQDwLQ+GJLmKuZBLXk9wBfiA4AAwXNn
         PpCxrfy4g/MwbHCrH7ew93AGMFZiL6YKawZsi1JMDM/23O76+MeFXUHXROtsdkyT4H6N
         Crq2rX9MozmWGrh7bDfPATgoYj06ydCshXJl/RclxvJTg3l9ilQ2rFHb2Hl3u63zsznb
         waDCq1Blxah09rXZJ/Tp8/PG/qsCVJ/wFBrDebpm6Spvq10ALsZt+zWcxRrlHrr0XOtZ
         p/Ztz2wwnsS+gVXK5834QewJnwu1XcepZxipK3UNd6AZOfpiIsz/8aZBfpw7rtz0jOgt
         jx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AEhzM8H87TLEc6j+l2DwTwvWX989gq+ctRvsxTktPlE=;
        b=JxUAwt7CNX8nmhVDWbjoHhg1W5fDD0BZzsAcgbHn46Ks20t2AKr8ch7JrbAbH5K/M7
         uXSHl+5zij++WHj5+0K+KqbukgtOOtH7JmU9H358UHxDF+Jmc/aP8RVCONVsddRnPF46
         ML3DTCTnAcZQ9S0Zt2Xv78Q5a7hhUnqPiFCxoX9ShhYhFhh8/CzdchAgRczj8PsQbmkO
         rbP/p3agmc+N0pwtOHZsFyWRIXhZvfBxQHySjF+VjssCML26MCq0sxJheeNRV9/H4z/B
         XpoaW45/g4TMgMDgE977QIuT6SZgVD/NOSGyusWgcjAfG8IGs6OAbw0Wt8AZwFs4z45z
         oxlQ==
X-Gm-Message-State: AOAM530zWIwYELD3GkWQEAsRgRsTIitVExloY7jOBveEsh2ftS/uKFfU
        7B7NhuLcII33n2uMgj98P40=
X-Google-Smtp-Source: ABdhPJz4RQ3njWBFRCh3MJa1CARIPDaCShvxTLkKLtJ9KSRcTM6tLEEDMFpdEZdxEFI+NsJOGLpEzg==
X-Received: by 2002:a37:6104:: with SMTP id v4mr6462246qkb.429.1617852962063;
        Wed, 07 Apr 2021 20:36:02 -0700 (PDT)
Received: from monty ([192.141.93.162])
        by smtp.gmail.com with ESMTPSA id z6sm68085qkc.73.2021.04.07.20.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 20:36:01 -0700 (PDT)
Date:   Thu, 8 Apr 2021 00:35:48 -0300
From:   Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmap.c: lines in __do_munmap repeat logic of inlined
 find_vma_intersection
Message-ID: <20210408033548.krdk4xneump6a7d3@monty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lines in __do_munmap used the same logic as find_vma_intersection
(which is inlined) instead of directly using that function.

Signed-off-by: Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
---
 mm/mmap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..1b29f8bf8344 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2823,15 +2823,10 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
-	vma = find_vma(mm, start);
+	vma = find_vma_intersecion(mm, start, end);
 	if (!vma)
 		return 0;
 	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
-
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >= end)
-		return 0;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-- 
2.31.1

