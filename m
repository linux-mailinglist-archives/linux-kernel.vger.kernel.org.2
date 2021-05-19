Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780038951C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhESSOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhESSOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:14:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91AD4611BF;
        Wed, 19 May 2021 18:12:59 +0000 (UTC)
Date:   Wed, 19 May 2021 19:12:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] kasan: speed up mte_set_mem_tag_range
Message-ID: <20210519181225.GF21619@arm.com>
References: <20210517235546.3038875-1-eugenis@google.com>
 <20210518174439.GA28491@arm.com>
 <CAMn1gO5TmJZ4M4EyQ60VMc2-acUZSYkaB9M0C9kOv_dXQe54Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO5TmJZ4M4EyQ60VMc2-acUZSYkaB9M0C9kOv_dXQe54Ug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:11:52AM -0700, Peter Collingbourne wrote:
> On Tue, May 18, 2021 at 10:44 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > If we want to get the best performance out of this, we should look at
> > the memset implementation and do something similar. In principle it's
> > not that far from a memzero, though depending on the microarchitecture
> > it may behave slightly differently.
> 
> For Scudo I compared our storeTags implementation linked above against
> __mtag_tag_zero_region from the arm-optimized-routines repository
> (which I think is basically an improved version of that memset
> implementation rewritten to use STG and DC GZVA), and our
> implementation performed better on the hardware that we have access
> to.

That's the advantage of having hardware early ;).

> > Anyway, before that I wonder if we wrote all this in C + inline asm
> > (three while loops or maybe two and some goto), what's the performance
> > difference? It has the advantage of being easier to maintain even if we
> > used some C macros to generate gva/gzva variants.
> 
> I'm not sure I agree that it will be easier to maintain. Due to the
> number of "unusual" instructions required here it seems more readable
> to have the code in pure assembly than to require readers to switch
> contexts between C and asm. If we did move it to inline asm then I
> think it should basically be a large blob of asm like the Scudo code
> that I linked.

I was definitely not thinking of a big asm block, that's even less
readable than separate .S file. It's more like adding dedicated macros
for single STG or DC GVA uses and using them in while loops.

Anyway, let's see a better commented .S implementation first. Given that
tagging is very sensitive to the performance of this function, we'd
probably benefit from a (few percent I suspect) perf improvement with
the hand-coded assembly.

-- 
Catalin
