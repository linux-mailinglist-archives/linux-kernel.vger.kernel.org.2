Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3F31A431
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhBLSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:05:30 -0500
Received: from foss.arm.com ([217.140.110.172]:40872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhBLSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:05:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 148141063;
        Fri, 12 Feb 2021 10:04:43 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0953F73B;
        Fri, 12 Feb 2021 10:04:37 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:04:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Amanieu d'Antras <amanieu@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <steven.price@arm.com>, sonicadvance1@gmail.com,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
Message-ID: <20210212180434.GB2744@C02TD0UTHF1T.local>
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
 <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com>
 <20210212123515.GC6057@sirena.org.uk>
 <20210212132807.GC7718@arm.com>
 <CA+y5pbTOZF9NgHdf0yG2d6GmPGqyyX400j0c=D8669WfWvk4SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+y5pbTOZF9NgHdf0yG2d6GmPGqyyX400j0c=D8669WfWvk4SQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:24:35PM +0000, Amanieu d'Antras wrote:
> On Fri, Feb 12, 2021 at 1:28 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > The only downside I think is that for some syscalls it's not that
> > efficient. Those using struct iovec come to mind, qemu probably
> > duplicates the user structures, having to copy them in both directions
> > (well, the kernel compat layer does something similar).
> >
> > Anyway, I'm not in favour of this patch. Those binary translation tools
> > need to explore the user-only options first and come up with some perf
> > numbers to justify the proposal.
> 
> I'd like to elaborate Tango's point of view on this problem.
> 
> Quick recap: Tango allows AArch32 programs to run on AArch64 CPUs that
> don't support 32-bit mode. The primary use case is supporting 32-bit
> Android apps, which means that Tango needs to be able to support the
> full set of syscalls used on Android, including interfacing with many
> drivers that are not in the mainline kernel.

Please bear in mind that for an upstream patch submission, the state of
out-of-tree drivers is not a justification. I appreciate that's a
problem for you if you need to support out-of-tree code, but it's not a
burden that upstream needs to care about.

> The patch proposed by
> Ryan is based on the kernel patch used by Tango which can be found
> here: https://github.com/Amanieu/linux/tree/tango-v5.4
> 
> Efficiency is not the concern here: copying/rearranging some bytes is
> tiny compared to the cost of a syscall. The main concern is
> correctness: there are many cases where userspace does not have the
> information or the capabilities needed to ensure that the 32-bit
> syscall ABI is correctly emulated.

I do appreciate that today there are cases where the emulator cannot do
the right thing due to lack of a mechanism, but where the emulator does
not have knowledge, I don't think that it can safely invoke the syscall.
Consider if userspace invokes compat_rt_sigreturn() or similar, which
will trash the emulator's state.

Note that there are cases (e.g. compat_rt_sigreturn()), the kernel
cannot provide the correct behaviour either. In your tree above, I spot
at least the following:

* For rt_sigreturn() the kernel will attempt to validate/restore a
  compat sigframe assuming the AArch32 register mappings, then
  valid_user_regs() will blat the PSTATE/SPSR_ELx value to /some/ valid
  AArch64 SPSR_ELx value that happens to mostly alias.

  I hope that your emulator doesn't allow emulated apps to call this,
  because it would blat the emulator's state. Regardless, this syscall
  simply cannot do any correct thing in the context of a fake compat
  task, and doesn't make sense to expose.

* For ptrace, operations on the user_aarch32_view (which
  task_user_regset_view() will return for fake compat tasks) will
  erroneously try to convert between SPSR_ELx <-> AARCH32 SPSR layouts,
  assuming the pt_regs::pstate field is using the encoding for AArch32
  EL0, where it's actually the AArch64 EL0 encoding where the layout is
  subtly differnt. Subseqeuntly valid_user_regs() will sanitize that to
  an AArch64 encoding, with the exact same problems as for rt_sigreturn().

  Note that attempting to set the TLS will clobber TPIDRR0_EL0, which
  the kernel will clobber for AArch64 tasks (including your fake compat
  tasks) in the KPTI trampoline. I'm not sure what your emulator expects
  here, and I suspect this also gets clobbered by the case
  tls_thread_flush() tries to cater for.

  So this really doesn't make sense to expose either, the kernel cannot
  possibly do something that is correct in this case.

I fully expect that there are more cases where this sort of mismatch
exists and there isn't some final sanity check that prevents said
mismatch from breaking the kernel.

Maybe your emulator avoids these, but that's no justification for the
kernel to expose such broken behaviour.

Thanks,
Mark.
