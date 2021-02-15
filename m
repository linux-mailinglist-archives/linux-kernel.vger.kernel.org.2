Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEAC31B6D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBOKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:02:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:47414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhBOKCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:02:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F35C1AC69;
        Mon, 15 Feb 2021 10:01:19 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:01:16 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v5.12
Message-ID: <20210215100116.GB23409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the RAS pile for v5.12.

Thx.

---

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.12

for you to fetch changes up to 9223d0dccb8f8523754122f68316dd1a4f39f7f8:

  thermal: Move therm_throt there from x86/mce (2021-02-08 11:43:20 +0100)

----------------------------------------------------------------
- Move therm_throt.c to the thermal framework, where it belongs.

- Identify CPUs which miss to enter the broadcast handler, as an
  additional debugging aid.

----------------------------------------------------------------
Borislav Petkov (2):
      x86/mce: Get rid of mcheck_intel_therm_init()
      thermal: Move therm_throt there from x86/mce

Paul E. McKenney (1):
      x86/mce: Make mce_timed_out() identify holdout CPUs

 arch/x86/Kconfig                                   |  4 ---
 arch/x86/include/asm/mce.h                         | 22 ------------
 arch/x86/include/asm/thermal.h                     | 13 +++++++
 arch/x86/kernel/cpu/intel.c                        |  3 ++
 arch/x86/kernel/cpu/mce/Makefile                   |  2 --
 arch/x86/kernel/cpu/mce/core.c                     | 16 +++++++--
 arch/x86/kernel/cpu/mce/intel.c                    |  1 -
 arch/x86/kernel/irq.c                              | 21 +++++++++++
 drivers/thermal/intel/Kconfig                      |  4 +++
 drivers/thermal/intel/Makefile                     |  1 +
 .../mce => drivers/thermal/intel}/therm_throt.c    | 41 ++++++----------------
 drivers/thermal/intel/thermal_interrupt.h          | 15 ++++++++
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  4 ++-
 13 files changed, 84 insertions(+), 63 deletions(-)
 create mode 100644 arch/x86/include/asm/thermal.h
 rename {arch/x86/kernel/cpu/mce => drivers/thermal/intel}/therm_throt.c (96%)
 create mode 100644 drivers/thermal/intel/thermal_interrupt.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
