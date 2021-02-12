Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACE31A507
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBLTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhBLTIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:08:51 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:08:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b9so797695ejy.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3ikNalsuZzL53jhGkXErOWPpRGEg8NvbnsD1QXWEGY=;
        b=HFX4SsNcGO6UF2J9+8AQmIwEznHImS+LvV+tkpAvg0DU0fKJGfSKmIVXjLNw5a10Nj
         BmyT6DGjrU7FY9JR75SH9SDhW74SpdMeFgMubI51cKZbrWQJyRZoXZX0nukGbRbsq7r+
         R9HNZC42AZzxTyEM6BZZPoCngd2I9yvwP5zt+ZftOmFErKXr1OTND4NtdIsezES1r/Lr
         HhZb82yTMA4cqTIpTTs3KuSzms7JzVRK+wvQ2+UkvHjP4zlX3sqKZs984/kX8mv6bz7l
         lXWE9xfybrJXy3HHSusT4skwSW+bBCt99HTBD1UGLCZUV8795gLlDzJbbwUq3OYsqGO8
         pBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3ikNalsuZzL53jhGkXErOWPpRGEg8NvbnsD1QXWEGY=;
        b=gnzjeeF1z+22gbhloU0ykiEYrb6sTqvUbBHe9nJo2RQZRSAxkkQXNRVcHqs9O/wsTI
         GFvp0NRDZ9X6ft83HqjalFYfE58ce6yBUogTrhQsJXilb+AIGMZ8YYLDM4jYHS4iWx+R
         KNkVKSf7co11wwnJNyRy9U/bzP3fV+KDaJOUASO4pqBgxVRkD2NhTr700hSzxdwkFyLL
         2enYoh7WqKVeqgVHPvy6n7P1QnwqbFs/qLMe17rKY/uf9R5KAEZaOeovRJeyLFAW6WRd
         /g37mX2Qaxtd0d/35y7AW2E+boenmDwGs1TK59sgzAIuRwx0LYTlf0A6wWzlgdugNfIA
         3ghA==
X-Gm-Message-State: AOAM531cTeaWyrCRgwwWQvc1Q9WDcUtclsF/fj5KvDNoVY/BOKgi8PnS
        Vtv2DlGS3K/67dVkuX4d2KLNi8+0Fdq5PuSo7vE=
X-Google-Smtp-Source: ABdhPJy1J4J3oiU/BDBlUoQbZjzXZ2s4r0BCftF+1LpngtFoGKRsnHEy2+mluePb4E3CYOuaXeMoOGwTiml9qMtn7Qg=
X-Received: by 2002:a17:906:1954:: with SMTP id b20mr4399816eje.61.1613156888953;
 Fri, 12 Feb 2021 11:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20210211202208.31555-1-Sonicadvance1@gmail.com>
 <58b03e17-3729-99ea-8691-0d735a53b9bc@arm.com> <20210212123515.GC6057@sirena.org.uk>
 <20210212132807.GC7718@arm.com> <CA+y5pbTOZF9NgHdf0yG2d6GmPGqyyX400j0c=D8669WfWvk4SQ@mail.gmail.com>
 <20210212180434.GB2744@C02TD0UTHF1T.local>
In-Reply-To: <20210212180434.GB2744@C02TD0UTHF1T.local>
From:   "Amanieu d'Antras" <amanieu@gmail.com>
Date:   Fri, 12 Feb 2021 19:06:07 +0000
Message-ID: <CA+y5pbRZqWNw8KuVg7bUUVoK5c2WyRPpcjfxymDmX_fX7-MoAA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2] arm64: Exposes support for 32-bit syscalls
To:     Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 6:04 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > The patch proposed by
> > Ryan is based on the kernel patch used by Tango which can be found
> > here: https://github.com/Amanieu/linux/tree/tango-v5.4
> >
> > Efficiency is not the concern here: copying/rearranging some bytes is
> > tiny compared to the cost of a syscall. The main concern is
> > correctness: there are many cases where userspace does not have the
> > information or the capabilities needed to ensure that the 32-bit
> > syscall ABI is correctly emulated.
>
> I do appreciate that today there are cases where the emulator cannot do
> the right thing due to lack of a mechanism, but where the emulator does
> not have knowledge, I don't think that it can safely invoke the syscall.
> Consider if userspace invokes compat_rt_sigreturn() or similar, which
> will trash the emulator's state.
>
> Note that there are cases (e.g. compat_rt_sigreturn()), the kernel
> cannot provide the correct behaviour either. In your tree above, I spot
> at least the following:
>
> * For rt_sigreturn() the kernel will attempt to validate/restore a
>   compat sigframe assuming the AArch32 register mappings, then
>   valid_user_regs() will blat the PSTATE/SPSR_ELx value to /some/ valid
>   AArch64 SPSR_ELx value that happens to mostly alias.
>
>   I hope that your emulator doesn't allow emulated apps to call this,
>   because it would blat the emulator's state. Regardless, this syscall
>   simply cannot do any correct thing in the context of a fake compat
>   task, and doesn't make sense to expose.

sigreturn and sigaction and completely emulated by Tango and never
reach the kernel. It simply doesn't make sense to do otherwise since
the kernel has no knowledge of how Tango manages the emulated AArch32
state.

I agree that invoking compat_sys_rt_sigreturn from a 64-bit process
doesn't make sense. My reading of the code is that it will trigger a
SIGSEGV due to valid_user_regs failing. We could add an explicit check
against is_aarch32_compat_task in the compat syscall but the end
result will be the same.

> * For ptrace, operations on the user_aarch32_view (which
>   task_user_regset_view() will return for fake compat tasks) will
>   erroneously try to convert between SPSR_ELx <-> AARCH32 SPSR layouts,
>   assuming the pt_regs::pstate field is using the encoding for AArch32
>   EL0, where it's actually the AArch64 EL0 encoding where the layout is
>   subtly differnt. Subseqeuntly valid_user_regs() will sanitize that to
>   an AArch64 encoding, with the exact same problems as for rt_sigreturn().

Note that user_aarch32_view is only returned when the tracer is
performing a compat syscall. This is no different from a normal 32-bit
process tracing a 64-bit process, which already "works" (the register
state is garbage but everything else works).

Tango doesn't use the regsets and instead retrieves the AArch32
register state directly from the traced process (which is also running
under Tango) with process_vm_readv and returns that when emulating the
various PTRACE_* operations.

>   Note that attempting to set the TLS will clobber TPIDRR0_EL0, which
>   the kernel will clobber for AArch64 tasks (including your fake compat
>   tasks) in the KPTI trampoline. I'm not sure what your emulator expects
>   here, and I suspect this also gets clobbered by the case
>   tls_thread_flush() tries to cater for.

All the code paths that modify TPIDRR0_EL0 are guarded by
is_aarch32_compat_task which returns false for fake compat tasks. The
call to compat_arm_syscall which handles __ARM_NR_compat_set_tls is
also guarded by is_aarch32_compat_task.

Again, __ARM_NR_compat_set_tls is emulated internally by Tango and the
AArch32 TLS registers visible to translated code are also emulated in
software.

>   So this really doesn't make sense to expose either, the kernel cannot
>   possibly do something that is correct in this case.
>
> I fully expect that there are more cases where this sort of mismatch
> exists and there isn't some final sanity check that prevents said
> mismatch from breaking the kernel.
>
> Maybe your emulator avoids these, but that's no justification for the
> kernel to expose such broken behaviour.

I disagree that any broken behavior is exposed here.
