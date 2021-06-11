Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E93A391C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFKBGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFKBG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:06:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF5F7611AE;
        Fri, 11 Jun 2021 01:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623373472;
        bh=gvXZrOaoBVCb3A6htviFepycoH2/6DLnx96h66dUUhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DvjXuP2mzi4GEV751dGARU1SUGuQ32pCU6gmYl5lZQj0N7yahe6flqYpZoXChqg3x
         W+rtfgRvVIgpsdQTbSAQXumCCbL+PXMcpAKVgURbbpPZhz0uLtWPkhREkuWW5SHKGY
         9wssS5Hhan5MU62rudxZ/EmWd4BLz82QQitCNOaGgnK5YtsFdfm3oou91kd/zOugL7
         q7G+0XPovMy/mzTUmraYJwb5LwEgg/6vIFBKZSyBvu0MIiP0nqlRdFJTEJKRjQLDSO
         er+eElVcoU562fojQbLEOQAxcmqkXkLf2RHL8JnLiU44+9FXSU+yHOuDXKeNYRQRU2
         WCQiP/EUtarZQ==
Subject: Re: [patch V3 3/6] x86/process: Check PF_KTHREAD and not current->mm
 for kernel threads
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@suse.de>
References: <20210608143617.565868844@linutronix.de>
 <20210608144345.912645927@linutronix.de>
 <ca2d7f44-bbef-448a-bbd4-ff27cc6f0c9e@www.fastmail.com>
 <87fsxpxwxr.ffs@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <40f51c91-23a0-2393-285f-c84a3a2e09ae@kernel.org>
Date:   Thu, 10 Jun 2021 18:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87fsxpxwxr.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 1:54 PM, Thomas Gleixner wrote:
> On Thu, Jun 10 2021 at 10:10, Andy Lutomirski wrote:
> 
>> On Tue, Jun 8, 2021, at 7:36 AM, Thomas Gleixner wrote:
>>> switch_fpu_finish() checks current->mm as indicator for kernel threads.
>>> That's wrong because kernel threads can temporarily use a mm of a user
>>> process via kthread_use_mm().
>>>
>>> Check the task flags for PF_KTHREAD instead.
>>>
>>> Fixes: 0cecca9d03c9 ("x86/fpu: Eager switch PKRU state")
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Rik van Riel <riel@surriel.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>  arch/x86/include/asm/fpu/internal.h |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- a/arch/x86/include/asm/fpu/internal.h
>>> +++ b/arch/x86/include/asm/fpu/internal.h
>>> @@ -578,7 +578,7 @@ static inline void switch_fpu_finish(str
>>>  	 * PKRU state is switched eagerly because it needs to be valid before we
>>>  	 * return to userland e.g. for a copy_to_user() operation.
>>>  	 */
>>> -	if (current->mm) {
>>> +	if (!(current->flags & PF_KTHREAD)) {
>>>  		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>>>  		if (pk)
>>>  			pkru_val = pk->pkru;
>>>
>>>
>> Why are we checking this at all?  I actually tend to agree with the
>> ->mm check more than PF_anything. If we have a user address space,
>> then PKRU matters. If we don’t, then it doesn’t.
> 
> Which PKRU matters? A kernel thread has always the default PKRU no
> matter whether it uses a mm or not. It _cannot_ borrow the PKRU from the
> mm owning process. There is no way, so let's not pretend there would be.
> 

Hmm.  I guess PK_KTHREAD is consistent with switch_fpu_prepare() --
kernel threads have no FPU state.

It might be worth a loud comment here that kernel threads' PKRU is not
context switched and that, if anyone wants kthread_use_mm() users to use
anything other than the default PKRU, that they will need to change this.

So I guess your patch is okay.

--Andy
