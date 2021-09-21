Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5841358A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhIUOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233602AbhIUOqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:46:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13DDC60F6E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632235508;
        bh=yw0Lb+r3sKAkv29z7Ae8zME50OqwTA4KGuEpEDmu8is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDjtbQRd/Ynw2hUGVI77ILO3A8Z49AgAMHpoM//kZ//QMVd7kNc3ZIeBzfuq8VRjy
         CFs5A61KuDssQUVOZ3J3e+jQkpE+pKnpkJqOiMfNLv4YSGFeTShrfl+epDxDZU5DeR
         z1x0eD8MeMhGvf88S+kB/1NAG26vL1xe3rBg5CA2RaW3YX5wKvSROn7R+lfJwtLjkj
         1ckFY85O5HrdUfLfQcTrZD20jkrkbWkXlC3TdEOnDoCXMgddyJzUThK8jc1VKHymP0
         uB8ZPZeAPReIjiLA+Az1JgHmQ9HtBBwWyaRsURp9BVaKhOJ3CAOqr1oKOl/1dMtMMR
         elvDjLLJLnI9g==
Received: by mail-ot1-f41.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso28669658otu.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:45:08 -0700 (PDT)
X-Gm-Message-State: AOAM531TYGJhbgk62MwcZ2LB1HDZm4vpnjJ9/jWJrodDDP7ngR+tSDcg
        WMX7SgoGUG8smX1pnyv2hV/9tOxNvxZyLE/089Q=
X-Google-Smtp-Source: ABdhPJxzhaFpEHaUYGpYqT73Ch6XfxzKGGr0FrNAXmC0d2Pfq1K/ay1nmTehLxy5KmnYVSbI5b8KKhtvbeYImDIGqSE=
X-Received: by 2002:a05:6830:3189:: with SMTP id p9mr23036206ots.147.1632235507451;
 Tue, 21 Sep 2021 07:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210920233237.90463-1-frederic@kernel.org> <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
In-Reply-To: <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Sep 2021 16:44:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
Message-ID: <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Sep 21, 2021 at 01:32:35AM +0200, Frederic Weisbecker wrote:
>
> > +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)                            \
> > +     asm("   .pushsection    .static_call.text, \"ax\"               \n" \
> > +         "   .align          3                                       \n" \
> > +         "   .globl          " STATIC_CALL_TRAMP_STR(name) "         \n" \
> > +         STATIC_CALL_TRAMP_STR(name) ":                              \n" \
> > +         "   hint    34      /* BTI C */                             \n" \
> > +         "   adrp    x16, 1f                                         \n" \
> > +         "   ldr     x16, [x16, :lo12:1f]                            \n" \
> > +         "   cbz     x16, 0f                                         \n" \
> > +         "   br      x16                                             \n" \
> > +         "0: ret                                                     \n" \
> > +         "   .popsection                                             \n" \
> > +         "   .pushsection    .rodata, \"a\"                          \n" \
> > +         "   .align          3                                       \n" \
> > +         "1: .quad           " target "                              \n" \
> > +         "   .popsection                                             \n")
>
> So I like what Christophe did for PPC32:
>
>   https://lkml.kernel.org/r/6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu
>
> Where he starts with an unconditional jmp and uses that IFF the offset
> fits and only does the data load when it doesn't. Ard, woulnd't that
> also make sense on ARM64? I'm thinking most in-kernel function pointers
> would actually fit, it's just the module muck that gets to have too
> large pointers, no?
>

Yeah, I'd have to page that back in. But it seems like the following

  bti c
  <branch>
  adrp x16, <literal>
  ldr x16, [x16, ...]
  br x16

with <branch> either set to 'b target' for the near targets, 'ret' for
the NULL target, and 'nop' for the far targets should work, and the
architecture permits patching branches into NOPs and vice versa
without special synchronization. But I must be missing something here,
or why did we have that long discussion before?
