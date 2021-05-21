Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A638BC56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhEUCTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhEUCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:19:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:17:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so6342307pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpTRo1Ap2rz+rRfpTotsbVCE4BSQeeHfMw+YQ+XQye8=;
        b=JA99I58UVOHKgTukkHfOUxC5u2seQ+Mc6ESOfaykGKvWFI16xuoDRvSvJbbQ422I3B
         4UPd30qGQ5I/R0SFtOcotsQneHjv9/U1KPWH2uOMEwh6ZdOPdJvQ8KUqR685UfQOs8ir
         iLdMMunStdcdx6PvxkMVjTwvhHFRwQ9AkYJUjpxQG3uGjl4MhryaOcQ+1i8CsYDe3Faq
         IigeR1eCpMkMr1c6iY4tyRoaSCe0uykFooZIjJhy0g5/gjKx340S0utEGknEN3fxo+hM
         p70WNqEDZnji32C27hDqVp4W0eW6kesHj9FuEgL+OCyYmq78JxbGtsRukeIjAfcvC/+D
         QXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpTRo1Ap2rz+rRfpTotsbVCE4BSQeeHfMw+YQ+XQye8=;
        b=mGV40AAZOvhI2NP3YLEIKMtIzw8+BzohI2HaAY/wMg8VCJpzzhC/Vg0LyHPY3ej7Hm
         TdofvAKONEFrflhcCZddIR5eJZN3PMoBC2rZUzygk0gs68q3SZltm11gSSYdfwCDx/+6
         ZAs5qTZWzxwx/sss2s946WTcBbeT86ygMockj2FhuQUjew7QxtZ2VfQPNSNR3FiwC0pN
         WqbxGJ6gLSlZhLo6emqNvGlIzmIylW75JhbAbKTJdHuRobgqaN4bzoThIfw5kwUa9SYc
         YJIOAMymlnGoWKwgYQ+IRzubJ2RHWEZqOiqjz13YHpKiZvlpYIWX0SBnRq66J1tanfOp
         pWWQ==
X-Gm-Message-State: AOAM5317CPyYE6xwFAVyknvALWW4SBpgEiLzqZhK09rYCe8GZr6dzyRH
        0IXjRClnwkkf6CrL8g5QeDFhTCDlrM7yY7VDpyxFyw==
X-Google-Smtp-Source: ABdhPJxtaRwfr83mysqvFo8ibnlYuAul0GqVuOaLWvuX/FHA39Ac2ZgWetI46CwdLLHPwzWCkr+SP8POVJZQmaOinZk=
X-Received: by 2002:a17:902:7407:b029:f0:dace:a5a9 with SMTP id
 g7-20020a1709027407b02900f0dacea5a9mr9180429pll.34.1621563464956; Thu, 20 May
 2021 19:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210520025949.1866-1-songmuchun@bytedance.com>
 <20210519212412.5653163f94904b141d5d74ce@linux-foundation.org>
 <CAMZfGtVKgfc7Gxf_07038SOJKDbi--9u0Jhwk7fTdrpkXu0m_Q@mail.gmail.com> <4802b996-6135-7817-374f-d8ddca7641ac@oracle.com>
In-Reply-To: <4802b996-6135-7817-374f-d8ddca7641ac@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 21 May 2021 10:17:08 +0800
Message-ID: <CAMZfGtXjjhN3khkrvYngcbkYZ6qYbx-gufrFobcUv5YoAP3bXA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: migrate: fix missing update
 page_private to hugetlb_page_subpool
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        zhengqi.arch@bytedance.com, fam.zheng@bytedance.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 2:17 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/19/21 10:13 PM, Muchun Song wrote:
> > On Thu, May 20, 2021 at 12:24 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >>
> >> On Thu, 20 May 2021 10:59:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> >>
> >>> Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
> >>> page flags") converts page.private for hugetlb specific page flags. We
> >>> should use hugetlb_page_subpool() to get the subpool pointer instead of
> >>> page_private(). The commit forgot to update it in the page migration
> >>> routine. So fix it.
> >>>
> >>> ...
> >>>
> >>> --- a/mm/migrate.c
> >>> +++ b/mm/migrate.c
> >>> @@ -1290,7 +1290,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >>>        * page_mapping() set, hugetlbfs specific move page routine will not
> >>>        * be called and we could leak usage counts for subpools.
> >>>        */
> >>> -     if (page_private(hpage) && !page_mapping(hpage)) {
> >>> +     if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
> >>>               rc = -EBUSY;
> >>>               goto out_unlock;
> >>>       }
> >>
> >> So it uses the wrong page*, so this isn't just a cosmetic fix.  One
> >> cannot tell from this changelog.
> >>
> >> Please describe the runtime effects of this bug.  Please always include
> >> this information when fixing bugs.  And when adding them.
> >
> > OK. I should update the commit log in the next version.
> >
>
> Unfortunately, it is more than a cosmetic fix.
>
> This 'could' prevent the migration of hugetlb pages.  page_private(hpage)
> is now used for hugetlb page specific flags.  At migration time, the
> only flag which could be set is HPageVmemmapOptimized.  This flag will
> only be set if the new vmemmap reduction feature is enabled.  In
> addition, !page_mapping() implies an anonymous mapping.  So, this will
> prevent migration of hugetb pages in anonymous mappings if the vmemmap
> reduction feature is enabled.
>
> In addition, that if statement checked for the rare race condition of a
> page being migrated while in the process of being freed.  Since that
> check is now wrong, we could leak hugetlb subpool usage counts.
>
> Muchun, feel free to use as much of that as you would like in the
> updated commit message.

Thanks Mike. I'll use this.

> --
> Mike Kravetz
