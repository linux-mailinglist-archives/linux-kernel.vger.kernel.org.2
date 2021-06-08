Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0E3A0442
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhFHT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235621AbhFHTNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:13:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1A156196A;
        Tue,  8 Jun 2021 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623178188;
        bh=ckYWFdjEJXxvnkQRZWDc6jwPRd5jtBkq4BQAfKzm89Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m9CxkHzhQse/6lwKnbx4+Q8tQ7/4im1G7Jtu0+HNYIQjCpgqmwJT/lxqxp41wJ0YP
         9GHsQGEWuQCHlS63lKpzlgmCdPQWAJQduqHidSQo/IugO/8hClOT/n34nxAhAYmKQb
         tsqoEBqgLZE7kpolyeg6jlAdgqWQEVZX/wfDbycJmUwZmoUPXxEtQES1RlsB0In6nD
         0KQfinqh9DKhX3rSwRHiQHOTA1wf12n4H+tUummX3fVK8+KcHyuOlu5LZZHuhCKEd+
         OuFxV2EQveHvaEZMjVzOhOaZZb/AhexpxrEQJEjeJny0hGuOdB2pDkNhd4ov4PqSFC
         TlKfrgaqNvn3w==
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
References: <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
 <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
 <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org>
Date:   Tue, 8 Jun 2021 11:49:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/2021 11:17 AM, Peter Zijlstra wrote:
> On Tue, Jun 08, 2021 at 10:29:56AM -0700, Nathan Chancellor wrote:
>> Unfortunately, this is the VM provided by the Windows Subsystem for Linux so
>> examining it is nigh-impossible :/ I am considering bisecting the transforms
>> that objtool does to try and figure out the one that causes the machine to
>> fail to boot or try to reproduce in a different hypervisor, unless you have
>> any other ideas.
> 
> Does breaking Windows earn points similar to breaking the binary
> drivers? :-) :-)

:)

> The below should kill this latest transform and would quickly confirm if
> the that is causing your problem. If that's not it, what was your last
> known working version?

Yes, that diff gets me back to booting. I will see if I can figure out 
the exact rewrite that blows everything up.

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e5947fbb9e7a..d0f231b9c5a1 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1857,10 +1857,10 @@ static int decode_sections(struct objtool_file *file)
>   	 * Must be after add_special_section_alts(), since this will emit
>   	 * alternatives. Must be after add_{jump,call}_destination(), since
>   	 * those create the call insn lists.
> -	 */
>   	ret = arch_rewrite_retpolines(file);
>   	if (ret)
>   		return ret;
> +	 */
>   
>   	return 0;
>   }
> 

Cheers,
Nathan
