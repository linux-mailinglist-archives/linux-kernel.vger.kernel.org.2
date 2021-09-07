Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8E402E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbhIGSUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbhIGSUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:20:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEDFC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:19:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m28so21239946lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtfAxst7zPqDCwqJkjePIsJDgkS8yCowhuk/DOgTTLI=;
        b=Y1Mftb1ueJkuVr+fK9Gmo/S+YiW2f+pXdD+gZ8/7qCMvXaXn/8upk41U+dlfgqrIq5
         HRR32JoSZUhge2B4tRmBFMd+ANBgRSy8iB53MsrVtt+6v27bOhbZcDaHYhpsJ6Fk7TUc
         1AUR4d+4FxFrJkUQWgB54DiUcUQb+xJk9A2gNqmK591+0JsNfg4CNI6nUp7PXOsoxYLO
         ZPUA7giqcHi558VFQAlHqsmpCkcI8c/bd9lsGSMt/dT2a6ZZ60shFzj/CpeLbjTOih5S
         t+M1nqS0TzTzFk1Xtf9e8rAEcqvPW22ECXCCw1tY3cNiwixMyL9VQnM6LeCVjEsyKmCg
         joEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtfAxst7zPqDCwqJkjePIsJDgkS8yCowhuk/DOgTTLI=;
        b=dNSg+fXp/7P5Y7TroJWZ0z7+irWdmcyhr/Du5tKk1g8rj4YtiZbvZGXGwjYH5bNNqK
         w6dD3zrI+lOnIyMdRB2Y1f7aT0oQ5dsp+XbaJd7OlX8vWUyu2gwiZ9CvX16dtfzkYq/o
         9uCnK2uVJCGxz8hLrFKROwuXee+i6yjxHA858wcopCZbk1wbVcTe8WkIE8MyJcAyg0SO
         zWmYDxOo4V1s+2ygG36nNtSpRH964go01HRWRLakCvlwUx688dqqlFEmN2bpwg7d+YBW
         LHaF0zUNYQfIB51hEbyL2tQMYMUIenW/81VFdOGBJFwVm1QiRB8kfwTh17Wfi7aQS0Ap
         5t7Q==
X-Gm-Message-State: AOAM532hMlTnI4DHwFFiH76EeYGau9lMP3nvThbf0JOMd4Ai8ZS5w7+L
        ODxcqGNknX6UiNQDSExoN7ts4m8kcUSEBBEpUU7kkg==
X-Google-Smtp-Source: ABdhPJwxwFCZCpfohBoMukMi9tqgK6JVEKP+CsqUdSQY3VDbB1hLcDs8NGaSDYm/Ab4sXgNKU1rmLq76dTwsz+09YFg=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr13239990lfu.210.1631038777357;
 Tue, 07 Sep 2021 11:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <CALvZod5Q_K=xLpBWTLgg38X_w23HVSyqW2_Jnz7p=JR+kDD_-w@mail.gmail.com> <CAHk-=wgW3dYJyh6S_U5ot_0Q-OU0-vrS=L8Uky4+Y5fZXeLcKw@mail.gmail.com>
In-Reply-To: <CAHk-=wgW3dYJyh6S_U5ot_0Q-OU0-vrS=L8Uky4+Y5fZXeLcKw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Sep 2021 11:19:26 -0700
Message-ID: <CALvZod5bjVzvgMQ0QoLSVY+JYZmPHaK-0PX6a6kJ_78UAEdX+Q@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Roman Gushchin <guro@fb.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 10:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Sep 7, 2021 at 9:49 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Tue, Sep 7, 2021 at 9:40 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > We are worried about them. I'm considering reverting several of them
> > > because I think the problems are
> > >
> > >  (a) big
> > >
> > >  (b) nontrivial
> > >
> > > and the patches clearly weren't ready and people weren't aware of this issue.
> >
> > Sounds good to me. Please let me know which patches you are planning
> > to revert. I will work on the followup to make those acceptable.
>
> The one that looks clear-cut is the one in this thread:
>
>     0f12156dff28 memcg: enable accounting for file lock caches
>
> which seems to result in regressions on multiple machines and just be
> very bad for anything that uses file locking. I'm not entirely sure
> how much that would show up in real life, but I can most definitely
> imagine it being a problem on a real load.
>
> There's a few other regression reports I've seen, like
>
>     5387c90490f7 mm/memcg: improve refill_obj_stock() performance
>
> but that one had mixed reports (it improved another benchmark), and it
> looks like Minchan has a fix for the regression already.
>
> And
>
>     aa48e47e3906 memcg: infrastructure to flush memcg stats
>     b65584344415 memcg: enable accounting for pollfd and select bits arrays
>
> were reported as a regression in -mm, but not in mainline yet.
>
> I assume (but didn't check) that aa48e47e3906 is a bigger deal to revert.
>

I am suspecting aa48e47e3906 might be similar to [1]. I am testing that theory.

[1] https://lore.kernel.org/all/20210811031734.GA5193@xsang-OptiPlex-9020/T/#u
