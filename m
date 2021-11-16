Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9918E453BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhKPV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhKPV5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:57:00 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:54:03 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h2so622596ili.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZVUIohL2barCI4V/DC/WSWlEx32HYD+S0UuqJH4pmw=;
        b=J14Gg3v0wDj1dDeKycL5ynNxtXEerxkkN0j2Hk4bq7P9Wl+j1YEna1LEGecZ8O+iWE
         bsIcWfI5/ShCKxbLwmT1uq7eYdWNYTPLJMHXAyhYPfKntfLUIRCsZt/cNDSrz+Uq6fs/
         DunVGV7JGzpyoKOeve2e9TuS/4+CVZNUY0QbB6FKpMNQzjQI+kJlWqQxSK72hbJSGPnV
         McEXyUFrPCevFYAIqcjd+ssJ/LzvNvdfdFxsHroZkwMAywzDbnEEKsxFENsTrVTJ8TFP
         HPob0jJmXWavIzdGZwCzwEKka+Nru9gXM5xO5S+rajbA9kyYTJKU5GIM8AePoQUQgtf1
         wAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZVUIohL2barCI4V/DC/WSWlEx32HYD+S0UuqJH4pmw=;
        b=oK9K6ISFFv+aHvyLG9k+u0tTtzSaEmTze5F4w/6hVyXWzeWXDlQoKsE0xun2w90SPw
         2q/C8ygvkZNmg6tIo3czCS/M5EUSwGs7DfxS5VjsB8AJNoQg8m3iHM0JvgTpmLsJwb6W
         w48ybtQ2bp6sH2qNMyCNARNXEtqSlM9v+IDtuEdoE3r1CYNaNEmIidxsatIUzfTKuR7m
         Xcb01nT7ajYDvJ5ZZIRlZXS8HRQTFsClGZO5WLauOXPOyDa8XUYae/bVxszmT4AN0p6g
         Q+i5A/suriKUmlCK15+VoP8FrdTSerzjyATTrmUZ5Pyhw8i4Lq0asp2AZqALA84rwJFb
         yfJw==
X-Gm-Message-State: AOAM533/850q91etUkvH906dgqgPSBGnCkaBMApzs2UFN7I4hJPmzmFY
        fvY/7nckTTqEQv0lwuQ7S444uQjfi7NoM8ZARNQygQ==
X-Google-Smtp-Source: ABdhPJz2MEtLIXeGRj2hnQVHakndrY2gWgC2prN5Fr4jZksKOoPobpJVp6WCTqdVcwTdFXmtBWMnU3soxLdG4kaLi+c=
X-Received: by 2002:a05:6e02:1c46:: with SMTP id d6mr6886998ilg.79.1637099642366;
 Tue, 16 Nov 2021 13:54:02 -0800 (PST)
MIME-Version: 1.0
References: <CAMZfGtVjrMC1+fm6JjQfwFHeZN3dcddaAogZsHFEtL4HJyhYUw@mail.gmail.com>
 <CAHS8izPjJRf50yAtB0iZmVBi1LNKVHGmLb6ayx7U2+j8fzSgJA@mail.gmail.com>
 <CALvZod7VPD1rn6E9_1q6VzvXQeHDeE=zPRpr9dBcj5iGPTGKfA@mail.gmail.com>
 <CAMZfGtWJGqbji3OexrGi-uuZ6_LzdUs0q9Vd66SwH93_nfLJLA@mail.gmail.com>
 <6887a91a-9ec8-e06e-4507-b2dff701a147@oracle.com> <CAHS8izP3aOZ6MOOH-eMQ2HzJy2Y8B6NYY-FfJiyoKLGu7_OoJA@mail.gmail.com>
 <CALvZod7UEo100GLg+HW-CG6rp7gPJhdjYtcPfzaPMS7Yxa=ZPA@mail.gmail.com>
 <YZOeUAk8jqO7uiLd@elver.google.com> <CAHS8izPV20pD8nKEsnEYicaCKLH7A+QTYphWRrtTqcppzoQAWg@mail.gmail.com>
 <CALvZod6zGa15CDQTp+QOGLUi=ap_Ljx9-L5+S6w84U6xTTdpww@mail.gmail.com> <YZQnBoPqMGhtLxnJ@elver.google.com>
In-Reply-To: <YZQnBoPqMGhtLxnJ@elver.google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 16 Nov 2021 13:53:51 -0800
Message-ID: <CAHS8izNH282748JeKeT_W6KC9G9=mJww4k9n5WrtoStDqTfQqA@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Marco Elver <elver@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>, paulmck@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
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

On Tue, Nov 16, 2021 at 1:48 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 16, 2021 at 12:59PM -0800, Shakeel Butt wrote:
> > On Tue, Nov 16, 2021 at 12:48 PM Mina Almasry <almasrymina@google.com> wrote:
> [...]
> > > > Per above, probably unlikely, but allowed. WRITE_ONCE should prevent it,
> > > > and at least relieve you to not worry about it (and shift the burden to
> > > > WRITE_ONCE's implementation).
> > > >
> > >
> > > Thank you very much for the detailed response. I can add READ_ONCE()
> > > at the no-lock read site, that is no issue.
> > >
> > > However, for the writes that happen while holding the lock, the write
> > > is like so:
> > > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] += nr_pages;
> > >
> > > And like so:
> > > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -= nr_pages;
> > >
> > > I.e. they are increments/decrements. Sorry if I missed it but I can't
> > > find an INC_ONCE(), and it seems wrong to me to do something like:
> > >
> > > +               WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
> > > +
> > > h_cg->nodeinfo[page_to_nid(page)] + nr_pages);
>
> From what I gather there are no concurrent writers, right?
>
> WRITE_ONCE(a, a + X) is perfectly fine. What it says is that you can
> have concurrent readers here, but no concurrent writers (and KCSAN will
> still check that). Maybe we need a more convenient macro for this idiom
> one day..
>
> Though I think for something like
>
>         h_cg->nodeinfo[page_to_nid(page)]->usage[idx] += nr_pages;
>
> it seems there wants to be an temporary long* so that you could write
> WRITE_ONCE(*usage, *usage + nr_pages) or something.
>

Ah, perfect, OK I can do this, and maybe add a comment explaining that
we don't have concurrent writers.

> > > I know we're holding a lock anyway so there is no race, but to the
> > > casual reader this looks wrong as there is a race between the fetch of
> > > the value and the WRITE_ONCE(). What to do here? Seems to me the most
> > > reasonable thing to do is just READ_ONCE() and leave the write plain?
> > >
> > >
> >
> > How about atomic_long_t?
>
> That would work of course; if this is very hot path code it might be
> excessive if you don't have concurrent writers.
>
> Looking at the patch in more detail, the counter is a stat counter that
> can be read from a stat file, correct? Hypothetically, what would happen
> if the reader of 'usage' reads approximate values?
>
> If the answer is "nothing", then this could classify as an entirely
> "benign" data race and you could only use data_race() on the reader and
> leave the writers unmarked using normal +=/-=. Check if it fits
> "Data-Racy Reads for Approximate Diagnostics" [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt#n74

Thank you very much for your quick responses. I think if the usage
returns a garbage/approximate value once in a while people will notice
and I can see it causing issues. I think it's worth doing it
'properly' here. I'll upload another version with these changes.
