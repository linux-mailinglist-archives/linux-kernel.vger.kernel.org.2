Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2D32EF7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhCEP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhCEP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:57:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3511C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 07:57:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n16so4452215lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWv/UZ2hjYDMqEoBqmYVC9yvynN1VeJd2v+UBeDpll8=;
        b=TgzwCUQ3IiWaOu2QgyAAwQlt3YVRyEkx1Vb/ghu0SziCkYI/nay7vxuIzs1pBzHBm9
         4EYTrGoywiEmNYE+q7AG48lKgcZ6PkjVqsGecXgZjtYCSuMQt5ZgI9fmmNoJzYWBI6/K
         dydZjsLwRQ0yehf9S5iSELUHWo3qesClshmz7o1SDrd2uH3LiqPHacKt1FOiIDSG/wes
         J+Ssujoo8fctythVTOWIwsn4jchv8Xgt6UiTQhooZmS/8G1T+57sjeayLuKBNX8OqfC/
         UMGaH+qNYOBr0o3wZnhjzoAbB5NoGRx+NjI3DmujUE4qo2I4Y+DVqLsujLXa6EIiQZfG
         5cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWv/UZ2hjYDMqEoBqmYVC9yvynN1VeJd2v+UBeDpll8=;
        b=Kgkq8Ra247WWi+dx8qlg8JayQ+bg+KenDDPCObWzB/KIUGsE8wNu8TCejDShHqlYpf
         iQuJ0DDiwZBbdctSVmT+MwMwna33GmqV2b0Cf7qVDOvLXaKMHi525tfp5DThPAMTV507
         FDmmHzNvLaSYxPN/4YYYQMvPmjGo7XVJJmqmMU/GwCG8qTq9GdnndHwgLhnK3foEv61G
         wHXfKPEvTwZElsIRYU5xNhszClYW8ZiDafkdqfz9TiUvsvJ6oN0Tk0jZlPI9Fm3bWJb2
         uC+524iLEagPHrwG5of9Bzf3ATAZ5GjPqDSkxnvtnwvmM+/w1FJgKNDD2ChHrP6lTzKO
         4Xog==
X-Gm-Message-State: AOAM532NKb+S4l+riSsJbQ3oadvO2bFeFJ8oLFVXk8GBDZx+oPki0RT/
        dRc6kbu9Pc1z35K90EVSbiF6q8MpzBcB6n1vnJU=
X-Google-Smtp-Source: ABdhPJz3I3/uV2QC+ltuxt84+mAJQ0JNI5xNM0cigQNCPx2a79gESfUnSRt9DiMGQ172Ov8xF36vt8IVH/dBf9JIdDQ=
X-Received: by 2002:a19:2308:: with SMTP id j8mr6227592lfj.38.1614959860421;
 Fri, 05 Mar 2021 07:57:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgQWHDUFjzmAazg8WN0BR7nOyHmduj-MV1GWWDUu+UKCQ@mail.gmail.com>
 <YEHtjioucovbxbRt@hirez.programming.kicks-ass.net> <YEJG8v/sCxsG5Lsg@hirez.programming.kicks-ass.net>
In-Reply-To: <YEJG8v/sCxsG5Lsg@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 5 Mar 2021 07:57:29 -0800
Message-ID: <CAADnVQLBrdBggyP1kBVrRQ2JDG+-5HzWAiLR7e-bNuLsKu2PkQ@mail.gmail.com>
Subject: Re: "struct perf_sample_data" alignment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 7:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 05, 2021 at 09:36:30AM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 04, 2021 at 07:45:44PM -0800, Linus Torvalds wrote:
> > > That ____cacheline_aligned goes back many years, this is not new, it
> > > seems to come from back in 2014: commit 2565711fb7d7 ("perf: Improve
> > > the perf_sample_data struct layout").
> >
> > long time ago...
> >
> > > But it really seems entirely and utterly bogus. That cacheline
> > > alignment makes things *worse*, when the variables are on the local
> > > stack. The local stack is already going to be dirty and in the cache,
> > > and aligning those things isn't going to - and I quote from the code
> > > in that commend in that commit - "minimize the cachelines touched".
> > >
> > > Quite the reverse. It's just going to make the stack frame use *more*
> > > memory, and make any cacheline usage _worse_.
> >
> > IIRC there is more history here, but I can't seem to find references
> > just now.
> >
> > What I remember is that since perf_sample_data is fairly large,
> > unconditionally initializing the whole thing is *slow* (and
> > -fauto-var-init=zero will hurt here).
> >
> > So at some point I removed that full initialization and made sure we
> > only unconditionally touched the first few variables, which gave a
> > measurable speedup.
> >
> > Then things got messy again and the commit 2565711fb7d7 referenced above
> > was cleanup, to get back to that initial state.
> >
> > Now, you're right that __cacheline_aligned on on-stack (and this is
> > indeed mostly on-stack) is fairly tedious (there were a few patches
> > recently to reduce the amount of on-stack instances).
> >
> > I'll put it on the todo list, along with that hotplug stuff (which I
> > tried to fix but ended up with an even bigger mess). I suppose we can
> > try and not have the alignment for the on-stack instances while
> > preserving it for the few off-stack ones.
> >
> > Also; we're running on the NMI stack, and that's not typically hot.
>
> This seems to be it... (completely untested)
>
> ---
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 3f7f89ea5e51..918a296d2ca2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1032,7 +1032,9 @@ struct perf_sample_data {
>         u64                             cgroup;
>         u64                             data_page_size;
>         u64                             code_page_size;
> -} ____cacheline_aligned;
> +};
> +
> +typedef struct perf_sample_data perf_sample_data_t ____cacheline_aligned;
>
>  /* default value for data source */
>  #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b0c45d923f0f..f32c623abef6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -923,7 +923,7 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
>   * bpf_perf_event_output
>   */
>  struct bpf_trace_sample_data {
> -       struct perf_sample_data sds[3];
> +       perf_sample_data_t sds[3];

bpf side doesn't care about about cacheline aligned.
No need to add new typedef just for that.
