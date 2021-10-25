Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA75A439822
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhJYOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233043AbhJYOLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF90260F9D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635170928;
        bh=4IDV4Li+NthHQE7Cm9CxbU5HokFuwFvoby4u50899LU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DiZPSgVE0pXRpaw3LBuzIFlekVTi6TP9h3GfmGF8nS9FF+n4S1gdtm0Y+P8ahhINC
         h+Cm91caEneZPz/dPrZL65UKFQByCJOuaoriecgEb0w5r0lcww/hLTbNfRTnJQpmUW
         OkEgvwdwt8/Qpwi9VUqdg+Qg+mZKZTbK0tTu0+Aa21ydkeUZGEymvRqcLx79u4JIbM
         YBGowQSXYF1+4159LI7eceL1xzkCK56zqV+R5h7uFSoXtHy+S8anjtwww5gGdnW4AJ
         Nzo/GI5QoGKYUJxm6UqwsVT/OSkmj09LFe1XAn37VNLsZQ/in5k/qjoS4bAdsX/oWw
         enq1i7FgL82IA==
Received: by mail-oo1-f53.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so3692960oop.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:08:48 -0700 (PDT)
X-Gm-Message-State: AOAM530CRYxeFDAThHyLqAZz8nB3DbqlKwtJlYlVk0XQL13HQguI2tU+
        zUBG7F1jk9VbM0OhpA9CvWPoDQAPBT5MyZeBukE=
X-Google-Smtp-Source: ABdhPJx7l1O965y3C3W2pev8xxdXroENygFBTQNoupg7ZF4peN4Bjsd25Nuy/iFGN/Mx/65oiqKtrk+0xQ/5+8FYLRA=
X-Received: by 2002:a4a:3e11:: with SMTP id t17mr12272683oot.32.1635170928103;
 Mon, 25 Oct 2021 07:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211025122102.46089-1-frederic@kernel.org> <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
In-Reply-To: <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 Oct 2021 16:08:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
Message-ID: <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 15:57, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 25, 2021 at 02:21:00PM +0200, Frederic Weisbecker wrote:
>
> > +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insn)                      \
> > +     asm("   .pushsection    .static_call.text, \"ax\"               \n" \
> > +         "   .align          4                                       \n" \
> > +         "   .globl          " STATIC_CALL_TRAMP_STR(name) "         \n" \
> > +         "0: .quad   0x0                                             \n" \
> > +         STATIC_CALL_TRAMP_STR(name) ":                              \n" \
> > +         "   hint    34      /* BTI C */                             \n" \
> > +             insn "                                                  \n" \
> > +         "   ldr     x16, 0b                                         \n" \
> > +         "   cbz     x16, 1f                                         \n" \
> > +         "   br      x16                                             \n" \
> > +         "1: ret                                                     \n" \
> > +         "   .popsection                                             \n")
>
> > +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
> > +{
> > +     /*
> > +      * -0x8 <literal>
> > +      *  0x0 bti c           <--- trampoline entry point
> > +      *  0x4 <branch or nop>
> > +      *  0x8 ldr x16, <literal>
> > +      *  0xc cbz x16, 20
> > +      * 0x10 br x16
> > +      * 0x14 ret
> > +      */
> > +     struct {
> > +             u64     literal;
> > +             __le32  insn[2];
> > +     } insns;
> > +     u32 insn;
> > +     int ret;
> > +
> > +     insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_BTIC);
> > +     insns.literal = (u64)func;
> > +     insns.insn[0] = cpu_to_le32(insn);
> > +
> > +     if (!func) {
> > +             insn = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_LR,
> > +                                                AARCH64_INSN_BRANCH_RETURN);
> > +     } else {
> > +             insn = aarch64_insn_gen_branch_imm((u64)tramp + 4, (u64)func,
> > +                                                AARCH64_INSN_BRANCH_NOLINK);
> > +
> > +             /*
> > +              * Use a NOP if the branch target is out of range, and rely on
> > +              * the indirect call instead.
> > +              */
> > +             if (insn == AARCH64_BREAK_FAULT)
> > +                     insn = aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
> > +     }
> > +     insns.insn[1] = cpu_to_le32(insn);
> > +
> > +     ret = __aarch64_insn_write(tramp - 8, &insns, sizeof(insns));
>
> OK, that's pretty magical...
>
> So you're writing the literal and the two instructions with 2 u64
> stores. Relying on alignment to guarantee both are in a single page and
> that copy_to_kernel_nofault() selects u64 writes.
>

To be honest, it just seemed tidier and less likely to produce weird
corner cases to put the literal and the patched insn in the smallest
possible power-of-2 aligned window, as it ensures that the D-side view
is always consistent.

However, the actual fetch of the instruction could still produce a
stale value before the cache maintenance completes.

> By unconditionally writing the literal, you avoid there ever being an
> stale value, which in turn avoids there being a race where you switch
> from 'J @func' relative addressing to 'NOP; do-literal-thing' and cross
> CPU execution gets the ordering inverted.
>

Indeed.

> Ooohh, but what if you go from !func to NOP.
>
> assuming:
>
>         .literal = 0
>         BTI C
>         RET
>
> Then
>
>         CPU0                    CPU1
>
>         [S] literal = func      [I] NOP
>         [S] insn[1] = NOP       [L] x16 = literal (NULL)
>                                 b x16
>                                 *BANG*
>
> Is that possible? (total lack of memory ordering etc..)
>

The CBZ will branch to the RET instruction if x16 == 0x0, so this
should not happen.

> On IRC you just alluded to the fact that this relies on it all being in
> a single cacheline (i-fetch windows don't need to be cacheline sized,
> but provided they're at least 16 bytes, this should still work given the
> alignment).
>
> But is I$ and D$ coherent? One load is through I-fetch, the other is a
> regular D-fetch.
>
> However, Will has previously expressed reluctance to rely on such
> things.
>

No they are not. That is why the CBZ is there. So the only issue we
might see is where the branch instruction is out of sync with the
literal, and so we may call the old function while switching to the
new one and the I-cache maintenance hasn't completed yet.

> > +     if (!WARN_ON(ret))
> > +             caches_clean_inval_pou((u64)tramp - 8, sizeof(insns));
> >  }
