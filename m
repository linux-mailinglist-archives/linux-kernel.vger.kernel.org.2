Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066A375369
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhEFMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:04:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:23803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhEFMEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:04:43 -0400
IronPort-SDR: gFSAfq3KCZxxBCZutHX8FKZWlHD32YVyjDdMJ5btyr2Ks2ojt+OV4IIDPYUWDjvXB621GkVeha
 FaVZLXQS9bvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="195334287"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="195334287"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 05:03:44 -0700
IronPort-SDR: HukIPX+D+awV948GipBoElRBx58DvH4GPzaYTJD7aEiU2jwXJMUNQRePzQUqGrt4zKHHPYxMcF
 HM13EcW318sw==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="430498620"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 05:03:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        He Ying <heying24@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] [v2] smp: fix smp_call_function_single_async prototype
References: <20210505211300.3174456-1-arnd@kernel.org>
        <87czu4slom.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <CAK8P3a1SBDXqHE5FgG_WfzrcbeT6V6kg5T+xTGU8Cp_vLLdMqA@mail.gmail.com>
        <877dkcs2h8.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <CAK8P3a3kZ9_VoKV+2eZh=WqncRqFKzRmRHUjAT9iFMtJpKzb1w@mail.gmail.com>
Date:   Thu, 06 May 2021 20:03:38 +0800
In-Reply-To: <CAK8P3a3kZ9_VoKV+2eZh=WqncRqFKzRmRHUjAT9iFMtJpKzb1w@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 6 May 2021 10:30:49 +0200")
Message-ID: <87pmy4qdb9.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> On Thu, May 6, 2021 at 10:14 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Arnd Bergmann <arnd@kernel.org> writes:
>>
>> > On Thu, May 6, 2021 at 3:20 AM Huang, Ying <ying.huang@intel.com> wrote:
>> >>
>> >> Arnd Bergmann <arnd@kernel.org> writes:
>> >>
>> >> > From: Arnd Bergmann <arnd@arndb.de>
>> >> >
>> >> > As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
>> >> > call_single_data"), the smp code prefers 32-byte aligned call_single_data
>> >> > objects for performance reasons, but the block layer includes an instance
>> >> > of this structure in the main 'struct request' that is more senstive
>> >> > to size than to performance here, see 4ccafe032005 ("block: unalign
>> >> > call_single_data in struct request").
>> >> >
>> >> > The result is a violation of the calling conventions that clang correctly
>> >> > points out:
>> >> >
>> >> > block/blk-mq.c:630:39: warning: passing 8-byte aligned argument
>> >> > to 32-byte aligned parameter 2 of
>> >> > 'smp_call_function_single_async' may result in an unaligned
>> >> > pointer access [-Walign-mismatch]
>> >> >                 smp_call_function_single_async(cpu, &rq->csd);
>> >>
>> >> Can this be silenced by
>> >>
>> >>                 smp_call_function_single_async(cpu, (call_single_data_t *)&rq->csd);
>> >
>> > Probably, but casting from smaller alignment to larger alignment is undefined
>> > behavior
>>
>> We cannot avoid type cast in Linux kernel, such as container_of(), is
>> there some difference here?
>
> container_of() does not cause any alignment problems. Assuming the outer
> structure is aligned correctly, then the inner structure also is.

So you think that the compiler may generate different code depends on
the data structure alignment (8 vs. 32 here)?  I think that it doesn't
on x86.  Do you know it does that on any architecture?  But I understand
that this is possible at least in theory.

>> > and I'd rather not go there in case this triggers some runtime
>> > misbehavior or ubsan check in the future. Making the function accept a
>> > pointer with the smaller alignment avoids getting into undefined behavior
>> > and doesn't require a cast.
>>
>> In its raw form as above, this looks bad.  If we encapsulate it, it may
>> look better, for example,
>>
>> static inline int __smp_call_function_single_async(int cpu, struct __call_single_data *csd)
>> {
>>         smp_call_function_single_async(cpu, (call_single_data_t *)csd);
>> }
>>
>> Then, we can do
>>
>>         __smp_call_function_single_async(cpu, &rq->csd);
>
> Same problem, it's still calling a function that expects stricter alignment.
> It would work if we do it the other way around though:
>
> static inline int smp_call_function_single_async(int cpu,
> call_single_data_t *csd)
> {
>         return __smp_call_function_single_async(cpu, csd);
> }
>
> That should even work without the cast.

Yes.  This looks good!

Best Regards,
Huang, Ying
