Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3740344C064
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhKJMAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:00:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7056C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so1650781pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qW/DCU4Sltw0ifSKJ/kxdxUfD3DM9qB3XPBr0oHUexg=;
        b=Ty5a7Ox1v9wb40yh9pIPzncRnxnffkSp51dy5HQ4yzVgLGLKpvuKY6EN2HbGnwkKbX
         b6LsDz0plGGtLGXW225scSr5vMIce8bRYa+NxZePjizUSxf9rjW7LqlyuQ5uGvrO5MsR
         69Bs2gAXW3Z2xF8L2gwWJcraV3FNczPQZ3VLK4sWFEwTH5qOocsYMlyie2512nMMX59b
         U3rHhCoFSxmTGboplFDf82EjjrwkgHOfUZRduEW84MJ9ZvpiB5aZGyUzFZwx2DQuNSXr
         y2Zuw9Y0Ivt87nRBaMyLMkN7SdZ+S4P0wH+Buq83FE4DJFlUfsdOYT00+LdAtJnJibhP
         L0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qW/DCU4Sltw0ifSKJ/kxdxUfD3DM9qB3XPBr0oHUexg=;
        b=Aw9w727U1kjV0LxtHRlRX9suy8/thsPMps2t1j1PtG/ZbWhZAFHyub8wvj4ZdjTr3U
         gXW0FA2NEbDElDgD0kOa4dTFLyQyMggSsQCe6gAbW61O6PPGakvWRvq1rNZAbLOKKcHW
         vtiqVv0ZhrwVaAYLT1QGBub6LWF6L/UXiEklMsvXxVq4v4d0dGYOKBVsH9eO2qQDKw8r
         bEJR3AIZ5fPhEeKNrenCiRYeF1LQlj+G66f3gNdAFBJyCmLwrGPJM5aNUKUT9IY8Yb+R
         OyGZ5IRVPn8G32s72sjxu3oJxErt+1U3D2N6hBELkSO+GGdZW3iR6326DgiBFDiDOF+h
         S80g==
X-Gm-Message-State: AOAM532fuQjwKgZgfPxXHi2V4BtJG1BRXMirkmfLP4ZDNZj5TebjR2cO
        dTM9tAQvzu0SSgdehsXhosr5+OvSOfs=
X-Google-Smtp-Source: ABdhPJybZjxQ2zx2/qkTWArzUWG4Q96jlvQ/YpFJSw8V3K2JRaPKZvx8sib9b0RbPBDE17gTZrMwDg==
X-Received: by 2002:a17:902:d4cf:b0:141:d36c:78f6 with SMTP id o15-20020a170902d4cf00b00141d36c78f6mr15438276plg.56.1636545447916;
        Wed, 10 Nov 2021 03:57:27 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id x17sm22028912pfa.209.2021.11.10.03.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:57:27 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V5 00/50] x86/entry/64: Convert a bunch of ASM entry code into C code
Date:   Wed, 10 Nov 2021 19:56:46 +0800
Message-Id: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

The patches 28-46 convert the IST entry code to C code.  Many of them
are preparation for the actual conversion.

The patches 47-49 do cleanup.

The patch 50 converts a small part of ASM code of syscall to C code which
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

Changed from V4:
	Move FENCE_SWAPGS_KERNEL_ENTRY up in the patch1. And change the
	corresponding C code in later patches to keep coherence.

	Jmp to xenpv_restore_regs_and_return_to_usermode in
	swapgs_restore_regs_and_return_to_usermode instead of calling
	it everywhere.

	Add Miguel Ojeda's Reviewed-by.

Changed from V3:
	Add a "Reviewed-by" for the xenpv fix
	Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

	Change __attribute((__section__(section))) to __section(section)

	Move a part of ist_paranoid_exit() as a new ist_restore_gsbase()

	Add a new commit (patch 32) to change the ASM RESTORE_CR3, the
		corresponding C version ist_restore_cr3() is changed too.

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
[V3]: https://lore.kernel.org/lkml/20211014031413.14471-1-jiangshanlai@gmail.com/
[V4]: https://lore.kernel.org/lkml/20211026141420.17138-1-jiangshanlai@gmail.com/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Joerg Roedel <jroedel@suse.de>

Lai Jiangshan (50):
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
  x86/entry: Add C user_entry_swapgs_and_fence()
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
  x86/entry: Skip CR3 write when the saved CR3 is kernel CR3 in
    RESTORE_CR3
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
 arch/x86/entry/entry64.c               | 346 +++++++++++++++++++
 arch/x86/entry/entry_64.S              | 445 ++++---------------------
 arch/x86/entry/entry_64_compat.S       | 104 +-----
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
 arch/x86/xen/xen-asm.S                 |  20 ++
 include/linux/compiler_types.h         |   8 +-
 20 files changed, 674 insertions(+), 682 deletions(-)
 create mode 100644 arch/x86/entry/entry64.c

-- 
2.19.1.6.gb485710b

