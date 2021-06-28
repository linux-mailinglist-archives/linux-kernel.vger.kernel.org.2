Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798113B5A74
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhF1I33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:29:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47362 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhF1I32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:29:28 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D296E20222;
        Mon, 28 Jun 2021 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624868822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=If4Pg72LTogOO06HS4XF4GqXFiMrBXOyzY6IHibjVJI=;
        b=fLkJ51iQj4NfJFUpud6kVmQgusqdh9IuTn8FZiLO9Lpl/j5aFPn2uK5t92GwNcQ0qKgGZF
        tahxzz94eAnyTDkwtR5O7dtuwuCoCwyg32fs6h1yeNhx4Uop28ZP7F2XcdzWlmLaZUh1BB
        MAKkVmeZVYVbgQPIpK0Tv7azchNI3ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624868822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=If4Pg72LTogOO06HS4XF4GqXFiMrBXOyzY6IHibjVJI=;
        b=ru1tVbCd3cUxxuDkX/qmyu1YNqSb9VaIIuWKrzMfGIx1CdfCtiy/9BGr1HCGHZhWN9FWL5
        z1Rud+2maLciPuBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B6729118DD;
        Mon, 28 Jun 2021 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624868822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=If4Pg72LTogOO06HS4XF4GqXFiMrBXOyzY6IHibjVJI=;
        b=fLkJ51iQj4NfJFUpud6kVmQgusqdh9IuTn8FZiLO9Lpl/j5aFPn2uK5t92GwNcQ0qKgGZF
        tahxzz94eAnyTDkwtR5O7dtuwuCoCwyg32fs6h1yeNhx4Uop28ZP7F2XcdzWlmLaZUh1BB
        MAKkVmeZVYVbgQPIpK0Tv7azchNI3ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624868822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=If4Pg72LTogOO06HS4XF4GqXFiMrBXOyzY6IHibjVJI=;
        b=ru1tVbCd3cUxxuDkX/qmyu1YNqSb9VaIIuWKrzMfGIx1CdfCtiy/9BGr1HCGHZhWN9FWL5
        z1Rud+2maLciPuBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id BntlK9aH2WCUOAAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 28 Jun 2021 08:27:02 +0000
Date:   Mon, 28 Jun 2021 10:27:02 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GTI PULL] x86/cpu updates for v5.14
Message-ID: <YNmH1pFTZqKlRAO5@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a bunch of x86/cpu updates for v5.14.

Thx.

---

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.14_rc1

for you to fetch changes up to 293649307ef9abcd4f83f6dac4d4400dfd97c936:

  x86/tsx: Clear CPUID bits when TSX always force aborts (2021-06-15 17:46:48 +0200)

----------------------------------------------------------------
- New AMD models support

- Allow MONITOR/MWAIT to be used for C1 state entry on Hygon too

- Use the special RAPL CPUID bit to detect the functionality on AMD and
  Hygon instead of doing family matching.

- Add support for new Intel microcode deprecating TSX on some models and
do not enable kernel workarounds for those CPUs when TSX transactions
always abort, as a result of that microcode update.

----------------------------------------------------------------
Andi Kleen (1):
      x86/cpu: Fix core name for Sapphire Rapids

Andrew Cooper (1):
      perf/x86/rapl: Use CPUID bit on AMD and Hygon parts

David Bartley (1):
      x86/amd_nb: Add AMD family 19h model 50h PCI ids

Pawan Gupta (3):
      x86/msr: Define new bits in TSX_FORCE_ABORT MSR
      x86/events/intel: Do not deploy TSX force abort workaround when TSX is deprecated
      x86/tsx: Clear CPUID bits when TSX always force aborts

Pu Wen (1):
      x86/cstate: Allow ACPI C1 FFH MWAIT use on Hygon systems

 arch/x86/events/intel/core.c        |  8 +++++++-
 arch/x86/events/rapl.c              |  6 ++----
 arch/x86/include/asm/cpufeatures.h  |  3 ++-
 arch/x86/include/asm/intel-family.h |  3 ++-
 arch/x86/include/asm/msr-index.h    |  4 ++++
 arch/x86/kernel/acpi/cstate.c       |  3 ++-
 arch/x86/kernel/amd_nb.c            |  3 +++
 arch/x86/kernel/cpu/amd.c           |  4 ++++
 arch/x86/kernel/cpu/cpu.h           |  2 ++
 arch/x86/kernel/cpu/hygon.c         |  4 ++++
 arch/x86/kernel/cpu/intel.c         |  4 +++-
 arch/x86/kernel/cpu/tsx.c           | 37 +++++++++++++++++++++++++++++++++++--
 include/linux/pci_ids.h             |  1 +
 13 files changed, 71 insertions(+), 11 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
