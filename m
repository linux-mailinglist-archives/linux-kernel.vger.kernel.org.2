Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2338C185
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhEUIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhEUIRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:17:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA419C061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:15:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r12so20137741wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zT8e7kYg29cZEuKphVTHl2YAXUXxdO63nOwX3vqV14Y=;
        b=EVReti+ELiL60IzYNerOImeZoNrTo83zejaiKbh35740R15r3ck28CuPj/O/Iwe2wO
         ZiC1bwucPd/WNnTvpho3Us6X5BZzayEU59+S5QTZWuf0abCU1HO9gFsmdOBaFiJiddK0
         4Bq33NVWEXFRAuh7E2azfiWZE4tU2HzwmvFDhfDInI+znqAK4dsbmtfiVL549fVvoNxJ
         5UE5jCQhOCkcejAR+thHZ/8rC8EqEA52MMktCRR4xNtMNjp7tfPiFTj/MhqKyS+xkxlL
         eCx42D0f+ifqe+avdh8Df7FN/u9YxLO5habZhFEWD+CY3SJy0oyXP7ZsPk/ZoyWB5wL6
         Vauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zT8e7kYg29cZEuKphVTHl2YAXUXxdO63nOwX3vqV14Y=;
        b=J229NFMWKEz+2Igkk2sqP1Z2T9wT1+tyewGBoKcbNbsHkLAOGmOiPtdVh50Q5yO64n
         p7ViHMA1YAzQtH3aofiD73jKk13Q374m+LyBN2Bhcy6GdT+5CZS4urFB4ZHzW5hrET+R
         76tH77sGWYudbkofttLOy5PUnAivqUCf0O7yQe6iZiN7eg1OrmuzAjbGou9neKcim7lj
         TwbXk5ZgWfuR3lTp12CnmHdXK2ISuzOVZ2YgmJYL1cO4zojBLU1XNchlKAwaMJMQDE5m
         kUmZ/EofWqzwd0BqxNugHQ0rd2LqWeuzeDpopooK5+XO5wXXDJqndB++N6yH1vjh9dbb
         tUwA==
X-Gm-Message-State: AOAM533Ky7TVfM1MDqjQPMQ0XRsYnyrmr8V2Khl7gXIwHJChfy3YIVek
        g9hEosg3JwawKone+ORNPDkbgA==
X-Google-Smtp-Source: ABdhPJyaHV6Z9gNyiik1g5x3E8QnahnNsRAei/IuEo3VgJ8sjRloFFLXTBxaK8sGkYW9DAmQ/tNLXw==
X-Received: by 2002:adf:fc4a:: with SMTP id e10mr7956183wrs.375.1621584955270;
        Fri, 21 May 2021 01:15:55 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id t16sm1261347wrb.66.2021.05.21.01.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:15:54 -0700 (PDT)
Date:   Fri, 21 May 2021 08:15:52 +0000
From:   Quentin Perret <qperret@google.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into
 SCHED_DEADLINE
Message-ID: <YKdsOBCjASzFSzLm@google.com>
References: <20210518102833.GA7770@willie-the-truck>
 <YKObZ1GcfVIVWRWt@google.com>
 <20210518105951.GC7770@willie-the-truck>
 <YKO+9lPLQLPm4Nwt@google.com>
 <YKYoQ0ezahSC/RAg@localhost.localdomain>
 <20210520101640.GA10065@willie-the-truck>
 <YKY7FvFeRlXVjcaA@google.com>
 <f9d1a138-3150-d404-7cd5-ddf72e93837b@redhat.com>
 <20210520180138.GA10523@willie-the-truck>
 <YKdEX9uaQXy8g/S/@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKdEX9uaQXy8g/S/@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2021 at 07:25:51 (+0200), Juri Lelli wrote:
> On 20/05/21 19:01, Will Deacon wrote:
> > On Thu, May 20, 2021 at 02:38:55PM +0200, Daniel Bristot de Oliveira wrote:
> > > On 5/20/21 12:33 PM, Quentin Perret wrote:
> > > > On Thursday 20 May 2021 at 11:16:41 (+0100), Will Deacon wrote:
> > > >> Ok, thanks for the insight. In which case, I'll go with what we discussed:
> > > >> require admission control to be disabled for sched_setattr() but allow
> > > >> execve() to a 32-bit task from a 64-bit deadline task with a warning (this
> > > >> is probably similar to CPU hotplug?).
> > > > 
> > > > Still not sure that we can let execve go through ... It will break AC
> > > > all the same, so it should probably fail as well if AC is on IMO
> > > > 
> > > 
> > > If the cpumask of the 32-bit task is != of the 64-bit task that is executing it,
> > > the admission control needs to be re-executed, and it could fail. So I see this
> > > operation equivalent to sched_setaffinity(). This will likely be true for future
> > > schedulers that will allow arbitrary affinities (AC should run on affinity
> > > change, and could fail).
> > > 
> > > I would vote with Juri: "I'd go with fail hard if AC is on, let it
> > > pass if AC is off (supposedly the user knows what to do)," (also hope nobody
> > > complains until we add better support for affinity, and use this as a motivation
> > > to get back on this front).
> > 
> > I can have a go at implementing it, but I don't think it's a great solution
> > and here's why:
> > 
> > Failing an execve() is _very_ likely to be fatal to the application. It's
> > also very likely that the task calling execve() doesn't know whether the
> > program it's trying to execute is 32-bit or not. Consequently, if we go
> > with failing execve() then all that will happen is that people will disable
> > admission control altogether.

Right, but only on these dumb 32bit asymmetric systems, and only if we
care about running 32bits deadline tasks -- which I seriously doubt for
the Android use-case.

Note that running deadline tasks is also a privileged operation, it
can't be done by random apps.

> > That has a negative impact on "pure" 64-bit
> > applications and so I think we end up with the tail wagging the dog because
> > admission control will be disabled for everybody just because there is a
> > handful of 32-bit programs which may get executed. I understand that it
> > also means that RT throttling would be disabled.
> 
> Completely understand your perplexity. But how can the kernel still give
> guarantees to "pure" 64-bit applications if there are 32-bit
> applications around that essentially broke admission control when they
> were restricted to a subset of cores?
> 
> > Allowing the execve() to continue with a warning is very similar to the
> > case in which all the 64-bit CPUs are hot-unplugged at the point of
> > execve(), and this is much closer to the illusion that this patch series
> > intends to provide.
> 
> So, for hotplug we currently have a check that would make hotplug
> operations fail if removing a CPU would mean not enough bandwidth to run
> the currently admitted set of DEADLINE tasks.

Aha, wasn't aware. Any pointers to that check for my education?

> > So, personally speaking, I would prefer the behaviour where we refuse to
> > admit 32-bit tasks vioa sched_set_attr() if the root domain contains
> > 64-bit CPUs, but we _don't_ fail execve() of a 32-bit program from a
> > 64-bit deadline task.
> 
> OK, this is interesting and I guess a very valid alternative. That would
> force users to create exclusive domains for 32-bit tasks, right?

FWIW this is not practical at all for our use-cases, the implications of
splitting the system in independent root-domains are way too important
for us to be able to recommend that. Disabling AC, OTOH, sounds simple
enough. The RT throttling part is the only 'worrying' part, but even
that may not be the end of the world.

Thanks!
Quentin
