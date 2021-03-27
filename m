Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8AB34B449
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 05:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhC0Exk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 00:53:40 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37377 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhC0ExS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 00:53:18 -0400
Received: by mail-ed1-f41.google.com with SMTP id x21so8556223eds.4;
        Fri, 26 Mar 2021 21:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/bL9HzL8raBAZm+7gFcLtKeJ3h77dE10M5csH8ISDA=;
        b=qIuhenVqIlF5JwkJmgy34dxI2l9fqSQUMUifPjPFVHd3FMnlQSXPAAh9If0vpTQbMN
         kg20mypYGj3jAxw9uZY/ELzoEd4MEZUDKqfRU5xlhsc3g4vgM73vfcrKTn+f5U2kvG3X
         J7HwMJE7V/Eqo5G46br1nPFdtO8aSnYYfMDlp7v2QSXmpEINIQydSw/LClKmQYWb7KkH
         bLOf5YjOiXL21TIGrcgHea53bFT9W4rgzdARX+xl/HMxKC717/qFd4St2zdV5kSFJe2A
         gRcjbZ2beia5G3QcVmZJedCOfJhYzq2R3oT9/FJWG7lQFBFNUwkFt40T8OOOgl/HVAve
         7ffw==
X-Gm-Message-State: AOAM531LodLvQygwOZY60L96Rx4KZr9X6Fdj6Wg5zN1n6f78qB15MZXJ
        gYRmTghRPOuWfgdBf8LWMw/hdlMLh1v60IGRMEI=
X-Google-Smtp-Source: ABdhPJyeyYE5KV72OPgbU3en6i98b1C+XWjf2E6bBMDRMypsgyCeyjUYx9hglIC/LRCEC1uou4EDMtaRxYIu0BuHcNQ=
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr18635691edy.310.1616820797709;
 Fri, 26 Mar 2021 21:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
 <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
 <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com>
 <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com>
 <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com> <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com>
In-Reply-To: <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Sat, 27 Mar 2021 00:53:06 -0400
Message-ID: <CAJvTdKmdMfD4BddMJs4iwvHWRSv4PV7Dh2vxjM57UJ3pw5UJDQ@mail.gmail.com>
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

> 3.3 RECOMMENDATIONS FOR SYSTEM SOFTWARE
>
> System software may disable use of Intel AMX by clearing XCR0[18:17],
> by clearing CR4.OSXSAVE, or by setting
> IA32_XFD[18]. It is recommended that system software initialize AMX
> state (e.g., by executing TILERELEASE)
> before doing so. This is because maintaining AMX state in a
> non-initialized state may have negative power and
> performance implications.

I agree that the wording here about disabling AMX is ominous.

The hardware initializes with AMX disabled.
The kernel probes AMX, enables it in XCR0, and keeps it enabled.

Initially, XFD is "armed" for all tasks.
When a task accesses AMX state, #NM fires, we allocate a context
switch buffer, and we "disarm" XFD for that task.
As we have that buffer in-hand for the lifetime of the task, we never
"arm" XFD for that task again.

XFD is context switched, and so the next time it is set, is when we
are restoring some other task's state.

n.b. I'm describing the Linux flow.  The VMM scenario is a little different.

> Since you reviewed the patch set, I assume you are familiar with how
> Linux manages XSTATE.  Linux does *not* eagerly load XSTATE on context
> switch.  Instead, Linux loads XSTATE when the kernel needs it loaded
> or before executing user code.  This means that the kernel can (and
> does, and it's a performance win) execute kernel thread code and/or go
> idle, *including long-term deep idle*, with user XSTATE loaded.

Yes, this scenario is clear.

There are several cases.

1. Since TMM registers are volatile, a routine using TMM that wants
them to persist across a call must save them,
    and will TILERELEASE before invoking that call.  That is the
calling convention,
    and I expect that if it is not followed, debugging (of tools) will
occur until it is.

    The only way for a user program's XSTATE to be present during the
kernel's call to idle
    is if it sleep via a system call when no other task wants to run
on that CPU.

    Since system calls are calls, in this case, AMX INIT=1 during idle.
    All deep C-state are enabled, the idle CPU is able to contribute
it's maximum turbo buget to its peers.

2. A correct program with live TMM registers takes an interrupt, and
we enter the kernel AMX INIT=0.
    Yes, we will enter the syscall at the frequency of the app (like
we always do).
    Yes, turbo frequency may be limited by the activity of this
processor and its peers (like it always is)

   2a. If we return to the same program, then depending on how long
the syscall runs, we may execute
         the program and the system call code at a frequency lower
than we might if AMX INIT=1 at time of interrupt.

   2b. If we context switch to a task that has AMX INIT=1, then any
AMX-imposed limits on turbo
         are immediately gone.

    Note for 2b.  4 generations have passed since SKX had significant
delay releasing AVX-512 credits.
    The delay in the first hardware that supports AXM should be
negligible for both AVX-512 and AMX.

3. A buggy or purposely bogus program is fully empowered to violate
the programming conventions.
    Say such a program called a long sleep, and nothing else wanted to
run on that CPU, so the kernel
    went idle with AMX INIT=0.  Indeed, this could retard the core
from getting into the deepest available
    C-state, which could impact the turbo budget of neighboring cores.
However, if that were some kind
    of DOS, it would be simpler and more effective to simply hog a CPU
by running code.  Also, as soon
    as another thread switches in with INIT=1, there is no concept of
AMX frequency caps. (see note for 2b)

I do not see a situation where the kernel needs to issue TILERELEASE
(though a VMM likely would).
What did I miss?

thanks,
Len Brown, Intel Open Source Technology Center

ps. I will respond to your ABI thoughts on your new ABI thread.
