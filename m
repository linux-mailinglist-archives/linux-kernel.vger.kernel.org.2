Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDEC413DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhIUXID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:08:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52752 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhIUXIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:08:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 00F781F4358B
Message-ID: <9db8c79a-f704-84ce-360b-84335f926a48@collabora.com>
Date:   Tue, 21 Sep 2021 20:06:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
 <72990864-5ec6-1f73-efd9-61b667a172dd@collabora.com>
 <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 05:08 de 21/09/21, Arnd Bergmann escreveu:
> On Tue, Sep 21, 2021 at 12:47 AM André Almeida
> <andrealmeid@collabora.com> wrote:
>>
>> #if defined(__i386__) || __TIMESIZE == 32
>> # define NR_gettime64 __NR_clock_gettime64
>> #else
>> # define NR_gettime64 __NR_clock_gettime
>> #endif
>>
>> struct timespec64 {
>>         long long tv_sec;       /* seconds */
>>         long long tv_nsec;      /* nanoseconds */
>> };
>>
>> int gettime64(clock_t clockid, struct timespec64 *tv)
>> {
>>         return syscall(NR_gettime64, clockid, tv);
>> }
>>
>> Then we can just use &timeout at __NR_futex_time64 for 32bit arch and at
>> __NR_futex for 64bit arch.
> 
> This is still broken when you disable CONFIG_COMPAT_32BIT_TIME,
> which disables all system calls that take time32 arguments.
> 

Oh, I think my point was confusing then. My suggestion was to use only
the futex entry points that accepts time64, and to always use
clock_gettime that uses time64, for all platforms. Then it will work if
we disable CONFIG_COMPAT_32BIT_TIME.

>> This might be a simpler solution to the problem that you are facing but
>> I'm not entirely sure. Also, futex's selftests do use the timeout
>> argument and I think that they also won't compile in 32-bit RISC-V, so
>> maybe we can start from there so we can actually test the timeout
>> argument and check if it's working.
> 
> I would love to see the wrapper that Alistair wrote as part of some kernel
> uapi header provided to user space. futex is used by tons of applications,
> and we never had a library abstraction for it, so everyone has to do these
> by hand, and they all get them slightly wrong in different ways.

Why we don't have a futex() wrapper at glibc as we do have for others
syscalls?

> 
> We normally don't do this in kernel headers, but I think the benefits
> would be far greater compared to today's situation.
> 
>       Arnd
> 
