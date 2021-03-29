Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF034D9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhC2WJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC2WI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:08:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01F6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:08:58 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u4so17652063ljo.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hqJn9c4uBNS7Nw3mlhlHUN2tIf4nHDC4lxd48hV+Bg=;
        b=NATCpKJD028PexAZ95r7O4V42dvoqGDbRjt952XeaXwa5AV2sEOEAiu3Z+BLFax+bc
         hM2Iwen39Y9vdBxk38LEMiAuED4SCRFV0QwDmoOW5015gbltyjC0t/WK0rVG/2u6nZaT
         t3cyJdmKIKYysFskqhVxWCokdprccf7P4VB7MSIL03rbLHhjPVEAXBPm33kQ27oEZrNN
         cCM9bZKwAsWsBhDhkSwds75P0VWI8YdbEt1186ZVoJ1146p88WcZSirU38REsS8DSj7B
         bx8BwkfqhKoDpgNpqlWShLQXVv6u3DCOQbpGY5L5/D3HNxokM1IrcbDagLDPoSapDrkN
         eaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hqJn9c4uBNS7Nw3mlhlHUN2tIf4nHDC4lxd48hV+Bg=;
        b=Q5Bvnmsye1sHxVtjV3R9/16GvIP3ziEw4CukuDQL6ZPb80McJTaF2hPeLk8HW0ytb/
         g1x6snPa1O+r9ASzmucusTv073j5wo80Yej1/7ZZyr4n0uWmIOPNDGoKZ822AfZ4KzWX
         JLBMIPW9rvOmMe85ipEPgqnxu23iZDDSlIQXQxA2DAmxAr4CJwSW+0o8Ik8mWSxGsVpm
         RLPjp7XApS50bWdIVDaZcULUawgxb5mIV0/uw2zE9K2Cwr4OwYD3WOnZ0h8WsltujnNu
         av86eEoTMIyybSPjCS4ab2gU1k/yFApcONSxzTL65IAoeLCwrbE6WQP75ArgPHtWOQjI
         NP0Q==
X-Gm-Message-State: AOAM531GVpy+kpyPDYO688MtKPG/ZAE1w1yzrPXYP9VUmQ+tLhpY5ebt
        cUatWXkQXbyqChZq82r5MCPdm7VYjveaz/9NIg7NRQ==
X-Google-Smtp-Source: ABdhPJxrj4/ghvQEemY8nKzLZ/kJMsgUWqniXLMuDt4HjRd2SoF5hUX+pLiPmHeVlvJJNuY9rhn0kbKGjt1Uty8mpYU=
X-Received: by 2002:a2e:868e:: with SMTP id l14mr19560955lji.479.1617055736955;
 Mon, 29 Mar 2021 15:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
 <20210128193422.241155-1-ndesaulniers@google.com> <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
 <CAKwvOdneTwx8LwKyAA+iMELEBWBxu2nkr9dVuQ=+hgsZROu-tw@mail.gmail.com> <CAMj1kXFh9GGReghFaZkCi0TNOBFjF+Nv_H6vj8pKmN4Rdth3Dg@mail.gmail.com>
In-Reply-To: <CAMj1kXFh9GGReghFaZkCi0TNOBFjF+Nv_H6vj8pKmN4Rdth3Dg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Mar 2021 15:08:45 -0700
Message-ID: <CAKwvOdkv9714jdhHuc7o90TY_sOKSe1J+NmwcxBxEaX-haJk0w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: rewrite test-[arm|thumb].c in UAL
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephen Hines <srhines@google.com>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 1:40 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 29 Jan 2021 at 01:22, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > > On Thu, 28 Jan 2021 at 20:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > +       TEST_RX("tbh    [pc, r",7, (9f-(1f+4))>>1,", lsl #1]",
> > > >
> > > On Thu, Jan 28, 2021 at 1:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > Why is this change needed? Are the resulting opcodes equivalent? Does
> > > GAS infer the lsl #1 but Clang doesn't?
> >
> > Yes; it seems if you serialize/deserialize this using GNU `as` and
> > objdump, that's the canonical form (GNU objdump seems to print in UAL
> > form, IIUC).  I didn't see anything specifically about `tbh` in
> > https://developer.arm.com/documentation/dui0473/c/writing-arm-assembly-language/assembly-language-changes-after-rvctv2-1?lang=en
> > but it's what GNU objdump produces and what clang's integrated
> > assembler accepts.
> >
>
> This matches the ARM ARM: TBB and TBH are indexed table lookups, where
> the table consists of 16-bit quantities in the latter case, and so the
> LSL #1 is implied.

(Sorry, more time to look into thumb2 now, revisiting this)

Then I would have expected it to be stated that the operand is
implicit in the Arm ARM or use the curly brace notation for the
optional operands (see "F5.1.167 RSB, RSBS (register)" for an example
of what I'm talking about. AFAICT, there's no such language in the Arm
ARM about TBH. This is also what GNU binutils' objdump spits out when
disassembled.  And TBB differs from TBH in regards to this operand;
TBH has it, TBB does not.  It's not clear to me whether these
shorthands are intentional (pseudo ops) vs unintentional (parsing
bugs) in GAS.

>
> > > >
> > > >  #define _DATA_PROCESSING32_DNM(op,s,val)                                       \
> > > > -       TEST_RR(op s".w r0,  r",1, VAL1,", r",2, val, "")                       \
> > > > +       TEST_RR(op s"   r0,  r",1, VAL1,", r",2, val, "")                       \
> > >
> > > What is wrong with these .w suffixes? Shouldn't the assembler accept
> > > these even on instructions that only exist in a wide encoding?
> >
> > Yeah, I'm not sure these have anything to do with UAL.  Looking at
> > LLVM's sources and IIRC, LLVM has "InstAlias"es it uses for .w
> > suffixes. I think I need to fix those in LLVM for a couple
> > instructions, rather than modify these in kernel sources.  I'll split
> > off the arm-test.c and thumb-test.c into separate patches, fix LLVM,
> > and drop the .w suffix changes to thumb-test.c.
> >
>
> The ARM ARM (DDI0487G.a F1.2) clearly specifies that any instruction
> documented as supporting the optional {q} suffix (which is almost all
> if not all of them) can be issued with the .w appended, even if doing
> so is redundant (note that it even documents this as being supported
> for the A32 ISA, which GAS does not implement today either)
>
> Given how we often use this suffix to ensure that the opcode fills the
> expected amount of space (for things like jump tables, etc), we cannot
> simply drop these left and right and expect things to still work.

I understand fixed in:
* BL+DBG:   https://reviews.llvm.org/D97236
* ORN/ORNS: https://reviews.llvm.org/D99538
* RSB/RSBS: https://reviews.llvm.org/D99542

-- 
Thanks,
~Nick Desaulniers
