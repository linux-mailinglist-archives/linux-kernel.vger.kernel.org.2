Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D16454083
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhKQF6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhKQF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:58:02 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A0C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:55:04 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i194so4030595yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrkwcwkttrB5ifjfBku0kt7bp7zUGWIamThouDnJlbw=;
        b=XeG50oA0pSmQIl4s9m19nCoQ/qhJfkx1CWWZt9PKu2D9JHuRk1/OA25YipxEXSDTIh
         gGnxfnvCeM+7y5i0yYI6XlSfXSIOdb151vTk1oGutMuQAe2vxYPbNTEdhzjMCNP3M+zJ
         txEXg/ciI4r471SnHQQRgEtGiT20/RmxMK+Z6ImS225WwQL44am4PqdnhIA713wXYLxa
         AhTXUoupPo4n/kP630i6X26xd0fJEc254ziKwtSqRM8UUmOuLoQfzwOD+U6FKSK/FG2y
         G7dpck4sPbhjSI11TZHU3d/ZGxHxyqO0WdcmybROB4+z+sNkRgFhWfW4LxFUfNpTOVPw
         Zi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrkwcwkttrB5ifjfBku0kt7bp7zUGWIamThouDnJlbw=;
        b=0/Db8unBid856QMx93MxQl93DKOYTsuDp5RS/SXISxjwnIRqgPXqll45d1nPwAzhV8
         DPCeePcpePCT0VVHtg4L88A5JzVHeNSSU++fmvqzvJ/ubgONPu/hZwBa3tW3OFXZ5+K7
         FrL/itKXp3Lsd4I41boBJTQwCX9yx9YzZ1H0mrI5GJ2sBdkhk0Fg5wJ+kQCvcrvQO3g9
         uaQ3T4Y6sZVlSBv73o6G4CwThcrd7pxV96xR6k9tODwcMPVHx8Ne7yhBBSrsYtZzrn+y
         Oq8r68hub7XvEvwhtyfexdL310OUGj8PuoT6dPbfQnNFWtE6YlRvfHyIywClV0gyIrQ3
         sZeQ==
X-Gm-Message-State: AOAM532evyakn//9tUL5ZfZMUCfmhR55LInWbjfpvd47CgLqe1eYTlMv
        feWntHUYalNJvNmeCjVC9UHMtAtAZiKcEnki0h0oLQ==
X-Google-Smtp-Source: ABdhPJyeq8yH1nEP2iL4JiJ9qDuYdG/Fd+x7IIVcNcW1bY/kl+StZbqwvb9KcV41WeEPG79niDldKPMWLEpibzAcxlA=
X-Received: by 2002:a25:ef0b:: with SMTP id g11mr15001602ybd.404.1637128503870;
 Tue, 16 Nov 2021 21:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
 <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com> <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
 <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com> <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
 <CALvZod7UEo100GLg+HW-CG6rp7gPJhdjYtcPfzaPMS7Yxa=ZPA@mail.gmail.com>
 <YZOeUAk8jqO7uiLd@elver.google.com> <CAHS8izPV20pD8nKEsnEYicaCKLH7A+QTYphWRrtTqcppzoQAWg@mail.gmail.com>
