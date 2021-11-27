Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241D24600B4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355912AbhK0RwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 12:52:09 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38673 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbhK0RuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 12:50:08 -0500
Received: by mail-wr1-f54.google.com with SMTP id q3so3344612wru.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 09:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=znvSQBtuxsMPA4nGx9l0GYe1gWKTf+GRGIt+867KoEc=;
        b=ZHwMihJNapGLe/s6fFRpG6HtgAn1qQ3gAGn+oD/cHw0UcTGsEJJBtkHEOb36uOlmuD
         LquG9nOYGVnYZkvjvZRbF568GOJCaGytIBCgYCOxvofgLTuOr3RUkSdh2+u0JuSILoSI
         Jz2yi0rfIq5xjqvIL2WF1i6MMnr3+GdLpHHkt6OMe6APOyVPzOdppiYbcs0OJmWcwt+K
         VhNiWEGClqp1nd46K7E2hM+gRN+NyQv6rt2CPNbxPfp/d7mN42NFWKQgq16/xJbbTn6U
         8DPwFtlRKqV0TCc/3jGDbJy3dYKnDudfbUG1Uu1YND7hIZgDZNXBQio9wm4OKqTZxOnc
         kW5A==
X-Gm-Message-State: AOAM533QusDxa+8sYk9UQF3RaBFTLOn12SJ0AiWborFZ3cs0CEQt2u4E
        cSxogmlISQSrve0Ucb07CfSSBA==
X-Google-Smtp-Source: ABdhPJyWuI8UZQDMeS3A5ELZFlFAbCmFdBGryqIvOYM/bH2iMYU7eaQrJH/5n9+18NpBhno8QFNjoA==
X-Received: by 2002:adf:e0c3:: with SMTP id m3mr22050458wri.546.1638035212266;
        Sat, 27 Nov 2021 09:46:52 -0800 (PST)
Received: from fedora.tometzki.de (p200300e68f4e7d00bf743c02b21b0358.dip0.t-ipconnect.de. [2003:e6:8f4e:7d00:bf74:3c02:b21b:358])
        by smtp.gmail.com with ESMTPSA id m14sm12480012wrp.28.2021.11.27.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 09:46:51 -0800 (PST)
Date:   Sat, 27 Nov 2021 18:46:48 +0100
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH V6 00/49] x86/entry/64: Convert a bunch of ASM entry code
 into C code
Message-ID: <YaJvCKKLhfIDNWj0@fedora.tometzki.de>
Reply-To: Damian Tometzki <dtometzki@fedoraproject.org>
Mail-Followup-To: Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
User-Agent: Mutt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lai,

the patches in my point of view looks good. My qemue system boots with
this patches. From my side: 

reviewed-by: damian.tomezki <dtometzki@fedoraproject.org>

best regards
Damian


