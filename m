Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711FE3A4965
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhFKTUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhFKTUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:20:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A357C613D0;
        Fri, 11 Jun 2021 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623439123;
        bh=FWRWB7qMYIMgll5fN+YqcHRkP32arVMnB3TPp5iiNMI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=kI4zCInuDiql8WGndKv3dTTItWJU3YxvUpC5/GzSiOSSI3nyn7YSYoL7t5miq6y/B
         LhhQ2VN5RVRgpdr9B+wIWwKy0oyWzMVVLLN//2NSd3TyHR5B/srfjbNYIBwYVkb1uH
         t+1vWM5iAT4R5TKJ7znHYu6FiLFw4XSnimb/GG3f6gO1GDlUmgZmLVrFpPBEvYy8EQ
         ynoMr84fX5kJpJasiGnOEzEVihao0bCQ4I0+AnOZcDmgaeDSiS3Xkt1YVJM66EB0mK
         6rFPZraLhrFasQJCvb70c2RLpomOrWE65LdnDIsb+7sraf42TOVwkR6fpoWMkyzNWm
         NYnEb81TxmloQ==
Subject: Re: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy
 components
From:   Andy Lutomirski <luto@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.820639606@linutronix.de>
 <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org>
Message-ID: <b81a0fe0-1aca-c0de-eb9e-895ac98c0c86@kernel.org>
Date:   Fri, 11 Jun 2021 12:18:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 12:03 PM, Andy Lutomirski wrote:
> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>> xstateregs_get() does not longer use fpstate_sanitize_xstate() and the only
> 
> s/does not longer use/no longer uses/
> 
> 		\
>> --- a/arch/x86/kernel/fpu/regset.c
>> +++ b/arch/x86/kernel/fpu/regset.c
>> @@ -11,6 +11,39 @@
>>  
>>  #include <linux/sched/task_stack.h>
>>  
>> +/*
>> + * When executing XSAVEOPT (or other optimized XSAVE instructions), if
> 
> The kernel doesn't use XSAVEOPT any more.  How about:
> 
> When executing XSAVES (or other optimized XSAVE instructions)
> 
>> + * a processor implementation detects that an FPU state component is still
>> + * (or is again) in its initialized state, it may clear the corresponding
>> + * bit in the header.xfeatures field, and can skip the writeout of registers
>> + * to the corresponding memory layout.
> 
> Additionally, copy_xxx_to_xstate() may result in an xsave buffer with a
> bit clear in xfeatures but the corresponding state region not containing
> the state's init value.
> 
>> + *
>> + * This means that when the bit is zero, the state component might still
>> + * contain some previous - non-initialized register state.
> 
> Maybe say what the function does, e.g.:
> 
> This function fills in the init values for the X87 and SSE states if the
> corresponding xfeatures bits are clear.
> 
>> + *
>> + * This is required for the legacy regset functions.
>> + */
>> +static void fpstate_sanitize_legacy(struct fpu *fpu)
>> +{
>> +	struct fxregs_state *fx = &fpu->state.fxsave;
>> +	u64 xfeatures;
>> +
>> +	if (!use_xsaveopt())
>> +		return;
> 
> This is confusing, since we never use xsaveopt.  It's also wrong -- see
> above.  How about just removing it?
> 
>> +
>> +	xfeatures = fpu->state.xsave.header.xfeatures;
>> +
>> +	/* If FP is in init state, reinitialize it */
>> +	if (!(xfeatures & XFEATURE_MASK_FP)) {
>> +		memset(fx, 0, sizeof(*fx));
>> +		fx->cwd = 0x37f;
>> +	}
>> +
>> +	/* If SSE is in init state, clear the storage */
>> +	if (!(xfeatures & XFEATURE_MASK_SSE))
>> +		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
>> +}
>> +
>>  
> 
> Does this result in the mxcsr_mask and mxcsr fields being correct?
> There is a silly number of special cases there.
> 

The SDM says, in a footnote in XRSTOR:

There is an exception if RFBM[1] = 0 and RFBM[2] = 1. In this case, the
standard form of XRSTOR will load MXCSR from memory, even though MXCSR
is part of state component 1 — SSE. The compacted form of XRSTOR does
not make this exception.

which makes me think that this code has a bug.  Also, the code is
manifest nonsense for a different reason:

if (!FP)
  memset(the whole damn thing, 0);

if (!SSE)
  memset(just part of it, 0);

which means that, if the FP bit is clear but the SSE bit is set, this
thing will clobber the SSE state.

This code is garbage.  So is the architecture that gave rise to this code.

--Andy
