Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4E73BE662
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGGKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhGGKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:35:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F56C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:32:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z9so2087274ljm.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wcak1Ofe83x621el2UdGBAdUl4Gwiq6BpwH465FUa/Q=;
        b=Y1qc5v5k67GQNdZB1sTiF7YHlYMBYpG/38vj5qm50DsU/b/FucLbo42Gv/QRHwGk4X
         0931LHtXjhC95nZrs4IzuF3qbHRY9NYqfTd7aMMKUMU7vHyqhXTfFeMOMdDcGQVSyxO5
         99J8eCiw5ZQ1/bx629RAszYcQ8iywZgns6J2Y7zn5Gh9q2HmdgNrUoPLaBp5ZQWxEEGs
         bDU2ffuWf3PxjZVEgwW10lxMMBChGTgSpnth64FwsLC2qclBwYbolQO98Omveqe7rOv4
         CXo1FJWvkI0UuEIbbWLaxJ5ktB4MZcwQCvYC4Udq5Zuml5020M+f5kJyDX5mbwMrPbc8
         jpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wcak1Ofe83x621el2UdGBAdUl4Gwiq6BpwH465FUa/Q=;
        b=lHq1uZJBeUgc5lmvXWZYOGLo78jf/dyt6m8m8tS1ZuKKrGWa2khFy7tXjNK0qLEnf7
         ipD7fjhB+DhbrsC70pENJdGUvB3YMfxqIY1CPqXArjsraZHm+cK3GlIa9G3QqyzbWaJ/
         phfyokoTWSkQZQibM8rheq+9nF6jlZQ06XULLPzOi3bJE5np5qCjobPy/IX/kpiedXC+
         roYx4O2mppPedQ9Db4sTsxCRoSlWEhsCaUisveyAGUe+yFPhLHwopCfrErboYwNaOLKl
         1xc3ya4Abd3diS0u0dknjNnhnb7MB1oL2Rcfm6w+tUmclM1jbdIyIRlR65P1cP7p7Ojb
         Kd1A==
X-Gm-Message-State: AOAM5327EzrTPEFV36TJ/dyqrass75tq0kkVbF+3i/If2MtClUFg0k8S
        hIb/hCJFTbCntPjNUPBbalW928GQ6A30e3rJFmK5DNXOOGM=
X-Google-Smtp-Source: ABdhPJyoGPaTT4NqVW7oko9qqSadcXDgrjhAb6CjaJY5L2LLlSJq4CCRMT8Am0i8tG6L0QTEE9k+/7shY9ecU/LKLW4=
X-Received: by 2002:a2e:8941:: with SMTP id b1mr19154447ljk.284.1625653971625;
 Wed, 07 Jul 2021 03:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com> <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com> <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com> <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
 <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com>
In-Reply-To: <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 12:32:40 +0200
Message-ID: <CAKfTPtAN6-ytxa2Qj3=z27e8ZBoqGrWAZce9CojL3wbZSotUsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 at 12:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 11:11 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
>
> [snip]
>
> >> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts
> >
> > Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
> > I'm not even sure that the power model can even reach an accuracy of
> > 1mW
> >
>
> True, the EM is registering platform with 1mW precision, but 1uW

Do you mean 1uW or 0.1uW ?

> precision makes more sense for internal EAS calculation. I don't
> force platforms to report 1uW power, I just want to operate on
> it internally. PowerCap and DTPM also operate internally on 1uW,
> so it's not that unrealistic that some kernel components want
> better resolution.
>
> But as Peter suggested, we might skip 32bit platforms for this issue.
> I have to discussed this internally.
