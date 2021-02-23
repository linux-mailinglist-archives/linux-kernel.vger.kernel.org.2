Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620FC322DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhBWPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:43:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233169AbhBWPnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:43:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1635C60295;
        Tue, 23 Feb 2021 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614094961;
        bh=NdyZuXOBqsbAzv4QDixhg/R5ehEnZyBiWp0onNviabo=;
        h=Date:From:To:Cc:Subject:From;
        b=stvdWbZS/tv58x2mPdFhZw1yjcmK5o2qtAhGrqhtO2p9W4JVPEafmLNioH6DKtw5N
         GHfXbETXi+Hnny/YbW88enyksn5nVIHnCwOWtPsu3Yi+CWhacb2fF4G4Z+ITTvzqzP
         6m8RlzJU7akY1ZhMfNRX0FO17XGdtny5CQ7Czsn8jJq6xUBZKWvpnB16QQ0nXaUE0D
         LjDR7ao+z/NB+d6OJ05uyZVIBbzhFEDiL7JGUSrqUeZRE9Vq8BOF26N8eW1pMNqcUK
         uzefj1zjdmc8tsnz03yjEC+YifGXTIl+FHe4w96BnzWhh9t5NH2mgBTzlAScU9r5yD
         m7/4XsmeOBjlQ==
Date:   Tue, 23 Feb 2021 16:42:36 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v5.12
Message-ID: <YDUibKAt5tpA1Hxs@gunter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux gunter 5.11.0-rc4-1-default+ x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull below to receive modules updates for the v5.12 merge window.
A summary can be found in the signed tag.

Thank you,

Jessica

---
The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

   Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.12

for you to fetch changes up to 1e80d9cb579ed7edd121753eeccce82ff82521b4:

   module: potential uninitialized return in module_kallsyms_on_each_symbol() (2021-02-10 16:57:04 +0100)

----------------------------------------------------------------
Modules updates for v5.12

Summary of modules changes for the 5.12 merge window:

- Retire EXPORT_UNUSED_SYMBOL() and EXPORT_SYMBOL_GPL_FUTURE(). These export
   types were introduced between 2006 - 2008. All the of the unused symbols have
   been long removed and gpl future symbols were converted to gpl quite a long
   time ago, and I don't believe these export types have been used ever since.
   So, I think it should be safe to retire those export types now. (Christoph Hellwig)

- Refactor and clean up some aged code cruft in the module loader (Christoph Hellwig)

- Build {,module_}kallsyms_on_each_symbol only when livepatching is enabled, as
   it is the only caller (Christoph Hellwig)

- Unexport find_module() and module_mutex and fix the last module
   callers to not rely on these anymore. Make module_mutex internal to
   the module loader. (Christoph Hellwig)

- Harden ELF checks on module load and validate ELF structures before checking
   the module signature (Frank van der Linden)

- Fix undefined symbol warning for clang (Fangrui Song)

- Fix smatch warning (Dan Carpenter)

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (13):
       powerpc/powernv: remove get_cxl_module
       drm: remove drm_fb_helper_modinit
       module: unexport find_module and module_mutex
       module: use RCU to synchronize find_module
       kallsyms: refactor {,module_}kallsyms_on_each_symbol
       kallsyms: only build {,module_}kallsyms_on_each_symbol when required
       module: mark module_mutex static
       module: remove each_symbol_in_section
       module: merge each_symbol_section into find_symbol
       module: pass struct find_symbol_args to find_symbol
       module: move struct symsearch to module.c
       module: remove EXPORT_SYMBOL_GPL_FUTURE
       module: remove EXPORT_UNUSED_SYMBOL*

Dan Carpenter (1):
       module: potential uninitialized return in module_kallsyms_on_each_symbol()

Fangrui Song (1):
       module: Ignore _GLOBAL_OFFSET_TABLE_ when warning for undefined symbols

Frank van der Linden (1):
       module: harden ELF info handling

  arch/arm/configs/bcm2835_defconfig          |   1 -
  arch/arm/configs/mxs_defconfig              |   1 -
  arch/mips/configs/nlm_xlp_defconfig         |   1 -
  arch/mips/configs/nlm_xlr_defconfig         |   1 -
  arch/parisc/configs/generic-32bit_defconfig |   1 -
  arch/parisc/configs/generic-64bit_defconfig |   1 -
  arch/powerpc/configs/ppc6xx_defconfig       |   1 -
  arch/powerpc/platforms/powernv/pci-cxl.c    |  22 --
  arch/s390/configs/debug_defconfig           |   1 -
  arch/s390/configs/defconfig                 |   1 -
  arch/sh/configs/edosk7760_defconfig         |   1 -
  arch/sh/configs/sdk7780_defconfig           |   1 -
  arch/x86/configs/i386_defconfig             |   1 -
  arch/x86/configs/x86_64_defconfig           |   1 -
  arch/x86/tools/relocs.c                     |   4 +-
  drivers/gpu/drm/drm_crtc_helper_internal.h  |  10 -
  drivers/gpu/drm/drm_fb_helper.c             |  21 --
  drivers/gpu/drm/drm_kms_helper_common.c     |  25 +-
  include/asm-generic/vmlinux.lds.h           |  42 ---
  include/linux/export.h                      |   9 -
  include/linux/kallsyms.h                    |  17 +-
  include/linux/module.h                      |  48 +--
  init/Kconfig                                |  17 -
  kernel/kallsyms.c                           |   8 +-
  kernel/livepatch/core.c                     |   7 +-
  kernel/module.c                             | 481 ++++++++++++++--------------
  kernel/module_signature.c                   |   2 +-
  kernel/module_signing.c                     |   2 +-
  kernel/trace/trace_kprobe.c                 |   4 +-
  lib/bug.c                                   |   3 -
  scripts/checkpatch.pl                       |   6 +-
  scripts/mod/modpost.c                       |  50 +--
  scripts/mod/modpost.h                       |   3 -
  scripts/module.lds.S                        |   6 -
  tools/include/linux/export.h                |   3 -
  35 files changed, 287 insertions(+), 516 deletions(-)
