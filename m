Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435F042AF24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhJLVqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhJLVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:46:15 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:44:12 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 64so1255924uab.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgazRr7A2QxPpLaIdzzNVnQx5x0TIqviAZnwgcAY9Pg=;
        b=bWRrfJh/Uo4JkHTOWSO2RpQy+iTmn2NyxbP00pHrKnicT0HSgoc4618JFZtYGtNjd3
         cg0/KnupBB0O5qb6pMcGfmQ+r+zZnVWbgz55IrrLMfBzDFGxp2TnTFO0Y9t1Uf7IS8nV
         I5WEyqW3mOJGCU4A2qwi4EYlk4lAebuoa4jH3/rLTqZh1r/QY0T5P8YJC3hPiL5iOEwc
         wLlDrwjH3Co0Km+NEYBNoLvBNkA/yVgARCWQ0JMmtVKQEUD5Dwd7yjcH6/AZfOVpVx7R
         lSr6wktbCK2wQgpyVi+R9WDtIP3hlmJhuZpvlfWtfdB2xeYLyaf8fzIITOX2RwFuYVbB
         jdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgazRr7A2QxPpLaIdzzNVnQx5x0TIqviAZnwgcAY9Pg=;
        b=lUpy8voFdGPpvQMiRHQKnJgCH6zLlFfO29kYJ5gdlgb35t4BH7yb/FMSmurR6fHv2c
         QGn1RutYIXvaUHNyM9cDvzKPgMU4Wb6YwtmD/if2CXtmLe6CjrYaGmfK1dBPvwHlEONJ
         rJL8oC05SeEfbEi/+sL0LsX1zqdmk3w7wR9/8nD7v2PIVM5k1r3qiHUeVJ7oG6b1I65S
         A88J5V6vJegVQa7mXLfd6dwVXw0G0No+XlWMxku4LJetGQERNOfvAhLLF5E2NDyiRkxq
         MO343XDcTXzeh+L6NF74mzvoJXEhVLRnjZSCxktfcxgl5A2bGuGLGt6BTv8CbklKJdR0
         0xsA==
X-Gm-Message-State: AOAM5301qwCfsXr3+nbtdfCQ8Rgw1wMXI9rirjKb2Nu0a2z5ovqfLk+C
        XbcP6IcURwwZjd40yNzMUpwHVQBeAgYnMc6PyZmOAA==
X-Google-Smtp-Source: ABdhPJztMGYi+qkGm7giUB/xpqhERMXS/4D4cftklCr5DL+PyCR0mAZ9cTV/61s/96a6eXEwdWl4e9VSMUjamG4Dfns=
X-Received: by 2002:ab0:16d4:: with SMTP id g20mr25152048uaf.114.1634075052009;
 Tue, 12 Oct 2021 14:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210917180323.278250-1-posk@google.com> <20210917180323.278250-6-posk@google.com>
 <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca> <CAFTs51W6ZHrGaoXEbXNCkVKLxe7_S2raYcXMBzypC7VUDMrU-w@mail.gmail.com>
 <e162fdea-5323-89d2-49d0-3fe56ba2ec3a@uwaterloo.ca> <CAFTs51X0kQLngHYXD-BxBmm6oRyMk1vy9nzaPu4V46PifO99LQ@mail.gmail.com>
 <40c37212-ab15-01ac-f5c5-e3f53c9b8e4e@uwaterloo.ca>
In-Reply-To: <40c37212-ab15-01ac-f5c5-e3f53c9b8e4e@uwaterloo.ca>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 12 Oct 2021 14:44:01 -0700
Message-ID: <CAFTs51XksSW+YW2H2iZk+j0AY+NApr=aBBVgakyx55yX_5AA8A@mail.gmail.com>
Subject: Re: [PATCH 5/5 v0.6] sched/umcg: add Documentation/userspace-api/umcg.txt
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry!

Again, it seems you are ascribing higher level semantics to lower
level constructs here, specifically to "idle workers list".

In this patchset, idle workers list is just a mechanism used by the
kernel to notify the userspace that previously blocked workers are now
available for scheduling. Maybe a better name would have been
"unblocked workers list". The true list of idle workers that the
userspace scheduler can schedule is maintained by the userspace; it
can be said that if a worker is on the kernel's idle workers list, it
is NOT on the userspace's idle workers list, and so workers on the
kernel's idle workers list are not yet fully "idle workers" that can
be scheduled.

On Tue, Oct 12, 2021 at 11:46 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  >> Just to be clear, sys_umcg_wait supports an operation that, when called
>  >> from a worker, puts the worker to sleep without triggering block
> detection
>  >> or context-switching back to the server?
>  >
>  > Potentially, yes - when a worker wants to yield (e.g. as part of a
>  > custom UMCG-aware mutex/condvar code), and calls into the userspace
>  > scheduler, it may be faster to skip the server wakeup (e.g. reassign
>  > the server to another sleeping worker and wake this worker). This is
>  > not a supported operation right now, but I see how it could be used to
>  > optimize some things in the future.
>  >
>  > Do you have any concerns here?
>
> To be honest, I did not realize this was a possibility until your previous
> email. I'm not sure I buy your example, it just sounds like worker to worker
> context-switching, but I could imagine "stop the world" cases or some "race
> to idle" policy using this feature.
>
> It seems to me the corresponding wake needs to know if it needs to enqueue
> the worker into the idle workers list or if it should just schedule the
> worker
> as it would a server.
>
> How does the wake know which to do?

If the worker is IDLE, and the userspace knows about it (i.e. the
worker is NOT on the kernel's idle workers list), the userspace either
can directly schedule the worker with a server (mark it RUNNING,
assign a server, etc.), or instruct the kernel to put the worker onto
the kernel's idle workers list so that it can later be picked up by a
userspace thread checking the kernel's idle workers list. This last
operation is provided for cases when for example a server wants to run
IDLE worker A and knows about IDLE worker B, but for some reason
cannot properly process worker B at the moment, so by putting worker B
back into the kernel's idle worker list this server delegates
processing worker B to another server in the future.

Both of these state transitions are explicitly covered in the documentation.

Again, you appear to be trying to equate kernel UMCG API with higher
level userspace scheduling notions/facilities, while in reality kernel
UMCG API is a low level facility that will be _used_ to construct the
higher level behaviors/semantics you are wondering about.

I suggest you wait until I post the userspace library to ask these
higher-level semantic questions.

Thanks,
Peter

[...]
