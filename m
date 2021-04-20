Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BF365654
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhDTKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:41:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:41:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d21so24360080edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vcp7LlvO4t6de7ogUbBXWf68yUyJYghPxKL5v8ehnQ=;
        b=Zo8PDeJH5Sm2dWt16buPFPVqLPX27UTATlBGB4jk4LVLmvak8Cyv8GOT7P3/klB5jl
         Q8J0yFxV1KWiSf5S+YObExHM99hiT0t14MK2/7An0TY2xTf3EaWA11aSMS0CbvI4x3tt
         UtGSey3FyCKdu97Q6RSm5fBmOpS2pnHwoAJeDSqtfeqdtBp8P+SUIdHa38UAk40i2zfX
         DXTrLSV71B0ZP7IkdoKVSbM4P8RxDpZNm2EctQui+pPQydEZOGVZ5fiX2G1qs7J6R3Al
         28/nV8xJC+2BpuNMnCsPcf86PMT1ljsdBmUssaqzXNPLOJcnUkx3FKR7QPRQKgg4Nj1z
         nDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vcp7LlvO4t6de7ogUbBXWf68yUyJYghPxKL5v8ehnQ=;
        b=U7W3w8QR0hpFBx+hKbnaemOLSSTfu5xPVmRYnfZmC8o5XRBN6Krh/RY7unBgtNDYse
         0nUnUp483XCNUxasQTMOc6fraMLnTEfC8hwjNKse8l0Iqs5UL4xRc4j2nyUCFH3zndUk
         +9lDpuWJquVS/Az45EShfJ6LJQBmUBp+JciEngtgobvnQDm2B6GGktNnOIzBcLtXSinL
         OiCeFQudwpnS9EUARNu1WIJZlJPnzN+gCxMWsX1GpOVXoJqzOHsVjDhOyHIoTcpcWI8V
         UJ4Lx8gGrMELEuGmcnEW9/buhWoasoEvWcz9qE9zL8b/8hgpYT3lIaVn1VkFVpMG/nbU
         qbHA==
X-Gm-Message-State: AOAM532pQMYudLQMDarP4163OxocoG3wABbsVjGCEXEEKzNZvIo5bDDR
        PWlnCDMpVdz6SVDa6yWjh8tPvn9ejjJvU0N4l543YhKn4tA=
X-Google-Smtp-Source: ABdhPJxaQSXq9Kx2cUWnTgxaan8HiU2d9KK1tTGunRJbq9zmMARjOFiLm/sduzkZP5MGkaY/InYgnNh0spiRKNoBBaE=
X-Received: by 2002:aa7:c492:: with SMTP id m18mr8438032edq.30.1618915279470;
 Tue, 20 Apr 2021 03:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210419184455.2987243-1-lrizzo@google.com> <20210419191712.GB26214@worktop.programming.kicks-ass.net>
 <CAMOZA0JxwQFfA=acfr255xcR85ztv-URwaQQFHR6RrLk-cPbvg@mail.gmail.com> <YH6bV9W4lgIl4Fry@hirez.programming.kicks-ass.net>
In-Reply-To: <YH6bV9W4lgIl4Fry@hirez.programming.kicks-ass.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Tue, 20 Apr 2021 12:41:08 +0200
Message-ID: <CAMOZA0J4q2XSmhxB_uc-Q2mOA=K_FcvZqy3G+8ME=QMicOF=Lg@mail.gmail.com>
Subject: Re: [PATCH] smp: add a best_effort version of smp_call_function_many()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 19, 2021 at 11:07:08PM +0200, Luigi Rizzo wrote:
> > On Mon, Apr 19, 2021 at 9:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Apr 19, 2021 at 11:44:55AM -0700, Luigi Rizzo wrote:
> > > > Regardless of the 'wait' argument, smp_call_function_many() must spin
> > > > if any of the target CPUs have their csd busy waiting to be processed
> > > > for a previous call. This may cause high tail latencies e.g. when some
> > > > of the target CPUs are running functions that disable interrupts for a
> > > > long time; getrusage() is one possible culprit.
> > > >
> > > > Here we introduce a variant, __smp_call_function_many(), that adds
> > > > a third 'best_effort' mode to the two existing ones (nowait, wait).
> > > > In best effort mode, the call will skip CPUs whose csd is busy, and if
> > > > any CPU is skipped it returns -EBUSY and the set of busy in the mask.
> > > > This allows the caller to decide how to proceed, e.g. it might retry at
> > > > a later time, or use a private csd, etc..
> > > >
> > > > The new function is a compromise to avoid touching existing callers of
> > > > smp_call_function_many(). If the feature is considered interesting, we
> > > > could even replace the 'wait' argument with a ternary 'mode' in all
> > > > smp_call_function_*() and derived methods.
> > >
> > > I don't see a user of this...
> >
> > This is actually something for which I was looking for feedback:
> >
> > my use case is similar to a periodic garbage collect request:
> > the caller tells targets that it may be time to do some work,
> > but it does not matter if the request is dropped because the
> > caller knows who was busy and will reissue pending requests later.
...
> > Any possible candidates that people can think of ?
>
> We mostly try and avoid using this stuff wherever possible. Only when
> no other choice is left do we send IPIs.
>
> NOHZ_FULL already relies on this and gets massively unhappy when a new
> user comes and starts to spray IPIs.

I am curious, why is that -- is it because the new user is stealing
the shared csd's in cfd_data (see below), or some other reason ?

>
> So no; mostly we send an IPI because we _HAVE_ to, not because giggles.
>
> That said; there's still some places left where we can avoid sending
> IPIs, but in all those cases correctness mandates we actually handle
> things and not randomly not do anything.

My case too requires that the request is eventually handled, but with
this non-blocking IPI the caller has a better option than blocking:
it can either retry the multicast IPI at a later time if conditions allow,
or it can post a dedicated CSD (with the advantage that being my
requests idempotent, if the CSD is locked there is no need to retry
because it means the handler has not started yet).

In fact, if we had the option to use dedicated CSDs for multicast IPI,
we wouldn't even need to retry because we'd know that the posted CSD
is for our call back and not someone else's.

cheers
luigi
