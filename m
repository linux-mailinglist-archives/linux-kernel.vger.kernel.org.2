Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC344F4C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 20:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhKMTSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 14:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhKMTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:18:08 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD0C061767
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 11:15:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f18so31369797lfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGDC9mOmd22+6y42SCOc0myXQvU3rdpaXKALYEk6oI0=;
        b=Dht6lEkhA7nljd41Ulo/Ix6iV/Klj/9w2CaB6kb5vTcAGvx9J1NqpGhgzE6M5yFxaF
         c04VMFds0UMzQS59VLXUXAwEUx7I/zwLkOv+a2+UpddGKbZXN1k6XofunNB1KLmxv3/Q
         TLeqXFXsvA65L81OpLGh9KBBSlCuAqW5ONWIkG6JrejDIEzo2HeL1vUQU9DyIOa71Cy9
         lh4EzwM5/QiVFMwhX+b1BJpohkh7ClFMSc8Equ5oOThB7PtljrEcVcsub9bxxox1iNvb
         TjXybnhHMraQ76ECwYOtDf2IYqXeD0EwLRIFFd0dQi3cR9UOYmFbjrlANdM7Xc087Oj5
         6GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGDC9mOmd22+6y42SCOc0myXQvU3rdpaXKALYEk6oI0=;
        b=kYgD5lHPDkTmCJek7LS0mLzkTfoDJ6ZoLz643tFAIbgqds0tz3iR1RNTH6eREtBLqM
         BTvnk+vkHc2UGAStj3Sww+gtTkrSr8pUEEXXAp2DvQHhmHKnfU2UgTyZ2OHowVFV5eJh
         ELff2hX8ZyKLPDO3fxecU6M2luiaVWkb+Iwiu5MTfhOtxX8uedvFegwlUARaXha9xMrV
         48rFSW5hHdzmAz6e+AfWlB4sbzWYTOYT9xXF+ZlljfeUAAT6uaMcbpXSzHK1TN4Fs2nP
         VZt8Qu3Ymqz5BIRJOysDhtqJDg5/eBQ4yLj5TUn16hB1liRYnJl6RzfUiXQX8y41VBlr
         7+Xw==
X-Gm-Message-State: AOAM5320ofYx+cxKvUTEwWqWWsUs3asj6gJYBf/JaLTLxVtaQRYkRIwm
        C4SkaX8ccahIjpcJf468HXoLYQ24jf2sgnjVC9ijFA==
X-Google-Smtp-Source: ABdhPJwZQVlaX6+Q9boT3hXjHfb3fZNv0w1nyUWLBr5S8MyIgoBdTw0nlPKLZDQxSv7v8jxZcfNrq8FyA08MdBdj1NI=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr23280643lfg.184.1636830913886;
 Sat, 13 Nov 2021 11:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com> <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
In-Reply-To: <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 13 Nov 2021 11:15:02 -0800
Message-ID: <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Sat, Nov 13, 2021 at 6:48 AM Mina Almasry <almasrymina@google.com> wrote=
:
>
> On Fri, Nov 12, 2021 at 6:45 PM Muchun Song <songmuchun@bytedance.com> wr=
ote:
> >
> > On Sat, Nov 13, 2021 at 7:36 AM Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
> > >
> > > Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
> > >
> > > To:        Muchun Song <songmuchun@bytedance.com>, Mina Almasry <alma=
srymina@google.com>
> > >
> > > Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shu=
ah@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvado=
r@suse.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google=
.com>, Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>, Yang=
 Yao <ygyao@google.com>, Joanna Li <joannali@google.com>, Cannon Matthews <=
cannonmatthews@google.com>, Linux Memory Management List <linux-mm@kvack.or=
g>, LKML <linux-kernel@vger.kernel.org>
> > >
> > > Bcc:
> > >
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > >
> > > On 11/10/21 6:36 PM, Muchun Song wrote:
> > >
> > > > On Thu, Nov 11, 2021 at 9:50 AM Mina Almasry <almasrymina@google.co=
m> wrote:
> > >
> > > >>
> > >
> > > >> +struct hugetlb_cgroup_per_node {
> > >
> > > >> +       /* hugetlb usage in pages over all hstates. */
> > >
> > > >> +       atomic_long_t usage[HUGE_MAX_HSTATE];
> > >
> > > >
> > >
> > > > Why do you use atomic? IIUC, 'usage' is always
> > >
> > > > increased/decreased under hugetlb_lock except
> > >
> > > > hugetlb_cgroup_read_numa_stat() which is always
> > >
> > > > reading it. So I think WRITE_ONCE/READ_ONCE
> > >
> > > > is enough.
> > >
> > >
> > >
> > > Thanks for continuing to work this, I was traveling and unable to
> > >
> > > comment.
> >
> > Have a good time.
> >
> > >
> > >
> > >
> > > Unless I am missing something, I do not see a reason for WRITE_ONCE/R=
EAD_ONCE
> >
> > Because __hugetlb_cgroup_commit_charge and
> > hugetlb_cgroup_read_numa_stat can run parallely,
> > which meets the definition of data race. I believe
> > KCSAN could report this race. I'm not strongly
> > suggest using WRITE/READ_ONCE() here. But
> > in theory it should be like this. Right?
> >
>
> My understanding is that the (only) potential problem here is
> read_numa_stat() reading an intermediate garbage value while
> commit_charge() is happening concurrently. This will only happen on
> archs where the writes to an unsigned long aren't atomic. On archs
> where writes to an unsigned long are atomic, there is no race, because
> read_numa_stat() will only ever read the value before the concurrent
> write or after the concurrent write, both of which are valid. To cater
> to archs where the writes to unsigned long aren't atomic, we need to
> use an atomic data type.
>
> I'm not too familiar but my understanding from reading the
> documentation is that WRITE_ONCE/READ_ONCE don't contribute anything
> meaningful here:
>
> /*
> * Prevent the compiler from merging or refetching reads or writes. The
> * compiler is also forbidden from reordering successive instances of
> * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
> * particular ordering. One way to make the compiler aware of ordering is =
to
> * put the two invocations of READ_ONCE or WRITE_ONCE in different C
> * statements.
> ...
>
> I can't see a reason why we care about the compiler merging or
> refetching reads or writes here. As far as I can tell the problem is
> atomicy of the write.
>

We have following options:

1) Use atomic type for usage.
2) Use "unsigned long" for usage along with WRITE_ONCE/READ_ONCE.
3) Use hugetlb_lock for hugetlb_cgroup_read_numa_stat as well.

All options are valid but we would like to avoid (3).

What if we use "unsigned long" type but without READ_ONCE/WRITE_ONCE.
The potential issues with that are KCSAN will report this as race and
possible garbage value on archs which do not support atomic writes to
unsigned long.

Shakeel
