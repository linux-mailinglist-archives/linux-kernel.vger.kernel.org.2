Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA032C03F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578197AbhCCSQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbhCCQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:02:48 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD34C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:01:58 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 192so9565146pfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YlBFJQlEO+lyMRVcd8i9eW1uGtWD1JtQnYATA4mTAks=;
        b=apLq6nbx2K8jVdej4g1cYPHE1Ioa284puWrnJYtpO1aj5uE7fnlPe2u988Qg49U6au
         I3/ruUA8+Cc7rYX90yajLnwHT3iIzCjHLmgFpb2CfSfWaRfmhoUkj9xDYIUOAEHx6rmj
         ZnvdqsaTnMggoJ1Irk9hJMWvi511Okdtp6cNI7ZfGvMZ/Y5ykuuUaWL1x1bXdpqOk2q0
         a7Em4aKcPyKOeey5a14E15AwGg+bAtUJ0o59HtlutYL7Hxx/uJCOpBPjxH/385Lr0Isq
         AyXQqISo4dK/dDvkF5mgc5k2kH9MgXwUCj1Mu3jHa7Lanf1PMossFh5ClQYisKuL9UXS
         oJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YlBFJQlEO+lyMRVcd8i9eW1uGtWD1JtQnYATA4mTAks=;
        b=Cn245uigTEC/4+OCtbiHRg79cdpfBQs+Uq1k22cTdZUZxiyIU08S/vCo6EAyB5AP4A
         I2Kdb7DRasDgIO5+BCzfpLbgWP/iB9PFHV0Kg7aEoawtj1Lpl8prGS4JuhB6xkdT5kHv
         i/KpSL0+5QufFfDAjKKDxHbtzpFFOqVi94gXkdJZEN69PxcY5Ig+WQoJdmoBB8Iut4Ya
         xFf6bi3iKwuc8NAsUVfkC0ELHU7HNkvmO+qS72TsZFCvKvPeyuyJxEM5SOUfrjj8Bpe1
         +L2ON4LJwz9ojk+w00VieCqp0GfAVV0QiG+EMVphRpseQ3eV/RsthJtL9lwa7Z3wyZL6
         rJTw==
X-Gm-Message-State: AOAM531C3vXRyD0bcsl8t5/7cFWrdv76ZDqfIInPC2Y4hLDtQhVEMSnv
        PeepOyYygA9YEYNwNI84bGowF9/gEgFCZmp1L1orCxNYPrzyNJqT
X-Google-Smtp-Source: ABdhPJywIlwbJQpn67289Ye30Jbxm6kyewXWb73Tj9gazxumHxqSqR+Zp4n+D0YeXyZBttOWLu9E4/kSnyH2MoxVgj4=
X-Received: by 2002:a63:161c:: with SMTP id w28mr12136789pgl.341.1614787318191;
 Wed, 03 Mar 2021 08:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <20210303034659.91735-5-zhouchengming@bytedance.com> <YD+w6Gbb49LeIQb1@hirez.programming.kicks-ass.net>
In-Reply-To: <YD+w6Gbb49LeIQb1@hirez.programming.kicks-ass.net>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 4 Mar 2021 00:01:21 +0800
Message-ID: <CAMZfGtW8kR5yHO=zAdOrfVg=bm8cvXqZp3vieqU7zGhC+BLp_g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/4] psi: Optimize task switch inside
 shared cgroups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 11:53 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 03, 2021 at 11:46:59AM +0800, Chengming Zhou wrote:
> > The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
> > cgroups") only update cgroups whose state actually changes during a
> > task switch only in task preempt case, not in task sleep case.
> >
> > We actually don't need to clear and set TSK_ONCPU state for common cgroups
> > of next and prev task in sleep case, that can save many psi_group_change
> > especially when most activity comes from one leaf cgroup.
> >
> > sleep before:
> > psi_dequeue()
> >   while ((group = iterate_groups(prev)))  # all ancestors
> >     psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
> > psi_task_switch()
> >   while ((group = iterate_groups(next)))  # all ancestors
> >     psi_group_change(next, .set=TSK_ONCPU)
> >
> > sleep after:
> > psi_dequeue()
> >   nop
> > psi_task_switch()
> >   while ((group = iterate_groups(next)))  # until (prev & next)
> >     psi_group_change(next, .set=TSK_ONCPU)
> >   while ((group = iterate_groups(prev)))  # all ancestors
> >     psi_group_change(prev, .clear=common?TSK_RUNNING:TSK_RUNNING|TSK_ONCPU)
> >
> > When a voluntary sleep switches to another task, we remove one call of
> > psi_group_change() for every common cgroup ancestor of the two tasks.
> >
> Co-developed-by: Muchun ?

Yes. Should Chengming send another version patch to add Co-developed-by tag?

> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