On Fri, 26. Nov 18:11, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Changed from V5:
> 	Fix the code order of FENCE_SWAPGS_KERNEL_ENTRY in patch1 and
> 	change the new corresponding C entry code to match the asm code.
> 
> 	Squash the patch of removing stack-protector from traps.c into
> 	a later patch that uses C entry code for #DB and #MCE
> 
> 	Kill .Lgs_change and use the new asm_load_gs_index_gs_change in
> 	_ASM_EXTABLE
> 
> 	s/ETNRY/ENTRY/g for DEFINE_IDTENTRY_IST_ENTRY macros
> ----
> 
> Many ASM code in entry_64.S can be rewritten in C if they can be written
> to be non-instrumentable and are called in the right order regarding to
> whether CR3/gsbase is changed to kernel CR3/gsbase.
> 
> The patchset covert some of them to C code.
> 
> The patch 23 converts the error_entry() to C code. And patch 1-23
> are fixes and preparation for it.
> 
> The patches 24-26 convert entry_INT80_compat and do cleanup.
> 
> The patches 27-45 convert the IST entry code to C code.  Many of them
> are preparation for the actual conversion.
> 
> The patches 46-48 do cleanup.
> 
> The patch 49 converts a small part of ASM code of syscall to C code which
> does the checking for whether it can use sysret to return to userspace.
> 
> Some other paths can be possible to be in C code, for example: the
> error exit, the syscall entry/exit.  The PTI handling for them can
> be in C code.  But it would required the pt_regs to be copied/pushed
> to the entry stack which means the C code would not be efficient.
> 
> When converting ASM to C, the most effort is to make them the same.
> Almost no creative was involved.  The code are kept as the same as ASM
> as possible and no functional change intended unless my misunderstanding
> in the ASM code was involved.  The functions called by the C entry code
> are checked to be ensured noinstr or __always_inline.  Some of them have
> more than one definitions and require some more cares from reviewers.
> The comments in the ASM are also copied in the right place in the C code.
> 
> Changed from V4:
> 	Move FENCE_SWAPGS_KERNEL_ENTRY up in the patch1. And change the
> 	corresponding C code in later patches to keep coherence.
> 
> 	Jmp to xenpv_restore_regs_and_return_to_usermode in
> 	swapgs_restore_regs_and_return_to_usermode instead of calling
> 	it everywhere.
> 
> 	Add Miguel Ojeda's Reviewed-by.
> 
> Changed from V3:
> 	Add a "Reviewed-by" for the xenpv fix
> 	Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> 	Change __attribute((__section__(section))) to __section(section)
> 
> 	Move a part of ist_paranoid_exit() as a new ist_restore_gsbase()
> 
> 	Add a new commit (patch 32) to change the ASM RESTORE_CR3, the
> 		corresponding C version ist_restore_cr3() is changed too.
> 
> Changed from V2:
> 	Fix two places with missed FENCE_SWAPGS_KERNEL_ENTRY.
> 
> 	Fix swapgs_restore_regs_and_return_to_usermode for XENPV.
> 
> 	Updates the C entry_error()/parnoid_entry() to use
> 		fence_swapgs_kernel_entry when with user gsbase
> 		in kernel CR3.
> 
> 	Simplify removing stack-protector in MAKEFILE.
> 
> 	Squash commits about removing stack-protector in MAKEFILE.
> 
> 	In V2 the C entry_error() checks xenpv first and uses natvie_swapgs
> 		but ASM entry_error() uses pv-aware SWAPGS.  In V3, the
> 		commit is split into 3 commit, so the conversion has no
> 		semantic change.
> 
> 	Move cld to the start of idtentry.
> 
> 	Use idtentry macro for entry_INT80_compat and remove the old one.
> 
> 	Add cleanup for PTI_USER_PGTABLE_BIT when it is moved to header
> 	file.
> 
> 	Remove pv-aware SWAPGS.
> 
> Changed from V1:
> 	Add a fix as the patch1.  Found by trying to applied Peterz's
> 		suggestion in patch11.
> 	The whole entry_error() is converted to C instead of partial.
> 	The whole parnoid_entry() is converted to C instead of partial.
> 	The asm code of "parnoid_entry() cfunc() parnoid_exit()" are
> 		converted to C as suggested by Peterz.
> 	Add entry64.c rather than move traps.c to arch/x86/entry/
> 	The order of some commits is changed.
> 	Remove two cleanups
> 
> [V1]: https://lore.kernel.org/all/20210831175025.27570-1-jiangshanlai@gmail.com/
> [V2]: https://lore.kernel.org/lkml/20210926150838.197719-1-jiangshanlai@gmail.com/
> [V3]: https://lore.kernel.org/lkml/20211014031413.14471-1-jiangshanlai@gmail.com/
> [V4]: https://lore.kernel.org/lkml/20211026141420.17138-1-jiangshanlai@gmail.com/
> [V5]: https://lore.kernel.org/lkml/20211110115736.3776-1-jiangshanlai@gmail.com/
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> 
> Lai Jiangshan (49):
>   x86/entry: Add fence for kernel entry swapgs in paranoid_entry()
>   x86/entry: Use the correct fence macro after swapgs in kernel CR3
>   x86/xen: Add xenpv_restore_regs_and_return_to_usermode()
>   x86/entry: Use swapgs and native_iret directly in
>     swapgs_restore_regs_and_return_to_usermode
>   compiler_types.h: Add __noinstr_section() for noinstr
>   x86/entry: Introduce __entry_text for entry code written in C
>   x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
>   x86: Remove unused kernel_to_user_p4dp() and user_to_kernel_p4dp()
>   x86: Replace PTI_PGTABLE_SWITCH_BIT with PTI_USER_PGTABLE_BIT
>   x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
>   x86/traps: Move the declaration of native_irq_return_iret into proto.h
>   x86/entry: Add arch/x86/entry/entry64.c for C entry code
>   x86/entry: Expose the address of .Lgs_change to entry64.c
>   x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as
>     switch_to_kernel_cr3()
>   x86/traps: Add fence_swapgs_{user,kernel}_entry()
>   x86/entry: Add C user_entry_swapgs_and_fence()
>   x86/traps: Move pt_regs only in fixup_bad_iret()
>   x86/entry: Switch the stack after error_entry() returns
>   x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
>   x86/entry: Move cld to the start of idtentry
>   x86/entry: Don't call error_entry for XENPV
>   x86/entry: Convert SWAPGS to swapgs in error_entry()
>   x86/entry: Implement the whole error_entry() as C code
>   x86/entry: Use idtentry macro for entry_INT80_compat
>   x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
>   x86: Remove the definition of SWAPGS
>   x86/entry: Make paranoid_exit() callable
>   x86/entry: Call paranoid_exit() in asm_exc_nmi()
>   x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
>   x86/entry: Add the C version ist_switch_to_kernel_cr3()
>   x86/entry: Skip CR3 write when the saved CR3 is kernel CR3 in
>     RESTORE_CR3
>   x86/entry: Add the C version ist_restore_cr3()
>   x86/entry: Add the C version get_percpu_base()
>   x86/entry: Add the C version ist_switch_to_kernel_gsbase()
>   x86/entry: Implement the C version ist_paranoid_entry()
>   x86/entry: Implement the C version ist_paranoid_exit()
>   x86/entry: Add a C macro to define the function body for IST in
>     .entry.text
>   x86/debug, mce: Use C entry code
>   x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
>   x86/nmi: Use DEFINE_IDTENTRY_NMI for nmi
>   x86/nmi: Use C entry code
>   x86/entry: Add a C macro to define the function body for IST in
>     .entry.text with an error code
>   x86/doublefault: Use C entry code
>   x86/sev: Add and use ist_vc_switch_off_ist()
>   x86/sev: Use C entry code
>   x86/entry: Remove ASM function paranoid_entry() and paranoid_exit()
>   x86/entry: Remove the unused ASM macros
>   x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
>   x86/syscall/64: Move the checking for sysret to C code
> 
>  arch/x86/entry/Makefile                |   3 +-
>  arch/x86/entry/calling.h               | 142 +-------
>  arch/x86/entry/common.c                |  73 +++-
>  arch/x86/entry/entry64.c               | 348 +++++++++++++++++++
>  arch/x86/entry/entry_64.S              | 448 ++++---------------------
>  arch/x86/entry/entry_64_compat.S       | 104 +-----
>  arch/x86/include/asm/idtentry.h        | 111 +++++-
>  arch/x86/include/asm/irqflags.h        |   8 -
>  arch/x86/include/asm/pgtable.h         |  23 +-
>  arch/x86/include/asm/processor-flags.h |  15 +
>  arch/x86/include/asm/proto.h           |   5 +-
>  arch/x86/include/asm/special_insns.h   |   4 +-
>  arch/x86/include/asm/syscall.h         |   2 +-
>  arch/x86/include/asm/traps.h           |   6 +-
>  arch/x86/kernel/Makefile               |   3 +
>  arch/x86/kernel/cpu/mce/Makefile       |   3 +
>  arch/x86/kernel/nmi.c                  |   2 +-
>  arch/x86/kernel/traps.c                |  33 +-
>  arch/x86/xen/xen-asm.S                 |  20 ++
>  include/linux/compiler_types.h         |   8 +-
>  20 files changed, 677 insertions(+), 684 deletions(-)
>  create mode 100644 arch/x86/entry/entry64.c
> 
> -- 
> 2.19.1.6.gb485710b
> 
