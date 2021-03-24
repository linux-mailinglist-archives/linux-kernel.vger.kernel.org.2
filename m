Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073BB34842D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhCXVwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhCXVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:51:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC986C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:51:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so35368219ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PT+dujUAmgFmgHJpTdhgvfY+Nbev7ObAVZ7wFssSbt8=;
        b=dFjeXgcjPFWBYzAdGDAr6qotENX+9vQD2Cz+RGxjO7Bc+iUlQbrIaxnbNNX9xA2Oa2
         urhNRxgGGCmEBdUhOju7WN7tHl6zKvgzB3LCddONfCxzP6af5RP0YjIkFH0vMvTMxHOC
         NcAQ+w3B13kovnjTbArM9QCqKOp4vN1IzypZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PT+dujUAmgFmgHJpTdhgvfY+Nbev7ObAVZ7wFssSbt8=;
        b=Q9LaUzxGLYojl9OH+1zOIRBu6lmBbjauhwFR8Uz7ZgwskzUY9TkM0OxyO6SxnTaqf7
         NY1eA5/Gj+JnLdlxHAqsfhXX5bjp/OUxLfibLMuKwJBZjDC3nMp/w393MT9xP/GgDOlo
         +VET5MIG1Rk+E/+nQP6NuHd0SKQNxE05s8zqL/50vlNNzpT10vzkv0cns+TQqEbEcSCr
         MNMpIp8sGYhoPUEIp2afiLjFs9moDfix1YyFT1tfhymMkogKaEQhJkMlbh80u+izg2Ah
         hn7VrGC2RMaetyI02NPVxNTeDHXqGKVUW06Fqyq2FTsElxyl8vchguDzu15bRmb6h49d
         uYBw==
X-Gm-Message-State: AOAM533GnetIG+dWPu1aoOHfWryphauuvPEJkF3rXMwCNpvjVRv9d/Mb
        6fiOBXM0pa0Wt8xgnoy1tbF2Xo2Cl4OjnVEJ
X-Google-Smtp-Source: ABdhPJyQfk/AAsb4ulgVU7qYgkyhD5zSdfLwU0pEpX60mvLBSYXeAUgcRMNjg5NMAYRqrD2cF5XQGA==
X-Received: by 2002:a17:906:ecf3:: with SMTP id qt19mr5832331ejb.467.1616622714190;
        Wed, 24 Mar 2021 14:51:54 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id g12sm1500644eje.120.2021.03.24.14.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:51:53 -0700 (PDT)
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
 <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
 <20210322172921.56350a69@gandalf.local.home>
 <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
 <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk>
 <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 22:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 18.33, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 05:45:52PM +0100, Rasmus Villemoes wrote:
>> Sorry, I think I misread the code. The static calls are indeed
>> initialized with a function with the right prototype. Try adding
>> "preempt=full" on the command line so that we exercise these lines
>>
>>                static_call_update(cond_resched,
>> (typeof(&__cond_resched)) __static_call_return0);
>>                 static_call_update(might_resched,
>> (typeof(&__cond_resched)) __static_call_return0);
>>
>> I would expect that to blow up, since we end up calling a long (*)(void)
>> function using a function pointer of type int (*)(void).
> 
> Note that on x86 there won't actually be any calling of function
> pointers. See what arch/x86/kernel/static_call.c does :-)

I know, but so far x86 is the only one with HAVE_STATIC_CALL, so for
arm64 which is where CFI seems to be targeted initially, static_calls
are function pointers. And unless CFI ignores the return type, I'd
really expect the above to fail.

> But I think some of this code might need some __va_function() love when
> combined with CFI.

Well, that was also my first thought when reading through the CFI
patches, I hoped that might salvage my
reduce-boilerplate-and-get-better-type-safety proposal for the
devm_*_action APIs [1]. But I don't think that would help at all;
storing __va_function(__static_call_return0) instead of
&__static_call_return0  (i.e., __static_call_return0 instead of
__static_call_return0.cfi_jt) doesn't help the call sites of that
static_call at all, neither address belongs to the range of jump table
entries corresponding to the prototype "int (*)(void)". So I think it
would be the static_call macro that would somehow need to grow a way to
suppress the cfi checking.

Rasmus

[1]
https://lore.kernel.org/lkml/20210309235917.2134565-1-linux@rasmusvillemoes.dk/
