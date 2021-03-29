Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9347C34D26C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhC2Ocr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhC2Ocb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:32:31 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF7C061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:32:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso12458266otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pd5+1lyxF0IpfUFm+C/Q0BotbJ7mj/8xSGsdykFryU=;
        b=WOGPfNiBH1rBOn7rKEj2te7OWuckEUpvJ+NQWbuqa1LLPtC8ni5+XceiDdRhii9Ezo
         M3ZPxxLkR1FXKmahCW23aHCLAWw+1OTM6ecK7JG1myf3fkFFkHbKy3NxP5RvTvpov7Y9
         EsByzRGNkr3bhxp3Sv7v6YCoNu0qTBw+quXgG6uVUGQ8KuWIX4x/qiDMmEaufKVIHUXm
         6yyKWYP37AglSKbupam4uq5h1Nmct7LqgHslu+LbupQAHibZM9OqxzCSknm9Ae0xDYpl
         o0BLDukK5niYeGEuiSDb/YFoa+1gQZhKm0HpxsyBbqblfmPZjrQumWmzZOKLO9gjRBmK
         Nx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pd5+1lyxF0IpfUFm+C/Q0BotbJ7mj/8xSGsdykFryU=;
        b=hMR1SYQqsOEQjUqRiF497J8ir08s0/yn73P/OuNibM819yUiD2S9Pt5EYRjAM9qT2Z
         1fsJ1Oy+eUt1zPlIY/Y2ZW9M/BI2LtqkpETXAne7idDC+r1yrfkKwknB1/hIlwLaeLAm
         ApBPn947dKJ6yQzJBrNCqQcuSRCXuRlLKZnLnYUH0hvC7OErrx79TDi48S8gPwdDnOJ2
         6nOxuc1WxF8zkHU2e4nA1ghPANdgd2XdmDXR1T00kEXg8k1k0flsJbLpQl0KKrEreUxS
         MWDaljRiomF2ijPAE644S+iccUvhwxLIjY9uYYYnQsdLW6bfLCwkldo0mjuDyFvf3T81
         FOow==
X-Gm-Message-State: AOAM531EWrq9SvzxADqZomVHIv+0UfqJVk016j4W9WZ+4lFMddb6HaVp
        /L2MQPCogwionrZv2ZEnFdXfTO4h78SW62pmVrY++w==
X-Google-Smtp-Source: ABdhPJxXlJbzmAzqT33taumiK8BdMN/OkVmDMWa6AP1XrX+5I2Yys/7Pp8HpnlAdCIy2hzJQig2Zesc70wVcHKDSdNI=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr23773028otq.251.1617028350375;
 Mon, 29 Mar 2021 07:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
 <20210329142705.GA24849@redhat.com>
In-Reply-To: <20210329142705.GA24849@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Mar 2021 16:32:18 +0200
Message-ID: <CANpmjNN4kiGiuSSm2g0empgKo3DW-UJ=eNDB6sv1bpypD13vqQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 at 16:27, Oleg Nesterov <oleg@redhat.com> wrote:
> On 03/29, Peter Zijlstra wrote:
> >
> > On Thu, Mar 25, 2021 at 09:14:39AM +0100, Marco Elver wrote:
> > > @@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
> > >  {
> > >     struct kernel_siginfo info;
> > >
> > > +   /*
> > > +    * This irq_work can race with an exiting task; bail out if sighand has
> > > +    * already been released in release_task().
> > > +    */
> > > +   if (!current->sighand)
> > > +           return;
>
> This is racy. If "current" has already passed exit_notify(), current->parent
> can do release_task() and destroy current->sighand right after the check.
>
> > Urgh.. I'm not entirely sure that check is correct, but I always forget
> > the rules with signal. It could be we ought to be testing PF_EXISTING
> > instead.
>
> Agreed, PF_EXISTING check makes more sense in any case, the exiting task
> can't receive the signal anyway.

Thanks for confirming. I'll switch to just checking PF_EXITING
(PF_EXISTING does not exist :-)).

Thanks,
-- Marco
