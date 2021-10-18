Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6E4329FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 01:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJRXIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 19:08:55 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:45318 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRXIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 19:08:54 -0400
Date:   Mon, 18 Oct 2021 23:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1634598399; bh=p9xeULJfISzpOHWDGuqzA/KQVTVWoZqXIhPeJUdzFgQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=U0BzjdHXt8PMLKtE1Y36b/f8FBXwRZ5NYpQm2HolgpOVqAyCFitAQ7zZnpo8Lo8Ke
         5ix9Ho8pZkYx5R/0vYJmj+Wq92Hg4Gu1OF1m3lAa9DUyRxTGzHgtQrGQfVj5Y4gL9U
         sfnRT6BZXvsMvJ04OD4AfG0Oq5bc5+ARCaxu7TZEmMYwz1BF6N48k6ldWHIQqM1q0J
         FnT2ptICEwx2r9khC+buviR7LXaH0DWHn/koP1/dlGoqNRZapy1BoN1ckzoLCUt7ub
         klHtNoPWXNaRJwhfmvTAHxBQL7Y9fxlzQarqAbY1qiCDJD1jbSq60oH7XlxTYqPr29
         R3+HhT8ZzzyYg==
To:     Peter Zijlstra <peterz@infradead.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211018225905.86034-1-alobakin@pm.me>
In-Reply-To: <20211015165635.GH174703@worktop.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org> <20211013123645.002402102@infradead.org> <YWmPCF+g+sF4+ieh@zn.tnic> <20211015165635.GH174703@worktop.programming.kicks-ass.net>
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

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 15 Oct 2021 18:56:35 +0200

Hi,

Gave it a spin with Clang/LLVM, and

> On Fri, Oct 15, 2021 at 04:24:08PM +0200, Borislav Petkov wrote:
> > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > > +{
> > > +=09void (*target)(void);
> > > +=09int reg, i =3D 0;
> > > +
> > > +=09if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > > +=09=09return -1;
> > > +
> > > +=09target =3D addr + insn->length + insn->immediate.value;
> > > +=09reg =3D (target - &__x86_indirect_thunk_rax) /
> > > +=09      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);

this triggers

> > I guess you should compute those values once so that it doesn't have to
> > do them for each function invocation. And it does them here when I look
> > at the asm it generates.
>
> Takes away the simplicity of the thing. It can't know these values at
> compile time (due to external symbols etc..) although I suppose LTO
> might be able to fix that.
>
> Other than that, the above is the trivial form of reverse indexing an
> array.
>
> > > +
> > > +=09if (WARN_ON_ONCE(reg & ~0xf))
> > > +=09=09return -1;

this:

WARN in patch_retpoline:408: addr pcibios_scan_specific_bus+0x196/0x200, op=
 0xe8, reg 0xb88ca
WARN in patch_retpoline:408: addr xen_pv_teardown_msi_irqs+0x8d/0x120, op 0=
xe8, reg 0xb88ca
WARN in patch_retpoline:408: addr __mptcp_sockopt_sync+0x7e/0x200, op 0xe8,=
 reg 0xb88ca
[...]
(thousands of them, but op =3D=3D 0xe8 && reg =3D=3D 0xb88ca are always the=
 same)

I know this reg calculation is about to be replaced, but anyway ;)

> > Sanity-checking the alignment of those thunks?
>
> Nah, the target address of the instruction; if that's not a retpoline
> thunk (for whatever raisin) then the computation will not result in a
> valid reg and we should bail.
>
> > > +
> > > +=09i =3D emit_indirect(insn->opcode.bytes[0], reg, bytes);
> > > +=09if (i < 0)
> > > +=09=09return i;
> > > +
> > > +=09for (; i < insn->length;)
> > > +=09=09bytes[i++] =3D BYTES_NOP1;
> >
> > Why not:
> >
> >         nop_len =3D insn->length - i;
> >         if (nop_len) {
> >                 memcpy(&bytes[i], x86_nops[nop_len], nop_len);
> >                 i +=3D nop_len;
> >         }
> >
> > and then you save yourself the optimize_nops() call because it'll take
> > the right-sized NOP directly.
>
> That's not immediately safe; if for some reason or other the original
> instrucion is 15 bytes long, and we generated 2 bytes, then we need 13
> nop bytes, the above will then do an out-of-bound array access (due to
> the nops array only doing 8 byte nops at max).
>
> I wanted this code to be simple and obvious.

Thanks,
Al

