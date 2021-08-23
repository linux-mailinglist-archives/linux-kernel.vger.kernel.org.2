Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F93F4F09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhHWROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD483C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:21 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6-20020ad448660000b02903500bf28866so12804448qvy.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TzNwsac26TTE64TPkO8Zw+SslAPN+OSf9Wllga1ByII=;
        b=MWCB6WvxwB6F+zLlU+bdbowGxXUtB63H+yJwpmJyNAmu5GmajAS54irNfnIfCvocsu
         eZb3WO9dtpFHSozTZNbYUFe7K+7WgkiX+8PcurbyaXl3h5FzLkHEeCDOE4PhBEkt3Q/3
         689FGSYc2GAUMryf71LD18gLqQ2aJ4FH9RVoreE8/pmJ6YFqIMfkhuI7tDj4v8pd2/YY
         EhS2WEWXsurJTItW3ayl0nVFqT+rLDOiYDo1w4sl0hx4Qd0TMmQWnhKYXa8y54cGAdOH
         11DFcJ1EkloaNKV7luDDjEGXe2UFm1KWNF1/aqaBiOzpnkDBEp+Q9j5xz60MCvmvdGmF
         ouQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TzNwsac26TTE64TPkO8Zw+SslAPN+OSf9Wllga1ByII=;
        b=CVku5eKpY/H0/JACNA9/2KBSgc2FEQcerXuB6Qg3fbaDnFUAD9UI3gRfY5pVdpxIFA
         wn+MNImd7EisYoB7pH8JiGdpZR2iw8ggBb/2icTWDFmCEyvG+l+/LTdDdWqO0PdYDdzF
         nTXpp3kbAxeh3Ku+QFbKy/jnmCGoxT/xcCgWMYtR9Zgx4sXziGIADnZWNZyN6y3ENz1f
         R6Mjb5oLolDl9KrfAw6sui/yXAbHvyqcG6oXGsTCwP2ktQvHPJoOFFzr9T2X7DIt9IoA
         HJT1ogDTuwuF3Tsn9vQMUSWwoRDAn98rKFQ8ggy9AtBRRMgRj5GhtjTVkzHoUgcXQwc6
         HvkQ==
X-Gm-Message-State: AOAM531uyoSkRMsIrR0Ek8f1sj365KlOIT1X8DSFvG5mEzDRdWKQm5BH
        z+tJ+HvwFlm7GwCgUlaQod1kls5lsvbuWkiOTKg=
X-Google-Smtp-Source: ABdhPJxt8SJCutO9XHUVYmIp52dTbp47/ya7vTQEF5ZIf2RLhHoucPX+tAFdFlCKuykZ0yJF0dNYbwrgxddFKALm6h4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:23cc:: with SMTP id
 hr12mr34346389qvb.56.1629738800924; Mon, 23 Aug 2021 10:13:20 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:04 -0700
Message-Id: <20210823171318.2801096-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 00/14] x86: Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Clang's Control-Flow Integrity (CFI)
checking to x86_64. With CFI, the compiler injects a runtime
check before each indirect function call to ensure the target is
a valid function with the correct static type. This restricts
possible call targets and makes it more difficult for an attacker
to exploit bugs that allow the modification of stored function
pointers. For more details, see:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

Version 2 depends on Clang >=14, where we fixed the issue with
referencing static functions from inline assembly. Based on the
feedback for v1, this version also changes the declaration of
functions that are not callable from C to use an opaque type,
which stops the compiler from replacing references to them. This
avoids the need to sprinkle function_nocfi() macros in the kernel
code.

The first two patches contain objtool support for CFI, the
remaining patches change function declarations to use opaque
types, fix type mismatch issues that confuse the compiler, and
disable CFI where it can't be used.

You can also pull this series from

  https://github.com/samitolvanen/linux.git x86-cfi-v2

---
Changes in v2:
- Dropped the first objtool patch as the warnings were fixed in
  separate patches.

- Changed fix_cfi_relocs() in objtool to not rely on jump table
  symbols, and to return an error if it can't find a relocation.

- Fixed a build issue with ASM_STACK_FRAME_NON_STANDARD().

- Dropped workarounds for inline assembly references to
  address-taken static functions with CFI as this was fixed in
  the compiler.

- Changed the C declarations of non-callable functions to use
  opaque types and dropped the function_nocfi() patches.

- Changed ARCH_SUPPORTS_CFI_CLANG to depend on Clang >=14 for
  the compiler fixes.

Kees Cook (2):
  x86/extable: Do not mark exception callback as CFI
  x86, relocs: Ignore __typeid__ relocations

Sami Tolvanen (12):
  objtool: Add CONFIG_CFI_CLANG support
  objtool: Add ASM_STACK_FRAME_NON_STANDARD
  linkage: Add DECLARE_ASM_FUNC_SYMBOL
  ftrace: Use an opaque type for functions not callable from C
  lkdtm: Disable UNSET_SMEP with CFI
  lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
  x86: Use an opaque type for functions not callable from C
  x86/purgatory: Disable CFI
  x86, module: Ignore __typeid__ relocations
  x86, cpu: Use LTO for cpu.c with CFI
  x86, kprobes: Fix optprobe_template_func type mismatch
  x86, build: Allow CONFIG_CFI_CLANG to be selected

 arch/x86/Kconfig                      |  1 +
 arch/x86/include/asm/ftrace.h         |  2 +-
 arch/x86/include/asm/idtentry.h       | 10 +++---
 arch/x86/include/asm/page_64.h        |  7 ++--
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/include/asm/proto.h          | 25 ++++++-------
 arch/x86/include/asm/uaccess_64.h     |  9 ++---
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/ftrace.c              |  2 +-
 arch/x86/kernel/kprobes/opt.c         |  4 +--
 arch/x86/kernel/module.c              |  4 +++
 arch/x86/kernel/paravirt.c            |  4 +--
 arch/x86/kvm/emulate.c                |  4 +--
 arch/x86/kvm/kvm_emulate.h            |  9 ++---
 arch/x86/mm/extable.c                 |  1 +
 arch/x86/power/Makefile               |  2 ++
 arch/x86/purgatory/Makefile           |  2 +-
 arch/x86/tools/relocs.c               |  7 ++++
 arch/x86/xen/enlighten_pv.c           |  6 ++--
 arch/x86/xen/xen-ops.h                | 10 +++---
 drivers/misc/lkdtm/bugs.c             |  2 +-
 drivers/misc/lkdtm/lkdtm.h            |  2 +-
 drivers/misc/lkdtm/perms.c            |  2 +-
 drivers/misc/lkdtm/rodata.c           |  2 +-
 include/linux/ftrace.h                |  7 ++--
 include/linux/linkage.h               | 13 +++++++
 include/linux/objtool.h               |  6 ++++
 tools/include/linux/objtool.h         |  6 ++++
 tools/objtool/arch/x86/decode.c       | 16 +++++++++
 tools/objtool/elf.c                   | 51 +++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h  |  3 ++
 tools/objtool/include/objtool/elf.h   |  2 +-
 33 files changed, 166 insertions(+), 62 deletions(-)


base-commit: d5ae8d7f85b7f6f6e60f1af8ff4be52b0926fde1
-- 
2.33.0.rc2.250.ged5fa647cd-goog

