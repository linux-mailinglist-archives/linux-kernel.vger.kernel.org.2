Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9436F712
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhD3I15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhD3I14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:27:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:27:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s9so21866433ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnNs0Pg3Uye5i8nopt5eZq0rwEWCr4/gJMQBqKGNqXo=;
        b=spJap/K+vD3s15E/46SMdkdy2ySiwVLQ9x92oPDUVUz1Hu0N7IoDS2Zl4NMv6t0gxO
         vop/0v1edM9T0q2FTw2KSeYlsqvr2O0zQEOjCvZFnmaOjsZ270DZm2qVrOmqtgd3XoF4
         20a2PlT7EulBMTNNj9lljh8PE44SmdTBV/tweE6eoPifaE+JDnI2aNT5OJKwxps8i5p3
         rrn7UEbvcnBTZZlrXP2qfCJuWnwbzwLIXw1VRThUwyjZpgF+vITB8yVZ8CvyE5S1pfLn
         eN99C+m5tnnh9MEkLbeYdJeDTTPfZX2WOeSQoBkdl7HzVgcPpBr+bzzE5Gt+VuB3qUh2
         TqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnNs0Pg3Uye5i8nopt5eZq0rwEWCr4/gJMQBqKGNqXo=;
        b=mOYYUehyEbO3NwX+oRXiR1u5y/Krp63KF6kRIEifjTWQ47Brj4+rsoyC0qR4+N+fOV
         75DIY8PF7ybRzpWZzOH8yXzh67nb1FBBlfMF7eV1YLQwW7XYYr9brL8U78DUc55hfsbH
         lJ1iqxc9BiT9qRSy34cmPFLUETom5H05C/W4IzKV3zua4lJSLwajgEbvd2OjBY9OI5cO
         H/Q3OivYYgX+A5OITBn+ZCdfhEakR3YdKOC2UfGJRW/C0c4HSXKIEgjO88S9zoEh6Xes
         1RMqcqS0QWvXeeRCHIrisZIAp032WESNuyc9whm2I4JNdlDiXHxKQW749e9MaQcKaRLz
         OrbA==
X-Gm-Message-State: AOAM531bBqds/W1DCQ/BcUJw6ge2TRXijgEaDo/rsdxzOt8ByAIkWaAC
        HnppP5ySyf4uaJrg6isde9Pv7c39IvP/gEKh7V4b7uUcSyk=
X-Google-Smtp-Source: ABdhPJwT3SYFLtwAJAoKSmEwCVG/S8A4RwlXeg18Ah1oXROHNfaOX8VALPdTBVEDl4Hitz2NCNDAxNrhE84fxxkO/cQ=
X-Received: by 2002:a2e:b058:: with SMTP id d24mr2973416ljl.246.1619771227028;
 Fri, 30 Apr 2021 01:27:07 -0700 (PDT)
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
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 30 Apr 2021 16:26:55 +0800
Message-ID: <CAERHkrtGSMiO30XAneNWY_ccGu1rqkAOCgRQnCgbSh78A_mvKw@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Don Hiatt <dhiatt@digitalocean.com>
Cc:     Josh Don <joshdon@google.com>,
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

On Fri, Apr 30, 2021 at 5:09 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
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

This sounds great, Thanks Don.

However, I guess we have the same problem in _double_lock_balance(), which
needs to be fixed as well.

I or Josh can make a better patch for this after Peter's comments.

Thanks,
-Aubrey
