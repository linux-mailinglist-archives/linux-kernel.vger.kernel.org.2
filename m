Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB3343210
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCULCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 07:02:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCULCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 07:02:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F12DFACA8;
        Sun, 21 Mar 2021 11:02:00 +0000 (UTC)
Date:   Sun, 21 Mar 2021 12:01:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.12-rc4
Message-ID: <20210321110158.GA14211@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the freshest pile of shiny x86/urgent fixes for 5.12.

Thx.

---

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12-rc4

for you to fetch changes up to dd926880da8dbbe409e709c1d3c1620729a94732:

  x86/apic/of: Fix CPU devicetree-node lookups (2021-03-19 23:01:49 +0100)

----------------------------------------------------------------
- Add the arch-specific mapping between physical and logical CPUs to fix
devicetree-node lookups.

- Restore the IRQ2 ignore logic

- Fix get_nr_restart_syscall() to return the correct restart syscall number.
Split in a 4-patches set to avoid kABI breakage when backporting to dead
kernels.

----------------------------------------------------------------
Johan Hovold (1):
      x86/apic/of: Fix CPU devicetree-node lookups

Oleg Nesterov (4):
      kernel, fs: Introduce and use set_restart_fn() and arch_set_restart_data()
      x86: Move TS_COMPAT back to asm/thread_info.h
      x86: Introduce TS_COMPAT_RESTART to fix get_nr_restart_syscall()
      x86: Introduce restart_block->arch_data to remove TS_COMPAT_RESTART

Thomas Gleixner (1):
      x86/ioapic: Ignore IRQ2 again

 arch/x86/include/asm/processor.h   |  9 ---------
 arch/x86/include/asm/thread_info.h | 15 ++++++++++++++-
 arch/x86/kernel/apic/apic.c        |  5 +++++
 arch/x86/kernel/apic/io_apic.c     | 10 ++++++++++
 arch/x86/kernel/signal.c           | 24 +-----------------------
 fs/select.c                        | 10 ++++------
 include/linux/restart_block.h      |  1 +
 include/linux/thread_info.h        | 13 +++++++++++++
 kernel/futex.c                     |  3 +--
 kernel/time/alarmtimer.c           |  2 +-
 kernel/time/hrtimer.c              |  2 +-
 kernel/time/posix-cpu-timers.c     |  2 +-
 12 files changed, 52 insertions(+), 44 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
