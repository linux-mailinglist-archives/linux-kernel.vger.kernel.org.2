Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC045CA06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348838AbhKXQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348820AbhKXQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:32:04 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB1C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:28:54 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p37so6270719uae.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yN6Nmt9ug88Fg5aU4VU/Ivh+jZZugsPIfs+d6Xfs88=;
        b=EayTDztFxh4IJrHx8ZTsUNpB2t76+XRcpJ+eZ79qHHu2VYAaYmINaxyFWi5TAuKmfr
         zWLA2FQa0AU2MjDGeXZ1tkNMPsFTUsLe0tDKl1LjBNoZNa98l4niwDPyQ+DubuUbiqmZ
         k7Hzf9Wm5zCuIiWyUzBw1rHl3FbizNHt0p42jq+XHl4To2a+mg/rixpCf4dllHJ0Ybr5
         C3D4sx8sMCV67YOoMw1v4xMjT5RShJmZTO4QjyJlmK0DZsk+poGGA+2GppsqIYGrDpQX
         lQhBMAwXNEYiWKM59R/0GfmGRBekvYUyRZZWmkgbSPOUrD6p0dI+MHrt0pn0edI77fU7
         BQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yN6Nmt9ug88Fg5aU4VU/Ivh+jZZugsPIfs+d6Xfs88=;
        b=EoQSPg1A++6mc6pUo3nOFMQo+WDpqoid672v+9MjKsMD1UbgkeaVH+0U66t8i3yM8+
         9UlgLUIzrnX1CuzMW9n5im7bw2h9wZhuzg3V3QZNDJgraMs+giS/2xzZ96vvp0fiTOkj
         LGv9tD+hW4SGRvR+hxEkvrGnXnXQPnBuiSV3fhC4tM7WTtXJ0ckZeAOJ/ZlnXV/TQfLS
         22F4EWtmDGz79ygqijNgIxZLj6wwSXfyJADP8yXyWuzAYpCHewvB8HgHItRmjKNkDC2/
         bgph5/sV/8E4c+CKJNH+dxiRbEfsUa6QVhVn/eayb6e/1saVN0ChuIvmcjdSEtaVliAQ
         P/Sg==
X-Gm-Message-State: AOAM533MjNERzxCguGBJyyJi6vZ0vS2+EhPNi/SYitb4gtKK2of0Q3SM
        Mj0dQg0jj1W0TbzeUS03QLFJdrqxjjmgBAIIVzOaKg==
X-Google-Smtp-Source: ABdhPJxZZQgEDWCNTylmZHsM0ICOHv3PAjc+H6pgfOuNvz+aCpOvcr1mwhE1Q3TeVLPXP0qYqOvxn7gLBVAICpNHPN8=
X-Received: by 2002:a9f:2431:: with SMTP id 46mr12240607uaq.114.1637771333863;
 Wed, 24 Nov 2021 08:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20211122211327.5931-1-posk@google.com> <YZ5G7gO5Gc1zu/Cm@hirez.programming.kicks-ass.net>
In-Reply-To: <YZ5G7gO5Gc1zu/Cm@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 24 Nov 2021 08:28:43 -0800
Message-ID: <CAFTs51Vp=hfiDkSHVysHLh9QOqpUXUksF-SW86GOd5ih-=7JPQ@mail.gmail.com>
Subject: Re: [PATCH v0.9.1 0/6] sched,mm,x86/uaccess: implement User Managed
 Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 6:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 22, 2021 at 01:13:21PM -0800, Peter Oskolkov wrote:
> > User Managed Concurrency Groups (UMCG) is an M:N threading
> > subsystem/toolkit that lets user space application developers implement
> > in-process user space schedulers.
> >
> > This v0.9.1 patchset is the same as v0.9, where u32/u64 in
> > uapi/linux/umcg.h are replaced with __u32/__u64, as test robot/lkp
> > does not recognize u32/u64 for some reason.
> >
> > v0.9 is v0.8 rebased on top of the current tip/sched/core,
> > with a fix in umcg_update_state of an issue reported by Tao Zhou.
> >
> > Key changes from patchset v0.7:
> > https://lore.kernel.org/all/20211012232522.714898-1-posk@google.com/:
> >
> > - added libumcg tools/lib/umcg;
> > - worker "wakeup" is reworked so that it is now purely a userspace op,
> >   instead of waking the thread in order for it to block on return
> >   to the userspace immediately;
> > - a couple of minor fixes and refactorings.
> >
> > These big things remain to be addressed (in no particular order):
> > - support tracing/debugging
> > - make context switches faster (see umcg_do_context_switch in umcg.c)
> > - support other architectures
> > - cleanup and post selftests in tools/testing/selftests/umcg/
> > - allow cross-mm wakeups (securely)
>
> *groan*... so these patches do *NOT* support the very thing this all
> started with, namely block + wakeup notifications. I'm really not sure
> how that happened, as that was the sole purpose of the exercise.

I'm not sure why you say this - in-process block/wakeup is very much
supported - please see the third patch. Cross-process (cross-mm)
wakeups are not supported at the moment, as the security story has to
be fleshed out.

>
> Aside of that, the whole uaccess stuff is horrific :-( I'll reply to
> that email separately, but the alternative is also included in the
> random hackery below.

Thanks - I'll try to make uaccess more to your liking, unless you say
the whole thing is a no-go.

>
> I'm still trying to make sense of it all, but I'm really not seeing how
> any of this satisfies the initial goals, also it is once again 100% new
> code :/

I believe the initial goals of in-process block/wakeup detection,
on-cpu context switching, etc. are all achieved here. Re: new code:
the code in the third patch evolved into what it is today based on
feedback/discussions in this list.

[...]
