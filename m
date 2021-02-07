Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C09E3122BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBGIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBGIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:25:21 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6744AC061786
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 00:24:35 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 2so5648960qvd.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhMUHv1x/ybfl3YdrOgHIRdqoV6sFesTDMrbAcmBRB8=;
        b=evKtEwNvPvjYn+Jl81Aogtf/fHtLsDMfupnbuL+ofBT3z/p/lDh3vvyRVjpJwgkNY+
         7+3hJLR8uEpRvylALOnAX8QI4raMdVjRVYXq8UTPYtpbWSN13otHGdyv3Lts9M/iR4RQ
         AztSn1EHbCra0z2d/+5eDmUsn4DqefAo8F4HVVSRb4Yob7xazCPd4DqDdyiRZb+OKNdH
         XsZYOsuFKEd5S2t3sKIptRjiy+4MWgw0akSuymAV5svR4ZeyX+P5tbUfFb6b916hxfFE
         aYBl+p+2UlRwR5hoVIwDIFwYtu5uu62pBjTjhV1ocTGJCP4gH4pKSqfnLQADFzwqjciF
         UTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhMUHv1x/ybfl3YdrOgHIRdqoV6sFesTDMrbAcmBRB8=;
        b=gXtv4UgKmEyWEKpF/m81ny3jFCF+b1VeN3WNxe0mMAa+8+Tm4wRuyYlykqQ0zVA+aO
         ggAoetKMiQoySCGcob2zsQcRZQ7bIUJ+w0l4+lIqqOcYl6lJYXu8hCQpAve4e5hm6cfw
         ngywdBDxlZQEV0/og8NfKuWoUgtWMjPRADatNipy+C/585jDS7irHlPGznfGg66dq8eO
         1FG/T/t53iJlD1RjMivk3u5t2q4jZ31bPomt2aTrOIzTtkfUCtKtFZ+iI+9Aa0eIkWEl
         tG2EpJuKINWskNSNW+FddhQf3OTSkWwqs9ShMC/IBTCy/NE7eYBzOqI3+j8kpgY4Ol8S
         r8nw==
X-Gm-Message-State: AOAM530zydd0SjFrMTz34g9uBFXdKHzXKXiKfIMioQgZEWAwiQdBvq4I
        Q4cgtpEU0QC4v54boBOsG2Fji+OzXrqpsj0PFiO5ww==
X-Google-Smtp-Source: ABdhPJxJ57rXoVcBTYselg8pRz8hX0JKofwnxDtRjilKLP9qileqVPAfC/JnkaQxx9VIwlwPx2cZM5B4ttkD8Kp2xbQ=
X-Received: by 2002:a05:6214:522:: with SMTP id x2mr11744804qvw.13.1612686274113;
 Sun, 07 Feb 2021 00:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 7 Feb 2021 09:24:23 +0100
Message-ID: <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The patchset brings support for LAM for userspace addresses.
>
> The most sensitive part of enabling is change in tlb.c, where CR3 flags
> get set. Please take a look that what I'm doing makes sense.
>
> The patchset is RFC quality and the code requires more testing before it
> can be applied.
>
> The userspace API is not finalized yet. The patchset extends API used by
> ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not imply ARM
> TBI: it now allows to request a number of bits of metadata needed and
> report where these bits are located in the address.
>
> There's an alternative proposal[2] for the API based on Intel CET
> interface. Please let us know if you prefer one over another.
>
> The feature competes for bits with 5-level paging: LAM_U48 makes it
> impossible to map anything about 47-bits. The patchset made these
> capability mutually exclusive: whatever used first wins. LAM_U57 can be
> combined with mappings above 47-bits.
>
> I include QEMU patch in case if somebody wants to play with the feature.

Exciting! Do you plan to send the QEMU patch to QEMU?

> The branch:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
>
> Any comments are welcome.
>
> [1] ISE, Chapter 14. https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf
> [2] https://github.com/hjl-tools/linux/commit/e85fa032e5b276ddf17edd056f92f599db9e8369
>
> Kirill A. Shutemov (9):
>   mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
>   x86/mm: Fix CR3_ADDR_MASK
>   x86: CPUID and CR3/CR4 flags for Linear Address Masking
>   x86/mm: Introduce TIF_LAM_U57 and TIF_LAM_U48
>   x86/mm: Provide untagged_addr() helper
>   x86/uaccess: Remove tags from the address before checking
>   x86/mm: Handle tagged memory accesses from kernel threads
>   x86/mm: Make LAM_U48 and mappings above 47-bits mutually exclusive
>   x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM
>
>  arch/arm64/include/asm/processor.h            |  12 +-
>  arch/arm64/kernel/process.c                   |  45 +++++-
>  arch/arm64/kernel/ptrace.c                    |   4 +-
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/elf.h                    |   3 +-
>  arch/x86/include/asm/mmu.h                    |   1 +
>  arch/x86/include/asm/mmu_context.h            |  13 ++
>  arch/x86/include/asm/page_32.h                |   3 +
>  arch/x86/include/asm/page_64.h                |  19 +++
>  arch/x86/include/asm/processor-flags.h        |   2 +-
>  arch/x86/include/asm/processor.h              |  10 ++
>  arch/x86/include/asm/thread_info.h            |   9 +-
>  arch/x86/include/asm/tlbflush.h               |   5 +
>  arch/x86/include/asm/uaccess.h                |  16 +-
>  arch/x86/include/uapi/asm/processor-flags.h   |   6 +
>  arch/x86/kernel/process_64.c                  | 145 ++++++++++++++++++
>  arch/x86/kernel/sys_x86_64.c                  |   5 +-
>  arch/x86/mm/hugetlbpage.c                     |   6 +-
>  arch/x86/mm/mmap.c                            |   9 +-
>  arch/x86/mm/tlb.c                             | 124 +++++++++++++--
>  kernel/sys.c                                  |  14 +-
>  .../testing/selftests/arm64/tags/tags_test.c  |  31 ----
>  .../selftests/{arm64 => vm}/tags/.gitignore   |   0
>  .../selftests/{arm64 => vm}/tags/Makefile     |   0
>  .../{arm64 => vm}/tags/run_tags_test.sh       |   0
>  tools/testing/selftests/vm/tags/tags_test.c   |  57 +++++++
>  26 files changed, 464 insertions(+), 76 deletions(-)
>  delete mode 100644 tools/testing/selftests/arm64/tags/tags_test.c
>  rename tools/testing/selftests/{arm64 => vm}/tags/.gitignore (100%)
>  rename tools/testing/selftests/{arm64 => vm}/tags/Makefile (100%)
>  rename tools/testing/selftests/{arm64 => vm}/tags/run_tags_test.sh (100%)
>  create mode 100644 tools/testing/selftests/vm/tags/tags_test.c
>
> --
> 2.26.2
>
