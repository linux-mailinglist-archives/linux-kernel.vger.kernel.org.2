Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA840B795
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhINTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhINTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BDEC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:48 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r18-20020a056214069200b0037a291a6081so670066qvz.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0GzzZ7fzGEuoqvnrH5xkZsITGuoIfAORG+08eeMzet8=;
        b=ZYLtvV6X16SIUpn4RDpGbDZkx1qtx35cu9QwoKZ+WO3jrtH2C4maVDBWO6S4FooZC6
         +rhiVcjwb1iqMyYKzEE4xHBLrlFu7uce41eVpuUw+ShgHXifI+6Ia5mLh3o6PU76uLfQ
         EYelPJyaRUWQMEcgFIuYSJ+N+luEAqmynpGu2afAywUMuqCyvWMQDdQ9YBRZB5LcUHsr
         6vXkMqlhPktT7wxZslwBjoUTnAIvCu2oZbU4hKLj/E+FyeaeTT+dnFVt5Kv9J81zrq2Z
         PaASIvljK4PIF38jdAxIq1ogAPJecReg4WYPeY5jqLd9lsr92sRMpT4tgDWaNhj+staQ
         NDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0GzzZ7fzGEuoqvnrH5xkZsITGuoIfAORG+08eeMzet8=;
        b=xeJP6fVglKCtk/8xpN4farwevGzFkXgVHSWvvI1ACQxe9leJ4RMTrMgNeE+IoXHRaW
         LnUj1Q7IS6xzwmyFy3sOjI+VOmFtgN5ZLcr0KsbWdT7oc4Ts9B9Ee3XTiZ7HG1wURGBS
         AELYBWhu6w2P+yYPloUzr2yOpcwQF+xozmaPiGT3yEtU0bLzMiQyMSV2YXXtohT0NSvI
         iOebRta5jaPCEPOhSRmjqJ4OIzFEtkARxguGsINaRvnX4iOD5htrR1pYFLcMTk1fmdNx
         V8iGccexQkhyVpD1MpR9mQ+IUq2HjbWDumY4zlZAQyKA2QegGZuV8N/POPsj5WtaeDcl
         B/pA==
X-Gm-Message-State: AOAM531FPYIBzHPD3m8aE6Yd3HwlHLNCYsh1n96SD6o6Sy9ApcHTFZ29
        B9+HKR17S8FKJTptisiXIonBPVTkvKjWPIoc74E=
X-Google-Smtp-Source: ABdhPJzVKiVmBLzFyscwJg2BySA2AI8C83IYyZAd7DSnW+5f+oVTtLZCupWgG5oVzv8eQ+y4xEMFljYhA3aGhkVDbj4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e0c7:: with SMTP id
 x7mr6956102qvk.55.1631646647327; Tue, 14 Sep 2021 12:10:47 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:29 -0700
Message-Id: <20210914191045.2234020-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 00/16] x86: Add support for Clang CFI
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

The first two patches contain objtool support for CFI, the
remaining patches change function declarations to use opaque
types, fix type mismatch issues that confuse the compiler, and
disable CFI where it can't be used.

You can also pull this series from

  https://github.com/samitolvanen/linux.git x86-cfi-v3

---
Changes in v3:
- Dropped Clang requirement to >= 13 after the missing compiler
  fix was backported there.

- Added DEFINE_CFI_IMMEDIATE_RETURN_STUB to address the issue
  with tp_stub_func in kernel/tracepoint.c.

- Renamed asm_func_t to asm_func_ptr.

- Changed extable handlers to use __cficanonical instead of
  disabling CFI for fixup_exception.


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


Kees Cook (1):
  x86, relocs: Ignore __typeid__ relocations

Sami Tolvanen (15):
  objtool: Add CONFIG_CFI_CLANG support
  objtool: Add ASM_STACK_FRAME_NON_STANDARD
  linkage: Add DECLARE_ASM_FUNC_SYMBOL
  cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
  tracepoint: Exclude tp_stub_func from CFI checking
  ftrace: Use an opaque type for functions not callable from C
  lkdtm: Disable UNSET_SMEP with CFI
  lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
  x86: Use an opaque type for functions not callable from C
  x86/extable: Mark handlers __cficanonical
  x86/purgatory: Disable CFI
  x86, module: Ignore __typeid__ relocations
  x86, cpu: Use LTO for cpu.c with CFI
  x86, kprobes: Fix optprobe_template_func type mismatch
  x86, build: Allow CONFIG_CFI_CLANG to be selected

 arch/x86/Kconfig                      |  1 +
 arch/x86/include/asm/ftrace.h         |  2 +-
 arch/x86/include/asm/idtentry.h       | 10 ++---
 arch/x86/include/asm/page_64.h        |  7 +--
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/include/asm/proto.h          | 25 ++++++-----
 arch/x86/include/asm/uaccess_64.h     |  9 ++--
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/ftrace.c              |  2 +-
 arch/x86/kernel/kprobes/opt.c         |  4 +-
 arch/x86/kernel/module.c              |  4 ++
 arch/x86/kernel/paravirt.c            |  4 +-
 arch/x86/kvm/emulate.c                |  4 +-
 arch/x86/kvm/kvm_emulate.h            |  9 +---
 arch/x86/mm/extable.c                 | 64 +++++++++++++++------------
 arch/x86/power/Makefile               |  2 +
 arch/x86/purgatory/Makefile           |  2 +-
 arch/x86/tools/relocs.c               |  7 +++
 arch/x86/xen/enlighten_pv.c           |  6 +--
 arch/x86/xen/xen-ops.h                | 10 ++---
 drivers/misc/lkdtm/bugs.c             |  2 +-
 drivers/misc/lkdtm/lkdtm.h            |  2 +-
 drivers/misc/lkdtm/perms.c            |  2 +-
 drivers/misc/lkdtm/rodata.c           |  2 +-
 include/asm-generic/vmlinux.lds.h     | 11 +++++
 include/linux/cfi.h                   | 14 ++++++
 include/linux/ftrace.h                |  7 +--
 include/linux/linkage.h               | 13 ++++++
 include/linux/objtool.h               |  6 +++
 kernel/cfi.c                          | 24 +++++++++-
 kernel/tracepoint.c                   |  5 +--
 tools/include/linux/objtool.h         |  6 +++
 tools/objtool/arch/x86/decode.c       | 16 +++++++
 tools/objtool/elf.c                   | 51 +++++++++++++++++++++
 tools/objtool/include/objtool/arch.h  |  3 ++
 tools/objtool/include/objtool/elf.h   |  2 +-
 37 files changed, 250 insertions(+), 95 deletions(-)


base-commit: d0ee23f9d78be5531c4b055ea424ed0b489dfe9b
-- 
2.33.0.309.g3052b89438-goog

