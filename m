Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4A36B0C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhDZJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:39:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:54762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232890AbhDZJjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:39:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92300AEFE;
        Mon, 26 Apr 2021 09:38:32 +0000 (UTC)
Date:   Mon, 26 Apr 2021 11:38:30 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/alternatives for v5.13
Message-ID: <YIaKFik1iPfNHZil@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the nice paravirt cleanup by Jürgen for v5.13.

Thx.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v5.13

for you to fetch changes up to 054ac8ad5ebe4a69e1f0e842483821ddbe560121:

  x86/paravirt: Have only one paravirt patch function (2021-03-11 20:11:09 +0100)

----------------------------------------------------------------
First big cleanup to the paravirt infra to use alternatives and thus
eliminate custom code patching. For that, the alternatives infra is
extended to accomodate paravirt's needs and, as a result, a lot of
paravirt patching code goes away, leading to a sizeable cleanup and
simplification. Work by Juergen Gross.

----------------------------------------------------------------
Juergen Gross (15):
      x86/alternative: Drop unused feature parameter from ALTINSTR_REPLACEMENT()
      x86/alternative: Merge include files
      static_call: Move struct static_call_key definition to static_call_types.h
      static_call: Add function to query current function
      x86/paravirt: Switch time pvops functions to use static_call()
      x86/alternative: Support not-feature
      x86/alternative: Support ALTERNATIVE_TERNARY
      x86/alternative: Use ALTERNATIVE_TERNARY() in _static_cpu_has()
      x86/paravirt: Add new features for paravirt patching
      x86/paravirt: Remove no longer needed 32-bit pvops cruft
      x86/paravirt: Simplify paravirt macros
      x86/paravirt: Switch iret pvops to ALTERNATIVE
      x86/paravirt: Add new PVOP_ALT* macros to support pvops in ALTERNATIVEs
      x86/paravirt: Switch functions with custom code to ALTERNATIVE
      x86/paravirt: Have only one paravirt patch function

 arch/arm/include/asm/paravirt.h          |  14 +--
 arch/arm/kernel/paravirt.c               |   9 +-
 arch/arm64/include/asm/paravirt.h        |  14 +--
 arch/arm64/kernel/paravirt.c             |  13 +-
 arch/x86/Kconfig                         |   1 +
 arch/x86/entry/entry_32.S                |   6 +-
 arch/x86/entry/entry_64.S                |   2 +-
 arch/x86/entry/vdso/vdso32/system_call.S |   2 +-
 arch/x86/include/asm/alternative-asm.h   | 114 -----------------
 arch/x86/include/asm/alternative.h       | 142 +++++++++++++++++++--
 arch/x86/include/asm/cpufeature.h        |  41 ++----
 arch/x86/include/asm/cpufeatures.h       |   2 +
 arch/x86/include/asm/irqflags.h          |   7 +-
 arch/x86/include/asm/mshyperv.h          |   2 +-
 arch/x86/include/asm/nospec-branch.h     |   1 -
 arch/x86/include/asm/paravirt.h          | 167 +++++++++++-------------
 arch/x86/include/asm/paravirt_types.h    | 210 ++++++++++++-------------------
 arch/x86/include/asm/smap.h              |   5 +-
 arch/x86/kernel/Makefile                 |   3 +-
 arch/x86/kernel/alternative.c            |  52 ++++++--
 arch/x86/kernel/asm-offsets.c            |   7 --
 arch/x86/kernel/cpu/vmware.c             |   5 +-
 arch/x86/kernel/kvm.c                    |   2 +-
 arch/x86/kernel/kvmclock.c               |   2 +-
 arch/x86/kernel/paravirt-spinlocks.c     |   9 ++
 arch/x86/kernel/paravirt.c               |  75 +++--------
 arch/x86/kernel/paravirt_patch.c         |  99 ---------------
 arch/x86/kernel/tsc.c                    |   3 +-
 arch/x86/lib/atomic64_386_32.S           |   2 +-
 arch/x86/lib/atomic64_cx8_32.S           |   2 +-
 arch/x86/lib/copy_page_64.S              |   2 +-
 arch/x86/lib/copy_user_64.S              |   2 +-
 arch/x86/lib/memcpy_64.S                 |   2 +-
 arch/x86/lib/memmove_64.S                |   2 +-
 arch/x86/lib/memset_64.S                 |   2 +-
 arch/x86/lib/retpoline.S                 |   2 +-
 arch/x86/xen/enlighten_pv.c              |   4 +-
 arch/x86/xen/time.c                      |  26 ++--
 drivers/xen/time.c                       |   3 +-
 include/linux/static_call.h              |  26 ++--
 include/linux/static_call_types.h        |  18 +++
 tools/include/linux/static_call_types.h  |  18 +++
 42 files changed, 482 insertions(+), 638 deletions(-)
 delete mode 100644 arch/x86/include/asm/alternative-asm.h
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
