Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899AC3AD896
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhFSIVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhFSIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 04:21:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3652C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 01:19:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g20so19782892ejt.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRc8xB3XKUzZmnXENvfDZhA4RjfJ/L1HuMrF2BpojSA=;
        b=LGgwy3aprRR6LJOJe/aOQN/OikrDTz1G0hktXpso5P6TL4uzjBwuv6mnJPqmMzIGqJ
         7US3tkOJp1KyjJGcwx2OHDr3DB2w17N0wr40hOG83OQlSnvALlKhNLq5HReBnvvG3GiF
         fICqhLZsFqiUBANbJjnFyE7wKJmB7Z6MPvgfCp0U/Pkb4pea16s0lkVXu1J4UO+CXJQg
         dMGT5VI301uOGS5C4lbJlRcQMWzBhuEDicZTbbgY+E37E3qqREEe3To4JP8VDmJlmhcQ
         lcb7ceNpPRW9LCRmnjgqAHmvvxAoDQ8zv8XZBq0pBtSBoy35HLSAUObdorGL2Vk//tUZ
         DMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRc8xB3XKUzZmnXENvfDZhA4RjfJ/L1HuMrF2BpojSA=;
        b=fMen8/0rciBkAwfGCPkVHTRbddlPwSypItE1zvfvDDCDyR3w43ZRS5Bw6cbvu9TzGW
         ocCri0kfUYQCI/Ak9WA7sgyk/ZMlmnPVnJndMY5rTlW8VUjXknAhZNyPdZtO+quiLJBr
         d3KrV45lIepTHpYmzGCko+j9SDxwwCTUWJH1eb9zPC9bos/W8+x8+Ho2DESLUpoz/YGa
         Znvi6euPe4hbJy5a/tn5SN4/dEXeppilsdSQGkJt2PCdrcCrJArZ6zdpFqgEYny/HNqU
         KpexG6wq7muJqj27cyUWf5zJeoLd+IPRmxA8ywe94jOgtS1VQStBE1aJQoVh25Es/itR
         VPvg==
X-Gm-Message-State: AOAM530kVeiM2fvgkArK1/VSzfaVTTvIFSQxQ2DLvDcQFhF8+EmpFVpl
        8r2dvshogNEjoZSnjvlm9kcSqnIq45HSj9NaLiXGxA==
X-Google-Smtp-Source: ABdhPJzp2NwMXmgPECmRBFMougXKIgALuQsg4izrJswtPbwxt+PGROAQKto3Mqg3veeWYn5FjPr1RvaRBxy3Nj0nMWk=
X-Received: by 2002:a17:906:6d16:: with SMTP id m22mr5131130ejr.333.1624090747368;
 Sat, 19 Jun 2021 01:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210611103937.827565-1-ani@anisinha.ca> <878s36e0yx.ffs@nanos.tec.linutronix.de>
In-Reply-To: <878s36e0yx.ffs@nanos.tec.linutronix.de>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Sat, 19 Jun 2021 13:48:56 +0530
Message-ID: <CAARzgwy=LY_LfLgsk+KCxr7VxXAzv=FpUMxpW=UNPGWd20X86g@mail.gmail.com>
Subject: Re: [PATCH] Add missing kernel log when enabling NO_HZ_FULL is not possible
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, anirban.sinha@nokia.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2021 at 1:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ani,
>
> On Fri, Jun 11 2021 at 16:09, Ani Sinha wrote:
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 828b091501ca..a82480c036e2 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -937,10 +937,18 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
> >       if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
> >               return;
> >
> > -     if (can_stop_full_tick(cpu, ts))
> > +     if (can_stop_full_tick(cpu, ts)) {
> >               tick_nohz_stop_sched_tick(ts, cpu);
> > -     else if (ts->tick_stopped)
> > -             tick_nohz_restart_sched_tick(ts, ktime_get());
> > +     } else {
> > +             /*
> > +              * Don't allow the user to think they can get
> > +              * full NO_HZ with this machine.
> > +              */
> > +             WARN_ONCE(tick_nohz_full_running,
> > +                       "NO_HZ_FULL will not work with current sched clock");
>
> How is that warning useful and even remotely correct?
>
> can_stop_full_tick() has 4 x 5 == 20 ways to return false and the
> smaller portion of them is related to sched clock.


Ok I admit I don't fully understand all the sched dep bits. There are
two ways we can solve this. Either we adjust the log message to
reflect that no hz cannot be enabled on this system in general or we
can specifically isolate the conditions that check for sched clock and
for those we add the warning message. Personally, I think we need some
kind of information on the kernel log when no hz enabling is not
possible. Silently disabling it can and did cause confusion that no hz
works fine ( particularly when the older kernel did produce the
warning). I am inclined towards keeping the log where it is but making
it more general and not specific to sched clock.

Ani