In-Reply-To: <CAHS8izPV20pD8nKEsnEYicaCKLH7A+QTYphWRrtTqcppzoQAWg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 17 Nov 2021 13:54:25 +0800
Message-ID: <CAMZfGtXuKt_6JGG=N_u0LiMkjYw20CQsUj6tEERU+E0NLCpmbg@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Marco Elver <elver@google.com>, Shakeel Butt <shakeelb@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 4:48 AM Mina Almasry <almasrymina@google.com> wrote:
>
> On Tue, Nov 16, 2021 at 4:04 AM Marco Elver <elver@google.com> wrote:
> >
> > On Mon, Nov 15, 2021 at 11:59AM -0800, Shakeel Butt wrote:
> > > On Mon, Nov 15, 2021 at 10:55 AM Mina Almasry <almasrymina@google.com> wrote:
> > [...]
> > > > Sorry I'm still a bit confused. READ_ONCE/WRITE_ONCE isn't documented
> > > > to provide atomicity to the write or read, just prevents the compiler
> > > > from re-ordering them. Is there something I'm missing, or is the
> > > > suggestion to add READ_ONCE/WRITE_ONCE simply to supress the KCSAN
> > > > warnings?
> >
> > It's actually the opposite: READ_ONCE/WRITE_ONCE provide very little
> > ordering (modulo dependencies) guarantees, which includes ordering by
> > compiler, but are supposed to provide atomicity (when used with properly
> > aligned types up to word size [1]; see __READ_ONCE for non-atomic
> > variant).
> >
> > Some more background...
> >
> > The warnings that KCSAN tells you about are "data races", which occur
> > when you have conflicting concurrent accesses, one of which is "plain"
> > and at least one write. I think [2] provides a reasonable summary of
> > data races and why we should care.
> >
> > For Linux, our own memory model (LKMM) documents this [3], and says that
> > as long as concurrent operations are marked (non-plain; e.g. *ONCE),
> > there won't be any data races.
> >
> > There are multiple reasons why data races are undesirable, one of which
> > is to avoid bad compiler transformations [4], because compilers are
> > oblivious to concurrency otherwise.
> >
> > Why do marked operations avoid data races and prevent miscompiles?
> > Among other things, because they should be executed atomically. If they
> > weren't a lot of code would be buggy (there had been cases where the old
> > READ_ONCE could be used on data larger than word size, which certainly
> > weren't atomic, but this is no longer possible).
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/rwonce.h#n35
> > [2] https://lwn.net/Articles/816850/#Why%20should%20we%20care%20about%20data%20races?
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1920
> > [4] https://lwn.net/Articles/793253/
> >
> > Some rules of thumb when to use which marking:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> >
> > In an ideal world, we'd have all intentionally concurrent accesses
> > marked. As-is, KCSAN will find:
> >
> > A. Data race, where failure due to current compilers is unlikely
> >    (supposedly "benign"); merely marking the accesses appropriately is
> >    sufficient. Finding a crash for these will require a miscompilation,
> >    but otherwise look "benign" at the C-language level.
> >
> > B. Race-condition bugs where the bug manifests as a data race, too --
> >    simply marking things doesn't fix the problem. These are the types of
> >    bugs where a data race would point out a more severe issue.
> >
> > Right now we have way too much of type (A), which means looking for (B)
> > requires patience.
> >
> > > +Paul & Marco
> > >
> > > Let's ask the experts.
> > >
> > > We have a "unsigned long usage" variable that is updated within a lock
> > > (hugetlb_lock) but is read without the lock.
> > >
> > > Q1) I think KCSAN will complain about it and READ_ONCE() in the
> > > unlocked read path should be good enough to silent KCSAN. So, the
> > > question is should we still use WRITE_ONCE() as well for usage within
> > > hugetlb_lock?
> >
> > KCSAN's default config will forgive the lack of WRITE_ONCE().
> > Technically it's still a data race (which KCSAN can find with a config
> > change), but can be forgiven because compilers are less likely to cause
> > trouble for writes (background: https://lwn.net/Articles/816854/ bit
> > about "Unmarked writes (aligned and up to word size)...").
> >
> > I would mark both if feasible, as it clearly documents the fact the
> > write can be read concurrently.
> >
> > > Q2) Second question is more about 64 bit archs breaking a 64 bit write
> > > into two 32 bit writes. Is this a real issue? If yes, then the
> > > combination of READ_ONCE()/WRITE_ONCE() are good enough for the given
> > > use-case?
> >
> > Per above, probably unlikely, but allowed. WRITE_ONCE should prevent it,
> > and at least relieve you to not worry about it (and shift the burden to
> > WRITE_ONCE's implementation).
> >
>
> Thank you very much for the detailed response. I can add READ_ONCE()
> at the no-lock read site, that is no issue.
>
> However, for the writes that happen while holding the lock, the write
> is like so:
> +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] += nr_pages;
>
> And like so:
> +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -= nr_pages;
>
> I.e. they are increments/decrements. Sorry if I missed it but I can't
> find an INC_ONCE(), and it seems wrong to me to do something like:
>
> +               WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
> +
> h_cg->nodeinfo[page_to_nid(page)] + nr_pages);

How about using a local variable to cache
h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
like the following.

long usage = h_cg->nodeinfo[page_to_nid(page)]->usage[idx];

usage += nr_pages;
WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx], usage);

Does this look more comfortable?

>
> I know we're holding a lock anyway so there is no race, but to the
> casual reader this looks wrong as there is a race between the fetch of
> the value and the WRITE_ONCE(). What to do here? Seems to me the most

It's not an issue, because fetching is a read operation and the
path of reading a stat file is also a read operation. Both are "plain"
operations.

> reasonable thing to do is just READ_ONCE() and leave the write plain?

I suggest using WRITE_ONCE() here and READ_ONCE() in the reading.

Thanks.

>
>
> > Thanks,
> > -- Marco
