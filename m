Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D144F3D8665
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 06:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhG1EEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 00:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhG1EEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 00:04:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C239C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:04:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m1so3221368pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Btfk1u4wYAEJ1JPHSnp+79fE/Z+lkoWUjorje3TDib8=;
        b=QvYmeosTm1xNtdIH2Um5jkPjS8DNjlxHPDVK1JGrxPEGZ5IeY5GeXQBsUygtX9Xu7d
         1UftAb3jV0ph4tAQHvuq+ZN90fJvJC7xy0aqiBdsv22Whb30yiiCITJkbmWODMM8NP0z
         g6xA5fnbetPqa8wg8lNX4kiSxd4BBoPuFSQOpuFtub3U1yEHtN0f3HyiqbDic89lgQWD
         F4F92tJWGrOZ4sMZoC6g/XBPa+4Ez+XlU2wiorvGYrlxhbqkRTKKrqoXYndj3kBgI9Ca
         fxchpke7+h8A9rrvbHqYnYUdqZkQTR+204gpIiN2u4NNGnHXi+FtYoIjIsG7wl0AfAak
         cyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Btfk1u4wYAEJ1JPHSnp+79fE/Z+lkoWUjorje3TDib8=;
        b=dh8JiiNNDrUt3W4K1vSmjR0xDcOrfeuOhGb1Z/Ya/E0Hbf2fnBqViVd5t2iQ5YyZVc
         zFE6D82lj3Euf74wEkyJ2hy8PRAE9oYWaO0vsF5suyfPbQQZ13baQTcpzP+pCNFNE56p
         e6F80ZmpLdOKljVQvSMj9XRT/lbHf4q/FgiiFUMX0W4Sv9Z5GskXEqeCydRch1hxOuMV
         H8fsOxcxFdTkiDcyv0ZE/4mGKD/6lxk8VXxgW/c5RyCvLqg9+a2apynHe+UTImeh/XGe
         y0Onw0B8/35dyoW7aUUlbB1e53n/vW4fWEB0pkWXSstDzk4VQtY9xBEgIEncp8k6PNkt
         SQiw==
X-Gm-Message-State: AOAM531z0YL7j9AkpZboRykDQfSAdeMRFKNGhA2/bHEmoh3TVXyqNMJo
        Q61ch5B/ghaSOn4NtNKLNlGkF/Yh48EEJ35QK7oZDg==
X-Google-Smtp-Source: ABdhPJwEhkeM1mmwO19L8ixbUhxtXf9ohgyUP3+rnpJvGdjSmRksQaaldFhuG7IFEZGB+ZDKL39ysLb8bMFXMz06xp4=
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr6624100pjh.13.1627445060944;
 Tue, 27 Jul 2021 21:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210710002441.167759-1-mike.kravetz@oracle.com> <22abb0f0-ce85-3567-3bfd-74dd1450c14f@oracle.com>
In-Reply-To: <22abb0f0-ce85-3567-3bfd-74dd1450c14f@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 28 Jul 2021 12:03:42 +0800
Message-ID: <CAMZfGtUJZQrzpC=-g3tLQMBq6sUzH3kKJ7fU-5+08R47P+r_xA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hugetlb: fix potential ref counting races
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

On Wed, Jul 28, 2021 at 7:41 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Any additional comments on these patches/this approach?
>
> The first patch addressing this issue actually went into the 5.14 merge
> window as commit 7118fc2906e2 ("hugetlb: address ref count racing in
> prep_compound_gigantic_page").
>
> All this code is very tricky and subtle.  It addresses potential issues
> discovered by code analysis.  I do not believe the races have ever been
> experienced in practice.  If anyone has suggestions for a simpler or
> alternative approach, I would love to hear them.

Hi Mike,

I agree with you that this code is very tricky and subtle. I have looked
at this patch set. For me, I cannot figure out a better solution for this
race.

--
Thanks,
Muchun

> --
> Mike Kravetz
>
>
> On 7/9/21 5:24 PM, Mike Kravetz wrote:
> > When Muchun Song brought up a potential issue with hugetlb ref counting[1],
> > I started looking closer at the code.  hugetlbfs is the only code with it's
> > own specialized compound page destructor and taking special action when ref
> > counts drop to zero.  Potential races happen in this unique handling of ref
> > counts.  The following patches address these races when creating and
> > destroying hugetlb pages.
> >
> > These potential races have likely existed since the creation of
> > hugetlbfs.  They certainly have been around for more than 10 years.
> > However, I am unaware of anyone actually hitting these races.  It is
> > VERY unlikely than anyone will actually hit these races, but they do
> > exist.
> >
> > I could not think of an easy (or difficult) way to force these races.
> > Therefore, testing consisted of adding code to randomly increase ref
> > counts in strategic places.  In this way, I was able to exercise all the
> > race handling code paths.
> >
> > [1] https://lore.kernel.org/linux-mm/CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com/
> >
> > Mike Kravetz (3):
> >   hugetlb: simplify prep_compound_gigantic_page ref count racing code
> >   hugetlb: drop ref count earlier after page allocation
> >   hugetlb: before freeing hugetlb page set dtor to appropriate value
> >
> >  mm/hugetlb.c | 137 ++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 104 insertions(+), 33 deletions(-)
> >
