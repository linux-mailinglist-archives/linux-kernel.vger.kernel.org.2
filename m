Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51CF31B7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBOKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:54:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:52862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhBOKyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:54:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DEC3AC32;
        Mon, 15 Feb 2021 10:53:22 +0000 (UTC)
Date:   Mon, 15 Feb 2021 11:53:24 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt for v5.12
Message-ID: <20210215105324.GF23409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the first part of the conversion of the paravirt
infrastructure to our patching facilities.

Thx.

---

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.12

for you to fetch changes up to ab234a260b1f625b26cbefa93ca365b0ae66df33:

  x86/pv: Rework arch_local_irq_restore() to not use popf (2021-02-10 12:36:45 +0100)

----------------------------------------------------------------
Part une of a major conversion of the paravirt infrastructure to our
kernel patching facilities and getting rid of the custom-grown ones.

----------------------------------------------------------------
Juergen Gross (5):
      x86/xen: Use specific Xen pv interrupt entry for MCE
      x86/xen: Use specific Xen pv interrupt entry for DF
      x86/pv: Switch SWAPGS to ALTERNATIVE
      x86/xen: Drop USERGS_SYSRET64 paravirt call
      x86/pv: Rework arch_local_irq_restore() to not use popf

 arch/x86/entry/entry_64.S             | 26 ++++++++----------
 arch/x86/include/asm/idtentry.h       |  6 ++++
 arch/x86/include/asm/irqflags.h       | 46 ++++++++++---------------------
 arch/x86/include/asm/paravirt.h       | 30 --------------------
 arch/x86/include/asm/paravirt_types.h | 17 ++----------
 arch/x86/kernel/asm-offsets_64.c      |  3 --
 arch/x86/kernel/irqflags.S            | 11 --------
 arch/x86/kernel/paravirt.c            |  7 +----
 arch/x86/kernel/paravirt_patch.c      | 10 -------
 arch/x86/xen/enlighten_pv.c           | 32 +++++++++++++++------
 arch/x86/xen/irq.c                    | 23 ----------------
 arch/x86/xen/xen-asm.S                | 52 ++---------------------------------
 arch/x86/xen/xen-ops.h                |  3 --
 13 files changed, 60 insertions(+), 206 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
