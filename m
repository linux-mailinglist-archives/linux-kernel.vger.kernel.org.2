Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D1C4419CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhKAK2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:28:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47304 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhKAK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:28:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F76521940;
        Mon,  1 Nov 2021 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635762331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DuXHFHGPe4/MdAen38JSA+NW92zbioBFomR9fHA4BhQ=;
        b=YIbVat9HUSel1LnFJdXJbpCsH2sPfKVa6Ew7e8EmaB+dTKwVCf+hrbeD5smS9lXwNkQK55
        PwP64+JVfLyFVOKmfBohL3vHYC96kKWcbpdZtKPiziP/rEn3HVOM0Ek6vv+LMdB1C+doUh
        4vmUsNWPCqW4/MojamDb1ab1dO1ucio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635762331;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DuXHFHGPe4/MdAen38JSA+NW92zbioBFomR9fHA4BhQ=;
        b=JcWdzA/zCO4kAChykzgfp8vHUGzWdIkyNywUpt1YoiFtQ/oIfxd8YFGFwzlDncJ1BOg46e
        mlqIox8P+AQcD/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B32513AA9;
        Mon,  1 Nov 2021 10:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 63DnAZvAf2FoTQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 10:25:31 +0000
Date:   Mon, 1 Nov 2021 11:25:28 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL (not really)] x86/core for v5.16
Message-ID: <YX/AmFgkQ0AEqDaG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

so this is not really a pull request but more of a question on the
process. I have merged the x86/cc branch into this branch I'm sending to
you - x86/core - and when I generate the diffstat with git request-pull,
it adds the changes of the merged branch x86/cc too, of course.

I can doctor the diffstat and the merge message by doing

 git diff --stat ^x86/cc x86_core_for_v5.16_rc1

see below, so that the merged branch's changes are not there.

But I'm not sure if this is the right thing to do. Especially if you do
not merge x86/cc first - then the below diffstat becomes wrong.

So what I've been doing with cases like that in the past is to wait
until you merge the dependent branch and then to create the proper
diffstat and pull message.

And I'm going to do it this way too but thought that maybe I should ask
if there is an alternative accepted way which I could do in the future
too, without having to wait.

Thx.

---
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

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


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
