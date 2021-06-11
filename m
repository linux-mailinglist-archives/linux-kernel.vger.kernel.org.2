Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2740C3A4A16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFKUZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:25:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:23:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623443011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtvwTASLd2sYTiNn7E8oMpSLjEuI7WShdgTEl+U1VRI=;
        b=Ov2mzryPknWqfkOsiiQcDWm5VYiZnWcVp7/HqznqxZ/rJ5/EOrhCyn8/QlTjcuewOFNbyZ
        b69kyATTjC5PSa23PxU075z7g0wM2phnC5Zs+mr3NL8Vyh06SjOIpDQNhJq8HInq4UD5iq
        FOV56v1pp6us7DenPbSMCMUttCTa83763EE55Lo5CL7QuarDn6Ox3DvDX3belXx01pV0LC
        Lvx67Uf1ME3Tdc0/mMDy9GpEevC2Arrmc+oGAA+hOiLUKNvKTYTdxFbWS4clAS0+/cNsBP
        F4GJEjj9NLUh8Xxv3w+96fQYUU/ISIkcDZWct4fHgTV3UEF0Z59OWYsBMxL9NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623443011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtvwTASLd2sYTiNn7E8oMpSLjEuI7WShdgTEl+U1VRI=;
        b=YlYdDGu9L3D7w+2ZUhpVPgibtIn41lIbSOSDBWcOo/94UI1CoNwVyIDU52F2BbiAiVhtlc
        kmXQDGBH8R9WIfBQ==
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 06/41] x86/fpu: Sanitize xstateregs_set()
In-Reply-To: <ae886c48-3c6c-a646-a140-ee26c57abf93@kernel.org>
References: <20210611161523.508908024@linutronix.de> <20210611163111.614604526@linutronix.de> <ae886c48-3c6c-a646-a140-ee26c57abf93@kernel.org>
Date:   Fri, 11 Jun 2021 22:23:31 +0200
Message-ID: <87k0n0w3p8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 11:45, Andy Lutomirski wrote:
> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>> xstateregs_set() operates on a stopped task and tries to copy the provided
>> buffer into the tasks fpu.state.xsave buffer.
>> 
>> Any error while copying or invalid state detected after copying results in
>> wiping the target tasks FPU state completely including supervisor states.
>> 
>> That's just wrong. The caller supplied invalid data or has a problem with
>> unmapped memory, so there is absolutely no justification to corrupt the
>> target state.
>> 
>> @@ -1146,14 +1146,16 @@ int copy_kernel_to_xstate(struct xregs_s
>>  	 */
>>  	xsave->header.xfeatures |= hdr.xfeatures;
>>  
>> +	/* mxcsr reserved bits must be masked to zero for security reasons. */
>> +	xsave->i387.mxcsr &= mxcsr_feature_mask;
>
> This comment is vague.  At least it should say:
>
> A subsequent XRSTOR(S) will fail if MXCSR has bits set that are not
> accepted by the current CPU.  Mask out unsupported bits.
>
> But a much nicer fix IMO would be to just return an error.

That was the "fix" for CVE-2003-0248, but I forgot the details of this
issue and why the masking was done instead of returning an error. The
problem was not that it caused a #GP, there was some other implication
which I can't remember.

The reason why this masking was done was that the SDM was pretty vague
about the reserved bits and only newer processor generations had an
issue while older ones just ignored them and of course some existing
user space was sloppy and got away with random values in reserved bits
up to the point where newer CPUs got more sensitive about this.

Yes, the comment could get some love and we probably can just error out
today. Those ancient binaries should be in the bit bucket by now.

Thanks,

        tglx


