Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D203F3546CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhDESqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbhDESq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:46:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE35C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:46:21 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id n4so4108788ili.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY0HNuTY2BtwWhk25KVUO2es0emwJeh8x2dhgf/EE78=;
        b=MYkHf9gDbynKdPCsI0m+IMkm2VZ1kOjcF8B4W57YILnepx0wImoXRS5F3PT7vT2wiO
         7fg+wi/X4MSFtgCmDWgAZ3toj1uZgOFrRyjSdqJCqIbc8SOwE4e39GYdXqYrKCL0iRLZ
         OGQkv090oIbA4EpLRVocQGxRvHJ3RaZ4AAAN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY0HNuTY2BtwWhk25KVUO2es0emwJeh8x2dhgf/EE78=;
        b=UWP4sOOBNzjglVXH7ZLPnrOXEEWfyNTgDBjaTiY9EQ75aFd0xJuRqGHQNVGlcJYmU7
         sTBICK8SdCemvwYrl33FlDK6Pi3lk7zcZcHbGemk/fEpyxRBPABV1F5X+ikj4y6Y5B4z
         a5wzm+JYOkQPQKs8SQw36KrIull9hWXUuyqrjN39Of8an2d7IIN/DKI2S2xObVDNPMxM
         QaVKELnrsnjpbAYPk20zcL1ZZ59mlb2S5wbotfScu3yjBDRlWVoth4/YrQQPfbL3oBFY
         HxOSCPme/LL5e5AH9ADTX5mn0WKJUiHNWUb9o4w1Bb4RoVe+bhNtm1bUD1zgKNrLbZOs
         3GGQ==
X-Gm-Message-State: AOAM532KOfkuALu0LhlDbwe6sHxMIBYgs+V7E7e4eXarqztj5sT6H9bg
        K0y1qV8jl4HBDXi6Be8SeXW2T9HROTxsRbL5y1gasA==
X-Google-Smtp-Source: ABdhPJxqQMx1c0FjnTtsPtKjUiAljdMDUm8dtdz59NQGSCay7Zh3fV7lgH9c5zXKArPVSRcfVG624mqeAZ9GKfz3Y3o=
X-Received: by 2002:a05:6e02:1d01:: with SMTP id i1mr20257304ila.171.1617648380476;
 Mon, 05 Apr 2021 11:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131012.395311786@infradead.org> <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
In-Reply-To: <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 5 Apr 2021 14:46:09 -0400
Message-ID: <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
To:     Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi TJ, Peter,

On Sun, Apr 4, 2021 at 7:39 PM Tejun Heo <tj@kernel.org> wrote:
>
> cc'ing Michal and Christian who've been spending some time on cgroup
> interface issues recently and Li Zefan for cpuset.
>
> On Thu, Apr 01, 2021 at 03:10:12PM +0200, Peter Zijlstra wrote:
> > The cgroup interface now uses a 'core_sched' file, which still takes 0,1. It is
> > however changed such that you can have nested tags. The for any given task, the
> > first parent with a cookie is the effective one. The rationale is that this way
> > you can delegate subtrees and still allow them some control over grouping.
>
> I find it difficult to like the proposed interface from the name (the term
> "core" is really confusing given how the word tends to be used internally)
> to the semantics (it isn't like anything else) and even the functionality
> (we're gonna have fixed processors at some point, right?).
>
> Here are some preliminary thoughts:
>
> * Are both prctl and cgroup based interfaces really necessary? I could be
>   being naive but given that we're (hopefully) working around hardware
>   deficiencies which will go away in time, I think there's a strong case for
>   minimizing at least the interface to the bare minimum.

I don't think these issues are going away as there are constantly new
exploits related to SMT that are coming out. Further, core scheduling
is not only for SMT - there are other usecases as well (such as VM
performance by preventing vCPU threads from core-sharing).

>
>   Given how cgroups are set up (membership operations happening only for
>   seeding, especially with the new clone interface), it isn't too difficult
>   to synchronize process tree and cgroup hierarchy where it matters - ie.
>   given the right per-process level interface, restricting configuration for
>   a cgroup sub-hierarchy may not need any cgroup involvement at all. This
>   also nicely gets rid of the interaction between prctl and cgroup bits.
> * If we *have* to have cgroup interface, I wonder whether this would fit a
>   lot better as a part of cpuset. If you squint just right, this can be
>   viewed as some dynamic form of cpuset. Implementation-wise, it probably
>   won't integrate with the rest but I think the feature will be less jarring
>   as a part of cpuset, which already is a bit of kitchensink anyway.

I think both interfaces are important for different reasons. Could you
take a look at the initial thread I started few months ago? I tried to
elaborate about usecases in detail:
http://lore.kernel.org/r/20200822030155.GA414063@google.com

Also, in ChromeOS we can't use CGroups for this purpose. The CGroup
hierarchy does not fit well with the threads we are tagging. Also, we
use CGroup v1, and since CGroups cannot overlap, this is impossible
let alone cumbersome. And, the CGroup interface having core scheduling
is still useful for people using containers and wanting to
core-schedule each container separately ( +Hao Luo can elaborate more
on that, but I did describe it in the link above).

> > The cgroup thing also '(ab)uses' cgroup_mutex for serialization because it
> > needs to ensure continuity between ss->can_attach() and ss->attach() for the
> > memory allocation. If the prctl() were allowed to interleave it might steal the
> > memory.
> >
> > Using cgroup_mutex feels icky, but is not without precedent,
> > kernel/bpf/cgroup.c does the same thing afaict.
> >
> > TJ, can you please have a look at this?
>
> Yeah, using cgroup_mutex for stabilizing cgroup hierarchy for consecutive
> operations is fine. It might be worthwhile to break that out into a proper
> interface but that's the least of concerns here.
>
> Can someone point me to a realistic and concrete usage scenario for this
> feature?

Yeah, its at http://lore.kernel.org/r/20200822030155.GA414063@google.com
as mentioned above, let me know if you need any more details about
usecase.

About the file name, how about kernel/sched/smt.c ? That definitely
provides more information than 'core_sched.c'.

Thanks,
- Joel
