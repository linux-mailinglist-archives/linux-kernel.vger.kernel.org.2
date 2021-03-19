Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5F342167
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhCSP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:58:35 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:37553 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhCSP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:58:22 -0400
Received: by mail-lj1-f172.google.com with SMTP id r20so12610417ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cFU+mq+hQfxytugsIHjZGcBMJB6tJrIkc4/KKvWSLg=;
        b=BOgF1I6t9WyWXkJuVHLtiiBmWk6jKFWABQc94bF3r5VsEMVuJgGVpt7flN2f3iotCK
         jSpm0aQLalZumRdTj0whA4naLSlaggSTzE38tzTkmooy4fX9KYn1aQif+KwimPZ50S5Q
         10LYwPC5SJ9Zq7o7N1pevanjGRr/DG4/4nrcxCz6DhlwbTiPrap8Vch+ulVA5Pkgk0fT
         P426FLYst7sfPSGI7r6MQhfl/byc9oKhtlLGa2WWfxcOxnUClX+ZQ2w76wIggwU90pCM
         909HrSsGY9CsOggUteZOrjGpTau84N4FDVqSnf8rYEtehJy9U+5l28XCGD6TAm7RqDSi
         120g==
X-Gm-Message-State: AOAM530PqcKxbM2usikWgDNQoung7it5mu2VPdYpwKKwDWDHhbVziAnN
        kwztdrCmUjXhoIg1JzywO0qzcPXa5IS8i38ariw=
X-Google-Smtp-Source: ABdhPJyzV+YA+8TmoZ4HRynYvB9GFyDyq+KHF08KWOvLqItRX9yDl12cMIquSkD29/CUoIbesh4uRVcLP8ozekwKb1U=
X-Received: by 2002:a05:651c:1055:: with SMTP id x21mr1283530ljm.275.1616169501522;
 Fri, 19 Mar 2021 08:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org> <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava> <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
 <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com> <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
 <YFTEsOhbx4Il1nji@kernel.org>
In-Reply-To: <YFTEsOhbx4Il1nji@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 20 Mar 2021 00:58:10 +0900
Message-ID: <CAM9d7cgoP28V_ONk2AJeu=Y7RQ8vzovzW=pGVYtERe97+ZH0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Sat, Mar 20, 2021 at 12:35 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Mar 19, 2021 at 09:54:59AM +0900, Namhyung Kim escreveu:
> > On Fri, Mar 19, 2021 at 9:22 AM Song Liu <songliubraving@fb.com> wrote:
> > > > On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
> > > > On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> > > >> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
> > > >>> perf stat -C 1,3,5                  107.063 [sec]
> > > >>> perf stat -C 1,3,5 --bpf-counters   106.406 [sec]
>
> > > >> I can't see why it's actualy faster than normal perf ;-)
> > > >> would be worth to find out
>
> > > > Isn't this all about contended cases?
>
> > > Yeah, the normal perf is doing time multiplexing; while --bpf-counters
> > > doesn't need it.
>
> > Yep, so for uncontended cases, normal perf should be the same as the
> > baseline (faster than the bperf).  But for contended cases, the bperf
> > works faster.
>
> The difference should be small enough that for people that use this in a
> machine where contention happens most of the time, setting a
> ~/.perfconfig to use it by default should be advantageous, i.e. no need
> to use --bpf-counters on the command line all the time.
>
> So, Namhyung, can I take that as an Acked-by or a Reviewed-by? I'll take
> a look again now but I want to have this merged on perf/core so that I
> can work on a new BPF SKEL to use this:

I have a concern for the per cpu target, but it can be done later, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.bpf/bpf_perf_enable

Interesting!  Actually I was thinking about the similar too. :)

Thanks,
Namhyung
