Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2530DD4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhBCOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhBCOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:52:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84673C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:52:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b9so16618550ejy.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ba8vo7NYBPo9eSD9iOWqZ0kAa5nRbWhxZY4okQVnGnw=;
        b=kabU4DJVcmFBq7Y/Y5iY/7dh3vcJdF72Bi6T33jpaCj1V26uxUKBXh1yOn5EA8wwlm
         /+xBYhOekNZRvBc1hobzHgb4+0FgkyDE+jt/TEMFdCRxDCAPoG+/L4TCs5MdVBOk1kgI
         yvHaN0O7w+ZJwAz1QB54rkyZLH2uyg+Qp5Fw0ZxIZc19NV/skkUUHB2fi7a6iEQGtx+h
         sO+l+EY5zNKxiTg9dV0wXzHynAABbrarCWdlBcYumPEZOgXBsUs8kPLaCROsqPa4dLs4
         Tt1tki7Aetn+Rysl2ZK6MvVicNY0q72pvToY74ctM7GWm6X9w5xCVvSlPQ545FqVh69n
         /opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba8vo7NYBPo9eSD9iOWqZ0kAa5nRbWhxZY4okQVnGnw=;
        b=gIhl0P6pu7/GE8FJbavZI17CjJGt++mzz3RFqOs3vCPKqAY5E9Oq8930sV15qK4i73
         Sxro7rwsJ7klwJ+diHUy0TdccYweMbs/V2NcmKW68ykbHr7AUPFzdFy+mGVLboFVa67O
         cbLZINVP47Rsjiehat3TvVZ/YpKkhn6k9rqJ5OERnP1ZvYnDo+/AlHYMi/Td3G5sXJdW
         wdg+HLxHLf54h05y65dxthZQ+4QGx10vuiyYp/4bRi/b3GL02lIapB+sH1nEjUejyjJ9
         MwiOAjUR5BceDJ6PW0ynKIbS9CZo2zuuy3Qgb/owRHJr1wIZhC+R6KpOGwcvn7QgQobI
         gY7Q==
X-Gm-Message-State: AOAM5328nUV6Ojy3uMdvfg51BU8L8Gm0KXIaXh0ixIKCATXCZyi0uffQ
        tGJ7FNfmaekz3FMwa9+ui4w+sK2I96D2WtzFtKZnRg==
X-Google-Smtp-Source: ABdhPJwDEE6FfRYKexhd7R5DOEGVnNd4L8WynkLlX3PUiXSfp1YsW6WZeZoAOwShPU8WkJdcJtYI8XYp1uZ5i8UmZts=
X-Received: by 2002:a17:906:eddd:: with SMTP id sb29mr3441623ejb.383.1612363928105;
 Wed, 03 Feb 2021 06:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20210125194751.1275316-1-pasha.tatashin@soleen.com>
 <20210125194751.1275316-3-pasha.tatashin@soleen.com> <05a66361-214c-2afe-22e4-12862ea1e4e2@oracle.com>
In-Reply-To: <05a66361-214c-2afe-22e4-12862ea1e4e2@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 3 Feb 2021 09:51:32 -0500
Message-ID: <CA+CK2bBSJ7T=jsukntQGqO0DoWE_MnhDwtHv-6rfXAPvznKh0Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] mm/gup: check every subpage of a compound page
 during isolation
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 8:23 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 1/25/21 7:47 PM, Pavel Tatashin wrote:
> > When pages are isolated in check_and_migrate_movable_pages() we skip
> > compound number of pages at a time. However, as Jason noted, it is
> > not necessary correct that pages[i] corresponds to the pages that
> > we skipped. This is because it is possible that the addresses in
> > this range had split_huge_pmd()/split_huge_pud(), and these functions
> > do not update the compound page metadata.
> >
> > The problem can be reproduced if something like this occurs:
> >
> > 1. User faulted huge pages.
> > 2. split_huge_pmd() was called for some reason
> > 3. User has unmapped some sub-pages in the range
> > 4. User tries to longterm pin the addresses.
> >
> > The resulting pages[i] might end-up having pages which are not compound
> > size page aligned.
> >
> > Fixes: aa712399c1e8 ("mm/gup: speed up check_and_migrate_cma_pages() on huge page")
> > Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
>
> [...]
>
> >               /*
> >                * If we get a page from the CMA zone, since we are going to
> >                * be pinning these entries, we might as well move them out
> > @@ -1599,8 +1596,6 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> >                               }
> >                       }
> >               }
> > -
> > -             i += step;
> >       }
> >
>

Hi Joao,

> With this, longterm gup will 'regress' for hugetlbfs e.g. from ~6k -> 32k usecs when
> pinning a 16G hugetlb file.

Estimate or you actually measured?

>

> Splitting can only occur on THP right? If so, perhaps we could retain the @step increment

Yes, I do not think we can split HugePage, only THP.

> for compound pages but when !is_transparent_hugepage(head) or just PageHuge(head) like:
>
> +               if (!is_transparent_hugepage(head) && PageCompound(page))
> +                       i += (compound_nr(head) - (pages[i] - head));
>
> Or making specific to hugetlbfs:
>
> +               if (PageHuge(head))
> +                       i += (compound_nr(head) - (pages[i] - head));

Yes, this is reasonable optimization. I will submit a follow up patch
against linux-next.

Thank you,
Pasha
