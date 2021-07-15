Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569A3C964D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhGODRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhGODRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:17:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B25C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:14:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b12so3806649pfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abyDHR0XRwSMrhA06McE4t3PEmRieAURZX1e2KLvRB4=;
        b=GpJrAxJZnwq6fPqj8j+JHs+SBdIKLopRRZJAb5ZcmyHLusiVn99YhZBxYgVboYwU9u
         US0lZR9SBIKwKCWkN3F/BhKpLSaRyOW5gW7jy5fz4a8kOLH40jTC6NlJTTJeWLJhA11v
         8JGETmCMlhSucSeLzyOxmakWCODX48tCeF9PgB9wnvm0nbpWl5kHDhV0hA6RVr1Jg4Uo
         uqmqEkc77BVC9ZQcww9O/bFKW92oWMJ8+DQBjPdL851Qu3I8eBLOkiKhqUXKQ+E7t7cz
         lmkhegsbt6bIAehkd8FtcU4/1NvoDbz+ESe3D54NCuYvJI8dTErWVITaDvqR05rsf7BN
         WBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abyDHR0XRwSMrhA06McE4t3PEmRieAURZX1e2KLvRB4=;
        b=WzADKEEguRhPfEp/RG4kC9MNIsRkDXlahNxPyfZ5EWCOyT/t+5SEx7Jho/XiHmsXsq
         u6GNS3mTGIJmP4U2/fuTtN4W2CjZWj9b5oRSsTpr2p0rs3JDWaO7G/9VZsZN0GOTSkKt
         M1KdPwuJNZPEapZR08HNB6gL6TfeKptl/Iw7/Bip0J3IDs9gTH6ajZ7/XCSbhq1PHmpZ
         pAWCYeM9pXdeh6kNz9RFScCdsOraRMJ4GYTLoxfVTkRO2Nua0A44/2pZKpR9g2/aSavA
         2tamju1f6uj+K9RgTEvkF6F0RcG+wRygTOCQukcbaCs6nin+huWk1v9CFDxAzJ14Pur5
         56Ow==
X-Gm-Message-State: AOAM530+bHuggLBN4MBVh8SRUMtLyl3iG997ExJIt4JC3CDc8DfUBbnF
        cmn6EZNw9oWDSQrV6cAvOFfhrlrbdOCzWYutG05s5w==
X-Google-Smtp-Source: ABdhPJzOV/c1LX6O04F3PPyi2lFcjnNcqYqiySbWv2hUD0oiEItNo7TlW6+E2Zb4oR9B+ECHbIgo9Bnly2g2+ovg/vs=
X-Received: by 2002:a65:63ce:: with SMTP id n14mr1740199pgv.273.1626318879171;
 Wed, 14 Jul 2021 20:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210710002441.167759-1-mike.kravetz@oracle.com>
 <20210710002441.167759-4-mike.kravetz@oracle.com> <CAMZfGtWvGZZ1VaPzZbEro7nYCHS6tGCL5kYm3ArSQ5b5E0-o5g@mail.gmail.com>
 <6c38223b-83f4-ef7d-68d7-27c0f6ae6359@oracle.com>
In-Reply-To: <6c38223b-83f4-ef7d-68d7-27c0f6ae6359@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 15 Jul 2021 11:14:03 +0800
Message-ID: <CAMZfGtWjZAJfPdow2VgNL9T9jYdLLgekKnnQVtKyzaEwC4FfJQ@mail.gmail.com>
Subject: Re: [External] [PATCH 3/3] hugetlb: before freeing hugetlb page set
 dtor to appropriate value
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 1:39 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 7/14/21 3:57 AM, Muchun Song wrote:
> > On Sat, Jul 10, 2021 at 8:25 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> +       /*
> >> +        * Very subtle
> >> +        *
> >> +        * For non-gigantic pages set the destructor to the normal compound
> >> +        * page dtor.  This is needed in case someone takes an additional
> >> +        * temporary ref to the page, and freeing is delayed until they drop
> >> +        * their reference.
> >> +        *
> >> +        * For gigantic pages set the destructor to the null dtor.  This
> >> +        * destructor will never be called.  Before freeing the gigantic
> >> +        * page destroy_compound_gigantic_page will turn the compound page
> >> +        * into a simple group of pages.  After this the destructor does not
> >> +        * apply.
> >> +        *
> >> +        * This handles the case where more than one ref is held when and
> >> +        * after update_and_free_page is called.
> >> +        */
> >>         set_page_refcounted(page);
> >> -       set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> >> +       if (hstate_is_gigantic(h))
> >> +               set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> >> +       else
> >> +               set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
> >
> > Hi Mike,
> >
> > The race is really subtle. But we also should remove the WARN from
> > free_contig_range, right? Because the refcount of the head page of
> > the gigantic page can be greater than one, but free_contig_range has
> > the following warning.
> >
> > WARN(count != 0, "%lu pages are still in use!\n", count);
> >
>
> I did hit that warning in my testing and thought about removing it.
> However, I decided to keep it because non-hugetlb code also makes use of
> alloc_contig_range/free_contig_range and it might be useful in those
> cases.
>
> My 'guess' is that the warning was added not because of temporary ref
> count increases but rather to point out any code that forgot to drop a
> reference.

Got it. At least this patch looks good to me. So

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

>
> BTW - It is not just the 'head' page which could trigger this warning, but
> any 'tail' page as well.  That is because we do not call free_contig_range
> with a compound page, but rather a group of pages all with ref count of
> at least one.

Right.

>
> I'm happy to remove the warning if people do not think it is generally
> useful.

For me, I suggest removing it. If someone has any ideas, please
let us know.

> --
> Mike Kravetz
