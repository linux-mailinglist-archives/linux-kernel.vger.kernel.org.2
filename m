Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6155433D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhJSRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhJSRh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:37:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68CA261354;
        Tue, 19 Oct 2021 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664943;
        bh=q9xjKEzI1+duipt5OANPox9tf8qby25kRaIJ/mILN6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iI3BeSSwZceP6uTe+dwvRxuv0TYsXHFoJkjJSmjOH7QEZSFeqgsrnRACsHj2ore1A
         1pKadda1j2+32HgOnV2IXSgR0UtExzVuzCI1f4fT9ASUy1FeFG7Mgpdmrh0XroKoAa
         aj/Pv56K6mFvNwm2fqpRmMeFysHGswQiq/ly0pjVXW436cZXkBvJIWqPkBzl8ml1qv
         Jommkhrc2u6DvIJwEOIEtmwhupZzZJvd3oXeuRvh57DquOXheq+feg+A69iXck+f1X
         LuAOXkIVqjnDYg2vb3dC6aa2YspCSBUnlKTmxVKUq+yX5zX5zpCVAT8lV3K0xw+jQV
         bnh+qtp36xx/Q==
Date:   Tue, 19 Oct 2021 10:35:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>,
        =?iso-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical
 warning
Message-ID: <YW8B6yMdnIJnFkHE@archlinux-ax161>
References: <20211018182537.2316800-1-nathan@kernel.org>
 <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
 <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
 <CAKwvOd=wGjd_L1703Y9Kngcr9-_wTvcRLToiydXYkR=S_9xWDw@mail.gmail.com>
 <CAHk-=wjwOnrHXDSqnmhiKujk=5XieJFvfnQwc2WKOKFwzcqvaA@mail.gmail.com>
 <YW5Q253s0Y+zYxdi@archlinux-ax161>
 <CAHk-=wi-UJAGo6uwYx8XKydSEsnQ33mW4t+kUnb+CNY+Oxobjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-UJAGo6uwYx8XKydSEsnQ33mW4t+kUnb+CNY+Oxobjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming up the replies as we are not really talking about the x86
platform drivers warning anymore.

On Mon, Oct 18, 2021 at 08:27:02PM -1000, Linus Torvalds wrote:
> On Mon, Oct 18, 2021 at 7:00 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > For what it's worth, the suggested fix is the '||' underneath the
> > warning text:
> >
> > In file included from arch/x86/kvm/mmu/tdp_iter.c:5:
> > arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >         return __is_bad_mt_xwr(rsvd_check, spte) |
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                                  ||
> > arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
> > 1 error generated.
> 
> Hmm. That's not at all obvious.

I agree, hence the question added to the warning.

> The *much* bigger part is that
> 
>    note: cast one or both operands to int to silence this warning
> 
> which is what I'm complaining about. That note should die. It should
> say "maybe you meant to use a logical or" or something like that.
> 
> > Perhaps that hint should also be added to the warning text, like:
> >
> > In file included from arch/x86/kvm/mmu/tdp_iter.c:5:
> > arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands; did you mean logical '||'? [-Werror,-Wbitwise-instead-of-logical]
> >         return __is_bad_mt_xwr(rsvd_check, spte) |
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >                                                  ||
> > arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
> 
> I don't understand why you seem to continue to ignore the "note"
> message, which makes a completely crazy suggestion.

Sorry, I was not intentionally ignoring the note. As far as I understand
it, it is fairly common for clang to offer a fix up in case the answer
to the question of "did you mean to do this?" is "no" but also offer a
way to shut the warning up in case the answer is "yes, I know what I am
doing", hence the note about casting.

Changing to logical OR is not always the answer, as something like

    int a, b, c;

    changed = foo(&a) | foo(&b) | foo(&c);
    if (changed)
        bar(a, b, c);

no longer works. It could be changed to

    int a, b, c;

    changed = foo(&a);
    changed |= foo(&b);
    changed |= foo(&c);
    if (changed)
        baz(a, b, c);

to make it clearer to both humans and the compiler that every call to
foo() needs to happen and the results are being aggregated. With that,
perhaps the note could be changed to something like:

note: separate expressions with '|=' to silence this warning

Although, that would require that the expression was being assigned to a
variable, rather than being returned or used in a loop like the KVM one
or this other one that is seen in fs/namei.c on big endian ARM
configurations with CONFIG_DCACHE_WORD_ACCESS because has_zero() returns
bool instead of unsigned long on little endian architectures:

fs/namei.c:2149:13: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
        } while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constants)));
                  ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                   ||
fs/namei.c:2149:13: note: cast one or both operands to int to silence this warning
1 warning generated.

Perhaps the note should just be eliminated entirely so that developers
can be left to try and figure out a way to silence it on their own or
just rework the code to use logical OR or not use boolean types, I do
not know.

There was some discussion upstream around how the warning should be
silenced during the warning's creation. I have added the author of the
warning, David, to this thread to see if he has any insights.

David, you can see the start of this thread here and follow along with
the threading at the bottom:

https://lore.kernel.org/r/CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com/

Cheers,
Nathan
