Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA45342FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCTWWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCTWVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:21:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852F06193A
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616278897;
        bh=TIIgS2jODhYZBOeXlXeLmD0AejgTCUX8tRiuIR/e68o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SFTeJy7OBOP9PNYMvqbVnIzTvnaciS/yTg4C1ECYIhb6NouJGeXJKiZZAxohLGV1j
         sF/Q/MqrOryAS2B86N1kcHS0rzqAiufSnV8rpASpymRWdMKAPV9pyk5IJeYMDmuylo
         hjW0hhA3DroQTq7veRBV/wJ79R/CnShH71beHUX0GDzua7Zm3XR1Mjs8eCR0X6mk4R
         Sl6WLN5bIUuPJWJ4vsGtkm6myjaVqFNYPsw2DumORBApjvuFbQ950s7pgNH0ZjeLRC
         eSsjaj62wUmEEwvrfnob18CCO0LqbQVhN15mrGKsC3AUyrjuBihJ9jK7WYVojSWguR
         6mJnzmrJMcQPQ==
Received: by mail-ej1-f46.google.com with SMTP id b7so15280952ejv.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:21:37 -0700 (PDT)
X-Gm-Message-State: AOAM533xG9osrXIGczTLR56gz/0856iySnEusmXfn1tbKBhJeK/POziw
        hkIxkMplU8ydX7I4pulp+1OwqWBJhHyhedoFkAomww==
X-Google-Smtp-Source: ABdhPJwfzCr2UiaaVpit+15LYFAVQMMSyPVuprJTpg3jAw/4ax/EB189frKYbQRJ33MpDicLvCq3gzd+NKZk8e8s3KE=
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr11579899ejc.101.1616278896042;
 Sat, 20 Mar 2021 15:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8fda2ye.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 20 Mar 2021 15:21:24 -0700
X-Gmail-Original-Message-ID: <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
Message-ID: <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@suse.de>, Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 3:13 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
> > +
> > +/* Update MSR IA32_XFD with xfirstuse_not_detected() if needed. */
> > +static inline void xdisable_switch(struct fpu *prev, struct fpu *next)
> > +{
> > +     if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
> > +             return;
> > +
> > +     if (unlikely(prev->state_mask != next->state_mask))
> > +             xdisable_setbits(xfirstuse_not_detected(next));
> > +}
>
> So this is invoked on context switch. Toggling bit 18 of MSR_IA32_XFD
> when it does not match. The spec document says:
>
>   "System software may disable use of Intel AMX by clearing XCR0[18:17], by
>    clearing CR4.OSXSAVE, or by setting IA32_XFD[18]. It is recommended that
>    system software initialize AMX state (e.g., by executing TILERELEASE)
>    before doing so. This is because maintaining AMX state in a
>    non-initialized state may have negative power and performance
>    implications."
>
> I'm not seeing anything related to this. Is this a recommendation
> which can be ignored or is that going to be duct taped into the code
> base once the first user complains about slowdowns of their non AMX
> workloads on that machine?

I have an obnoxious question: do we really want to use the XFD mechanism?

Right now, glibc, and hence most user space code, blindly uses
whatever random CPU features are present for no particularly good
reason, which means that all these features get stuck in the XINUSE=1
state, even if there is no code whatsoever in the process that
benefits.  AVX512 is bad enough as we're seeing right now.  AMX will
be much worse if this happens.

We *could* instead use XCR0 and require an actual syscall to enable
it.  We could even then play games like requiring whomever enables the
feature to allocate memory for the state save area for signals, and
signal delivery could save the state and disable the feature, this
preventing the signal frame from blowing up to 8 or 12 or who knows
how many kB.

--Andy
