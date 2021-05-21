Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7C38C248
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhEUIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:52:29 -0400
Received: from foss.arm.com ([217.140.110.172]:41828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhEUIw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:52:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C9D511B3;
        Fri, 21 May 2021 01:51:04 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE19F3F73D;
        Fri, 21 May 2021 01:51:02 -0700 (PDT)
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
From:   Steven Price <steven.price@arm.com>
Message-ID: <1c2bd27a-1c96-f154-ed18-f33630b109b1@arm.com>
Date:   Fri, 21 May 2021 09:51:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+y5pbRwgpctUOBzzscT9XMN9LM2qraPNg6K6onFcpQaaFDYkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 17:14, Amanieu d'Antras wrote:
> On Wed, May 19, 2021 at 4:30 PM Steven Price <steven.price@arm.com> wrote:
>> Perhaps I'm missing something, but surely some syscalls that would be
>> native on 32 bit will have to be translated by Tango to 64 bit syscalls
>> to do the right thing? E.g. from the previous patch compat sigreturn
>> isn't available.
> 
> That's correct.
> 
> Tango handles syscalls in 3 different ways:
> - ~20 syscalls are completely emulated in userspace or through 64-bit
> syscalls. E.g. sigaction, sigreturn, clone, exit.
> - Another ~50 syscalls have various forms of pre/post-processing, but
> are otherwise passed on to the kernel compat syscall handler. E.g.
> open, mmap, ptrace.
> - The remaining syscalls are passed on to the kernel compat syscall
> handler directly.
> 
> The first group of ~20 syscalls will effectively bypass the
> user-specified seccomp filter: any 64-bit syscalls used to emulate
> them will be whitelisted. I consider this an acceptable limitation to
> Tango's seccomp support since I see no viable way of supporting
> seccomp filtering for these syscalls.

I agree it's difficult - the only 'solution' I can see is like I said to
emulate the BPF code in user space.

>> In those cases to correctly emulate seccomp, isn't Tango is going to
>> have to implement the seccomp filter in user space?
> 
> I have not implemented user-mode seccomp emulation because it can
> trivially be bypassed by spawning a 64-bit child process which runs
> outside Tango. Even when spawning another translated process, the
> user-mode filter will not be preserved across an execve.

Clearly if you have user-mode seccomp emulation then you'd hook execve
and either install the real BPF filter (if spawning a 64 bit child
outside Tango) or ensure that the user-mode emulation is passed on to
the child (if running within Tango).

You already have a potential 'issue' here of a 64 bit process setting up
a seccomp filter and then execve()ing a 32 bit (Tango'd) process. The
set of syscalls needed for the system which supports AArch32 natively is
going to be different from the syscalls needed for Tango. (Fundamentally
this is a major limitation with the whole seccomp syscall filtering
approach).

>> I guess the question comes down to how big a hole is
>> syscall_in_tango_whitelist() - if Tango only requires a small set of
>> syscalls then there is still some security benefit, but otherwise this
>> doesn't seem like a particularly big benefit considering you're already
>> going to need the BPF infrastructure in user space.
> 
> Currently Tango only whitelists ~50 syscalls, which is small enough to
> provide security benefits and definitely better than not supporting
> seccomp at all.

Agreed, and I don't want to imply that this approach is necessarily
wrong. But given that the approach of getting the kernel to do the
compat syscall filtering is not perfect, I'm not sure in itself it's a
great justification for needing the kernel to support all the compat
syscalls.

One other thought: I suspect in practise there aren't actually many
variations in the BPF programs used with seccomp. It may well be quite
possible to convert the 32-bit syscall filtering programs to filter the
equivalent 64-bit syscalls that Tango would use. Sadly this would be
fragile if a program used a BPF program which didn't follow the "normal"
pattern.

Steve
