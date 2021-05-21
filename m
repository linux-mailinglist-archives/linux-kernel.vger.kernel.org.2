Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF238C61D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhEUL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhEUL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:59:11 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:57:46 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n10so19851478ion.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGeIrOpcuP6wbP/zIsOF2etDIqU10NJ58UYzjMALJZg=;
        b=bWYfSzP8CxiWns4gr5nTVLcLCOCCBoFXcUJxPAzW9e9IcV37buU4SMIqgHWph2+6Gc
         FD50i6XBqdJ63H7RgKdCyB7a1x5m/8UnWN1ePSk2fyZJV5YkDu/Cra0pTpfw8PGM4mr5
         /L/G7LgKBwHT4poWVfsf1Nip7g4lTh/XjDtAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGeIrOpcuP6wbP/zIsOF2etDIqU10NJ58UYzjMALJZg=;
        b=NYcWTnJpi3FUWxpru4LDCqkOUBDo8jUQQVVrgsXyVeE6a34a0MWrBpCWYNPOzZkDpN
         YCBrygkFLDvUTCVB0szTY0NDovdVfIlm16bKOBDuKt6BpNxepA/afH2IOwjUXEIB8S9t
         R7HBqweVQ7AhdmUbaF6DSlFX7LEj4eIVu6QnzG1AfmxC/me42rjKy2FwBchgOle2NEH0
         OLtkeqCmhm5TotEsk8aHDmzIBKRcF7yBDr9mkantlTfJ3PVBtocKc0Guqe72qHMQoSlI
         xz6zUEZCb5aXdZ0l253nERt+nOlSp/0Okuz95WjxtzaTujcIJAAA0LW6SUu2jXt/jqDn
         z4Cw==
X-Gm-Message-State: AOAM530V8bD+ZQDAvqCDMxx4JtRIayOLsGhSaaEptH5WJjZitIz0eRMI
        lordftF7ZTpLlNN1IEEQpF8gY+fLwcRPAo0kkHHRwu8CWl8=
X-Google-Smtp-Source: ABdhPJzqld6TChHbjBf1ZaCorP3hMXTe1Ga/0Ixa4yCy1w7W6BlWLHpK9I0lbRC1awCy0Ql+pa6I3tps04uoPvFhJds=
X-Received: by 2002:a05:6638:1650:: with SMTP id a16mr3863442jat.23.1621598265867;
 Fri, 21 May 2021 04:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils> <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
In-Reply-To: <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 21 May 2021 07:57:35 -0400
Message-ID: <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
Subject: Re: config SCHED_CORE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 3:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 20, 2021 at 08:06:07PM -0700, Hugh Dickins wrote:
> > Hi Peter,
> >
> > make oldconfig gave me no help at all on how to decide whether to choose
> > SCHED_CORE Y or n, beyond it recommending Y.  Maybe you'll delete that
> > option later, or maybe removing the prompt string would silence it.
>
> Ah, you're quite right. I never seem to have gotten around to actually
> writing anything useful there :/ Similarly the documentation for all
> this seems to have gone missing too.
>
> Joel, could I ask you to refresh the document to match the current state
> of things and repost? I still whole hartedly despise this RST crud, it
> makes it so hard to read / modify the files.
>
> ( I think the latest version is here:
>   https://lkml.kernel.org/r/20210324214020.34142-8-joel@joelfernandes.org
> )
>
> Anyway, how is something like the below, Joel can add a reference to the
> document once it's there.
>
> ---
>  kernel/Kconfig.preempt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index ea1e3331c0ba..3c4566cd20ef 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -104,4 +104,16 @@ config SCHED_CORE
>         bool "Core Scheduling for SMT"
>         default y
>         depends on SCHED_SMT
> -
> +       help
> +         This option enables Core scheduling, a means of coordinated task
> +         selection across SMT siblings with the express purpose of creating a
> +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
> +         -- task selection will ensure all SMT siblings will execute a task
> +         from the same 'core group', forcing idle when no matching task is found.
> +
> +         This provides means of mitigation against a number of SMT side-channels;
> +         but is, on its own, insufficient to mitigate all known side-channels.
> +         Notable: the MDS class of attacks require more.
> +
> +         Default enabled for anything that has SCHED_SMT, when unused there should
> +         be no impact on performance.

This description sort of makes it sound like security is the only
usecase. Perhaps we can also add here that core-scheduling can help
performance of workloads where hyperthreading is undesired, such as
when VM providers don't want to share hyperthreads.

Thoughts?
