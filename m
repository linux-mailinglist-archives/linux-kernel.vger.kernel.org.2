Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB984116DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhITO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbhITO2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:28:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:26:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so17506153pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEsX1wE2wUwgVo5sqagm06pGLMALS0tuk0jb3y2D0xM=;
        b=wmQ7DtwNqInFEzlGaZLWkN/xY6byH8fldi+0bt0L0CVe9maaX3m0W/r/4w/IhmCrF0
         UVmAPKR1ZUisR352UvLvqhm8+Pu34UfOlO5YvS2wQofUkCKjqDRNJj6w4S6S7aZwM4Fu
         IoCrO3hH+vWModq4cnYczInrM6l+n7HCkSzHQhwnGLJAYNDkOBgn22XgGUM6nJswTlzf
         AmbtjZ3DC7UkW+7wjstKAGpbnfrB7m6nBHF1wUAlfZnqNtR9aUJy++mThLjYGO/Ik85d
         g0cB3f6OsWvBNVFwCD6cAA8IHVFd64DZ8VV3x/uRSVS0C/cifs4CtD8j8QdN9ObNbOMa
         ETPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEsX1wE2wUwgVo5sqagm06pGLMALS0tuk0jb3y2D0xM=;
        b=D/9CpyTh+jJoNTJwRGxj301yhMlgwpRX/iTrgOKALtaPToz/Jgbh8c5zOTxLOyALZX
         lSrParYLk7ZxBFUpNxwZDZ/x38Ybus3JgFw0TGqgugx9YtrwrlNxvNBQerD704RjhzR+
         9ub/oEbcVrlO+J/bVKlM3enNZ5od1dXxQNk6sPKGUYdc6/skuwbyV0J2TrYQ5ORPLpRM
         EiWnto1niyi2TiDqFZtXuR15PaZ++sMxUZH2cprXAba7KHD2LZDSjMvuy3+qaERb+XVG
         3D/fhs9tNthrbMQOcepa5fKTDISQpOTldX5LaR8LtgvGjkhFOzSSYenXTu34EOKUMp9j
         gaCw==
X-Gm-Message-State: AOAM530s2cw8W3UwmwOqjR5hB6R+Y3M7q/D2JON5b80D/5YM/SuxAWRJ
        WVIJUxCOPd03XEA0H+01eH5Zk+/jDpsUkvkye9/0TA==
X-Google-Smtp-Source: ABdhPJwfCKGZEQIIRuKMhY+7FrAZiWptl/porLMfHW9bp8HEicvlAaeY9DXy1mhaWHjd2OJKcFVW2vbMnqLt0z0T3N8=
X-Received: by 2002:a62:1717:0:b0:440:527f:6664 with SMTP id
 23-20020a621717000000b00440527f6664mr24161534pfx.73.1632148000396; Mon, 20
 Sep 2021 07:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com>
 <20210917034815.80264-5-songmuchun@bytedance.com> <CAGsJ_4wW6b5aC4va1_BZuWLqxzRkSi3vLcyJo7XGMbVi8i7iuw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wW6b5aC4va1_BZuWLqxzRkSi3vLcyJo7XGMbVi8i7iuw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 20 Sep 2021 22:26:01 +0800
Message-ID: <CAMZfGtVtU2zWYJB1U_Q4AMBb5vYysT2MC06qsA5u0T6FrpbW1g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 4/4] selftests: vm: add a hugetlb test case
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 1:20 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Since the head vmemmap page frame associated with each HugeTLB page is
> > reused, we should hide the PG_head flag of tail struct page from the
> > user. Add a tese case to check whether it is work properly.
> >
>
> TBH, I am a bit confused. I was thinking about some kernel unit tests to make
> sure those kernel APIs touched by this patchset are still working as before.
> This userspace test, while certainly useful for checking the content of page
> frames as expected, doesn't directly prove things haven't changed.
>
> In patch 1/4, a couple of APIs have the fixup for the fake head issue.
> Do you think a test like the below would be more sensible?
> 1. alloc 2MB hugeTLB

It is done in main().

> 2. get each page frame
> 3. apply those APIs in each page frame
> 4. Those APIs work completely the same as before.

Reading the flags of a page by /proc/kpageflags is done
in stable_page_flags(), which has invoked PageHead(),
PageTail(), PageCompound() and compound_head().
If those APIs work properly, the head page must have
15 and 17 bits set. And tail pages must have 16 and 17
bits set but 15 unset.

So I think check_page_flags() has done the step 2 to 4.
What do you think?

Thanks.
