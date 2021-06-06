Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD44739CDF2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFFH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:57:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56940 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFH5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:57:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 712911FD30;
        Sun,  6 Jun 2021 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622966157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VstjiBMm33y78FQkXkeOep9BwkExlIKSBlnBgt6a8qw=;
        b=lxIcC7Z1zITMG5JYYXKhQVTOBw2wt8GFZoG4fLVDXtBdkex/ahl+qYFjtRgTncrYXRETm1
        yv8rbCMp6impEThN6aCQqEmcaiFBwdu0RHlt76aleQ0GbBd1G6EDL+ODqo7z07M/+aHURX
        wXD5XAZXv9MSlh3lpjxjAJm0fGCbsOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622966157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VstjiBMm33y78FQkXkeOep9BwkExlIKSBlnBgt6a8qw=;
        b=ft+jBQPeQ2gPn+/idH6c3wJb2jfsbwrupOFsWzqOSHVU6iBZ66evLV5E81NZvTPrclTf/y
        hWOqC72qfyEzrTBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4CCF2118DD;
        Sun,  6 Jun 2021 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622966157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VstjiBMm33y78FQkXkeOep9BwkExlIKSBlnBgt6a8qw=;
        b=lxIcC7Z1zITMG5JYYXKhQVTOBw2wt8GFZoG4fLVDXtBdkex/ahl+qYFjtRgTncrYXRETm1
        yv8rbCMp6impEThN6aCQqEmcaiFBwdu0RHlt76aleQ0GbBd1G6EDL+ODqo7z07M/+aHURX
        wXD5XAZXv9MSlh3lpjxjAJm0fGCbsOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622966157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VstjiBMm33y78FQkXkeOep9BwkExlIKSBlnBgt6a8qw=;
        b=ft+jBQPeQ2gPn+/idH6c3wJb2jfsbwrupOFsWzqOSHVU6iBZ66evLV5E81NZvTPrclTf/y
        hWOqC72qfyEzrTBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id VylUEo1/vGBiCwAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 06 Jun 2021 07:55:57 +0000
Date:   Sun, 6 Jun 2021 09:55:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.13-rc5
Message-ID: <YLx/iA8xeRzwhXJn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a bunch of x86/urgent stuff accumulated for the last two weeks so lemme
unload it to you. It should be all totally risk-free, ofcourse. :-)

Please pull,
thx.

---

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13-rc5

for you to fetch changes up to 009767dbf42ac0dbe3cf48c1ee224f6b778aa85a:

  x86/sev: Check SME/SEV support in CPUID first (2021-06-04 18:39:09 +0200)

----------------------------------------------------------------
- Fix out-of-spec hardware (1st gen Hygon) which does not implement
MSR_AMD64_SEV even though the spec clearly states so, and check CPUID
bits first.

- Send only one signal to a task when it is a SEGV_PKUERR si_code type.

- Do away with all the wankery of reserving X amount of memory in
the first megabyte to prevent BIOS corrupting it and simply and
unconditionally reserve the whole first megabyte.

- Make alternatives NOP optimization work at an arbitrary position
within the patched sequence because the compiler can put single-byte
NOPs for alignment anywhere in the sequence (32-bit retpoline), vs our
previous assumption that the NOPs are only appended.

- Force-disable ENQCMD[S] instructions support and remove update_pasid()
because of insufficient protection against FPU state modification in an
interrupt context, among other xstate horrors which are being addressed
at the moment. This one limits the fallout until proper enablement.

- Use cpu_feature_enabled() in the idxd driver so that it can be
build-time disabled through the defines in .../asm/disabled-features.h.

- Fix LVT thermal setup for SMI delivery mode by making sure the APIC
LVT value is read before APIC initialization so that softlockups during
boot do not happen at least on one machine.

- Mark all legacy interrupts as legacy vectors when the IO-APIC is
disabled and when all legacy interrupts are routed through the PIC.

----------------------------------------------------------------
Borislav Petkov (3):
      x86/thermal: Fix LVT thermal setup for SMI delivery mode
      dmaengine: idxd: Use cpu_feature_enabled()
      x86/alternative: Optimize single-byte NOPs at an arbitrary position

Jiashuo Liang (1):
      x86/fault: Don't send SIGSEGV twice on SEGV_PKUERR

Mike Rapoport (1):
      x86/setup: Always reserve the first 1M of RAM

Pu Wen (1):
      x86/sev: Check SME/SEV support in CPUID first

Thomas Gleixner (2):
      x86/apic: Mark _all_ legacy interrupts when IO/APIC is missing
      x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()

 arch/x86/include/asm/apic.h              |  1 +
 arch/x86/include/asm/disabled-features.h |  7 +---
 arch/x86/include/asm/fpu/api.h           |  6 +--
 arch/x86/include/asm/fpu/internal.h      |  7 ----
 arch/x86/include/asm/thermal.h           |  4 +-
 arch/x86/kernel/alternative.c            | 64 +++++++++++++++++++++++---------
 arch/x86/kernel/apic/apic.c              |  1 +
 arch/x86/kernel/apic/vector.c            | 20 ++++++++++
 arch/x86/kernel/fpu/xstate.c             | 57 ----------------------------
 arch/x86/kernel/setup.c                  | 44 +++++++++++++++-------
 arch/x86/mm/fault.c                      |  4 +-
 arch/x86/mm/mem_encrypt_identity.c       | 11 +++---
 arch/x86/platform/efi/quirks.c           | 12 ++++++
 arch/x86/realmode/init.c                 | 14 ++++---
 drivers/dma/idxd/init.c                  |  4 +-
 drivers/thermal/intel/therm_throt.c      | 15 ++++++--
 16 files changed, 145 insertions(+), 126 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
