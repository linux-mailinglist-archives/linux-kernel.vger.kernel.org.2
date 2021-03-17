Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA16133F84B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhCQSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCQSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:43:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B5DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:43:44 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id e5so165124vse.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BY6Vn1nuAM3ElW71CCjlIKhlSq5fPXddIXN0CzmwDNc=;
        b=IcjKrfcJSqrirymxoj0le3JUWlU0wyWnSvuOoEyHh5mJ0xUM2ot+BYhfDD8HqX5VH9
         tWUwRLXEa6unLMGuR9f674oqYFLxPp4hHpnPQCdqkKu9ibxjiNbxyfDbGzet6dC+rq20
         Y1mVtt621nVfku3r/H7kaylNviAFfPMSONSOzEFvUifz2A5Av7juIxrH+LJul2t9Zrho
         htoxoWT/E9eeAZeYVkQkq7C899uffYtqzYGb68FG/5b9JPUreFXCnkfvRIs+45Cd3pWz
         zBj6ah0OudETpR7KHBeIauydlnqm56uybxwSxjHXbHxoGYnxDKfsvPHGZswhzqe8V9pn
         OIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY6Vn1nuAM3ElW71CCjlIKhlSq5fPXddIXN0CzmwDNc=;
        b=nF1bn/Q6mx8c23UUX/j2BRO10VyH/JwMUEY6nPI9yjp3pZfYpds5aVyaj4naojQcBk
         Wl6ZBHsialX3aZUygeurK4Qs3zD4yISmIb2eQ1R7k0+/mCDlJBDqyho7SHVzUlj6FjrI
         A61DLG4J4l28P3ZuJHytZsIXa+HUhaa+Ziem8fvPBhbGApSE2IKa7anSHJdPs3nV/KMw
         SKXQ7U3e08cZLSuSuzQWfwqbyNTYDlcPixRrDM2mESxHSae19KIUBj+Af74gRn6Z3pHY
         lme4Rt0kJVJQXoVtLKyJPbqy+l9FDdMnFqJtYOh3Sj1gIulCuEIvo46ys8RTWXvQc/Ox
         LWXg==
X-Gm-Message-State: AOAM53216jbkdZmVEkciSBSnoD5q49IajGOom5sgrP9qkd/xvID/DmnT
        6QiVNSRPLAjxZR2h37W+dxlLXlBXjOj1Mxw6C4VBdQ==
X-Google-Smtp-Source: ABdhPJxEA7oy3O3UN2+hSKIMMJ0KfXJIViwXsqZ+km6kGtRyn7wC/ij0mufe0xnzocmLQhGM5O7grwJQ8wJ/86HzhLw=
X-Received: by 2002:a67:3015:: with SMTP id w21mr4742485vsw.23.1616006623246;
 Wed, 17 Mar 2021 11:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <c85541c4-6ae5-8898-8044-99e403335f48@torproject.org>
In-Reply-To: <c85541c4-6ae5-8898-8044-99e403335f48@torproject.org>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 17 Mar 2021 11:43:32 -0700
Message-ID: <CAFTs51WOGye9EiJEinA=k4rzBptKmzZheg8ZsELwpZ71bZsJ3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3 v3] futex/sched: introduce FUTEX_SWAP operation
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Peter Oskolkov <posk@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Jansen <rob.g.jansen@nrl.navy.mil>,
        Ryan Wails <ryan.wails@nrl.navy.mil>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Ben Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim, thank you for your interest!

While FUTEX_SWAP seems to be a nonstarter, there is a discussion
off-list on how to approach the larger problem of userspace
scheduling. A full userspace scheduling patchset is likely to take
some time to shape out, but the "core" patches of wait/wake/swap are
more or less ready, so I'll probably post an early RFC version here in
the next week or two.

CC-ing the maintainers.

Thanks,
Peter

On Wed, Mar 17, 2021 at 10:59 AM Jim Newsome <jnewsome@torproject.org> wrote:
>
> I'm not well versed in this part of the kernel (ok, any part, really),
> but I wanted to chime in from a user perspective that I'm very
> interested in this functionality.
>
> We (Rob + Ryan + I, cc'd) are currently developing the second generation
> of the Shadow simulator <https://shadow.github.io/>, which is used by
> various researchers and the Tor Project. In this new architecture,
> simulated network-application processes (such as tor, browsers, and web
> servers) are each run as a native OS process, started by forking and
> exec'ing its unmodified binary. We are interested in supporting large
> simulations (e.g. 50k+ processes), and expect them to take on the order
> of hours or even days to execute, so scalability and performance matters.
>
> We've prototyped two mechanisms for controlling these simulated
> processes, and a third hybrid mechanism that combines the two. I've
> mentioned one of these (ptrace) in another thread ("do_wait: make
> PIDTYPE_PID case O(1) instead of O(n)"). The other mechanism is to use
> an LD_PRELOAD'd shim that implements the libc interface, and
> communicates with Shadow via a syscall-like API over IPC.
>
> So far the most performant version we've tried of this IPC is with a bit
> of shared memory and a pair of semaphores. It looks much like the
> example in Peter's proposal:
>
> > a. T1: futex-wake T2, futex-wait
> > b. T2: wakes, does what it has been woken to do
> > c. T2: futex-wake T1, futex-wait
>
> We've been able to get the switching costs down using CPU pinning and
> SCHED_FIFO. Each physical CPU spends most of its time swapping back and
> forth between a Shadow worker thread and an emulated process. Even so,
> the new architecture is so far slower than the first generation of
> Shadow, which multiplexes the simulated processes into its own handful
> of OS processes (but is complex and fragile).
>
> > With FUTEX_SWAP, steps a and c above can be reduced to one futex
> > operation that runs 5-10 times faster.
>
> IIUC the proposed primitives could let us further improve performance,
> and perhaps drop some of the complexity of attempting to control the
> scheduler via pinning and SCHED_FIFO.
