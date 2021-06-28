Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8344F3B6926
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhF1Tex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhF1Tew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:34:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D276C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:32:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cs1-20020a17090af501b0290170856e1a8aso198137pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=apmuhgU/Oe5VvddtMSF+nAIGS/WXE1w2P1HiUkwahs8=;
        b=SSFPqsTkzfJTFfdfcMKQu8xkJ5EeYB/uJ4P0y8DPsT80kyqs+Qf/V4tKxs9l65vEB/
         e7BSBgvk5+LOIJ37ZM2VduLFrPdPP9FFPTCW3v/vMfogPXhRWRW5Q7u6TFg5xJ9aUv03
         JBuyh2FuLei8heE+whvDjyIYNEGZu1LTcgtio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=apmuhgU/Oe5VvddtMSF+nAIGS/WXE1w2P1HiUkwahs8=;
        b=RCO+JcAO0Rn/aRk8Ev3i0XG4S2XRrn3c5Xnkiki7vIyhGOiYrJwJ4MRqh6J03Pz0kw
         ZGiQvPPl631470tvcbM9wUL/2tYEdSY0HnuiujCt6Cb14IISGFMrddFYpYvpp+XC5YNh
         VNUbPoR66O/Fa7J0z25I2HOxw+GohchCCegc/LtY327cVRWhs86yzOmmPww13l+iFzyt
         kxZFGijwr/bceoovLQNLUW+C7p96rNMeRreWQFHzWejMYDWNO4kNouGF+dO0zirQReM+
         RHyyefzckV5z+omiv/3bZ/4ibidlQ643HctR+GGHeWgzK6F7KdgL8XivJREGIi8RbZrU
         296w==
X-Gm-Message-State: AOAM531etXbwaYpCXflBHDCGBGg9e3bb7EwHrX6/6xOkJN7SLmTmlWy/
        8yo5AANPLcOy37GBFZ2Fz82IOA==
X-Google-Smtp-Source: ABdhPJy4M3yOYHgfuJRWYsL19KtYpyZeyog4j8WMp4W7oi3WicBxvyfWK96RF5DuCO1B5ZbMqGhgXg==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr28732587pjr.113.1624908745511;
        Mon, 28 Jun 2021 12:32:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14sm15115116pfk.10.2021.06.28.12.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:32:24 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:32:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] Clang feature updates for v5.14-rc1
Message-ID: <202106281231.E99B92BB13@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these Clang feature updates for v5.14-rc1.

Thanks!

-Kees

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.14-rc1

for you to fetch changes up to 6a0544606ec7f03e4a2534c87ea989de4bac41ae:

  pgo: rectify comment to proper kernel-doc syntax (2021-06-28 12:10:31 -0700)

----------------------------------------------------------------
Clang feature updates for v5.14-rc1

The big addition for this merge window is the core support for Clang's
Profile Guided Optimization, which lets Clang build the kernel for
improved performance when running specific kernel workloads. This
currently covers only vmlinux, but module support is under active
development. (Sami Tolvanen, Bill Wendling, Kees Cook, Jarmo Tiitto,
Lukas Bulwahn)

Added CC_HAS_NO_PROFILE_FN_ATTR in preparation for PGO support in
the face of the noinstr attribute, paving the way for PGO and fixing
GCOV. (Nick Desaulniers)

x86_64 LTO coverage is expaned to 32-bit x86. (Nathan Chancellor)

Small fixes to CFI. (Mark Rutland, Nathan Chancellor)

----------------------------------------------------------------
Bill Wendling (1):
      pgo: rename the raw profile file to vmlinux.profraw

Jarmo Tiitto (2):
      pgo: Limit allocate_node() to vmlinux sections
      pgo: Fix sleep in atomic section in prf_open()

Kees Cook (2):
      MAINTAINERS: Expand and relocate PGO entry
      pgo: Clean up prf_open() error paths

Lukas Bulwahn (1):
      pgo: rectify comment to proper kernel-doc syntax

Mark Rutland (1):
      CFI: Move function_nocfi() into compiler.h

Nathan Chancellor (2):
      MAINTAINERS: Add Clang CFI section
      x86, lto: Enable Clang LTO for 32-bit as well

Nick Desaulniers (3):
      compiler_attributes.h: define __no_profile, add to noinstr
      compiler_attributes.h: cleanups for GCC 4.9+
      Kconfig: Introduce ARCH_WANTS_NO_INSTR and CC_HAS_NO_PROFILE_FN_ATTR

Sami Tolvanen (1):
      pgo: Add Clang's Profile Guided Optimization infrastructure

 Documentation/dev-tools/index.rst     |   1 +
 Documentation/dev-tools/pgo.rst       | 127 +++++++++++
 MAINTAINERS                           |  25 ++
 Makefile                              |   3 +
 arch/Kconfig                          |   8 +
 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/compiler.h     |  16 ++
 arch/arm64/include/asm/memory.h       |  16 --
 arch/s390/Kconfig                     |   1 +
 arch/x86/Kconfig                      |   6 +-
 arch/x86/boot/Makefile                |   1 +
 arch/x86/boot/compressed/Makefile     |   1 +
 arch/x86/crypto/Makefile              |   3 +
 arch/x86/entry/vdso/Makefile          |   1 +
 arch/x86/kernel/Makefile              |   3 +
 arch/x86/kernel/vmlinux.lds.S         |   2 +
 arch/x86/platform/efi/Makefile        |   1 +
 arch/x86/purgatory/Makefile           |   1 +
 arch/x86/realmode/rm/Makefile         |   1 +
 arch/x86/um/vdso/Makefile             |   1 +
 drivers/firmware/efi/libstub/Makefile |   1 +
 include/asm-generic/vmlinux.lds.h     |  32 +++
 include/linux/compiler.h              |  10 +
 include/linux/compiler_attributes.h   |  19 +-
 include/linux/compiler_types.h        |   2 +-
 include/linux/mm.h                    |  10 -
 init/Kconfig                          |   3 +
 kernel/Makefile                       |   1 +
 kernel/gcov/Kconfig                   |   1 +
 kernel/pgo/Kconfig                    |  37 +++
 kernel/pgo/Makefile                   |   5 +
 kernel/pgo/fs.c                       | 413 ++++++++++++++++++++++++++++++++++
 kernel/pgo/instrument.c               | 188 ++++++++++++++++
 kernel/pgo/pgo.h                      | 211 +++++++++++++++++
 scripts/Makefile.lib                  |  10 +
 35 files changed, 1130 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/dev-tools/pgo.rst
 create mode 100644 kernel/pgo/Kconfig
 create mode 100644 kernel/pgo/Makefile
 create mode 100644 kernel/pgo/fs.c
 create mode 100644 kernel/pgo/instrument.c
 create mode 100644 kernel/pgo/pgo.h

-- 
Kees Cook
