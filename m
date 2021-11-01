Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD81F4417E7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhKAJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:41:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45486 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhKAJjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:39:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2915B21891;
        Mon,  1 Nov 2021 09:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635759399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VkvRmtzaMwQVzGnYzNDOr+dDnG2YSYcgGsrZZek3ew4=;
        b=qoemHH92UKh1amzOwEfD6gNQEn7IO/n94VKUa3F+DXdDnEDrCeTQWG1X3UdM+pfV3a48OS
        ice0s2IcY+rbMJPmlHcONWHizqzzUjSv1sxPBYr3m943fRrnil6VHf9ppWQCxBvdL6CrsG
        WIEMlKj6QxjCTnPx1NHrcVC63KoA4ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635759399;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VkvRmtzaMwQVzGnYzNDOr+dDnG2YSYcgGsrZZek3ew4=;
        b=oL0TJD7QX+565r70WzC8M5dUEqOUV3K6B7o7OUd9SAKItzBc+VMInyJFN6PxE/oUv3g2ck
        xnhHH6ipVblJS5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1666D13AB7;
        Mon,  1 Nov 2021 09:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L30WBSe1f2GVOwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 09:36:39 +0000
Date:   Mon, 1 Nov 2021 10:36:36 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v5.16
Message-ID: <YX+1JHxvxDUHTjFw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of RAS updates for 5.16.

As Thomas already mentioned, this branch has a merge conflict with
x86/fpu and will conflict in a different way, depending on what you
merge first.

I've added the resolve we've been doing in the tip tree at the end of
this message too, for your convenience.

Thx.

---

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.16_rc1

for you to fetch changes up to 15802468a95bd8ec9060eb861468f4a0f0106fa4:

  x86/mce: Sort mca_config members to get rid of unnecessary padding (2021-09-23 11:38:04 +0200)

----------------------------------------------------------------
- Get rid of a bunch of function pointers used in MCA land in favor
of normal functions. This is in preparation of making the MCA code
noinstr-aware

- When the kernel copies data from user addresses and it encounters a
machine check, a SIGBUS is sent to that process. Change this action to
either an -EFAULT which is returned to the user or a short write, making
the recovery action a lot more user-friendly

----------------------------------------------------------------
Borislav Petkov (5):
      x86/mce: Get rid of the mce_severity function pointer
      x86/mce: Get rid of machine_check_vector
      x86/mce: Get rid of msr_ops
      x86/mce: Get rid of the ->quirk_no_way_out() indirect call
      x86/mce: Sort mca_config members to get rid of unnecessary padding

Tony Luck (2):
      x86/mce: Change to not send SIGBUS error during copy from user
      x86/mce: Drop copyin special case for #MC

 arch/x86/include/asm/mce.h         |  12 --
 arch/x86/kernel/cpu/mce/amd.c      |  10 +-
 arch/x86/kernel/cpu/mce/core.c     | 252 ++++++++++++++++---------------------
 arch/x86/kernel/cpu/mce/internal.h |  59 ++++++---
 arch/x86/kernel/cpu/mce/p5.c       |   6 +-
 arch/x86/kernel/cpu/mce/severity.c |  11 +-
 arch/x86/kernel/cpu/mce/winchip.c  |   6 +-
 arch/x86/lib/copy_user_64.S        |  13 --
 8 files changed, 161 insertions(+), 208 deletions(-)

---

Merge conflict resolve:

diff --cc arch/x86/kernel/cpu/mce/internal.h
index 37b9e381ef02,3463f8cedb32..acd61c41846c
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@@ -190,31 -183,7 +190,21 @@@ extern bool filter_mce(struct mce *m)
  #ifdef CONFIG_X86_MCE_AMD
  extern bool amd_filter_mce(struct mce *m);
  #else
- static inline bool amd_filter_mce(struct mce *m)			{ return false; };
+ static inline bool amd_filter_mce(struct mce *m) { return false; }
  #endif
  
- __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
- 				      struct pt_regs *regs, int trapnr,
- 				      unsigned long error_code,
- 				      unsigned long fault_addr);
- 
- __visible bool ex_handler_wrmsr_fault(const struct exception_table_entry *fixup,
- 				      struct pt_regs *regs, int trapnr,
- 				      unsigned long error_code,
- 				      unsigned long fault_addr);
- 
 +#ifdef CONFIG_X86_ANCIENT_MCE
 +void intel_p5_mcheck_init(struct cpuinfo_x86 *c);
 +void winchip_mcheck_init(struct cpuinfo_x86 *c);
 +noinstr void pentium_machine_check(struct pt_regs *regs);
 +noinstr void winchip_machine_check(struct pt_regs *regs);
 +static inline void enable_p5_mce(void) { mce_p5_enabled = 1; }
 +#else
 +static inline void intel_p5_mcheck_init(struct cpuinfo_x86 *c) {}
 +static inline void winchip_mcheck_init(struct cpuinfo_x86 *c) {}
 +static inline void enable_p5_mce(void) {}
 +static inline void pentium_machine_check(struct pt_regs *regs) {}
 +static inline void winchip_machine_check(struct pt_regs *regs) {}
 +#endif
 +
  #endif /* __X86_MCE_INTERNAL_H__ */

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
