Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492A43FCC88
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhHaRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhHaRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q3so11101194plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpR1j4foRTEcoowMnHvCNe4seLyDOV/uvtLd6+E3J0g=;
        b=QhW02l6wgK4Kh2oJuAmxeidWt/nVoYRmLuYTVbMEeIPtcIf/V6DJ6t6yvHV9te0uDg
         zriIU2w9xcCPRor+zX1PlGFCGFizwMgCMSmwsBH4POhi/ZHFYJTokSxhNp4s3IpLNjAe
         y0XqnjgPTBq5tlb47lw4AUGowwOEd9O24AHCO3F8qpK4fv4tWY6s+BPviDY16RbSjV9p
         ng5NfPRUPPFkIgfHB8Ct2eAatLXtUwRDrbdbXwPhO5/jHg9ZrTy1m3hk4vb4wxEFNtFQ
         CBE3/eW71JaMVy67HjRsHKn5IcbELjarOzWJBDEiYETtQRlO/NljdwM/WTJEEfJC7MkQ
         62FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpR1j4foRTEcoowMnHvCNe4seLyDOV/uvtLd6+E3J0g=;
        b=mHcEMytdMW6VgkdH5a46/SVnXQS1ZkF+nIzJMbNGqdPcde+C0z8dpStQHmipOyt9BA
         7eJ/KVzvWqVlE08eyrFeWhDjkgkDgbC5f3lFPYwcmcCBWWKtXUKI8zWpoHgAFgfwpFaC
         T9SzXuDJyNGTcT9OF6hisf96oTjocXhjNM6aV4frfseg9askgxh/A+Eoz9Iw8ErHTJu8
         6ws+P/XaJgglvaZSJzKCRtBulLnuQaUNAxK4SMSYxSXJ/7gkpqL2VYiov/nS/bdjju4r
         7o/+IDwROTy4wlOWTeqHICjW+/ZXcUPkNPRiCoXWKwLhCJ7Uz1m+JmOAd3W469bFFh2f
         nYAw==
X-Gm-Message-State: AOAM531ynzDxq2KyRJl34WBTrep9NZhArCcPM0EKrh9A7K/JiusMVa87
        Mgxz04bDZzAimLhWtdQ1iDrAbw4OpNQ=
X-Google-Smtp-Source: ABdhPJx3/dtfLIX8z39aqUxyJf/iF+0E6iRUTe1jYLBT0sQiGZcW6grdkrIWZEcYGHP0opQOcCZk/Q==
X-Received: by 2002:a17:90a:8b08:: with SMTP id y8mr6778880pjn.173.1630432224149;
        Tue, 31 Aug 2021 10:50:24 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id y4sm3417888pjw.57.2021.08.31.10.50.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:50:23 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 00/24] x86/entry/64: Convert a bunch of ASM entry code into C code
Date:   Wed,  1 Sep 2021 01:50:01 +0800
Message-Id: <20210831175025.27570-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Many ASM code in entry_64.S can be rewritten in C if they can be written
to be non-instrumentable and are called in the right order regarding to
whether CR3/gsbase is changed to kernel CR3/gsbase.

The patchset covert some of them to C code.

The patch 11 converts the non paranoid entry (entry of interrupts/
non-IST-exception/IST-exception-from-user) to C code. And patch 1-10
are preparation for it and patch 12-13 are cleanup for it.  The patch 1
might fix a defect.

The patch 22 converts the paranoid entry/exit to Code.  And patch 14-21 are
pareparation for it and patch 23 is cleanup for it.

The patch 24 converts a small part of ASM code of syscall to C code which
does the checking for whether it can use sysret to return to userspace.

Some other paths can be possible to be in C code, for example: the non
paranoid exit, the syscall entry/exit.  The PTI handling for them can
be in C code.  But it would required the pt_regs to be copied/pushed
to the entry stack which means the C code would not be efficient.

When converting ASM to C, the most effort is to make them the same.
Almost no creative was involved.  The code are kept as the same as ASM
as possible and no functional change intended unless my missunderstanding
in the ASM code was involved.  The functions called by the C entry code
are checked to be ensured noinstr or __always_inline.  Some of them have
more than one definitions and require some more cares from reviewers.
The comments in the ASM are also copied in the right place in the C code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Lai Jiangshan (24):
  x86/traps: Remove stack-protector from traps.c
  x86/traps: Move arch/x86/kernel/traps.c to arch/x86/entry/
  x86/traps: Move declaration of native_irq_return_iret up
  x86/entry: Expose the address of .Lgs_change to traps.c
  x86/entry: Introduce __entry_text for entry code written in C
  x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
  x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
  x86/traps: Add C verion of SWITCH_TO_KERNEL_CR3 as
    switch_to_kernel_cr3()
  x86/traps: Add fence_swapgs_{user,kernel}_entry()
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Replace the most of asm code of error_entry to C code
  x86/traps: Reconstruct pt_regs on task stack directly in
    fixup_bad_iret()
  x86/traps: Mark sync_regs() and fixup_bad_iret() as static
    __always_inline
  x86/entry: Make paranoid_exit() callable
  x86/entry: Call paranoid_exit() in asm_exc_nmi()
  x86/entry: Use skip_rdi instead of save_ret for PUSH_AND_CLEAR_REGS
  x86/entry: Introduce struct ist_regs
  x86/entry: Add the C version ist_switch_to_kernel_cr3()
  x86/entry: Add the C version ist_restore_cr3()
  x86/entry: Add the C version get_percpu_base()
  x86/entry: Add the C version ist_switch_to_kernel_gsbase()
  x86/entry: Implement and use do_paranoid_entry() and paranoid_exit()
  x86/entry: Remove the unused ASM macros
  x86/syscall/64: Move the checking for sysret to C code

 arch/x86/entry/Makefile                |   5 +-
 arch/x86/entry/calling.h               | 144 +--------
 arch/x86/entry/common.c                |  73 ++++-
 arch/x86/entry/entry_64.S              | 366 ++++-------------------
 arch/x86/{kernel => entry}/traps.c     | 397 +++++++++++++++++++++++--
 arch/x86/include/asm/processor-flags.h |  15 +
 arch/x86/include/asm/special_insns.h   |   4 +-
 arch/x86/include/asm/syscall.h         |   2 +-
 arch/x86/include/asm/traps.h           |  36 ++-
 arch/x86/kernel/Makefile               |   2 +-
 arch/x86/kernel/asm-offsets_64.c       |   2 +
 11 files changed, 554 insertions(+), 492 deletions(-)
 rename arch/x86/{kernel => entry}/traps.c (74%)

-- 
2.19.1.6.gb485710b

