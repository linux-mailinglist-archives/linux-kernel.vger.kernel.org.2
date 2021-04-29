Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2536F2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhD2XXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 19:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhD2XXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:23:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD5C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 16:22:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d19so33292427qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQ8Jf74PNstibeAaTzLNuJjv1ieRo/LrsZj4933jgH4=;
        b=ioEyWjw0cDzGlWrSG3mnYuKT4D6gfMlwiW8DXYIjsB2B43S9kxcicSkdFWR/0Z6WOU
         SFl87W1FC4HYmPMKWb4t7H6lBhTBDkpV6gBpadi9DjvTC0nEWuq68NuiKO6TUSxsEi5p
         LLJ8rQAff+O29Rz4aCPz09oj5rhwS0CRCjzdNcvdDualg06ZfIF8Ik8ce0bgYHA5TJIb
         eZqQyneiYDh+uILhkNHTchuzp0qdcM+VasBgBb8g98vw3TPdUKSwDP/tvgY1/r7mXECb
         zRG2tZkYRE6vUp6V0Gdyj4cT4xiBJWyNNue80NDGnnyDFOl1zEXnBOz6eSJtLxEuqzGO
         NSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQ8Jf74PNstibeAaTzLNuJjv1ieRo/LrsZj4933jgH4=;
        b=FRUH+xewiLZCWRwKBkxtit4Ef2ZxvebwnsHNVYGZNu2x9QtaokfC6aXFooJb9/tgI4
         32krTX+M2LOjSolRiznsDshhgqPCrseOkBivEkVZPtmMQQtg0GuonPbjGxQ64SFiG+56
         SD3ApQ2PEfDx0+50Y1hOJF1l91kFskWaOTKpjBddOdr4ByDjNz0VrQ1K5fWMg3Ws2nic
         gE7GqMF5rQobf1hjxXqbpKQiosm9Gqw8sR4r5FKrWmMOh86O/ccpbs0ziiC7l/SGSFdI
         oXLsSp79QdEAQtJ1CtqVw9DibeGLbm3bCwOmo33k3dey3cvx6o9r9OkzfaM7NY0FaKsP
         3vcg==
X-Gm-Message-State: AOAM530debZ6b4+X9wEMlKlGJL3GtKi0/AOey9dPLf8mxuPJsZWLO09G
        mpeAE+C4F70LrOQpzovhxYPa+r7PE8OStG11EmXa+Q==
X-Google-Smtp-Source: ABdhPJwoSdIrhSptl+J44diCwPbOfm2eJTKr8USbzx3GQJ5xilS3WVn//b2z93oYw4IPCyuUiV3obqviDL20XT7QH8s=
X-Received: by 2002:a37:41ce:: with SMTP id o197mr2365869qka.122.1619738535821;
 Thu, 29 Apr 2021 16:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
 <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com> <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
 <CAOY2WowOR6HhoKMsGrg+2VFD6ySY67E7Kr1s2GCuO4LdyusyUw@mail.gmail.com>
 <CABk29Nt_xBaoawiyMv1RG+Yzg_a9w5RMc6Zy0ggmS5K-9LzrUA@mail.gmail.com> <CAOY2WozkceZ+B+AGTVLJ1H-jZDAbr2c7ksjtgrnr7DQ8h5raAg@mail.gmail.com>
In-Reply-To: <CAOY2WozkceZ+B+AGTVLJ1H-jZDAbr2c7ksjtgrnr7DQ8h5raAg@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 29 Apr 2021 16:22:04 -0700
Message-ID: <CABk29NuM98UEmbxD9OY8TLab0yNbrT5ASJ8ELyUw6ZOZq1j7Zg@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Don Hiatt <dhiatt@digitalocean.com>
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

On Thu, Apr 29, 2021 at 2:09 PM Don Hiatt <dhiatt@digitalocean.com> wrote:
>
> On Thu, Apr 29, 2021 at 1:48 PM Josh Don <joshdon@google.com> wrote:
> >
> > On Wed, Apr 28, 2021 at 9:41 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
> > >
> > > I'm still seeing hard lockups while repeatedly setting cookies on qemu
> > > processes even with
> > > the updated patch. If there is any debug you'd like me to turn on,
> > > just let me know.
> > >
> > > Thanks!
> > >
> > > don
> >
> > Thanks for the added context on your repro configuration. In addition
> > to the updated patch from earlier, could you try the modification to
> > double_rq_lock() from
> > https://lkml.kernel.org/r/CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com
> > ? I have a feeling this is what's causing your lockup.
> >
> > Best,
> > Josh
>
> Hi Josh,
>
> I've been running Aubrey+Peter's patch (attached) for almost 5 hours
> and haven't had a single issue. :)
>
> I'm running a set-cookie script every 5 seconds on the two VMs (each
> vm is running
> 'sysbench --threads=1 --time=0 cpu run' to generate some load in the vm) and
> I'm running two of the same sysbench runs on the HV while setting cookies
> every 5 seconds.
>
> Unless I jinxed us it looks like a great fix. :)
>
> Let me know if there is anything else you'd like me to try. I'm going
> to leave the tests running
> and see what happens. I update with what I find.
>
> Thanks!
>
> don

That's awesome news, thanks for validating. Note that with Aubrey's
patch there is still a race window if sched core is being
enabled/disabled (ie. if you alternate between there being some
cookies in the system, and no cookies). In my reply I posted an
alternative version to avoid that. If your script were to do the
on-off flipping with the old patch, you'd might eventually see another
lockup.
