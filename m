Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E533373345
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhEEAim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEEAil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:38:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D78C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:37:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2so121211lft.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rE+67pf/2itGCrXRDqOt78tityf8/56CzXmtqalTs7Y=;
        b=oPjqJycdh906u/NKD96OF/32I8GkIKXWJvImxBVe8Uoi5eQH0eCxEmU1C14OFp77Bh
         7Q0cLGd/hOMzojqrDn4N+h/krRVmuvkI/846O1BZJG6acacCSK6qRvH8kWCAw0IgRM2o
         tW70LTDJPlXiFxn+Onp+XUen2V3IVkqMFUZ7B20neSLbTJyPlWuIJLgM+YpmiPQ3zIUA
         kc8idKtZ5R86Yp4837IQvSnAO/r8OkY3shl3v0ueAglTxveiZ600ewUj216ssOQDZoWi
         COcs6/4gvKgeap02wOQj5e0w7c0XRY4BL7JWx7btEdKvqUOorT11BgEN8oY2OwmENhV1
         yMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rE+67pf/2itGCrXRDqOt78tityf8/56CzXmtqalTs7Y=;
        b=Awr/TK2UueS4x61M5XPJs2u6CfBV0Gr85Y8QIiofFYZ2z211E0UCiVSgzs+6FkZmcF
         BdrTfaDw1NWkTvvYFBAhN25RLA1BedoapGavMXigTstZYu4iBtIDeNnzWAETUJ2buBX8
         eUuGBxpnE5oC1wWdt5g4g5YbcDkblTkXtlQhH3sjgfyn5ZfIMaDy5HePQkGyPZ1IiWBL
         D2mZtDh14DPtlBxNEnDIRVXp8ynVgwXtx31tuU1kRfBGZxXsoulFkZNtzsJuYLgSgFi2
         LjwlPcdpihOOoqWZmEAUJpy/ZSOztbA1ekFFmvy20BJxP5rF1xHXhIEHQA0HMx/aS0DD
         peOw==
X-Gm-Message-State: AOAM530OxtM4jjvP3AnpdcqmhXnkX3UyeXGq9ScOpSQCPadHUZX8c8Uq
        KLHAzBLhLpJTOuobYp6vIp9gliNVzxlTamwUB++8qw==
X-Google-Smtp-Source: ABdhPJzcggYN+sQarkF2p9KMUd3IdfrvBTmP3Ycic01HaxyCcS1xXBgbGOrpUlrf3u49WLTtzDu+21oBxRurC6ywBew=
X-Received: by 2002:a05:6512:208b:: with SMTP id t11mr16611191lfr.358.1620175063595;
 Tue, 04 May 2021 17:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz> <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz> <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
 <YIA2rB0wgqKzfUfi@dhcp22.suse.cz>
In-Reply-To: <YIA2rB0wgqKzfUfi@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 May 2021 17:37:32 -0700
Message-ID: <CALvZod4_L7GSHnivQTSdDzo=fb4i3z=katjzVCHfLz9WWGK8uQ@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 7:29 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > > What if the pool is depleted?
> >
> > This would mean that either the estimate of mempool size is bad or
> > oom-killer is buggy and leaking memory.
> >
> > I am open to any design directions for mempool or some other way where
> > we can provide a notion of memory guarantee to oom-killer.
>
> OK, thanks for clarification. There will certainly be hard problems to
> sort out[1] but the overall idea makes sense to me and it sounds like a
> much better approach than a OOM specific solution.
>
>
> [1] - how the pool is going to be replenished without hitting all
> potential reclaim problems (thus dependencies on other all tasks
> directly/indirectly) yet to not rely on any background workers to do
> that on the task behalf without a proper accounting etc...
> --

I am currently contemplating between two paths here:

First, the mempool, exposed through either prctl or a new syscall.
Users would need to trace their userspace oom-killer (or whatever
their use case is) to find an appropriate mempool size they would need
and periodically refill the mempools if allowed by the state of the
machine. The challenge here is to find a good value for the mempool
size and coordinating the refilling of mempools.

Second is a mix of Roman and Peter's suggestions but much more
simplified. A very simple watchdog with a kill-list of processes and
if userspace didn't pet the watchdog within a specified time, it will
kill all the processes in the kill-list. The challenge here is to
maintain/update the kill-list.

I would prefer the direction which oomd and lmkd are open to adopt.

Any suggestions?
