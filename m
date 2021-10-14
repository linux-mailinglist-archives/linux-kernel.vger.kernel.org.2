Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00A242D0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJNDQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJNDQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:16:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E5C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 66so4191303pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EM1+V23pNsBMyMnIegw2B3PVe6SGaCvPvEr1hY3r+Uc=;
        b=MknAh0+PwYNdPJo+sRtZjpuR42RsBB69PRZFsm5OXRUjYmdjV5NtbywUKsTbK3PuEB
         86af+34yyfi9NQ4CuLsALunjDBiJBioqn8lrUgXCvIPVaPJdw06Bvheq+DvlhZMMNBpS
         caEsgskH8iVxykFUgbyRP1y+L+FRIk1uDPTI51NJ+VIfhOvtNkogHM46yZdGpAbBnv7I
         56gVS/kBkJvOEHEfRqf9g8WdRpVIrF8vNLTbuMmGrDL+MJsHUjKLButpuRGePLMJnVAM
         kaei4ApEKt8S49LsCVr6qIcvcre9Wu01ieI+ZRJxkZfcRkSB0su38DtKS1SoNruYQniy
         AKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EM1+V23pNsBMyMnIegw2B3PVe6SGaCvPvEr1hY3r+Uc=;
        b=jzaIVudj1FRxAEYRg1BHNlxBnWfgkalgPK4BadRDd0ZXwMGmL+fvTCK9N2LKvEGmK+
         0WIIkIaAYMQrXPGI5EBm8SoKX/H+Hj7WFY38Krd9a43qsIWA2UvKnVjsvlHUjbA9emd+
         pyjTQvb4hqb3BfCf4G1WRwbVYCinqCtPDQHSx1x93ITEl88NM31gLmoogpiUUg9Roz7y
         jJqcdeCiK6/HSd4cCV3yyzD8ZF7GWnnKKkG7Szg0ZNqvcZ9+uALCs5WZvYLwrGx1oTOY
         BZpmsomD4xa0vQxmvdNfhrp+TBuMjtFMbvFluAHFVzcB/ASa7Ha1C7leo91TF72xD/d3
         un6g==
X-Gm-Message-State: AOAM532B8objTMvB2R83AwvOK3J/MkM6+L9D9c3ip5zvqtq2wglwS1x1
        ZN84Lolcr+eNv7Pty9OBAR3zq8fozh0=
X-Google-Smtp-Source: ABdhPJwi1puiBKa1IxCKf3zK41bku7A2oH+9feOt8wLt5MnL5hik54UWf66HYpglEAZUFpMeDOXiGg==
X-Received: by 2002:a05:6a00:1586:b0:447:b30c:4a65 with SMTP id u6-20020a056a00158600b00447b30c4a65mr3140026pfk.0.1634181252214;
        Wed, 13 Oct 2021 20:14:12 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id j20sm847607pgb.2.2021.10.13.20.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:14:11 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 00/49] x86/entry/64: Convert a bunch of ASM entry code into C code
Date:   Thu, 14 Oct 2021 11:13:23 +0800
Message-Id: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

The patch 24 converts the error_entry() to C code. And patch 1-23
are fixes and preparation for it.

The patches 25-27 convert entry_INT80_compat and do cleanup.

The patches 28-45 convert the IST entry code to C code.  Many of them
are preparation for the actual conversion.

The patches 46-48 do cleanup.

The patch 49 converts a small part of ASM code of syscall to C code which
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

Changed from V2:
	Fix two places with missed FENCE_SWAPGS_KERNEL_ENTRY.

	Fix swapgs_restore_regs_and_return_to_usermode for XENPV.

	Updates the C entry_error()/parnoid_entry() to use
		fence_swapgs_kernel_entry when with user gsbase
		in kernel CR3.

	Simplify removing stack-protector in MAKEFILE.

	Squash commits about removing stack-protector in MAKEFILE.

	In V2 the C entry_error() checks xenpv first and uses natvie_swapgs
		but ASM entry_error() uses pv-aware SWAPGS.  In V3, the
		commit is split into 3 commit, so the conversion has no
		semantic change.

	Move cld to the start of idtentry.

	Use idtentry macro for entry_INT80_compat and remove the old one.

	Add cleanup for PTI_USER_PGTABLE_BIT when it is moved to header
	file.

	Remove pv-aware SWAPGS.

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
[V2]: https://lore.kernel.org/lkml/20210926150838.197719-1-jiangshanlai@gmail.com/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Joerg Roedel <jroedel@suse.de>


