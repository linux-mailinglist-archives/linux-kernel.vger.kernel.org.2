Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422D544F825
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 14:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhKNNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhKNNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 08:47:28 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1DC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:44:34 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id u60so38334491ybi.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XiL4sazgjnRcq78QU16A4FxwkDV5n8t9TKCfKPhOGWc=;
        b=3oNlfvHeHCnq0x3+Hdkw6nCI++VSaUBJeBDm8k3FtH/emg9+7H++TSlsQwxngCJjy9
         vHzAlSJH7NAx/0lBfGH+UrUgnxP14gIQGX0rg1fBcdT/La5xo7/xjCSTlponZk70XuqH
         Fx8TkRTd0dI5gt0K+hnZgXDLgUzp+DILMu8i4sHWxWa2EHQqI28VzT/jkkoY+MoDn2Cv
         oTKGqHPRX6Wk7FgMPuKsKwSq7WENNeCr83h+fIhADsRx3bjNjWO5islwxVW+axDCCfMh
         alDDLsaPbwKU7hEh3YB4B/3Y9l980afHwT5m+eovTsejcJ99Z6SeU2EsGnKVFPs3eSBw
         ZJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XiL4sazgjnRcq78QU16A4FxwkDV5n8t9TKCfKPhOGWc=;
        b=ih0smTi/73okLYnrBxcQaJc2uvbbnn8N+vSkYAncG3KjtWNL++OY9PBpzovM6Q29HM
         z65vhH5r/5mWhcwHZ6NpidVF306wKjRZAUvdD0CdhHTYbyC6h/QdV+4awqn4ISTRGpeN
         dGrdgkFyFQp9o0tqZ/Ym5S8SXg6RQ9e6p4aloasGf9B2qZCyeTrQVsqpptJCXXbaHMFv
         WcCicJdD74aQC5XxbsA4tK+Q9FMgUHNEzbPBajzSBr40ziIdFfoX9+M6fmKNSEvwjIGf
         Ktnop4Ff7fVA6Vu4toH475pgFMn6Vs26/04je6skD3hSQy4iN6OuIDnMGVEFt7ysieUb
         vZ1A==
X-Gm-Message-State: AOAM5314mpaxIXI6u1wMCYbObipCQjwlSxfjstFenhwn/1G926kBnzyi
        ivFA2rvWjF9mh6mOk+0nDhYjLYQuiRw9gKMoJ/kh3g==
X-Google-Smtp-Source: ABdhPJw//e9xfUXRSj/P3NnV+MQYvHcC5UtGgf5hdCBInyairlNUjoM/JYQydjIh8rF5bHLUFfdH+0IP3JdX9BGZGTs=
X-Received: by 2002:a25:ef0b:: with SMTP id g11mr32894341ybd.404.1636897473416;
 Sun, 14 Nov 2021 05:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com> <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com> <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
In-Reply-To: <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 14 Nov 2021 21:43:55 +0800
Message-ID: <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Shakeel Butt <shakeelb@google.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 3:15 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sat, Nov 13, 2021 at 6:48 AM Mina Almasry <almasrymina@google.com> wro=
te:
> >
> > On Fri, Nov 12, 2021 at 6:45 PM Muchun Song <songmuchun@bytedance.com> =
wrote:
> > >
> > > On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.com=
> wrote:
> > > >
> > > > Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
> > > >
> > > > To:        Muchun Song <songmuchun@bytedance.com>, Mina Almasry <al=
masrymina@google.com>
> > > >
> > > > Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <s=
huah@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalva=
dor@suse.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@goog=
le.com>, Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>, Ya=
ng Yao <ygyao@google.com>, Joanna Li <joannali@google.com>, Cannon Matthews=
 <cannonmatthews@google.com>, Linux Memory Management List <linux-mm@kvack.=
org>, LKML <linux-kernel@vger.kernel.org>
> > > >
> > > > Bcc:
> > > >
> > > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > > >
> > > > On 11/10/21 6:36 PM, Muchun Song wrote:
> > > >
> > > > > On Thu, Nov 11, 2021 at 9:50 AM Mina Almasry <almasrymina@google.=
com> wrote:
> > > >
> > > > >>
> > > >
> > > > >> +struct hugetlb_cgroup_per_node {
> > > >
> > > > >> +       /* hugetlb usage in pages over all hstates. */
> > > >
> > > > >> +       atomic_long_t usage[HUGE_MAX_HSTATE];
> > > >
> > > > >
> > > >
> > > > > Why do you use atomic? IIUC, 'usage' is always
> > > >
> > > > > increased/decreased under hugetlb_lock except
> > > >
> > > > > hugetlb_cgroup_read_numa_stat() which is always
> > > >
> > > > > reading it. So I think WRITE_ONCE/READ_ONCE
> > > >
> > > > > is enough.
> > > >
> > > >
> > > >
> > > > Thanks for continuing to work this, I was traveling and unable to
> > > >
> > > > comment.
> > >
> > > Have a good time.
> > >
> > > >
> > > >
> > > >
> > > > Unless I am missing something, I do not see a reason for WRITE_ONCE=
/READ_ONCE
> > >
> > > Because __hugetlb_cgroup_commit_charge and
> > > hugetlb_cgroup_read_numa_stat can run parallely,
> > > which meets the definition of data race. I believe
> > > KCSAN could report this race. I'm not strongly
> > > suggest using WRITE/READ_ONCE() here. But
> > > in theory it should be like this. Right?
> > >
> >
> > My understanding is that the (only) potential problem here is
> > read_numa_stat() reading an intermediate garbage value while
> > commit_charge() is happening concurrently. This will only happen on
> > archs where the writes to an unsigned long aren't atomic. On archs
> > where writes to an unsigned long are atomic, there is no race, because
> > read_numa_stat() will only ever read the value before the concurrent
> > write or after the concurrent write, both of which are valid. To cater
> > to archs where the writes to unsigned long aren't atomic, we need to
> > use an atomic data type.
> >
> > I'm not too familiar but my understanding from reading the
> > documentation is that WRITE_ONCE/READ_ONCE don't contribute anything
> > meaningful here:
> >
> > /*
> > * Prevent the compiler from merging or refetching reads or writes. The
> > * compiler is also forbidden from reordering successive instances of
> > * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
> > * particular ordering. One way to make the compiler aware of ordering i=
s to
> > * put the two invocations of READ_ONCE or WRITE_ONCE in different C
> > * statements.
> > ...
> >
> > I can't see a reason why we care about the compiler merging or
> > refetching reads or writes here. As far as I can tell the problem is
> > atomicy of the write.
> >
>
> We have following options:
>
> 1) Use atomic type for usage.
> 2) Use "unsigned long" for usage along with WRITE_ONCE/READ_ONCE.
> 3) Use hugetlb_lock for hugetlb_cgroup_read_numa_stat as well.
>
> All options are valid but we would like to avoid (3).
>
> What if we use "unsigned long" type but without READ_ONCE/WRITE_ONCE.
> The potential issues with that are KCSAN will report this as race and
> possible garbage value on archs which do not support atomic writes to
> unsigned long.

At least I totally agree with you. Thanks for your detailed explanation.

>
> Shakeel
