Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175D39F5E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhFHMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:03:09 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:38531 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhFHMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:03:06 -0400
Received: by mail-lj1-f173.google.com with SMTP id s22so6215018ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uYU0wBlQGxD0TLzC1dztsvlGJDA1tbga5OhaOeNPfa8=;
        b=zbTsbmBNcYTv2dszMaSb1//4OEXSqqmXwpT2KhnVaKPW0N3YsFFxJEqwiZGoxW4tkY
         MHUJDrTPq8jmsRyipdRMm4bLN9oE8Kgm/+AB9yhqzlABNzRNEGXizx59Lu4cFLzvxgah
         Tgjw4GfnQHh87Lp0bMqWl5xZe5qQdJo3zjbwPOzPPkJ5+SPUxwhBKZSmrG1ldKDXOxXT
         ccutdvxZ2mnC6M6WWc1Yf0tNJQNpIe1pQ7RhKDlSdXYjdp5cJNoIpOhWIx/mzyl0wgNN
         ExC/3ZY3B4REllhqWJTTuvovmYdR1QVq45qwiVkFLiNqaUrEu/KYIaaE4YNbVqPriQaH
         nh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYU0wBlQGxD0TLzC1dztsvlGJDA1tbga5OhaOeNPfa8=;
        b=RxssEknB+hRBCbtQ7jVALc7mTcy0A4+Qkvck+7V7AucJ+9i5VjLYHyhoL0EPSCRl7Q
         OBLyfbVDSELvlnw3MhZiO8OQB62SmGFwYkudH+woEbgD2CoStmrBjJq34Pel+759rhUE
         qWrqGwt6QMa0Wa+0mMjRZ2V7jypFF6RN0x1X1WDqKYfjWg70nMtsliC/wpzLWNAaJ/Y3
         SxlyYZc9zUVCQV1QckwvSF9XJeCtVzqW8HNUMRKTAzFIhPz6lsh0b9Es9Jur+rJ2H5Sm
         R0zXlHtgg1L/Avfgn+8yODAjNe9I4BVItPBl9c/GDfx34SkDu7XT1R/jsLmTzoXKxoem
         woFA==
X-Gm-Message-State: AOAM532mSr20MpVUxRFyWcIq2A+8FVgFOAbIrj4EFSjmzthaXLTyJRBf
        b52eItHZIC7dwKkewB/NFW7g3A==
X-Google-Smtp-Source: ABdhPJwaeeFC8vZrtFP9XyW6k7l5rVCxcllnwZXrHnutDNQ/cO/h62uMPst3gxCGA1UQAtdc+TYJIg==
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr18412608ljp.66.1623153612807;
        Tue, 08 Jun 2021 05:00:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g20sm2229786lja.2.2021.06.08.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:00:12 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EC77E102815; Tue,  8 Jun 2021 15:00:26 +0300 (+03)
Date:   Tue, 8 Jun 2021 15:00:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Xu Yu <xuyu@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Message-ID: <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:22:39PM +0800, Xu Yu wrote:
> We notice that hung task happens in a conner but practical scenario when
> CONFIG_PREEMPT_NONE is enabled, as follows.
> 
> Process 0                       Process 1                     Process 2..Inf
> split_huge_page_to_list
>     unmap_page
>         split_huge_pmd_address
>                                 __migration_entry_wait(head)
>                                                               __migration_entry_wait(tail)
>     remap_page (roll back)
>         remove_migration_ptes
>             rmap_walk_anon
>                 cond_resched
> 
> Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> copy_to_user in fstat, which will immediately fault again without
> rescheduling, and thus occupy the cpu fully.
> 
> When there are too many processes performing __migration_entry_wait on
> tail page, remap_page will never be done after cond_resched.
> 
> This makes __migration_entry_wait operate on the compound head page,
> thus waits for remap_page to complete, whether the THP is split
> successfully or roll back.
> 
> Note that put_and_wait_on_page_locked helps to drop the page reference
> acquired with get_page_unless_zero, as soon as the page is on the wait
> queue, before actually waiting. So splitting the THP is only prevented
> for a brief interval.
> 
> Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>

Looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

But there's one quirk: if split succeed we effectively wait on wrong
page to be unlocked. And it may take indefinite time if split_huge_page()
was called on the head page.

Maybe we should consider waking up head waiter on head page, even if it is
still locked after split?

Something like this (untested):

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..f79a38e21e53 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2535,6 +2535,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 */
 		put_page(subpage);
 	}
+
+	if (page == head)
+		wake_up_page_bit(page, PG_locked);
 }

 int total_mapcount(struct page *page)
-- 
 Kirill A. Shutemov
