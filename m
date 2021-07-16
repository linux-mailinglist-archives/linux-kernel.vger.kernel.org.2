Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3E3CBC22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhGPS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:58:07 -0400
Received: from gateway32.websitewelcome.com ([192.185.144.98]:20285 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230018AbhGPS6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:58:06 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id F26492E627
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:55:09 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 4SzNmxhU3rJtZ4SzNmmFsn; Fri, 16 Jul 2021 13:55:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kSBeS0wNZCGOSvffjr4Uefrex/vK2JFe2DnuWwhdA3M=; b=IGm1FgdAUCQ4dCu+4FRpIyjx9+
        1jOH4ooi7BqArupu4+74L/CK8+SiRtlSvwmCoUDhg2pNXEbI2D57nd0/DFxWYxfdfNh2eGt5cckKs
        U7JLXwH2jsZjJEI/k8AmgGvDwMIKp8twG6pyw9lfZZsMv5yk1I4nNzRUJABYOIX38M/SF0HjBiQOL
        ZCoyTApESIsAfAa+iB9xut1A1FU3ZdXX3hwlTbuOmNVOelkCxr/1pAdUv2F0VoC9hjggkmsmrARtL
        KRchIVG8jlHFfipFhbxEne1YNgidGqOfmQa70Y+ZazUvzM8f2AgfIHZsOoZikPqEnpvSi2SeVM4ah
        PpCUnN5g==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:42730 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1m4SzL-002ZwS-Fu; Fri, 16 Jul 2021 13:55:07 -0500
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210714200523.GA10606@embeddedor>
 <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
 <YPHUJsiaOuqzW0Od@archlinux-ax161>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <54a99f59-0211-d9c2-4ab5-e74bbc72086b@embeddedor.com>
Date:   Fri, 16 Jul 2021 13:57:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPHUJsiaOuqzW0Od@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1m4SzL-002ZwS-Fu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:42730
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/21 13:47, Nathan Chancellor wrote:
> On Thu, Jul 15, 2021 at 06:04:15PM -0700, Linus Torvalds wrote:
>> On Wed, Jul 14, 2021 at 1:03 PM Gustavo A. R. Silva
>> <gustavoars@kernel.org> wrote:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2
>>
>> Grr.
>>
>> I merged this, but when I actually tested it on my clang build, it
>> turns out that the clang "-Wimplicit-fallthrough" flag is unbelievable
>> garbage.
>>
>> I get
>>
>>    warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>>
>> and the stupid warning doesn't even say WHERE THE PROBLEM HAPPENS.
>>
>> No file name, no line numbers. Just this pointless garbage warning.
>>
>> Honestly, how does a compiler even do something that broken? Am I
>> supposed to use my sixth sense to guide me in finding the warning?
>>
>> I like the concept of the fallthrough warning, but it looks like the
>> clang implementation of it is so unbelievably broken that it's getting
>> disabled again.
>>
>> Yeah, I can
>>
>>  (a) build the kernel without any parallelism
>>
>>  (b) use ">&" to get both output and errors into the same file
>>
>>  (c) see that it says
>>
>>     CC      kernel/sched/core.o
>>   warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>>   1 warning generated.
>>
>> and now I see at least which _file_ it is that causes that warning.
>>
>> I can then use my incredible powers of deduction (it's almost like a
>> sixth sense, but helped by the fact that there's only one single
>> "fallthrough" statement in that file) to figure out that it's
>> triggered by this code:
>>
>>                 case cpuset:
>>                         if (IS_ENABLED(CONFIG_CPUSETS)) {
>>                                 cpuset_cpus_allowed_fallback(p);
>>                                 state = possible;
>>                                 break;
>>                         }
>>                         fallthrough;
>>                 case possible:
>>
>> and it all makes it clear that the clang warning is just incredibly
>> broken garbage not only in that lack of filename and line number, but
>> just in general.
> 
> I commented this on the LLVM bug tracker but I will copy and paste it
> here for posterity:
> 
> "It is actually the fact that
> 
> case 1:
>     if (something || !IS_ENABLED(CONFIG_SOMETHING))
>         return blah;
>     fallthrough;
> case 2:
> 
> looks like
> 
> case 1:
>     return blah;
>     fallthrough;
> case 2:
> 
> For example: https://godbolt.org/z/GdPeMbdo8
> 
> int foo(int a) {
>     switch (a) {
>     case 0:
>         if (0)
>             return 0;
>         __attribute__((__fallthrough__)); // no warning
>     case 1:
>         if (1)
>             return 1;
>         __attribute__((__fallthrough__)); // warning

I think that if the "1" in this case, depends on the initial
configuration, as it is the case with CONFIG_CPUSETS, then
Clang should not cause a warning either. That's how GCC seems
to be treating these scenarios.

--
Gustavo

>     case 2:
>         return 3;
>     default:
>         return 4;
>     }
> }
> 
> I am not really sure how to resolve that within checkFallThroughIntoBlock() or
> fillReachableBlocks() but given that this is something specific to the kernel,
> we could introduce -Wimplicit-fallthrough-unreachable then disable it within
> the kernel.
> 
> The file location not showing up was fixed by commit 1b4800c26259
> ("[clang][parser] Set source ranges for GNU-style attributes"). The
> differential revision mentions this issue specifically."
> 
> Hopefully that would be an adequate solution, otherwise someone with more clang
> internal will have to take a look.
> 
> Cheers,
> Nathan
> 
