Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF41432B30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJSA1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:27:53 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16]:34215 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSA1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:27:52 -0400
X-Greylist: delayed 4739 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 20:27:51 EDT
Date:   Tue, 19 Oct 2021 00:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1634603138; bh=cU/f3CXO6Nbi2g/nt9ZeUr6pVfoFWg57QTXnP5pDW8o=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aelsAMwFlhH/uW+mutyk6sR22qJLu2loJ82gLa30t9Krs7PQiw/9cQfhFHZTc2ug7
         xdWbv1o/WTpDTNYI3tLaYGak6ZDLnpPohVeqPu6xe1R4U1DGrb1Tv1U9H+jj3bdYAV
         wfV9jA9okpszsAvHo6NswnD9P/V5o8Lqly8VQtq6SwZ0MviEe1qJunqymSZp5NwpJ9
         W30airNl5oYHDbf4F2tAyZL6PCzFc4tpCmFA0ebXbWtgYH4T2W9Jze4+HZgNKzPm9C
         LuMCBVxgLV5IM+Dl0FCQSx/rxNK4+yyF034ha1Sh6v0F8hMbl2jMCjmCoIHU/RjHRx
         X+z1o4PN6AFPA==
To:     Peter Zijlstra <peterz@infradead.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211019001845.85256-1-alobakin@pm.me>
In-Reply-To: <20211018225905.86034-1-alobakin@pm.me>
References: <20211013122217.304265366@infradead.org> <20211013123645.002402102@infradead.org> <YWmPCF+g+sF4+ieh@zn.tnic> <20211015165635.GH174703@worktop.programming.kicks-ass.net> <20211018225905.86034-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>
Date: Mon, 18 Oct 2021 23:06:35 +0000

Sorry for double posting, should've include this from the start.

> Hi,
>
> Gave it a spin with Clang/LLVM, and
>
> > On Fri, Oct 15, 2021 at 04:24:08PM +0200, Borislav Petkov wrote:
> > > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > > +static int patch_retpoline(void *addr, struct insn *insn, u8 *byte=
s)
> > > > +{
> > > > +=09void (*target)(void);
> > > > +=09int reg, i =3D 0;
> > > > +
> > > > +=09if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > > > +=09=09return -1;
> > > > +
> > > > +=09target =3D addr + insn->length + insn->immediate.value;
> > > > +=09reg =3D (target - &__x86_indirect_thunk_rax) /
> > > > +=09      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
>
> this triggers
>
> > > I guess you should compute those values once so that it doesn't have =
to
> > > do them for each function invocation. And it does them here when I lo=
ok
> > > at the asm it generates.
> >
> > Takes away the simplicity of the thing. It can't know these values at
> > compile time (due to external symbols etc..) although I suppose LTO
> > might be able to fix that.
> >
> > Other than that, the above is the trivial form of reverse indexing an
> > array.
> >
> > > > +
> > > > +=09if (WARN_ON_ONCE(reg & ~0xf))
> > > > +=09=09return -1;
>
> this:
>
> WARN in patch_retpoline:408: addr pcibios_scan_specific_bus+0x196/0x200, =
op 0xe8, reg 0xb88ca
> WARN in patch_retpoline:408: addr xen_pv_teardown_msi_irqs+0x8d/0x120, op=
 0xe8, reg 0xb88ca
> WARN in patch_retpoline:408: addr __mptcp_sockopt_sync+0x7e/0x200, op 0xe=
8, reg 0xb88ca
> [...]
> (thousands of them, but op =3D=3D 0xe8 && reg =3D=3D 0xb88ca are always t=
he same)

SMP alternatives: WARN in patch_retpoline:408: addr __strp_unpause+0x62/0x1=
b0/0xffffffff92d20a12, op 0xe8, reg 0xb88ca
SMP alternatives: insn->length: 5, insn->immediate.value: 0xffae0989
SMP alternatives: target: 0xffffffff928013a0/__x86_indirect_thunk_r11+0x0/0=
x20
SMP alternatives: rax: 0xffffffff9223cd50, target - rax: 0x5c4650
SMP alternatives: rcx - rax: 0x8

Imm value and addr are different each time, the rest are the same.
target is correct and even %pS works on it, but this distance
between r11 and rax thunks (0x5c4650) doesn't look fine, as well as
rcx - rax being 0x8. Thunks are 0x11 sized + alignment, should be
0x20, and it is, according to vmlinux.map. Weird. Amps/&s?

> I know this reg calculation is about to be replaced, but anyway ;)
>
> > > Sanity-checking the alignment of those thunks?
> >
> > Nah, the target address of the instruction; if that's not a retpoline
> > thunk (for whatever raisin) then the computation will not result in a
> > valid reg and we should bail.
> >
> > > > +
> > > > +=09i =3D emit_indirect(insn->opcode.bytes[0], reg, bytes);
> > > > +=09if (i < 0)
> > > > +=09=09return i;
> > > > +
> > > > +=09for (; i < insn->length;)
> > > > +=09=09bytes[i++] =3D BYTES_NOP1;
> > >
> > > Why not:
> > >
> > >         nop_len =3D insn->length - i;
> > >         if (nop_len) {
> > >                 memcpy(&bytes[i], x86_nops[nop_len], nop_len);
> > >                 i +=3D nop_len;
> > >         }
> > >
> > > and then you save yourself the optimize_nops() call because it'll tak=
e
> > > the right-sized NOP directly.
> >
> > That's not immediately safe; if for some reason or other the original
> > instrucion is 15 bytes long, and we generated 2 bytes, then we need 13
> > nop bytes, the above will then do an out-of-bound array access (due to
> > the nops array only doing 8 byte nops at max).
> >
> > I wanted this code to be simple and obvious.
>
> Thanks,
> Al

Thanks,
Al

