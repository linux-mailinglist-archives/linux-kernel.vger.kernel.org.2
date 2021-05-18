Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCF38817F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbhERUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:40:59 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34434 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhERUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:40:58 -0400
Received: by mail-ed1-f53.google.com with SMTP id w12so5046450edx.1;
        Tue, 18 May 2021 13:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbLSlUzjnQi9LF9AztCJB11CoBKrMpAM+VLmKOfWpRM=;
        b=G1VA/I69KWPHSUwwRbapPd4rw8TIB+ei7cQDX/EzwVOEY9gJ2sJEyFpQO98zRQFtZR
         6PLmLKpZ2mUBSuPbzR2Za4kcY8FZ1urmPKZL9FkzgcbeanAtyrV4BlF23R/3WQUiA5Tj
         xwvnEQp+k+P5KCSnJCff2NCIbixzUcUENn/fAATEYOV/Yrjj+Ux3d0c9nvoVOM+Vk0Vq
         JsNwOAhw3ICTut5WHdudzmJ/9n+OXRH36zHk/FPavBOsDG1jgH4qMZHOELWW7CSQQKfM
         3zd/be5ALUg8o37qNNcZum7gtMRw+fYjFpJhWQuJIG0QdR6EBsDdjaXjYjkq++UHwmkA
         0UlA==
X-Gm-Message-State: AOAM531V3cfBrK3/X2Jb/HRX1s09UsHgb/M5sXfpPMd1N0t/8E9y/LG4
        nWw66uvvt5+xOss4r5FtoglKpKeNH8N2+Wpeusua3pRoUvs=
X-Google-Smtp-Source: ABdhPJxw5S0oKG/063Mjks6XP0/hBfpkaOmAgGXCuwZUj6YRAeqLLCfzj0j/MLpmDI18M8ARWsipim5braA8S+9cWSY=
X-Received: by 2002:a05:6402:358a:: with SMTP id y10mr9252017edc.122.1621370378826;
 Tue, 18 May 2021 13:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <8735uxmucw.ffs@nanos.tec.linutronix.de>
In-Reply-To: <8735uxmucw.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 18 May 2021 16:39:27 -0400
Message-ID: <CAJvTdK=6B8fXasshqOoMknAt25vWPDW6LVLovOhnmY10ZEdL1Q@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 5:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> Where is #6 which describes the signal interaction?

#6 Per the current ABI, Linux gives signal handlers access to all of
the hardware architectural state.

#6a Signal Stack is on User Stack

The architectural state is pushed on the user stack in uncompressed
XSTATE format.

It is established that there exists application code that counts on
this opaque state being complete so that it can do a user-space
XRESTORE instead of a sigreturn(2).  (My opinion is that not breaking
that legacy code is a requirement, and I'm actually shocked this view
is not unanimous)

If a feature is enabled in XCR0 but is in INIT state, the XSAVE will
transfer zeros.
While this is established for AVX-512, we optimize for this case for AMX
by checking for this scenario and not transferring any data.
(this optimization, and the self-test for it, is in AMX patch series v5)

The signal hander is empowered to alter everything in XSTATE on the
signal stack.

Upon sigreturn, the kernel will dutifully XRESTORE the XSTATE.

#6b Applications that allocate and register a dedicated alternate signal stack

Run-time is similar to above, except the user has allocated a
dedicated signal stack.
The problem is that the user had to decide this stack's size.

Unfortunately, signal.h ABI contained #define MIN/SIG-STACKSIZE
(2k/8k) constants, which were:
a) constant
b) not updated in decades

The kernel, for its part, also failed to check that an altstack was
big enough before writing to it.

Indeed, AVX-512 made the 2k constant a lie, which Andy points out is
ABI breakage.
This is factual, and there were real programs that broke because of it.

Were AMX to be deployed in this manner without repairing the broken ABI,
the 8K state would exceed both of these constants, and that would be
more severe breakage than AVX-512.

glibc 2.34 addressed both the existing and future problem, by updating
these constants
to be calculated at run-time.  The run-time calculation can be done
entirely in glibc,
or if glibc is running on an updated kernel, it will ask the kernel
for the size via altvec.

Further, the kernel has been updated to check for alt-stack too-small
at run-time.

https://lore.kernel.org/lkml/20210518200320.17239-1-chang.seok.bae@intel.com/

I believe that all feedback has been addressed in that patch series,
and that it is ready for linux-next.

There are still two potential failures on systems that have AVX-512/AMX enabled:
1. program, re-compiled or not, that hard-codes its own too-small alt-stack
2. legacy static binary using old signal.h constants to allocate alt-stack.

The kernel will not prohibit these programs from executing, but if they actually
take a signal, the kernel will SIGSEGV them instead of overflowing their stack.

Len Brown, Intel Open Source Technology Center
