Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC13FC594
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbhHaKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240908AbhHaKXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:23:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE57D60FF2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630405350;
        bh=CopK0+RPrdW0NrpmXSqnJg7a/FM6saM8cfHvnciJNVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GRQbXhOspGBkkIdQarG+TUlyTgZ1ZIu+lRu3XB3bAPtMaH3eeOK7uUszP3UV0esUN
         y+omubUOvniXV0SqWGkdDSfBAtuuQumR4kSh6W5bi0l+6wO3MXGuyVRv68ET1Tbadm
         SYPfB/GK3EE/z7vpkowN6sqqsJ9V6JtkW/ZzOF42L7ocM4APl7HcV0qsY6mKRnyEGm
         UZ8NJ7hvZrRIx+QS4okWIKDi7lK0d0aNsP1XF2qxaPP0JXIEVVM67k6khIXNvnAu6v
         DscgIH027byMmXT8p7jQyR18P72N7Bx5hNzbxAzvid0I4NCz363bRF/ckN37pe3f+g
         cySVbxwB8TE+w==
Received: by mail-oi1-f170.google.com with SMTP id bi4so19942827oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:22:29 -0700 (PDT)
X-Gm-Message-State: AOAM530moMHMaWiKeQ4gqANUl6SPbXPSinLdGe/lktlLKCmP9acFIfcK
        Au02F3WLEtyBxPTtjO3CbwgfE6DIB6LXl6hYz2A=
X-Google-Smtp-Source: ABdhPJzjKuTh+epTj5FSATkHPUdlZkAtu32PUzfeNKRcR5oIb4mMVRmSAXwtJww3FuIzehctC2Gstt7OAkN8JJpuuG4=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr2567189oih.174.1630405349269;
 Tue, 31 Aug 2021 03:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <cbfc0376461d02867c75cee72bb9167e16f4d0b0.1630396954.git.christophe.leroy@csgroup.eu>
 <YS3t/s9nojyCn9ev@hirez.programming.kicks-ass.net>
In-Reply-To: <YS3t/s9nojyCn9ev@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Aug 2021 12:22:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERf18cKD6v2vDkue4wosqBSnB4B6xjj4yz0H-c7DKyzw@mail.gmail.com>
Message-ID: <CAMj1kXERf18cKD6v2vDkue4wosqBSnB4B6xjj4yz0H-c7DKyzw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Add support for out-of-line static calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 at 10:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 31, 2021 at 08:05:21AM +0000, Christophe Leroy wrote:
>
> > +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)                     \
> > +     asm(".pushsection .text, \"ax\"                         \n"     \
> > +         ".align 4                                           \n"     \
> > +         ".globl " STATIC_CALL_TRAMP_STR(name) "             \n"     \
> > +         STATIC_CALL_TRAMP_STR(name) ":                      \n"     \
> > +         "   blr                                             \n"     \
> > +         "   nop                                             \n"     \
> > +         "   nop                                             \n"     \
> > +         "   nop                                             \n"     \
> > +         ".type " STATIC_CALL_TRAMP_STR(name) ", @function   \n"     \
> > +         ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> > +         ".popsection                                        \n")
>
> > +static int patch_trampoline_32(u32 *addr, unsigned long target)
> > +{
> > +     int err;
> > +
> > +     err = patch_instruction(addr++, ppc_inst(PPC_RAW_LIS(_R12, PPC_HA(target))));
> > +     err |= patch_instruction(addr++, ppc_inst(PPC_RAW_ADDI(_R12, _R12, PPC_LO(target))));
> > +     err |= patch_instruction(addr++, ppc_inst(PPC_RAW_MTCTR(_R12)));
> > +     err |= patch_instruction(addr, ppc_inst(PPC_RAW_BCTR()));
> > +
> > +     return err;
> > +}
>
> There can be concurrent execution and modification; the above doesn't
> look safe in that regard. What happens if you've say, done the first
> two, but not the latter two and execution happens (on a different
> CPU or through IRQ context, etc..)?
>
> > +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> > +{
> > +     int err;
> > +     unsigned long target = (long)func;
> > +
> > +     if (!tramp)
> > +             return;
> > +
> > +     mutex_lock(&text_mutex);
> > +
> > +     if (!func)
> > +             err = patch_instruction(tramp, ppc_inst(PPC_RAW_BLR()));
> > +     else if (is_offset_in_branch_range((long)target - (long)tramp))
> > +             err = patch_branch(tramp, target, 0);
>
> These two are single instruction modifications and I'm assuming the
> hardware is sane enough that execution sees either the old or the new
> instruction. So this should work.
>
> > +     else if (IS_ENABLED(CONFIG_PPC32))
> > +             err = patch_trampoline_32(tramp, target);
> > +     else
> > +             BUILD_BUG();
> > +
> > +     mutex_unlock(&text_mutex);
> > +
> > +     if (err)
> > +             panic("%s: patching failed %pS at %pS\n", __func__, func, tramp);
> > +}
> > +EXPORT_SYMBOL_GPL(arch_static_call_transform);
>
> One possible solution that we explored on ARM64, was having the
> trampoline be in 2 slots:
>
>
>         b 1f
>
> 1:      blr
>         nop
>         nop
>         nop
>
> 2:      blr
>         nop
>         nop
>         nop
>
> Where initially the first slot is active (per "b 1f"), then you write
> the second slot, and as a final act, re-write the initial branch to
> point to slot 2.
>
> Then you execute synchronize_rcu_tasks() under your text mutex
> (careful!) to ensure all users of your slot1 are gone and the next
> modification repeats the whole thing, except for using slot1 etc..
>
> Eventually I think Ard came up with the latest ARM64 proposal which puts
> a literal in a RO section (could be the text section I suppose) and
> loads and branches to that.
>

Yes. The main reason is simply that anything else is premature
optimization: we have a clear use case (CFI) where out-of-line static
calls are faster than compiler generated indirect calls, even if the
static call sequence is based on a literal load and an indirect
branch, but CFI is not upstream [yet].

Once other use cases emerge, we will revisit this.



> Anyway, the thing is, you can really only modify a single instruction at
> the time and need to ensure concurrent execution is correct.
