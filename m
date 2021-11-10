Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8544BB52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhKJFlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKJFl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:41:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A6EC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:38:42 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e9so3002593ljl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDtvbV5LxV5z9R4yo8jwMsLWShI2ssXYnCOglSG/Vk8=;
        b=qamOWrHxyZagjomM+WM8QbTHUqyyR0Kmhre52bHOun/0mZ4ZSW0DtXoB61SeNbsx/9
         lM287W3whV7P0B5iHWxNW0vKg5yPOyqF+foacGly1baS95FU/NTEJ06X+wp32Zm28S97
         DKKYz50h56k5q6rD9ASrtp0KSlYPNHYri2SSprNg//Yi1e824Zqexs5vQMmVjtVipqtU
         sBnnFD3bugd92DykIHl4b7edlEVyQT4FA5MioKdZ0/0YLUNlo7z5giXubPdkz/CjzxED
         oUF11hywZicr6ogEb4PwJ4nLRftSSsJZNYsnrdmrQw5PbOhrYlkQVRCkhbOInBGADDIT
         YN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDtvbV5LxV5z9R4yo8jwMsLWShI2ssXYnCOglSG/Vk8=;
        b=F+OIAII8Zpc8GYZYWtGEy5qqfALBaU06JenkSrWNfJMlPEbO+TH2AyAASlQ6NNyE2d
         sgg802if8jhllCW02wfEbYSnlyFr3067+5OhZc+k4J/rVMXkhCXKS42F823kP+zoXjbW
         yYMOxT9BbVAZAz8Yyk6ul+1TawS0z3KNaqFfLJukPLsvL186VvNJMwv0z5IuxPmkH/5c
         fZThPe6SR7T1L9pTkBkKph4jAghzwtSmFzzKqucV2WRx6XGdSbYLGwjMFWD/mcmpK1aM
         fZGcBq3qNeylkBoAxSWSUVBmA1K7/oT+M1F+wmiZsmV58wwVNUBQ8Bmj9dqly/R1gYdg
         fmTg==
X-Gm-Message-State: AOAM532F8OBscSwAVda9pz2A91s9ZnAK1J+AFPFSPRULi/x8YaPJoqjO
        QsNPtGP47GctsFgXdE69s2WWBokSjcWWP1x02wY=
X-Google-Smtp-Source: ABdhPJy9NN4VshdRDEzj07i1vT3EYszoUdzpZlAtJxKW8AENVtcHXsKHFW4wCiSCRJssiXymVm24D+qoAAUZKv/nMkc=
X-Received: by 2002:a05:651c:1036:: with SMTP id w22mr13019766ljm.356.1636522720425;
 Tue, 09 Nov 2021 21:38:40 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com> <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com> <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
 <CAGWkznGNb2X_V1ppD2AjBxaKrey_A7U==XO_bnXoNAh2emLs8A@mail.gmail.com> <25828616-1976-6e24-cd7d-a95b789f1bc0@arm.com>
In-Reply-To: <25828616-1976-6e24-cd7d-a95b789f1bc0@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 10 Nov 2021 13:38:27 +0800
Message-ID: <CAB8ipk-AumAR1wXEwd94bj-Fj_QXkom3c9jy9qpeUU4mSacYuA@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xuewen.yan@unisoc.com, Ke Wang <Ke.Wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 8:29 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 08/11/2021 10:20, Zhaoyang Huang wrote:
> > On Mon, Nov 8, 2021 at 4:49 PM Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >>
> >> Hi Dietmar
> >>
> >> On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
> >> <dietmar.eggemann@arm.com> wrote:
> >>>
> >>> On 05/11/2021 06:58, Zhaoyang Huang wrote:
>
> [...]
>
> >>>>> This will let the idle task (swapper) pass. Is this indented? Or do you
> >>>>> want to only let CFS tasks (including SCHED_IDLE) pass?
> >>>> idle tasks will NOT call psi_memstall_xxx. We just want CFS tasks to
> >>>> scale the STALL time.
> >>>
> >>> Not sure I  get this.
> >>>
> >>> __schedule() -> psi_sched_switch() -> psi_task_change() ->
> >>> psi_group_change() -> record_times() -> psi_memtime_fixup()
> >>>
> >>> is something else than calling psi_memstall_enter() or _leave()?
> >>>
> >>> IMHO, at least record_times() can be called with current equal
> >>> swapper/X. Or is it that PSI_MEM_SOME is never set for the idle task in
> >>> this callstack? I don't know the PSI internals.
> > According to my understanding, PSI_MEM_SOME represents the CORE's
> > state within which there is at least one task trapped in memstall
> > path(only counted in by calling PSI_MEMSTALL_ENTER). record_times is
> > responsible for collecting the delta time of the CORE since it start.
> > What we are doing is to make the delta time more precise. So idle task
> > is irrelevant for these.
>
> Coming back to the original snippet of the patch.
>
> static unsigned long psi_memtime_fixup(u32 growth)
> {
>
>     if (!(current->policy == SCHED_NORMAL ||
>           current->policy == SCHED_BATCH))
>         return growth_fixed;
>
> With this condition:
>
> (1) you're not bailing when current is the idle task. It has policy
>     equal 0 (SCHED_NORMAL)
>
> (2) But you're bailing for a SCHED_IDLE (CFS) task.
>
> I'm not sure that this is indented here?
>
> Since you want to do the scaling later based on whats left for CFS tasks
> from the CPU capacity my hunch is that you want to rather do:
>
>     if (current->sched_class != &fair_sched_class)
>         return growth_fixed;

Yes, It is the correct method!

Thanks!
>
> What's the possible sched classes of current in psi_memtime_fixup?
