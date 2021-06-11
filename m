Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DB93A386B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFKASF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFKASE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:18:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C8AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:16:07 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x196so4050261oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=C6U1YLmSE4JLi5mlyZ8NZHiwVuj878z1/GmcLjmH1Z8=;
        b=JkMx5lhLC+EwsNDITFq8VQa/ynipjwnU6CCUFtm54jST9h8FIHQMvf4RqTNCkl7Mjn
         w2OGeD47iVlqADdMmiZfActWaNvLuKScXgjKv9y/9RrN2lDYiWl+AUExUy+JQbz+MdcK
         UC5NXPxhlJU2uzCNNmLsuZZF2FNbK/8zWKYPxtxTuelPNF9xy34ncwvyFUjWUczMYDuS
         eQU6fJsWpzQINClAIfiecu+YqxMF1JFrUJWYGwsh4W3Cea+Sn8PIyCnwI70sySYpCFw4
         15tVp+HkJk8HM3xl/a+sxDcBmIel6IRIfz2UkLrsX0C+cf9Y71SxWJi3HAF1d/RKp9En
         rJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=C6U1YLmSE4JLi5mlyZ8NZHiwVuj878z1/GmcLjmH1Z8=;
        b=FcmxzX8fYYUPfGakY5DsNajm5S+c/A2J4kF8nQoc+6KCUETRm2BEARM0n0Gygn3koV
         9XYzIuFXfVGtmcGq3iQCjwGtltxuihOpaKU/WvhNBfyOZk1Kyy7U+Bw5W7/yOoNi0L7d
         Bs0zJH9TU34v7ysPYZrnMoX+llK+S+zNMDWvtxfz4KZYPK+8Gs/iVDTaB6akjT4nhpnS
         X0h4jOa0jjPkK8We3G7OEhkrU0IOEaB7AGX5yLhbYSm3750Q4Hkm9d1vcZBW7ol+V82S
         b8JXP21APrrSFWEvodTFDieoENMNVEzBWUxfsFix6Ve/7gV/NJU2NqwPuGkKOWJE4aq0
         Svng==
X-Gm-Message-State: AOAM533mgDOrIF7U2yOQiOLJRJIEkF53m8Qf3QKRR72EGOXDDyek24nZ
        YCbfHQhMb8q6ed5/yS84t1G65g==
X-Google-Smtp-Source: ABdhPJzlOEgwY3eyULH7NLJD3/SXvH7bEJtsmyJY/pfBOZOO1u51AdLhYOQVX3qWWaCArvtZM62gUg==
X-Received: by 2002:aca:fd43:: with SMTP id b64mr681624oii.0.1623370566755;
        Thu, 10 Jun 2021 17:16:06 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z22sm851655ooj.6.2021.06.10.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:16:06 -0700 (PDT)
Date:   Thu, 10 Jun 2021 17:15:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Alistair Popple <apopple@nvidia.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and
 related
In-Reply-To: <2014832.e7zRqyNrDn@nvdebian>
Message-ID: <b27e866-a06c-d32-20aa-3b16f58549@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <20210610151505.d0124033e55bda07fa3d4408@linux-foundation.org> <2014832.e7zRqyNrDn@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021, Alistair Popple wrote:
> On Friday, 11 June 2021 8:15:05 AM AEST Andrew Morton wrote:
> > On Tue, 8 Jun 2021 20:57:34 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > 
> > > These are against 5.13-rc5: expect mmotm conflicts with a couple of
> > > Alistair Popple's "Add support for SVM atomics in Nouveau" series:
> > > mm-remove-special-swap-entry-functions.patch
> > > mm-rmap-split-try_to_munlock-from-try_to_unmap.patch
> > 
> > I came unstuck at "mm/rmap: split migration into its own function".

Sorry about that, I hadn't yet gotten to trying my latest with mmotm.
And I think my previous mmotm-adjust.tar must have been incomplete;
and even if it were complete, would no longer apply properly anyway.

