Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071E244372F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhKBUWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKBUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:22:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F0C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 13:20:17 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bi29so255595qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uv1Cr4f00HzExD4VFx0jLk9JUK/54pKd/9W6U3gV65o=;
        b=SIVY7lzDlozt+W1N7QutRJN4VJF9vHqJ/CJUhScvw984Jaq9/oa4zGLBunmhS+CoGt
         Xs+IkrUs1ruEEOsMkDMjKOBt4Hnu0oUjQYa5eMX8/M/5OI2wkYrSPpOY/SysyqB8+3X3
         +sIcPI5hfgz/euM0L+2ZmMq5ZBjg5g4D4HnGpyv6gAsd8nxQkcOVm0L68K3t/f3JZRvu
         Xxk6Nb+8gHDsG1c5zbsmF63HrWgxlAbJ5ihGVFp+NHVO+UshlW3lpJBmvzfqPMYEuw+l
         rJbzstN9r48W40p/lYc9tJQ4DkDkM1PMBd5Yj/e6aVmaSdqueaw4RgaF280MVRi5c1gK
         niNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uv1Cr4f00HzExD4VFx0jLk9JUK/54pKd/9W6U3gV65o=;
        b=xudmQYHxGtTrZ6bYMRGUesUtgX/e65PkOBXfNm6Hde03svti18k31dlbeB+L4OylGx
         NaWMaXEHvb6iMXOaUaoyinipK5q4b1pmhvkCY/O/IwmKeFIsjQwxs39P2RUMtwVDfJkk
         zOouu6cGwSxAHcWCCyF38QQBId7bu4g/p2/8nR9IW16ZLtzw9Wy8osghmGxJtB9sCJj5
         QXO0gQzEG/qNcWWFCaokV90o08luLFVcES+lO+prQGDzNbiObPHfAx2Rm+7AsBEYrrol
         DY9y8CzWklPq/LWHy3VJC1LgE/2U96UmDbME4rHN6O909gInf3ZVguR01vOUUk8tj+Wz
         qZ1g==
X-Gm-Message-State: AOAM532EuVfZ1vHkOkGF0VH53SRig/ct+TFpUJH7q9+cB4xX7YTsikzC
        1mKrMle8CgTf/iBegGw9uMEq/EvR4DuYtv9U9NlyUw==
X-Google-Smtp-Source: ABdhPJweEsPjodKbqAZtf2krs0YVBvVBwh8g9gLq6QJqx6E7m0IpvI+oQfkbXoLeqSqPNzssxUDarORC8Xr+CA+Vp1o=
X-Received: by 2002:a05:620a:28ce:: with SMTP id l14mr15906086qkp.456.1635884416199;
 Tue, 02 Nov 2021 13:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211011172236.11223-1-mkoutny@suse.com> <CAKfTPtAQmqgAiNGqk9xRmiB4_dzHxaKK68+fWwea25mZv0kT2w@mail.gmail.com>
 <20211013142643.GA48428@blackbody.suse.cz> <20211102160228.GA57072@blackbody.suse.cz>
In-Reply-To: <20211102160228.GA57072@blackbody.suse.cz>
From:   Odin Ugedal <odin@uged.al>
Date:   Tue, 2 Nov 2021 20:20:05 +0000
Message-ID: <CAFpoUr2RQzPJ3XgUcY-B1_EWQhRS2cQYuzcCOkAY=nmv82KV6Q@mail.gmail.com>
Subject: Re: task_group unthrottling and removal race (was Re: [PATCH]
 sched/fair: Use rq->lock when checking cfs_rq list) presence
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tir. 2. nov. 2021 kl. 16:02 skrev Michal Koutn=C3=BD <mkoutny@suse.com>:
>
>
> I've observed that the window between unregister_fair_sched_group() and
> free_fair_sched_group() is commonly around 15 ms (based on kprobe
> tracing).
>
> I have a reproducer (attached) that can hit this window quite easily
> after tuning.  I can observe consequences of it even with a recent 5.15
> kernel. (And I also have reports from real world workloads failing due
> to a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on
> unthrottle").)
>
> My original patch was really an uninformed attempt given the length of
> the window.


Thanks for your digging into this! I don't have time to run the
reproduction myself
atm but it looks good. Will look more deeply into it this weekend.

> On Wed, Oct 13, 2021 at 07:45:59PM +0100, Odin Ugedal <odin@uged.al> wrot=
e:
>
> I say no to reverting 31bc6aeaab1d ("sched/fair: Optimize
> update_blocked_averages()") (it solves reported performance issues, it's
> way too old :-).

Yeah, I am fine with not reverting that one.


> 1) Revert a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on=
 unthrottle") and its fixups.
> (Not exclusive with the other suggestions, rather a stop-gap for the
> time being.)

I am fine with reverting this commit for the short term. Can you post
a revert patch of it together
with your bug details, as well as references to this discussion. Feel
free to add me to it
Acked-by: Odin Ugedal <odin@uged.al>

I do not think we need to revert its fixups, as they help the
consistency of the list in other cases
as well. Might be wrong about this one, so it would probably need some
testing. They should
at least not cause _this_ race issue.

The performance regression of reverting that commit should also be
_fairly_ small, even though
it can cause quite severe fairness issues in some cases. That is
however preferable compared to
a hard lockup.

We can then look at solutions for that issue, and use some time to
figure out the best way
to mitigate it.

> 2) Don't add offlined task_groups into the undecayed list
> - Your proposal with overloaded on_list=3D2 could serve as mark of that,
>   but it's a hack IMO.
> - Proper way (tm) would be to use css_tryget_online() and css_put() when
>   dealing with the list (my favorite at the moment).

Ahh. Not familiar with css_tryget_online() and css_put(), but they
might be useful here.
Maybe cc the cgroups list about this? But yeah, this is my favorite
medium to long term
as well.

> 3) Narrowing the race-window dramatically
> - that is by moving list removal from unregister_fair_sched_group() to
>   free_fair_sched_group(),
> - <del>or use list_empty(tg->list) as indicator whether we're working
>   with onlined task_group.</del> (won't work for RCU list)

Outside what I can wrap my head around this late, but I vote for a solution
that does _not_ include the phrase "narrowing a race window"
if we can eliminate it.

> 4) Rework how throttled load is handled (hand waving)
> - There is remove_entity_load_avg() that moves the load to parent upon
>   final removal. Maybe it could be generalized for temporary removals by
>   throttling (so that unthrottling could again add only non-empty
>   cfs_rqs to the list and undecayed load won't skew fairness).
> - or the way of [1].

Yeah, we can do this if the performance impact of always grabbing the rq lo=
ck
on control group delete (essentially your initial patch here). My hunch is =
that
the impact of the lock is essentially zero, and that doing something like 2=
)
is better if we can do that. Have not sketched up a proper solution like th=
is,
so not sure how it will look.

> 5) <your ideas>

Nah, I think you found all the possible solutions I have thought of. :)

> Opinions?

Again, thanks for working on this, and for the nice script to reproduce!

> [1] https://lore.kernel.org/lkml/CAFpoUr1AO_qStNOYrFWGnFfc=3DuSFrXSYD8A5c=
Q8h0t2pioQzDA@mail.gmail.com/

Thanks
Odin
