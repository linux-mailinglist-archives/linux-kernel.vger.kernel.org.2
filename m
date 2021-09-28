Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE041AA81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhI1IWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhI1IWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:22:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B65E561209
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632817222;
        bh=FOqCQkHnZGbZdTybxy+5IK/DFnY6xsR2LcxikZl/+rY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UCvZFQTyf2Xb5DGTJMcRCTcmpWSrkZcBIzpbNC3WNmQ92ZvUZmkT7tGo1/LdmnKc7
         YU9AA/Ls4GPIrKNGRMzGxU16EYsBQTmLi3CnUsblDXAyTEuHKSOh1kG4f6ULFpdl5c
         3J3mQVQY3xTLEq04xL5gt8n47n9obHFYCtLPPEZt/HFuSOiQ3hnyUszu5zuTQ2yxfH
         nFDpd9FTJZEgzRoRxZedXpJwrQbRXpiCn1fMr7VQff/G6Bdo/6NnhvePk4eBNhB2ca
         ZWtKNOLLvganXhf1SLdX/oFEjwkjFnaJR+PbPbioJtU0ciNUfHodNED2dVqjq0xxgB
         1n7TmaC60rQgQ==
Received: by mail-wr1-f47.google.com with SMTP id t8so56582154wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:20:22 -0700 (PDT)
X-Gm-Message-State: AOAM530DctxoDjePqb6W+Y4eYjCLIHKByztiXAaZsIucfl6WAv8zMZcP
        Ab8MQGNtIcE7Ku9x10X45YcOj5sL+vThjNcvID8=
X-Google-Smtp-Source: ABdhPJyxkWC/1VGczppVyh9LB2qQTcVBdk7PWoSh1zOlZbPaInSRFjDMiURvzC39B0Iv2KWsxvtNxgd9aqfpKHqheSo=
X-Received: by 2002:a5d:6cb4:: with SMTP id a20mr4296190wra.428.1632817221261;
 Tue, 28 Sep 2021 01:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210927141815.1711736-1-arnd@kernel.org> <1B89CC23-0CB4-4DA3-BA84-3DD628675351@tuxera.com>
In-Reply-To: <1B89CC23-0CB4-4DA3-BA84-3DD628675351@tuxera.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Sep 2021 10:20:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04K0z-ExztXisby506qz6pCuvx5pyOQU8hzFNULoHj8w@mail.gmail.com>
Message-ID: <CAK8P3a04K0z-ExztXisby506qz6pCuvx5pyOQU8hzFNULoHj8w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] ntfs: disable for 64KB because of stack overflow risk
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 1:21 AM Anton Altaparmakov <anton@tuxera.com> wrote:
>
> Hi Arnd,
>
> Thanks for the patch but what is the problem with the stack usage exceeding 2048 bytes?
>
> I am not aware of any architectures that implements kernel stack size (THREAD_SIZE)
> less than page size and by default most architectures with 4kiB page size even use two
> pages to make the stack 8kiB.

The two are decoupled these days unless CONFIG_VMAP_STACK is enabled at build
time, in which case the THREAD_SIZE is always a multiple of STACK_SIZE.
No architecture currently forces the use of VMAP_STACK though, so the allocation
is done in alloc_thread_stack_node() using this kmem_cache:

        thread_stack_cache = kmem_cache_create_usercopy("thread_stack",
                                        THREAD_SIZE, THREAD_SIZE, 0, 0,
                                        THREAD_SIZE, NULL);

64K pages are allowed on arm64, powerpc, mips, microblaze, ia64, sh, hexagon
and the upcoming loongarch port. The respective THREAD_SHIFT/THREAD_SIZE
values on these are

arch/arm64/include/asm/memory.h:#define MIN_THREAD_SHIFT (14 +
KASAN_THREAD_SHIFT)
arch/powerpc/Kconfig:config THREAD_SHIFT
arch/powerpc/Kconfig-   default "14" if PPC64
arch/mips/include/asm/thread_info.h:#define THREAD_SIZE_ORDER (0)
arch/mips/include/asm/thread_info.h:#define THREAD_SIZE (PAGE_SIZE <<
THREAD_SIZE_ORDER)
arch/microblaze/include/asm/thread_info.h:#define THREAD_SHIFT 13
arch/ia64/include/asm/ptrace.h:# define KERNEL_STACK_SIZE_ORDER         0
arch/ia64/include/asm/ptrace.h:#define IA64_STK_OFFSET
 ((1 << KERNEL_STACK_SIZE_ORDER)*PAGE_SIZE)
arch/ia64/include/asm/ptrace.h:#define KERNEL_STACK_SIZE
 IA64_STK_OFFSET
arch/ia64/include/asm/thread_info.h:#define THREAD_SIZE
 KERNEL_STACK_SIZE
arch/sh/include/asm/thread_info.h:#define THREAD_SHIFT  12
arch/hexagon/include/asm/thread_info.h:#define THREAD_SHIFT 12

As far as I can tell, only mips and ia64 require the kernel stack to
be a multiple
of the page size here, and I would consider that a bug: This is extremely
wasteful, especially considering that those machines typically won't have the
vast amounts of RAM that modern arm64 and powerpc64 servers have.

On a hexagon or sh system with 4KB stacks, using over 2KB in one function
is definitely excessive. Those machines wouldn't normally need NTFS support,
but that was kind-of the point of my patch.

         Arnd
