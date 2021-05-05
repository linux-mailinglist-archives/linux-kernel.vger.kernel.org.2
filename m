Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1F374B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 00:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEEWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhEEWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 18:30:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E957DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 15:29:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o21so2710461iow.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 15:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXvKaaWq7vzQpCpbouH1Lr4d0ReClmY25AFj528tEt8=;
        b=PHwrFCjoDG3i5t0h6G53GUeTmcPpvyzfeZaoFNrkz5UNd2w0cS44uVKx3xOBo3oI69
         xhBYHTV61NA7hpVVTsjJs4BUQJytqu3otML+kpPijY1vETjMPT+F0kSDdW8RNgk6jV7D
         R1J3//4LGm8DGtcVWr1stN/z0XH9d6NDolR1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXvKaaWq7vzQpCpbouH1Lr4d0ReClmY25AFj528tEt8=;
        b=o5R+OHbE0U2bIePNLPGoMYQokq4tdVhMhPlYsU706d3nztwugG/WzblrrtdjEPmQSO
         cRl7kgG5x1k3RmbdkNNH01Kf6qmiiYjJe+TwO7zojH/yr2Zy4zhMmqa2hfeNHIYo19Hk
         GJugDwfGflF2MHG3FLOP5pAeq2Lh6FlAhkIJ6AnKxVXGq3Nywsg6kPEkM9S889fLtn2h
         KHYn1HcPxzHEbvn+3wRn2Y4cdNjU4xjPIhtRDuiVdWndyQO2rFtGddmCemotZQikWfiC
         rUXc+kPzNxpYpDqLgwola66HOMIr/kiuPRIyunR0qN9IfDc+cHE0NKSpVguQ/0rDrDPX
         T7Nw==
X-Gm-Message-State: AOAM532ujEIqm/oKyjc0eGVjUiOhDov5KCr3AM2/jvjZct0FnKeRoQPE
        kuFZBUE36l5WQ8oeY+3HblHFbCgD4fe6KvgxediRdA==
X-Google-Smtp-Source: ABdhPJz72WLR18u0eqPc2kl+tLtEMNBnBdqPdgYwoWhMal5ij4YSX2sV88t2x7kv5K6/tTzd1pB2wIPqcD+NJynioEw=
X-Received: by 2002:a02:cb09:: with SMTP id j9mr863049jap.110.1620253754386;
 Wed, 05 May 2021 15:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org> <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
 <fe37ff8f-ebf0-25ec-4f3c-df3373944efa@iogearbox.net> <CAEf4BzYsAXQ1t6GUJ4f8c0qGLdnO4NLDVJLRMhAY2oaiarDd6g@mail.gmail.com>
 <CAEf4BzYqUxgj28p7e1ng_5gfebXdVdrCVyPK4bjA31O4wgppeA@mail.gmail.com>
In-Reply-To: <CAEf4BzYqUxgj28p7e1ng_5gfebXdVdrCVyPK4bjA31O4wgppeA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 6 May 2021 00:29:03 +0200
Message-ID: <CABRcYmJBxY5AQMzO2vuuhVN7hs=1h+ursEnVAXpCPJ3DrkRrUA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 10:52 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 5, 2021 at 1:48 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, May 5, 2021 at 1:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> > >
> > > On 5/5/21 8:55 PM, Andrii Nakryiko wrote:
> > > > On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
> > > >>
> > > >> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> > > >> per-cpu buffer that they use to store temporary data (arguments to
> > > >> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> > > >> by the end of their scope with bpf_bprintf_cleanup.
> > > >>
> > > >> If one of these helpers gets called within the scope of one of these
> > > >> helpers, for example: a first bpf program gets called, uses
> > > >
> > > > Can we afford having few struct bpf_printf_bufs? They are just 512
> > > > bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
> > > > only situation where this can occur, right? If someone is doing
> > > > bpf_snprintf() and interrupt occurs and we run another BPF program, it
> > > > will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
> > > > second BPF program, etc. We can't eliminate the probability, but
> > > > having a small stack of buffers would make the probability so
> > > > miniscule as to not worry about it at all.
> > > >
> > > > Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
> > > > the changes are minimal. Nestedness property is preserved for
> > > > non-sleepable BPF programs, right? If we want this to work for
> > > > sleepable we'd need to either: 1) disable migration or 2) instead of
> >
> > oh wait, we already disable migration for sleepable BPF progs, so it
> > should be good to do nestedness level only
>
> actually, migrate_disable() might not be enough. Unless it is
> impossible for some reason I miss, worst case it could be that two
> sleepable programs (A and B) can be intermixed on the same CPU: A
> starts&sleeps - B starts&sleeps - A continues&returns - B continues
> and nestedness doesn't work anymore. So something like "reserving a
> slot" would work better.

Iiuc try_get_fmt_tmp_buf does preempt_enable to avoid that situation ?

> >
> > > > assuming a stack of buffers, do a loop to find unused one. Should be
> > > > acceptable performance-wise, as it's not the fastest code anyway
> > > > (printf'ing in general).
> > > >
> > > > In any case, re-using the same buffer for sort-of-optional-to-work
> > > > bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
> > > > suboptimal, so seems worth fixing this.
> > > >
> > > > Thoughts?
> > >
> > > Yes, agree, it would otherwise be really hard to debug. I had the same
> > > thought on why not allowing nesting here given users very likely expect
> > > these helpers to just work for all the contexts.
> > >
> > > Thanks,
> > > Daniel

What would you think of just letting the helpers own these 512 bytes
buffers as local variables on their stacks ? Then bpf_prepare_bprintf
would only need to write there, there would be no acquire semantic
(like try_get_fmt_tmp_buf) and the stack frame would just be freed on
the helper return so there would be no bpf_printf_cleanup either. We
would also not pre-reserve static memory for all CPUs and it becomes
trivial to handle re-entrant helper calls.

I inherited this per-cpu buffer from the pre-existing bpf_seq_printf
code but I've not been convinced of its necessity.
