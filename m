Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85B13E4BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhHISSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHISSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:18:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34591C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:17:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t9so35806701lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbVrjTG6KtD1ShxcQyr/Iy25T6noL4kVDyEjmN56a1Y=;
        b=aASeeFZAXdWDc9jRFXU5zoyBl7CgTDnaf+pOucZ3iLDiLUPtAPEl/QKWWyF0b5u3dZ
         lGkweHcBqNzo+sB1qCGqEZEHnvqAewZPwx71Nj731fJyOn/J2UABTGzuMdpVaKPvEbVP
         WwTfT5DvC8C2uDtoseUxCOJgO3iCuPY+Bf/mcQhei/syL4VVtFxN4NgEw5X9gUtxFt2/
         alhUjKqnwy+mEdDwBW7NXWCcLnMFhq6nJgSk4Zs9eafqMxsyJr0BJO2hMsjIQodzgaH1
         v4S3vPWklSmfSftWHLbDTIwwmBnyzt7kIImP4D2fU3ydXxjgufcFNJauZAl5dPEYNbkr
         b/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbVrjTG6KtD1ShxcQyr/Iy25T6noL4kVDyEjmN56a1Y=;
        b=Hi9nCcm2n8V9orEIjE3grfKvDhf2UiLFbyTJO3XCJHRR//pRK0qqQuGN8ZCOFZwYuW
         P01RA3lS+nANR//Tq8a6sD9u//IOcG9xZp25oQ4HLmAp1OQ7PBk/kzwa9XTQYbaqkHI0
         Mfe63kdgT9L6bcz88Weq1lu/AM6x+C6QkZQM5pm4TkZI6wNO0MIX/2kzgt0244ns8/Pf
         r634a10FJtvmBf2apv2v9gKy0oHBYRhAz/cHAMfiX54h1h1UUFVfJSCvUWUUN4hKtjBT
         5iFvdZ3VjyooeV1ZmxxNXN/o3H8UVgMG+FbdkBCn2ih2QB44YfmL3X+WovuY2i9og77Y
         M3Pg==
X-Gm-Message-State: AOAM533+Z7sDcrK+gM6Nqzqa0tssrz0HTqB5Z3o/AWp7wY0IKKhPKf5c
        nZJobl3jt4J9jA9gvNrE2QqF3WqZ5yvk9KrY78Gc0w==
X-Google-Smtp-Source: ABdhPJwvubYWcvyp+iJZ34g5UbOHFO6fQr752H2iFo9L5IcrD2ras6rKyWnd7bzwG5B66YKrBGuusrhiR0L+vj9YjMc=
X-Received: by 2002:a05:6512:3fa8:: with SMTP id x40mr3338313lfa.0.1628533069113;
 Mon, 09 Aug 2021 11:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-14-maz@kernel.org>
 <CAOQ_QshjRWh=onT-j3dWgmVfnAXsMFJoz0i7OEezQxkW4O9KZA@mail.gmail.com> <87im0ebi9m.wl-maz@kernel.org>
In-Reply-To: <87im0ebi9m.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 11:17:38 -0700
Message-ID: <CAOQ_Qsh6h_afu_-WjJ2JTP=gYBYW4hbC92qmxzyJ8dgRCCgLKw@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 11:11 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 09 Aug 2021 17:42:00 +0100,
> Oliver Upton <oupton@google.com> wrote:
> >
> > On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > CNTPCTSS_EL0 and CNTVCTSS_EL0 are alternatives to the usual
> > > CNTPCT_EL0 and CNTVCT_EL0 that do not require a previous ISB
> > > to be synchronised (SS stands for Self-Synchronising).
> > >
> > > Use the ARM64_HAS_ECV capability to control alternative sequences
> > > that switch to these low(er)-cost primitives. Note that the
> > > counter access in the VDSO is for now left alone until we decide
> > > whether we want to allow this.
> >
> > What remains to be figured out before we add this to the vDSO (and
> > presumably advertise to userspace through some standard convention)?
>
> We need to understand what breaks if we runtime-patch the VDSO just
> like we do with the rest of the kernel. To start with, the debug
> version of the shared object is not the same as the object presented
> to the process. Maybe that's not a problem, but I would tend to err on
> the side of caution.

I would too, but there sadly are instances of Linux patching *user*
memory already (go look at how KVM/x86 handles the VMCALL/VMMCALL
instruction). But yes, I would much prefer the debug vDSO correspond
to the actual instructions.

> An alternative suggested by Ard was to have a separate function
> altogether for the counter access and an ifunc mapping to pick the
> right one.
>

Hmm, this does sound promising.

> > It would be nice to skip the trap handler altogether, unless there's a
> > can of worms lurking that I'm not aware of.
>
> The trap handlers are only there to work around errata. If you look at
> the arch timer code, you will notice that there is a bunch of SoCs and
> CPUs that do not have a reliable counter, and for which we have to
> trap the virtual counter accesses from userspace (as well as the
> VDSO).
>
> On sane platforms, userspace is free to use the virtual counter
> without any trap.

/facepalm I was about 2 cups of coffee short when writing this :) Thanks!

--
Oliver
