Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159BC3484F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhCXWxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhCXWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:53:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:53:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b7so35576421ejv.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHr083VjHOHzDz2ujRoHkPciK56RoE+YYVsaDRyaSiQ=;
        b=Vek+K7e1QLSZ/0x/6kpFsL1yBWndI2BEHUjCF1/Y5KeVlyj0qeX54HmJ790i0rLgpR
         v8alr48dgmUOPYORHVOg8Fpa32AuFydasSF4LPc4bcr20WGyIhix/nu0xmIUCrJsFvT1
         ONW5cG3lljQPSAaKVBEau9ytkVMktMxea0WZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHr083VjHOHzDz2ujRoHkPciK56RoE+YYVsaDRyaSiQ=;
        b=tzQ8IhLDijl1d0ChA5BjNiYLd9EIyECuxwVnawvCJbsjAVhWU9Flm1JbE8yZCIFLl7
         gRDGWdArBxLSRqUISR0VhXKtsBn2KnwkeBXs0YhtcocmMLVAlvpU9k6ASHtoHax2P4OJ
         2jtkJSGRurs0B+FLEW8OHsBPqbtjPkcV+8HcZQ/b9cj1qmUy+LnOqjavyyGxUxXMjUh0
         eORJKfbnRwIPaZXHXB3iL78GHpWHlzcAPdTNPxI1AxKqqNTGLc53DAjPJbE4ijG1HHXO
         I4upHytS09Qo/Vq6wnvow3n+k+X172RQVolHLLmFbxN7XAPYyMWG2+eHTRzaym87P8Fd
         xAKg==
X-Gm-Message-State: AOAM531vos+EOUlbS5qkt6+YDLEKEQvg+cTvRdZ1MIGrWaB9ea5xpAB8
        1MiA1zakYEDFLiKHg6Spv8DjSw+eFBj2qqvL
X-Google-Smtp-Source: ABdhPJzs1ijDm1EGDzp+UTqw7Kb0Gk2n2uFTqrpnhb0vloG9d8N5RBLfGqp+NaSRYKKeHSdtWeEZSA==
X-Received: by 2002:a17:906:d9d1:: with SMTP id qk17mr6124224ejb.52.1616626406757;
        Wed, 24 Mar 2021 15:53:26 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id p9sm1785629eds.66.2021.03.24.15.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:53:26 -0700 (PDT)
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk>
 <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2b38d13f-9f90-b94b-7de4-c924696e6a9f@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 23:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 23.34, Sami Tolvanen wrote:
> On Wed, Mar 24, 2021 at 2:51 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 24/03/2021 18.33, Peter Zijlstra wrote:
>>> On Wed, Mar 24, 2021 at 05:45:52PM +0100, Rasmus Villemoes wrote:
>>>> Sorry, I think I misread the code. The static calls are indeed
>>>> initialized with a function with the right prototype. Try adding
>>>> "preempt=full" on the command line so that we exercise these lines
>>>>
>>>>                static_call_update(cond_resched,
>>>> (typeof(&__cond_resched)) __static_call_return0);
>>>>                 static_call_update(might_resched,
>>>> (typeof(&__cond_resched)) __static_call_return0);
>>>>
>>>> I would expect that to blow up, since we end up calling a long (*)(void)
>>>> function using a function pointer of type int (*)(void).
>>>
>>> Note that on x86 there won't actually be any calling of function
>>> pointers. See what arch/x86/kernel/static_call.c does :-)
>>
>> I know, but so far x86 is the only one with HAVE_STATIC_CALL, so for
>> arm64 which is where CFI seems to be targeted initially, static_calls
>> are function pointers. And unless CFI ignores the return type, I'd
>> really expect the above to fail.
> 
> I think you're correct, this would trip CFI without HAVE_STATIC_CALL.
> However, arm64 also doesn't support PREEMPT_DYNAMIC at the moment, so
> this isn't currently a problem there.

Well, there's PREEMPT_DYNAMIC and HAVE_PREEMPT_DYNAMIC. The former
doesn't depend on the latter (and the latter does depend on
HAVE_STATIC_CALL, so effectively not for anything but x86). You should
be able to select both PREEMPT_DYNAMIC and CFI_CLANG, and test if
booting with preempt=full does give the fireworks one expects.

Rasmus
