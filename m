Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B164426DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 06:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhKBFvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 01:51:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBFvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:51:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A2E621956;
        Tue,  2 Nov 2021 05:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635832113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQN4ystTydsP3Lk2G9Vyr/XSWEkZQFofekZEx4m1D+M=;
        b=OuwTs6KR98BJn/01QSnif2n02Bvo8wLIJr33Pb/JOQXkORvJ5KW01goIEJ9c1LiQoF0qBo
        oDzE+jZxXo8w5ARWFsMWE9yu/wf/4jXgCyKuyccW/8N09Dj0SUmZft4YWk8nSnXxaUHUNe
        ak50Q4bsyWH1sCgl/1C/CIop3P1Ugss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635832113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQN4ystTydsP3Lk2G9Vyr/XSWEkZQFofekZEx4m1D+M=;
        b=+NXhmRAfaEO4dV8e9F7AXYluewAF+pw4n/J7tWa8rROYsIu+aCtTqoTyWCR25HkPQJIr29
        ksebKtdXBs2xyNBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60EA4139F0;
        Tue,  2 Nov 2021 05:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fNlGFzHRgGFhMAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 02 Nov 2021 05:48:33 +0000
Date:   Tue, 2 Nov 2021 06:48:32 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v5.16
Message-ID: <YYDRMNr9+94+eHdi@zn.tnic>
References: <YX/AmFgkQ0AEqDaG@zn.tnic>
 <CAHk-=wiNyR-cAxicOD6nkRQNw-q+uzFvB3hpA-s=7asEKom=og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiNyR-cAxicOD6nkRQNw-q+uzFvB3hpA-s=7asEKom=og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:16:24PM -0700, Linus Torvalds wrote:
>  (b) when you have a series of pull requests that aren't independent,
> create the series of pulls yourself in a temporary tree, and generate
> the pull request from that series, with the previous merge always as
> the "base".

And doing the pull request message now, it looks like I could have
simply used as the <start> point in the invocation of

$ git request-pull [-p] <start> <url> [<end>]

the merged branch. I.e., usually I do:

$ git request-pull master tip x86_core_for_v5.16_rc1

i.e., master up to the tag and doing

$ git request-pull tip/x86/cc tip x86_core_for_v5.16_rc1

where tip/x86/cc is the branch which had to be merged into x86/core,
gives the exact same diffstat etc...

Now, with that out of the way, you can finally please pull the x86/core
updates for 5.16.

Btw, there's a small merge conflict with your tree, resolution at the
end of this mail, courtesy of Ingo.

Thanks!

---

The following changes since commit e9d1d2bb75b2d5d4b426769c5aae0ce8cef3558f:

  treewide: Replace the use of mem_encrypt_active() with cc_platform_has() (2021-10-04 11:47:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.16_rc1

for you to fetch changes up to a72fdfd21e01c626273ddcf5ab740d4caef4be54:

  selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage (2021-10-30 23:18:04 +0200)

----------------------------------------------------------------
- Do not #GP on userspace use of CLI/STI but pretend it was a NOP to
keep old userspace from breaking. Adjust the corresponding iopl selftest
to that.

- Improve stack overflow warnings to say which stack got overflowed and
raise the exception stack sizes to 2 pages since overflowing the single
page of exception stack is very easy to do nowadays with all the tracing
machinery enabled. With that, rip out the custom mapping of AMD SEV's
too.

- A bunch of changes in preparation for FGKASLR like supporting more
than 64K section headers in the relocs tool, correct ORC lookup table
size to cover the whole kernel .text and other adjustments.

----------------------------------------------------------------
Borislav Petkov (3):
      Merge branch x86/cc into x86/core
      x86/sev: Make the #VC exception stacks part of the default stacks storage
      selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage

Kees Cook (2):
      x86/boot: Allow a "silent" kaslr random byte fetch
      x86/boot/compressed: Avoid duplicate malloc() implementations

Kristen Carlson Accardi (2):
      x86/tools/relocs: Support >64K section headers
      vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext

Peter Zijlstra (3):
      x86/iopl: Fake iopl(3) CLI/STI usage
      x86/mm/64: Improve stack overflow warnings
      x86: Increase exception stack sizes

 arch/x86/boot/compressed/kaslr.c      |   4 --
 arch/x86/boot/compressed/misc.c       |   3 +
 arch/x86/boot/compressed/misc.h       |   2 +
 arch/x86/include/asm/cpu_entry_area.h |   8 ++-
 arch/x86/include/asm/insn-eval.h      |   1 +
 arch/x86/include/asm/irq_stack.h      |  37 ++++++++----
 arch/x86/include/asm/page_64_types.h  |   2 +-
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/stacktrace.h     |  10 ++++
 arch/x86/include/asm/traps.h          |   6 +-
 arch/x86/kernel/dumpstack_64.c        |   6 ++
 arch/x86/kernel/process.c             |   1 +
 arch/x86/kernel/sev.c                 |  32 -----------
 arch/x86/kernel/traps.c               |  58 +++++++++++++++----
 arch/x86/lib/insn-eval.c              |   2 +-
 arch/x86/lib/kaslr.c                  |  18 ++++--
 arch/x86/mm/cpu_entry_area.c          |   7 +++
 arch/x86/mm/fault.c                   |  20 +++----
 arch/x86/tools/relocs.c               | 103 +++++++++++++++++++++++++---------
 include/asm-generic/vmlinux.lds.h     |   3 +-
 include/linux/decompress/mm.h         |  12 +++-
 tools/testing/selftests/x86/iopl.c    |  78 ++++++++++++++++++-------
 22 files changed, 284 insertions(+), 130 deletions(-)


Merge conflict resolution:

---
commit 67ec0b0f87d0c5886006cb2b00b7c82eeab8c004
Merge: edfb8366b13b 2258a6fc33d5
Author: Ingo Molnar <mingo@kernel.org>
Date:   Mon Nov 1 10:19:22 2021 +0100

    Merge branch 'irq/core'
    
    Conflicts:
            arch/x86/include/asm/irq_stack.h

diff --cc arch/x86/include/asm/irq_stack.h
index e23a7868c6d2,ea0c5ab31da4..ae9d40f6c706
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@@ -201,6 -185,10 +201,7 @@@
  			      IRQ_CONSTRAINTS, regs, vector);		\
  }
  
+ #ifndef CONFIG_PREEMPT_RT
 -#define ASM_CALL_SOFTIRQ						\
 -	"call %P[__func]				\n"
 -
  /*
   * Macro to invoke __do_softirq on the irq stack. This is only called from
   * task context when bottom halves are about to be reenabled and soft

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
