Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF239FDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhFHRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhFHRbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:31:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EA3B61378;
        Tue,  8 Jun 2021 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623173398;
        bh=ma/CkFfb8CYaaDcX25dR9NFonTv/wOGFyGfkm75Kj9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VbARVNu/BDv7MOreXdH0h0CjHdMLUOauVp/AeplxCuwYNJfohMxtKJWhy8RaPPtQ0
         dCplQ8K+KqbASS0q/VrnUAClykw8RFvI/nvJdSIOQ/o27JX68HdKEQkDqm18fze5lq
         zk92iaQ7GwSSAueUAqMKpRfGSmGvPaD2ZajXpgn/LC3jDf5umXHUyLxyik0BN6QYFg
         RqSji2MPY67nmh80t4F1wvVMpYSCJmlJVPV3ITkci84klRjfGBu+TnU+iHu9afBMm0
         hffBmnxfZlrwmJMmIrglrEN3Es3tjtkpSDNjLAgKwern6vhY1nY0Rgiiy0VyygDxUX
         s5Riljchq/j0Q==
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=c5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
 <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
Date:   Tue, 8 Jun 2021 10:29:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/2021 10:22 AM, Peter Zijlstra wrote:
> On Tue, Jun 08, 2021 at 09:58:03AM -0700, Nathan Chancellor wrote:
>> On 6/7/2021 1:54 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
>>> On Mon, Jun 7, 2021 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>
>>> Thanks, the below diff resolves the linker error reported in
>>> https://github.com/ClangBuiltLinux/linux/issues/1388
>>>
>>> Both readelf implementations seem happy with the results, too.
>>>
>>> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>>>
>>> Nathan,
>>> Can you please test the below diff and see if that resolves your boot
>>> issue reported in:
>>> https://github.com/ClangBuiltLinux/linux/issues/1384
>>
>> Unfortunately, it does not appear to resolve that issue.
>>
>> $ git log -2 --decorate=no --oneline
>> eea6a9d6d277 Peter's fix
>> 614124bea77e Linux 5.13-rc5
>>
>> $ strings /mnt/c/Users/natec/Linux/kernel-investigation | grep microsoft
>> 5.13.0-rc5-microsoft-standard-WSL2-00001-geea6a9d6d277
>> (nathan@archlinux-ax161) #3 SMP Tue Jun 8 09:46:19 MST 2021
>>
>> My VM still never makes it to userspace.
> 
> Since it's a VM, can you use the gdb-stub to ask it where it's stuck?
> 

Unfortunately, this is the VM provided by the Windows Subsystem for 
Linux so examining it is nigh-impossible :/ I am considering bisecting 
the transforms that objtool does to try and figure out the one that 
causes the machine to fail to boot or try to reproduce in a different 
hypervisor, unless you have any other ideas.

Cheers,
Nathan
