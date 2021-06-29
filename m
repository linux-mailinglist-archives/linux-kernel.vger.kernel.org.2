Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF83B7304
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhF2NQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:16:46 -0400
Received: from foss.arm.com ([217.140.110.172]:50892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhF2NQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:16:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EFC106F;
        Tue, 29 Jun 2021 06:14:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55A83F718;
        Tue, 29 Jun 2021 06:14:06 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:14:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <20210629131400.GA24514@C02TD0UTHF1T.local>
References: <202106281231.E99B92BB13@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106281231.E99B92BB13@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, Jun 28, 2021 at 12:32:24PM -0700, Kees Cook wrote:
> Hi Linus,
> 
> Please pull these Clang feature updates for v5.14-rc1.
> 
> Thanks!
> 
> -Kees
> 
> The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:
> 
>   Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.14-rc1
> 
> for you to fetch changes up to 6a0544606ec7f03e4a2534c87ea989de4bac41ae:
> 
>   pgo: rectify comment to proper kernel-doc syntax (2021-06-28 12:10:31 -0700)
> 
> ----------------------------------------------------------------
> Clang feature updates for v5.14-rc1
> 
> The big addition for this merge window is the core support for Clang's
> Profile Guided Optimization, which lets Clang build the kernel for
> improved performance when running specific kernel workloads. This
> currently covers only vmlinux, but module support is under active
> development. (Sami Tolvanen, Bill Wendling, Kees Cook, Jarmo Tiitto,
> Lukas Bulwahn)

I thought the PGO stuff was on hold given Peter had open concerns, e.g.

https://lore.kernel.org/r/20210614154639.GB68749@worktop.programming.kicks-ass.net

... and there didn't seem to be a strong conclusion to the contrary.

> Added CC_HAS_NO_PROFILE_FN_ATTR in preparation for PGO support in
> the face of the noinstr attribute, paving the way for PGO and fixing
> GCOV. (Nick Desaulniers)
> 
> x86_64 LTO coverage is expaned to 32-bit x86. (Nathan Chancellor)
> 
> Small fixes to CFI. (Mark Rutland, Nathan Chancellor)

FWIW, all the rest of this looks good to me.

Thanks,
Mark.

> 
> ----------------------------------------------------------------
> Bill Wendling (1):
>       pgo: rename the raw profile file to vmlinux.profraw
> 
> Jarmo Tiitto (2):
>       pgo: Limit allocate_node() to vmlinux sections
>       pgo: Fix sleep in atomic section in prf_open()
> 
> Kees Cook (2):
>       MAINTAINERS: Expand and relocate PGO entry
>       pgo: Clean up prf_open() error paths
> 
> Lukas Bulwahn (1):
>       pgo: rectify comment to proper kernel-doc syntax
> 
> Mark Rutland (1):
>       CFI: Move function_nocfi() into compiler.h
> 
> Nathan Chancellor (2):
>       MAINTAINERS: Add Clang CFI section
>       x86, lto: Enable Clang LTO for 32-bit as well
> 
> Nick Desaulniers (3):
>       compiler_attributes.h: define __no_profile, add to noinstr
>       compiler_attributes.h: cleanups for GCC 4.9+
>       Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR
> 
> Sami Tolvanen (1):
>       pgo: Add Clang's Profile Guided Optimization infrastructure
> 
>  Documentation/dev-tools/index.rst     |   1 +
>  Documentation/dev-tools/pgo.rst       | 127 +++++++++++
>  MAINTAINERS                           |  25 ++
>  Makefile                              |   3 +
>  arch/Kconfig                          |   8 +
>  arch/arm64/Kconfig                    |   1 +
>  arch/arm64/include/asm/compiler.h     |  16 ++
>  arch/arm64/include/asm/memory.h       |  16 --
>  arch/s390/Kconfig                     |   1 +
>  arch/x86/Kconfig                      |   6 +-
>  arch/x86/boot/Makefile                |   1 +
>  arch/x86/boot/compressed/Makefile     |   1 +
>  arch/x86/crypto/Makefile              |   3 +
>  arch/x86/entry/vdso/Makefile          |   1 +
>  arch/x86/kernel/Makefile              |   3 +
>  arch/x86/kernel/vmlinux.lds.S         |   2 +
>  arch/x86/platform/efi/Makefile        |   1 +
>  arch/x86/purgatory/Makefile           |   1 +
>  arch/x86/realmode/rm/Makefile         |   1 +
>  arch/x86/um/vdso/Makefile             |   1 +
>  drivers/firmware/efi/libstub/Makefile |   1 +
>  include/asm-generic/vmlinux.lds.h     |  32 +++
>  include/linux/compiler.h              |  10 +
>  include/linux/compiler_attributes.h   |  19 +-
>  include/linux/compiler_types.h        |   2 +-
>  include/linux/mm.h                    |  10 -
>  init/Kconfig                          |   3 +
>  kernel/Makefile                       |   1 +
>  kernel/gcov/Kconfig                   |   1 +
>  kernel/pgo/Kconfig                    |  37 +++
>  kernel/pgo/Makefile                   |   5 +
>  kernel/pgo/fs.c                       | 413 ++++++++++++++++++++++++++++++++++
>  kernel/pgo/instrument.c               | 188 ++++++++++++++++
>  kernel/pgo/pgo.h                      | 211 +++++++++++++++++
>  scripts/Makefile.lib                  |  10 +
>  35 files changed, 1130 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/dev-tools/pgo.rst
>  create mode 100644 kernel/pgo/Kconfig
>  create mode 100644 kernel/pgo/Makefile
>  create mode 100644 kernel/pgo/fs.c
>  create mode 100644 kernel/pgo/instrument.c
>  create mode 100644 kernel/pgo/pgo.h
> 
> -- 
> Kees Cook
