Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD830CF4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhBBWqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbhBBWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:46:23 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C5C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:45:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id y9so10927579ejp.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svF6KUKMi2Xie2sUq/73/lGuw8cSY721FQcOtkyB5q8=;
        b=hSloLE1DQGm4eqMoIMnssMxkqqYqRyjLPn9kxkQAlOgqNcCcVbWQcsdfCLjNC8MNIm
         qsl/cNJbyVqPv9sGieAv9ZSwqomPwNKU92wWIezj7JsJSycidp95kJ4UNlUuwLLUC72S
         ZQWbn7LjQekQ8vOcU/dsm4ZT1MKRLu8O5Ek+WMLK3RovfEA/oBjkQv9Z1DFofR5O1xnq
         ffHS3jp9/hP+KBMBWo4M/gHfJLjasj6EXf3NC4LFc76yQllV5RaONRy0Ez51oPafk0Yx
         TF9kqg6+bhW5VdroY9IBd90b/xumBcbMcKfxXGEQM/goRWCIB9n11N+aVrFboPuG1PMR
         nspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svF6KUKMi2Xie2sUq/73/lGuw8cSY721FQcOtkyB5q8=;
        b=iysiSCz8q+MhRg9a0zJJ9vXcCPXc8w2FMiW3LJQe1NjqbS/fIxZnEUFIsdzR5rgpC1
         efLAEXTWKhAeAonunj/UCuUp8iUuTxJnxbsji2zKhw9ygGqt1tS/7lHsL+zWsIupG/29
         WPdv4RIb36zM/x1g6YjXamWKZ2TTnLkRtzshdee08pq4EAnL4x+hian/DshurI4YGoEc
         tEqiKVcYhkmfL/EP3QOl+Pt441LfLr89C9xmdvG69hECrIZTa5m7oDB5RzaDleLrYLN7
         KimdC78/lJvYS322GpqPgExKxD3QNFRneC1O9/PHnGv+dndG/bRZXohdP8sPtn9iECKT
         sXNg==
X-Gm-Message-State: AOAM533A1t9b+slsJKUNScDX6XAKhdkAFRmLDS9gDXpWzGgwU39Z0QGs
        c0hw2xkMGWCTiX/njpkCQK6e4wOOWDWwN7y75K8=
X-Google-Smtp-Source: ABdhPJx4C6LoBDfe8fMz5l5f1s3X1zuFf9L62m6eaNay32CowCnPbqdxwfItjxYyOhmIXBv1dJkCCVBwcz0hYOiOCHE=
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr197001ejb.499.1612305941340;
 Tue, 02 Feb 2021 14:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003427.73DFDD34@viggo.jf.intel.com>
 <20210202115516.GC12139@linux>
