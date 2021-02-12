Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3831A070
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhBLOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:15:06 -0500
Received: from foss.arm.com ([217.140.110.172]:37642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhBLOOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:14:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F02B331B;
        Fri, 12 Feb 2021 06:14:03 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB793F73D;
        Fri, 12 Feb 2021 06:13:57 -0800 (PST)
Date:   Fri, 12 Feb 2021 14:13:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     sonicadvance1@gmail.com
Cc:     amanieu@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kevin Hao <haokexin@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, Andrey Ignatov <rdna@fb.com>,
        Peter Collingbourne <pcc@google.com>,
        Julien Grall <julien.grall@arm.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
Message-ID: <20210212141350.GA2744@C02TD0UTHF1T.local>
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211202208.31555-1-Sonicadvance1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:21:54PM -0800, sonicadvance1@gmail.com wrote:
> From: Ryan Houdek <Sonicadvance1@gmail.com>
> 
> Sorry about the noise. I obviously don't work in this ecosystem.
> Didn't get any comments previously so I'm resending
> 
> The problem:
> We need to support 32-bit processes running under a userspace
> compatibility layer. The compatibility layer is a AArch64 process.
> This means exposing the 32bit compatibility syscalls to userspace.

I think that the requirement is that the compatibility layer can
/somehow/ emulate the 32-bit syscalls (e.g. being able to limit the
range of mmap() and friends), and doesn't strictly require that the
kernel expose the 32-bit compat syscalls directly to userspace.

> Why do we need compatibility layers?
> There are ARMv8 CPUs that only support AArch64 but still need to run
> AArch32 applications.
> Cortex-A34/R82 and other cores are prime examples of this.
> Additionally if a user is needing to run legacy 32-bit x86 software, it
> needs the same compatibility layer.

I think that for this series x86 emulation is a red herring. ABIs differ
across 32-bit arm and 32-bit x86 (and they have distinct arch-specific
syscalls), and so those need distinct compatibility layers.

If you're wanting to accelerate x86 emulation, I don't think this is the
right approach.

> Who does this matter to?
> Any user that has a specific need to run legacy 32-bit software under a
> compatibility layer.
> Not all software is open source or easy to convert to 64bit, it's
> something we need to live with.
> Professional software and the gaming ecosystem is rife with this.
> 
> What applications have tried to work around this problem?
> FEX emulator (1) - Userspace x86 to AArch64 compatibility layer
> Tango binary translator (2) - AArch32 to AArch64 compatibility layer
> QEmu (3) - Not really but they do some userspace ioctl emulation
> 
> What problems did they hit?
> FEX and Tango hit problems with emulating memory related syscalls.
> - Emulating 32-bit mmap, mremap, shmat in userspace changes behaviour
> All three hit issues with ioctl emulation

I suspect these can be solved by extending these syscalls (or adding new
variants) with new functionality to support emulation cases. For
example, having variants with an explicit address mask would also
benefit JITs which want to turn VA bits into additional tag bits.

> - ioctls are free to do what they want including allocating memory and
> returning opaque structures with pointers.

They're also free to mess with state that can differ across
compat/native tasks, so I don't think this is generally safe to expose
without auditing the specific ioctl.

I'd also note that non-ioctl syscalls can affect distinct state across
compat/native tasks, e.g. TPIDR_EL0 vs TPIDRRO_EL0, and while I see some
accounting for that below I don't believe that will work consistently or
reliably without further invasive changes (e.g. considering the KPTI
trampoline). Futher, this introduces significant scope for error, and
the potential to introduce security problems.

So to reiterate, I am strongly opposed to exposing compat syscalls in
this way. However, I do think that we can make emulation easier by
extending some syscalls (e.g. mmap()), and that this would be worthwhile
regardless of emulation.

I've made some further technical comments below, but those have no
bearing on my fundamental objection here.

> With this patch we will be exposing the compatibility syscall table
> through the regular syscall svc API. There is prior art here where on
> x86-64 they also expose the compatibility tables.
> The justification for this is that we need to maintain support for 32bit
> application compatibility going in to the foreseeable future.
> Userspace does almost all of the heavy lifting here, especially when the
> hardware no longer supports the 32bit use case.
> 
> A couple of caveats to this approach.
> Userspace must know that this doesn't solve structure alignment problems
> for the x86->AArch64 (1) case.
> The API for this changes from syscall number in x8 to x7 to match
> AArch32 syscall semantics
> This is now exposing the compat syscalls to userspace, but for the sake
> of userspace compatibility it is a necessary evil.
> 
> Why does the upstream kernel care?
> I believe every user wants to have their software ecosystem continue
> working if they are in a mixed AArch32/AArch64 world even when they are
> running AArch64 only hardware. The kernel should facilitate a good user
> experience.

I appreciate that people have 32-bit applications, and want to run
those, but I'm not convinced that this requires these specific changes.
Especially considering that the cross-architecture cases you mention are
not addressed by this, and need syscall emulation in userspace; that
implies that in general userspace needs to handle conversion of
semantics, and what the kernel needs to do is provide the primitives
onto which userspace can map things in order to get the desried
semantics (which is not the same as blindly exposing compat syscalls).

[...]

> +/* Definitions for compat syscall guest mmap area */
> +#define COMPAT_MIN_GAP			(SZ_128M)
> +#define COMPAT_STACK_TOP		0xffff0000
> +#define COMPAT_MAX_GAP			(COMPAT_STACK_TOP/6*5)
> +#define COMPAT_TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE_32 / 4)
> +#define COMPAT_STACK_RND_MASK		(0x7ff >> (PAGE_SHIFT - 12))

What's the "guest mmap area" ?

The commit message introduced the abstract problem, but none of the new
technical concepts like this.

> +#ifndef arch_get_mmap_end
> +#define arch_get_mmap_end(addr)	(TASK_SIZE)
> +#endif
> +
> +#ifndef arch_get_mmap_base
> +#define arch_get_mmap_base(addr, base) (base)
> +#endif
> +
> +static int mmap_is_legacy(unsigned long rlim_stack)
> +{
> +	if (current->personality & ADDR_COMPAT_LAYOUT)
> +		return 1;
> +
> +	if (rlim_stack == RLIM_INFINITY)
> +		return 1;
> +
> +	return sysctl_legacy_va_layout;
> +}
> +
> +static unsigned long compat_mmap_base(unsigned long rnd, unsigned long gap)
> +{
> +	unsigned long pad = stack_guard_gap;
> +
> +	/* Account for stack randomization if necessary */
> +	if (current->flags & PF_RANDOMIZE)
> +		pad += (COMPAT_STACK_RND_MASK << PAGE_SHIFT);
> +
> +	/* Values close to RLIM_INFINITY can overflow. */
> +	if (gap + pad > gap)
> +		gap += pad;
> +
> +	if (gap < COMPAT_MIN_GAP)
> +		gap = COMPAT_MIN_GAP;
> +	else if (gap > COMPAT_MAX_GAP)
> +		gap = COMPAT_MAX_GAP;
> +
> +	return PAGE_ALIGN(COMPAT_STACK_TOP - gap - rnd);
> +}

Again, it's not clear what's going on here, and I fear this is specific
to the design of your userspace emilation layer.

Thanks,
Mark.
