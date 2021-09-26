Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2854189B3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhIZPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhIZPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88240C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k26so8804906pfi.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hofrnEGqqNlWzL9YwEziE2i8AS0lUMOXFV3v1j7iPcA=;
        b=H51Rr6V14xvv11pvbFo9TJxQ+iOYC+0F+rvfceHyyDpmD7Hp3WJdr7cOe9zCE8/Wdc
         izf7r/73QSM/QCQ0zM7H/d9mpJhOQvclI+Jt8P6dF8SGUAgOzHD3QHNfPCloOvvqnMU8
         I4DUSdgEs2UaQzjTkLGKeAArgIZs673Qd2yH8O8tRUiB6CdQeEsUYpMqdg318zjEMjYJ
         v5N3EEfx+4cAhj2NTCams4C39Np9n0FVn7u4AF2ISmQRl+Vh7rjhvakbso4CnDGGCkhZ
         6WbrUM9nFhfgyj/Z1mK5ymOWlB+JF2JOt9pL/4HSdejE9WxT3ssdnctMQbesa6yYZd7J
         jgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hofrnEGqqNlWzL9YwEziE2i8AS0lUMOXFV3v1j7iPcA=;
        b=QzNYbWPJck2NvQjNkLaOebs67vtzKZ9K+ZQ68bHuTv8V5bW4qAoZtpUc8cra5/Fiyx
         RD3xXqUSiQFNy20t4lfP4SdMhbpoFFH1DeAf6CYz73doZxNP3FtsVDDuimh7zxI1TgwS
         uKUlx9UPW5iVp2CelT2O3Y6K3L3vpYGQk2uhOMF9tvI4twA6epWSoLEqOdKr5E2yvuM8
         HWxnlxrPgZ0MsocfcO6tLf/JeFluEouAL7F+/CYw4ZBkakpcPFlLyC/05ctJ1K05xFHs
         bJd0SecBn7ibeHhPdJ15eenbB9L1Ma9CIFn2mMKPu5/zkdWbeA6X39ENduZ3bHS/zRdl
         SmOw==
X-Gm-Message-State: AOAM531fnKONl1c+8D2S0fOkuS4qRdh8o1YkytqnHpSzDMTqvmbJu8tk
        XnM6J+5aJ9WbQn9PxrojZVdShC9Viq3QuQ==
X-Google-Smtp-Source: ABdhPJwIq7FpfRS+vIgWdATnKZpv+/GGbkq7vbBs6IikafMvd7AUoVZV2ZSAGKRCbjKayAEQWEvcsw==
X-Received: by 2002:a62:64d7:0:b0:438:7342:edfa with SMTP id y206-20020a6264d7000000b004387342edfamr19548812pfb.3.1632668913833;
        Sun, 26 Sep 2021 08:08:33 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id x15sm15875147pgt.34.2021.09.26.08.08.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:08:33 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V2 00/41] x86/entry/64: Convert a bunch of ASM entry code into C code
Date:   Sun, 26 Sep 2021 23:07:57 +0800
Message-Id: <20210926150838.197719-1-jiangshanlai@gmail.com>
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

The patch 16 converts the error_entry() to C code. And patch 1-15
are preparation for it.

The patches 17-37 convert the IST entry code to C code.  Many of them
are preparation for the actual conversion.

The patch 41 converts a small part of ASM code of syscall to C code which
does the checking for whether it can use sysret to return to userspace.

Some other paths can be possible to be in C code, for example: the
error exit, the syscall entry/exit.  The PTI handling for them can
be in C code.  But it would required the pt_regs to be copied/pushed
to the entry stack which means the C code would not be efficient.

When converting ASM to C, the most effort is to make them the same.
Almost no creative was involved.  The code are kept as the same as ASM
as possible and no functional change intended unless my misunderstanding
in the ASM code was involved.  The functions called by the C entry code
are checked to be ensured noinstr or __always_inline.  Some of them have
more than one definitions and require some more cares from reviewers.
The comments in the ASM are also copied in the right place in the C code.

