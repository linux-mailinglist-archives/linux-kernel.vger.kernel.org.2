Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981094332D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhJSJtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:49:49 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:46249 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhJSJtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:49:47 -0400
Date:   Tue, 19 Oct 2021 09:47:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1634636852; bh=iTes/LS2at5n4b3JbFfDhTVYmIXqtWhyKtjvRl5h1lk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=epp2TtqpMqsLGYPPx9w/sOx6AAYZdDsmJKSvQ2p7TQhojEJA+9t2RJF3Pm4LlIpwN
         zticrAFZfiOokSeDz9zm6ZRZBye+91Q267sm5FEvU+PLu8M/lkxfHSZjXlm8fpOrxR
         wpagntqEY+CLq4TRaf0Q6NpqZxckkdWIdj/x6JicNkZw+Jf8YVfwqevEcI0QooHrVI
         EVjvTNaKhKW95ux6MFhfBqNa5ikRgps8L050ouXo1R6q/0Ke1+2O+mpjWNden/Chfe
         mof9bWorqAarlexlKPySQ6EJc9aTymvtxiVNvVZWhC9G4Lq/dcs4rKpGwznOsDJ4BU
         KB529DmhP8vDA==
To:     Peter Zijlstra <peterz@infradead.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211019094038.80569-1-alobakin@pm.me>
In-Reply-To: <20211019001845.85256-1-alobakin@pm.me>
References: <20211013122217.304265366@infradead.org> <20211013123645.002402102@infradead.org> <YWmPCF+g+sF4+ieh@zn.tnic> <20211015165635.GH174703@worktop.programming.kicks-ass.net> <20211018225905.86034-1-alobakin@pm.me> <20211019001845.85256-1-alobakin@pm.me>
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
Date: Tue, 19 Oct 2021 00:25:30 +0000

> From: Alexander Lobakin <alobakin@pm.me>
> Date: Mon, 18 Oct 2021 23:06:35 +0000
>
> Sorry for double posting, should've include this from the start.
>
> > Hi,
> >
> > Gave it a spin with Clang/LLVM, and
> >
> > > On Fri, Oct 15, 2021 at 04:24:08PM +0200, Borislav Petkov wrote:
> > > > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > > > +static int patch_retpoline(void *addr, struct insn *insn, u8 *by=
tes)
> > > > > +{
> > > > > +=09void (*target)(void);
> > > > > +=09int reg, i =3D 0;
> > > > > +
> > > > > +=09if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > > > > +=09=09return -1;
> > > > > +
> > > > > +=09target =3D addr + insn->length + insn->immediate.value;
> > > > > +=09reg =3D (target - &__x86_indirect_thunk_rax) /
> > > > > +=09      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax)=
;
> >
> > this triggers
> >
> > > > I guess you should compute those values once so that it doesn't hav=
e to
> > > > do them for each function invocation. And it does them here when I =
look
> > > > at the asm it generates.
> > >
> > > Takes away the simplicity of the thing. It can't know these values at
> > > compile time (due to external symbols etc..) although I suppose LTO
> > > might be able to fix that.
> > >
> > > Other than that, the above is the trivial form of reverse indexing an
> > > array.
> > >
> > > > > +
> > > > > +=09if (WARN_ON_ONCE(reg & ~0xf))
> > > > > +=09=09return -1;
> >
> > this:
> >
> > WARN in patch_retpoline:408: addr pcibios_scan_specific_bus+0x196/0x200=
, op 0xe8, reg 0xb88ca
> > WARN in patch_retpoline:408: addr xen_pv_teardown_msi_irqs+0x8d/0x120, =
op 0xe8, reg 0xb88ca
> > WARN in patch_retpoline:408: addr __mptcp_sockopt_sync+0x7e/0x200, op 0=
xe8, reg 0xb88ca
> > [...]
> > (thousands of them, but op =3D=3D 0xe8 && reg =3D=3D 0xb88ca are always=
 the same)
>
> SMP alternatives: WARN in patch_retpoline:408: addr __strp_unpause+0x62/0=
x1b0/0xffffffff92d20a12, op 0xe8, reg 0xb88ca
> SMP alternatives: insn->length: 5, insn->immediate.value: 0xffae0989
> SMP alternatives: target: 0xffffffff928013a0/__x86_indirect_thunk_r11+0x0=
/0x20
> SMP alternatives: rax: 0xffffffff9223cd50, target - rax: 0x5c4650
> SMP alternatives: rcx - rax: 0x8
>
> Imm value and addr are different each time, the rest are the same.
> target is correct and even %pS works on it, but this distance
> between r11 and rax thunks (0x5c4650) doesn't look fine, as well as
> rcx - rax being 0x8. Thunks are 0x11 sized + alignment, should be
> 0x20, and it is, according to vmlinux.map. Weird. Amps/&s?

Oh okay, it's because of ClangCFI:

SMP alternatives: You were looking for __typeid__ZTSFvvE_global_addr+0x370/=
0x1410 at 0xffffffffa523cd60,>
SMP alternatives: rax is __typeid__ZTSFvvE_global_addr+0x360/0x1410 at 0xff=
ffffffa523cd50

Sorry for confusing, seems like it's a side effect of using it on
Clang 12 while the original series supports only 13+. I'll double
check and let know if find something.

[ snip ]

Thanks,
Al

