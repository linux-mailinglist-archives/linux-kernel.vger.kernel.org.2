Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68360370469
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEAA3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:29:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CB2C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:28:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t24so14335210oic.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrSDrh86BIUH92uxEEUIIzYXakmk5H1bASu7Ra8z2vg=;
        b=cvM0ZoU48pK2bYkaKMuHnSoQ06aWqFfkle9mtgOE/Ush8rIB5JVJRuoCRAzplzdNNl
         I8sBtiJuY+Wewk8R0f9ELuux1yOcHKWmMSma4409yzW1wIDhiddWDFYV9WPOb8jS9KEY
         LASs1C1i+LifJunVK3i65hUcADSM/TcSa7HX5GTfeaERdUOeUnTpL/0JoA6Nwi5GDJnJ
         yftzIBkHJmylhsDacSB0TT2ywGtL+Rwk9MPNLWm9iMRXMEv0/Aw8K4aGrQnyKHcS9by4
         LqL7xbL0BirIf5oh0qpJIKXzj4gS6APG4yb3UqYogyYAVhgHkscBpZvU728ThVeDXKFx
         NfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrSDrh86BIUH92uxEEUIIzYXakmk5H1bASu7Ra8z2vg=;
        b=k6LWGe0PQrCK4pZ29QDNRHM+Q4xY8gYhkoUpXy2c8N31LrccZsp2VX4+lCNP5cZPJW
         J07UaKiyKDKQpjtgg3GmWb4k8Up3sXl4wwJUV9Uss5pCB9lqOAcoFKn6aeUpGQDdb+78
         kxl/wsLoMbEV2jLedNcDwBqHZvNo1A06cMHwJktFOTXXrzAz++v5ZXBfjk74MKVBgke2
         4PWJhqBUW1uD7XY1TplRTDlOpvVUENiaG6UOQ04pjrIp+fYpmFSqXn35HwkV7IOQnBbC
         4sOKbBuvXRveuyWL7jeV8dMENDVSrwRmvGjq8f+/3aJfN3nQJY/pHYkAaCMptUpYTEJ7
         ah8Q==
X-Gm-Message-State: AOAM530uIOK+UgjKjnfMmo4PfJV4h6uIAFGhWRqDI4YBpzJFTwL3LHNt
        B33k8ObdMLiBaAl5BNUv5sgDpD8X1LCXEeoB0gbJLQ==
X-Google-Smtp-Source: ABdhPJwd0pDQ1vHrS8Z2nkyzNABox9/lzR97Z3rpScDEZ96BeynLMF42t/vDPTiSITQxEl86WXm5uwEG3bhnj95lNz8=
X-Received: by 2002:aca:408a:: with SMTP id n132mr6068321oia.70.1619828924536;
 Fri, 30 Apr 2021 17:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1im43qrug.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1im43qrug.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Sat, 1 May 2021 02:28:33 +0200
Message-ID: <CANpmjNOwUfcCrBfCjtq9ngjqkqjYzehrqS+=+2oA=703tNP=aA@mail.gmail.com>
Subject: Re: Is perf_sigtrap synchronous?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2021 at 01:23, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I am looking at perf_sigtrap and I am confused by the code.
>
>
>         /*
>          * We'd expect this to only occur if the irq_work is delayed and either
>          * ctx->task or current has changed in the meantime. This can be the
>          * case on architectures that do not implement arch_irq_work_raise().
>          */
>         if (WARN_ON_ONCE(event->ctx->task != current))
>                 return;
>
>         /*
>          * perf_pending_event() can race with the task exiting.
>          */
>         if (current->flags & PF_EXITING)
>                 return;
>
>
> It performs tests that absolutely can never fail if we are talking about
> a synchronous exception.  The code force_sig family of functions only
> make sense to use with and are only safe to use with synchronous
> exceptions.
>
> Are the tests in perf_sigtrap necessary or is perf_sigtrap not reporting
> a synchronous event?

Yes it's synchronous, insofar that the user will receive the signal
right when the event happens (I've tested this extensively, also see
tools/testing/selftests/perf_events). Of course, there's some effort
involved from the point where the event triggered to actually safely
delivering the signal. In particular, for HW events, these arrive in
NMI, and we can't do much in NMI, and therefore will queue an
irq_work.

On architectures that properly implement irq_work, it will do a
self-IPI, so that once it is safe to do so, another interrupt is
delivered where we process the event and do the force_sig_info(). The
task where the event occurred never got a chance to run -- except for
bad architectures with broken irq_work, and the first WARN_ON() is
there so we don't crash the kernel if somebody botched their irq_work.

Since we're talking about various HW events, these can still trigger
while the task is exiting, before perf_event_exit_task() being called
during do_exit(). That's why we have the 2nd check.

Thanks,
-- Marco
