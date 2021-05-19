Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885053899DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhESXa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhESXa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C209610CB;
        Wed, 19 May 2021 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621466976;
        bh=6/whUwY1s4s16/hwQLNvUOYLO0zffwSHDrR5vJNwuf4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EsZr5LTzneA83dV8soI8i3YX1gZa4OsXH7nTfBIa2Wurl5SJkjMmvVrqd7JDOls0f
         qzdPxPmnG2I300EQdWQAS5FvXbainILuLqQ9uo2veUq7basSqK27CfWHuyPn9RDqYd
         R9tuk1dIpSdZGVePfweQfRhylsJrdQvha5A+faMw2VMF3K/CaPWrvtz4CqzuOTB6qY
         NvWbMlWgFZZGEYegPF9YnQ0D4sA+hzLByUZhwQGyVA6ZX8O00CPerDlVfONCAJ7ARK
         2K2O1Afi7A2lwo0Q3Nu1Y3wB5fpsPuq+Ubibl7QoSKe05k5Ue2mgK49ZGY1ZCa5I+/
         cj0cD+SNKaiUw==
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
To:     Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic>
 <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
 <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <8735uxmucw.ffs@nanos.tec.linutronix.de>
 <CAJvTdK=6B8fXasshqOoMknAt25vWPDW6LVLovOhnmY10ZEdL1Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <eebc971a-dc5f-6ae6-c5f7-d303e56212b2@kernel.org>
Date:   Wed, 19 May 2021 16:29:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJvTdK=6B8fXasshqOoMknAt25vWPDW6LVLovOhnmY10ZEdL1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 1:39 PM, Len Brown wrote:
> On Sat, May 8, 2021 at 5:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> 
>> Where is #6 which describes the signal interaction?
> 
> #6 Per the current ABI, Linux gives signal handlers access to all of
> the hardware architectural state.
> 
> #6a Signal Stack is on User Stack
> 
> The architectural state is pushed on the user stack in uncompressed
> XSTATE format.
> 
> It is established that there exists application code that counts on
> this opaque state being complete so that it can do a user-space
> XRESTORE instead of a sigreturn(2).

Is this established?

Note that the specific case of a user program doing XRSTOR will work
just fine if we omit the allocation of non-in-use states from the
buffer, at least by my reading of the pseudocode.  The case that would
break is if user code then assumes that it can XSAVE back to the same
buffer.

> (My opinion is that not breaking
> that legacy code is a requirement, and I'm actually shocked this view
> is not unanimous)
> 
It's pretty unanimous.  But the legacy code that's broken has to
actually exist for this to apply.
