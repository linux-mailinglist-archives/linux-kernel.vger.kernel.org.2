Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E73A7D37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFOLeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhFOLeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:34:15 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC15C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:32:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i12so5583795ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t45Hc0O9NaQxxbL38MjJg2JzYz6L4EbKuDBx3en7Fbk=;
        b=GsIieD6J6Hw+JIqfGoJmNTpao3TX2EgmU7sLqZTe4pinGm1odndgOdkWjUbu5y91a9
         sOVzfoIu7IXMWjD9wgc36mB7S9oa3RjCADHc3l1DcMfcxc4oaipGM/efRr8Ec84hc6dS
         ZIoyvw9Sm/4X5u09dhiwHq+5gARs9d4sCY5I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t45Hc0O9NaQxxbL38MjJg2JzYz6L4EbKuDBx3en7Fbk=;
        b=hOrZv9OGMI4R9dPaUJbPbUlZnf7ySzFGLsuUviiEcuYvB5ieLWH2ylDoCMiA1SX310
         TsV/joXkcmImj4Hohly5lvOeQ80oif1SXJP8DpahiEIsn7VU73ngfY+le4+uowJeP+WQ
         Sxk9GVsoD3kYCgcIfbsnZBl41AwlifcRHOItqE4NHarEeLYl8mGpfLBAlcr2vjeJhZTo
         gYNF6u08PC2UsOn+wDo//FwP31MhfFkL7o1zDCuOqVtKeOZBF1tpt7CqcovYqHHbk26N
         fZ2O2EOXHZRMdbndoejoyev9vMyVZY9jSY2oy/y6ZZjcM34g7MifUj05S9WOR+SsAQmE
         5/Fw==
X-Gm-Message-State: AOAM533BvMKjWqNsx+77AOZi/JbIZe3YdtUJsJPNqR6bhH76Cj3M78zj
        Nb3120VhE6yGAtP0Ry6arTivYXkhMsuhWVNNjh0tSw==
X-Google-Smtp-Source: ABdhPJwxVpBnk920TRAbXnR383cXKoJB9bz8tSvrgk7c3Hzyr5me0Pw36U9Hx3zzk64YttigT3mN2el8XWFgNRsgYKg=
X-Received: by 2002:a92:4a02:: with SMTP id m2mr16918443ilf.171.1623756730794;
 Tue, 15 Jun 2021 04:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123309.039845339@infradead.org>
 <CABk29NtA4UxM-XqJ0v+5UOZEfgHTozF5VeqVGpLcR3Ci4z806g@mail.gmail.com>
In-Reply-To: <CABk29NtA4UxM-XqJ0v+5UOZEfgHTozF5VeqVGpLcR3Ci4z806g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 15 Jun 2021 07:31:59 -0400
Message-ID: <CAEXW_YTMGvTEjHmC4pbdNTt99J545htb4cnkNbBcMY1jSe_24A@mail.gmail.com>
Subject: Re: [PATCH 18/19] sched: prctl() core-scheduling interface
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Xiangling Kong <xiangling@google.com>,
        Benjamin Segall <bsegall@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 7:36 PM Josh Don <joshdon@google.com> wrote:
>
> On Thu, Apr 22, 2021 at 5:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > From: Chris Hyser <chris.hyser@oracle.com>
> >
> > This patch provides support for setting and copying core scheduling
> > 'task cookies' between threads (PID), processes (TGID), and process
> > groups (PGID).
>
> [snip]
>
> Internally, we have lots of trusted processes that don't have a
> security need for coresched cookies. However, these processes could
> still decide to create cookies for themselves, which will degrade
> machine capacity and performance for other jobs on the machine.
>
> Any thoughts on whether it would be desirable to have the ability to
> restrict use of SCHED_CORE_CREATE? Perhaps a new SCHED_CORE capability
> would be appropriate?

Hi,
Maybe a capability may not work because then other users who don't
care for the issue you mention will be required to manage/assign the
capability as well?

How about you use seccomp to filter the prctl based on the PID, and
CREATE command?

-Joel