Lai Jiangshan (49):
  x86/entry: Add fence for kernel entry swapgs in paranoid_entry()
  x86/entry: Use the correct fence macro after swapgs in kernel CR3
  x86/traps: Remove stack-protector from traps.c
  x86/xen: Add xenpv_restore_regs_and_return_to_usermode()
  x86/entry: Use swapgs and native_iret directly in
    swapgs_restore_regs_and_return_to_usermode
  compiler_types.h: Add __noinstr_section() for noinstr
  x86/entry: Introduce __entry_text for entry code written in C
  x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
  x86: Remove unused kernel_to_user_p4dp() and user_to_kernel_p4dp()
  x86: Replace PTI_PGTABLE_SWITCH_BIT with PTI_USER_PGTABLE_BIT
  x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
  x86/traps: Move the declaration of native_irq_return_iret into proto.h
  x86/entry: Add arch/x86/entry/entry64.c for C entry code
  x86/entry: Expose the address of .Lgs_change to entry64.c
  x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as
    switch_to_kernel_cr3()
  x86/traps: Add fence_swapgs_{user,kernel}_entry()
  x86/entry: Add C {user,kernel}_entry_swapgs_and_fence()
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
  x86/entry: Move cld to the start of idtentry
  x86/entry: Don't call error_entry for XENPV
  x86/entry: Convert SWAPGS to swapgs in error_entry()
  x86/entry: Implement the whole error_entry() as C code
  x86/entry: Use idtentry macro for entry_INT80_compat
  x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
  x86: Remove the definition of SWAPGS
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
  x86/debug, mce: Use C entry code
  x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
  x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
  x86/nmi: Use C entry code
  x86/entry: Add a C macro to define the function body for IST in
    .entry.text with an error code
  x86/doublefault: Use C entry code
  x86/sev: Add and use ist_vc_switch_off_ist()
  x86/sev: Use C entry code
  x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
  x86/entry: Remove the unused ASM macros
  x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
  x86/syscall/64: Move the checking for sysret to C code

 arch/x86/entry/Makefile                |   3 +-
 arch/x86/entry/calling.h               | 142 +-------
 arch/x86/entry/common.c                |  73 +++-
 arch/x86/entry/entry64.c               | 367 ++++++++++++++++++++
 arch/x86/entry/entry_64.S              | 448 ++++---------------------
 arch/x86/entry/entry_64_compat.S       | 108 +-----
 arch/x86/include/asm/idtentry.h        | 111 +++++-
 arch/x86/include/asm/irqflags.h        |   8 -
 arch/x86/include/asm/pgtable.h         |  23 +-
 arch/x86/include/asm/processor-flags.h |  15 +
 arch/x86/include/asm/proto.h           |   5 +-
 arch/x86/include/asm/special_insns.h   |   4 +-
 arch/x86/include/asm/syscall.h         |   2 +-
 arch/x86/include/asm/traps.h           |   6 +-
 arch/x86/kernel/Makefile               |   3 +
 arch/x86/kernel/cpu/mce/Makefile       |   3 +
 arch/x86/kernel/nmi.c                  |   2 +-
 arch/x86/kernel/traps.c                |  33 +-
 arch/x86/xen/xen-asm.S                 |  27 ++
 include/linux/compiler_types.h         |   6 +-
 20 files changed, 704 insertions(+), 685 deletions(-)
 create mode 100644 arch/x86/entry/entry64.c

-- 
2.19.1.6.gb485710b

