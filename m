Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09134AE08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCZRyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:54:25 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:36383 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCZRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:54:00 -0400
Received: by mail-ej1-f43.google.com with SMTP id a7so9701633ejs.3;
        Fri, 26 Mar 2021 10:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0TLaqtqsYqy5cUnEclBBX/cBG3TFyNiJCvgVTFjh6s=;
        b=qSRiaX/8FmwbwAPPAXAGOI0YYWrHDN7mmE9eq1mHiNGbG+aGYNs630H/IQTRwR60pR
         teDgZLsh/T1Csa94J42WP1hocj2l3v/Mhopz0RLN/lZWBfQSH7wqLpd2bTlq1bIQott5
         A2sV3wHBx18AF1x/CXbbP8J1WISrPOuZq0o286kgR9087R6Z09BIhtPQU9EYEKqnlPbJ
         J0zGdixzdVwgJGZERBOnSpwPzd46eAQTHHpaWEzfXMErz//DOo8M74X4m1sTk30fk7Q4
         1HRwUxnNM4YldutB7H4X1c6lA4MBtlTPWjf0CC4aZwDX8Yiz3qP1E+geAy0+j3bviNJo
         FnjA==
X-Gm-Message-State: AOAM531PuV/3fi9Vvsh6587rdzqzm0f1bUFkwv3+pRniSzhx1MvAGQBs
        nWgHw+Fsgnl1TqtNCutGsYKrzvV1wTH9EpU0rauva5uJ
X-Google-Smtp-Source: ABdhPJxUSB073e3Gf0OF8x92Y0SOhmfJuYJOa8tcBbfim7jzG7YHJhav1wADmDSx5kBnlCPOq7J8EQNQ7VgiPty9pDQ=
X-Received: by 2002:a17:907:ea3:: with SMTP id ho35mr16851333ejc.219.1616781238988;
 Fri, 26 Mar 2021 10:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
 <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
 <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com> <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com>
In-Reply-To: <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 26 Mar 2021 13:53:47 -0400
Message-ID: <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:48 AM Andy Lutomirski <luto@kernel.org> wrote:

> > I submit, that after the generic XFD support is in place,
> > there is exactly 1 bit that needs to be flipped to enable
> > user applications to benefit from AMX.
>
> The TILERELEASE opcode itself is rather longer than one bit, and the
> supporting code to invoke it at the right time, to avoid corrupting
> user state, and avoid causing performance regressions merely by
> existing will be orders of magnitude more than 1 bit.  Of course, all
> of this is zero bits in the current series because the code is
> missing.entirely.

Please explain why the kernel must know about the TILERELEASE
instruction in order for an AMX application to run properly.

> This isn't just about validation.  There's also ABI, performance, and
> correctness.

Thank you for agreeing that this is not about unvalidated features.

> ABI: The AVX-512 enablement *already* broke user ABI.  Sadly no one
> told anyone in the kernel community until about 5 years after the
> fact, and it's a bit late to revert AVX-512.  But we don't want to
> enable AMX until the ABI has a reasonable chance of being settled.
> Ditto for future features.  As it stands, if you xstate.enable some
> 16MB feature, the system may well simply fail to boot as too many user
> processes explode.

At Dave's suggestion, we had a 64 *KB* sanity check on this path.
Boris forced us to remove it, because we could not tell him
how we chose the number 64.

I would be delighted to see a check for 64 KB restored, and that
it be a rejection, rather than warning.  At this point, as there is no way
go down that path without manually modifying the kernel, it would
devolve into a sanity check for a hardware (CPUID) bug.

> Performance:
>
> We *still* don't know the performance implications of leaving the AMX
> features in use inappropriately.  Does it completely destroy idle?

No.

> Will it literally operate CPUs out of spec such that Intel's
> reliability estimates will be invalidated?

No.

>  (We had that with NVMe APST.  Let's not repeat this with XSTATE.)

I acknowledge that the possibility of broken hardware always exists.
However, I don't see how the experience with broken NVMe actually applies here,
other than general paranoia about new features (which is, arguably, healthy).

>  The performance impacts
> and transitions for AVX-512 are, to put it charitably, forthcoming.

I acknowledge the parallels with AVX-512, in that AMX adds new instructions,
and it has even bigger registers.  I also acknowledge that the AVX-512 rollout
(and arguably, its brief existence on client CPUs) was problematic.

My understanding is that Intel continues to learn (a lot) from its mistakes.
I believe that the AVX-512 credits problem has been largely eliminated
on newer Xeons.

My understanding is that AMX is implemented only in CPUs that actually
have the hardware to properly support AMX.  If it were not, then that would
be a problem for Intel to deal with in hardware, not a problem for Linux
to deal with in software.

> Correctness: PKRU via the kernel's normal XSAVE path would simply be
> incorrect.  Do we really trust that this won't get repeated?  Also,
> frankly, a command line option that may well break lots of userspace
> but that we fully expect Intel to recommend setting is not a good
> thing.

There is no analogy between AMX and PKRU, except the fact that they
are both features, and at one time, both were new.

I am unaware of anybody at Intel recommending that any cmdline
be set that would break userspace.

thanks,
Len Brown, Intel Open Source Technology Center
