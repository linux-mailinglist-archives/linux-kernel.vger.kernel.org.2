Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9241D3A1A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhFIP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFIP6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:58:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EA7C61278;
        Wed,  9 Jun 2021 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623254165;
        bh=Brj8Ps1D07lmJb6l+32gl6pseZbIS/xTqR+sZ9RrEqQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=si0WHEUraK33aa73XI62zclY1ZoTVBTXpVGjoHXZf5VcLR26D1Sm/dJ2hOENR+HH0
         tzs+Rz8KxAZjpDuxO6mIYlNnAIXvDdK3uyeWZllSEuM+WlGDgN1uLTF/1rL0nvZFds
         Ql/DUmvvc1yQbTOvz9zayqj5lOXhJ+7ch2Ajdb6X+0FPgnWdW5y1BAm0PBnRJIXjEg
         Uk5rYyfM8oRkaz273VrGWPhBnr0yPhvc7CmT80Kts4fCRosNNYj9QoZhBGd07D7sM0
         TLEzsjzpEbKmy/09EE+5AAn6j2ctbqI9scZIlEdY69i/ozqpU6B1IdJ2GmTJyQ5PW0
         x88JdjLTJ7bqg==
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=c5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
References: <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
 <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
 <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
 <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org>
 <CAFJ_xbp5YzYNQWEJLDySyC_bWUsirq=P03k8HHW=B4sH0V_uUg@mail.gmail.com>
 <YMBrqDI0Oxj9+Cr/@hirez.programming.kicks-ass.net>
 <CAFJ_xbodWTQQaJ-3yJ4ZQOiTFFXo6M+cn_F0p157o=80BwrQAw@mail.gmail.com>
 <20210609150804.GF68208@worktop.programming.kicks-ass.net>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <6caa3fa0-f71c-1a3f-b944-57b518645e74@kernel.org>
Date:   Wed, 9 Jun 2021 08:56:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609150804.GF68208@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/2021 8:08 AM, Peter Zijlstra wrote:
> On Wed, Jun 09, 2021 at 02:23:28PM +0200, Lukasz Majczak wrote:
>> śr., 9 cze 2021 o 09:20 Peter Zijlstra <peterz@infradead.org> napisał(a):
>>>
>>> On Wed, Jun 09, 2021 at 09:11:18AM +0200, Lukasz Majczak wrote:
>>>
>>>> I'm sorry I was on vacation last week - do you still need the requested debugs?
>>>
>>> If the patch here:
>>>
>>>    https://lkml.kernel.org/r/YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net
>>>
>>> does not fix things for you (don't think it actually will), then yes,
>>> please send me the information requested.
>>
>> Ok, it didn't help. Peter, Josh I have sent you a private email with
>> requested information.
> 
> OK, I think I've found it. Check this one:
> 
>   5d5:   0f 85 00 00 00 00       jne    5db <cpuidle_reflect+0x22>       5d7: R_X86_64_PLT32     __x86_indirect_thunk_r11-0x4
> 
> 
> +Relocation section '.rela.altinstructions' at offset 0 contains 14 entries:
> +    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 
> +0000000000000018  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5d5
> +000000000000001c  0000009200000002 R_X86_64_PC32          0000000000000000 __x86_indirect_alt_call_r11 + 0
> 
> Apparently we get conditional branches to retpoline thunks and objtool
> completely messes that up. I'm betting this also explains the problems
> Nathan is having.

Yes, the below patch gets my kernel back to booting so it seems the root 
cause is the same.

> *groan*,.. not sure what to do about this, except return to having
> objtool generate code, which everybody hated on. For now I'll make it
> skip the conditional branches.
> 
> I wonder if the compiler will also generate conditional tail calls, and
> what that does with static_call... now I have to check all that.
> 
> ---

Tested-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 24295d39713b..523aa4157f80 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -747,6 +747,10 @@ int arch_rewrite_retpolines(struct objtool_file *file)
>   
>   	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
>   
> +		if (insn->type != INSN_JUMP_DYNAMIC &&
> +		    insn->type != INSN_CALL_DYNAMIC)
> +			continue;
> +
>   		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
>   			continue;
>   
> 
