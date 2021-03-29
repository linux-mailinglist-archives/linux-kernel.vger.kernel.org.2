Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FE834D133
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhC2Ndp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhC2NdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:33:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:33:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617024802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIiWgfdJvybstntfwtce0IOwXUzjwiWcYYh5faGlboY=;
        b=jjOVBZB88+VRqj7o3KFc8rbuL/R7GsjyY50HZh9pAIoGtQ0AeHYd61872CUy9VwkDtwEFf
        U+mcojvGcvYzCjSIzwd0fnH89E1nVZ+PORrokbQLIva0TkoM5vss3ERrZQwtRNwb1Js7ce
        DgmM4GFoiy81Po9MCPrBJmkmAaaPJFfhMwyvMXvpgey6hE6XohM9Xm/07oPw+BrFyunJTc
        CfCf5S6gmVxF2kTyvUXjTeKmE6I+5DcByhPav4mozoDGPN7IqVK9MWh+stUV0aazJCzPoC
        hGux7gCfVM/Qu0jl4ApuJa8z/oSQP2Vv5/dwiXMsgs1dcJ/X4ErpJ1wROk9Ygg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617024802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIiWgfdJvybstntfwtce0IOwXUzjwiWcYYh5faGlboY=;
        b=hqmp8Ji/iqyUpapP3Exv4J84Q8v3Rzu5Wh+4FAg85Hs5UgYTkgHkahgvSVy9GYeXOLSjmN
        43UMwiwBvq9XiuDA==
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
In-Reply-To: <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de> <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com>
Date:   Mon, 29 Mar 2021 15:33:21 +0200
Message-ID: <87r1jyaxum.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29 2021 at 09:14, Len Brown wrote:
> On Sat, Mar 20, 2021 at 6:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
>> > +
>> > +/* Update MSR IA32_XFD with xfirstuse_not_detected() if needed. */
>> > +static inline void xdisable_switch(struct fpu *prev, struct fpu *next)
>> > +{
>> > +     if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
>> > +             return;
>> > +
>> > +     if (unlikely(prev->state_mask != next->state_mask))
>> > +             xdisable_setbits(xfirstuse_not_detected(next));
>> > +}
>>
>> So this is invoked on context switch. Toggling bit 18 of MSR_IA32_XFD
>> when it does not match. The spec document says:
>>
>>   "System software may disable use of Intel AMX by clearing XCR0[18:17], by
>>    clearing CR4.OSXSAVE, or by setting IA32_XFD[18]. It is recommended that
>>    system software initialize AMX state (e.g., by executing TILERELEASE)
>>    before doing so. This is because maintaining AMX state in a
>>    non-initialized state may have negative power and performance
>>    implications."
>>
>> I'm not seeing anything related to this. Is this a recommendation
>> which can be ignored or is that going to be duct taped into the code
>> base once the first user complains about slowdowns of their non AMX
>> workloads on that machine?
>
> I found the author of this passage, and he agreed to revise it to say this
> was targeted primarily at VMMs.

Why would this only a problem for VMMs?

> "negative power and performance implications" refers to the fact that
> the processor will not enter C6 when AMX INIT=0, instead it will demote
> to the next shallower C-state, eg C1E.
>
> (this is because the C6 flow doesn't save the AMX registers)
>
> For customers that have C6 enabled, the inability of a core to enter C6
> may impact the maximum turbo frequency of other cores.

That's the same on bare metal, right?

Thanks,

        tglx
