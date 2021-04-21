Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF9E366DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhDUOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbhDUOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:09:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF60C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:08:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so42172428iot.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1mA+bXgMyEnqSc8k5VDUxU2oNU/RLd1zwL6lAl3pUs=;
        b=Ecvgf6QOWXhpql5sQ06Tb01lKwQHpKDgjBv6g74QnS9/yfponh28l9ibY3hUVYpxM6
         A3lsEIqkk0soZNl444tuBLa1T8sbfggeE7yrlHrPXWX2TrKEitBGDbztvqTmkKAkQ8zu
         0VKiL3n/SBR6YU+NH9mN+HqZ0uYcvchmYkk0YEeeNFw/a/ZWYc3bW9rjyLwIjL4LYuF7
         py2b52kTyvU/rnIgi8z4WnQ8E8MJiAKj5rfLcnLwkpSolBpKgvWt4vqhg/auFyX2USLQ
         MADtTErvDu8IUmx/hwPRBoIuWIC8sSrn6M9r0DoBR90xDxvMZveeSzInliOHPXjy2oho
         EnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1mA+bXgMyEnqSc8k5VDUxU2oNU/RLd1zwL6lAl3pUs=;
        b=e3UJGbNH9leLA5XaU1kMsCSpKPg77gZLWmhqzR7aTYboQ4TGhaLD2NujIQtOld7lOh
         zGDlOhUiL7vDO5utw9nATGNhv58tLjdPB1BUiqXNI0CAumXrGDvcwc2/AnJbTa4HUCPh
         L+18sA5mZEV4fE1f6IZ59c80S6hKEzWxPptRtwmHDQyqYN4hojRULFh8ed4ew+/aBEA9
         vr9+ETWCIQtuG4ktvjBeA1EDFxoPMfc8XDsHtNKhY2XePAi9rSK6eOhJG3xJ/3kIYhcz
         70hH3z/ZFqtvwImc+pz7qWvFCL5ozUV3IPkurIYGBUYTTfXZgekDmAtzV1dhJ2PWYKT5
         KltA==
X-Gm-Message-State: AOAM533bzIxZ53NQ9hYbA6eFAJCYP1Uz72twmsIcL1btRKCL7BVXhwnT
        YrYI456TnWe5d6hmp8RKWd+mkhk5KDneecraRRMD/Q==
X-Google-Smtp-Source: ABdhPJwJpPv9j37+hi4F3tGlbqa7selR5RrQee/T40hK2bnb85oifvozkgf99HuZSMABBVcwXhuKmyc97oiw5Z0ekzI=
X-Received: by 2002:a02:918d:: with SMTP id p13mr26420892jag.51.1619014111274;
 Wed, 21 Apr 2021 07:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
 <87eef5qbrx.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87eef5qbrx.ffs@nanos.tec.linutronix.de>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Wed, 21 Apr 2021 23:08:19 +0900
Message-ID: <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>   1) hrtimer is contrary to timer_list not really suited for high
>      frequency start/cancel/start/... cycles of a timer. It's optimized
>      for the start and expire precisely case.

Ack. This is not what the f_ncm gadget code needs. It just needs a
timer to fire "about 300us after the last packet submitted". Under
load the timer will almost never fire since there will always be
another packet coming. So the speed of adding/updating the timer is
much more important than the accuracy. We will try to move it to
timer_list.

>      I assume that's an ARM64 system. ARM64 CPUs have an architected per
>      CPU timer where the reprogramming is pretty fast as it's next to
>      the CPU, but who knows what your system is using.

This system appears to be using timer hardware that is... slow to
program (microseconds). We're looking at whether it's possible to use
the arch timer instead.

> Now in the meantime I looked into __hrtimer_start_range_ns() whether
> that double reprogram can be avoided without creating a total trainwreck
> and imposing penalty on all sensible use cases. Completely untested
> patch below should do the trick and it's not ugly enough that I hate it
> with a passion.

I tested this and in my simple benchmark, the double calls are gone
and hrtimer_start calls tick_program_event approximately once (more
precisely, 90.06% of the time; sometimes it doesn't call it at all).
This is not enough to cancel the regression we're seeing because the
previous code would pretty much never call tick_program_event at all.
But it's definitely better.
