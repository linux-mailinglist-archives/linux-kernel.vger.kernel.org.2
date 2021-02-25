Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FE325357
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhBYQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234039AbhBYQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:13:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70CFF64F1C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614269541;
        bh=6a6+Lo7ZD5NJqz85anc9huPjV9zOLA0n8oW58t+rASI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g2xHbCzS7K5oeElbqa8lJS6EIMGvw7gud8LeoZQHkofQtzZ+D8Z1Jum+9vnKozsSA
         toCYrhfXzPgTSDHOyZrlSsghEPPBHw7rhyK3D1dDJF/+QDZU5lst6wACGfVhA6KZHb
         jqzt1zacWpAtgIhHGuyNlmB5zsW/kFYENUtJmWmdZWB414B9hh2v7MymyL2tVHvO+p
         zayc+RAvf/Aprfw008Xjaq/qXu2X5p5hEO/ycpFJUKK6yW4siACoRvbqAmggPhC+lx
         ZEsxZ0WKF9W67IOQas9q4TsXz+wxLEMKIhv5b3TFW1hkC40+uYnUlR75uepSIB6U5J
         iIqGJ2ObSTe9Q==
Received: by mail-oi1-f169.google.com with SMTP id l64so6551706oig.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:12:21 -0800 (PST)
X-Gm-Message-State: AOAM532pyKt/JVVwAHkRyv2W+UpTPstgBzc2MMmW4QeswFe5aEDexpqV
        pmgkxD4C+lDbzd4y/0NumAirxbsM7q0+0X0G8ok=
X-Google-Smtp-Source: ABdhPJz7vXBtHKuL54uoi+53wDxQ9XweckJQCH12YtjWdIo7GdigmprZ5jbWbaHOYJLwr7bOjyu3pbe/mPEKbXXEDiE=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr2254102oia.67.1614269540490;
 Thu, 25 Feb 2021 08:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20210225133808.2188581-1-arnd@kernel.org> <60989b76-1ae6-6be3-0277-df9f0cc8dc3e@redhat.com>
 <CAK8P3a0W5F14uW+0jqkNAxcXfODhK9_1L-DXnC_h2yrev13aAA@mail.gmail.com> <20210225150757.GK1447004@kernel.org>
In-Reply-To: <20210225150757.GK1447004@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 17:12:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1N_YCBcU=-fUBUVvb=Yz=HD9BjHNiDGtjatY00Q1PrLg@mail.gmail.com>
Message-ID: <CAK8P3a1N_YCBcU=-fUBUVvb=Yz=HD9BjHNiDGtjatY00Q1PrLg@mail.gmail.com>
Subject: Re: [PATCH] memblock: fix section mismatch warning
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Aslan Bakirov <aslan@fb.com>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 4:08 PM Mike Rapoport <rppt@kernel.org> wrote:
> On Thu, Feb 25, 2021 at 03:06:27PM +0100, Arnd Bergmann wrote:
> > On Thu, Feb 25, 2021 at 2:47 PM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > (I don't see why to not inline that function, but I am obviously not a
> > > compiler person :) )
> >
> > Looking at the assembler output in the arm64 build that triggered the
> > warning, I see this code:
>
> "push %rbp" seems more x86 for me, but that's not really important :)

I suppose the relocation names like "R_X86_64_32S" and the command
line I used should could have told me the same ;-)

> I wonder what happens with other memblock inline APIs, particularly with
> alloc wrappers. Do they still get inlined?

Trying the same configuration here, with all the allocation functions
marked __init again, they all get inlined by clang, regardless of the
'__init' and 'inline' and '__always_inline' tags.

With gcc-7 and gcc-10 one instance of the plain 'memblock_alloc' does not
get fully inlined if I revert the __always_inline back to plain inline:

        .type   memblock_alloc.constprop.0, @function
memblock_alloc.constprop.0:
.LASANPC4090:
        pushq   %rbp    #
# include/linux/memblock.h:407: static inline __init void
*memblock_alloc(phys_addr_t size, phys_addr_t align)
        movq    %rdi, %rbp      # tmp84, size
# include/linux/memblock.h:409:    return memblock_alloc_try_nid(size,
align, MEMBLOCK_LOW_LIMIT,
        call    __sanitizer_cov_trace_pc        #
        movq    %rbp, %rdi      # size,
        orl     $-1, %r8d       #,
        xorl    %ecx, %ecx      #
        xorl    %edx, %edx      #
        movl    $4096, %esi     #,
# include/linux/memblock.h:411: }
        popq    %rbp    #
# include/linux/memblock.h:409:    return memblock_alloc_try_nid(size,
align, MEMBLOCK_LOW_LIMIT,
        jmp     memblock_alloc_try_nid  #
        .size   memblock_alloc.constprop.0, .-memblock_alloc.constprop.0

Apparently, this is an optimization for code size, as there are
multiple callers in
kernel/dma/swiotlb.c and it can move the call to __sanitizer_cov_trace_pc into
a single place here.

       Arnd
