Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031CB3A5C44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhFNEuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 00:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 00:50:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6409C061574
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 21:47:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r198so18831224lff.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DivavMZT0DB2lVtUmC7mfKuI7ok3bEvks33og/PTQuY=;
        b=Y3A66Aj51d6devffT4DrhfOmQDaaJSZwLeMBQmUZGi0XNSY4n4PmYsEuW6bcb8qukh
         7H4Ohj/Vl6bEUCIa05VyiKYnSoyzsRfc2WRik9uYHX0Bv4X8/vcSqmjJeUFuYc92Y6Gk
         vyLmc3poDD0GGX+/EyWeZoQ+hXaaxGw4YikQeTWKNon7FYicGD3C0z4/hmyZXomxs8l3
         y4475d5ROQmeAXL6EAhMJllWd5I+gOWnYsXz21xvSXvUXgcHJOb5ygCk4U21kPEhbBGG
         6czLZcgYdWiWaw4D19aFu6MRi6Y2nudO0Chh+/bA7i3MXAlh53Evh0VnRMHQhtiVtTQn
         KNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DivavMZT0DB2lVtUmC7mfKuI7ok3bEvks33og/PTQuY=;
        b=eCN2Uw87vSLxv1yrgJx32FW6x0OU4FrWTHOK2ZC8YXQM0N4qdKBeazXt49p8vmx2pU
         omcZySSVOYwCmnZbpGi5Vex5Wwjb6Q9YqQMpKubMZnn/a6Orx5uFIg4h1Jk5ur6Hr0dm
         D8TNDSfOaA7fTJOPYFZ0FgeOopv0MLBKqwhWevikB1fnAY5eGLrtrrqkWCW3rpRovlcV
         U0zS8zMBOpqmmSz20UGRTuvat0LiiS2A59+sXFefXtjCbwCkIb/Nc0RGbyWelT4C01fg
         9VqBBM99Fb9OxEm/UMZLytxJABeQ9Sf0RkjRIPWACqNJce+3h4jRIb2pzxZFcLBqh77j
         3PEQ==
X-Gm-Message-State: AOAM5321p1GvWcGW2k9zKNP50Mt5ptwUFEtPl5X9hkGqja+nI5HilspU
        BdiBFxOxEh1gPZ4B3zHZdyvHPUIgCLmpYCe4caVVGA==
X-Google-Smtp-Source: ABdhPJxezLRUpsDqbMvqKsqU8sSDXkc3WSFS/MgS11uY8Z0jxCWrHVN+P6xbSagXIWj26zJBpWhhgZXgDVEeprgUdGs=
X-Received: by 2002:a05:6512:754:: with SMTP id c20mr10540300lfs.356.1623646066877;
 Sun, 13 Jun 2021 21:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210611161545.998858-1-jannh@google.com> <20210611153624.65badf761078f86f76365ab9@linux-foundation.org>
 <CAG48ez3mjsf41Z2vCjmkuBaHe9XgoXbWDGvM4OJdUjqiCQbN4A@mail.gmail.com> <9041f85d-515d-576d-21a9-6f10b6e1279e@nvidia.com>
In-Reply-To: <9041f85d-515d-576d-21a9-6f10b6e1279e@nvidia.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Jun 2021 06:47:20 +0200
Message-ID: <CAG48ez3Vb1BxaZ0EHhR9ctkjCCygMWOQqFMGqt-=Ea2yXrvKiw@mail.gmail.com>
Subject: Re: [PATCH resend] mm/gup: fix try_grab_compound_head() race with split_huge_page()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 12:17 PM John Hubbard <jhubbard@nvidia.com> wrote:
> On 6/11/21 3:49 PM, Jann Horn wrote:
> > On Sat, Jun 12, 2021 at 12:36 AM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >> On Fri, 11 Jun 2021 18:15:45 +0200 Jann Horn <jannh@google.com> wrote:
> >>> +/* Equivalent to calling put_page() @refs times. */
> >>> +static void put_page_refs(struct page *page, int refs)
> >>> +{
> >>> +     VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
> >>
> >> I don't think there's a need to nuke the whole kernel in this case.
> >> Can we warn then simply leak the page?  That way we have a much better
> >> chance of getting a good bug report.
> >
> > Ah, yeah, I guess that makes sense. I had just copied this over from
> > put_compound_head(), and figured it was fine to keep it as-is, but I
> > guess changing it would be reasonable. I'm not quite sure what the
> > best way to do that would be though.
> >
> > I guess the check should go away in !DEBUG_VM builds?
> >
> > Should I just explicitly put the check in an ifdef block? Like so:
> >
> > #ifdef CONFIG_DEBUG_VM
> > if (VM_WARN_ON_ONCE_PAGE(...))
> >    return;
> > #endif
> >
> > Or, since inline ifdeffery looks ugly, get rid of the explicit ifdef,
>
> Agreed: VM_WARN_ON_ONCE_PAGE(), at least at the API level, seems like
> the best thing to use here. However, as you point out below, it needs a
> little something first.
>
> > and change the !DEBUG_VM definition of VM_WARN_ON_ONCE_PAGE() as
> > follows so that the branch is compiled away?
> >
> > #define VM_WARN_ON_ONCE_PAGE(cond, page)  (BUILD_BUG_ON_INVALID(cond), false)
> >
> > That would look kinda neat, but it would be different from the
> > behavior of WARN_ON(), which still returns the original condition even
> > in !BUG builds, so that could be confusing...
> >
>
> The VM_WARN_ON_ONCE_PAGE() is not implemented exactly right
> in the !CONFIG_DEBUG_VM case. IMHO it should follow the WARN*()
> behavior, and return the original condition and keep going
> in that case.

But the point of the existing definition is that the compiler can
avoid generating code for the condition in !DEBUG_VM builds, even if
it can't prove that the condition is free of side effects, right? If
VM_WARN_ON_ONCE_PAGE() was changed as you propose, then I think that
in mem_cgroup_page_lruvec(), the compiler would have to generate code
for mem_cgroup_disabled(), which calls static_branch_likely(), which
ends up in "asm volatile" statements; so the compiler probably won't
be able to eliminate the condition.

> Then you could use it directly here.

Depending on whether the intended behavior here is to skip the check
in !DEBUG_VM builds (which was the case before) or also perform the
check in DEBUG_VM builds. And if DEBUG_VM is a config option because
it might have some performance impact, isn't the cost of the check
probably quite large compared to the cost of printing the warning on a
codpath that should never execute?
