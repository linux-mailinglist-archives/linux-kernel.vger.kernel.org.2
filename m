Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A878A305ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhA0O4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:56:32 -0500
Received: from foss.arm.com ([217.140.110.172]:49836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234656AbhA0OyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:54:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B90631B;
        Wed, 27 Jan 2021 06:53:26 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932273F66B;
        Wed, 27 Jan 2021 06:53:25 -0800 (PST)
Date:   Wed, 27 Jan 2021 14:53:07 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64/ptrace: introduce NT_ARM_PRSTATUS to get a
 full set of registers
Message-ID: <20210127145304.GC13952@arm.com>
References: <20210119220637.494476-1-avagin@gmail.com>
 <20210119220637.494476-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119220637.494476-3-avagin@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:06:36PM -0800, Andrei Vagin wrote:
> This is an alternative to NT_PRSTATUS that clobbers ip/r12 on AArch32,
> x7 on AArch64 when a tracee is stopped in syscall entry or syscall exit
> traps.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

This approach looks like it works, though I still think adding an option
for this under PTRACE_SETOPTIONS would be less intrusive.

Adding a shadow regset like this also looks like it would cause the gp
regs to be pointlessly be dumped twice in a core dump.  Avoiding that
might require hacks in the core code...


> ---
>  arch/arm64/kernel/ptrace.c | 39 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h   |  1 +
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 1863f080cb07..b8e4c2ddf636 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -591,6 +591,15 @@ static int gpr_get(struct task_struct *target,
>  	return ret;
>  }
>  
> +static int gpr_get_full(struct task_struct *target,
> +		   const struct user_regset *regset,
> +		   struct membuf to)
> +{
> +	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
> +
> +	return membuf_write(&to, uregs, sizeof(*uregs));
> +}
> +
>  static int gpr_set(struct task_struct *target, const struct user_regset *regset,
>  		   unsigned int pos, unsigned int count,
>  		   const void *kbuf, const void __user *ubuf)
> @@ -1088,6 +1097,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
>  
>  enum aarch64_regset {
>  	REGSET_GPR,
> +	REGSET_GPR_FULL,

If we go with this approach, "REGSET_GPR_RAW" might be a preferable
name.  Both regs represent all the regs ("full"), but REGSET_GPR is
mangled by the kernel.

>  	REGSET_FPR,
>  	REGSET_TLS,
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> @@ -1119,6 +1129,14 @@ static const struct user_regset aarch64_regsets[] = {
>  		.regset_get = gpr_get,
>  		.set = gpr_set
>  	},
> +	[REGSET_GPR_FULL] = {
> +		.core_note_type = NT_ARM_PRSTATUS,

Similarly, something like NT_ARM_PRSTATUS_RAW or similar.

> +		.n = sizeof(struct user_pt_regs) / sizeof(u64),
> +		.size = sizeof(u64),
> +		.align = sizeof(u64),
> +		.regset_get = gpr_get_full,
> +		.set = gpr_set
> +	},
>  	[REGSET_FPR] = {
>  		.core_note_type = NT_PRFPREG,
>  		.n = sizeof(struct user_fpsimd_state) / sizeof(u32),
> @@ -1225,6 +1243,7 @@ static const struct user_regset_view user_aarch64_view = {
>  #ifdef CONFIG_COMPAT
>  enum compat_regset {
>  	REGSET_COMPAT_GPR,
> +	REGSET_COMPAT_GPR_FULL,
>  	REGSET_COMPAT_VFP,
>  };
>  
> @@ -1285,6 +1304,18 @@ static int compat_gpr_get(struct task_struct *target,
>  	return 0;
>  }
>  
> +/* compat_gpr_get_full doesn't  overwrite x12 like compat_gpr_get. */
> +static int compat_gpr_get_full(struct task_struct *target,
> +			  const struct user_regset *regset,
> +			  struct membuf to)
> +{
> +	int i = 0;
> +
> +	while (to.left)
> +		membuf_store(&to, compat_get_user_reg(target, i++));
> +	return 0;
> +}
> +
>  static int compat_gpr_set(struct task_struct *target,
>  			  const struct user_regset *regset,
>  			  unsigned int pos, unsigned int count,
> @@ -1435,6 +1466,14 @@ static const struct user_regset aarch32_regsets[] = {
>  		.regset_get = compat_gpr_get,
>  		.set = compat_gpr_set
>  	},
> +	[REGSET_COMPAT_GPR_FULL] = {
> +		.core_note_type = NT_ARM_PRSTATUS,
> +		.n = COMPAT_ELF_NGREG,
> +		.size = sizeof(compat_elf_greg_t),
> +		.align = sizeof(compat_elf_greg_t),
> +		.regset_get = compat_gpr_get_full,
> +		.set = compat_gpr_set
> +	},
>  	[REGSET_COMPAT_VFP] = {
>  		.core_note_type = NT_ARM_VFP,
>  		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 30f68b42eeb5..a2086d19263a 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -426,6 +426,7 @@ typedef struct elf64_shdr {
>  #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
>  #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
>  #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */

What happened to 0x40a..0x40f?

[...]

Cheers
---Dave
