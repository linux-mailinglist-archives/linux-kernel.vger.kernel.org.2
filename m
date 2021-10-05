Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C014229CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhJEOCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235729AbhJEOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:00:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD8C2610EA;
        Tue,  5 Oct 2021 13:58:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxd-0055cw-Kl; Tue, 05 Oct 2021 09:58:25 -0400
Message-ID: <20211005135733.485175654@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>
Subject: [for-linus][PATCH 00/27] tracing: Updates for 5.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: bf094cffea2a6503ce84062f9f0243bef77c58f9


Josh Poimboeuf (3):
      objtool: Add frame-pointer-specific function ignore
      objtool: Ignore unwind hints for ignored functions
      x86/kprobes: Add UNWIND_HINT_FUNC on kretprobe_trampoline()

Masami Hiramatsu (19):
      kprobes: treewide: Cleanup the error messages for kprobes
      kprobes: Fix coding style issues
      kprobes: Use IS_ENABLED() instead of kprobes_built_in()
      kprobes: Add assertions for required lock
      kprobes: treewide: Use 'kprobe_opcode_t *' for the code address in get_optimized_kprobe()
      kprobes: Use bool type for functions which returns boolean value
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_symbol_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: treewide: Make it harder to refer kretprobe_trampoline directly
      kprobes: Add kretprobe_find_ret_addr() for searching return address
      ARC: Add instruction_pointer_set() API
      ia64: Add instruction_pointer_set() API
      arm: kprobes: Make space for instruction pointer on stack
      kprobes: Enable stacktrace from pt_regs in kretprobe handler
      x86/kprobes: Push a fake return address at kretprobe_trampoline
      x86/unwind: Recover kretprobe trampoline entry
      tracing: Show kretprobe unknown indicator only for kretprobe_trampoline
      x86/kprobes: Fixup return address in generic trampoline handler

Punit Agrawal (5):
      kprobes: Do not use local variable when creating debugfs file
      kprobes: Use helper to parse boolean input from userspace
      kprobe: Simplify prepare_kprobe() by dropping redundant version
      csky: ftrace: Drop duplicate implementation of arch_check_ftrace_location()
      kprobes: Make arch_check_ftrace_location static

----
 arch/arc/include/asm/kprobes.h                |   2 +-
 arch/arc/include/asm/ptrace.h                 |   5 +
 arch/arc/kernel/kprobes.c                     |  13 +-
 arch/arm/probes/kprobes/core.c                |  15 +-
 arch/arm/probes/kprobes/opt-arm.c             |   7 +-
 arch/arm64/include/asm/kprobes.h              |   2 +-
 arch/arm64/kernel/probes/kprobes.c            |  10 +-
 arch/arm64/kernel/probes/kprobes_trampoline.S |   4 +-
 arch/csky/include/asm/kprobes.h               |   2 +-
 arch/csky/kernel/probes/ftrace.c              |   7 -
 arch/csky/kernel/probes/kprobes.c             |  14 +-
 arch/csky/kernel/probes/kprobes_trampoline.S  |   4 +-
 arch/ia64/include/asm/ptrace.h                |   5 +
 arch/ia64/kernel/kprobes.c                    |  15 +-
 arch/mips/kernel/kprobes.c                    |  26 +-
 arch/parisc/kernel/kprobes.c                  |   6 +-
 arch/powerpc/include/asm/kprobes.h            |   2 +-
 arch/powerpc/kernel/kprobes.c                 |  29 +-
 arch/powerpc/kernel/optprobes.c               |   8 +-
 arch/powerpc/kernel/stacktrace.c              |   2 +-
 arch/riscv/include/asm/kprobes.h              |   2 +-
 arch/riscv/kernel/probes/kprobes.c            |  15 +-
 arch/riscv/kernel/probes/kprobes_trampoline.S |   4 +-
 arch/s390/include/asm/kprobes.h               |   2 +-
 arch/s390/kernel/kprobes.c                    |  16 +-
 arch/s390/kernel/stacktrace.c                 |   2 +-
 arch/sh/include/asm/kprobes.h                 |   2 +-
 arch/sh/kernel/kprobes.c                      |  12 +-
 arch/sparc/include/asm/kprobes.h              |   2 +-
 arch/sparc/kernel/kprobes.c                   |  12 +-
 arch/x86/include/asm/kprobes.h                |   1 -
 arch/x86/include/asm/unwind.h                 |  23 ++
 arch/x86/include/asm/unwind_hints.h           |   5 +
 arch/x86/kernel/kprobes/core.c                |  71 +++-
 arch/x86/kernel/kprobes/opt.c                 |   6 +-
 arch/x86/kernel/unwind_frame.c                |   3 +-
 arch/x86/kernel/unwind_guess.c                |   3 +-
 arch/x86/kernel/unwind_orc.c                  |  21 +-
 include/linux/kprobes.h                       | 113 +++---
 include/linux/objtool.h                       |  12 +
 kernel/kprobes.c                              | 502 ++++++++++++++------------
 kernel/trace/trace_kprobe.c                   |   2 +-
 kernel/trace/trace_output.c                   |  17 +-
 lib/error-inject.c                            |   3 +-
 tools/include/linux/objtool.h                 |  12 +
 tools/objtool/check.c                         |   2 +-
 46 files changed, 607 insertions(+), 436 deletions(-)
