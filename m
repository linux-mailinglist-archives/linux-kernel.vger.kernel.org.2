Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72241E092
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353037AbhI3SHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353007AbhI3SHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:18 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A9FC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso11322238qvf.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d2ahcIWGgjFLa51IYF/IRgZQTxiFTIrN8xyd61bx7ZU=;
        b=NhbAP7unTGwhWdPvJeWACQ1TDF5GXMPv+0MBfQlPCnaKXOZdSPEz5uCF6RDloP1n8b
         OwibjpId8oQguIS9uQbd1xpiZvTdbsEjyOqUTKphGudM8vdeEoJE7cAGBlFxOst9k01U
         nWM5yQQbK70Eh4imuXPyktRhBnlYsPK5HPGNbDPrfioMoHlvyR8UXoIOBejRVOJgtyPL
         Kv99RotkBHZSIpXgJ1aow4PYNRvWmX9MLsO/YQJn/O5XJTviFbQNetqfMC0aoOiJnlpK
         ncO9vdcOujtWUksHqhILZw9nVEPRbCRxukd/ItEualssEXi6n6N7/R6Jqb9ZI0IKnpXy
         hc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d2ahcIWGgjFLa51IYF/IRgZQTxiFTIrN8xyd61bx7ZU=;
        b=Kthy7nJjaeBoQv+m6z1BW6Y4Y0pXbnKKyW3WqW8daSbH6VSUJL/Y3BpjH3JoDJl8S/
         77pcKUwrAREAbulcsMPIoBhqARoBx7UfK5Kzb+E3HtomlbEz/VEuLQM7fn15HxY74ivg
         doH0wjXktadNQwJNwvXBewAE/VVB0zc2w0EdmNQRYuoy1tYeDTYeALG28xO3rn+I9O3n
         CNocLg25S7iFggqH4VZunMAeypvFIkmB8yLE1hzDz0MsHPAA4jTD3FyTi4UEFVdjwBRq
         miVPgXrtvfzqqaHXmbblyE+UQg1qi8JJ3ng5qUv00U36n99b6zz8o1kLt1fOnAvEmkDu
         U7Xg==
X-Gm-Message-State: AOAM532X9KHyw0I9FRuwqi32EMl/6EZOQZvcJm+Vz+Gx4QOPycEqc0Az
        ebbFPaUgCbrcnx0awATAou0b2iGr5kfJh6mMq4g=
X-Google-Smtp-Source: ABdhPJy34QBbONh0nYYsCE3geeKJiBHRElBYm2K2StDlG2pt1e7d/J1trbAIyBj0A4qx9m58AymxwIjArJ9EDAX8EPY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1022:: with SMTP id
 k2mr5342357qvr.53.1633025134523; Thu, 30 Sep 2021 11:05:34 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:16 -0700
Message-Id: <20210930180531.1190642-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 00/15] x86: Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
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

Note that v4 is based on tip/master. The first two patches contain
objtool support for CFI, the remaining patches change function
declarations to use opaque types, fix type mismatch issues that
confuse the compiler, and disable CFI where it can't be used.

You can also pull this series from

  https://github.com/samitolvanen/linux.git x86-cfi-v4

---
Changes in v4:
- Dropped the extable patch after the code was refactored in -tip.

- Switched to __section() instead of open-coding the attribute.

- Added an explicit ifdef for filtering out CC_FLAGS_CFI in
  purgatory for readability.

- Added a comment to arch_cfi_jump_reloc_offset() in objtool.

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

Sami Tolvanen (14):
  objtool: Add CONFIG_CFI_CLANG support
  objtool: Add ASM_STACK_FRAME_NON_STANDARD
  linkage: Add DECLARE_ASM_FUNC_SYMBOL
  cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
  tracepoint: Exclude tp_stub_func from CFI checking
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
 arch/x86/power/Makefile               |  2 ++
 arch/x86/purgatory/Makefile           |  4 +++
 arch/x86/tools/relocs.c               |  7 ++++
 arch/x86/xen/enlighten_pv.c           |  6 ++--
 arch/x86/xen/xen-ops.h                | 10 +++---
 drivers/misc/lkdtm/bugs.c             |  2 +-
 drivers/misc/lkdtm/lkdtm.h            |  2 +-
 drivers/misc/lkdtm/perms.c            |  2 +-
 drivers/misc/lkdtm/rodata.c           |  2 +-
 include/asm-generic/vmlinux.lds.h     | 11 ++++++
 include/linux/cfi.h                   | 13 +++++++
 include/linux/ftrace.h                |  7 ++--
 include/linux/linkage.h               | 13 +++++++
 include/linux/objtool.h               |  6 ++++
 kernel/cfi.c                          | 24 ++++++++++++-
 kernel/tracepoint.c                   |  5 +--
 tools/include/linux/objtool.h         |  6 ++++
 tools/objtool/arch/x86/decode.c       | 17 +++++++++
 tools/objtool/elf.c                   | 51 +++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h  |  3 ++
 tools/objtool/include/objtool/elf.h   |  2 +-
 36 files changed, 217 insertions(+), 66 deletions(-)


base-commit: d4bfebd9ef497ee0afb498f6028a5074a6ccf307
-- 
2.33.0.800.g4c38ced690-goog

