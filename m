Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A180C33A4A2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 13:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhCNMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:07:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:36818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235248AbhCNMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:07:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D853CABD7;
        Sun, 14 Mar 2021 12:07:28 +0000 (UTC)
Date:   Sun, 14 Mar 2021 13:07:26 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.12-rc3
Message-ID: <20210314120726.GA27191@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the accumulated x86/urgent pile for v5.12-rc3.

Thx.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12_rc3

for you to fetch changes up to bffe30dd9f1f3b2608a87ac909a224d6be472485:

  x86/sev-es: Use __copy_from_user_inatomic() (2021-03-09 12:37:54 +0100)

----------------------------------------------------------------
- A couple of SEV-ES fixes and robustifications: verify usermode stack
pointer in NMI is not coming from the syscall gap, correctly track IRQ
states in the #VC handler and access user insn bytes atomically in same
handler as latter cannot sleep.

- Balance 32-bit fast syscall exit path to do the proper work on exit
and thus not confuse audit and ptrace frameworks.

- Two fixes for the ORC unwinder going "off the rails" into KASAN
redzones and when ORC data is missing.

----------------------------------------------------------------
Andy Lutomirski (1):
      x86/entry: Fix entry/exit mismatch on failed fast 32-bit syscalls

Joerg Roedel (4):
      x86/sev-es: Introduce ip_within_syscall_gap() helper
      x86/sev-es: Check regs->sp is trusted before adjusting #VC IST stack
      x86/sev-es: Correctly track IRQ states in runtime #VC handler
      x86/sev-es: Use __copy_from_user_inatomic()

Josh Poimboeuf (2):
      x86/unwind/orc: Disable KASAN checking in the ORC unwinder, part 2
      x86/unwind/orc: Silence warnings caused by missing ORC data

 arch/x86/entry/common.c          |  3 +-
 arch/x86/entry/entry_64_compat.S |  2 ++
 arch/x86/include/asm/insn-eval.h |  2 ++
 arch/x86/include/asm/proto.h     |  1 +
 arch/x86/include/asm/ptrace.h    | 15 +++++++++
 arch/x86/kernel/sev-es.c         | 22 +++++++++++---
 arch/x86/kernel/traps.c          |  3 +-
 arch/x86/kernel/unwind_orc.c     | 14 ++++-----
 arch/x86/lib/insn-eval.c         | 66 +++++++++++++++++++++++++++++++---------
 9 files changed, 99 insertions(+), 29 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
