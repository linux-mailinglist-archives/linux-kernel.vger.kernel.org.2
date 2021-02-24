Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC83236E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 06:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhBXFaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 00:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhBXFaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 00:30:14 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30039C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:29:34 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v17so983018ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/ihSCYjkGq0mVDgKW7XRfTj3HFK99zD03o5XQ3n2So=;
        b=OVVAlme8EN5RSBhZYiTwJnY7D3RqoRKvhT8/weafREU78rdsK2RV2qvpeU0De8lemE
         n3dyapfBvveZpqbutJnF5uA/el7Z0hs4Yarj4gR9am0EbYqgqLG6/i5c3iWFjXPPHn08
         FbBe0KJKGXr3yMDoIRk4lXbnDsZc7oI4Mmcbgu5ZCaqFVmQSvHCWCsGseOKisFTYeog5
         L/Q7ibaiyK0Cpojx87l8lqqlEuV+ux77D2Qrx/WkqKxADFX1QT8kIXzbNgt345u5zlL8
         JhtXlUnLZtW+0UJk2o9LGuqIURvbpxdbB2I+EFJzaDpIyYMRJSQloJPlOL3Y3iEidBdi
         bLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/ihSCYjkGq0mVDgKW7XRfTj3HFK99zD03o5XQ3n2So=;
        b=bLbqFHWYcC6eeEh37Z17iydmYTKC3dqFjg8mgMg8hni2tG+ZTmZgaRtK2tPgxoSvSL
         HrGVYaMy0eWxI2S6S/cC28VCRwgD3s0Zze+hyVi5hPb6lEWDDpJdFnWUpIkU7nDbC2AA
         HeEy/iTT1iuM2V6q6kHN6bDLFsU8ODBoYicrmWpFPvkJD3+8U7fqU5vmb7r3apo8xYPe
         YkOSxsurswHSl0YOz+A3Xqjum4D6XSawXLEz2GdSpAK0PB8e5eLqCCek0D3a0lzcKBbt
         o9ZDSPrIbwvl7EfPOnT9QFNSibONELUvC2ZDQc2C9nQU+zg5QOLIjOogxOkdys0vnv0D
         dRIQ==
X-Gm-Message-State: AOAM533vHIm37V3+jgtudHHMYoAZSxWnM/aUhrtQs4ZXKO/mdKWs2ce5
        gkysoLOI+3UtmM+TXRPP08zgE4I9qu42EU927jFFcRaZ5Jxd2A==
X-Google-Smtp-Source: ABdhPJwZ879rp2aYmE038GsVn/7cREy2wSJR6ciTugHnAFa77EKK8b8teOcBV8CIfbXReKEHdsDpA/F7DDULF8QdaKs=
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr9838399ljj.343.1614144572582;
 Tue, 23 Feb 2021 21:29:32 -0800 (PST)
MIME-Version: 1.0
References: <1613721694-16418-1-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=X1hsFf08J5JNifzFGw=1ikmXj2mp6K=KMOAzCYDWKZUw@mail.gmail.com>
 <CAFA6WYO0PkbpXUJp9jayb71LsydpnHfLFyc21bHotC1dLJ7Dhg@mail.gmail.com> <20210223125447.7penkj42hd6ito4i@maple.lan>
In-Reply-To: <20210223125447.7penkj42hd6ito4i@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 Feb 2021 10:59:20 +0530
Message-ID: <CAFA6WYO9TRyavbTgXMZkHi1YoffrnV8+HxCg-WA=Qf2=-Bcw5Q@mail.gmail.com>
Subject: Re: [PATCH] kernel: debug: Handle breakpoints in kernel .init.text section
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 at 18:24, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Feb 23, 2021 at 02:33:50PM +0530, Sumit Garg wrote:
> > Thanks Doug for your comments.
> >
> > On Tue, 23 Feb 2021 at 05:28, Doug Anderson <dianders@chromium.org> wrote:
> > > > To be clear there is still a very small window between call to
> > > > free_initmem() and system_state = SYSTEM_RUNNING which can lead to
> > > > removal of freed .init.text section breakpoints but I think we can live
> > > > with that.
> > >
> > > I know kdb / kgdb tries to keep out of the way of the rest of the
> > > system and so there's a bias to just try to infer the state of the
> > > rest of the system, but this feels like a halfway solution when really
> > > a cleaner solution really wouldn't intrude much on the main kernel.
> > > It seems like it's at least worth asking if we can just add a call
> > > like kgdb_drop_init_breakpoints() into main.c.  Then we don't have to
> > > try to guess the state...
>
> Just for the record, +1. This would be a better approach.
>
>
> > Sounds reasonable, will post RFC for this. I think we should call such
> > function as kgdb_free_init_mem() in similar way as:
> > - kprobe_free_init_mem()
> > - ftrace_free_init_mem()
>
> As is matching the names...
>
>
> > @@ -378,8 +382,13 @@ int dbg_deactivate_sw_breakpoints(void)
> >         int i;
> >
> >         for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> > -               if (kgdb_break[i].state != BP_ACTIVE)
> > +               if (kgdb_break[i].state < BP_ACTIVE_INIT)
> > +                       continue;
> > +               if (system_state >= SYSTEM_RUNNING &&
> > +                   kgdb_break[i].state == BP_ACTIVE_INIT) {
> > +                       kgdb_break[i].state = BP_UNDEFINED;
> >                         continue;
> > +               }
> >                 error = kgdb_arch_remove_breakpoint(&kgdb_break[i]);
> >                 if (error) {
> >                         pr_info("BP remove failed: %lx\n",
> >
> > >
> > > > +                       kgdb_break[i].state = BP_ACTIVE;
> > > > +               else
> > > > +                       kgdb_break[i].state = BP_ACTIVE_INIT;
> > >
> > > I don't really see what the "BP_ACTIVE_INIT" state gets you.  Why not
> > > just leave it as "BP_ACTIVE" and put all the logic fully in
> > > dbg_deactivate_sw_breakpoints()?
> >
> > Please see my response above.
> >
> > [which was]
> > > "BP_ACTIVE_INIT" state is added specifically to handle this scenario
> > > as to keep track of breakpoints that actually belong to the .init.text
> > > section. And we should be able to again set breakpoints after free
> > > since below change in this patch would mark them as "BP_UNDEFINED":
>
> This answer does not say whether the BP_ACTIVE_INIT state needs to be
> per-breakpoint state or whether we can infer it from the global state.
>
> Changing the state of breakpoints in .init is a one-shot activity
> whether it is triggered explicitly (e.g. kgdb_free_init_mem) or implicitly
> (run the first time dbg_deactivate_sw_breakpoints is called with the system
> state >= running).
>
> As Doug has suggested it is quite possible to unify all the logic to
> handle .init within a single function by running that function when the
> state changes globally.
>

Ah, I see. Thanks for further clarification. Will get rid of
BP_ACTIVE_INIT state.

-Sumit

>
> Daniel.
