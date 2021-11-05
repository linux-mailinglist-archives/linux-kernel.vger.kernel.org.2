Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3097A446B20
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhKEXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 19:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhKEXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 19:13:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFDC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 16:10:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h14so8618346qtb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01prNQfOshQwAraB0gPQr6QCA+e8lskhGHoqy/4slkU=;
        b=jrHZlWSn2gXjjjH9/9iLLT0idaUdpkyj4K9Tr8G4+/nKwy2tSmWgfJ7EOMF6NpMrXj
         UZuoVBHbSjl3LrrC9cE78Lmlw4OBEpnnP/+FWFMfGSgPjGcyS1VnMYA2P6O2B6jA9ig5
         zVCKLMrdHUXYIpBT61IEFwON5dPIlJURQWbpySteIeAHqV4oVKqCjBwcIp9RJ0ITfOzc
         MnnfgYIO7oacyxf4ubhGjyDl214EAGPgw7fpNvCAdUTgXxzbiV23fnMroWfPjs/b6lKY
         JsHkc/g7us8iS0qniAm0G1nVRSPJHiMjVyEyDfedq5QRx+2hsEGdkwF9/Sz2aOIpI8Cb
         tDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01prNQfOshQwAraB0gPQr6QCA+e8lskhGHoqy/4slkU=;
        b=grq3zJpnkdJz/gKnpxjrho1xkNpuuZVUTFeCQ/f2We1NB06p2Q8HmDQdXK68Jm9MzU
         eOjakl7QHDq4C9NtIlKWR9XxUJIQGl45DHpnJhWc0XzDW2d00PfoCmoEnwWSEF5ws3ZI
         tdWDMjjub5a2bEz+GQNH/Yu4CpycPO3o4r8IbfG0T9+J8HtzcaPnKixCUG8hCjsAGl7K
         ExTq6MskoGLm7vmgOdWMBw/BZUv7gTtup8qCdoZhpnd9d0AsDdcnQI1kzYN4QwCb9AyR
         18m8pk4D7Kndanm35Q/AGNc2GL/vjL3aIX51mzlAPRe9hRK24/cc07MbbyIAjgyz2oV2
         ehHg==
X-Gm-Message-State: AOAM530hkrfuki83nCClTblBALOF86vVwB9Fj6gJn742EMXrofhuNsxQ
        WtDLQqyEznRIg0lZH2T+3bfKJZcuN3KLhsKbJ+FJOA==
X-Google-Smtp-Source: ABdhPJwbXn2bWDBccj7jLS3vgk9oe57vWLQ4se9oPE4pFVQkjtIhcedCdVGY2mO1mgsmMPAA5GSqGbDnuaY9+oNWHKE=
X-Received: by 2002:a05:622a:1112:: with SMTP id e18mr14406447qty.127.1636153825025;
 Fri, 05 Nov 2021 16:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
 <CAJWu+orNotdFUe0Bc9ooP+1nzajd=7A9WiSWXwtrsLkWi8gFAg@mail.gmail.com> <CAJWu+oocnt-yF=R=XxNvjj14hwV8hAewz-696DcAzGdr5ys2sQ@mail.gmail.com>
In-Reply-To: <CAJWu+oocnt-yF=R=XxNvjj14hwV8hAewz-696DcAzGdr5ys2sQ@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 5 Nov 2021 19:10:13 -0400
Message-ID: <CAJWu+oqUC4V4QxryLXvG-GRS_Co=n+kMLeWJom4VR6OWCNE4=A@mail.gmail.com>
Subject: Re: RT_GROUP_SCHED throttling blocks unthrottled RT tasks?
To:     Doug Anderson <dianders@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 7:05 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Fri, Nov 5, 2021 at 7:04 PM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 1:44 PM Doug Anderson <dianders@chromium.org> wrote:
> > [..]
> > >
> > >
> > > I tried gathering some tracing. One bit that might (?) be relevant:
> > >
> > >  cros_ec_spi_hig-179     [000] d.h5  1495.305919: sched_waking:
> > > comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
> > >  cros_ec_spi_hig-179     [000] d.h6  1495.305926: sched_wakeup:
> > > comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
> > >           <idle>-0       [001] d.H5  1495.309113: sched_waking:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >           <idle>-0       [001] d.H6  1495.309119: sched_wakeup:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >  cros_ec_spi_hig-179     [000] d.h5  1495.309336: sched_waking:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >  cros_ec_spi_hig-179     [000] d.h6  1495.309341: sched_wakeup:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >           <idle>-0       [001] d.H5  1495.312137: sched_waking:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >           <idle>-0       [001] d.H6  1495.312142: sched_wakeup:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >  cros_ec_spi_hig-179     [000] d.h5  1495.312859: sched_waking:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >  cros_ec_spi_hig-179     [000] d.h6  1495.312870: sched_wakeup:
> > > comm=sugov:6 pid=2658 prio=-1 target_cpu=006
> > >
> > > My best guess is that there's some bug in the scheduler where it just
> > > loops constantly picking an unthrottled RT task but then incorrectly
> > > decides that it's throttled and thus doesn't run it.
> >
> > Thanks for posting this. Tricky bit indeed. I was wondering if the
> > issue is here:
> > https://elixir.bootlin.com/linux/latest/source/kernel/sched/rt.c#L1031
>
> Errm, I meant Line 1060 in rt.c
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/rt.c#L1060

AAARGH , I hate elixir. I meant this code in update_curr_rt() :

if (sched_rt_runtime_exceeded(rt_rq))
    resched_curr(rq);
