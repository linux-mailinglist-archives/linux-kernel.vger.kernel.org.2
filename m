Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF82E3A0EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhFIIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 04:47:57 -0400
Received: from forward1-smtp.messagingengine.com ([66.111.4.223]:50821 "EHLO
        forward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231917AbhFIIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 04:47:56 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2021 04:47:56 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailforward.nyi.internal (Postfix) with ESMTP id 0B3BC1940C78;
        Wed,  9 Jun 2021 04:38:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 09 Jun 2021 04:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cf/f/6
        o53yZFK0c2xysdNHLo69ogP+H0lETTTPrZ740=; b=EdqkiQZfh1eLVc36Dw4nBB
        NTCZmIrf7x9ln/qRz/fbBhzTxeNtEn58C+23Q+NSlwVo8ooWVWU2Hhla3pgIDkV0
        uA0SIg49+9LkaHIhSzO0opOe7PrOH7dcXm9ONeqPxlWmaR2yPx/q5t7kfwROXqsa
        l5E8F65qopnxjNekYmOZpfuyG/e7PYlt0oJAkjK890tPBbJSKYF4d+76+b/rNGQm
        4NsSGGytEsiA+Iq2ji+t2FeFNHkVVw7agmiVjk7RgBdOpHpSg2DFaknP/qqK/DJZ
        JYrhtbQSAZj7Aybe1SXLnR159j9FOjcTQzQjdYC0yHXzfoTYxYc1QmV4LY7ANxwA
        ==
X-ME-Sender: <xms:CX7AYNf3F6PQNqia6vNmZ49Wt4dUzrVaRMz452EjH8oGNVjE_ddtBg>
    <xme:CX7AYLPMCS6IUEWgUdu4_3NM3gxqzk0BCH0M2PnpdZUkVMakH4e_2ouTDeyaYtRrc
    Pfu8fu_hAwVlg_8xUM>
X-ME-Received: <xmr:CX7AYGhSeU6jOLATGR-9y_SsmvUZ9ScjSBmt_EfdxTETIQC-cloSguMa2ztUup8auw1SHTPls2-Ziuji0Cj0R4SNcPHsarEDEl1gp7Vo8kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvffujghfhfffkfggtgesthdtredttddttdenucfhrhhomhepffgrvhhiugcu
    gfgumhhonhgushhonhcuoegumhgvsegumhgvrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhkeeguedtvdegffffteehjedvjeeitefgfefgffdugeffffegudehgeetgeelkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegumhgvsegumh
    gvrdhorhhg
X-ME-Proxy: <xmx:CX7AYG_ydNb130YPu_XZeJ45sxTJK6If-a5xSB2X35CUYgYp0UefXA>
    <xmx:CX7AYJu3Ml5FOZ9Ch-QdB8LpO7luxBpPHXHs1l4KbBeyZnMLEc007w>
    <xmx:CX7AYFELWNo2jD5jZ84QYFhL1P3EVUSIRFzWccON4NUe_iKrcxl8zQ>
    <xmx:C37AYCFwlatc5Qq92Q6bjv37HhEciO5NGjFU0HLCeXsM17Ym162T5ey_Kz8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 04:38:32 -0400 (EDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
        by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 854acb37;
        Wed, 9 Jun 2021 08:38:30 +0000 (UTC)
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>
Subject: Re: [patch V3 6/6] selftests/x86: Test signal frame XSTATE header
 corruption handling
In-Reply-To: <20210608144346.234764986@linutronix.de>
References: <20210608143617.565868844@linutronix.de>
 <20210608144346.234764986@linutronix.de>
X-HGTTG: zarquon
From:   David Edmondson <dme@dme.org>
Date:   Wed, 09 Jun 2021 09:38:30 +0100
Message-ID: <cunmtrz1lh5.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2021-06-08 at 16:36:23 +02, Thomas Gleixner wrote:

> From: Andy Lutomirski <luto@kernel.org>
>
> This is very heavily based on some code from Thomas Gleixner.  On a system
> without XSAVES, it triggers the WARN_ON():
>
>     Bad FPU state detected at copy_kernel_to_fpregs+0x2f/0x40, reinitializing FPU registers.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: main() -> main(void) - Borislav
> ---
>  tools/testing/selftests/x86/Makefile                |    3 
>  tools/testing/selftests/x86/corrupt_xstate_header.c |  114 ++++++++++++++++++++
>  2 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/corrupt_xstate_header.c
>
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -17,7 +17,8 @@ TARGETS_C_BOTHBITS := single_step_syscal
>  TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>  			test_FCMOV test_FCOMI test_FISTTP \
>  			vdso_restorer
> -TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering
> +TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> +			corrupt_xstate_header
>  # Some selftests require 32bit support enabled also on 64bit systems
>  TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
>  
> --- /dev/null
> +++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Corrupt the XSTATE header in a signal frame
> + *
> + * Based on analysis and a test case from Thomas Gleixner.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <err.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <sys/wait.h>
> +
> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
> +			   unsigned int *ecx, unsigned int *edx)
> +{
> +	asm volatile(
> +		"cpuid;"
> +		: "=a" (*eax),
> +		  "=b" (*ebx),
> +		  "=c" (*ecx),
> +		  "=d" (*edx)
> +		: "0" (*eax), "2" (*ecx));
> +}
> +
> +static inline int xsave_enabled(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	eax = 0x1;
> +	ecx = 0x0;
> +	__cpuid(&eax, &ebx, &ecx, &edx);
> +
> +	/* Is CR4.OSXSAVE enabled ? */
> +	return ecx & (1U << 27);
> +}
> +
> +static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> +		       int flags)
> +{
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction = handler;
> +	sa.sa_flags = SA_SIGINFO | flags;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(sig, &sa, 0))
> +		err(1, "sigaction");
> +}
> +
> +static void sigusr1(int sig, siginfo_t *info, void *uc_void)
> +{
> +	ucontext_t *uc = uc_void;
> +	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
> +	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
> +
> +	printf("\tWreckage XSTATE header\n");

"Wreckage" is an odd word to use here, as it usually refers to the
objects that are the result of a wreck. Maybe "wreck" or (to match the
test name) "corrupt"?

> +	/* Wreckage the first reserved byte in the header */
> +	*(xfeatures + 2) = 0xfffffff;

This trashes more than a byte, which doesn't seem significant, but it
would be good to have the comment and code match.

> +}
> +
> +static void sigsegv(int sig, siginfo_t *info, void *uc_void)
> +{
> +	printf("\tGot SIGSEGV\n");
> +}
> +
> +int main(void)
> +{
> +	cpu_set_t set;
> +
> +	sethandler(SIGUSR1, sigusr1, 0);
> +	sethandler(SIGSEGV, sigsegv, 0);
> +
> +	if (!xsave_enabled()) {
> +		printf("[SKIP] CR4.OSXSAVE disabled.\n");
> +		return 0;
> +	}
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(0, &set);
> +
> +	/*
> +	 * Enforce that the child runs on the same CPU
> +	 * which in turn forces a schedule.
> +	 */
> +	sched_setaffinity(getpid(), sizeof(set), &set);
> +
> +	printf("[RUN]\tSend ourselves a signal\n");
> +	raise(SIGUSR1);
> +
> +	printf("[OK]\tBack from the signal.  Now schedule.\n");
> +	pid_t child = fork();
> +	if (child < 0)
> +		err(1, "fork");
> +	if (child == 0)
> +		return 0;
> +	if (child)
> +		waitpid(child, NULL, 0);
> +	printf("[OK]\tBack in the main thread.\n");
> +
> +	/*
> +	 * We could try to confirm that extended state is still preserved
> +	 * when we schedule.  For now, the only indication of failure is
> +	 * a warning in the kernel logs.
> +	 */
> +
> +	return 0;
> +}

dme.
-- 
It's alright, we told you what to dream.
