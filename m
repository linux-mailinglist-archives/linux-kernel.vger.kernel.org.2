Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3842E4B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhJNXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 19:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhJNXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 19:21:12 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A195C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:19:07 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n65so18387326ybb.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIDsF8OdOSsSMq3TShOJfG1E7T7gfTYbjddGetKWzcQ=;
        b=ZLhPQaoERE2TIqUe/eZDSGbpzchxYQfdrCizokkMYvieOR6+MNzui52vFKrylZDMbz
         +JqGI+GYmUpV2nrZU61KU7te6RFwpHeBEXvfXy1LNDCGXISVzsUcJ+WFtQ7579WV7VQy
         fp7ek6XVYWCXRgD5YPkGigY8spU6Pa/P/1r7UbME8MmbdzzWky3B/TVE1TQYSGJ2pJ7Q
         kfcDNxt02czia6yRzcpF6MeJ3ZrHOt1w/+FHtqYHGFVk/ltN0EjdtIebwKb6ouDYadmR
         lGkkrIw2KfVaDeu2UGGInkbLHLLfpse6Sro82y4+gOtnqurWL+ThNawUXfv/aqamdr4q
         pGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIDsF8OdOSsSMq3TShOJfG1E7T7gfTYbjddGetKWzcQ=;
        b=DgUguodOP1dK+zLuXBllQ/EZFU47RBA4pt6RX2tb7G4wQQyH0C3UDOicc1ucX+rElj
         GpTEmcDH07fbWa4Dcg1UwuqL/R46BxMew0L9fTbb0cy7Q6GsCY1Zxf6OnjLDdqcRY+0h
         y65Qt1HaC8uZqIdg2H8D6EXUuZb25HZ1Af5KHGRHQ4ZCLUbkRPHBn1zhaHls/swhkWbd
         zzUaVBDHqPmyP7ji+0JGlVXMgwEJMnhUNwQJfVJTcdEA72NKZePApvJkHR758IV729WV
         +fuDrj8VGfFD4WlyckpbFxtOSGDCYpV6b6t+pfMwwtM28pFnvevzkURguL5gEub7FcKT
         KQ8Q==
X-Gm-Message-State: AOAM533baEaf/uU3uiYgWVyvmYFnIPwwi52rjv1cPnv/VnIo0/bsCLOs
        vRQLdQ7SqiQkrLWCDEjexFoyS01IvrtNMaC74jtQxQ==
X-Google-Smtp-Source: ABdhPJyd/HDe4po5I86KAwzy80KWXo69khqftfSO5aPDKlDEw7VJ6UATdrgTw2X499Cw8QUZwd6bsSO3HNC++HkLbM8=
X-Received: by 2002:a25:a027:: with SMTP id x36mr9533901ybh.405.1634253545879;
 Thu, 14 Oct 2021 16:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000825.1364224-1-joshdon@google.com> <20211009155435.GW174703@worktop.programming.kicks-ass.net>
 <CABk29Nu6F4__ryF5p0En--Ze6CCev1Jy81W=LkTYaacf-YLkFg@mail.gmail.com>
 <YWV/HNDJaIAOLdrt@hirez.programming.kicks-ass.net> <CABk29NucE__6r3P64Ts3Nbf4sUy5Zkw1sbNNnab9KZ=68ydy=w@mail.gmail.com>
 <YWg9je0wEJsNAd3M@hirez.programming.kicks-ass.net>
In-Reply-To: <YWg9je0wEJsNAd3M@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 14 Oct 2021 16:18:54 -0700
Message-ID: <CABk29Nv-A3VAKTEzyAAcOjcjaBwjKr51UP72AMjxQYCEmrRd=A@mail.gmail.com>
Subject: Re: [PATCH] sched/core: forced idle accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 7:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 12, 2021 at 12:45:28PM -0700, Josh Don wrote:
> > On Tue, Oct 12, 2021 at 5:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > > We scale by the number of cpus actually forced idle, since we don't
> > > > want to falsely over or under charge forced idle time (defined
> > > > strictly as time where we have a runnable task but idle the cpu). The
> > > > more important scaling here though is the division over the number of
> > > > running entities. This is done so that the aggregate amount of forced
> > > > idle over some group of threads makes sense. Ie if we have a cpu with
> > > > SMT8, and a group of 7 threads sharing a cookie, we don't want to
> > > > accrue 7 units of forced idle time per unit time while the 8th SMT is
> > > > forced idle.
> > >
> > > So why not simply compute the strict per-cpu force-idle time and let
> > > userspace sort out the rest?
> >
> > Do you mean to compute force idle solely as a per-cpu value? I think
> > that would be fine in addition to the per-thread field, but a
> > desirable property here is proper attribution to the cause of the
> > force idle. That lets system management understand which jobs are the
> > most antagonistic from a coresched perspective, and is a signal
> > (albeit noisy, due to system state and load balancing decisions) for
> > scaling their capacity requirements.
>
> Urgh, reading is hard. I hadn't noticed you did per-task accounting (and
> the original changelog doesn't clarify this either).

Yea, I'll add that to the description, along with a few other
implementation details.

> Also, should all this be undef SCHED_DEBUG ? Or be part of SCHEDSTATS ?

schedstats seems like a good home, that way users can avoid most of
the extra overhead if schedstats is disabled.
