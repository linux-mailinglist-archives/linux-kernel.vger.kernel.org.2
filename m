Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B643ADD66
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhFTHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 03:01:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhFTHB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 03:01:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1C91FD29;
        Sun, 20 Jun 2021 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624172383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ROOXzRDw1RUGmYZ1T8H7kFYotje29jwY0WPXXtXdI1Q=;
        b=JnpaNbX45aW9FaBVzvA3LlGfAoRqNxn1TmolWuY7+V7Gf7AfK7Qo4Kn0PvpGkYXAHVNauQ
        /ao69oEBtA83w9ivPOGMZX+WfU901J/eE2OebUXGx4IbNxiNvRmpgjBtMglDRn7hHdQ1kS
        0ZHG0X4q/SyAt5iIP38K9lg11bjiLWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624172383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ROOXzRDw1RUGmYZ1T8H7kFYotje29jwY0WPXXtXdI1Q=;
        b=gJLg48J3nBWyMMOn2tv/ywsMPE/ZbczzB3tgmWh1D7ExwW5K5x121NbXONbCV/SVy3h/EL
        p2ykP+qaZLkdUTBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5F0E6118DD;
        Sun, 20 Jun 2021 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624172383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ROOXzRDw1RUGmYZ1T8H7kFYotje29jwY0WPXXtXdI1Q=;
        b=JnpaNbX45aW9FaBVzvA3LlGfAoRqNxn1TmolWuY7+V7Gf7AfK7Qo4Kn0PvpGkYXAHVNauQ
        /ao69oEBtA83w9ivPOGMZX+WfU901J/eE2OebUXGx4IbNxiNvRmpgjBtMglDRn7hHdQ1kS
        0ZHG0X4q/SyAt5iIP38K9lg11bjiLWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624172383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ROOXzRDw1RUGmYZ1T8H7kFYotje29jwY0WPXXtXdI1Q=;
        b=gJLg48J3nBWyMMOn2tv/ywsMPE/ZbczzB3tgmWh1D7ExwW5K5x121NbXONbCV/SVy3h/EL
        p2ykP+qaZLkdUTBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4TSSF1/nzmDcTwAALh3uQQ
        (envelope-from <bp@suse.de>); Sun, 20 Jun 2021 06:59:43 +0000
Date:   Sun, 20 Jun 2021 08:59:31 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.13-rc6
Message-ID: <YM7nUwsJ+1v66B9m@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some x86/urgent fixes before 5.13 releases. This time, I'm not
even going to think of saying that they're the last batch. :)

Please pull,
thx.

---

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc6

for you to fetch changes up to 28e5e44aa3f4e0e0370864ed008fb5e2d85f4dc8:

  x86/mm: Avoid truncating memblocks for SGX memory (2021-06-18 19:37:01 +0200)

----------------------------------------------------------------
A first set of urgent fixes to the FPU/XSTATE handling mess^W code.
(There's a lot more in the pipe):

- Prevent corruption of the XSTATE buffer in signal handling by
  validating what is being copied from userspace first.

- Invalidate other task's preserved FPU registers on XRSTOR failure
  (#PF) because latter can still modify some of them.

- Restore the proper PKRU value in case userspace modified it

- Reset FPU state when signal restoring fails

Other:

- Map EFI boot services data memory as encrypted in a SEV guest so that
  the guest can access it and actually boot properly

- Two SGX correctness fixes: proper resources freeing and a NUMA fix

----------------------------------------------------------------
Andy Lutomirski (1):
      x86/fpu: Invalidate FPU state after a failed XRSTOR from a user buffer

Fan Du (1):
      x86/mm: Avoid truncating memblocks for SGX memory

Kai Huang (1):
      x86/sgx: Add missing xa_destroy() when virtual EPC is destroyed

Thomas Gleixner (4):
      x86/fpu: Prevent state corruption in __fpu__restore_sig()
      x86/process: Check PF_KTHREAD and not current->mm for kernel threads
      x86/pkru: Write hardware init value to PKRU when xstate is init
      x86/fpu: Reset state for all signal restore failures

Tom Lendacky (1):
      x86/ioremap: Map EFI-reserved memory as encrypted for SEV

 arch/x86/include/asm/fpu/internal.h | 13 ++++++---
 arch/x86/kernel/cpu/sgx/virt.c      |  1 +
 arch/x86/kernel/fpu/signal.c        | 54 ++++++++++++++++++++++++-------------
 arch/x86/mm/ioremap.c               |  4 ++-
 arch/x86/mm/numa.c                  |  8 +++++-
 5 files changed, 56 insertions(+), 24 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
