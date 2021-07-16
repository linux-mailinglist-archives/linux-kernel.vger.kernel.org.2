Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D23CBC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhGPTVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhGPTVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:21:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED072613DF;
        Fri, 16 Jul 2021 19:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626463122;
        bh=ksQ8CHwF3GSe7R4KX9/y53TSbrUHgfoZSogamqkWQoU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CcjCEjz28Yp6vSFhJ3xpa9+gQYBue+Ws2nhFAekmEqNEZy/8KyqZ6uTpuTp2FuGPZ
         LlMXudjv3Th05hpe0ab+BcDB1p9MyYkWP6HNNDGr7mHmgM+V0o23YE7EO/775GrsYb
         qv8gTsnMl5O/Np2ta2HhhaWNKUNmsQ5+4fetrmqIyzZfnuMTnN2hok7Nw7aylku0em
         VPcarSNE0cy8zdqW5DKxM1n6BZktw/7qHxy90Rtjvc1nUO7Y1pqcwoFUEzfTZxnOMt
         n//U5ylEgsvoIddIRiDT/mPy8y1K9Sg7nLuP+k+eygXUf+9Z1e2A8bPrp0NU/u7MCN
         NrMO9RIxycB0Q==
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210714200523.GA10606@embeddedor>
 <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
 <YPHUJsiaOuqzW0Od@archlinux-ax161>
 <54a99f59-0211-d9c2-4ab5-e74bbc72086b@embeddedor.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <7774f876-6a60-03e4-b273-34f508d06404@kernel.org>
Date:   Fri, 16 Jul 2021 12:18:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <54a99f59-0211-d9c2-4ab5-e74bbc72086b@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2021 11:57 AM, Gustavo A. R. Silva wrote
> On 7/16/21 13:47, Nathan Chancellor wrote:
>> On Thu, Jul 15, 2021 at 06:04:15PM -0700, Linus Torvalds wrote:
>>> On Wed, Jul 14, 2021 at 1:03 PM Gustavo A. R. Silva
>>> <gustavoars@kernel.org> wrote:
>>>>
>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2
>>>
>>> Grr.
>>>
>>> I merged this, but when I actually tested it on my clang build, it
>>> turns out that the clang "-Wimplicit-fallthrough" flag is unbelievable
>>> garbage.
>>>
>>> I get
>>>
>>>     warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>>>
>>> and the stupid warning doesn't even say WHERE THE PROBLEM HAPPENS.
>>>
>>> No file name, no line numbers. Just this pointless garbage warning.
>>>
>>> Honestly, how does a compiler even do something that broken? Am I
>>> supposed to use my sixth sense to guide me in finding the warning?
>>>
>>> I like the concept of the fallthrough warning, but it looks like the
>>> clang implementation of it is so unbelievably broken that it's getting
>>> disabled again.
>>>
>>> Yeah, I can
>>>
>>>   (a) build the kernel without any parallelism
>>>
>>>   (b) use ">&" to get both output and errors into the same file
>>>
>>>   (c) see that it says
>>>
>>>      CC      kernel/sched/core.o
>>>    warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>>>    1 warning generated.
>>>
>>> and now I see at least which _file_ it is that causes that warning.
>>>
>>> I can then use my incredible powers of deduction (it's almost like a
>>> sixth sense, but helped by the fact that there's only one single
>>> "fallthrough" statement in that file) to figure out that it's
>>> triggered by this code:
>>>
>>>                  case cpuset:
>>>                          if (IS_ENABLED(CONFIG_CPUSETS)) {
>>>                                  cpuset_cpus_allowed_fallback(p);
>>>                                  state = possible;
>>>                                  break;
>>>                          }
>>>                          fallthrough;
>>>                  case possible:
>>>
>>> and it all makes it clear that the clang warning is just incredibly
>>> broken garbage not only in that lack of filename and line number, but
>>> just in general.
>>
>> I commented this on the LLVM bug tracker but I will copy and paste it
>> here for posterity:
>>
>> "It is actually the fact that
>>
>> case 1:
>>      if (something || !IS_ENABLED(CONFIG_SOMETHING))
>>          return blah;
>>      fallthrough;
>> case 2:
>>
>> looks like
>>
>> case 1:
>>      return blah;
>>      fallthrough;
>> case 2:
>>
>> For example: https://godbolt.org/z/GdPeMbdo8
>>
>> int foo(int a) {
>>      switch (a) {
>>      case 0:
>>          if (0)
>>              return 0;
>>          __attribute__((__fallthrough__)); // no warning
>>      case 1:
>>          if (1)
>>              return 1;
>>          __attribute__((__fallthrough__)); // warning
> 
> I think that if the "1" in this case, depends on the initial
> configuration, as it is the case with CONFIG_CPUSETS, then
> Clang should not cause a warning either. That's how GCC seems
> to be treating these scenarios.

Correct. It does not seem like GCC warns at all about the use of 
fallthrough attributes at all, for example, against the same clang test 
cases: https://godbolt.org/z/4MvW1TnYa

This could be a conscious decision by the clang developers to deviate 
from GCC, the only way we will know is from the bug report above. I can 
recall this happening once before where it impacted the kernel and the 
clang developers allowed me to add another flag that was default enabled 
but could be disabled separately from the warning to get GCC 
compatibility without sacrificing the additional warning coverage they 
felt was worth deviating from GCC for:

https://github.com/ClangBuiltLinux/linux/issues/887
https://reviews.llvm.org/D72231
https://reviews.llvm.org/D75758

Hence why I suggested -Wimplicit-fallthrough-unreachable.

>>      case 2:
>>          return 3;
>>      default:
>>          return 4;
>>      }
>> }
>>
>> I am not really sure how to resolve that within checkFallThroughIntoBlock() or
>> fillReachableBlocks() but given that this is something specific to the kernel,
>> we could introduce -Wimplicit-fallthrough-unreachable then disable it within
>> the kernel.
>>
>> The file location not showing up was fixed by commit 1b4800c26259
>> ("[clang][parser] Set source ranges for GNU-style attributes"). The
>> differential revision mentions this issue specifically."
>>
>> Hopefully that would be an adequate solution, otherwise someone with more clang
>> internal will have to take a look.

Cheers,
Nathan
