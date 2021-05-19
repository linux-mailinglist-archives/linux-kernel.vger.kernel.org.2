Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BB3892AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354884AbhESPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:31:59 -0400
Received: from foss.arm.com ([217.140.110.172]:45362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241083AbhESPb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:31:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070A51480;
        Wed, 19 May 2021 08:30:39 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 998533F73D;
        Wed, 19 May 2021 08:30:37 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat
 syscalls
To:     Amanieu d'Antras <amanieu@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210518090658.9519-1-amanieu@gmail.com>
 <20210518090658.9519-9-amanieu@gmail.com>
 <CAK8P3a0=iSUBu5GnuWoxEjB0Hpd3iHeVwe2Njfj6x64hoJA5oA@mail.gmail.com>
 <CA+y5pbRiXAF=gobC9sqJmvjVAmihA=O7xcSTkA1f8=QsnZzoEg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <14982d7d-bee1-6c25-8b18-123c29959f52@arm.com>
Date:   Wed, 19 May 2021 16:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+y5pbRiXAF=gobC9sqJmvjVAmihA=O7xcSTkA1f8=QsnZzoEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 00:51, Amanieu d'Antras wrote:
> On Tue, May 18, 2021 at 2:03 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> I'm still undecided about this approach. It is an easy way to expose the 32-bit
>> ABIs, it mostly copies what x86-64 already does with 32-bit syscalls and
>> it doesn't expose a lot of attack surface that isn't already exposed to normal
>> 32-bit tasks running compat mode.
>>
>> On the other hand, exposing the entire aarch32 syscall set seems both
>> too broad and not broad enough: Half of the system calls behave the
>> exact same way in native and compat mode, so they wouldn't need to
>> be exposed like this, a lot of others are trivially emulated in user space
>> by calling the native versions. The syscalls that are actually hard to do
>> such as ioctl() or the signal handling will work for aarch32 emulation, but
>> they are still insufficient to correctly emulate other 32-bit architectures
>> that have a slightly different ABI. This means the interface is a fairly good
>> fit for Tango, but much less so for FEX.
>>
>> It's also worth pointing out that this approach has a few things in common
>> with Yury's ilp32 tree at https://github.com/norov/linux/tree/ilp32-5.2
>> Unlike the x86 x32 mode, that port however does not allow calling compat
>> syscalls from normal 64-bit tasks but rather keys the syscall entry point
>> off the executable format., which wouldn't work here. It also uses the
>> asm-generic system call numbers instead of the arm32 syscall numbers.
>>
>> I assume you have already considered or tried the alternative approach of
>> only adding a minimal set of syscalls that are needed for the emulation.
>> Having a way to limit the address space for mmap() and similar
>> system calls sounds like a generally useful addition, and having an
>> extended variant of ioctl() that lets you pick the target ABI (arm32, x86-32,
>> ...) on supported drivers would probably be better for FEX. Can you
>> explain the tradeoffs that led you towards duplicating the syscall
>> entry points instead?
> 
> Tango needs the entire compat ABI to be exposed to support seccomp for
> translated AArch32 processes. Here's how this works:
> 
> 1. When a translated process installs a seccomp filter, Tango injects
> a prefix into the seccomp program which effectively does:
>     if (arch == AUDIT_ARCH_AARCH64) {
>         // 64-bit syscalls used by Tango for internal operations
>         if (syscall_in_tango_whitelist(nr))
>             return SECCOMP_RET_ALLOW;
>     }
>     // continue to user-supplied seccomp program
> 
> 2. When Tango performs a 32-bit syscall on behalf of the translated
> process, the seccomp filter will see a syscall with AUDIT_ARCH_ARM and
> the compat syscall number. This allows the user-supplied seccomp
> filter to behave exactly as if it was running in a native AArch32
> process.
> 

Perhaps I'm missing something, but surely some syscalls that would be
native on 32 bit will have to be translated by Tango to 64 bit syscalls
to do the right thing? E.g. from the previous patch compat sigreturn
isn't available.

In those cases to correctly emulate seccomp, isn't Tango is going to
have to implement the seccomp filter in user space?

I guess the question comes down to how big a hole is
syscall_in_tango_whitelist() - if Tango only requires a small set of
syscalls then there is still some security benefit, but otherwise this
doesn't seem like a particularly big benefit considering you're already
going to need the BPF infrastructure in user space.

Or perhaps I'm wrong and there's some magic that makes this work in the
kernel?

Steve
