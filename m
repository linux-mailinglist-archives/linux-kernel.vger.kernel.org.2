Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0B31D1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBPUfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBPUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:35:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:34:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a24so6120618plm.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=T+1qamTdKklsp4cGDuy9oXMeAOr1r2cIWsxbuUT5D64=;
        b=W4swVyMJHQaIiKtxV9sWRNS871Op7I+kSbh2fNsQ5qr6EaalUtW74cI4D46Tufv+co
         S6EWq6wjyGm2gEav2sGpNXx9VZtLFbqguBxjzRM/4xp9U/kyoVwuwuvBGnXgqQPF34Bt
         DLke26xC2zWYzhUQJk2oGTYeciqXBWDpEUqmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T+1qamTdKklsp4cGDuy9oXMeAOr1r2cIWsxbuUT5D64=;
        b=IOiivUSKDeU3jZPQubfnMo+fLy5NzIhG5z5o9Jq8rh8WZ0g6AGi7KVhzqRUXxbLGqY
         MVP4uQT50Vt6V0YfwAUMVi0mbx6RXTxI/8HdvBcjz6X3v1km5+LGLauSIYvbxdQ8xkCF
         ci5UfjgwBd862kAWHPB9daG9N1pku4RTrLaYr/S0z5xeAnU8ibRDi05iAARDg8cLfU1Q
         NXTHq0S1CIb2dtW2AONUrInAE1dW25n83N8C6oPYMgzDy60mpS9OSiCDSm/XXBV9Jme9
         jSS/zoorcJhdUlJvl+7L3lrdrb+4kISTYligw+SfSMPsmBfrrhceBx2zxnN9uoC9K2I9
         narg==
X-Gm-Message-State: AOAM530Lx8UclO5nCLYdYg7BSNMjuG+rHXyX/I9RaY3Ztvozpt9Nd2xZ
        SkNArThObdQ8il3SSEFFzda7Fw==
X-Google-Smtp-Source: ABdhPJyZF367gb2IjqcC7LZdkMUeVsILlGzZHF8K7NySCYQdIdhQjJ/u2LxwQRDAPmdqMW9VxK+o0w==
X-Received: by 2002:a17:90a:4101:: with SMTP id u1mr5837744pjf.119.1613507689357;
        Tue, 16 Feb 2021 12:34:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m23sm25753pgv.14.2021.02.16.12.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:34:48 -0800 (PST)
Date:   Tue, 16 Feb 2021 12:34:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL] clang-lto for v5.12-rc1
Message-ID: <202102161211.6FDD4FE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this Clang Link Time Optimization series for v5.12-rc1. This
has been in linux-next for the entire last development cycle, and is
built on the work done preparing[0] for LTO by arm64 folks, tracing folks,
etc. This series includes the core changes as well as the remaining pieces
for arm64 (LTO has been the default build method on Android for about
3 years now, as it is the prerequisite for the Control Flow Integrity
protections). While x86 LTO support is done[1], there is still some
on-going clean-up work happening for objtool[2] that should hopefully
land by the v5.13 merge window.

For merge log posterity, and as detailed in commit dc5723b02e52 ("kbuild:
add support for Clang LTO"), here is the lt;dr to do an LTO build:

	make LLVM=1 LLVM_IAS=1 defconfig
	scripts/config -e LTO_CLANG_THIN
	make LLVM=1 LLVM_IAS=1

(To do a cross-compile of arm64, add "CROSS_COMPILE=aarch64-linux-gnu-"
and "ARCH=arm64" to the "make" command lines.)

Thanks!

-Kees

[0] https://git.kernel.org/linus/3c09ec59cdea5b132212d97154d625fd34e436dd
[1] https://github.com/samitolvanen/linux/commits/clang-lto
[2] https://lore.kernel.org/lkml/cover.1611263461.git.jpoimboe@redhat.com/

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1

for you to fetch changes up to 112b6a8e038d793d016e330f53acb9383ac504b3:

  arm64: allow LTO to be selected (2021-01-14 08:21:10 -0800)

----------------------------------------------------------------
clang-lto for v5.12-rc1

Provide build infrastructure for arm64 Clang LTO.

----------------------------------------------------------------
Sami Tolvanen (16):
      tracing: move function tracer options to Kconfig
      kbuild: add support for Clang LTO
      kbuild: lto: fix module versioning
      kbuild: lto: limit inlining
      kbuild: lto: merge module sections
      kbuild: lto: add a default list of used symbols
      init: lto: ensure initcall ordering
      init: lto: fix PREL32 relocations
      PCI: Fix PREL32 relocations for LTO
      modpost: lto: strip .lto from module names
      scripts/mod: disable LTO for empty.c
      efi/libstub: disable LTO
      drivers/misc/lkdtm: disable LTO for rodata.o
      arm64: vdso: disable LTO
      arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
      arm64: allow LTO to be selected

 .gitignore                            |   1 +
 Makefile                              |  45 ++++--
 arch/Kconfig                          |  90 ++++++++++++
 arch/arm64/Kconfig                    |   4 +
 arch/arm64/kernel/vdso/Makefile       |   3 +-
 drivers/firmware/efi/libstub/Makefile |   2 +
 drivers/misc/lkdtm/Makefile           |   1 +
 include/asm-generic/vmlinux.lds.h     |  11 +-
 include/linux/init.h                  |  79 ++++++++--
 include/linux/pci.h                   |  27 +++-
 init/Kconfig                          |   1 +
 kernel/trace/Kconfig                  |  16 ++
 scripts/Makefile.build                |  48 +++++-
 scripts/Makefile.lib                  |   6 +-
 scripts/Makefile.modfinal             |   9 +-
 scripts/Makefile.modpost              |  25 +++-
 scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh               |  70 +++++++--
 scripts/lto-used-symbollist.txt       |   5 +
 scripts/mod/Makefile                  |   1 +
 scripts/mod/modpost.c                 |  16 +-
 scripts/mod/modpost.h                 |   9 ++
 scripts/mod/sumversion.c              |   6 +-
 scripts/module.lds.S                  |  24 +++
 24 files changed, 707 insertions(+), 62 deletions(-)
 create mode 100755 scripts/generate_initcall_order.pl
 create mode 100644 scripts/lto-used-symbollist.txt

-- 
Kees Cook
