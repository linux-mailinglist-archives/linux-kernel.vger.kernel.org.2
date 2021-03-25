Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE96348B83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCYI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:27:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:27:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x21so1438536eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XDJMrloCPc2qsa07p06WodbgmzYyye6+8dvpO5AaLD4=;
        b=fZmSS+1yH7NSNBp7S7JA0BiPmzNkZ5OuERxGTCF+DtlMvk9/fYpz+SY8m/vjF9wHu4
         VNkXrqQwxrNluuqHwHjG+xZVJazG7jzLfD6aNcWGIcjAhVpOVdBPyZmo9maMmnpaH3CW
         XrHdgcehb8+rZGHiNpNa6d0l6Rc6beubofoAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XDJMrloCPc2qsa07p06WodbgmzYyye6+8dvpO5AaLD4=;
        b=ZNrQs0ksfcQUqWJDM3LnNxFuFw80nTi2fFTbKFpiucSJkB21zUShheSog7iO2s9ghM
         HiFcVfzhTjIfoZEwP62j2OLhgIQ82CBd/QCoi3TEe22Jzr2MXFM8zYOL9SKoI6JVIFqK
         vhvo1YZyIsgAtboRpOiMhTZfnBO0ehZ1FAVaUDVfOSRuU/rvrQFsFdd4Fm8o4SahNJe3
         ElHvqZOe06QWjKNVvBbksRQ9//JjNndambLcIKfR+V3uRj+FQIjOBg6kN1/+SgiENLEv
         4HpkjN0NHD9XWczw3RPfwCr+iKk2U4T2OJ0NrqQm8nFcVpSHFpRSwTGHpXXdSXyxVMXX
         AtGg==
X-Gm-Message-State: AOAM531tKZVWPDR5fNKvpXnFeqN7F4+BXo681pUfSJNPzZBvf/7c2qLZ
        kt6mEzuR8R1GD3eCD3nAgnVE7VTwjiJudufH
X-Google-Smtp-Source: ABdhPJyZVeO6YMVwAYUBLYN+VL5uXvEYQtgfoT39cMXuq4XCuT0ifiSFeA79XNOGYHuR1LM4i8Uxrw==
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr7690161edd.313.1616660827102;
        Thu, 25 Mar 2021 01:27:07 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id j1sm2066842ejt.18.2021.03.25.01.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 01:27:06 -0700 (PDT)
Subject: Re: [PATCH] static_call: fix function type mismatch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
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
References: <YFmdJlESrCh4iC9A@hirez.programming.kicks-ass.net>
 <0f4679d6-44a4-d045-f249-a9cffb126fd4@rasmusvillemoes.dk>
 <CABCJKuf1-GWda9_BiBO=nNP_drh3a8471G+LEqPzdVrLBhVqZQ@mail.gmail.com>
 <b2d77e78-751e-283c-8cff-e9c4f16e27ef@prevas.dk>
 <YFt382FImjQQ+10f@hirez.programming.kicks-ass.net>
 <a758cace-99ed-5c60-e59c-9f4f6b3a39c7@rasmusvillemoes.dk>
 <CABCJKuek8Set48v5wa2sbCN1fN7DYSczJ9MdH4BcQBdky1YNaA@mail.gmail.com>
 <2b38d13f-9f90-b94b-7de4-c924696e6a9f@rasmusvillemoes.dk>
 <CABCJKudx9bkvkOsAVi7Wzgr3AVFGwa64Kre1d59v0tTr6GOgcA@mail.gmail.com>
 <170687fb-13ef-e9b8-ac69-032202b344fe@rasmusvillemoes.dk>
 <YFw+4Ba5ci/Bmg0k@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <724911b8-f812-4857-0a14-0f6931842244@rasmusvillemoes.dk>
Date:   Thu, 25 Mar 2021 09:27:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFw+4Ba5ci/Bmg0k@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2021 08.42, Peter Zijlstra wrote:
> On Thu, Mar 25, 2021 at 01:42:41AM +0100, Rasmus Villemoes wrote:
>>> Actually, it looks like I can't select PREEMPT_DYNAMIC> and tweaking Kconfig
>>
>> Ah, there's no prompt on the "bool" line, so it doesn't show up. That
>> seems to be a mistake, since there's an elaborate help text which says
>>
>>           The runtime overhead is negligible with
>> HAVE_STATIC_CALL_INLINE enabled
>>           but if runtime patching is not available for the specific
>> architecture
>>           then the potential overhead should be considered.
>>
>> So it seems that it was meant to be "you can enable this if you really
>> want".
>>
>> to force enable it on arm64 results in a build error
> 
> Right, PREEMPT_DYNAMIC really hard relies on HAVE_STATIC_CALL
> 
> There's an implicit dependency in the select:
> 
> config PREEMPT
> 	...
> 	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC

That's not a dependency, that's a "force PREEMPT_DYNAMIC on", and users
on x86 can't deselect PREEMPT_DYNAMIC even if they wanted to.

Having a help text but not providing a prompt string is rather unusual.
What's the point of that paragraph I quoted above if PREEMPT_DYNAMIC is
not supposed to be settable by the developer?

>>> ("implicit declaration of function 'static_call_mod'").
>>
>> Seems to be an omission in the last !HAVE_STATIC_CALL branch in
>> static_call_types.h, and there's also no
>> EXPORT_STATIC_CALL_TRAMP{,_GPL} in static_call.h for that case.
> 
> That interface doesn't make sense for !HAVE_STATIC_CALL.

Perhaps, perhaps not. But I think it's silly to have code with such a
random hidden dependency, especially when it's only a defense against
crazy oot modules and not some fundamental requirement.

> It's impossible
> to not export the function pointer itself but still call it for
> !HAVE_STATIC_CALL.

Well, I think there's a way. At this point, the audience is asked to
wear sun glasses.

// foo.h
extern const int foo;
extern int __foo_just_for_vmlinux;

// foo.c
int __foo_just_for_vmlinux;
extern const int foo __attribute__((__alias__("__foo_just_for_vmlinux")));
EXPORT_SYMBOL(foo);

Modules can read foo, but can't do foo = 5. (Yeah, they can take the
address and cast away the const...). Basically, this is a kind of
top-level anonymous union trick a la i_nlink/__i_nlink. And it's more or
less explicitly said in the gcc docs that this is supposed to work:
"Except for top-level qualifiers the alias target must have the same
type as the alias."

Rasmus
