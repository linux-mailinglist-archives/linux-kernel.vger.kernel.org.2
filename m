Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD64358B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhDHR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhDHR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:27:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:27:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v6so3131358ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12TgNirSEgx1xK4iZu+oef0GZkuYbX4qCm+wQ6HbK54=;
        b=RHq1X5DervhotWlcoeZ+ZH0NkaVwhuBsZBjLjIk3P4d/VW+2KYPjT2TRuGnNVLqPIv
         w8J1sWpsS+vNl4kP2NeCRwwcP0CkpfCvRZUb/DrE1qSOS4/CjxPzIEEblvdKOjd2tJE6
         dkCOwIMaCuoEhfrVy+QZ5CiRlLB9oY1ZRuu69Ax7OQwCct7VLVFfAttmZQwOPLB2INbP
         iiqoZfjwRE4GiM+ptZOoSbGTMP7cbSXOS/yOpqwNiBDIcG3aOm+JUhJ18g0RHi6kg/5Q
         0A2/Lpj7bIpeYZhvomPGZ7epL3F9dw9GOqrMdREjaUcSFIsfDDfAAw2BUtk606/HGkMT
         cq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12TgNirSEgx1xK4iZu+oef0GZkuYbX4qCm+wQ6HbK54=;
        b=j/VbZnbqtwK70MakT/8eUrGO4H4S95UPEs0uii95XxoYRskeYNHSJsdmp3Iy05N1bG
         lBoWWIg5sWrqndm94hLsXCRnWFebBqngEowhajSypuSoMF15KpmVaeBdT58/kD0LSpCT
         ViQZfZknQvPrCN2tCC0eclDhaMFLBJ+aodkmIOJsO25ZFqnQ6MVqRSoKmurSQz7je1BH
         XmExoHoWPLgAwPKq0bv0WFbEPO2gXxz7cYxP6SPgI7/UGrztZuFiRTD6KZwnxU/+C3mM
         s4J0pXpTs1Qpai+Xv8+rUvZ9JfYR7gyV6VxfjrZjjUm1uNSfBkV91ElWkEAjsgH6ol1h
         sThQ==
X-Gm-Message-State: AOAM533J8rDHj2UYB53b+e63hIELFPn+OrM+rG85xF1lrJmeNGbURO07
        rRsVMn/G92cDYjklZ4yOdkH3OiVvFZ7TGO1Rvpo=
X-Google-Smtp-Source: ABdhPJybMRj5YdSyDJty/Q4euXx9aSpxateuLXjVnfO7x/PLTche1UstCaIQ+5W7KpvIGxamLG3he5X8ZXJRZUbjrlo=
X-Received: by 2002:a17:906:6dd9:: with SMTP id j25mr11666611ejt.507.1617902826704;
 Thu, 08 Apr 2021 10:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain>
In-Reply-To: <YG7XjTG9tiK29y1j@localhost.localdomain>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 8 Apr 2021 10:26:54 -0700
Message-ID: <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, weixugc@google.com,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 3:14 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Apr 01, 2021 at 11:32:23AM -0700, Dave Hansen wrote:
> >
> > From: Yang Shi <yang.shi@linux.alibaba.com>
> >
> > The migrate_pages() returns the number of pages that were not migrated,
> > or an error code.  When returning an error code, there is no way to know
> > how many pages were migrated or not migrated.
> >
> > In the following patch, migrate_pages() is used to demote pages to PMEM
> > node, we need account how many pages are reclaimed (demoted) since page
> > reclaim behavior depends on this.  Add *nr_succeeded parameter to make
> > migrate_pages() return how many pages are demoted successfully for all
> > cases.
> >
> > Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Yang Shi <shy828301@gmail.com>
> > Cc: Wei Xu <weixugc@google.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: osalvador <osalvador@suse.de>
> >
>
> ...
> >  int migrate_pages(struct list_head *from, new_page_t get_new_page,
> >               free_page_t put_new_page, unsigned long private,
> > -             enum migrate_mode mode, int reason)
> > +             enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
> >  {
> >       int retry = 1;
> >       int thp_retry = 1;
> >       int nr_failed = 0;
> > -     int nr_succeeded = 0;
> >       int nr_thp_succeeded = 0;
> >       int nr_thp_failed = 0;
> >       int nr_thp_split = 0;
> > @@ -1611,10 +1611,10 @@ retry:
> >                       case MIGRATEPAGE_SUCCESS:
> >                               if (is_thp) {
> >                                       nr_thp_succeeded++;
> > -                                     nr_succeeded += nr_subpages;
> > +                                     *nr_succeeded += nr_subpages;
> >                                       break;
> >                               }
> > -                             nr_succeeded++;
> > +                             (*nr_succeeded)++;
> >                               break;
> >                       default:
> >                               /*
> > @@ -1643,12 +1643,12 @@ out:
> >        */
> >       list_splice(&ret_pages, from);
> >
> > -     count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> > +     count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
> >       count_vm_events(PGMIGRATE_FAIL, nr_failed);
> >       count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> >       count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
> >       count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> > -     trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> > +     trace_mm_migrate_pages(*nr_succeeded, nr_failed, nr_thp_succeeded,
> >                              nr_thp_failed, nr_thp_split, mode, reason);
>
> It seems that reclaiming is the only user who cared about how many pages
> could we migrated, could not do the following instead:
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 695a594e5860..d4170b7ea2fe 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1503,7 +1503,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                 free_page_t put_new_page, unsigned long private,
> -               enum migrate_mode mode, int reason)
> +               enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>  {
>         int retry = 1;
>         int thp_retry = 1;
> @@ -1654,6 +1654,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>         if (!swapwrite)
>                 current->flags &= ~PF_SWAPWRITE;
>
> +       if (ret_succedded)
> +               *ret_succedded = nr_succedded;
> +
>         return rc;
>  }
>
>  And pass only a valid pointer from demote_page_list() and NULL from all
>  the others?
>  I was just wondered after all those "unsigned int nr_succedded" in all
>  other functions.
>  This would also solve the "be careful to initialize nr_succedded"
>  problem?

Thanks, Oscar. Yes, kind of. But we have to remember to initialize
"nr_succedded" pointer properly for every migrate_pages() callsite,
right? And it doesn't prevent from returning wrong value if
migrate_pages() is called multiple times by one caller although there
might be not such case (calls migrate_pages() multiple times and care
about nr_succeded) for now.

So IMHO I do prefer Wei's suggestion to have migrate_pages()
initialize nr_succeeded. This seems simpler.


>
>
> --
> Oscar Salvador
> SUSE L3
