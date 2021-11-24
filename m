Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6545C6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354964AbhKXOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355125AbhKXOIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:08:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA3AC61131
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637762054;
        bh=89ve5eFO8r4NmQqnGewI9sZ0aIqfSlaIy4w2WN6dIFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ibi7ljNYdFBRyFN8zJ8ojDjFGjBWbxLu4SGoPAX2WCIICk3xLgFGwt1k6DMjCvrop
         9yJxCZtOPBYm6of1qs2y1XLkdyCQsLMdHP+rYB9MJY53uO6A17X32OGdezD6x6Ei8f
         7ttuXWiXdZ/oHPR2G9cyC4I1553PjPC7qppEuHluwCyaGnOiM/++0vMw3bm3LRBW4k
         tH8a4Wl0cXPRgE79X19Bcc+czx0hKAIcyuGSKyXKzeWWZwtj4Df9tOAcpZb05NOmkg
         yZa8flVCxl+wFJbl/b62rSnU69ns9jLaNc5Ytk99yGEvffM3UulFsrZOcyMYoGWY1E
         obMhFMoavdtvw==
Received: by mail-ot1-f54.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so4329652otm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:54:14 -0800 (PST)
X-Gm-Message-State: AOAM533w3o0Dg9XOB8pORqp3h0UvUMCup+WuaRsEGdpdrnLeAlRiIRj8
        55WE/ucgNJE6GSTeAcdPrvjMdCvoSL/aMUdXKW8=
X-Google-Smtp-Source: ABdhPJxsMnUAhj0BfHNi7qFdJg0D4kmTjT5LlSmzouYEb59aCCuzyyMGlQLf5n/ld4xwVZaccv8q6N7JK6aFkLPiiC4=
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr13498620otp.112.1637762054105;
 Wed, 24 Nov 2021 05:54:14 -0800 (PST)
MIME-Version: 1.0
References: <1637658760-5813-1-git-send-email-huangzhaoyang@gmail.com>
 <CAMj1kXGLRr8bnhLPseW=gSj6kA1TKqAC0Bs0Loj8gkpgaMB8MA@mail.gmail.com>
 <CAGWkznGsus77QT4r5X3qDzP3wHsY+=j8m-7DYfm_s_nd5bWQbQ@mail.gmail.com>
 <CAMj1kXHdOn66wrFs78-g0PXnXZjioSPPwZ1TNsFhWAHeRje+sg@mail.gmail.com> <CAGWkznF1-E8bPcZT59SZy3dvmqf=FmBYbAGGE5J7mrL9UGC=VA@mail.gmail.com>
In-Reply-To: <CAGWkznF1-E8bPcZT59SZy3dvmqf=FmBYbAGGE5J7mrL9UGC=VA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Nov 2021 14:54:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGn-qO5eEer5JmOeGtKQ-mg8iLZ72z1owV8mitVBm+20A@mail.gmail.com>
Message-ID: <CAMj1kXGn-qO5eEer5JmOeGtKQ-mg8iLZ72z1owV8mitVBm+20A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: introduce alloc hook to apply PTE_CONT
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 13:01, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Wed, Nov 24, 2021 at 5:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 24 Nov 2021 at 09:08, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > On Tue, Nov 23, 2021 at 5:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Tue, 23 Nov 2021 at 10:13, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > > > >
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > Since there is no PTE_CONT when rodata_full in ARM64, introducing a
> > > > > hook function to apply PTE_CONT on the proper page blocks.
> > > > >
> > > >
> > > > Given the discussion around your previous patch, I would expect a
> > > > meticulous explanation here why it is guaranteed to be safe to
> > > > manipulate the PTE_CONT attribute like this, and how the proposed
> > > > logic is correct for all supported page sizes.
> > > >
> > > > Without using an intermediate invalid mapping for the entire range,
> > > > this is never going to work reliably (this is the break-before-make
> > > > requirement). And given that marking the entire block invalid will
> > > > create intermediate states that are not permitted (a valid PTE_CONT
> > > > mapping and an invalid ~PTE_CONT mapping covering the same VA), the
> > > > only way to apply changes like these is to temporarily switch all CPUs
> > > > to a different translation via TTBR1. And this is not going to happen.
> > > As there is no safe way to modify PTE_CONT on a live mapping, please
> > > forget all previous patches except current one.
> >
> > OK
> >
> > > >
> > > > Also, you never replied to my question regarding the use case and the
> > > > performance gain.
> > > In our android based system, the multimedia related cases suffers from
> > > small pte granularity mostly which use high order page blocks quite a
> > > lot. The performance gap even be visible.
> >
> > OK, good to know.
> >
> > > >
> > > > In summary, NAK to this patch or any of the previous ones regarding
> > > > PTE_CONT. If you do insist on pursuing this further, please provide an
> > > > elaborate and rock solid explanation why your approach is 100% valid
> > > > and correct (for all page sizes). And make sure you include an
> > > > explanation how your changes comply with the architectural
> > > > break-before-make requirements around PTE_CONT attributes.
> > > IMHO, It is safe to modify the page block's pte undering
> > > *arch_alloc/free_pages* as there is no one else aware of it.
> >
> > Whether the software is 'aware' or not is irrelevant. Speculative
> > accesses could be made at any time, and these will trigger a page
> > table walk if no cached TLB entries exist for the region. If more than
> > one cached TLB entry exists (which would be the case if an adjacent
> > entry has the PTE_CONT attribute but not the entry itself), you will
> > hit a TLB conflict abort.
> Could it be a risk that a speculative load racing with setting pte
> from VALID to INVALID?

Theorizing about what might go wrong is not very useful. The
architecture simply does not permit what you are proposing here, and
this is reason enough not to do it.

The ARM ARM says the following [DDI0487G.a D5.2 "Misprogramming of the
Contiguous bit"]

"""
If one or more of the following errors is made in programming the
translation tables, the TLB might contain overlapping entries:
- One or more of the contiguous translation table entries does not
have the Contiguous bit set to 1.
- One or more of the contiguous translation table entries holds an
output address that is not consistent with all of the entries pointing
to the same aligned contiguous address range.
- The attributes and permissions of the contiguous entries are not all the same.

Such misprogramming of the translation tables means the output
address, memory permissions, or attributes for a lookup might be
corrupted, and might be equal to values that are not consistent with
any of the programmed translation table values.

In some implementations, such misprogramming might also give rise to a
TLB Conflict abort.
"""

This means that none of the entries in the contiguous group are
reliable when only one entry in the group deviates, and in addition to
TLB conflict aborts, you may trigger all kinds of corruption due to
the output address being bogus.

So NAK again.
