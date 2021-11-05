Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F70446B1B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhKEXIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhKEXId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 19:08:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C674FC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 16:05:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id x23so3470046qkf.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoJ+FmSfSJVPeg55SPs5H9Cad5OF+xCMwp+gslZjZ0Y=;
        b=NCrbdZpmxI6P3Ycc8UTDZyEl8KcoG6yiqYRNXnwYz8CQCaOixoMni5S4iS0/0LWpXU
         j2xTI6tV9vqFf0kl5hyWGCA2kFJPwdGnWBIoA9sdbOYlwMS25l9Z/xoKeSUxbd+Js7kU
         LcL7cuoRiO/sYMkgvjE7UmqMOLtSW/CNxMuv7NiqQODpi+IiMdkyBT1UKsmcktGBLL4S
         TbPYsZE3MTTq51YaH0i/OENdKxM2lx26s6ZRXukUy9qvJvuPSpPtcu9vnTg4OasOUjFk
         RGNCZk9MPZVrenhzza6p3s8Q00tUtVEZ/3vm7wzmtk35KdJJqoLGwA3Lj1KAaGpjeMr7
         X+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoJ+FmSfSJVPeg55SPs5H9Cad5OF+xCMwp+gslZjZ0Y=;
        b=BLURTAyTVhyRCvCv1jD0ct6Tc7lGn/6i0xfBf9+3R/QGHAvsBLURCd68l2wbu2Jypu
         9oXaNjkdr9kHBXW0YkAp7Np4lTfREcVy+XGor/Lweil9DVu1XdDTsJS8GLqbM1fJE8Cf
         XCGuv+1t9cG4a04qusjUhQjBRDp/K5e3i+CQfT8BvZ9lHuKdY5rfnybeg0cuLUgEaNaf
         Yqz9evOJd75cnZDCwdi9/csL7HzeeTPw/eKvBBQj/klHek4bnr1/FbMZQ818LuOk2M0v
         vz3dVrfo8orU0yraWpIEq2988TTVxkNovK9/f1DK5PJ9S7bAhpKyi7Dj6BFIRZpvrJZy
         Zx5g==
X-Gm-Message-State: AOAM530lUACD+ry9g/QrhJHMLaxkt/V3NHeZnfDpf7C1ADebqZ87Y6nZ
        Nd+Z+f9RnxScFCctLEw/vW2vTvx8tTDMpTaZTXFz3Q==
X-Google-Smtp-Source: ABdhPJzDu6aeT1YkR0lQHu5xDuwafU6AaOMbWA18O+ozz2p3OOcq25NZhR53bDGAmd9GT8gbwhJmxamH7HPmYQ9mdd8=
X-Received: by 2002:a05:620a:454f:: with SMTP id u15mr49248563qkp.144.1636153552807;
 Fri, 05 Nov 2021 16:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
 <CAJWu+orNotdFUe0Bc9ooP+1nzajd=7A9WiSWXwtrsLkWi8gFAg@mail.gmail.com>
In-Reply-To: <CAJWu+orNotdFUe0Bc9ooP+1nzajd=7A9WiSWXwtrsLkWi8gFAg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 5 Nov 2021 19:05:41 -0400
Message-ID: <CAJWu+oocnt-yF=R=XxNvjj14hwV8hAewz-696DcAzGdr5ys2sQ@mail.gmail.com>
Subject: Re: RT_GROUP_SCHED throttling blocks unthrottled RT tasks?
To:     Doug Anderson <dianders@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 7:04 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Fri, Nov 5, 2021 at 1:44 PM Doug Anderson <dianders@chromium.org> wrote:
> [..]
> >
> >
> > I tried gathering some tracing. One bit that might (?) be relevant:
> >
> >  cros_ec_spi_hig-179     [000] d.h5  1495.305919: sched_waking:
> > comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
> >  cros_ec_spi_hig-179     [000] d.h6  1495.305926: sched_wakeup:
> > comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
> >           <idle>-0       [001] d.H5  1495.309113: sched_waking:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >           <idle>-0       [001] d.H6  1495.309119: sched_wakeup:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >  cros_ec_spi_hig-179     [000] d.h5  1495.309336: sched_waking:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >  cros_ec_spi_hig-179     [000] d.h6  1495.309341: sched_wakeup:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >           <idle>-0       [001] d.H5  1495.312137: sched_waking:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >           <idle>-0       [001] d.H6  1495.312142: sched_wakeup:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >  cros_ec_spi_hig-179     [000] d.h5  1495.312859: sched_waking:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >  cros_ec_spi_hig-179     [000] d.h6  1495.312870: sched_wakeup:
> > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> >
> > My best guess is that there's some bug in the scheduler where it just
> > loops constantly picking an unthrottled RT task but then incorrectly
> > decides that it's throttled and thus doesn't run it.
>
> Thanks for posting this. Tricky bit indeed. I was wondering if the
> issue is here:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/rt.c#L1031

Errm, I meant Line 1060 in rt.c
https://elixir.bootlin.com/linux/latest/source/kernel/sched/rt.c#L1060
