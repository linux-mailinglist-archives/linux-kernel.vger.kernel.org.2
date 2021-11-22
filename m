Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE57C4597D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhKVWqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhKVWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:46:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5DEC061574;
        Mon, 22 Nov 2021 14:43:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so86145344lfb.0;
        Mon, 22 Nov 2021 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOGMy7fQppmIi2lh+bBNZKhDlmtVTvAMYZ6ML5vXHQk=;
        b=Y/XQX8HoLTQ/AiZ0PyjthwW0sS+Bz5PYFZcLuPVi3KmxkRzAGZJAbvmSCaWKk3VXSO
         H8pze+C3mbthtuPTOBbxee11vj2ndOwmrxG3vapPWK6NuXryfGtyRWKgLjDtvVIvMTvh
         p7usOsqZiv95/HpUu7YRrHMInOJX7ddiWbjSnTPiZA7gn6WrFef4Ke/lLvjA7HNZLIIw
         UsTO37nTaqoO8zOnap3eTMNd2h2hmwYONDJGBFupp4Q6lNTyNlMtcqwMqXRNVY/1m1Ad
         RApj+/F6MvLKhFgZMQtErcu6g5E8eWZWCgUuZX5kKc5H8eJ7TfiZRRIgQ1NpNaVgmhcN
         C05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOGMy7fQppmIi2lh+bBNZKhDlmtVTvAMYZ6ML5vXHQk=;
        b=8FmGASP9Za33lSmCxgDttT+9ROWYoz4HYw9UaEYVK8mXzmIfL8Ba2P3OXAY/jKpHIm
         a54i1Lkqs/sLVPoEqQBTG2Vf0otzK2G+a7fizKDBCjBN7E5zMQicpec889JIR4VPO8r8
         TGuZypGnQ+PeHxn9nx/G7HdRV5gQVRfKk00jMm5NxKHKx+TA3ClTJVjZGJSJfxob7th9
         XmOL9rxA5tTKwdE4/pgr0tvy5t5nw3ox2DksVGvIatnYcOTBvlEfh0c9sGQxtHMvVsKD
         rV7c1L6ewFdT1/+5wudo6ssdotBPk7zQeKFZsYWf30qbIfVR9/+RI5tz0FK7xVD7CeYB
         ho0A==
X-Gm-Message-State: AOAM53045aq1CCHmiG426dSTGhY+gftqf5Ng3AvhhsfUFn4RwTVRqksJ
        VjnM6Aw79VX7IZIP6daDI+ilG0zXvdg0AiBGfdY=
X-Google-Smtp-Source: ABdhPJy5vsW1PcvFZiwn9kAx0mHvt3wDdudHp7YXdnTzsic6PsUQQbhUWWqAtAAWiuSlEfFJA7syF7mk1Arujhc6srw=
X-Received: by 2002:a05:6512:3c85:: with SMTP id h5mr482306lfv.544.1637621016935;
 Mon, 22 Nov 2021 14:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20211111220206.121610-1-jim.cromie@gmail.com> <20211111220206.121610-9-jim.cromie@gmail.com>
 <20211112114953.GA1381@axis.com> <f3914fa9-8b22-d54e-3f77-d998e74094b9@akamai.com>
 <20211116104631.195cbd0b@eldfell> <f87b7076-47e6-89b1-aaf9-b67aa6713e01@akamai.com>
 <20211118172401.0b4d722e@eldfell> <41ea83b2-a707-cb6f-521e-070bb12502de@akamai.com>
 <20211122110208.528e1d80@eldfell>
In-Reply-To: <20211122110208.528e1d80@eldfell>
From:   jim.cromie@gmail.com
Date:   Mon, 22 Nov 2021 15:42:38 -0700
Message-ID: <CAJfuBxyFzA++2JUxLY-6yLqmrETbmsWpTiyJH5w1qKiAkMriNw@mail.gmail.com>
Subject: Re: [PATCH v10 08/10] dyndbg: add print-to-tracefs, selftest with it
 - RFC
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>, Sean Paul <seanpaul@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        quic_saipraka@quicinc.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Will Deacon <will@kernel.org>, maz@kernel.org,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_psodagud@quicinc.com,
        mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 2:02 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>
