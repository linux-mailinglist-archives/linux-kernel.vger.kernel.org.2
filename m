Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6037509D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhEFIQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:16:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:50404 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbhEFIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:16:24 -0400
IronPort-SDR: ZeHwsGpKGi2PloLm85ZvWpX8Ag29yy2hAOS2bUHNCju6wNaRxEZFwv7Q73oyO9rV9Sys5mskcj
 50QfevodoAuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185872229"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="185872229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 01:14:49 -0700
IronPort-SDR: YOYbol4mHR0ZzBH+w1CpU011GEPo5Etw8G5ZJ0PqJFjirPYPzkpjWHnEflKyL5d5EBLkCsJuwZ
 wUA757WTQlxA==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="434235869"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 01:14:45 -0700
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
Date:   Thu, 06 May 2021 16:14:43 +0800
In-Reply-To: <CAK8P3a1SBDXqHE5FgG_WfzrcbeT6V6kg5T+xTGU8Cp_vLLdMqA@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 6 May 2021 09:54:55 +0200")
Message-ID: <877dkcs2h8.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> On Thu, May 6, 2021 at 3:20 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Arnd Bergmann <arnd@kernel.org> writes:
>>
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
>> > call_single_data"), the smp code prefers 32-byte aligned call_single_data
>> > objects for performance reasons, but the block layer includes an instance
>> > of this structure in the main 'struct request' that is more senstive
>> > to size than to performance here, see 4ccafe032005 ("block: unalign
>> > call_single_data in struct request").
>> >
>> > The result is a violation of the calling conventions that clang correctly
>> > points out:
>> >
>> > block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
>> >                 smp_call_function_single_async(cpu, &rq->csd);
>>
>> Can this be silenced by
>>
>>                 smp_call_function_single_async(cpu, (call_single_data_t *)&rq->csd);
>
> Probably, but casting from smaller alignment to larger alignment is undefined
> behavior

We cannot avoid type cast in Linux kernel, such as container_of(), is
there some difference here?

> and I'd rather not go there in case this triggers some runtime
> misbehavior or ubsan check in the future. Making the function accept a
> pointer with the smaller alignment avoids getting into undefined behavior
> and doesn't require a cast.

In its raw form as above, this looks bad.  If we encapsulate it, it may
look better, for example,

static inline int __smp_call_function_single_async(int cpu, struct __call_single_data *csd)
{
        smp_call_function_single_async(cpu, (call_single_data_t *)csd);
}

Then, we can do

        __smp_call_function_single_async(cpu, &rq->csd);

Best Regards,
Huang, Ying
