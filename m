Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1A38E544
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEXLWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:22:11 -0400
Received: from foss.arm.com ([217.140.110.172]:41154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbhEXLWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B99531B;
        Mon, 24 May 2021 04:20:41 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD8233F719;
        Mon, 24 May 2021 04:20:39 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 8/8] arm64: Allow 64-bit tasks to invoke compat
 syscalls
To:     Amanieu d'Antras <amanieu@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
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
 <14982d7d-bee1-6c25-8b18-123c29959f52@arm.com>
 <CA+y5pbRwgpctUOBzzscT9XMN9LM2qraPNg6K6onFcpQaaFDYkQ@mail.gmail.com>
 <1c2bd27a-1c96-f154-ed18-f33630b109b1@arm.com>
 <CA+y5pbSbky2kS+O5j9bn57nROdYaYeHcd2R-46X1cc388PKOvg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <419f410f-21b3-a4c6-3cd8-025007e9c31e@arm.com>
Date:   Mon, 24 May 2021 12:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+y5pbSbky2kS+O5j9bn57nROdYaYeHcd2R-46X1cc388PKOvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2021 20:18, Amanieu d'Antras wrote:
> On Fri, May 21, 2021 at 9:51 AM Steven Price <steven.price@arm.com> wrote:
>>>> In those cases to correctly emulate seccomp, isn't Tango is going to
>>>> have to implement the seccomp filter in user space?
>>>
>>> I have not implemented user-mode seccomp emulation because it can
>>> trivially be bypassed by spawning a 64-bit child process which runs
>>> outside Tango. Even when spawning another translated process, the
>>> user-mode filter will not be preserved across an execve.
>>
>> Clearly if you have user-mode seccomp emulation then you'd hook execve
>> and either install the real BPF filter (if spawning a 64 bit child
>> outside Tango) or ensure that the user-mode emulation is passed on to
>> the child (if running within Tango).
> 
> Spawning another process is just an example. Fundamentally, Tango is
> not intended or designed to be a sandbox around the 32-bit code. For
> example, many of the newer ioctls use u64 instead of a pointer type to
> avoid the need for a compat_ioctl handler. This means that such ioctls
> could be abused to read/write any address in the process address
> space, including the code that is performing the usermode seccomp
> emulation.

Indeed, I think it's almost impossible to fully preserve all the
security aspects of the seccomp filter - whether that's because the 32
bit code can "attack" Tango itself, or whether it's because Tango
requires white-listing ioctls that would normally be excluded by the
seccomp filter.

Even with the compat syscalls exposed, ioctls that take a u64 and don't
do any special handling for a compat call would happily accept addresses
>4GB even though they wouldn't if it was a real compat process.

For the user space emulation of the compat syscalls, Tango does have the
option of attempting to fix up such ioctls to restrict the address range
- but it's obviously a very large set of ioctls to audit if you want to
be complete.

