Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAA36D16C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 06:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhD1EuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 00:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhD1EuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 00:50:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA46C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:49:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z25so23168158qtn.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6kmrNF9udEXSxesCkSapcMJ7JhEAtkqSYssV2y3Ckw=;
        b=pUVYaauGLuf8JDa34aZdIwoATTdicbQcB2C/pUcrNtjwujuZ7YsMLIsb2GfhNvFASs
         HI3SipJumPzcw26Kpl1djxBE9ivqvVe0rywZF/Rhg8szejGnZ6xhAy45BnqQKXXvWx/x
         rCiFZBWOhkdeuJKxOgU8MChKy8nkTvTVrUvD0J+cwjTHYgmGutEoicHbKEg6Ir4JCEd0
         lC3cWD40NwldI1824rQhBDnjxuZYnGa4oJeewFbFgewYf9A3FOJ+c5qj1qsDR8dsRoI9
         wXvrxCUtiy5UxlbuUk/ekLvBdTyohrnMds4GutJ/LdPNfhO08Feo+hD7ETGCBrY/gz2N
         7sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6kmrNF9udEXSxesCkSapcMJ7JhEAtkqSYssV2y3Ckw=;
        b=Wa8dEIHKOCyPQrIorNj9Wv1gHU1q9BBdN6xuzfCX1imYTrNnd260daESSfSkf+JhkF
         0NRM/pCIRo2M7RIHboTQCyR4BTJFtQOQd7dllGwOwc0c3HAepuURtmD/LXpUBmWjLXHc
         eTiM0n0bxva++gd0C5r4ESz5zupmtlbjUa80sjTZUbfC6YPEMoEDZtZkjGSMdBi/Nb3P
         vmC0KIUoXlbJHum90Re88wPAd7jqcPwRBUYmkSug51Cyx6h3HAMV8C+h1clkg8QjA6MS
         DaAoh0r/loTHefJlmSI0tf6vNgheMpIeXKgEkZHw275Ic4r34jPg0f4+QlSuqEwPqTHS
         U8PA==
X-Gm-Message-State: AOAM532MqviXpPN5CqWBA34sfEVTTE7WdMFrnXczuI+MvM1qP/voLWRA
        MWoOP1WVCIrBR6UERgBqHuP83+BuoAb+k0ZvES9kMmwZgC0=
X-Google-Smtp-Source: ABdhPJwcyyCtzn7vHK9D5Yv4kA31SBBHY/zxKoRRlqYrjMRMl1GM4HrfxRZHzz/c11BbE6N2uobU8ww2bfXNIRteT/k=
X-Received: by 2002:ac8:730c:: with SMTP id x12mr24602407qto.275.1619585366171;
 Tue, 27 Apr 2021 21:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org> <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1> <20210426160008.GY1401198@tassilo.jf.intel.com>
 <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1> <20210426175627.GZ1401198@tassilo.jf.intel.com>
 <20210426182433.GD975577@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210426182433.GD975577@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Wed, 28 Apr 2021 12:49:12 +0800
Message-ID: <CAJRGBZxgJuc2OJfvT_k3Xmk_qsxzm=xX5wm4NqeRo7vkTcZk6w@mail.gmail.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
To:     paulmck@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We 'd expect to see clock_source watchdog can avoid to do wrong thing
due to the injected delay or
in real life delay by doing tsc sync-re-check by applying the patch-set.
However , the noise is still cause wrong actions and the patch doesn't
defeat the injected's delay
please correct me if  I'm wrong.

parameters]# cat *
1
1
-1
3
8

[62939.809615] clocksource: clocksource_watchdog_inject_delay():
Injecting delay.
[62939.816867] clocksource: clocksource_watchdog_inject_delay():
Injecting delay.
[62939.824094] clocksource: clocksource_watchdog_inject_delay():
Injecting delay.
[62939.831314] clocksource: clocksource_watchdog_inject_delay():
Injecting delay.
[62939.838536] clocksource: timekeeping watchdog on CPU26: hpet
read-back delay of 7220833ns, attempt 4, marking unstable
[62939.849230] tsc: Marking TSC unstable due to clocksource watchdog
[62939.855340] TSC found unstable after boot, most likely due to
broken BIOS. Use 'tsc=unstable'.
[62939.863972] sched_clock: Marking unstable (62943398530130,
-3543150114)<-(62941186607503, -1331276112)
[62939.875104] clocksource: Checking clocksource tsc synchronization
from CPU 123 to CPUs 0,6,26,62,78,97-98,137.
[62939.886518] clocksource: Switched to clocksource hpet

On Tue, Apr 27, 2021 at 2:27 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 10:56:27AM -0700, Andi Kleen wrote:
> > > ------------------------------------------------------------------------
> > >
> > > - module parameters
> > >
> > >   If the scope of the fault injection capability is limited to a
> > >   single kernel module, it is better to provide module parameters to
> > >   configure the fault attributes.
> > >
> > > ------------------------------------------------------------------------
> > >
> > > And in this case, the fault injection capability is in fact limited to
> > > kernel/clocksource.c.
> >
> >
> > I disagree with this recommendation because it prevents fuzzer coverage.
> >
> > Much better to have an uniform interface that can be automatically
> > explored.
>
> The permissions for these module parameters is 0644, so there is no
> reason why the fuzzers cannot use them via sysfs.
>
>                                                         Thanx, Paul
