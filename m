Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73E34D22A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhC2OLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhC2OKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:10:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D49C061574;
        Mon, 29 Mar 2021 07:10:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617027052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSxgoPopcM0cDMxgeW7VtkiyOengdx6ivl7xbU811OM=;
        b=Nuo01USCwoeU/+/V+JGgvZUDpIWn67KGPIbL8b1tTS5s6UcMNQRRKrUafrZFve5obVgOOJ
        73u47whssJNTzZxUD0A5gKe6VPDb4TVKOteIMVo0YDlhK4h9y2sM0V9j23Mdm6CY8RJKNv
        2j4iaEkCqWeG422dTAgFS2ep90RtiQ8XNerAjMWHpRZRzfeyR65rIw/79WnTBk05fCcPFM
        YR098gZ7qB8oS4G6cVm8CJi33EU3SVKW8hQC1XaNYdBkVK4aoKX7SgzKjjmRmPNmWr8EjL
        MK6NvX/lhPVQJDMTDmNPNHM/eq00jlQ5susXZClx9zfN9mVKPrgeN4DepptIpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617027052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QSxgoPopcM0cDMxgeW7VtkiyOengdx6ivl7xbU811OM=;
        b=GF4k7+bIuvabZwywW1+UzMxS2SMH1G5hGQWmlUT7RAotmXvgICLTIkNjdFfA7Xp3CZmfPf
        qruKyM3ef5cj/9BA==
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown\, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to control state component support
In-Reply-To: <CAJvTdKkOED6p0ox83A0qcspi5UZ-UbZAkJeyOJ6AChb-qnZGwQ@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de> <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com> <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com> <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com> <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com> <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com> <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com> <CAJvTdKmdMfD4BddMJs4iwvHWRSv4PV7Dh2vxjM57UJ3pw5UJDQ@mail.gmail.com> <87r1k0ck7o.ffs@nanos.tec.linutronix.de> <CAJvTdKkOED6p0ox83A0qcspi5UZ-UbZAkJeyOJ6AChb-qnZGwQ@mail.gmail.com>
Date:   Mon, 29 Mar 2021 16:10:52 +0200
Message-ID: <87r1jy6oer.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2021 at 09:31, Len Brown wrote:
> On Sat, Mar 27, 2021 at 6:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> What's the actual downside of issuing TILERELEASE conditionally
>> depending on prev->AMX INIT=0? Is it slooooow or what's the real
>> problem here?
>
> TILERELEASE is fast, so there should be no down-side to execute it.
> Indeed, checking whether you need to execute it or not will probably take
> longer than executing TILERELEASE.  My point (perhaps academic)
> is that Linux should not have to know about TILERELEASE, or execute it.
>
> Re: running in the kernel with AMX INIT=0
>
> AMX INIT=0 will prevent c6 on that core.  I don't expect to see this
> in the syscall path, though if a user wanted to neglect to issue TILERELEASE,
> there is nothing forcing them to do so.
>
> It can certainly happen on the interrupt path, but on the interrupt patch
> I don't know if we can end up requesting c6 -- perhaps on a forced
> task migration?

I think I clearly described how it can end up in that situation and that
there are a gazillion ways to get there.

If I decide at 5PM to call it a day after hitting the breakpoint, then I
really would appreciate that the machine goes deep idle instead of
staying at C1(E) until 9AM when I come back.

> Re:  frequency credits in the kernel with AMX INIT=0.
>
> It works exactly the same way as AMX INIT=1.
> That is to say, the frequency credits don't key off of AMX INIT,
> they key off of the actual use of the AMX execution unit, and
> the credits free up several orders of magnitude faster
> (both for AVX-512 and AMX) on this hardware as in previous generations.
>
> As a result, if we interrupt an AMX program, and run for an extended
> period of time in the kernel without XRESTOR to clear out his AMX INIT=0 state,
> that will not have any impact on the frequency we run inside the kernel any more
> than if he had AMX INIT=1 state.

Ok. That's clearly missing in documentation, but it does not solve the C
state issue at all.

Thanks,

        tglx
