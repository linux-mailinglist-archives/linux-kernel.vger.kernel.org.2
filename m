Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020C8309DCD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 17:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhAaQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhAaQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 11:04:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BB0C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 08:04:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so16095939edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ill5FtHsvnGnhyZq4PTZ+wfZWDbj85ydmjcR5hoQtSU=;
        b=WA9qeWNS7cwGg8EThTQKocqoSAMpMXmdWEN96odCb1lDWcM2Sc6v0Qb7sDlmvA+l+I
         A8f+UMiuSXRUXIbHorjezUUJhKowq2uMgSlOLaQKlQ2TE2CKW/8nPCtEsN+ULwFm0bCg
         9/wX7BwKDdipxk5O1KYWXekm+8qe/E4QqrApq/d05iBQtDtZIXya1NS9k8a0s5lWncyh
         g6ruf7EBD+cG/5qucNNMJ6+m+zjl1MiGsDM8tC4ZUV0lVOP0V6NdY9Qaskw+B2dxa5eF
         WGMkCC6G04Cz0bCzZ3ggOUmnb142HmddZFEz3cJyHpOYgpANZbbHESkueT3GcqeRKuB9
         a7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ill5FtHsvnGnhyZq4PTZ+wfZWDbj85ydmjcR5hoQtSU=;
        b=XN86ffoYliDgWIOmwmH0Jyvm7nIj+7dvmqP6BkQy9K98sjcbkvoApRYPgN4sq1A698
         TKSUQ24rjJFfamDKhOM9Vz2Z/mfFuwlNNiKKzhPmg9c/DRlknffY1/WiXt6lNHZxhY4M
         EV0dMoul17PUBteNyKvc6AV2ua/J8NDVK9KLx1aTe3T3LWssFptG3q2StvbpczMPepDW
         3MxblLjrw8bTUwL60MUZCChwnPIdq1a+rGgOnAfZB9hPqa/VneJ8VFNffSwb2WRaydG3
         Y5+FY6Mx37aHlynbwxT+PXsBfBhTqjo5uEg3VqbzBDq7ZCPNwlaYvrn/9RWf00vlXpDL
         e9FQ==
X-Gm-Message-State: AOAM533VizPFrmY7SFqsJlkAzDmBKjS0x0XbPjcw+UH4Lw7aCZbqTdhw
        GrGZokUCaLsFwUvPDn2HcMK3Zr+d22M1sfYnEt5f6w==
X-Google-Smtp-Source: ABdhPJyCGWQ/3ra4ZR4qn/M+OGAua47G1o3uToLGNFPGWhEhJk7alqSH8V206c7XvCeXq7s9hKIxxI4DTjqV9Fn0UKc=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr14874940edv.116.1612109048337;
 Sun, 31 Jan 2021 08:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20210125194751.1275316-8-pasha.tatashin@soleen.com> <20210131130903.4875-1-lecopzer@gmail.com>
In-Reply-To: <20210131130903.4875-1-lecopzer@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sun, 31 Jan 2021 11:03:32 -0500
Message-ID: <CA+CK2bC_LKeffiYq8eraM-rLBFPfUS1034eD6FKQo5eR7s28Ew@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] mm: honor PF_MEMALLOC_PIN for all movable pages
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        James Morris <jmorris@namei.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 8:09 AM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
>
> Hi,
>
> [...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c93e801a45e9..3f17c73ad582 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3807,16 +3807,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
> >       return alloc_flags;
> >  }
> >
> > -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> > -                                     unsigned int alloc_flags)
> > +/* Must be called after current_gfp_context() which can change gfp_mask */
> > +static inline unsigned int gpf_to_alloc_flags(gfp_t gfp_mask,
> > +                                           unsigned int alloc_flags)
> >  {
> >  #ifdef CONFIG_CMA
> > -     unsigned int pflags = current->flags;
> > -
> > -     if (!(pflags & PF_MEMALLOC_PIN) &&
> > -         gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> > +     if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> >               alloc_flags |= ALLOC_CMA;
> > -
> >  #endif
> >       return alloc_flags;
> >  }
> > @@ -4472,7 +4469,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
> >       } else if (unlikely(rt_task(current)) && !in_interrupt())
> >               alloc_flags |= ALLOC_HARDER;
> >
> > -     alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
> > +     alloc_flags = gpf_to_alloc_flags(gfp_mask, alloc_flags);
> >
> >       return alloc_flags;
> >  }
> > @@ -4774,7 +4771,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >
> >       reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
> >       if (reserve_flags)
> > -             alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
> > +             alloc_flags = gpf_to_alloc_flags(gfp_mask, reserve_flags);
> >
> >       /*
> >        * Reset the nodemask and zonelist iterators if memory policies can be
> > @@ -4943,7 +4940,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
> >       if (should_fail_alloc_page(gfp_mask, order))
> >               return false;
> >
> > -     *alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
> > +     *alloc_flags = gpf_to_alloc_flags(gfp_mask, *alloc_flags);
>
> I have a question, what is the abbreviation of "gpf" in the function
> name gpf_to_alloc_flags()?
>
> It seems that this function still use gfp_mask, is this supposed
> to be gfp (Get Free Page)?

Thank you for noticing this, it was accidental, I will rename the
function gpf_to_alloc_flags() -> gfp_to_alloc_flags()

>
> Thanks,
> Lecopzer
>