Changed from V1:
	Add a fix as the patch1.  Found by trying to applied Peterz's
		suggestion in patch11.
	The whole entry_error() is converted to C instead of partial.
	The whole parnoid_entry() is converted to C instead of partial.
	The asm code of "parnoid_entry() cfunc() parnoid_exit()" are
		converted to C as suggested by Peterz.
	Add entry64.c rather than move traps.c to arch/x86/entry/
	The order of some commits is changed.
	Remove two cleanups

[V1]: https://lore.kernel.org/all/20210831175025.27570-1-jiangshanlai@gmail.com/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Joerg Roedel <jroedel@suse.de>

Lai Jiangshan (41):
  x86/entry: Fix swapgs fence
  x86/traps: Remove stack-protector from traps.c
  compiler_types.h: Add __noinstr_section() for noinstr
  x86/entry: Introduce __entry_text for entry code written in C
  x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
  x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
  x86/traps: Move the declaration of native_irq_return_iret into proto.h
  x86/entry: Add arch/x86/entry/entry64.c for C entry code
  x86/entry: Expose the address of .Lgs_change to entry64.c
  x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as
    switch_to_kernel_cr3()
  x86/entry: Add C user_entry_swapgs_and_fence() and
    kernel_entry_fence_no_swapgs()
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
  objtool: Allow .entry.text function using CLD instruction
  x86/entry: Implement the whole error_entry() as C code
  x86/entry: Make paranoid_exit() callable
  x86/entry: Call paranoid_exit() in asm_exc_nmi()
  x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
  x86/entry: Add the C version ist_switch_to_kernel_cr3()
  x86/entry: Add the C version ist_restore_cr3()
  x86/entry: Add the C version get_percpu_base()
  x86/entry: Add the C version ist_switch_to_kernel_gsbase()
  x86/entry: Implement the C version ist_paranoid_entry()
  x86/entry: Implement the C version ist_paranoid_exit()
  x86/entry: Add a C macro to define the function body for IST in
    .entry.text
  x86/mce: Remove stack protector from mce/core.c
  x86/debug, mce: Use C entry code
  x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
  x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
  x86/nmi: Remove stack protector from nmi.c
  x86/nmi: Use C entry code
  x86/entry: Add a C macro to define the function body for IST in
    .entry.text with an error code
  x86/doublefault: Use C entry code
  x86/sev: Add and use ist_vc_switch_off_ist()
  x86/sev: Remove stack protector from sev.c
  x86/sev: Use C entry code
  x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
  x86/entry: Remove the unused ASM macros
  x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
  x86/syscall/64: Move the checking for sysret to C code

 arch/x86/entry/Makefile                |   5 +-
 arch/x86/entry/calling.h               | 142 +--------
 arch/x86/entry/common.c                |  73 ++++-
 arch/x86/entry/entry64.c               | 354 ++++++++++++++++++++++
 arch/x86/entry/entry_64.S              | 403 +++----------------------
 arch/x86/include/asm/idtentry.h        |  64 +++-
 arch/x86/include/asm/processor-flags.h |  15 +
 arch/x86/include/asm/proto.h           |   1 +
 arch/x86/include/asm/special_insns.h   |   4 +-
 arch/x86/include/asm/syscall.h         |   2 +-
 arch/x86/include/asm/traps.h           |   6 +-
 arch/x86/kernel/Makefile               |   7 +
 arch/x86/kernel/cpu/mce/Makefile       |   4 +
 arch/x86/kernel/nmi.c                  |   2 +-
 arch/x86/kernel/traps.c                |  33 +-
 include/linux/compiler_types.h         |   6 +-
 tools/objtool/check.c                  |   2 +-
 17 files changed, 580 insertions(+), 543 deletions(-)
 create mode 100644 arch/x86/entry/entry64.c

-- 
2.19.1.6.gb485710b

