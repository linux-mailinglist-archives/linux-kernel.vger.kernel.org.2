Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3542801C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhJJI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:58:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhJJI6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:58:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78D1422132;
        Sun, 10 Oct 2021 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633856170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HTdjODQGQL3pgMMNcnJCIwsPjLFJqycYxweWWC06Hl8=;
        b=SSsOBvEeh+4kDzJF6HsX1sCienB3ge5e/j31ajT/7aMEFsSDHomLM4pSXI44vMLlAjiXJX
        JO0zmlvqat2bY/VKV8c8P3GXnz8YGP75ABKCISrsVBsIMyYLv2tiFcmqyjwkCHWcBazYqV
        WcPjjT/8wuZn7AC6SZJ1roARvSp+Ur0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633856170;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HTdjODQGQL3pgMMNcnJCIwsPjLFJqycYxweWWC06Hl8=;
        b=ls00Mkbg57SMfA4yg9jz9b8tlIUI++lX0EcbWAMISHvJM3VFpUWNx25b/UeAgnnVv5MiKZ
        JJjoxF0qyuRCE7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 593CF13479;
        Sun, 10 Oct 2021 08:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GyNpFaqqYmFoSAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 10 Oct 2021 08:56:10 +0000
Date:   Sun, 10 Oct 2021 10:56:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.15-rc5
Message-ID: <YWKqpkLDl4Yd87z1@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the last two weeks gathered in several x86/urgent fixes, please pull
them in.

Thx.

---

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc5

for you to fetch changes up to d298b03506d3e161f7492c440babb0bfae35e650:

  x86/fpu: Restore the masking out of reserved MXCSR bits (2021-10-08 11:12:17 +0200)

----------------------------------------------------------------
- A FPU fix to properly handle invalid MXCSR values: 32-bit masks them
out due to histerical reasons and 64-bit kernels reject them

- A fix to clear X86_FEATURE_SMAP when support for is not config-enabled

- Three fixes correcting misspelled Kconfig symbols used in code

- Two resctrl object cleanup fixes

- Yet another attempt at fixing the neverending saga of botched x86
timers, this time because some incredibly smart hardware decides to turn
off the HPET timer in a low power state - who cares if the OS is relying
on it...

- Check the full return value range of an SEV VMGEXIT call to determine
whether it returned an error

----------------------------------------------------------------
Borislav Petkov (1):
      x86/fpu: Restore the masking out of reserved MXCSR bits

James Morse (2):
      x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state() fails
      x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()

Lukas Bulwahn (3):
      x86/entry: Correct reference to intended CONFIG_64_BIT
      x86/platform/olpc: Correct ifdef symbol to intended CONFIG_OLPC_XO15_SCI
      x86/Kconfig: Correct reference to MWINCHIP3D

Thomas Gleixner (1):
      x86/hpet: Use another crystalball to evaluate HPET usability

Tom Lendacky (1):
      x86/sev: Return an error on a returned non-zero SW_EXITINFO1[31:0]

Vegard Nossum (1):
      x86/entry: Clear X86_FEATURE_SMAP when CONFIG_X86_SMAP=n

 arch/x86/Kconfig                    |  2 +-
 arch/x86/include/asm/entry-common.h |  2 +-
 arch/x86/kernel/cpu/common.c        |  1 +
 arch/x86/kernel/cpu/resctrl/core.c  |  6 ++-
 arch/x86/kernel/early-quirks.c      |  6 ---
 arch/x86/kernel/fpu/signal.c        | 11 +++--
 arch/x86/kernel/hpet.c              | 81 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/sev-shared.c        |  2 +
 arch/x86/platform/olpc/olpc.c       |  2 +-
 9 files changed, 99 insertions(+), 14 deletions(-)


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