>> You already have a potential 'issue' here of a 64 bit process setting up
>> a seccomp filter and then execve()ing a 32 bit (Tango'd) process. The
>> set of syscalls needed for the system which supports AArch32 natively is
>> going to be different from the syscalls needed for Tango. (Fundamentally
>> this is a major limitation with the whole seccomp syscall filtering
>> approach).
> 
> The specific example I had in mind here is Android which installs a
> global seccomp filter on the zygote process from which app processes
> are forked from. This filter is designed for mixed arm32/arm64 systems
> and therefore has syscall whitelists for both AArch32 and AArch64.
> This filter allows 32-bit processes to spawn 64-bit processes and
> vice-versa: for example, many 32-bit apps will invoke another 32-bit
> executable via system() which uses a 64-bit /system/bin/sh.

Given that Tango is going to be constrained by the 64 bit version of the
seccomp filter, I don't really understand why the emulated 32-bit
process needs to be separately constrained by the list of 32-bit calls
in this case.

The problem really comes if the controlling 64 bit process is written
"knowing" that it is executing a 32 bit process and tailors the seccomp
filter for that. I don't see any solution actually solving that (Tango
requires extra 64 bit syscalls which won't be naturally included).

>>>> I guess the question comes down to how big a hole is
>>>> syscall_in_tango_whitelist() - if Tango only requires a small set of
>>>> syscalls then there is still some security benefit, but otherwise this
>>>> doesn't seem like a particularly big benefit considering you're already
>>>> going to need the BPF infrastructure in user space.
>>>
>>> Currently Tango only whitelists ~50 syscalls, which is small enough to
>>> provide security benefits and definitely better than not supporting
>>> seccomp at all.
>>
>> Agreed, and I don't want to imply that this approach is necessarily
>> wrong. But given that the approach of getting the kernel to do the
>> compat syscall filtering is not perfect, I'm not sure in itself it's a
>> great justification for needing the kernel to support all the compat
>> syscalls.
> 
> I feel that exposing all compat syscalls to 64-bit processes is better
> than the alternative of only exposing a subset of them. Of the top of
> my head I can think of quite a few compat syscalls that cannot be
> fully emulated in userspace and would need to be exposed in the
> kernel:
> - mmap/mremap/shmat/io_setup: anything that allocates VM space needs
> to return a pointer in the low 4GB.

So a "generic" way of requested the kernel limit the address space for
allocations would be potentially useful for other purposes. Adding a new
syscall for this purpose would be sensible. We already have (at least)
two "hacks" in mmap for controlling the address range that can be used:

 * MAP_32BIT - x86 only, and really "31 bit"

 * Providing a mmap() hint with the top bits set to opt-in to 52-bit VAs.

A well defined mechanism for controlling the valid VA range for
allocations would be much better than adding more hacks - and bonus
points if it works for all the different types of allocation unlike the
above.

> - ioctl: too many variants to reasonably maintain a separate compat
> layer in userspace.

I do agree that it probably makes sense to expose a compat_ioctl()
syscall, but this isn't a complete fix and user space is likely to need
to do some ioctl translations. And x86->aarch64 is obviously going to
require translation in many cases.

> - getdents/lseek: ext4 uses 32-bit directory offsets for 32-bit processes.

My guess is that a getdents32() call makes sense, but I haven't looked
into this.

> - get_robust_list/set_robust_list: different in-memory ABI for
> 32/64-bit processes.

Here some careful thought needs to go into how both 32 bit and 64 bit
robust lists would coexist. I haven't looked into it, but I doubt it's
as simple as just exposing the compat calls.

> - open: don't force O_LARGEFILE for 32-bit processes.

At first glance it seems reasonable to expose the compat version.

> - io_uring_create: different in-memory ABI for 32/64-bit processes.

I'm not familiar enough with io_uring to sensibly comment on this.

> - (and possibly many others)
> 
> Also consider the churn involved when adding a new syscall which
> behaves differently in compat processes: rather than just using
> in_compat_syscall() or wiring up a COMPAT_SYSCALL_DEFINE, a compat
> variant of this syscall would also need to be added to the 64-bit
> syscall table to support translation layers like Tango and FEX.

Just exposing a new compat call to translated processes would also be
potentially dangerous - Tango needs to actually consider whether the
syscall is safe before exposing it. Yes there's some potential cost, but
in general there's much more of an attempt to make the compat syscalls
the same as native ones wherever possible. So I would expect that the
cases needing special handling are reasonably rare.

>> One other thought: I suspect in practise there aren't actually many
>> variations in the BPF programs used with seccomp. It may well be quite
>> possible to convert the 32-bit syscall filtering programs to filter the
>> equivalent 64-bit syscalls that Tango would use. Sadly this would be
>> fragile if a program used a BPF program which didn't follow the "normal"
>> pattern.
> 
> This might work for simple filters that only look at the syscall
> number, but becomes much harder when the filter also inspects the
> syscall arguments.

Yes it heavily relies on being able to pattern match what specific
programs/libraries do. My hunch is that most seccomp filters are set by
a very small number of programs/libraries. But I've no data to back that up.

Steve
