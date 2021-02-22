Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA06A322291
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhBVXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBVXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:12:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D48C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:11:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ds5so622425pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ni/IadrWeOPx9qblfRX+LLI3SLmfbnZstGHe9FGOE9Q=;
        b=XyixXJnCb/nuAXi9AJtF2wVbNkG3h9NDh6xin608wrSVwfRcbXTyLv3cktpY7l2GVP
         cAubXguc2WX1NH1fqHwcsiYhLaC8h76T2f1nUdNHcifMdll1lqh8nG/LEmInK+UVfc7P
         XMHM4V5pBTxwQcMMfT3tjLqseni2jDURCaFe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ni/IadrWeOPx9qblfRX+LLI3SLmfbnZstGHe9FGOE9Q=;
        b=tFmusfes+g9R6wuIqaHImUbPoxqHOlNJZS1cHc0asmGlhz7MbrRx0Z3TkYcn/ciVWL
         yFx+YW5XdYwT6vGkKZiOJhhABzg9f+lXr869oJgf8ZLH78QId5IAUkqbRcc5NUixAXdy
         kf/51Q/mC+gBTwDU8ljx3yGaZM7ZT7owvlZmI8PUAKDASaBIQVjb9jkhNEW5kdOTAwZ1
         nW91Rc6VizY76Y5KUtnsUZL3LF4LWyXlL2q6TUZFdfGYNZXHGh35rBmdm/SCjTyoTq6M
         eXkEDFTIFVUHbl0vvJsgBt0i64UDyzhTK7Drn7Vq3llqgoDP3hv4vw4OOLNK9RMYEL3c
         JZ9g==
X-Gm-Message-State: AOAM531ILQBZBKyN2gFuuubG9gesIPQw3CP0gMRBiP+J48iyUpVg7ccE
        FGzdUir+yyuSqH+Kjalsm958QnK8ox5pUA==
X-Google-Smtp-Source: ABdhPJxTTFYjpFN7Z6ri2i+ZUMau1IQvP160pdKZUItODij1Xd0aZjqJULNWrKUafvfljqXGqxajfw==
X-Received: by 2002:a17:902:768b:b029:e3:fb85:1113 with SMTP id m11-20020a170902768bb02900e3fb851113mr6267463pll.3.1614035481561;
        Mon, 22 Feb 2021 15:11:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm15488607pgg.85.2021.02.22.15.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 15:11:20 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:11:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Alexander Lobakin <alobakin@pm.me>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: [GIT PULL v2] clang-lto for v5.12-rc1
Message-ID: <202102221504.0418BE2D1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this Clang Link Time Optimization series for v5.12-rc1.
This has been in linux-next for the entire last development cycle,
and is built on the work done preparing[0] for LTO by arm64 folks,
tracing folks, etc. This series includes the core changes as well as
the remaining pieces for arm64 (LTO has been the default build method on
Android for about 3 years now, as it is the prerequisite for the Control
Flow Integrity protections).

While x86 LTO enablement is done[1], it depends on some objtool
clean-ups[2], though it appears those actually have been in linux-next
(via tip/objtool/core), so it's possible that if that tree lands, I'll
send a "part 2" pull request for LTO that includes x86 support (though
I guess that depends on the length of the merge window).

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

for you to fetch changes up to 2b8689520520175075ca97bc4eaf51ff3f7253aa:

  kbuild: prevent CC_FLAGS_LTO self-bloating on recursive rebuilds (2021-02-17 10:10:37 -0800)

----------------------------------------------------------------
clang-lto series for v5.12-rc1

- Clang LTO build infrastructure and arm64-specific enablement (Sami Tolvanen)
- Recursive build CC_FLAGS_LTO fix (Alexander Lobakin)

----------------------------------------------------------------
Alexander Lobakin (1):
      kbuild: prevent CC_FLAGS_LTO self-bloating on recursive rebuilds

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
