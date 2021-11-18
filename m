Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304D7456174
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhKRRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:30:19 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46948 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbhKRRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:30:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UxDyzGG_1637256434;
Received: from 30.30.94.206(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UxDyzGG_1637256434)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Nov 2021 01:27:16 +0800
Message-ID: <dc3abbdc-fcae-171f-7283-46977af086de@linux.alibaba.com>
Date:   Fri, 19 Nov 2021 01:27:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V5 01/50] x86/entry: Add fence for kernel entry swapgs in
 paranoid_entry()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
 <20211110115736.3776-2-jiangshanlai@gmail.com>
 <YZZ3OUaMjMIhvj70@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <YZZ3OUaMjMIhvj70@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/18 23:54, Peter Zijlstra wrote:

> 
> I'm confused, shouldn't the LFENCE be between SWAPGS and future uses of
> GS prefix?

I'm wrong a again.

I once thought "it should be followed with serializing operations such
as SWITCH_TO_KERNEL_CR3", and tglx corrected me:

https://lore.kernel.org/lkml/875yumbgox.ffs@tglx/

 > It does not matter whether the *serializing* is before or after

And in my brain, it was incorrectly stored as:
    It does not matter whether the *fence* is before or after.

I will update patch1 and the corresponding C code in later patches.

Patch 1 in V4 is correct, but not as good as Borislav Petkov pointed out
that it has duplicated FENCE_SWAPGS_KERNEL_ENTRY.

I will change it as

	rdmsr
	if (need_swapgs) {
		swapgs
		set ebx/return value
	}
	FENCE_SWAPGS_KERNEL_ENTRY

> 
> In the old code, before 96b2371413e8f, we had:
> 
> 	swapgs
> 	SAVE_AND_SWITCH_TO_KERNEL_CR3
> 	FENCE_SWAPGS_KERNEL_ENTRY
> 
> 	// %gs user comes here..
> 
> And the comment made sense, since if SAVE_AND_SWITCH_TO_KERNEL_CR3 would
> imply an unconditional CR3 write, the LFENCE would not be needed.
> 
> Then along gomes 96b2371413e8f and changes the order to:
> 
> 	SAVE_AND_SWITCH_TO_KERNEL_CR3
> 	swapgs
> 	FENCE_SWAPGS_KERNEL_ENTRY
> 	// %gs user comes here..
> 
> But now the comment is crazy talk, because even if the CR3 write were
> unconditional, it'd be pointless, since it's not after SWAPGS, but we
> still have the LFENCE in the right place.

I think the comments also make sense.

If CR3 write were unconditional before swapgs, no fence is needed after
swapgs since cr3 write is serializing.

> 
> But now you want to make it:
> 
> 	SAVE_AND_SWITCH_TO_KERNEL_CR3
> 	FENCE_SWAPGS_KERNEL_ENTRY
> 	swapgs
> 	// %gs user comes here..
> 
> And there's nothing left and speculation can use the old %gs for our
> user and things go sideways. Hmm?
> 
> 
> (on a completely unrelated note, I find KERNEL_ENTRY and USER_ENTRY
> utterly confusing)
> 
