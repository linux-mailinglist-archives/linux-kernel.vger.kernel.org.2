Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74B424778
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbhJFTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhJFTv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:51:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F2C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:49:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 66so3407815pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QP/Vq0xLWohywO1NlG/qjZOSaNtEdv1kkotE+eKre9s=;
        b=SRg+Mq0eFgXHKB4RaB9+ddGyuXYrnzik6i7ncCKK+9NsyjmCQ0IturH7Ka17BYOxjf
         yCFNJMIpxeSjSE4A1tbvnoidCUPhnAF2SMWyZQNKO/CoMYihsc/rim3ORf2Gq4u0y6EU
         Re7ibLbbvMVrPfElJzt+iSc7TfkyQlt2qFp9oincEz6XsnctOUkGsfXVaBPZ0tpcJdij
         wjeCRrgbgGC1sG162b7b1nWOUq2IcWnpfrQQyj8bYRp/yzYLybxZAWpEAPdRC0dvsVCx
         1n3U8vWbn9RP0YwBCKC3ZnlHiClAm2gayUxrWYrEDhf3zHml1XIYwYfG4IBEeJg+IYcS
         zwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QP/Vq0xLWohywO1NlG/qjZOSaNtEdv1kkotE+eKre9s=;
        b=AYhljeVPIidYkLqcgIwTma6Z9lCjcLtpl6j2VehAsAhaAWUzyDF9BxD9gKPrUdRIVX
         4AkSy8oTdIG+JQE6EJ+7c+rRemWnw2oiioChLAC6G/2semvn+8xegqoSmnC6gOaX69iH
         y8TAJkwRVHangRe1HRHiDlClolSz9yCHEAvD/stXz628OpfMTlyxuPPB4K2hGUitho8B
         236td1iEZTGYqB25mOrHyAOQ8RbuJqjgyonQpYmoAL9qr82ybJyTFx7Z+izFwl3zoFZk
         1T2Q1ALtTHOhhUWtadOfCeTlrL6qaDnZ4LNR72Fpn3cFRSvVNhaza4QvJP/WuQrxxCbC
         f3jw==
X-Gm-Message-State: AOAM531wqHz+qfR9xkH2+nSFcJA4cPCnJr94t7NRFf81CujvzJy7RRyr
        rizfVXRTQ5+NNsQMpZ4sqqvEz8mf0xmu+YYQ9TYHwhX22Eo=
X-Google-Smtp-Source: ABdhPJwj4OTPkL0sFf14cRnzzkj+5MSrZkvkai6bUUkG2fxfbNbyGqhLKNBsGc5HpwCCWdVxifbkfQJOBYM/E46F5RA=
X-Received: by 2002:a63:131c:: with SMTP id i28mr478827pgl.396.1633549776062;
 Wed, 06 Oct 2021 12:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210811011056.770351-1-almasrymina@google.com>
 <9f76b103-ba81-d4e3-1071-89009fb585a5@oracle.com> <CAHS8izOkTPYUn5aLYtma=YTAm6yYYraL7AqXjjC4hiqLXXSB-g@mail.gmail.com>
 <09af2c88-35ce-41ff-c172-64766b156d80@suse.cz>
In-Reply-To: <09af2c88-35ce-41ff-c172-64766b156d80@suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 6 Oct 2021 12:49:24 -0700
Message-ID: <CAHS8izMeOQ-sh+U1UG0LpJMp6vQWU0vROPQg89BRQYJqCYvYAA@mail.gmail.com>
Subject: Re: [PATCH v2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My sincere apologies for the late follow up here. I've been out for
sometime and needed some time to catch up.

On Tue, Aug 24, 2021 at 8:33 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 8/19/21 01:35, Mina Almasry wrote:
> > On Fri, Aug 13, 2021 at 4:40 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> Adding Michal, Vlastimil and Kirill as adding this type of support
> >> was discussed in this thread:
> >> https://lore.kernel.org/linux-mm/3ba05809-63a2-2969-e54f-fd0202fe336b@gmx.de/
> >>
> >
> > Ack. I haven't gone through that thread but if there are any concerns
> > with what I whipped up here, do let me know.
>
> Looks like there were mostly concerns with vma's growing and you're not handling
> that, so that's fine?
>

Yes, it seems that's fine.

> >> On 8/10/21 6:10 PM, Mina Almasry wrote:
> >> > Support mremap() for hugepage backed vma segment by simply repositioning
> >> > page table entries. The page table entries are repositioned to the new
> >> > virtual address on mremap().
> >> >
> >> > Hugetlb mremap() support is of course generic; my motivating use case
> >> > is a library (hugepage_text), which reloads the ELF text of executables
> >> > in hugepages. This significantly increases the execution performance of
> >> > said executables.
>
> I think this scenario has been motivation for FS support of THP, but AFAIK we're
> not there yet. Also IIRC Google had some library that did what you describe, but
> using THP's instead of hugetlbfs - might be simpler as there are no reservations
> involved.
>
> But nothing against improving mremap() support wrt hugetlbfs.
>
> > I'll yield to whatever you decide here because I reckon you have much
> > more experience and better judgement here. But my thoughts:
> >
> > 'Sane' usage of mremap() is something like:
> > 1. mmap() a hugetlbfs vma.
> > 2. Pass the vma received from step (1) to mremap() to remap it to a
> > different location.
> >
> > I don't know if there is another usage pattern I need to worry about
> > but given the above, old_addr and old_len will be hugepage aligned
> > already since they are values returned by the previous mmap() call
> > which aligns them, no? So, I think aligning old_addr and old_len to
> > the hugepage boundary is fine.
> >
> > With this support we don't allow mremap() expansion. In my use case
> > old_len==new_len acutally. I think it's fine to also align new_len to
> > the hugepage boundary
> >
> > I already have this code that errors out if the lengths are not aligned:
> >
> > if (old_len & ~huge_page_mask(h) || new_len & ~huge_page_mask(h))
> >     goto out;
> >
> > I think aligning new_addr breaks my use case though. In my use case
> > new_addr is the start of the text segment in the ELF executable, and I
> > don't think that's guaranteed to be anything but page aligned.
>
> Hm, I have a vague (possibly wrong) recollection that Andrea mentioned he always
> planned text to be in THPs so he made sure ELF text sections are aligned as
> such. I guess there's a way to declare alignment in ELF and it depends on
> whether your distro's linker is set up to ask for hugepage-sized one?
>

Sincere apologies to Vlastimil and Mike for my misinformation here as
well. You are completely correct in that my v3 patch return EINVAL if
the new_addr was not already hugepage aligned. It turns out
unbeknownst to me our userspace code was already handling that and
making sure only to remap to an address that was already hugepage
aligned. So, for my use case, either erroring out if new_addr is not
hugepage aligned or aligning new_addr works fine for me. Mike has
indicated he prefers the kernel aligning new_addr for consistency with
how mmap() works, so I've uploaded v4 with that change. I've also
updated the tests to test that case.

As far as I can tell that was the only pending issue with the previous
reviews. Please take another look. Thanks!
