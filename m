Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD532D8D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhCDRqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCDRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B63C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:42:52 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44EF11EC04AD;
        Thu,  4 Mar 2021 18:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=JwlwPzCHaxj5cmPBIJdRD6Z+tj2H1CdkA4wdwRfTeps=;
        b=VCdjIs4jmxS73lmO0n15QmhY3yewDpx+XMAP12vgzlQrZYAflBn5aLN/Xde/sH4YQR3HnD
        CxHDAzU270ScZ0+Its8HMCF1vzXsH+NJtNWpJ9GWfLusZweoln61hum/VMda3GHe7//MRZ
        YEruSAyw7e/ul09Xia1riYe9FwjeOP8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/21] x86/insn: Add an insn_decode() API
Date:   Thu,  4 Mar 2021 18:42:16 +0100
Message-Id: <20210304174237.31945-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

here's v3 with the snafu Masami caught, fixed.

The rest is unchanged, it all is based on x86/seves which contains a
small fixlet to sev-es.c. If there are no more issues, I'll queue it
next week.

Thx.

Changelog:
==========

v2:
--

finally had some time during the merge window to finish reworking this.
Most if not all review feedback should be incorporated.

v1:
---

here's v1 with the requested change to return -ENODATA on short input to
the decoder. The rest is as in the previous submission.

Only lightly tested.

Thx.

v0:
---

https://lkml.kernel.org/r/20201124101952.7909-1-bp@alien8.de

here's what I had in mind, finally split into proper patches. The final
goal is for all users of the decoder to simply call insn_decode() and
look at its retval. Simple.

As to amluto's question about detecting partial insns, see the diff
below.

Running that gives:

insn buffer:
0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
supplied buf size: 15, ret 0
supplied buf size: 2, ret 0
supplied buf size: 3, ret 0
supplied buf size: 4, ret 0

and the return value is always success.

Which means that that buf_len that gets supplied to the decoder
functions doesn't really work and I need to look into it.

That is, provided this is how we want to control what the instruction
decoder decodes - by supplying the length of the buffer it should look
at.

We could also say that probably there should be a way to say "decode
only the first insn in the buffer and ignore the rest". That is all up
to the use cases so I'm looking for suggestions here.

In any case, at least the case where I give it

0x48 0xcf 0x48 0x83

and say that buf size is 4, should return an error because the second
insn is incomplete. So I need to go look at that now.


Borislav Petkov (21):
  x86/insn: Rename insn_decode() to insn_decode_from_regs()
  x86/insn: Add @buf_len param to insn_init() kernel-doc comment
  x86/insn: Add a __ignore_sync_check__ marker
  x86/insn: Add an insn_decode() API
  x86/insn-eval: Handle return values from the decoder
  x86/boot/compressed/sev-es: Convert to insn_decode()
  perf/x86/intel/ds: Check insn_get_length() retval
  perf/x86/intel/ds: Check return values of insn decoder functions
  x86/alternative: Use insn_decode()
  x86/mce: Convert to insn_decode()
  x86/kprobes: Convert to insn_decode()
  x86/sev-es: Split vc_decode_insn()
  x86/sev-es: Convert to insn_decode()
  x86/traps: Convert to insn_decode()
  x86/uprobes: Convert to insn_decode()
  x86/tools/insn_decoder_test: Convert to insn_decode()
  tools/objtool: Convert to insn_decode()
  x86/tools/insn_sanity: Convert to insn_decode()
  tools/perf: Convert to insn_decode()
  x86/insn: Remove kernel_insn_init()
  x86/insn: Make insn_complete() static

 arch/x86/boot/compressed/sev-es.c             |  11 +-
 arch/x86/events/intel/ds.c                    |  11 +-
 arch/x86/events/intel/lbr.c                   |  10 +-
 arch/x86/include/asm/inat.h                   |   2 +-
 arch/x86/include/asm/insn-eval.h              |   4 +-
 arch/x86/include/asm/insn.h                   |  44 ++--
 arch/x86/kernel/alternative.c                 |   6 +-
 arch/x86/kernel/cpu/mce/severity.c            |  12 +-
 arch/x86/kernel/kprobes/core.c                |  17 +-
 arch/x86/kernel/kprobes/opt.c                 |   9 +-
 arch/x86/kernel/sev-es.c                      |  63 +++--
 arch/x86/kernel/traps.c                       |   7 +-
 arch/x86/kernel/umip.c                        |   2 +-
 arch/x86/kernel/uprobes.c                     |   8 +-
 arch/x86/lib/inat.c                           |   2 +-
 arch/x86/lib/insn-eval.c                      |  40 +--
 arch/x86/lib/insn.c                           | 230 ++++++++++++++----
 arch/x86/tools/insn_decoder_test.c            |  10 +-
 arch/x86/tools/insn_sanity.c                  |   8 +-
 tools/arch/x86/include/asm/inat.h             |   2 +-
 tools/arch/x86/include/asm/insn.h             |  44 ++--
 tools/arch/x86/lib/inat.c                     |   2 +-
 tools/arch/x86/lib/insn.c                     | 230 ++++++++++++++----
 tools/include/linux/kconfig.h                 |  73 ++++++
 tools/objtool/arch/x86/decode.c               |   9 +-
 tools/objtool/sync-check.sh                   |  17 +-
 tools/perf/arch/x86/tests/insn-x86.c          |   9 +-
 tools/perf/arch/x86/util/archinsn.c           |   9 +-
 tools/perf/check-headers.sh                   |  15 +-
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |  17 +-
 30 files changed, 648 insertions(+), 275 deletions(-)
 create mode 100644 tools/include/linux/kconfig.h

-- 
2.29.2