> > 
> > --- mm/huge_memory.c~mm-rmap-split-migration-into-its-own-function
> > +++ mm/huge_memory.c
> > @@ -2345,16 +2345,21 @@ void vma_adjust_trans_huge(struct vm_are
> > 
> >  static void unmap_page(struct page *page)
> >  {
> > -       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> > -               TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > +       enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> >         bool unmap_success;
> > 
> >         VM_BUG_ON_PAGE(!PageHead(page), page);
> > 
> >         if (PageAnon(page))
> > -               ttu_flags |= TTU_SPLIT_FREEZE;
> > -
> > -       unmap_success = try_to_unmap(page, ttu_flags);
> > +               unmap_success = try_to_migrate(page, ttu_flags);
> > +       else
> > +               /*
> > +                * Don't install migration entries for file backed pages. This
> > +                * helps handle cases when i_size is in the middle of the page
> > +                * as there is no need to unmap pages beyond i_size manually.
> > +                */
> > +               unmap_success = try_to_unmap(page, ttu_flags |
> > +                                               TTU_IGNORE_MLOCK);
> >         VM_BUG_ON_PAGE(!unmap_success, page);
> >  }
> > 
> > 
> > Sigh.  I have a few todo's against Alastair's "Add support for SVM
> > atomics in Nouveau v9".  Including

Sigh shared!

> > 
> > https://lkml.kernel.org/r/20210525183710.fa2m2sbfixnhz7g5@revolver
> > https://lkml.kernel.org/r/20210604204934.sbspsmwdqdtmz73d@revolver
> > https://lkml.kernel.org/r/YK6mbf967dV0ljHn@t490s
> > https://lkml.kernel.org/r/2005328.bFqPmhE5MS@nvdebian
> > https://lkml.kernel.org/r/202105262107.LkxpsZsV-lkp@intel.com
> > https://lkml.kernel.org/r/YK6hYGEx+XzeZELV@t490s
> > 
> > So I think I'll drop that series and shall ask for it to be redone
> > against this lot, please.

Thank you, Andrew: that's certainly easiest for you and for me:
and I think the right thing to do for now.

> > 
> 
> I believe v10 of the series posted earlier this week should address those
> todo's. I will double check though and resend based on top of mmotm. Thanks.

Sorry to give you the bother, Alistair: it's worked out as a bad moment
to rewrite swapops.h and rmap.c, I'm afraid.

And the only help I've had time to give you was pointing Peter at your
series - many thanks to Peter, and to Shakeel.

Several times I've been on the point of asking you to keep the familiar
migration_entry_to_page(), along with your new pfn_swap_entry_to_page();
but each time I've looked, seen that it's hard to retain it sensibly at
the same time as overdue cleanup of the device_private_entry_to_page()s.

So I guess I'm resigned to losing it; but there are at least three
bugs currently under discussion or fixes in flight, which border on
migration_entry_to_page() - Jann Horn's smaps syzbot bug, Xu Yu's
__migration_entry_wait() fix, my __split_huge_pmd_locked() fix
(and page_vma_mapped_walk() cleanup).

And regarding huge_memory.c's unmap_page(): I did not recognize the
"helps handle cases when i_size" comment you added there.  What I
ended up with (and thought was in mmotm-adjust.tar but seems not):

	/*
	 * Anon pages need migration entries to preserve them, but file
	 * pages can simply be left unmapped, then faulted back on demand.
	 * If that is ever changed (perhaps for mlock), update remap_page().
	 */
	if (PageAnon(page))
		try_to_migrate(page, ttu_flags);
	else
		try_to_unmap(page, ttu_flags | TTU_IGNORE_MLOCK);

with
	/* If try_to_migrate() is used on file, remove this check */
in remap_page() to replace the
	/* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
comment my series puts there (since you delete TTU_SPLIT_FREEZE altogether).

Hugh