In-Reply-To: <20210202115516.GC12139@linux>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 2 Feb 2021 14:45:29 -0800
Message-ID: <CAHbLzkrSYsoVV1eHHO9kWv2xe96qmAt6dmC_FsBrydsZxGLvew@mail.gmail.com>
Subject: Re: [RFC][PATCH 08/13] mm/migrate: demote pages during reclaim
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 3:55 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Mon, Jan 25, 2021 at 04:34:27PM -0800, Dave Hansen wrote:
> >
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > This is mostly derived from a patch from Yang Shi:
> >
> >       https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/
> >
> > Add code to the reclaim path (shrink_page_list()) to "demote" data
> > to another NUMA node instead of discarding the data.  This always
> > avoids the cost of I/O needed to read the page back in and sometimes
> > avoids the writeout cost when the pagee is dirty.
> >
> > A second pass through shrink_page_list() will be made if any demotions
> > fail.  This essentally falls back to normal reclaim behavior in the
> > case that demotions fail.  Previous versions of this patch may have
> > simply failed to reclaim pages which were eligible for demotion but
> > were unable to be demoted in practice.
> >
> > Note: This just adds the start of infratructure for migration. It is
> > actually disabled next to the FIXME in migrate_demote_page_ok().
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Yang Shi <yang.shi@linux.alibaba.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: osalvador <osalvador@suse.de>
> >
> > --
> >
> > changes from 202010:
> >  * add MR_NUMA_MISPLACED to trace MIGRATE_REASON define
> >  * make migrate_demote_page_ok() static, remove 'sc' arg until
> >    later patch
> >  * remove unnecessary alloc_demote_page() hugetlb warning
> >  * Simplify alloc_demote_page() gfp mask.  Depend on
> >    __GFP_NORETRY to make it lightweight instead of fancier
> >    stuff like leaving out __GFP_IO/FS.
> >  * Allocate migration page with alloc_migration_target()
> >    instead of allocating directly.
> > changes from 20200730:
> >  * Add another pass through shrink_page_list() when demotion
> >    fails.
> > ---
>
> [...]
>
> > +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> > +{
> > +        struct migration_target_control mtc = {
> > +             /*
> > +              * Fail quickly and quietly.  Page will likely
> > +              * just be discarded instead of migrated.
> > +              */
> > +             .gfp_mask = GFP_HIGHUSER | __GFP_NORETRY | __GFP_NOWARN,
> > +             .nid = node
> > +     };
> > +
> > +        return alloc_migration_target(page, (unsigned long)&mtc);
> > +}
>
> Migration for THP pages will set direct reclaim. I guess that is fine right?
> AFAIK, direct reclaim will only be tried once with GFP_NORETRY.
>
> > +
> > +/*
> > + * Take pages on @demote_list and attempt to demote them to
> > + * another node.  Pages which are not demoted are left on
> > + * @demote_pages.
> > + */
> > +static unsigned int demote_page_list(struct list_head *demote_pages,
> > +                                  struct pglist_data *pgdat,
> > +                                  struct scan_control *sc)
> > +{
> > +     int target_nid = next_demotion_node(pgdat->node_id);
> > +     unsigned int nr_succeeded = 0;
> > +     int err;
> > +
> > +     if (list_empty(demote_pages))
> > +             return 0;
> > +
> > +     /* Demotion ignores all cpuset and mempolicy settings */
> > +     err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> > +                         target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> > +                         &nr_succeeded);
> > +
> > +     return nr_succeeded;
> > +}
> > +
> >  /*
> >   * shrink_page_list() returns the number of reclaimed pages
> >   */
> > @@ -1078,12 +1135,15 @@ static unsigned int shrink_page_list(str
> >  {
> >       LIST_HEAD(ret_pages);
> >       LIST_HEAD(free_pages);
> > +     LIST_HEAD(demote_pages);
> >       unsigned int nr_reclaimed = 0;
> >       unsigned int pgactivate = 0;
> > +     bool do_demote_pass = true;
> >
> >       memset(stat, 0, sizeof(*stat));
> >       cond_resched();
> >
> > +retry:
> >       while (!list_empty(page_list)) {
> >               struct address_space *mapping;
> >               struct page *page;
> > @@ -1233,6 +1293,16 @@ static unsigned int shrink_page_list(str
> >               }
> >
> >               /*
> > +              * Before reclaiming the page, try to relocate
> > +              * its contents to another node.
> > +              */
> > +             if (do_demote_pass && migrate_demote_page_ok(page)) {
> > +                     list_add(&page->lru, &demote_pages);
> > +                     unlock_page(page);
> > +                     continue;
> > +             }
>
> Should we keep it simple for now and only try to demote those pages that are
> free of cpusets and memory policies?
> Actually, demoting those pages to a CPU or a NUMA node that does not fall into
> their set, would violate those constraints right?

Yes, this has been discussed since the very beginning. There is not an
easy way to figure out the memory placement policy (cpuset and
mempolicy) from "page". I think this also prevents "demote those pages
that are free of cpusets and memory policies".

The conclusion was the violation should be fine for now. And the
demotion feature is opt'ed in by a new node reclaim mode.

> So I think we should leave those pages alone for now.
>
> > +
> > +             /*
> >                * Anonymous process memory has backing store?
> >                * Try to allocate it some swap space here.
> >                * Lazyfree page could be freed directly
> > @@ -1479,6 +1549,17 @@ keep:
> >               list_add(&page->lru, &ret_pages);
> >               VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
> >       }
> > +     /* 'page_list' is always empty here */
> > +
> > +     /* Migrate pages selected for demotion */
> > +     nr_reclaimed += demote_page_list(&demote_pages, pgdat, sc);
> > +     /* Pages that could not be demoted are still in @demote_pages */
> > +     if (!list_empty(&demote_pages)) {
> > +             /* Pages which failed to demoted go back on on @page_list for retry: */
> > +             list_splice_init(&demote_pages, page_list);
> > +             do_demote_pass = false;
> > +             goto retry;
> > +     }
> >
> >       pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
> >
> > _
> >
>
> --
> Oscar Salvador
> SUSE L3
>
