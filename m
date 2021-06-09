Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F13A10E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhFIKLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:11:13 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44691 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbhFIKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:11:08 -0400
Received: by mail-lf1-f48.google.com with SMTP id r198so33797255lff.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ycBV7W+Z4gGupsDwiNMvurO0enCT2qnqxmC8+tIujTs=;
        b=ChMG4OAUVihcSMJETWizwykkGL+XM2iEOokvplS6iAWVZcqF70BtDu8kJeHcT0hZfo
         vbKH87Ek3+fn2RofGbTw91LmYM3u2zfqlD8Z9IhjO6z3IMKoByQmfudnZOqCi+drmUho
         l0g9lLnOLOZDmIN4rky27x0zI0NUk9n3PlPZWpxBfr7LrG7mmZDkz+mKksrpK37VJdNt
         vePXcdBNeAvgHmiEA3q7ijL/rqb7VYxytRbZXpAbP7A1K2yp5ax8hISa9EG2dkE3qEOY
         BfL1MyCSquTTL9B7F3acy6Fw/WY1vPoFJyLdfNIh9axIB4Zior60W/4/8djkmjl/nZ4T
         jwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ycBV7W+Z4gGupsDwiNMvurO0enCT2qnqxmC8+tIujTs=;
        b=t3QlApg1EKvArWPN89SS8TdQ0swDpOciJ7Rrs8C/7eWow4nAP5r4Y0XUXoKcMAqMFZ
         xC8xTXuEWC022WuhiLkKr+7YbiLOsfvuhKHi1pdjMEvHOH5AbLHidYd44ZBmlSJ4LbMF
         LQnevdtU3/tj53Hm7Ds6yUGstTLk7oqTQTzCclI6MERpzxzxYKxJMlPyMuFWlNbNwb89
         C0cDcESGx5TBwWq53fRPWKILRmncMozRLc8dv5z9UjYPpojmTgb/IU0qq6LFeE9A66iW
         krTIyATOPqegahKffkmUjnS5AXwfFhP2+IuFxouWRX0sQhQf6+mhmBJIDQIFstRkpk8e
         ZW9Q==
X-Gm-Message-State: AOAM530trncN00DP59woJXi2DEU2fHi4ddif68njalZhoqiGTipZV4LS
        upxG1gZSdT05eZWFGX9VNqd8/g==
X-Google-Smtp-Source: ABdhPJzuGkUvJj/AJoTCCtnNh2nfQU8KxExaJycKNJ8fsWv+zFzEpVWfSZ1IbjKpMTAAGyvlAy8tww==
X-Received: by 2002:a05:6512:54b:: with SMTP id h11mr18858506lfl.236.1623233281541;
        Wed, 09 Jun 2021 03:08:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y17sm304690lfy.14.2021.06.09.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:08:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 43E0110265B; Wed,  9 Jun 2021 13:08:16 +0300 (+03)
Date:   Wed, 9 Jun 2021 13:08:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Xu <xuyu@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Message-ID: <20210609100816.tmgcy2vq4cmw7o7e@box.shutemov.name>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
 <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
 <57e151a8-03b2-3458-0178-21edb4ce97d2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e151a8-03b2-3458-0178-21edb4ce97d2@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:22:28PM +0800, Yu Xu wrote:
> On 6/8/21 8:00 PM, Kirill A. Shutemov wrote:
> > On Tue, Jun 08, 2021 at 05:22:39PM +0800, Xu Yu wrote:
> > > We notice that hung task happens in a conner but practical scenario when
> > > CONFIG_PREEMPT_NONE is enabled, as follows.
> > > 
> > > Process 0                       Process 1                     Process 2..Inf
> > > split_huge_page_to_list
> > >      unmap_page
> > >          split_huge_pmd_address
> > >                                  __migration_entry_wait(head)
> > >                                                                __migration_entry_wait(tail)
> > >      remap_page (roll back)
> > >          remove_migration_ptes
> > >              rmap_walk_anon
> > >                  cond_resched
> > > 
> > > Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> > > copy_to_user in fstat, which will immediately fault again without
> > > rescheduling, and thus occupy the cpu fully.
> > > 
> > > When there are too many processes performing __migration_entry_wait on
> > > tail page, remap_page will never be done after cond_resched.
> > > 
> > > This makes __migration_entry_wait operate on the compound head page,
> > > thus waits for remap_page to complete, whether the THP is split
> > > successfully or roll back.
> > > 
> > > Note that put_and_wait_on_page_locked helps to drop the page reference
> > > acquired with get_page_unless_zero, as soon as the page is on the wait
> > > queue, before actually waiting. So splitting the THP is only prevented
> > > for a brief interval.
> > > 
> > > Fixes: ba98828088ad ("thp: add option to setup migration entries during PMD split")
> > > Suggested-by: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> > > Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> > 
> > Looks good to me:
> > 
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > But there's one quirk: if split succeed we effectively wait on wrong
> > page to be unlocked. And it may take indefinite time if split_huge_page()
> > was called on the head page.
> 
> Inspired by you, I look into the codes, and have a new question (nothing
> to do with this patch).
> 
> If we split_huge_page_to_list on *tail* page (in fact, I haven't seen
> that used yet),

See ksm code for instance.

> mm/huge_memory.c:2666 checks "VM_BUG_ON_PAGE(!PageLocked(head), head);"
> in split_huge_page_to_list(), while
> 
> mm/huge_memory.c:2497 does "unlock_page(subpage)", where subpage can
> be head in this scenario, in __split_huge_page().
> 
> My confusion is
> 1) how the pin on the @subpage is got outside split_huge_page_to_list()?
>    can we ever get tail page?

This loop:

	for (i = 0; i < nr; i++) {
		struct page *subpage = head + i;
		if (subpage == page)
			continue;
		unlock_page(subpage);

		/*
		 * Subpages may be freed if there wasn't any mapping
		 * like if add_to_swap() is running on a lru page that
		 * had its mapping zapped. And freeing these pages
		 * requires taking the lru_lock so we do the put_page
		 * of the tail pages after the split is complete.
		 */
		put_page(subpage);
	}

We skip unlocking and unpinning the page split_huge_page() got called for.

> 
> 2) head page is locked outside split_huge_page_to_list(), but unlocked
>    in __split_huge_page()?

If called on tail page, yes.

-- 
 Kirill A. Shutemov
