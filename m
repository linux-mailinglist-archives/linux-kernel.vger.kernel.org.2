Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8129D36FE61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhD3QTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhD3QTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:19:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:18:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 124so29914343lff.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zI4CowRa/LcwYkJ8lPvJ7HqO9Kr1KwEc72oXwyDFlAw=;
        b=S8EQ0yJh85oxt921TgVnXJzGWNt94gYHvUIq6jeEoBdSDHLSz/bbCZl3ac2Zi3EpVo
         Rqt7gsq+x98WhRykg1bchxQ6QCuNEh/Wf4CMD8qo8ih2RF6l1IwQj/s4hEaMieaXI1A7
         v1yNwpD+wDqt7P9XDeMQq76d+Vw7/3Dq5YzUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zI4CowRa/LcwYkJ8lPvJ7HqO9Kr1KwEc72oXwyDFlAw=;
        b=CJHptFmsmhGNePAQXPVPZiZlrPlavx/nvUQ9A26e033ajGZkOI0qg02BD09br+BiKB
         p3ZW42NNHJbGZccJQMIuAE9qS0K9qBhVshz7/Peq9r6NJOOr71hG/qfe3riY3xlVPUbk
         9wFOK9POe7zY29joSRGaguDm5SYzMrW0J5bf9hffT3YeFLHAx0PkuZruZdXLmVx/dBno
         nfG+UM1/3PKtWsRhCn7/PuTCA+ryZwkQxEhwBW3OKctQBZjEWUqZwz1SRwelg27QCqGj
         9D9wsHZoBdGlL2PinljhmtkAvHgZCc/m9jLV1pGmK6P81FeIhnJqV5KWFRZJZ1mtu6y/
         6N3A==
X-Gm-Message-State: AOAM530ZLungCzxG9/d41csFjFnNwihd70bR+TCwNWBjCnIorzuaAYaU
        e4SVwl1CV213Q2USpMCZMoTqsmglbSv/qzZ3xYNkHw==
X-Google-Smtp-Source: ABdhPJzum24RN8/mdkU1Tb5XpaxSiOZ+tImR7pFL45m5EJ5KINjch/ohA2tEgIlGV1Txx52PoLYsBbBqSWa1iYbkJUM=
X-Received: by 2002:a05:6512:218d:: with SMTP id b13mr3987599lft.228.1619799531644;
 Fri, 30 Apr 2021 09:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
 <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com> <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
 <CAOY2WowOR6HhoKMsGrg+2VFD6ySY67E7Kr1s2GCuO4LdyusyUw@mail.gmail.com>
 <CABk29Nt_xBaoawiyMv1RG+Yzg_a9w5RMc6Zy0ggmS5K-9LzrUA@mail.gmail.com>
 <CAOY2WozkceZ+B+AGTVLJ1H-jZDAbr2c7ksjtgrnr7DQ8h5raAg@mail.gmail.com> <CABk29NuM98UEmbxD9OY8TLab0yNbrT5ASJ8ELyUw6ZOZq1j7Zg@mail.gmail.com>
In-Reply-To: <CABk29NuM98UEmbxD9OY8TLab0yNbrT5ASJ8ELyUw6ZOZq1j7Zg@mail.gmail.com>
From:   Don Hiatt <dhiatt@digitalocean.com>
Date:   Fri, 30 Apr 2021 09:18:40 -0700
Message-ID: <CAOY2WoziNni5RAbtSbk0AbhJLowopN4PhKWo_YOVEC5Q1H0yNw@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Josh Don <joshdon@google.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 4:22 PM Josh Don <joshdon@google.com> wrote:
>
> On Thu, Apr 29, 2021 at 2:09 PM Don Hiatt <dhiatt@digitalocean.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 1:48 PM Josh Don <joshdon@google.com> wrote:
> > >
> > > On Wed, Apr 28, 2021 at 9:41 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> > > >
> > > > I'm still seeing hard lockups while repeatedly setting cookies on qemu
> > > > processes even with
> > > > the updated patch. If there is any debug you'd like me to turn on,
> > > > just let me know.
> > > >
> > > > Thanks!
> > > >
> > > > don
> > >
> > > Thanks for the added context on your repro configuration. In addition
> > > to the updated patch from earlier, could you try the modification to
> > > double_rq_lock() from
> > > https://lkml.kernel.org/r/CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com
> > > ? I have a feeling this is what's causing your lockup.
> > >
> > > Best,
> > > Josh
> >
> > Hi Josh,
> >
> > I've been running Aubrey+Peter's patch (attached) for almost 5 hours
> > and haven't had a single issue. :)
> >
> > I'm running a set-cookie script every 5 seconds on the two VMs (each
> > vm is running
> > 'sysbench --threads=1 --time=0 cpu run' to generate some load in the vm) and
> > I'm running two of the same sysbench runs on the HV while setting cookies
> > every 5 seconds.
> >
> > Unless I jinxed us it looks like a great fix. :)
> >
> > Let me know if there is anything else you'd like me to try. I'm going
> > to leave the tests running
> > and see what happens. I update with what I find.
> >
> > Thanks!
> >
> > don
>
> That's awesome news, thanks for validating. Note that with Aubrey's
> patch there is still a race window if sched core is being
> enabled/disabled (ie. if you alternate between there being some
> cookies in the system, and no cookies). In my reply I posted an
> alternative version to avoid that. If your script were to do the
> on-off flipping with the old patch, you'd might eventually see another
> lockup.

My tests have been running 24 hours now and all is good. I'll do another
test with your changes next as well as continue to test the core-sched queue.

This and all the other patches in Peter's repo:
    Tested-by: Don Hiatt <dhiatt@digitalocean.com>

Have a great day and thanks again.

don