> On Fri, 19 Nov 2021 11:21:36 -0500
> Jason Baron <jbaron@akamai.com> wrote:
>
> > On 11/18/21 10:24 AM, Pekka Paalanen wrote:
> > > On Thu, 18 Nov 2021 09:29:27 -0500
> > > Jason Baron <jbaron@akamai.com> wrote:
> > >
> > >> On 11/16/21 3:46 AM, Pekka Paalanen wrote:
> > >>> On Fri, 12 Nov 2021 10:08:41 -0500
> > >>> Jason Baron <jbaron@akamai.com> wrote:
> > >>>
> > >>>> On 11/12/21 6:49 AM, Vincent Whitchurch wrote:
> > >>>>> On Thu, Nov 11, 2021 at 03:02:04PM -0700, Jim Cromie wrote:
> > >>>>>> Sean Paul proposed, in:
> > >>>>>> https://urldefense.com/v3/__https://patchwork.freedesktop.org/series/78133/__;!!GjvTz_vk!HcKnMRByYkIdyF1apqQjlN5aBIomzJR1an3YWXM6KXs0EftVMQdrewRA8Dki4A$
> > >>>>>> drm/trace: Mirror DRM debug logs to tracefs
> > >>>>>>
> > >>>>>> His patchset's objective is to be able to independently steer some of
> > >>>>>> the drm.debug stream to an alternate tracing destination, by splitting
> > >>>>>> drm_debug_enabled() into syslog & trace flavors, and enabling them
> > >>>>>> separately.  2 advantages were identified:
> > >>>>>>
> > >>>>>> 1- syslog is heavyweight, tracefs is much lighter
> > >>>>>> 2- separate selection of enabled categories means less traffic
> > >>>>>>
> > >>>>>> Dynamic-Debug can do 2nd exceedingly well:
> > >>>>>>
> > >>>>>> A- all work is behind jump-label's NOOP, zero off cost.
> > >>>>>> B- exact site selectivity, precisely the useful traffic.
> > >>>>>>    can tailor enabled set interactively, at shell.
> > >>>>>>
> > >>>>>> Since the tracefs interface is effective for drm (the threads suggest
> > >>>>>> so), adding that interface to dynamic-debug has real potential for
> > >>>>>> everyone including drm.
> > >>>>>>
> > >>>>>> if CONFIG_TRACING:
> > >>>>>>
> > >>>>>> Grab Sean's trace_init/cleanup code, use it to provide tracefs
> > >>>>>> available by default to all pr_debugs.  This will likely need some
> > >>>>>> further per-module treatment; perhaps something reflecting hierarchy
> > >>>>>> of module,file,function,line, maybe with a tuned flattening.
> > >>>>>>
> > >>>>>> endif CONFIG_TRACING
> > >>>>>>
> > >>>>>> Add a new +T flag to enable tracing, independent of +p, and add and
> > >>>>>> use 3 macros: dyndbg_site_is_enabled/logging/tracing(), to encapsulate
> > >>>>>> the flag checks.  Existing code treats T like other flags.
> > >>>>>
> > >>>>> I posted a patchset a while ago to do something very similar, but that
> > >>>>> got stalled for some reason and I unfortunately didn't follow it up:
> > >>>>>
> > >>>>>  https://urldefense.com/v3/__https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/__;!!GjvTz_vk!HcKnMRByYkIdyF1apqQjlN5aBIomzJR1an3YWXM6KXs0EftVMQdrewRGytKHPg$
> > >>>>>
> > >>>>> A key difference between that patchset and this patch (besides that
> > >>>>> small fact that I used +x instead of +T) was that my patchset allowed
> > >>>>> the dyndbg trace to be emitted to the main buffer and did not force them
> > >>>>> to be in an instance-specific buffer.
> > >>>>
> > >>>> Yes, I agree I'd prefer that we print here to the 'main' buffer - it
> > >>>> seems to keep things simpler and easier to combine the output from
> > >>>> different sources as you mentioned.
> > >>>
> > >>> Hi,
> > >>>
> > >>> I'm not quite sure I understand this discussion, but I would like to
> > >>> remind you all of what Sean's original work is about:
> > >>>
> > >>> Userspace configures DRM tracing into a flight recorder buffer (I guess
> > >>> this is what you refer to "instance-specific buffer").
> > >>>
> > >>> Userspace runs happily for months, and then hits a problem: a failure
> > >>> in the DRM sub-system most likely, e.g. an ioctl that should never
> > >>> fail, failed. Userspace handles that failure by dumping the flight
> > >>> recorder buffer into a file and saving or sending a bug report. The
> > >>> flight recorder contents give a log of all relevant DRM in-kernel
> > >>> actions leading to the unexpected failure to help developers debug it.
> > >>>
> > >>> I don't mind if one can additionally send the flight recorder stream to
> > >>> the main buffer, but I do want the separate flight recorder buffer to
> > >>> be an option so that a) unrelated things cannot flood the interesting
> > >>> bits out of it, and b) the scope of collected information is relevant.
> > >>>
> > >>> The very reason for this work is problems that are very difficult to
> > >>> reproduce in practice, either because the problem itself is triggered
> > >>> very rarely and randomly, or because the end users of the system have
> > >>> either no knowledge or no access to reconfigure debug logging and then
> > >>> reproduce the problem with good debug logs.
> > >>>
> > >>> Thank you very much for pushing this work forward!
> > >>>
> > >>>
> > >>
> > >> So I think Vincent (earlier in the thread) was saying that he finds it
> > >> very helpful have dynamic debug output go to the 'main' trace buffer,
> > >> while you seem to be saying you'd prefer it just go to dynamic debug
> > >> specific trace buffer.
> > >
> > > Seems like we have different use cases: traditional debugging, and
> > > in-production flight recorder for problem reporting. I'm not surprised
> > > if they need different treatment.
> > >
> > >> So we certainly can have dynamic output potentially go to both places -
> > >> although I think this would mean two tracepoints? But I really wonder
> > >> if we really need a separate tracing buffer for dynamic debug when
> > >> what goes to the 'main' buffer can be controlled and filtered to avoid
> > >> your concern around a 'flood'?
> > >
> > > If the DRM tracing goes into the main buffer, then systems in
> > > production cannot have any other sub-system traced in a similar
> > > fashion. To me it would feel very arrogant to say that to make use of
> > > DRM flight recording, you cannot trace much or anything else.
> > >
> > > The very purpose of the flight recorder is run in production all the
> > > time, not in a special debugging session.
> > >
> > > There is also the question of access and contents of the trace buffer.
> > > Ultimately, if automatic bug reports are enabled in a system, the
> > > contents of the trace buffer would be sent as-is to some bug tracking
> > > system. If there is a chance to put non-DRM stuff in the trace buffer,
> > > that could be a security problem.
> > >
> > > My use case is Weston. When Weston encounters an unexpected problem in
> > > production, something should automatically capture the DRM flight
> > > recorder contents and save it alongside the Weston log. Would be really
> > > nice if Weston itself could do that, but I suspect it is going to need
> > > root privileges so it needs some helper daemon.
> > >
> > > Maybe Sean can reiterate their use case more?
> > >
> > >
> > > Thanks,
> > > pq
> > >
> >
> > Ok, so in this current thread the proposal was to create a "dyndbg-tracefs"
> > buffer to put the dynamic debug output (including drm output from dynamic
> > debug) into. And I was saying let's just put in the 'main' trace buffer
> > (predicated on a dynamic debug specific tracepoint), since there seems
> > to be a a use-case for that and it keeps things simpler.
> >
> > But I went back to Sean's original patch, and it creates a drm specific
> > trace buffer "drm" (via trace_array_get_by_name("drm")). Here:
> > https://patchwork.freedesktop.org/patch/445549/?series=78133&rev=5
> >
> > So I think that may be some of the confusion here? The current thread/
> > proposal is not for a drm specific trace buffer...
>
> Hi Jason,
>
> I may very well have confused things, sorry about that. If this series
> is not superseding the idea of the DRM flight recorder, then don't mind
> me. It just sounded very similar and I also haven't seen new revisions
> of the flight recorder in a long time.

IMO this series has clarified the requirement for a flight-recorder mode,
which seems to fit ideally in a separate instance.

> > Having a subsystem specific trace buffer would allow subsystem specific
> > trace log permissions depending on the sensitivity of the data. But
> > doesn't drm output today go to the system log which is typically world
> > readable today?
>
> Yes, and that is exactly the problem. The DRM debug output is so high
> traffic it would make the system log both unusable due to cruft and
> slow down the whole machine. The debug output is only useful when
> something went wrong, and at that point it is too late to enable
> debugging. That's why a flight recorder with an over-written circular
> in-memory buffer is needed.

Seans patch reuses enum drm_debug_category to split the tracing
stream into 10 sub-streams
- how much traffic from each ?
- are some sub-streams more valuable for post-mortem ?
- any value from further refinement of categories ?
- drop irrelevant callsites individually to reduce clutter, extend
buffer time/space ?
