Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FCF447EE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhKHLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:32:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbhKHLb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:31:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A277D61360
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636370955;
        bh=t2BEV1wat8ws6w2DTh6xiYZxYgmoX7b04xEVmmh6RNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hv1HBpcecgOPuOx/IU9Ci6dO8fXAgzIZMlzo8P3YTpcM3zRsepWzCN6PFlHNv05cM
         UktH1a/pQ+oO3BTLWGHl8sl47krZ0LfPmYX/JU3J+mBWDSu6JvQCB3toq0qRykHYaJ
         Gqggil/CqGQ2+FI8OscTxZKnF9YRk1fV7ez+5T3gX4sLp7OJc/+TaG1Meu6rkiqL0h
         b1aBXbNC4bPYjCQ8X/+KTpFUvHt+curnVDqoxuHDRxW+LVmHymLirsILV5g8sFSRvM
         OMztQkrsF1SnkCCMteS2CBH+0TFaYJql/pQZCVV5DEQGUAmSjOaoPRKxvuqdbiqaHN
         Xp09e7pD50oMw==
Received: by mail-oi1-f170.google.com with SMTP id q124so27028006oig.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 03:29:15 -0800 (PST)
X-Gm-Message-State: AOAM531zm5ztzkLFx9uft2X88Clg37y9z09JkB8lAOAAYvGdM1qNo1Ec
        qy+bYRPvL8SK9zMGwr6UPOU1Py5Uaz+fpb9N2Jk=
X-Google-Smtp-Source: ABdhPJz/CgiK30N4avcJmA414YAszTRP+TwzizVE4eOYT7giArQXQ/imYJ8VNPDDeW2YlpNO3kPv5rbH9hIUqy95a2E=
X-Received: by 2002:a05:6808:1919:: with SMTP id bf25mr7236654oib.33.1636370954860;
 Mon, 08 Nov 2021 03:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20211105145917.2828911-1-ardb@kernel.org> <20211105145917.2828911-3-ardb@kernel.org>
 <YYj6ib6Mrp9rAjVJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YYj6ib6Mrp9rAjVJ@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 8 Nov 2021 12:29:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHEBc1XkTuHPXYV8rp5++HA9ruROUP-UApzEnVzvgFvTw@mail.gmail.com>
Message-ID: <CAMj1kXHEBc1XkTuHPXYV8rp5++HA9ruROUP-UApzEnVzvgFvTw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call trampolines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 at 11:23, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 05, 2021 at 03:59:17PM +0100, Ard Biesheuvel wrote:
> > diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/asm/static_call.h
> > new file mode 100644
> > index 000000000000..6ee918991510
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/static_call.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_STATIC_CALL_H
> > +#define _ASM_STATIC_CALL_H
> > +
> > +/*
> > + * The sequence below is laid out in a way that guarantees that the literal and
> > + * the instruction are always covered by the same cacheline, and can be updated
> > + * using a single store-pair instruction (provided that we rewrite the BTI C
> > + * instruction as well). This means the literal and the instruction are always
> > + * in sync when observed via the D-side.
> > + *
> > + * However, this does not guarantee that the I-side will catch up immediately
> > + * as well: until the I-cache maintenance completes, CPUs may branch to the old
> > + * target, or execute a stale NOP or RET. We deal with this by writing the
> > + * literal unconditionally, even if it is 0x0 or the branch is in range. That
> > + * way, a stale NOP will fall through and call the new target via an indirect
> > + * call. Stale RETs or Bs will be taken as before, and branch to the old
> > + * target.
> > + */
>
> Thanks for the comment!
>
>
> > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> > index 771f543464e0..a265a87d4d9e 100644
> > --- a/arch/arm64/kernel/patching.c
> > +++ b/arch/arm64/kernel/patching.c
>
>
> > +static void *strip_cfi_jt(void *addr)
> > +{
> > +     if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> > +             void *p = addr;
> > +             u32 insn;
> > +
> > +             /*
> > +              * Taking the address of a function produces the address of the
> > +              * jump table entry when Clang CFI is enabled. Such entries are
> > +              * ordinary jump instructions, preceded by a BTI C instruction
> > +              * if BTI is enabled for the kernel.
> > +              */
> > +             if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> > +                     p += 4;
>
> Perhaps:
>                 if (aarch64_insn_is_bti(le32_to_cpup(p)))

That instruction does not exist yet, and it begs the question which
type of BTI instruction we want to detect.

>                         p += 4;
>
> Perhapser still, add:
>                 else
>                         WARN_ON(IS_ENABLED(CONFIG_ARM64_BTI_KERNEL));
>

There's already a WARN() below that will trigger and return the
original address if the entry did not have the expected layout, which
means a direct branch at offset 0x0 or 0x4 depending on whether BTI is
on.

So I could add a WARN() here as well, but I'd prefer to keep the one
at the bottom, which makes the one here slightly redundant.

> > +
> > +             insn = le32_to_cpup(p);
> > +             if (aarch64_insn_is_b(insn))
> > +                     return p + aarch64_get_branch_offset(insn);
> > +
> > +             WARN_ON(1);
> > +     }
> > +     return addr;
> > +}
>
> Also, can this please have a comment decrying the lack of built-in for
> this?

Sure.
